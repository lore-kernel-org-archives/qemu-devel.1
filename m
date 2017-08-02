Received: from eggs.gnu.org ([2001:4830:134:3::10]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcuBV-0002Mm-09
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcuBS-0005rj-0w
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcuBR-0005r1-Qw
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B95694A6E8
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 13:59:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  2 Aug 2017 14:58:33 +0100
Message-Id: <20170802135834.1455-3-dgilbert@redhat.com>
In-Reply-To: <20170802135834.1455-1-dgilbert@redhat.com>
References: <20170802135834.1455-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] migration: fix comment disorder in RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com

From: Peter Xu <peterx@redhat.com>

Comments for "migration_dirty_pages" and "bitmap_mutex" are switched.
Fix it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1501666880-10159-2-git-send-email-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1b08296d1b..e18b3e2d4f 100644
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
2.13.3
