Received: from eggs.gnu.org ([2001:4830:134:3::10]:34946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXv-0002wm-Oh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXr-0008B3-S3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:35 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXr-0008A8-O5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:31 -0400
Received: by mail-qk0-x244.google.com with SMTP id d136so970475qkg.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:47:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 23:47:12 -0300
Message-Id: <20170718024713.27557-5-f4bug@amsat.org>
In-Reply-To: <20170718024713.27557-1-f4bug@amsat.org>
References: <20170718024713.27557-1-f4bug@amsat.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2.5 4/5] docker: warn users to use newer
 debian8/debian9 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

to stay backward incompatible.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include          |  1 +
 tests/docker/dockerfiles/debian.docker | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian.docker

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
2.13.2
