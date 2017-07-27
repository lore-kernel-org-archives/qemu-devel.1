Received: from eggs.gnu.org ([2001:4830:134:3::10]:32841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4x-0000cq-Js
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal4u-0007LO-9K
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:51:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:45:05 +0200
Message-Id: <20170727154505.14838-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] build-sys: there is no qemu-ga.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It got moved in qga/main.c from commit 2870dc3456c9c.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ef721480eb..97a58a0f4e 100644
--- a/Makefile
+++ b/Makefile
@@ -443,7 +443,7 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.p=
y $(qapi-py)
 		"GEN","$@")
=20
 QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
-$(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
+$(qga-obj-y): $(QGALIB_GEN)
=20
 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
--=20
2.14.0.rc0.1.g40ca67566
