Received: from eggs.gnu.org ([2001:4830:134:3::10]:43756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whX-0003fC-Vk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whU-0006sa-5K
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:59:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0whT-0006sR-Vu
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF31A31F3EC
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 20:59:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:58:35 +0200
Message-Id: <20170419205923.8808-12-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 11/59] ram: Change num_dirty_pages_period type
 to uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/exec/ram_addr.h | 2 +-
 migration/ram.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b05dc84..9aadc5c 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -356,7 +356,7 @@ static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
                                                ram_addr_t start,
                                                ram_addr_t length,
-                                               int64_t *real_dirty_pages)
+                                               uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
diff --git a/migration/ram.c b/migration/ram.c
index d6cf032..9a82355 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -160,7 +160,7 @@ struct RAMState {
     /* bytes transferred at start_time */
     uint64_t bytes_xfer_prev;
     /* number of dirty pages since start_time */
-    int64_t num_dirty_pages_period;
+    uint64_t num_dirty_pages_period;
 };
 typedef struct RAMState RAMState;
 
-- 
2.9.3
