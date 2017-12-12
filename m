Received: from eggs.gnu.org ([2001:4830:134:3::10]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eOplK-0002UH-LO
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eOplG-0008Q4-RO
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:58:42 -0500
Received: from mail-dm3nam03on0063.outbound.protection.outlook.com
	([104.47.41.63]:61155
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eOplG-0008P0-JD
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:58:38 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 12 Dec 2017 10:54:18 -0800
Message-ID: <c076e907f355923864cb1afde31b938ffb677778.1513104804.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513104804.git.alistair.francis@xilinx.com>
References: <cover.1513104804.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH-2.12 v3 3/3] xilinx_spips: Use memset instead
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, frasse.iglesias@gmail.com, frederic.konrad@adacore.com

Use memset() instead of a for loop to zero all of the registers.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---

 hw/ssi/xilinx_spips.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 42d9b04bd3..d8187fadd1 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -329,10 +329,7 @@ static void xilinx_spips_reset(DeviceState *d)
 {
     XilinxSPIPS *s = XILINX_SPIPS(d);
 
-    int i;
-    for (i = 0; i < XLNX_SPIPS_R_MAX; i++) {
-        s->regs[i] = 0;
-    }
+    memset(s->regs, 0, sizeof(s->regs));
 
     fifo8_reset(&s->rx_fifo);
     fifo8_reset(&s->rx_fifo);
@@ -357,13 +354,11 @@ static void xilinx_spips_reset(DeviceState *d)
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
