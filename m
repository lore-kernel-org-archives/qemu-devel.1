Received: from eggs.gnu.org ([2001:4830:134:3::10]:47979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eJoTc-00025c-M9
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 17:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eJoTZ-0006W6-IP
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 17:35:40 -0500
Received: from mail-cys01nam02on0041.outbound.protection.outlook.com
	([104.47.37.41]:58544
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eJoTZ-0006Vc-A1
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 17:35:37 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 28 Nov 2017 14:31:14 -0800
Message-ID: <ee595cb7408c5fce0f2ad6d33b721c7ae1fed283.1511908159.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1511908159.git.alistair.francis@xilinx.com>
References: <cover.1511908159.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH-2.12 v1 3/3] xilinx_spips: Use memset instead
 of a for loop to zero registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Use memset() instead of a for loop to zero all of the registers.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/ssi/xilinx_spips.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 1a37f9c7f5..82436e2f69 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -330,10 +330,7 @@ static void xilinx_spips_reset(DeviceState *d)
 {
     XilinxSPIPS *s = XILINX_SPIPS(d);
 
-    int i;
-    for (i = 0; i < XLNX_SPIPS_R_MAX; i++) {
-        s->regs[i] = 0;
-    }
+    memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo);
     fifo8_reset(&s->rx_fifo);
@@ -358,13 +355,11 @@ static void xilinx_spips_reset(DeviceState *d)
 static void xlnx_zynqmp_qspips_reset(DeviceState *d)
 {
     XlnxZynqMPQSPIPS *s = XLNX_ZYNQMP_QSPIPS(d);
-    int i;
 
     xilinx_spips_reset(d);
 
-    for (i = 0; i < XLNX_ZYNQMP_SPIPS_R_MAX; i++) {
-        s->regs[i] = 0;
-    }
+    memset(s->regs, 0, sizeof(s->regs));
+
     fifo8_reset(&s->rx_fifo_g);
     fifo8_reset(&s->rx_fifo_g);
     fifo32_reset(&s->fifo_g);
-- 
2.14.1
