Received: from eggs.gnu.org ([209.51.188.92]:46243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h0XoL-0004dh-Ss
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h0XoL-00078O-7w
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:34:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h0XoK-00077a-Ux
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:34:13 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  3 Mar 2019 22:33:44 +0200
Message-Id: <20190303203345.2472-9-yuval.shaia@oracle.com>
In-Reply-To: <20190303203345.2472-1-yuval.shaia@oracle.com>
References: <20190303203345.2472-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v4 8/9] hw/pvrdma: Delete pvrdma_exit function
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
index b795f80666..4e4a43eac4 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -641,11 +641,6 @@ out:
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
@@ -653,7 +648,6 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
     RdmaStatsProviderClass *ir = RDMA_STATS_PROVIDER_CLASS(klass);
 
     k->realize = pvrdma_realize;
-    k->exit = pvrdma_exit;
     k->vendor_id = PCI_VENDOR_ID_VMWARE;
     k->device_id = PCI_DEVICE_ID_VMWARE_PVRDMA;
     k->revision = 0x00;
-- 
2.17.2
