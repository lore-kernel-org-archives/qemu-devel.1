Received: from eggs.gnu.org ([2001:4830:134:3::10]:42505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9LyE-00017j-LQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9LyB-0004ef-In
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:40:18 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9LyB-0004eP-DC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:40:15 -0400
Received: by mail-qk0-x243.google.com with SMTP id d206so7535700qkb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:40:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 23:40:04 -0300
Message-Id: <20180420024005.30245-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: Rename the amd64 image as amd64-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Like the other images, this one is also used to cross-compile.
Name it accordingly, matching directory pattern.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/Makefile.include                                   | 2 +-
 .../{debian-amd64.docker => debian-amd64-cross.docker}          | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/docker/dockerfiles/{debian-amd64.docker => debian-amd64-cross.docker} (100%)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index de87341528..a113a15f77 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -49,7 +49,7 @@ docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerf
 # Enforce dependancies for composite images
 docker-image-debian: docker-image-debian9
 docker-image-debian8-mxe: docker-image-debian8
-docker-image-debian-amd64: docker-image-debian9
+docker-image-debian-amd64-cross: docker-image-debian9
 docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian-amd64.docker
rename to tests/docker/dockerfiles/debian-amd64-cross.docker
-- 
2.17.0
