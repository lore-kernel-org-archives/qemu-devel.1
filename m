Received: from eggs.gnu.org ([2001:4830:134:3::10]:45712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQM-0007rp-Vm
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQL-0001Mq-Eo
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:20 +1100
Message-Id: <20180117022525.31767-18-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/22] ppc/pnv: change core mask for POWER9
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

When addressed by XSCOM, the first core has the 0x20 chiplet ID but
the CPU PIR can start at 0x0.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c           | 4 ++--
 tests/pnv-xscom-test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 536162b274..f9591cd41d 100644
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
index a1a119c091..9d545c4718 100644
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
2.14.3
