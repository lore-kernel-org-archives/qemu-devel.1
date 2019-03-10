Received: from eggs.gnu.org ([209.51.188.92]:43604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpF-00027T-PF
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpE-00024x-UB
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:48 +1100
Message-Id: <20190310082703.1245-46-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 45/60] ppc/pnv: lpc: fix OPB address ranges
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

The PowerNV LPC Controller exposes different sets of registers for
each of the functional units it encompasses, among which the OPB
(On-Chip Peripheral Bus) Master and Arbitrer and the LPC HOST
Controller.

The mapping addresses of each register range are correct but the sizes
are too large. Fix the sizes and define the OPB Arbitrer range to fill
the gap between the OPB Master registers and the LPC HOST Controller
registers.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_lpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 9b18ce55e3..547be609ca 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -89,10 +89,11 @@ enum {
 #define LPC_FW_OPB_SIZE         0x10000000
=20
 #define LPC_OPB_REGS_OPB_ADDR   0xc0010000
-#define LPC_OPB_REGS_OPB_SIZE   0x00002000
+#define LPC_OPB_REGS_OPB_SIZE   0x00000060
+#define LPC_OPB_REGS_OPBA_ADDR  0xc0011000
+#define LPC_OPB_REGS_OPBA_SIZE  0x00000008
 #define LPC_HC_REGS_OPB_ADDR    0xc0012000
-#define LPC_HC_REGS_OPB_SIZE    0x00001000
-
+#define LPC_HC_REGS_OPB_SIZE    0x00000100
=20
 static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
--=20
2.20.1
