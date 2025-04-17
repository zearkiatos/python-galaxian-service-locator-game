
FROM python:3.11-slim AS builder

RUN apt-get update && \
apt-get install -y ffmpeg

RUN pip install --no-cache-dir pygbag

WORKDIR /app

COPY . .

CMD ["pygbag", "main.py"]

FROM nginx:alpine

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]