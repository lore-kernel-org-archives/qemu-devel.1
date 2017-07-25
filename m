Received: from eggs.gnu.org ([2001:4830:134:3::10]:44071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKT-0001gr-Vi
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKS-0003JD-PL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwKS-0003It-In
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:36 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:13 +0200
Message-Id: <20170725094026.5376-2-cohuck@redhat.com>
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 01/14] vfio/ccw: allocate irq info with
 the right size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Jing Zhang <bjzhjing@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Jing Zhang <bjzhjing@linux.vnet.ibm.com>

When allocating memory for the vfio_irq_info parameter of the
VFIO_DEVICE_GET_IRQ_INFO ioctl, we used the wrong size. Let's
fix it by using the right size.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170718014926.44781-2-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 12d0262336..8d97b53e77 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -168,7 +168,7 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
-    argsz = sizeof(*irq_set);
+    argsz = sizeof(*irq_info);
     irq_info = g_malloc0(argsz);
     irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
     irq_info->argsz = argsz;
-- 
2.13.3
