Received: from eggs.gnu.org ([2001:4830:134:3::10]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpd-0006CC-67
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpc-0004VY-Cr
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Cpc-0004U8-7r
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 267818047E
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:01:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:36 +0200
Message-Id: <20170417200041.2451-15-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 14/19] migration: Remove vmstate.h from
 migration.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 1 -
 migration/block.c             | 1 +
 migration/colo-comm.c         | 1 +
 migration/migration.c         | 1 +
 migration/ram.c               | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3353de1..1451067 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -17,7 +17,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
-#include "migration/vmstate.h"
 #include "qapi-types.h"
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
diff --git a/migration/block.c b/migration/block.c
index e45a42d..3048088 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -20,6 +20,7 @@
 #include "migration/block.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "sysemu/block-backend.h"
 
 #define BLOCK_SIZE                       (1 << 20)
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 4161242..f11fa81 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/migration.h"
+#include "migration/vmstate.h"
 #include "migration/colo.h"
 
 typedef struct {
diff --git a/migration/migration.c b/migration/migration.c
index 9990c46..c2c25fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -25,6 +25,7 @@
 #include "migration/socket.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "block/block.h"
 #include "qapi/qmp/qerror.h"
diff --git a/migration/ram.c b/migration/ram.c
index b0759ac..49e518f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -38,6 +38,7 @@
 #include "migration/init.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "migration/vmstate.h"
 #include "migration/postcopy-ram.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
-- 
2.9.3
