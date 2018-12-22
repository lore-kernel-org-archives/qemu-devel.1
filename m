Received: from eggs.gnu.org ([2001:4830:134:3::10]:41546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvp-00069p-79
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvm-0006KC-Qp
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvj-0006Hi-E5
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so7505658wrr.12
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:46 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:09 +0200
Message-Id: <20181222095036.29743-5-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 04/31] hw/rdma: Return qpn 1 if ibqp is
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Yuval Shaia <yuval.shaia@oracle.com>

Device is not supporting QP0, only QP1.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 86e8fe8ab6..3ccc9a2494 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -33,7 +33,7 @@ static inline union ibv_gid *rdma_backend_gid(RdmaBackendDev *dev)
 
 static inline uint32_t rdma_backend_qpn(const RdmaBackendQP *qp)
 {
-    return qp->ibqp ? qp->ibqp->qp_num : 0;
+    return qp->ibqp ? qp->ibqp->qp_num : 1;
 }
 
 static inline uint32_t rdma_backend_mr_lkey(const RdmaBackendMR *mr)
-- 
2.17.1
