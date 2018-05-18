Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJbXA-0006qE-Da
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJbX9-00040q-HN
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fJbX9-00040b-CN
	for qemu-devel@nongnu.org; Fri, 18 May 2018 05:18:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 May 2018 17:18:27 +0800
Message-Id: <20180518091828.12814-2-famz@redhat.com>
In-Reply-To: <20180518091828.12814-1-famz@redhat.com>
References: <20180518091828.12814-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] docker: Fix trivial typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180508144358.13530-1-f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index de87341528..ef1a3e62eb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -46,7 +46,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
=20
 docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(SRC_PATH)/tests/dock=
er/dockerfiles/debian-apt-fake.sh
=20
-# Enforce dependancies for composite images
+# Enforce dependencies for composite images
 docker-image-debian: docker-image-debian9
 docker-image-debian8-mxe: docker-image-debian8
 docker-image-debian-amd64: docker-image-debian9
--=20
2.14.3
