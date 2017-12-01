Received: from eggs.gnu.org ([2001:4830:134:3::10]:54276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoIp-0004dh-Bu
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoIo-0002rn-2L
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoIn-0002r4-Se
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62F4061D0E
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:57:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:57:27 +0100
Message-Id: <20171201125728.1310-3-quintela@redhat.com>
In-Reply-To: <20171201125728.1310-1-quintela@redhat.com>
References: <20171201125728.1310-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] migration: print features as on off
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

Once there, do one thing for line

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8d2372394c..19917a4b5b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2366,10 +2366,15 @@ void migration_global_dump(Monitor *mon)
 {
     MigrationState *ms = migrate_get_current();
 
-    monitor_printf(mon, "globals: store-global-state=%d, only_migratable=%d, "
-                   "send-configuration=%d, send-section-footer=%d\n",
-                   ms->store_global_state, ms->only_migratable,
-                   ms->send_configuration, ms->send_section_footer);
+    monitor_printf(mon, "globals:\n");
+    monitor_printf(mon, "store-global-state: %s\n",
+                   ms->store_global_state ? "on" : "off");
+    monitor_printf(mon, "only-migratable: %s\n",
+                   ms->only_migratable ? "on" : "off");
+    monitor_printf(mon, "send-configuration: %s\n",
+                   ms->send_configuration ? "on" : "off");
+    monitor_printf(mon, "send-section-footer: %s\n",
+                   ms->send_section_footer ? "on" : "off");
 }
 
 #define DEFINE_PROP_MIG_CAP(name, x)             \
-- 
2.14.3
