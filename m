Received: from eggs.gnu.org ([2001:4830:134:3::10]:34255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun6-0007ox-FL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun5-0007eF-NU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun5-0007Yb-Ge
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun4-0004ng-B0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:37 +0100
Message-Id: <20180629145347.652-46-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 45/55] i.mx7d: Change IRQ number type from
 hwaddr to int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jean-Christophe Dubois <jcd@tribudubois.net>

The qdev_get_gpio_in() function accept an int as second parameter.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index e15aadb587c..44fde03cbea 100644
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
