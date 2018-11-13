Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gMSu8-0003vl-Q6
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gMSu4-0002oO-Cv
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:14:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gMSu4-0002e0-2e
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 02:14:28 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Tue, 13 Nov 2018 09:12:55 +0200
Message-Id: <20181113071336.6242-7-yuval.shaia@oracle.com>
In-Reply-To: <20181113071336.6242-1-yuval.shaia@oracle.com>
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v3 06/23] hw/pvrdma: Make function reset_device
 return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

This function cannot fail - fix it to return void

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 6c8c0154fa..fc2abd34af 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -369,13 +369,11 @@ static int unquiesce_device(PVRDMADev *dev)
     return 0;
 }
 
-static int reset_device(PVRDMADev *dev)
+static void reset_device(PVRDMADev *dev)
 {
     pvrdma_stop(dev);
 
     pr_dbg("Device reset complete\n");
-
-    return 0;
 }
 
 static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.17.2
