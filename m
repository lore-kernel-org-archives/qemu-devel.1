Received: from eggs.gnu.org ([209.51.188.92]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4R-0006SC-M3
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0007o3-Oy
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:35 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 18:38:59 -0700
Message-Id: <20190416013902.4941-3-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] i.mx7d: Add no-op/unimplemented PCIE PHY
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

Add no-op/unimplemented PCIE PHY IP block. Needed by new kernels to
use PCIE.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/arm/fsl-imx7.h | 3 +++
 hw/arm/fsl-imx7.c         | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index aae4f860fc..3efa697adc 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -125,6 +125,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_ADC2_ADDR            = 0x30620000,
     FSL_IMX7_ADCn_SIZE            = 0x1000,
 
+    FSL_IMX7_PCIE_PHY_ADDR        = 0x306D0000,
+    FSL_IMX7_PCIE_PHY_SIZE        = 0x10000,
+
     FSL_IMX7_GPC_ADDR             = 0x303A0000,
 
     FSL_IMX7_I2C1_ADDR            = 0x30A20000,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 1abfa5910c..813fb55ca9 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -532,6 +532,11 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
                                 FSL_IMX7_DMA_APBH_SIZE);
+    /*
+     * PCIe PHY
+     */
+    create_unimplemented_device("pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
+                                FSL_IMX7_PCIE_PHY_SIZE);
 }
 
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
-- 
2.20.1
