Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0l-00049c-Et
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1fXw0g-0002mk-UE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:31 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1fXw0g-0002ma-Lt
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:26 -0400
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed, 27 Jun 2018 00:00:22 +0200
Message-Id: <20180626220022.19037-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH 2/3] i.mx7d: Change SRC unimpleted device name
 from sdma to src
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

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 26c1d27f7c..e15aadb587 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -459,7 +459,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * SRC
      */
-    create_unimplemented_device("sdma", FSL_IMX7_SRC_ADDR, FSL_IMX7_SRC_SIZE);
+    create_unimplemented_device("src", FSL_IMX7_SRC_ADDR, FSL_IMX7_SRC_SIZE);
 
     /*
      * Watchdog
-- 
2.17.1
