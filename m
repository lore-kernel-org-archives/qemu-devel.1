Received: from eggs.gnu.org ([2001:4830:134:3::10]:43008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeb-0006ta-GW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeR-0008BN-Mc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:33 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 21:11:49 +0800
Message-Id: <20170905131149.10669-7-famz@redhat.com>
In-Reply-To: <20170905131149.10669-1-famz@redhat.com>
References: <20170905131149.10669-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 6/6] xilinx_axidma: Convert to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/dma/xilinx_axidma.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 3987b5ff96..9b48103574 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -562,18 +562,6 @@ static void xilinx_axidma_init(Object *obj)
     XilinxAXIDMA *s =3D XILINX_AXI_DMA(obj);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
=20
-    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLA=
VE,
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
=20
 static Property axidma_properties[] =3D {
     DEFINE_PROP_UINT32("freqhz", XilinxAXIDMA, freqhz, 50000000),
+    DEFINE_PROP_LINK("axistream-connected", XilinxAXIDMA,
+                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
+    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIDMA,
+                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.13.5
