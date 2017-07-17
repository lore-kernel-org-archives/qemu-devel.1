Received: from eggs.gnu.org ([2001:4830:134:3::10]:36944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Kd-00063s-LL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Kc-0002E2-QA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:07 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7Kc-0002DS-JO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:06 -0400
Received: by mail-wm0-x230.google.com with SMTP id b134so50667493wma.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:49:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:36 +0100
Message-Id: <20170717144848.11793-12-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 11/23] docker: add debian/amd64 based on
 Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

By itself this doesn't add much to our coverage. However later patches
will extend this image to include more bleeding edge libraries which
are not yet widely available in distros.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: extend commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                |  1 +
 tests/docker/dockerfiles/debian-amd64.docker | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-amd64.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 553465ef6d..8d45551476 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -62,6 +62,7 @@ docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
+docker-image-debian-amd64: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
new file mode 100644
index 0000000000..2ab76120a4
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -0,0 +1,18 @@
+#
+# Docker x86_64 target
+#
+# This docker target builds on the debian Stretch base image.
+#
+FROM qemu:debian9
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy qemu
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libbz2-dev \
+        liblzo2-dev \
+        librdmacm-dev \
+        libsnappy-dev \
+        libvte-dev
-- 
2.13.0
