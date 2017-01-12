Received: from eggs.gnu.org ([2001:4830:134:3::10]:57615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cRkf6-0000o7-8x
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cRkf5-00018F-II
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:03:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cRkf5-00013b-Bq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:03:47 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 19:03:33 +0000
Message-Id: <1484247815-15279-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] stellaris: Document memory map and which
 SoC devices are unimplemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org

Add a comment documenting the memory map of the SoC devices and which
are not implemented.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 794a3ad..204502a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1220,6 +1220,37 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
         0x40024000, 0x40025000, 0x40026000};
     static const int gpio_irq[7] = {0, 1, 2, 3, 4, 30, 31};
 
+    /* Memory map of SoC devices:
+     * 40000000 wdtimer (unimplemented)
+     * 40002000 i2c (unimplemented)
+     * 40004000 GPIO
+     * 40005000 GPIO
+     * 40006000 GPIO
+     * 40007000 GPIO
+     * 40008000 SSI
+     * 4000c000 UART
+     * 4000d000 UART
+     * 4000e000 UART
+     * 40020000 i2c
+     * 40021000 i2c (unimplemented)
+     * 40024000 GPIO
+     * 40025000 GPIO
+     * 40026000 GPIO
+     * 40028000 PWM (unimplemented)
+     * 4002c000 QEI (unimplemented)
+     * 4002d000 QEI (unimplemented)
+     * 40030000 gptimer
+     * 40031000 gptimer
+     * 40032000 gptimer
+     * 40033000 gptimer
+     * 40038000 ADC
+     * 4003c000 analogue comparator (unimplemented)
+     * 40048000 ethernet
+     * 400fc000 hibernation module (unimplemented)
+     * 400fd000 flash memory control (unimplemented)
+     * 400fe000 system control
+     */
+
     DeviceState *gpio_dev[7], *nvic;
     qemu_irq gpio_in[7][8];
     qemu_irq gpio_out[7][8];
-- 
2.7.4
