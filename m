Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId5J-0000i7-Mo
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId59-0003KY-Kn
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:18:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gId59-0002Zn-3M
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:18:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gId3v-0003al-VC
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 17:16:47 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 17:16:35 +0000
Message-Id: <20181102171638.24069-8-peter.maydell@linaro.org>
In-Reply-To: <20181102171638.24069-1-peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/10] hw/arm/xilinx_zynq: Use the ARRAY_SIZE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f1496d29273..57497b0c4d3 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -294,7 +294,7 @@ static void zynq_init(MachineState *machine)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
     sysbus_connect_irq(busdev, 0, pic[45-IRQ_OFFSET]); /* abort irq line */
-    for (n = 0; n < 8; ++n) { /* event irqs */
+    for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
         sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - IRQ_OFFSET]);
     }
 
-- 
2.19.1
