Received: from eggs.gnu.org ([2001:4830:134:3::10]:37358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq9-0007op-LE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGXq8-0006ci-Up
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGXq8-0006cD-O1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 17:41:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAA5347CB
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 21:41:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 23:40:56 +0200
Message-Id: <20170601214056.30387-5-quintela@redhat.com>
In-Reply-To: <20170601214056.30387-1-quintela@redhat.com>
References: <20170601214056.30387-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] ram: Now POSTCOPY_ACTIVE is the same that
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
---
 migration/migration.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8289544..af4c2cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -538,19 +538,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
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
-        break;
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-        /* Mostly the same as active; TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
         info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
-- 
2.9.4
