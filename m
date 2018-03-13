Received: from eggs.gnu.org ([2001:4830:134:3::10]:36679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGz-0000zO-T1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evoGv-0008AF-F1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Mar 2018 21:03:14 +0300
Message-Id: <20180313180320.339796-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180313180320.339796-1-vsementsov@virtuozzo.com>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 07/13] migration: include
 migrate_dirty_bitmaps in migrate_postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Enable postcopy if dirty bitmap migration is enabled.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
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
2.11.1
