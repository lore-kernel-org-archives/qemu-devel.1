Received: from eggs.gnu.org ([2001:4830:134:3::10]:34841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvG-0005gX-Vl
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvD-00025O-M4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvD-00024A-Ca
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:19 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:23 +0200
Message-Id: <20181217184540.4571-7-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 06/23] hw/pvrdma: Make function reset_device
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
