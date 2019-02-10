Received: from eggs.gnu.org ([209.51.188.92]:51404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gsmdI-00007E-BF
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 05:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gsmdE-0007UG-V7
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 05:46:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gsmdB-0007PT-Ae
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 05:46:39 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Feb 2019 12:45:36 +0200
Message-Id: <20190210104537.1488-9-yuval.shaia@oracle.com>
In-Reply-To: <20190210104537.1488-1-yuval.shaia@oracle.com>
References: <20190210104537.1488-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v1 8/9] hw/pvrdma: Delete pvrdma_exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com
Cc: Yuval Shaia <yuval.shaia@oracle.com>

This hook is not called and was implemented by mistake.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 90dc9b191b..8b379c6435 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -701,18 +701,12 @@ out:
     }
 }
 
-static void pvrdma_exit(PCIDevice *pdev)
-{
-    pvrdma_fini(pdev);
-}
-
 static void pvrdma_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pvrdma_realize;
-    k->exit = pvrdma_exit;
     k->vendor_id = PCI_VENDOR_ID_VMWARE;
     k->device_id = PCI_DEVICE_ID_VMWARE_PVRDMA;
     k->revision = 0x00;
-- 
2.17.2
