Received: from eggs.gnu.org ([2001:4830:134:3::10]:45818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQP-0007vo-Pu
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQN-0001PT-MB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:19 +1100
Message-Id: <20180117022525.31767-17-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/22] ppc/pnv: use POWER9 DD2 processor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit 1ed9c8af501f ("target/ppc: Add POWER9 DD2.0 model information")
deprecated the POWER9 model v1.0.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c           | 2 +-
 tests/pnv-xscom-test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9475e8479c..536162b274 100644
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
index 89fa6282d3..a1a119c091 100644
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
2.14.3
