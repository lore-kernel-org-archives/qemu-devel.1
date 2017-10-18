Received: from eggs.gnu.org ([2001:4830:134:3::10]:49112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liP-00089l-O2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liO-0005Hr-0K
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4liN-0005HA-QG
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3182883BA
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 10:36:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 18 Oct 2017 12:36:24 +0200
Message-Id: <20171018103633.5549-2-quintela@redhat.com>
In-Reply-To: <20171018103633.5549-1-quintela@redhat.com>
References: <20171018103633.5549-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/10] migration: Fix migrate_test_apply for
 multifd parameters
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

They were missing when introduced on the tree

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 98429dc843..fb62a639d8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -865,6 +865,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_block_incremental) {
         dest->block_incremental = params->block_incremental;
     }
+    if (params->has_x_multifd_channels) {
+        dest->x_multifd_channels = params->x_multifd_channels;
+    }
+    if (params->has_x_multifd_page_count) {
+        dest->x_multifd_page_count = params->x_multifd_page_count;
+    }
 }
 
 static void migrate_params_apply(MigrateSetParameters *params)
-- 
2.13.6
