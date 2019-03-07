Received: from eggs.gnu.org ([209.51.188.92]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLI-0001fP-O2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLH-0004hK-Ps
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLH-0004gr-GV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:23 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:00 -0800
Message-Id: <20190307072100.8197-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 03/37] multi-process: add a
 command line option for debug file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, peter.maydell@linaro.org, richard.henderson@linaro.org, eblake@redhat.com

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Can be used with -d rdebug command options when starting qemu.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 include/qemu/log.h | 1 +
 util/log.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6c..ca6f490 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define LOG_REMOTE_DEBUG   (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/util/log.c b/util/log.c
index c0dbbd4..c746125 100644
--- a/util/log.c
+++ b/util/log.c
@@ -274,6 +274,8 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { LOG_REMOTE_DEBUG, "rdebug",
+      "log remote debug" },
     { 0, NULL, NULL },
 };
 
-- 
1.8.3.1
