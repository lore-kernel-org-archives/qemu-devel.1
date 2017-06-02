Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl2-00027M-7a
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl0-0006K4-CJ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:12 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl0-0006Jh-7e
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:10 -0400
Received: by mail-oi0-x242.google.com with SMTP id w138so13111034oiw.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:15 -0300
Message-Id: <20170602185630.5059-10-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/24] docker: use eatmydata in debian armhf
 image
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-armhf-cross.docker | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 668d60aeb3..ba8d5a5167 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -8,8 +8,11 @@ FROM qemu:debian
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armhf
 RUN apt update
-RUN apt install -yy crossbuild-essential-armhf
-RUN apt-get build-dep -yy -a armhf qemu
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        crossbuild-essential-armhf
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get build-dep -yy -a armhf qemu
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
-- 
2.11.0
