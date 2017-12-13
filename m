Received: from eggs.gnu.org ([2001:4830:134:3::10]:51903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWt-000554-3S
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWs-0008Gz-84
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWs-0008FT-1p
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWq-0007s0-U8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:41 +0000
Message-Id: <1513188761-20784-44-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 43/43] xilinx_spips: Use memset instead of a for
 loop to zero registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Use memset() instead of a for loop to zero all of the registers.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: c076e907f355923864cb1afde31b938ffb677778.1513104804.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 42d9b04..d8187fa 100644
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
2.7.4
