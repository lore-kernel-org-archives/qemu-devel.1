Received: from eggs.gnu.org ([209.51.188.92]:47626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6T-0000pC-1W
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6Q-0007Yq-Jk
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2u6O-0007WP-H9
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:38 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Mar 2019 10:46:09 +0200
Message-Id: <20190310084610.23077-10-yuval.shaia@oracle.com>
In-Reply-To: <20190310084610.23077-1-yuval.shaia@oracle.com>
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 09/10] hw/pvrdma: Delete pvrdma_exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

This hook is not called and was implemented by mistake.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 01bb6e6b17..84df4294eb 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -654,11 +654,6 @@ out:
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
@@ -666,7 +661,6 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
     RdmaProviderClass *ir = INTERFACE_RDMA_PROVIDER_CLASS(klass);
 
     k->realize = pvrdma_realize;
-    k->exit = pvrdma_exit;
     k->vendor_id = PCI_VENDOR_ID_VMWARE;
     k->device_id = PCI_DEVICE_ID_VMWARE_PVRDMA;
     k->revision = 0x00;
-- 
2.17.2
