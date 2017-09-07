Received: from eggs.gnu.org ([2001:4830:134:3::10]:56501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr7-00011u-2d
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqx-0007dK-3Q
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqw-0007a4-T0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwql-0001XX-UI
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:27:59 +0100
Message-Id: <1504790904-17018-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/31] xilinx_axidma: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20170905131149.10669-7-famz@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xilinx_axidma.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 3987b5f..9b48103 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -562,18 +562,6 @@ static void xilinx_axidma_init(Object *obj)
     XilinxAXIDMA *s = XILINX_AXI_DMA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLAVE,
-                             (Object **)&s->tx_data_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-    object_property_add_link(obj, "axistream-control-connected",
-                             TYPE_STREAM_SLAVE,
-                             (Object **)&s->tx_control_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
     object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
                       TYPE_XILINX_AXI_DMA_DATA_STREAM);
     object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
@@ -593,6 +581,10 @@ static void xilinx_axidma_init(Object *obj)
 
 static Property axidma_properties[] = {
     DEFINE_PROP_UINT32("freqhz", XilinxAXIDMA, freqhz, 50000000),
+    DEFINE_PROP_LINK("axistream-connected", XilinxAXIDMA,
+                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
+    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIDMA,
+                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
