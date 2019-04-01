Received: from eggs.gnu.org ([209.51.188.92]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAsHj-0003gM-HL
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hAsHh-0002NY-5S
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:27:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hAsHf-0002MH-Uq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 04:27:13 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3so4376867pga.6
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 01:27:10 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Mon,  1 Apr 2019 13:56:54 +0530
Message-Id: <20190401082655.8272-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel] [PATCH 1/2] Header cleanups
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

Declarations were moved out of qemu-common.h for functions declared in utils/ files.
This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 include/qemu-common.h        | 6 ------
 include/qemu/id.h            | 3 +++
 include/qemu/iov.h           | 6 ++++++
 include/qemu/readline.h      | 2 ++
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
 util/hexdump.c               | 2 +-
 util/id.c                    | 1 -
 util/iohandler.c             | 1 -
 util/iov.c                   | 1 -
 util/log.c                   | 1 -
 util/module.c                | 1 -
 util/notify.c                | 1 -
 util/qemu-coroutine-io.c     | 1 -
 util/qemu-coroutine.c        | 1 -
 util/qemu-openpty.c          | 2 +-
 util/qemu-option.c           | 1 -
 util/qemu-progress.c         | 2 +-
 util/qemu-thread-win32.c     | 1 -
 util/rcu.c                   | 1 -
 util/readline.c              | 1 -
 util/thread-pool.c           | 1 -
 util/uuid.c                  | 1 -
 37 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index a102245519..9543c469b6 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -141,12 +141,6 @@ int os_parse_cmd_args(int index, const char *optarg);
 
 #include "qemu/module.h"
 
-/*
- * Hexdump a buffer to a file. An optional string prefix is added to every line
- */
-
-void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
-
 /*
  * helper to parse debug environment variables
  */
diff --git a/include/qemu/id.h b/include/qemu/id.h
index 40c70103e4..3a651fb9d2 100644
--- a/include/qemu/id.h
+++ b/include/qemu/id.h
@@ -1,6 +1,9 @@
 #ifndef QEMU_ID_H
 #define QEMU_ID_H
 
+#define qemu_isalnum(c)		isalnum((unsigned char)(c))
+#define qemu_isalpha(c)		isalpha((unsigned char)(c))
+
 typedef enum IdSubSystems {
     ID_QDEV,
     ID_BLOCK,
diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 48b45987b7..84a4007165 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -108,6 +108,12 @@ ssize_t iov_send_recv(int sockfd, const struct iovec *iov, unsigned iov_cnt,
 void iov_hexdump(const struct iovec *iov, const unsigned int iov_cnt,
                  FILE *fp, const char *prefix, size_t limit);
 
+/*
+ * Hexdump a buffer to a file. An optional string prefix is added to every line
+ */
+void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
+
+
 /*
  * Partial copy of vector from iov to dst_iov (data is not copied).
  * dst_iov overlaps iov at a specified offset.
diff --git a/include/qemu/readline.h b/include/qemu/readline.h
index e81258322b..4cbf7ead5a 100644
--- a/include/qemu/readline.h
+++ b/include/qemu/readline.h
@@ -1,6 +1,8 @@
 #ifndef READLINE_H
 #define READLINE_H
 
+#define qemu_isspace(c)		isspace((unsigned char)(c))
+
 #define READLINE_CMD_BUF_SIZE 4095
 #define READLINE_MAX_CMDS 64
 #define READLINE_MAX_COMPLETIONS 256
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
diff --git a/util/hexdump.c b/util/hexdump.c
index f879ff0ad6..4917696a08 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/hexdump.h"
 
 void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size)
 {
diff --git a/util/id.c b/util/id.c
index 6141352955..834bb4ecd1 100644
--- a/util/id.c
+++ b/util/id.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/id.h"
 
 bool id_wellformed(const char *id)
diff --git a/util/iohandler.c b/util/iohandler.c
index 623b55b9ec..bece8825dc 100644
--- a/util/iohandler.c
+++ b/util/iohandler.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "block/aio.h"
 #include "qemu/main-loop.h"
diff --git a/util/iov.c b/util/iov.c
index 74e6ca8ed7..41434beaca 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -17,7 +17,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/iov.h"
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
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..07642e6cc6 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -33,7 +33,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/qemu-openpty.h"
 
 #if defined(__GLIBC__)
 # include <pty.h>
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
diff --git a/util/qemu-progress.c b/util/qemu-progress.c
index 3c2223c1a2..ad355f9241 100644
--- a/util/qemu-progress.c
+++ b/util/qemu-progress.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/qemu-progress.h"
 
 struct progress_state {
     float current;
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
diff --git a/util/readline.c b/util/readline.c
index ec91ee0fea..f3d8b0698a 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/readline.h"
 #include "qemu/cutils.h"
 
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
