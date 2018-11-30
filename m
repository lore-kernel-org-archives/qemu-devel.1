Received: from eggs.gnu.org ([2001:4830:134:3::10]:38685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGm-0006EH-SH
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGk-0002Yc-8e
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:32 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21654)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gSfGj-0002W0-F1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:39:30 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Fri, 30 Nov 2018 17:38:51 +0800
Message-Id: <20181130093852.20739-21-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
References: <20181130093852.20739-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v3 20/21] xen_backend: remove xen_sysdev_init()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, peter.maydell@linaro.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

The init function doesn't do anything at all, so we
just omit it.

Cc: sstabellini@kernel.org
Cc: anthony.perard@citrix.com
Cc: xen-devel@lists.xenproject.org
Cc: peter.maydell@linaro.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen_backend.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 9a8e8771ec..0bc6b1de60 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -809,11 +809,6 @@ static const TypeInfo xensysbus_info = {
     }
 };
 
-static int xen_sysdev_init(SysBusDevice *dev)
-{
-    return 0;
-}
-
 static Property xen_sysdev_properties[] = {
     {/* end of property list */},
 };
@@ -821,9 +816,7 @@ static Property xen_sysdev_properties[] = {
 static void xen_sysdev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = xen_sysdev_init;
     dc->props = xen_sysdev_properties;
     dc->bus_type = TYPE_XENSYSBUS;
 }
-- 
2.17.1
