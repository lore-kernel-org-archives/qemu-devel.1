Received: from eggs.gnu.org ([2001:4830:134:3::10]:51700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9ju-0007TV-Lu
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jq-0003rS-T6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:43 +1100
Message-Id: <20170202051445.5735-46-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 045/107] hw/ppc: QOM'ify spapr_vio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, xiaoqiang zhao <zxq_yx_007@163.com>, David Gibson <david@gibson.dropbear.id.au>

From: xiaoqiang zhao <zxq_yx_007@163.com>

Drop the old and empty SysBus init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_vio.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index cc1e09c..8bfc5f9 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -538,21 +538,11 @@ VIOsPAPRBus *spapr_vio_bus_init(void)
     return bus;
 }
 
-/* Represents sPAPR hcall VIO devices */
-
-static int spapr_vio_bridge_init(SysBusDevice *dev)
-{
-    /* nothing */
-    return 0;
-}
-
 static void spapr_vio_bridge_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->fw_name = "vdevice";
-    k->init = spapr_vio_bridge_init;
 }
 
 static const TypeInfo spapr_vio_bridge_info = {
-- 
2.9.3
