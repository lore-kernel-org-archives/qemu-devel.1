Received: from eggs.gnu.org ([2001:4830:134:3::10]:54207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eD9aM-00022f-57
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eD9aI-0006KJ-A5
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:43:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eD9aI-0006I8-2v
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:43:02 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 10 Nov 2017 21:42:54 +0800
Message-Id: <20171110134254.25031-3-famz@redhat.com>
In-Reply-To: <20171110134254.25031-1-famz@redhat.com>
References: <20171110134254.25031-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] docker: correctly escape $BACKEND in the
 help output
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

In Makefiles the $ must be escaped as $$ in shell uses.

Since 8a2390a4f47:

 $ make docker
     [...]
     NETWORK=3D1            Enable virtual network interface with default=
 backend.
     NETWORK=3DACKEND     Enable virtual network interface with ACKEND.

Once escaped:

 $ make docker
     [...]
     NETWORK=3D1            Enable virtual network interface with default=
 backend.
     NETWORK=3D$BACKEND     Enable virtual network interface with $BACKEN=
D.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-Id: <20171108024719.8389-1-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index f1a398e9fa..de87341528 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -109,7 +109,7 @@ docker:
 	@echo '    DEBUG=3D1              Stop and drop to shell in the created=
 container'
 	@echo '                         before running the command.'
 	@echo '    NETWORK=3D1            Enable virtual network interface with=
 default backend.'
-	@echo '    NETWORK=3D$BACKEND     Enable virtual network interface with=
 $BACKEND.'
+	@echo '    NETWORK=3D$$BACKEND     Enable virtual network interface wit=
h $$BACKEND.'
 	@echo '    NOUSER               Define to disable adding current user t=
o containers passwd.'
 	@echo '    NOCACHE=3D1            Ignore cache when build images.'
 	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
--=20
2.13.6
