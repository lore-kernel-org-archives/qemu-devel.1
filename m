Received: from eggs.gnu.org ([2001:4830:134:3::10]:53070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97O-0001v1-Oc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97L-00074t-KU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:22 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:35885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb97L-00073O-Ey
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:19 -0500
Received: from player687.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 06A6797CF4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:04:18 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 19:04:01 +0100
Message-Id: <20180115180406.28489-2-clg@kaod.org>
In-Reply-To: <20180115180406.28489-1-clg@kaod.org>
References: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] ppc/pnv: use POWER9 DD2 processor
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

commit 1ed9c8af501f ("target/ppc: Add POWER9 DD2.0 model information")
deprecated the POWER9 model v1.0.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c           | 2 +-
 tests/pnv-xscom-test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9475e8479c37..536162b2747c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -759,7 +759,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
     k->chip_type =3D PNV_CHIP_POWER9;
-    k->chip_cfam_id =3D 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
+    k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask =3D POWER9_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p9;
     k->xscom_base =3D 0x00603fc00000000ull;
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 89fa6282d3af..a1a119c0912c 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -48,7 +48,7 @@ static const PnvChip pnv_chips[] =3D {
         .cpu_model  =3D "POWER9",
         .xscom_base =3D 0x000603fc00000000ull,
         .xscom_core_base =3D 0x0ull,
-        .cfam_id    =3D 0x100d104980000000ull,
+        .cfam_id    =3D 0x220d104900008000ull,
         .first_core =3D 0x20,
     },
 #endif
--=20
2.13.6
