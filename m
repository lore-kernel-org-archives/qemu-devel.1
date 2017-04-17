Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpb-0006AX-8A
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpa-0004Ts-GQ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Cpa-0004TO-7w
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 237DEA794
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:01:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:35 +0200
Message-Id: <20170417200041.2451-14-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 13/19] migration: Remove qemu-file.h from
 vmstate.h
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
 include/hw/hw.h             | 1 +
 include/migration/vmstate.h | 3 ---
 migration/block.c           | 1 +
 migration/channel.c         | 1 +
 migration/colo.c            | 1 +
 migration/postcopy-ram.c    | 1 +
 migration/ram.c             | 1 +
 7 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/hw.h b/include/hw/hw.h
index e22d4ce..af9eae1 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -11,6 +11,7 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "migration/qemu-file.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f4c5bed..1e6fcb5 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,9 +27,6 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
-#ifndef CONFIG_USER_ONLY
-#include "migration/qemu-file.h"
-#endif
 #include "migration/qjson.h"
 
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
diff --git a/migration/block.c b/migration/block.c
index 0722837..e45a42d 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -19,6 +19,7 @@
 #include "qemu/cutils.h"
 #include "migration/block.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "sysemu/block-backend.h"
 
 #define BLOCK_SIZE                       (1 << 20)
diff --git a/migration/channel.c b/migration/channel.c
index 10416e0..04a26c5 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -17,6 +17,7 @@
 #include "migration/channel.h"
 #include "migration/tls.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "io/channel-tls.h"
diff --git a/migration/colo.c b/migration/colo.c
index d455884..e2eaccd 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "migration/colo.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 11b24c6..5aea2ff 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "migration/postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
diff --git a/migration/ram.c b/migration/ram.c
index 4f49622..b0759ac 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -37,6 +37,7 @@
 #include "migration/xbzrle.h"
 #include "migration/init.h"
 #include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "migration/postcopy-ram.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
-- 
2.9.3
