Received: from eggs.gnu.org ([2001:4830:134:3::10]:59130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gOMCs-0004Ls-Gj
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 07:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gOMCm-00089Y-Rq
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 07:29:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gOMCk-00088x-Ve
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 07:29:36 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 18 Nov 2018 14:28:27 +0200
Message-Id: <20181118122843.10892-8-yuval.shaia@oracle.com>
In-Reply-To: <20181118122843.10892-1-yuval.shaia@oracle.com>
References: <20181118122843.10892-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v4 07/23] hw/pvrdma: Make default pkey 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Commit 6e7dba23af ("hw/pvrdma: Make default pkey 0xFFFF") exports
default pkey as external definition but omit the change from 0x7FFF to
0xFFFF.

Fixes: 6e7dba23af ("hw/pvrdma: Make default pkey 0xFFFF")

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index e3742d893a..15c3f28b86 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -52,7 +52,7 @@
 #define PVRDMA_FW_VERSION    14
 
 /* Some defaults */
-#define PVRDMA_PKEY          0x7FFF
+#define PVRDMA_PKEY          0xFFFF
 
 typedef struct DSRInfo {
     dma_addr_t dma;
-- 
2.17.2
