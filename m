Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3LN-0007xk-6Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3LM-0003r1-FM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3LM-0003qd-99
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 676A1C04B925
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:54:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:53:08 +0100
Message-Id: <20180115115309.23982-27-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 26/27] migration: remove some
 block_cleanup_parameters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Keep the one in migrate_fd_cleanup() would be enough.  Removing the other
two.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 793fd163f7..47367cffae 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1160,7 +1160,6 @@ void migrate_fd_error(MigrationState *s, const Error *error)
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, error);
     notifier_list_notify(&migration_state_notifiers, s);
-    block_cleanup_parameters(s);
 }
 
 static void migrate_fd_cancel(MigrationState *s)
@@ -1206,7 +1205,6 @@ static void migrate_fd_cancel(MigrationState *s)
             s->block_inactive = false;
         }
     }
-    block_cleanup_parameters(s);
 }
 
 void add_migration_state_change_notifier(Notifier *notify)
-- 
2.14.3
