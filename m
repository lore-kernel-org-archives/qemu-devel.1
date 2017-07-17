Received: from eggs.gnu.org ([2001:4830:134:3::10]:34098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvq-0000cr-B7
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvl-0001ZV-FK
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 10:38:23 +0800
Message-Id: <20170717023824.18796-6-famz@redhat.com>
In-Reply-To: <20170717023824.18796-1-famz@redhat.com>
References: <20170717023824.18796-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/6] xilinx_axienet: Convert to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/net/xilinx_axienet.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 5ffa739..d4c2c89 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -989,18 +989,6 @@ static void xilinx_enet_init(Object *obj)
     XilinxAXIEnet *s = XILINX_AXI_ENET(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLAVE,
-                             (Object **) &s->tx_data_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-    object_property_add_link(obj, "axistream-control-connected",
-                             TYPE_STREAM_SLAVE,
-                             (Object **) &s->tx_control_dev,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
     object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
                       TYPE_XILINX_AXI_ENET_DATA_STREAM);
     object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
@@ -1021,6 +1009,10 @@ static Property xilinx_enet_properties[] = {
     DEFINE_PROP_UINT32("rxmem", XilinxAXIEnet, c_rxmem, 0x1000),
     DEFINE_PROP_UINT32("txmem", XilinxAXIEnet, c_txmem, 0x1000),
     DEFINE_NIC_PROPERTIES(XilinxAXIEnet, conf),
+    DEFINE_PROP_LINK("axistream-connected", XilinxAXIEnet,
+                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
+    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIEnet,
+                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
