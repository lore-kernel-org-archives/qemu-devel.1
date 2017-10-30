Received: from eggs.gnu.org ([2001:4830:134:3::10]:52833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988A-0005Pd-Tk
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e9889-0007kY-Uq
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e9889-0007jy-Ol
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D79FC79706
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 11:21:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 30 Oct 2017 12:21:08 +0100
Message-Id: <20171030112112.6952-3-quintela@redhat.com>
In-Reply-To: <20171030112112.6952-1-quintela@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] migration: print features as on off
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
---
 migration/migration.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4de3b551fe..706d2407ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2375,10 +2375,15 @@ void migration_global_dump(Monitor *mon)
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
2.13.6
