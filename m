Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYj-00007n-9Z
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYe-0000fS-Ha
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYe-0000f6-Be
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:20 -0400
Received: by mail-wr1-x442.google.com with SMTP id g1-v6so12896161wru.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:20 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:53 +0300
Message-Id: <20180819202300.10590-9-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 08/15] hw/rdma: Reorder resource cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

From: Yuval Shaia <yuval.shaia@oracle.com>

To be consistence with allocation do the reverse order in deallocation

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-9-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
