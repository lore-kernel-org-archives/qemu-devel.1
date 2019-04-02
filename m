Received: from eggs.gnu.org ([209.51.188.92]:60742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hBIvA-0006Xt-SF
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hBIv2-0003VB-IZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:53:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:39228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hBIuz-00035P-9w
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:53:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id i17so6350140pfo.6
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 05:53:06 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue,  2 Apr 2019 18:22:50 +0530
Message-Id: <20190402125250.10347-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel] [PATCH 3/3] Header cleanups Moved the qemu-hexdump
 declaration from qemu-common.h to qemu/hexdump.h
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

Qemu-hexdump declaration was moved from qemu-common.h to qemu/hexdump.h

Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 hw/dma/pl330.c        | 1 +
 hw/dma/xlnx_dpdma.c   | 1 +
 include/qemu-common.h | 6 ------
 net/colo-compare.c    | 2 +-
 util/hexdump.c        | 2 +-
 util/iov.c            | 2 +-
 6 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index d071049233..6f7c79324d 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -20,6 +20,7 @@
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/hexdump.h"
 
 #ifndef PL330_ERR_DEBUG
 #define PL330_ERR_DEBUG 0
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 077c7da9cc..c937384b54 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/dma/xlnx_dpdma.h"
+#include "qemu/hexdump.h"
 
 #ifndef DEBUG_DPDMA
 #define DEBUG_DPDMA 0
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0066e45a6b..bdd65914b8 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -130,12 +130,6 @@ int os_parse_cmd_args(int index, const char *optarg);
 
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
diff --git a/net/colo-compare.c b/net/colo-compare.c
index bf10526f05..f654ee5713 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "net/net.h"
 #include "net/eth.h"
@@ -31,6 +30,7 @@
 #include "migration/colo.h"
 #include "migration/migration.h"
 #include "util.h"
+#include "qemu/hexdump.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 #define COLO_COMPARE(obj) \
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
diff --git a/util/iov.c b/util/iov.c
index 2f960fc38d..1293f7ad22 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -18,7 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
-#include "qemu-common.h"
+#include "qemu/hexdump.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 
-- 
2.17.1
