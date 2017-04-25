Received: from eggs.gnu.org ([2001:4830:134:3::10]:55160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aG-000749-4s
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aC-000577-VN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aC-000565-PQ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C32B84E336
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:20 +0200
Message-Id: <20170425220451.6028-11-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/41] migration: Move postcopy-ram.h to
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
---
 migration/migration.c                           | 2 +-
 migration/postcopy-ram.c                        | 2 +-
 {include/migration => migration}/postcopy-ram.h | 0
 migration/ram.c                                 | 2 +-
 migration/savevm.c                              | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename {include/migration => migration}/postcopy-ram.h (100%)

diff --git a/migration/migration.c b/migration/migration.c
index fe30227..fef1f0a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -28,7 +28,7 @@
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
index 47e66f4..5fcf593 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -37,7 +37,7 @@
 #include "qemu/main-loop.h"
 #include "xbzrle.h"
 #include "migration/migration.h"
-#include "migration/postcopy-ram.h"
+#include "postcopy-ram.h"
 #include "exec/address-spaces.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 7a07ea6..1b2a83c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -37,7 +37,7 @@
 #include "qemu/timer.h"
 #include "migration/migration.h"
 #include "qemu-file-channel.h"
-#include "migration/postcopy-ram.h"
+#include "postcopy-ram.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-- 
2.9.3
