Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68J-0001Ms-SD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68J-0006sc-05
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68I-0006sR-Qo
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:54 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E984AC00AFF8
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:54 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhV0020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:54 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:39 +0000
Message-Id: <20170124184742.1639-13-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] migration: Change name of live migration
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pankaj Gupta <pagupta@redhat.com>

Change the name of live migration thread from 'migration'
to 'live_migration' to identify it clearly. 'migration'
is a generic word and kernel also has  tasks for process
migration with the name 'migration/cpu#'.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Message-Id: <1485178976-15225-1-git-send-email-pagupta@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index f8a4500..2766d2f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2024,7 +2024,7 @@ void migrate_fd_connect(MigrationState *s)
     }
 
     migrate_compress_threads_create();
-    qemu_thread_create(&s->thread, "migration", migration_thread, s,
+    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
 }
-- 
2.9.3
