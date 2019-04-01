Received: from eggs.gnu.org ([209.51.188.92]:54839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAwEX-0006QE-CW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAwET-0008OG-QU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:40:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hAwEQ-0008Mb-TX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:40:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id bf11so4429297plb.12
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 05:40:05 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Mon,  1 Apr 2019 18:09:45 +0530
Message-Id: <20190401123945.26466-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel] [PATCH] Header cleanups Removed qemu-common.h from
 source files which don't need it contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

Removed unnecessary declaration qemu-common.h from in utils/ files
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
---
 util/aio-posix.c             | 1 -
 util/aio-win32.c             | 1 -
 util/async.c                 | 1 -
 util/bufferiszero.c          | 1 -
 util/compatfd.c              | 1 -
 util/coroutine-sigaltstack.c | 1 -
 util/coroutine-ucontext.c    | 1 -
 util/coroutine-win32.c       | 1 -
 util/crc32c.c                | 1 -
 util/cutils.c                | 1 -
 util/envlist.c               | 1 -
 util/error.c                 | 1 -
 util/event_notifier-posix.c  | 1 -
 util/event_notifier-win32.c  | 1 -
 util/fifo8.c                 | 1 -
 util/getauxval.c             | 1 -
 util/id.c                    | 2 +-
 util/iov.c                   | 2 +-
 util/log.c                   | 1 -
 util/module.c                | 1 -
 util/notify.c                | 1 -
 util/qemu-config.c           | 1 -
 util/qemu-coroutine-io.c     | 1 -
 util/qemu-coroutine-lock.c   | 1 -
 util/qemu-coroutine.c        | 1 -
 util/qemu-option.c           | 1 -
 util/qemu-thread-win32.c     | 1 -
 util/rcu.c                   | 1 -
 util/thread-pool.c           | 1 -
 util/uuid.c                  | 1 -
 30 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6fbfa7924f..e36c76c4e0 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/block.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
diff --git a/util/aio-win32.c b/util/aio-win32.c
index a23b9c364d..f270005422 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -16,7 +16,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/block.h"
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
diff --git a/util/async.c b/util/async.c
index c10642a385..8d2105729c 100644
--- a/util/async.c
+++ b/util/async.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/aio.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 2178d8ab9d..bfb2605466 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 
diff --git a/util/compatfd.c b/util/compatfd.c
index 980bd33e52..c296f55d14 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/thread.h"
 
 #include <sys/syscall.h>
diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
index f6fc49a0e5..7d3ee49943 100644
--- a/util/coroutine-sigaltstack.c
+++ b/util/coroutine-sigaltstack.c
@@ -27,7 +27,6 @@
 #endif
 #include "qemu/osdep.h"
 #include <pthread.h>
-#include "qemu-common.h"
 #include "qemu/coroutine_int.h"
 
 typedef struct {
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 090ba21a13..bd593e61bc 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -24,7 +24,6 @@
 #endif
 #include "qemu/osdep.h"
 #include <ucontext.h>
-#include "qemu-common.h"
 #include "qemu/coroutine_int.h"
 
 #ifdef CONFIG_VALGRIND_H
diff --git a/util/coroutine-win32.c b/util/coroutine-win32.c
index de6bd4fd3e..c196f956d2 100644
--- a/util/coroutine-win32.c
+++ b/util/coroutine-win32.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/coroutine_int.h"
 
 typedef struct
diff --git a/util/crc32c.c b/util/crc32c.c
index 7e99555c16..762657d853 100644
--- a/util/crc32c.c
+++ b/util/crc32c.c
@@ -26,7 +26,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/crc32c.h"
 
 /*
diff --git a/util/cutils.c b/util/cutils.c
index e098debdc0..a157aafa55 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include <math.h>
 
diff --git a/util/envlist.c b/util/envlist.c
index 1eeb7fca87..2bcc13f094 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "qemu/envlist.h"
 
diff --git a/util/error.c b/util/error.c
index 934a78e1b1..dc42e9398f 100644
--- a/util/error.c
+++ b/util/error.c
@@ -14,7 +14,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 
 struct Error
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 73c4046b58..4a379ffe4a 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
diff --git a/util/event_notifier-win32.c b/util/event_notifier-win32.c
index 62c53b0a99..9352da4699 100644
--- a/util/event_notifier-win32.c
+++ b/util/event_notifier-win32.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
 
diff --git a/util/fifo8.c b/util/fifo8.c
index d38b3bdaa5..a9aa20a9f7 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -13,7 +13,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/fifo8.h"
 
 void fifo8_create(Fifo8 *fifo, uint32_t capacity)
diff --git a/util/getauxval.c b/util/getauxval.c
index 0b3bae2dcb..36afdfb9e6 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 
 #ifdef CONFIG_GETAUXVAL
 /* Don't inline this in qemu/osdep.h, because pulling in <sys/auxv.h> for
diff --git a/util/id.c b/util/id.c
index 6141352955..3f8e13bd6f 100644
--- a/util/id.c
+++ b/util/id.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/id.h"
+#include "qemu-common.h"
 
 bool id_wellformed(const char *id)
 {
diff --git a/util/iov.c b/util/iov.c
index 74e6ca8ed7..2f960fc38d 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -17,8 +17,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/iov.h"
+#include "qemu-common.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 
diff --git a/util/log.c b/util/log.c
index c0dbbd4700..1d1b33f7d9 100644
--- a/util/log.c
+++ b/util/log.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
diff --git a/util/module.c b/util/module.c
index 1259dd3686..142db7e911 100644
--- a/util/module.c
+++ b/util/module.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #ifdef CONFIG_MODULES
 #include <gmodule.h>
 #endif
diff --git a/util/notify.c b/util/notify.c
index 06de63a839..aee8d93cb0 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/notify.h"
 
 void notifier_list_init(NotifierList *list)
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 9d2e278e29..772f5a219e 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -4,7 +4,6 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 44a8969a69..9c393bc8a9 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -23,7 +23,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/sockets.h"
 #include "qemu/coroutine.h"
 #include "qemu/iov.h"
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 27438a1858..5da5234155 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -27,7 +27,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/processor.h"
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 2295928d33..c3caa6c770 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -14,7 +14,6 @@
 
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/coroutine.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index ef60af70fc..97172b5eaa 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 572f88535d..d176943a27 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -12,7 +12,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
diff --git a/util/rcu.c b/util/rcu.c
index 5676c22bd1..177a675619 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -27,7 +27,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/rcu.h"
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d131..4ed9b89ab2 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -15,7 +15,6 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
diff --git a/util/uuid.c b/util/uuid.c
index 5787f0978c..b1108dde78 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/uuid.h"
 #include "qemu/bswap.h"
 
-- 
2.17.1
