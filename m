Received: from eggs.gnu.org ([2001:4830:134:3::10]:49907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3L0-0007d6-CT
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kz-0003dq-M9
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3Kz-0003dS-Gv
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DF8C7F755
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:54:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:52:59 +0100
Message-Id: <20180115115309.23982-18-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 17/27] migration: remove "enable_colo" var
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

It's only used once, clean it up a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 02d8bc07b1..0b513c2020 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2216,7 +2216,6 @@ static void *migration_thread(void *opaque)
     bool entered_postcopy = false;
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
     enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
-    bool enable_colo = migrate_colo_enabled();
 
     rcu_register_thread();
 
@@ -2348,7 +2347,7 @@ static void *migration_thread(void *opaque)
              * We should really assert here, but since it's during
              * migration, let's try to reduce the usage of assertions.
              */
-            if (!enable_colo) {
+            if (!migrate_colo_enabled()) {
                 error_report("%s: critical error: calling COLO code without "
                              "COLO enabled", __func__);
             }
-- 
2.14.3
