Received: from eggs.gnu.org ([2001:4830:134:3::10]:57049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU2-00015J-Fr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU1-0003Ju-Qp
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiU1-0003Jn-Kw
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A0B17F74B
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:10 +0200
Message-Id: <20170613095120.11373-5-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] ram: Now POSTCOPY_ACTIVE is the same that
 STATUS_ACTIVE
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

Merge them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/migration.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2f5f270..b23dfd3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -653,20 +653,8 @@ MigrationInfo *qmp_query_migrate(Error **errp)
         break;
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
-        info->has_status = true;
-        info->has_total_time = true;
-        info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
-            - s->total_time;
-        info->has_expected_downtime = true;
-        info->expected_downtime = s->expected_downtime;
-        info->has_setup_time = true;
-        info->setup_time = s->setup_time;
-
-        populate_ram_info(info, s);
-        populate_disk_info(info);
-        break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-        /* Mostly the same as active; TODO add some postcopy stats */
+         /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
         info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
-- 
2.9.4
