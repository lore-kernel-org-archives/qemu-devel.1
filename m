Received: from eggs.gnu.org ([209.51.188.92]:44004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4R-0006Rx-DI
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0007nt-F7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:35 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 18:38:58 -0700
Message-Id: <20190416013902.4941-2-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/5] i.mx7d: Add no-op/unimplemented APBH DMA
 module
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

Instantiate no-op APBH DMA module. Needed to boot latest Linux kernel.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/arm/fsl-imx7.h | 3 +++
 hw/arm/fsl-imx7.c         | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index d848262bfd..aae4f860fc 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -179,6 +179,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_PCIE_REG_SIZE        = 16 * 1024,
 
     FSL_IMX7_GPR_ADDR             = 0x30340000,
+
+    FSL_IMX7_DMA_APBH_ADDR        = 0x33000000,
+    FSL_IMX7_DMA_APBH_SIZE        = 0x2000,
 };
 
 enum FslIMX7IRQs {
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 7663ad6861..1abfa5910c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -526,6 +526,12 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("lcdif", FSL_IMX7_LCDIF_ADDR,
                                 FSL_IMX7_LCDIF_SIZE);
+
+    /*
+     * DMA APBH
+     */
+    create_unimplemented_device("dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
+                                FSL_IMX7_DMA_APBH_SIZE);
 }
 
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
-- 
2.20.1
