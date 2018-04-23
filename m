Received: from eggs.gnu.org ([2001:4830:134:3::10]:59666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAclr-0004It-Bw
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAclo-0004Hb-7m
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:48:47 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fAclo-0004HK-2z
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:48:44 -0400
Received: by mail-qt0-x241.google.com with SMTP id s2-v6so17951932qti.2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 07:48:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 23 Apr 2018 11:48:37 -0300
Message-Id: <20180423144837.16710-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: add debian/alpha image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This image is not enough to cross-build QEMU,
but it is useful enough to cross-compile TCG tests.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-alpha-cross.docker | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker

diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
new file mode 100644
index 0000000000..dce1d2e719
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
@@ -0,0 +1,13 @@
+#
+# Docker alpha cross-compiler target
+#
+# This docker target builds on the debian Stretch base image.
+#
+FROM qemu:debian9
+
+# Add the foreign architecture we want and install dependencies
+RUN dpkg --add-architecture alpha
+RUN apt update
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        gcc-alpha-linux-gnu
-- 
2.17.0
