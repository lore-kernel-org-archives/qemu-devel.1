Received: from eggs.gnu.org ([2001:4830:134:3::10]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzp-0002DO-6l
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYnzl-0007L1-OB
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYnzl-0007IB-Cq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:21 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:30 +0200
Message-Id: <20181217081047.2039-7-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 06/23] hw/pvrdma: Make function reset_device
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
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
