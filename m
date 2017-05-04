Received: from eggs.gnu.org ([2001:4830:134:3::10]:45394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DGB-0008Qk-3R
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DG7-0000q9-VR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DG7-0000oR-P7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBC7E2D9FDB
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:41:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:52 +0200
Message-Id: <20170504094053.2329-10-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] migration: Move postcopy-ram.h to
 migration/
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

It is internal to migration, not intended for other users.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c                           | 2 +-
 migration/postcopy-ram.c                        | 2 +-
 {include/migration => migration}/postcopy-ram.h | 0
 migration/ram.c                                 | 2 +-
 migration/savevm.c                              | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename {include/migration => migration}/postcopy-ram.h (100%)

diff --git a/migration/migration.c b/migration/migration.c
index 353f272..799952c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -26,7 +26,7 @@
 #include "qemu/sockets.h"
 #include "qemu/rcu.h"
 #include "migration/block.h"
-#include "migration/postcopy-ram.h"
+#include "postcopy-ram.h"
 #include "qemu/thread.h"
 #include "qmp-commands.h"
 #include "trace.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e3f4a37..cdadaf6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -20,7 +20,7 @@
 
 #include "qemu-common.h"
 #include "migration/migration.h"
-#include "migration/postcopy-ram.h"
+#include "postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
diff --git a/include/migration/postcopy-ram.h b/migration/postcopy-ram.h
similarity index 100%
rename from include/migration/postcopy-ram.h
rename to migration/postcopy-ram.h
diff --git a/migration/ram.c b/migration/ram.c
index 1f03469..4918c11 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -36,7 +36,7 @@
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "migration/migration.h"
-#include "migration/postcopy-ram.h"
+#include "postcopy-ram.h"
 #include "exec/address-spaces.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index ff78a89..7668510 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -36,7 +36,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "migration/migration.h"
-#include "migration/postcopy-ram.h"
+#include "postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-- 
2.9.3
