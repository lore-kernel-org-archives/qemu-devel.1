Received: from eggs.gnu.org ([208.118.235.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd5-0003uc-Ou
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd1-0005dH-8M
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:49:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Dec 2017 18:49:39 +0300
Message-Id: <20171220154945.88410-8-vsementsov@virtuozzo.com>
In-Reply-To: <20171220154945.88410-1-vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 07/13] migration: include
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
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1526cd4bff..e973837bfd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1487,7 +1487,7 @@ bool migrate_postcopy_ram(void)
 
 bool migrate_postcopy(void)
 {
-    return migrate_postcopy_ram();
+    return migrate_postcopy_ram() || migrate_dirty_bitmaps();
 }
 
 bool migrate_auto_converge(void)
-- 
2.11.1
