# Use Node.js to build the React app
FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Use Nginx to serve the build
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Introduce an intentional failure
RUN invalid_command_that_does_not_exist

EXPOSE 4000
CMD ["nginx", "-g", "daemon off;"]
