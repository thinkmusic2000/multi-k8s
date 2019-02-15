docker build -t mikemad/multi-client:latest -t mikemad/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t mikemad/multi-server:latest -t mikemad/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t mikemad/multi-worker:latest -t mikemad/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push mikemad/multi-client:latest
docker push mikemad/multi-server:latest
docker push mikemad/multi-worker:latest
docker push mikemad/multi-client:$GIT_SHA
docker push mikemad/multi-server:$GIT_SHA
docker push mikemad/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mikemad/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=mikemad/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=mikemad/multi-worker:$GIT_SHA
