Received: from eggs.gnu.org ([2001:4830:134:3::10]:60660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Nx-0004tG-AO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc8Ns-0004ha-QZ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:57:17 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:24 +0300
Message-Id: <7a0b7eba4b577bceb8aa795ae46d9812e2d6f4ca.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/25] build-sys: there is no qemu-ga.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

It got moved in qga/main.c from commit 2870dc3456c9c.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
