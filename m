Received: from eggs.gnu.org ([2001:4830:134:3::10]:38322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyl0w-0005y7-B7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eyl0v-000258-GT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 17:11:18 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 21 Mar 2018 23:10:55 +0200
Message-Id: <20180321211056.3339-3-yuval.shaia@oracle.com>
In-Reply-To: <20180321211056.3339-1-yuval.shaia@oracle.com>
References: <20180321211056.3339-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 2/3] hw/rdma: Use correct print format in
 CHK_ATTR macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Macro should not cast the given variable to u64 instead it should use
the supplied format argument (fmt).

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index f1a37ba4a2..0391a7dd95 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -656,8 +656,8 @@ void rdma_backend_destroy_qp(RdmaBackendQP *qp)
 #define CHK_ATTR(req, dev, member, fmt) ({ \
     pr_dbg("%s="fmt","fmt"\n", #member, dev.member, req->member); \
     if (req->member > dev.member) { \
-        warn_report("%s = 0x%lx is higher than host device capability 0x%lx", \
-                    #member, (uint64_t)req->member, (uint64_t)dev.member); \
+        warn_report("%s = "fmt" is higher than host device capability "fmt, \
+                    #member, req->member, dev.member); \
         req->member = dev.member; \
     } \
     pr_dbg("%s="fmt"\n", #member, req->member); })
-- 
2.13.6
