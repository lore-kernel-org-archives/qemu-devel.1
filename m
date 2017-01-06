Received: from eggs.gnu.org ([2001:4830:134:3::10]:54988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPINU-0007D0-HQ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPINR-0000sD-EN
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:27:28 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Fri,  6 Jan 2017 08:26:28 +0800
Message-Id: <20170106002628.10343-5-zxq_yx_007@163.com>
In-Reply-To: <20170106002628.10343-1-zxq_yx_007@163.com>
References: <20170106002628.10343-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH v2 4/4] hw/ppc: QOM'ify spapr_vio.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, peter.maydell@linaro.org, qemu-ppc@nongnu.org

Drop the old and empty SysBus init

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/ppc/spapr_vio.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index cc1e09c568..8bfc5f971f 100644
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
2.11.0
