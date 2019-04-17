Received: from eggs.gnu.org ([209.51.188.92]:43422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdM-0000aF-Gc
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdL-00071r-Mp
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:16 -0400
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Wed, 17 Apr 2019 22:53:52 +0300
Message-Id: <20190417195355.16123-3-mlevitsk@redhat.com>
In-Reply-To: <20190417195355.16123-1-mlevitsk@redhat.com>
References: <20190417195355.16123-1-mlevitsk@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] block/nvme: fix doorbell stride
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Fix the math involving non standard doorbell stride

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 2d208000df..208242cf1f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -216,7 +216,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
         error_propagate(errp, local_err);
         goto fail;
     }
-    q->cq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale + 1];
+    q->cq.doorbell = &s->regs->doorbells[(idx * 2 + 1) * s->doorbell_scale];
 
     return q;
 fail:
-- 
2.17.2
