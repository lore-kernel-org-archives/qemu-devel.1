Received: from eggs.gnu.org ([2001:4830:134:3::10]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b9-0007oV-6P
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b7-0006Fw-Qm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38b7-0006Ev-Hz
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 885957AEA2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:06:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:48 +0200
Message-Id: <20170425220451.6028-39-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 38/41] migration: Move migration.h to migration/
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

Nothing uses it outside of migration.h

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/block.c                            | 2 +-
 migration/channel.c                          | 2 +-
 migration/colo-comm.c                        | 2 +-
 migration/colo.c                             | 2 +-
 migration/exec.c                             | 2 +-
 migration/fd.c                               | 2 +-
 migration/migration.c                        | 2 +-
 {include/migration => migration}/migration.h | 0
 migration/postcopy-ram.c                     | 2 +-
 migration/qemu-file.c                        | 2 +-
 migration/ram.c                              | 2 +-
 migration/rdma.c                             | 2 +-
 migration/savevm.c                           | 2 +-
 migration/socket.c                           | 2 +-
 migration/tls.c                              | 2 +-
 migration/vmstate-types.c                    | 2 +-
 migration/vmstate.c                          | 2 +-
 tests/test-vmstate.c                         | 2 +-
 18 files changed, 17 insertions(+), 17 deletions(-)
 rename {include/migration => migration}/migration.h (100%)

diff --git a/migration/block.c b/migration/block.c
index 307f136..6457f25 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -25,7 +25,7 @@
 #include "qemu/timer.h"
 #include "block.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/register.h"
 #include "sysemu/blockdev.h"
 #include "qemu-file.h"
diff --git a/migration/channel.c b/migration/channel.c
index 5a81a60..633423c 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "channel.h"
 #include "tls.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file-channel.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index b4288b8..1acdb94 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/vmstate.h"
 #include "colo.h"
 #include "trace.h"
diff --git a/migration/colo.c b/migration/colo.c
index 3757ad9..72001a5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -14,7 +14,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu-file-channel.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file.h"
 #include "migration/savevm.h"
 #include "migration/colo.h"
diff --git a/migration/exec.c b/migration/exec.c
index c532c56..074943a 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -22,7 +22,7 @@
 #include "qemu-common.h"
 #include "channel.h"
 #include "exec.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "io/channel-command.h"
 #include "trace.h"
 
diff --git a/migration/fd.c b/migration/fd.c
index 8a04dcd..b2384bf 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -19,7 +19,7 @@
 #include "qemu-common.h"
 #include "channel.h"
 #include "fd.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "monitor/monitor.h"
 #include "io/channel-util.h"
 #include "trace.h"
diff --git a/migration/migration.c b/migration/migration.c
index 287b762..fccd779 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -25,7 +25,7 @@
 #include "rdma.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
diff --git a/include/migration/migration.h b/migration/migration.h
similarity index 100%
rename from include/migration/migration.h
rename to migration/migration.h
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index cae5d48..bd23971 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file.h"
 #include "savevm.h"
 #include "postcopy-ram.h"
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index ab26f4e..e65c373 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -28,7 +28,7 @@
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
 #include "qemu/coroutine.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file.h"
 #include "trace.h"
 
diff --git a/migration/ram.c b/migration/ram.c
index b6cef70..14104f1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -37,7 +37,7 @@
 #include "qemu/main-loop.h"
 #include "xbzrle.h"
 #include "ram.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/register.h"
 #include "migration/misc.h"
 #include "qemu-file.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index f8fea9b..1d91266 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -18,7 +18,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "rdma.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file.h"
 #include "ram.h"
 #include "qemu-file-channel.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index e7c05f3..03ff007 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -35,7 +35,7 @@
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
 #include "migration/register.h"
diff --git a/migration/socket.c b/migration/socket.c
index acb3f0d..cc3d977 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "channel.h"
 #include "socket.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file.h"
 #include "io/channel-socket.h"
 #include "trace.h"
diff --git a/migration/tls.c b/migration/tls.c
index d3abd6e..596e879 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "channel.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "tls.h"
 #include "io/channel-tls.h"
 #include "crypto/tlscreds.h"
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index c2bd334..0c92b23 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -29,7 +29,7 @@
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "qemu-file.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4b0cb2f..ec9d0f89 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/vmstate.h"
 #include "migration/savevm.h"
 #include "qemu-file.h"
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index f30433a..ee292c7 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
-#include "migration/migration.h"
+#include "../migration/migration.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
 #include "../migration/qemu-file.h"
-- 
2.9.3
