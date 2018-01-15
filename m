Received: from eggs.gnu.org ([2001:4830:134:3::10]:50140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3LT-00084s-VU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3LT-0003v4-9F
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3LT-0003uk-4G
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23BC15D5EA
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:54:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:53:09 +0100
Message-Id: <20180115115309.23982-28-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 27/27] migration: remove notify in fd_error
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

It is already called in migrate_fd_cleanup.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 47367cffae..d3a1c494c0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1159,7 +1159,6 @@ void migrate_fd_error(MigrationState *s, const Error *error)
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_FAILED);
     migrate_set_error(s, error);
-    notifier_list_notify(&migration_state_notifiers, s);
 }
 
 static void migrate_fd_cancel(MigrationState *s)
-- 
2.14.3
