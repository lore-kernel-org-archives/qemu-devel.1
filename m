Received: from eggs.gnu.org ([209.51.188.92]:42545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY73-0006bL-88
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY71-0002QG-5V
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gxY6z-0002PW-5u
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id j125so4360875wmj.1
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 06:17:05 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 23 Feb 2019 16:16:42 +0200
Message-Id: <20190223141644.6609-10-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 09/11] hw/pvrdma: Delete pvrdma_exit
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, philmd@redhat.com, dgilbert@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This hook is not called and was implemented by mistake.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190213065357.16076-10-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.1
