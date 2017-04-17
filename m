Received: from eggs.gnu.org ([2001:4830:134:3::10]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Cpd-0006CY-Ez
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpZ-0004TD-7v
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpY-0004Sm-Ua
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC1102DC342
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:34 +0200
Message-Id: <20170417200041.2451-13-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/19] migration: Remove unneeded includes
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

I just removed includes that allow me to still compile everything.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/colo.h  | 3 ---
 migration/block.c         | 7 -------
 migration/colo-comm.c     | 1 -
 migration/colo-failover.c | 1 +
 migration/colo.c          | 2 --
 migration/exec.c          | 1 -
 migration/fd.c            | 1 -
 migration/migration.c     | 5 -----
 migration/postcopy-ram.c  | 2 --
 migration/qemu-file.c     | 4 +---
 migration/ram.c           | 2 --
 migration/rdma.c          | 1 -
 migration/savevm.c        | 5 -----
 13 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index ba0bb6e..be6beba 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -14,9 +14,6 @@
 #define QEMU_COLO_H
 
 #include "qemu-common.h"
-#include "qemu/coroutine_int.h"
-#include "qemu/thread.h"
-#include "qemu/main-loop.h"
 
 bool colo_supported(void);
 void colo_info_init(void);
diff --git a/migration/block.c b/migration/block.c
index 9490343..0722837 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -15,17 +15,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
-#include "block/block.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
-#include "hw/hw.h"
 #include "qemu/cutils.h"
-#include "qemu/queue.h"
-#include "qemu/timer.h"
 #include "migration/block.h"
 #include "migration/migration.h"
-#include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 
 #define BLOCK_SIZE                       (1 << 20)
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 3d91798..4161242 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "migration/migration.h"
 #include "migration/colo.h"
-#include "trace.h"
 
 typedef struct {
      bool colo_requested;
diff --git a/migration/colo-failover.c b/migration/colo-failover.c
index cc229f5..1c0025b 100644
--- a/migration/colo-failover.c
+++ b/migration/colo-failover.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "migration/colo.h"
 #include "migration/failover.h"
 #include "qmp-commands.h"
diff --git a/migration/colo.c b/migration/colo.c
index 2924602..d455884 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -11,14 +11,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "migration/migration.h"
 #include "migration/colo.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
 #include "qemu/error-report.h"
-#include "qapi/error.h"
 #include "migration/failover.h"
 #include "replication.h"
 #include "qmp-commands.h"
diff --git a/migration/exec.c b/migration/exec.c
index 1a2d5c2..7939c95 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "migration/channel.h"
 #include "migration/exec.h"
 #include "io/channel-command.h"
diff --git a/migration/fd.c b/migration/fd.c
index 78ebd5b..ae41b06 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -16,7 +16,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "migration/channel.h"
 #include "migration/fd.h"
 #include "monitor/monitor.h"
diff --git a/migration/migration.c b/migration/migration.c
index 9ab66b6..9990c46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "migration/blocker.h"
 #include "migration/machine.h"
 #include "migration/state.h"
@@ -30,7 +29,6 @@
 #include "block/block.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/util.h"
-#include "qemu/sockets.h"
 #include "qemu/rcu.h"
 #include "migration/block.h"
 #include "migration/postcopy-ram.h"
@@ -38,9 +36,6 @@
 #include "qmp-commands.h"
 #include "trace.h"
 #include "qapi-event.h"
-#include "qom/cpu.h"
-#include "exec/memory.h"
-#include "exec/address-spaces.h"
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 85fd8d7..11b24c6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -17,8 +17,6 @@
  */
 
 #include "qemu/osdep.h"
-
-#include "qemu-common.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
 #include "sysemu/sysemu.h"
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 195fa94..460e536 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -26,10 +26,8 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
-#include "qemu/sockets.h"
-#include "qemu/coroutine.h"
-#include "migration/migration.h"
 #include "migration/qemu-file.h"
+#include "migration/migration.h"
 #include "trace.h"
 
 #define IO_BUF_SIZE 32768
diff --git a/migration/ram.c b/migration/ram.c
index 1bd8599..4f49622 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,13 +33,11 @@
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
-#include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "migration/xbzrle.h"
 #include "migration/init.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
-#include "exec/address-spaces.h"
 #include "migration/page_cache.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index 674ccab..94d4840 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -19,7 +19,6 @@
 #include "qemu/cutils.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
-#include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 96cf6db..b03973a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -29,13 +29,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/boards.h"
-#include "hw/hw.h"
-#include "hw/qdev.h"
 #include "hw/xen/xen.h"
 #include "net/net.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
-#include "qemu/timer.h"
 #include "audio/audio.h"
 #include "migration/machine.h"
 #include "migration/migration.h"
@@ -43,11 +40,9 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "qemu/queue.h"
 #include "sysemu/cpus.h"
 #include "qmp-commands.h"
 #include "trace.h"
-#include "qemu/bitops.h"
 #include "qemu/iov.h"
 #include "block/snapshot.h"
 #include "block/qapi.h"
-- 
2.9.3
