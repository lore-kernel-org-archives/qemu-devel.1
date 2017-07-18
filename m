Received: from eggs.gnu.org ([2001:4830:134:3::10]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0P-0007Z8-L5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0J-00039I-CG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:29 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0J-000382-2p
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:23 -0400
Received: by mail-wr0-x230.google.com with SMTP id 12so23212149wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:46 +0100
Message-Id: <20170718104513.23947-6-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/32] docker: rename debian stable -> 9
 (Stretch)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We'll also want to support some older Debian combinations for
architectures that didn't make the Debian 9 cut.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: extend commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 012a2fc1af..72bb52ad7b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -56,9 +56,9 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		"BUILD","$*")
 
 # Enforce dependancies for composite images
-docker-image-debian-armhf-cross: docker-image-debian
-docker-image-debian-arm64-cross: docker-image-debian
-docker-image-debian-mipsel-cross: docker-image-debian
+docker-image-debian-armhf-cross: docker-image-debian9
+docker-image-debian-arm64-cross: docker-image-debian9
+docker-image-debian-mipsel-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 45b891d57a..f1bfa64160 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker arm64 cross-compiler target
 #
-# This docker target builds on the base debian image.
+# This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian
+FROM qemu:debian9
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index e67dfdccc5..2beacef49b 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker armhf cross-compiler target
 #
-# This docker target builds on the base debian image.
+# This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian
+FROM qemu:debian9
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armhf
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 2156bdb28d..9ee997aa54 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -1,9 +1,9 @@
 #
 # Docker mipsel cross-compiler target
 #
-# This docker target builds on the base debian image.
+# This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian
+FROM qemu:debian9
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 # Add the foreign architecture we want and install dependencies
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian9.docker
similarity index 62%
rename from tests/docker/dockerfiles/debian.docker
rename to tests/docker/dockerfiles/debian9.docker
index 10953b2425..c74f71283c 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -1,13 +1,13 @@
 #
 # Docker multiarch cross-compiler target
 #
-# This docker target is builds on Debian and Emdebian's cross compiler targets
-# to build distro with a selection of cross compilers for building test binaries.
+# This docker target is builds on Debian cross compiler targets to build distro
+# with a selection of cross compilers for building test binaries.
 #
 # On its own you can't build much but the docker-foo-cross targets
 # build on top of the base debian image.
 #
-FROM debian:stable-slim
+FROM debian:stretch-slim
 
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
@@ -17,4 +17,9 @@ RUN apt update
 RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
-    ca-certificates build-essential clang git bison flex
+        bison \
+        build-essential \
+        ca-certificates \
+        clang \
+        flex \
+        git
-- 
2.13.0
