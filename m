Received: from eggs.gnu.org ([2001:4830:134:3::10]:34650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lh-PF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFw-0005mf-SB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFw-0005mM-O1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:48 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:35 -0400
Message-Id: <20180313211441.5179-8-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 07/13] migration: include migrate_dirty_bitmaps
 in migrate_postcopy
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

Enable postcopy if dirty bitmap migration is enabled.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180313180320.339796-8-vsementsov@virtuozzo.com
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e0aff5c814..094196c236 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1508,7 +1508,7 @@ bool migrate_postcopy_ram(void)
 
 bool migrate_postcopy(void)
 {
-    return migrate_postcopy_ram();
+    return migrate_postcopy_ram() || migrate_dirty_bitmaps();
 }
 
 bool migrate_auto_converge(void)
-- 
2.14.3
