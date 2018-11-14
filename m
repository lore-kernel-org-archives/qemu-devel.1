Received: from eggs.gnu.org ([2001:4830:134:3::10]:55280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMqlx-0003sB-I4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 03:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMqls-0006dl-1y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 03:43:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Nov 2018 09:43:19 +0100
Message-Id: <1542184999-11145-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add entries for missing ARM boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Add entries for the boards "mcimx6ul-evk", "mcimx7d-sabre", "raspi2",
"raspi3", "sabrelite", "vexpress-a15", "vexpress-a9" and "virt".
While we're at it, also adjust the "i.MX31" section a little bit,
so that the wildcards there do not match anymore for unrelated files
(e.g. the new hw/misc/imx6ul_ccm.c file).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b8db61..dd8ac65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -521,14 +521,15 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
=20
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
=20
 Integrator CP
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -537,6 +538,28 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
=20
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
@@ -570,6 +593,17 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/palm.c
=20
+Raspberry Pi
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Andrew Baumann <Andrew.Baumann@microsoft.com>
+R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
@@ -591,6 +625,19 @@ F: hw/*/pxa2xx*
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
=20
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
@@ -604,6 +651,12 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/stellaris*
=20
+Versatile Express
+M: Peter Maydell <peter.maydell@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/vexpress.c
+
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
@@ -611,6 +664,13 @@ S: Maintained
 F: hw/*/versatile*
 F: hw/misc/arm_sysctl.c
=20
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
--=20
1.8.3.1
