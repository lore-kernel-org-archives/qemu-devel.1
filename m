Received: from eggs.gnu.org ([2001:4830:134:3::10]:53108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97Q-0001wl-JL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97P-00078v-Lu
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:24 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb97P-00077j-G1
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:23 -0500
Received: from player687.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 438D39FE70
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:04:22 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 19:04:02 +0100
Message-Id: <20180115180406.28489-3-clg@kaod.org>
In-Reply-To: <20180115180406.28489-1-clg@kaod.org>
References: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/6] ppc/pnv: change core mask for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When addressed by XSCOM, the first core has the 0x20 chiplet ID but
the CPU PIR can start at 0x0.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c           | 4 ++--
 tests/pnv-xscom-test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 536162b2747c..f9591cd41d36 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -707,9 +707,9 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, u=
int32_t core_id)
 #define POWER8_CORE_MASK   (0x7e7eull)
=20
 /*
- * POWER9 has 24 cores, ids starting at 0x20
+ * POWER9 has 24 cores, ids starting at 0x0
  */
-#define POWER9_CORE_MASK   (0xffffff00000000ull)
+#define POWER9_CORE_MASK   (0xffffffffffffffull)
=20
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
 {
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index a1a119c0912c..9d545c471813 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -49,7 +49,7 @@ static const PnvChip pnv_chips[] =3D {
         .xscom_base =3D 0x000603fc00000000ull,
         .xscom_core_base =3D 0x0ull,
         .cfam_id    =3D 0x220d104900008000ull,
-        .first_core =3D 0x20,
+        .first_core =3D 0x0,
     },
 #endif
 };
--=20
2.13.6
