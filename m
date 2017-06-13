Received: from eggs.gnu.org ([2001:4830:134:3::10]:57261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUQ-0001Qj-0g
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiUO-0003SJ-LB
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiUO-0003S8-Ce
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56A157F74B
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:20 +0200
Message-Id: <20170613095120.11373-15-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] migration: Move migration.h to migration/
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/block.c                            | 2 +-
 migration/channel.c                          | 2 +-
 migration/colo-comm.c                        | 2 +-
 migration/colo.c                             | 2 +-
 migration/exec.c                             | 2 +-
 migration/fd.c                               | 2 +-
 migration/migration.c                        | 2 +-
 {include/migration =3D> migration}/migration.h | 0
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
 rename {include/migration =3D> migration}/migration.h (100%)

diff --git a/migration/block.c b/migration/block.c
index 223ecaa..ae06975 100644
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
index 92f6f99..3b7252f 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "channel.h"
 #include "tls.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file-channel.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/migration/colo-comm.c b/migration/colo-comm.c
index 8bfdf68..b61aa19 100644
--- a/migration/colo-comm.c
+++ b/migration/colo-comm.c
@@ -12,7 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/colo.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/migration/colo.c b/migration/colo.c
index 111b715..45e9b46 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -14,7 +14,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu-file-channel.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "qemu-file.h"
 #include "savevm.h"
 #include "migration/colo.h"
diff --git a/migration/exec.c b/migration/exec.c
index fc78eeb..b1de445 100644
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
=20
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
index e824c5f..8ef6d6c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -25,7 +25,7 @@
 #include "ram.h"
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
index 9c41887..c8c4500 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -20,7 +20,7 @@
=20
 #include "qemu-common.h"
 #include "exec/target_page.h"
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
=20
diff --git a/migration/ram.c b/migration/ram.c
index d8b6713..c1b4f4a 100644
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
index e446c6f..c6bc607 100644
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
index 28d00ca..30cda2c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -34,7 +34,7 @@
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
 #include "migration/register.h"
diff --git a/migration/socket.c b/migration/socket.c
index 50dc8d8..757d382 100644
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
=20
 #include "qemu/osdep.h"
 #include "channel.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "tls.h"
 #include "io/channel-tls.h"
 #include "crypto/tlscreds.h"
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 7287c6b..02f05a3 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -14,7 +14,7 @@
 #include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "qemu-file.h"
-#include "migration/migration.h"
+#include "migration.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 377d951..3226e8e 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -12,7 +12,7 @@
=20
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
=20
 #include "qemu-common.h"
-#include "migration/migration.h"
+#include "../migration/migration.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
 #include "../migration/qemu-file.h"
--=20
2.9.4
