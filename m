Received: from eggs.gnu.org ([209.51.188.92]:43536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpD-00025e-VJ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpD-00023L-7Y
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:52 +1100
Message-Id: <20190310082703.1245-50-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 49/60] ppc/pnv: add SerIRQ routing registers
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

This is just a simple reminder that SerIRQ routing should be
addressed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-8-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_lpc.c         | 14 ++++++++++++++
 include/hw/ppc/pnv_lpc.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 6df694e0ab..641e2046db 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -39,6 +39,8 @@ enum {
 };
=20
 /* OPB Master LS registers */
+#define OPB_MASTER_LS_ROUTE0    0x8
+#define OPB_MASTER_LS_ROUTE1    0xC
 #define OPB_MASTER_LS_IRQ_STAT  0x50
 #define   OPB_MASTER_IRQ_LPC            0x00000800
 #define OPB_MASTER_LS_IRQ_MASK  0x54
@@ -521,6 +523,12 @@ static uint64_t opb_master_read(void *opaque, hwaddr=
 addr, unsigned size)
     uint64_t val =3D 0xfffffffffffffffful;
=20
     switch (addr) {
+    case OPB_MASTER_LS_ROUTE0: /* TODO */
+        val =3D lpc->opb_irq_route0;
+        break;
+    case OPB_MASTER_LS_ROUTE1: /* TODO */
+        val =3D lpc->opb_irq_route1;
+        break;
     case OPB_MASTER_LS_IRQ_STAT:
         val =3D lpc->opb_irq_stat;
         break;
@@ -547,6 +555,12 @@ static void opb_master_write(void *opaque, hwaddr ad=
dr,
     PnvLpcController *lpc =3D opaque;
=20
     switch (addr) {
+    case OPB_MASTER_LS_ROUTE0: /* TODO */
+        lpc->opb_irq_route0 =3D val;
+        break;
+    case OPB_MASTER_LS_ROUTE1: /* TODO */
+        lpc->opb_irq_route1 =3D val;
+        break;
     case OPB_MASTER_LS_IRQ_STAT:
         lpc->opb_irq_stat &=3D ~val;
         pnv_lpc_eval_irqs(lpc);
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 242b18081c..413579792e 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -55,6 +55,8 @@ typedef struct PnvLpcController {
     MemoryRegion opb_master_regs;
=20
     /* OPB Master LS registers */
+    uint32_t opb_irq_route0;
+    uint32_t opb_irq_route1;
     uint32_t opb_irq_stat;
     uint32_t opb_irq_mask;
     uint32_t opb_irq_pol;
--=20
2.20.1
