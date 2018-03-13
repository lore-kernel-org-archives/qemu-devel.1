Received: from eggs.gnu.org ([2001:4830:134:3::10]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFz-0000mY-GQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFy-0005oK-C7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFy-0005o7-84
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:50 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:38 -0400
Message-Id: <20180313211441.5179-11-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 10/13] migration: allow qmp command
 migrate-start-postcopy for any postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Allow migrate-start-postcopy for any postcopy type

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20180313180320.339796-11-vsementsov@virtuozzo.com
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 094196c236..59b4fe6090 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1022,7 +1022,7 @@ void qmp_migrate_start_postcopy(Error **errp)
 {
     MigrationState *s = migrate_get_current();
 
-    if (!migrate_postcopy_ram()) {
+    if (!migrate_postcopy()) {
         error_setg(errp, "Enable postcopy with migrate_set_capability before"
                          " the start of migration");
         return;
-- 
2.14.3
