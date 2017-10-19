Received: from eggs.gnu.org ([2001:4830:134:3::10]:41306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e59CH-0003f5-RZ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e59CD-0001PK-Hm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:41:09 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e59CD-0001Is-Bu
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:41:05 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 79445145110
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 13:40:53 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 19 Oct 2017 13:40:42 +0200
Message-ID: <150841324224.31292.4012464539983692364.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] docker: fix out-of-tree 'make
 docker-test-build@debian-powerpc-cross'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Without this patch, it fails with:

IOError: [Errno 2] No such file or directory:
 'tests/docker/dockerfiles/debian-apt-fake.sh'

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/docker/Makefile.include |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 6f9ea196a7b8..5d54eca5d0b3 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -44,7 +44,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
-docker-image-debian-powerpc-cross: EXTRA_FILES:=tests/docker/dockerfiles/debian-apt-fake.sh
+docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
 
 # Enforce dependancies for composite images
 docker-image-debian: docker-image-debian9
