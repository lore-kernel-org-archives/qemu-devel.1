Received: from eggs.gnu.org ([208.118.235.92]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPnth-0000Nx-7Z
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gPnsN-0008BC-Fj
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:14:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gPnsN-00085B-7B
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:14:31 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 22 Nov 2018 14:13:41 +0200
Message-Id: <20181122121402.13764-4-yuval.shaia@oracle.com>
In-Reply-To: <20181122121402.13764-1-yuval.shaia@oracle.com>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 03/24] hw/rdma: Return qpn 1 if ibqp is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Device is not supporting QP0, only QP1.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.2
