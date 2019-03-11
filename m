Received: from eggs.gnu.org ([209.51.188.92]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBW-0007d6-Rq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBV-0000yg-SP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h3IBV-0000y9-HU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:29 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 11 Mar 2019 03:29:15 -0700
Message-Id: <1552300155-25216-12-git-send-email-yuval.shaia@oracle.com>
In-Reply-To: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
References: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v6 11/11] hw/pvrdma: Provide correct value to
 object_get_typename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com

Use base object of PCIDevice in call to object_get_typename().

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 49bfbd6..0b46561 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -593,7 +593,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 
     func0 = pci_get_function_0(pdev);
     /* Break if not vmxnet3 device in slot 0 */
-    if (strcmp(object_get_typename(&func0->qdev.parent_obj), TYPE_VMXNET3)) {
+    if (strcmp(object_get_typename(OBJECT(func0)), TYPE_VMXNET3)) {
         error_setg(errp, "Device on %x.0 must be %s", PCI_SLOT(pdev->devfn),
                    TYPE_VMXNET3);
         return;
-- 
1.8.3.1
