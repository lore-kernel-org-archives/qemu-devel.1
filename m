Received: from eggs.gnu.org ([2001:4830:134:3::10]:32781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe2-0007Y6-Oh
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe1-0002kX-Cl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe1-0002gg-6c
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdv-0005VV-ER
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:23 +0000
Message-Id: <1486492645-27803-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/13] stellaris: Document memory map and which
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

Add a comment documenting the memory map of the SoC devices and which
are not implemented.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1484247815-15279-2-git-send-email-peter.maydell@linaro.org
---
 hw/arm/stellaris.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 794a3ad..5c4b707 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1220,6 +1220,40 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
         0x40024000, 0x40025000, 0x40026000};
     static const int gpio_irq[7] = {0, 1, 2, 3, 4, 30, 31};
 
+    /* Memory map of SoC devices, from
+     * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
+     * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
+     *
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
