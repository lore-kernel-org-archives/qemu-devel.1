Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHPH-0005MO-Qi
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHPG-0004Cv-UH
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gRHPG-000484-Ny
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 08:58:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gRHP8-0001gS-Es
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:58:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 13:58:18 +0000
Message-Id: <20181126135820.18998-2-peter.maydell@linaro.org>
In-Reply-To: <20181126135820.18998-1-peter.maydell@linaro.org>
References: <20181126135820.18998-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/3] MAINTAINERS: Assign some more files in the
 hw/arm/ directory
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

I apparently missed some more files and even a complete machine (the
"imx25-pdk") in my previous patch... but now we should hopefully have
a completely coverage for all available ARM boards.

Fixes: 95a5db3ae5698b49c63144610ad02913e780c828
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 1542782568-20059-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4a7e453c06..43d0d9d5783 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -535,6 +535,17 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
 
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
@@ -617,6 +628,7 @@ R: Andrew Baumann <Andrew.Baumann@microsoft.com>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
+F: hw/arm/raspi.c
 F: hw/arm/raspi_platform.h
 F: hw/*/bcm283*
 F: include/hw/arm/raspi*
@@ -641,8 +653,12 @@ F: hw/arm/spitz.c
 F: hw/arm/tosa.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
+F: hw/display/tc6393xb.c
+F: hw/gpio/max7310.c
+F: hw/gpio/zaurus.c
 F: hw/misc/mst_fpga.c
 F: include/hw/arm/pxa.h
+F: include/hw/arm/sharpsl.h
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.19.1
