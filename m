Received: from eggs.gnu.org ([2001:4830:134:3::10]:59157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmrZ-0004mM-67
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmrV-0000Ol-SU
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gKmrV-0000ON-IR
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:53 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu,  8 Nov 2018 18:07:59 +0200
Message-Id: <20181108160818.5485-4-yuval.shaia@oracle.com>
In-Reply-To: <20181108160818.5485-1-yuval.shaia@oracle.com>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 03/22] hw/rdma: Return qpn 1 if ibqp is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

Device is not supporting QP0, only QP1.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
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
