Received: from eggs.gnu.org ([2001:4830:134:3::10]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7I-0005Ei-7L
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7H-0006Rl-DV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:36 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ7H-0006RL-6M
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:35 -0400
Received: by mail-wr0-x22a.google.com with SMTP id w4so23081783wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:12 +0100
Message-Id: <20170718104513.23947-32-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/32] docker: warn users to use newer
 debian8/debian9 base image
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

to stay backward incompatible.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e993e149e7..aaab1a4208 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -58,6 +58,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 docker-image-debian-powerpc-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
 
 # Enforce dependancies for composite images
+docker-image-debian: docker-image-debian9
 docker-image-debian8-mxe: docker-image-debian8
 docker-image-debian-amd64: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
new file mode 100644
index 0000000000..fd32e71b79
--- /dev/null
+++ b/tests/docker/dockerfiles/debian.docker
@@ -0,0 +1,13 @@
+# This template is deprecated and was previously based on Jessie on QEMU 2.9.
+# Now than Stretch is out, please use qemu:debian8 as base for Jessie,
+# and qemu:debian9 for Stretch.
+#
+FROM qemu:debian9
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+RUN for n in $(seq 8); do echo; done && \
+    echo "\n\t\tThis image is deprecated." && echo && \
+    echo "\tUse 'FROM qemu:debian9' to use the stable Debian Stretch image" && \
+    echo "\tor 'FROM qemu:debian8' to use old Debian Jessie." && \
+    for n in $(seq 8); do echo; done
-- 
2.13.0
