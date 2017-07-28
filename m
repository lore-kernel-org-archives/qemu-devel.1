Received: from eggs.gnu.org ([2001:4830:134:3::10]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0IS-0000Tm-Q3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0IR-0000qo-UG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0IR-0000qP-Nv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:06:55 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:11 +0800
Message-Id: <1501229198-30588-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 02/29] migration: fix comment disorder in RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Comments for "migration_dirty_pages" and "bitmap_mutex" are switched.
Fix it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index c93973c..c12358d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -222,9 +222,9 @@ struct RAMState {
     uint64_t iterations_prev;
     /* Iterations since start */
     uint64_t iterations;
-    /* protects modification of the bitmap */
-    uint64_t migration_dirty_pages;
     /* number of dirty bits in the bitmap */
+    uint64_t migration_dirty_pages;
+    /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* The RAMBlock used in the last src_page_requests */
     RAMBlock *last_req_rb;
-- 
2.7.4
