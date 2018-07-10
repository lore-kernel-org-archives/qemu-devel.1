Received: from eggs.gnu.org ([2001:4830:134:3::10]:40834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub1-0003Aw-IK
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub0-0003ON-NE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34020 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcub0-0003O7-IY
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34AB54023132
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:09 +0100
Message-Id: <20180710153016.131258-9-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] migration: show pause/recover state on
 dst host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

These two states will be missing when doing "query-migrate" on
destination VM.  Add these states so that we can get the query results
as expected.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-5-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 0404c53215..8d56d56930 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -911,6 +911,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_COLO:
         info->has_status = true;
-- 
2.17.1
