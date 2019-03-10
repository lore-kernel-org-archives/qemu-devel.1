Received: from eggs.gnu.org ([209.51.188.92]:43614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpG-00027p-4M
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpF-00025Q-Af
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:57 +1100
Message-Id: <20190310082703.1245-55-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 54/60] ppc/pnv: activate XSCOM tests for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

We now have enough support to let the XSCOM test run on POWER9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-13-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/pnv-xscom-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 974f8da5b2..63d464048d 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -39,7 +39,6 @@ static const PnvChip pnv_chips[] =3D {
         .cfam_id    =3D 0x120d304980000000ull,
         .first_core =3D 0x1,
     },
-#if 0 /* POWER9 support is not ready yet */
     {
         .chip_type  =3D PNV_CHIP_POWER9,
         .cpu_model  =3D "POWER9",
@@ -47,7 +46,6 @@ static const PnvChip pnv_chips[] =3D {
         .cfam_id    =3D 0x220d104900008000ull,
         .first_core =3D 0x0,
     },
-#endif
 };
=20
 static uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
--=20
2.20.1
