Received: from eggs.gnu.org ([2001:4830:134:3::10]:36463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP9-00055q-Cz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSP8-00008f-FV
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSP8-00071P-7R
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:58 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO9-0007KQ-RI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:57 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:30 +0000
Message-Id: <20181213145445.17935-23-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/37] xen_backend: remove xen_sysdev_init()
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

The init function doesn't do anything at all, so we
just omit it.

Cc: sstabellini@kernel.org
Cc: anthony.perard@citrix.com
Cc: xen-devel@lists.xenproject.org
Cc: peter.maydell@linaro.org

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-id: 20181130093852.20739-21-maozhongyi@cmss.chinamobile.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/xen/xen_backend.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 9a8e8771eca..0bc6b1de60f 100644
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
2.19.2
