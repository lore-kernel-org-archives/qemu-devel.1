Received: from eggs.gnu.org ([2001:4830:134:3::10]:56880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2S-00070a-AQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi2Q-0002S2-5I
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi2P-0002R8-Ul
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B5B261B8F
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:16 +0800
Message-Id: <20180103122017.14794-13-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/13] migration: remove some
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
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Keep the one in migrate_fd_cancel() would be enough.  Removing the other
two.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 16eb24c8b3..fbb41b8887 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1130,7 +1130,6 @@ void migrate_fd_error(MigrationState *s, const Error *error)
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, error);
     notifier_list_notify(&migration_state_notifiers, s);
-    block_cleanup_parameters(s);
 }
 
 static void migrate_fd_cancel(MigrationState *s)
@@ -1176,7 +1175,6 @@ static void migrate_fd_cancel(MigrationState *s)
             s->block_inactive = false;
         }
     }
-    block_cleanup_parameters(s);
 }
 
 void add_migration_state_change_notifier(Notifier *notify)
-- 
2.14.3
