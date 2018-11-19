Received: from eggs.gnu.org ([2001:4830:134:3::10]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvl-0002C0-Vi
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvk-0006wC-Ut
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvk-0006tw-ND
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlve-000659-Ar
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:25 +0000
Message-Id: <20181119155730.11758-6-peter.maydell@linaro.org>
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/10] MAINTAINERS: Add entries for missing ARM
 boards
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

Add entries for the boards "mcimx6ul-evk", "mcimx7d-sabre", "raspi2",
"raspi3", "sabrelite", "vexpress-a15", "vexpress-a9" and "virt".
While we're at it, also adjust the "i.MX31" section a little bit,
so that the wildcards there do not match anymore for unrelated files
(e.g. the new hw/misc/imx6ul_ccm.c file).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1542184999-11145-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 70 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba52b8c77b0..bb71f5e6500 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -528,14 +528,15 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
 
-i.MX31
+i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
 L: qemu-arm@nongnu.org
-S: Odd fixes
-F: hw/*/imx*
-F: include/hw/*/imx*
+S: Odd Fixes
 F: hw/arm/kzm.c
-F: include/hw/arm/fsl-imx31.h
+F: hw/*/imx_*
+F: hw/*/*imx31*
+F: include/hw/*/imx_*
+F: include/hw/*/*imx31*
 
 Integrator CP
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -544,6 +545,28 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 
+MCIMX6UL EVK / i.MX6ul
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Jean-Christophe Dubois <jcd@tribudubois.net>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/mcimx6ul-evk.c
+F: hw/arm/fsl-imx6ul.c
+F: hw/misc/imx6ul_ccm.c
+F: include/hw/arm/fsl-imx6ul.h
+F: include/hw/misc/imx6ul_ccm.h
+
+MCIMX7D SABRE / i.MX7
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Andrey Smirnov <andrew.smirnov@gmail.com>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/mcimx7d-sabre.c
+F: hw/arm/fsl-imx7.c
+F: include/hw/arm/fsl-imx7.h
+F: hw/pci-host/designware.c
+F: include/hw/pci-host/designware.h
+
 MPS2
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
@@ -577,6 +600,17 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/palm.c
 
+Raspberry Pi
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Andrew Baumann <Andrew.Baumann@microsoft.com>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/raspi_platform.h
+F: hw/*/bcm283*
+F: include/hw/arm/raspi*
+F: include/hw/*/bcm283*
+
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
@@ -598,6 +632,19 @@ F: hw/*/pxa2xx*
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
 
+SABRELITE / i.MX6
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Jean-Christophe Dubois <jcd@tribudubois.net>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/sabrelite.c
+F: hw/arm/fsl-imx6.c
+F: hw/misc/imx6_src.c
+F: hw/ssi/imx_spi.c
+F: include/hw/arm/fsl-imx6.h
+F: include/hw/misc/imx6_src.h
+F: include/hw/ssi/imx_spi.h
+
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
@@ -611,6 +658,12 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/stellaris*
 
+Versatile Express
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/vexpress.c
+
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
@@ -618,6 +671,13 @@ S: Maintained
 F: hw/*/versatile*
 F: hw/misc/arm_sysctl.c
 
+Virt
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/virt*
+F: include/hw/arm/virt.h
+
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
-- 
2.19.1
