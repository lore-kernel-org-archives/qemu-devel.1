Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun5-0007nM-Hq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun4-0007bQ-QU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun4-0007Yb-Jl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun3-0004nR-J2
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:36 +0100
Message-Id: <20180629145347.652-45-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 44/55] i.mx7d: Change SRC unimplemented device
 name from sdma to src
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

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 26c1d27f7ca..e15aadb587c 100644
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
