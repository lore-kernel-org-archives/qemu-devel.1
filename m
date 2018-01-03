Received: from eggs.gnu.org ([2001:4830:134:3::10]:56635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi23-0006cm-K6
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi22-0001zq-Ox
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi22-0001yx-It
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD361693C8
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:29 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:07 +0800
Message-Id: <20180103122017.14794-4-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/13] migration: remove "enable_colo" var
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

It's only used once, clean it up a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2c2140006c..9ba96ae301 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2177,7 +2177,6 @@ static void *migration_thread(void *opaque)
     bool entered_postcopy = false;
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
     enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
-    bool enable_colo = migrate_colo_enabled();
 
     rcu_register_thread();
 
@@ -2309,7 +2308,7 @@ static void *migration_thread(void *opaque)
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
