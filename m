Received: from eggs.gnu.org ([2001:4830:134:3::10]:36788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akL-0003W0-Ly
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akK-0007py-Rw
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:09 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7akK-0007pu-NQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:08 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so8240234qtb.2
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:58:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:56:58 -0300
Message-Id: <20170508045715.21770-7-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/23] docker: compact debian arm64
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
 tests/docker/dockerfiles/debian-arm64-cross.docker | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 592b5d7055..12b30aae54 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -6,10 +6,12 @@
 FROM qemu:debian
 
 # Add the foreign architecture we want and install dependencies
-RUN dpkg --add-architecture arm64
-RUN apt update
-RUN apt install -yy crossbuild-essential-arm64
-RUN apt-get build-dep -yy -a arm64 qemu
+RUN dpkg --add-architecture arm64 && \
+    apt-get update && \
+    DEBIAN_FRONTEND=noninteractive eatmydata apt-get install -y --no-install-recommends \
+        crossbuild-essential-arm64
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata apt-get build-dep -yy -a arm64 qemu
-- 
2.11.0
