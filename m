Received: from eggs.gnu.org ([2001:4830:134:3::10]:39703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXHdv-0002yJ-G9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dXHds-0004CI-FA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dXHds-0004BP-4q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:49:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I1nM3X068255
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:49:37 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bs1svrvhp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:49:37 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 21:49:35 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 03:49:25 +0200
In-Reply-To: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170718014926.44781-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] vfio/ccw: allocate irq info with the right
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, Jing Zhang <bjzhjing@linux.vnet.ibm.com>

From: Jing Zhang <bjzhjing@linux.vnet.ibm.com>

When allocating memory for the vfio_irq_info parameter of the
VFIO_DEVICE_GET_IRQ_INFO ioctl, we used the wrong size. Let's
fix it by using the right size.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
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
2.11.2
