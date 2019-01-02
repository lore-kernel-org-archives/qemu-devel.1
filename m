Received: from eggs.gnu.org ([208.118.235.92]:56427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1geg1Q-0007VZ-AJ
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1geg1O-0000tI-EF
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:53:20 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 Jan 2019 13:53:03 +0100
Message-Id: <1546433583-18397-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add ARM-related files for
 hw/[misc|input|timer]/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org

Some of the files in hw/input/, hw/misc/ and hw/timer/ are only
used by one of the ARM machines, so we can assign these files to
the corresponding boards.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 180695f..693abdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -510,6 +510,7 @@ F: hw/intc/arm*
 F: hw/intc/gic_internal.h
 F: hw/misc/a9scu.c
 F: hw/misc/arm11scu.c
+F: hw/misc/arm_l2x0.c
 F: hw/timer/a9gtimer*
 F: hw/timer/arm*
 F: include/hw/arm/arm*.h
@@ -582,6 +583,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
+F: include/hw/misc/arm_integrator_debug.h
 
 MCIMX6UL EVK / i.MX6ul
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -601,7 +603,9 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx7d-sabre.c
 F: hw/arm/fsl-imx7.c
+F: hw/misc/imx7_*.c
 F: include/hw/arm/fsl-imx7.h
+F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 
@@ -635,6 +639,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/nseries.c
+F: hw/input/lm832x.c
+F: hw/input/tsc2005.c
+F: hw/misc/cbus.c
+F: hw/timer/twl92230.c
 
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
@@ -642,6 +650,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/palm.c
+F: hw/input/tsc210x.c
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -678,6 +687,7 @@ F: hw/display/tc6393xb.c
 F: hw/gpio/max7310.c
 F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
+F: hw/misc/max111x.c
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
 
@@ -688,10 +698,10 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/sabrelite.c
 F: hw/arm/fsl-imx6.c
-F: hw/misc/imx6_src.c
+F: hw/misc/imx6_*.c
 F: hw/ssi/imx_spi.c
 F: include/hw/arm/fsl-imx6.h
-F: include/hw/misc/imx6_src.h
+F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
 
 Sharp SL-5500 (Collie) PDA
@@ -802,7 +812,9 @@ R: Joel Stanley <joel@jms.id.au>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/*aspeed*
+F: hw/misc/pca9552.c
 F: include/hw/*/*aspeed*
+F: include/hw/misc/pca9552*.h
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 
-- 
1.8.3.1
