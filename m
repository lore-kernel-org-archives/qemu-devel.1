Received: from eggs.gnu.org ([2001:4830:134:3::10]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0s-0004EF-1N
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0n-0002ns-Fm
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fXw0n-0002nn-81
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:33 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed, 27 Jun 2018 00:00:29 +0200
Message-Id: <20180626220029.19088-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH 3/3] i.mx7d: Change IRQ number type from hwaddr
 to int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, andrew.smirnov@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

The qdev_get_gpio_in() function accept an int as second parameter.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index e15aadb587..44fde03cbe 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -324,7 +324,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_ECSPI4_ADDR,
         };
 
-        static const hwaddr FSL_IMX7_SPIn_IRQ[FSL_IMX7_NUM_ECSPIS] = {
+        static const int FSL_IMX7_SPIn_IRQ[FSL_IMX7_NUM_ECSPIS] = {
             FSL_IMX7_ECSPI1_IRQ,
             FSL_IMX7_ECSPI2_IRQ,
             FSL_IMX7_ECSPI3_IRQ,
@@ -349,7 +349,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_I2C4_ADDR,
         };
 
-        static const hwaddr FSL_IMX7_I2Cn_IRQ[FSL_IMX7_NUM_I2CS] = {
+        static const int FSL_IMX7_I2Cn_IRQ[FSL_IMX7_NUM_I2CS] = {
             FSL_IMX7_I2C1_IRQ,
             FSL_IMX7_I2C2_IRQ,
             FSL_IMX7_I2C3_IRQ,
@@ -515,7 +515,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USB3_ADDR,
         };
 
-        static const hwaddr FSL_IMX7_USBn_IRQ[FSL_IMX7_NUM_USBS] = {
+        static const int FSL_IMX7_USBn_IRQ[FSL_IMX7_NUM_USBS] = {
             FSL_IMX7_USB1_IRQ,
             FSL_IMX7_USB2_IRQ,
             FSL_IMX7_USB3_IRQ,
-- 
2.17.1
