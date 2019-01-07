Received: from eggs.gnu.org ([209.51.188.92]:46438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXod-00053S-Ay
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoZ-00029E-Oz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoZ-000266-Fz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:47 -0500
Received: by mail-wr1-x42a.google.com with SMTP id x10so1052628wrs.8
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.44 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:01 +0000
Message-Id: <20190107163117.16269-22-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/37] MAINTAINERS: Add ARM-related files for
 hw/[misc|input|timer]/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Some of the files in hw/input/, hw/misc/ and hw/timer/ are only
used by one of the ARM machines, so we can assign these files to
the corresponding boards.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 1546433583-18397-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 471161742de..0bfd95a4ef7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -515,6 +515,7 @@ F: hw/intc/arm*
 F: hw/intc/gic_internal.h
 F: hw/misc/a9scu.c
 F: hw/misc/arm11scu.c
+F: hw/misc/arm_l2x0.c
 F: hw/timer/a9gtimer*
 F: hw/timer/arm*
 F: include/hw/arm/arm*.h
@@ -587,6 +588,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
+F: include/hw/misc/arm_integrator_debug.h
 
 MCIMX6UL EVK / i.MX6ul
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -606,7 +608,9 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx7d-sabre.c
 F: hw/arm/fsl-imx7.c
+F: hw/misc/imx7_*.c
 F: include/hw/arm/fsl-imx7.h
+F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 
@@ -640,6 +644,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/nseries.c
+F: hw/input/lm832x.c
+F: hw/input/tsc2005.c
+F: hw/misc/cbus.c
+F: hw/timer/twl92230.c
 
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
@@ -647,6 +655,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/palm.c
+F: hw/input/tsc210x.c
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -683,6 +692,7 @@ F: hw/display/tc6393xb.c
 F: hw/gpio/max7310.c
 F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
+F: hw/misc/max111x.c
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
 
@@ -693,10 +703,10 @@ L: qemu-arm@nongnu.org
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
@@ -807,7 +817,9 @@ R: Joel Stanley <joel@jms.id.au>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/*aspeed*
+F: hw/misc/pca9552.c
 F: include/hw/*/*aspeed*
+F: include/hw/misc/pca9552*.h
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
 
-- 
2.19.2
