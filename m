Received: from eggs.gnu.org ([2001:4830:134:3::10]:52493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcq9w-0006Rh-10
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcq9m-0004hy-9W
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:41:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcq9l-0004dX-Gu
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B9DA356C2
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 09:41:32 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 Aug 2017 17:41:19 +0800
Message-Id: <1501666880-10159-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1501666880-10159-1-git-send-email-peterx@redhat.com>
References: <1501666880-10159-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] migration: fix comment disorder in
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Comments for "migration_dirty_pages" and "bitmap_mutex" are switched.
Fix it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1b08296..e18b3e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -188,9 +188,9 @@ struct RAMState {
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
