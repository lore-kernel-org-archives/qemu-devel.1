Received: from eggs.gnu.org ([2001:4830:134:3::10]:47854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPME1-00018P-Eq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 01:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPME0-0002LW-Iu
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 01:43:01 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 21 Nov 2018 07:42:48 +0100
Message-Id: <1542782568-20059-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] MAINTAINERS: Assign some more files in the
 hw/arm/ directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

I apparently missed some more files and even a complete machine (the
"imx25-pdk") in my previous patch... but now we should hopefully have
a completely coverage for all available ARM boards.

Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v3: Dropped "ds1338-test.c", added some more pxa2xx related files instea=
d

 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406..63c88e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -533,6 +533,17 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
=20
+i.MX25 PDK
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Jean-Christophe Dubois <jcd@tribudubois.net>
+L: qemu-arm@nongnu.org
+S: Odd Fixes
+F: hw/arm/fsl-imx25.c
+F: hw/arm/imx25_pdk.c
+F: hw/misc/imx25_ccm.c
+F: include/hw/arm/fsl-imx25.h
+F: include/hw/misc/imx25_ccm.h
+
 i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -615,6 +626,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+F: hw/arm/raspi.c
 F: hw/arm/raspi_platform.h
 F: hw/*/bcm283*
 F: include/hw/arm/raspi*
@@ -639,8 +651,12 @@ F: hw/arm/spitz.c
 F: hw/arm/tosa.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
+F: hw/display/tc6393xb.c
+F: hw/gpio/max7310.c
+F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
+F: include/hw/arm/sharpsl.h
=20
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
--=20
1.8.3.1
