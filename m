Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMR-0001ml-66
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMO-0002yJ-Dt
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:03 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:24226)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gOiMN-0002r7-JX
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:09:00 -0500
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 19 Nov 2018 20:08:18 +0800
Message-Id: <20181119120820.29878-21-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 20/22] xen_backend: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, sstabellini@kernel.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Use DeviceClass rather than SysBusDeviceClass in
xen_sysdev_class_init().

Cc: sstabellini@kernel.org
Cc: anthony.perard@citrix.com
Cc: xen-devel@lists.xenproject.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 hw/xen/xen_backend.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 9a8e8771ec..73b0ed0169 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -809,9 +809,8 @@ static const TypeInfo xensysbus_info = {
     }
 };
 
-static int xen_sysdev_init(SysBusDevice *dev)
+static void xen_sysdev_realize(DeviceState *dev, Error **errp)
 {
-    return 0;
 }
 
 static Property xen_sysdev_properties[] = {
@@ -821,9 +820,8 @@ static Property xen_sysdev_properties[] = {
 static void xen_sysdev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = xen_sysdev_init;
+    dc->realize = xen_sysdev_realize;
     dc->props = xen_sysdev_properties;
     dc->bus_type = TYPE_XENSYSBUS;
 }
-- 
2.17.1
