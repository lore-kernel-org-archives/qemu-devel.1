Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUla2-0001bk-1A
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZx-0004UM-AX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:18 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZx-0004UI-5U
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:11:13 -0400
Received: by mail-qt0-f195.google.com with SMTP id w12so15131685qta.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:11:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:43 -0300
Message-Id: <20170711031000.24844-2-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 01/18] docker: rename debian stable -> 9
 (Stretch)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                              |  6 +++---
 tests/docker/dockerfiles/debian-arm64-cross.docker         |  4 ++--
 tests/docker/dockerfiles/debian-armhf-cross.docker         |  4 ++--
 tests/docker/dockerfiles/debian-mipsel-cross.docker        |  4 ++--
 tests/docker/dockerfiles/{debian.docker => debian9.docker} | 13 +++++++++----
 5 files changed, 18 insertions(+), 13 deletions(-)
 rename tests/docker/dockerfiles/{debian.docker => debian9.docker} (62%)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 037cb9e9e7..01d7af9698 100644
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
2.13.2
