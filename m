Received: from eggs.gnu.org ([2001:4830:134:3::10]:59240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1duF9G-0006YK-Pn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1duF9B-0003id-48
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:48:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Sep 2017 10:48:41 +0100
Message-Id: <20170919094841.29522-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] nvme: fix cmbuf leak on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <keith.busch@intel.com>

Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/nvme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9aa32692a3..513ec7065d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1057,6 +1057,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->cmbuf);
     if (n->cmbsz) {
         memory_region_unref(&n->ctrl_mem);
     }
-- 
2.13.5
