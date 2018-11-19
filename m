Received: from eggs.gnu.org ([2001:4830:134:3::10]:45344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvl-0002AG-EJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvk-0006vR-02
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvj-0006tw-Oa
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:43 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvi-00066N-Ru
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:30 +0000
Message-Id: <20181119155730.11758-11-peter.maydell@linaro.org>
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/10] MAINTAINERS: list myself as maintainer
 for various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In practice for most of the more-or-less orphan Arm board models,
I will review patches and put them in via the target-arm tree.
So list myself as an "Odd Fixes" status maintainer for them.

This commit downgrades these boards to "Odd Fixes":
 * Allwinner-A10
 * Exynos
 * Calxeda Highbank
 * Canon DIGIC
 * Musicpal
 * nSeries
 * Palm
 * PXA2xx

These boards were already "Odd Fixes":
 * Gumstix
 * i.MX31 (kzm)

Philippe Mathieu-Daudé has requested to be moved to R:
status for Gumstix now that I am listed as the M: contact.

Some boards are maintained, but their patches still go
via the target-arm tree, so add myself as a secondary
maintainer contact for those:
 * Xilinx Zynq
 * Xilinx ZynqMP
 * STM32F205
 * Netduino 2
 * SmartFusion2
 * Mecraft M2S-FG484
 * ASPEED BMCs
 * NRF51

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20181108134139.31666-1-peter.maydell@linaro.org
---
 MAINTAINERS | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb71f5e6500..1032406c560 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -442,8 +442,9 @@ ARM Machines
 ------------
 Allwinner-a10
 M: Beniamino Galvani <b.galvani@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
@@ -502,27 +503,31 @@ F: tests/test-arm-mptimer.c
 
 Exynos
 M: Igor Mitsyanko <i.mitsyanko@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/exynos*
 F: include/hw/arm/exynos4210.h
 
 Calxeda Highbank
 M: Rob Herring <robh@kernel.org>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/highbank.c
 F: hw/net/xgmac.c
 
 Canon DIGIC
 M: Antony Pavlov <antonynpavlov@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: include/hw/arm/digic.h
 F: hw/*/digic*
 
 Gumstix
-M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-devel@nongnu.org
 L: qemu-arm@nongnu.org
 S: Odd Fixes
@@ -530,6 +535,7 @@ F: hw/arm/gumstix.c
 
 i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/kzm.c
@@ -584,20 +590,23 @@ F: include/hw/misc/iotkit-sysinfo.h
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/musicpal.c
 
 nSeries
 M: Andrzej Zaborowski <balrogg@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/nseries.c
 
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/palm.c
 
 Raspberry Pi
@@ -622,8 +631,9 @@ F: include/hw/intc/realview_gic.h
 
 PXA2XX
 M: Andrzej Zaborowski <balrogg@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/mainstone.c
 F: hw/arm/spitz.c
 F: hw/arm/tosa.c
@@ -681,6 +691,7 @@ F: include/hw/arm/virt.h
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xilinx_*
@@ -692,6 +703,7 @@ X: hw/ssi/xilinx_*
 Xilinx ZynqMP
 M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/xlnx*.c
@@ -705,6 +717,7 @@ F: hw/arm/virt-acpi-build.c
 
 STM32F205
 M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/stm32f205_soc.c
 F: hw/misc/stm32f2xx_syscfg.c
@@ -716,11 +729,13 @@ F: include/hw/*/stm32*.h
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/netduino2.c
 
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/msf2-soc.c
 F: hw/misc/msf2-sysreg.c
@@ -733,11 +748,13 @@ F: include/hw/ssi/mss-spi.h
 
 Emcraft M2S-FG484
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
+M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/msf2-som.c
 
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
+M: Peter Maydell <peter.maydell@linaro.org>
 R: Andrew Jeffery <andrew@aj.id.au>
 R: Joel Stanley <joel@jms.id.au>
 L: qemu-arm@nongnu.org
@@ -749,6 +766,7 @@ F: include/hw/net/ftgmac100.h
 
 NRF51
 M: Joel Stanley <joel@jms.id.au>
+M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/nrf51_soc.c
-- 
2.19.1
