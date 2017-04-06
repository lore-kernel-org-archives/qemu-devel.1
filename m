Received: from eggs.gnu.org ([2001:4830:134:3::10]:50030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AL-0005UH-Hh
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7AI-00082a-FX
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7AI-00082G-9U
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:09:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 652E364DAA
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:09:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:28 +0200
Message-Id: <20170406130913.2232-10-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 09/54] ram: Change byte_xfer_now type to
 uint64_t
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
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aeef563..d13674f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -158,7 +158,7 @@ struct RAMState {
     /* last time we did a full bitmap_sync */
     int64_t time_last_bitmap_sync;
     /* bytes transferred at start_time */
-    int64_t bytes_xfer_prev;
+    uint64_t bytes_xfer_prev;
 };
 typedef struct RAMState RAMState;
 
@@ -660,7 +660,7 @@ static void migration_bitmap_sync(RAMState *rs)
     RAMBlock *block;
     MigrationState *s = migrate_get_current();
     int64_t end_time;
-    int64_t bytes_xfer_now;
+    uint64_t bytes_xfer_now;
 
     rs->bitmap_sync_count++;
 
-- 
2.9.3
