Received: from eggs.gnu.org ([2001:4830:134:3::10]:53791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZL-00013U-7V
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZG-0004AL-A0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:35 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZG-0004AE-5g
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:30 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so15132145qta.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:10:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:49 -0300
Message-Id: <20170711031000.24844-8-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 07/18] docker: add debian/amd64
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
 tests/docker/Makefile.include                      |  1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-amd64-cross.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 59b08b4aca..d2a81b0d71 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -62,6 +62,7 @@ docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
+docker-image-debian-amd64-cross: docker-image-debian9
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
new file mode 100644
index 0000000000..9d10a886df
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -0,0 +1,18 @@
+#
+# Docker x86_64 cross-compiler target
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
2.13.2
