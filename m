Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVV-0006nG-FX
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVU-0006vh-L1
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVU-0006ui-Ez
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D2AB2DD783
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:38:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:22 +0100
Message-Id: <20180103093834.20879-3-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] migration: print features as on off
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
