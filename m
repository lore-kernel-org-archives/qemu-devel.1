Received: from eggs.gnu.org ([2001:4830:134:3::10]:39860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4n-0007Bk-0B
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmL4i-0006Si-4F
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fmL4h-0006SX-R1
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:36:08 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 Aug 2018 18:35:13 +0300
Message-Id: <20180805153518.2983-9-yuval.shaia@oracle.com>
In-Reply-To: <20180805153518.2983-1-yuval.shaia@oracle.com>
References: <20180805153518.2983-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH v2 08/13] hw/rdma: Reorder resource cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

To be consistence with allocation do the reverse order in deallocation

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index bf4a5c71b4..1f014b4ab2 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -543,8 +543,9 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res)
     res_tbl_free(&dev_res->uc_tbl);
     res_tbl_free(&dev_res->cqe_ctx_tbl);
     res_tbl_free(&dev_res->qp_tbl);
-    res_tbl_free(&dev_res->cq_tbl);
     res_tbl_free(&dev_res->mr_tbl);
+    res_tbl_free(&dev_res->cq_tbl);
     res_tbl_free(&dev_res->pd_tbl);
+
     g_hash_table_destroy(dev_res->qp_hash);
 }
-- 
2.17.1
