Received: from eggs.gnu.org ([2001:4830:134:3::10]:35023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5X-0004dk-8r
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5U-00047t-6F
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44248)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO5T-00047V-UN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:25:40 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:25:24 +0300
Message-ID: <151299872436.4808.2880956635467564369.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 43/46] windbg: added new api functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Added some definitions for new windbg.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgkd.h |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgkd.h b/include/exec/windbgkd.h
index 5008cbb729..aa2b4fdbd9 100755
--- a/include/exec/windbgkd.h
+++ b/include/exec/windbgkd.h
@@ -112,7 +112,10 @@
 #define DbgKdFillMemoryApi                  0x0000315b
 #define DbgKdQueryMemoryApi                 0x0000315c
 #define DbgKdSwitchPartition                0x0000315d
-#define DbgKdMaximumManipulate              0x0000315e
+#define DbgKdWriteCustomBreakpointApi       0x0000315e
+#define DbgKdGetContextExApi                0x0000315f
+#define DbgKdSetContextExApi                0x00003160
+#define DbgKdMaximumManipulate              0x00003161
 
 /*
  * Debug I/O Types
@@ -723,6 +726,20 @@ typedef struct _DBGKD_SWITCH_PARTITION {
     uint32_t Partition;
 } DBGKD_SWITCH_PARTITION;
 
+typedef struct _DBGKD_CONTEXT_EX {
+   uint32_t Offset;
+   uint32_t ByteCount;
+   uint32_t BytesCopied;
+} DBGKD_CONTEXT_EX, *PDBGKD_CONTEXT_EX;
+
+typedef struct _DBGKD_WRITE_CUSTOM_BREAKPOINT {
+   uint64_t BreakPointAddress;
+   uint64_t BreakPointInstruction;
+   uint32_t BreakPointHandle;
+   uint16_t BreakPointInstructionSize;
+   uint16_t BreakPointInstructionAlignment;
+} DBGKD_WRITE_CUSTOM_BREAKPOINT, *PDBGKD_WRITE_CUSTOM_BREAKPOINT;
+
 /*
  * DBGKD Structure for Manipulate
  */
@@ -787,6 +804,8 @@ typedef struct _DBGKD_MANIPULATE_STATE64 {
         DBGKD_FILL_MEMORY FillMemory;
         DBGKD_QUERY_MEMORY QueryMemory;
         DBGKD_SWITCH_PARTITION SwitchPartition;
+        DBGKD_WRITE_CUSTOM_BREAKPOINT WriteCustomBreakpoint;
+        DBGKD_CONTEXT_EX ContextEx;
     } u;
 } DBGKD_MANIPULATE_STATE64, *PDBGKD_MANIPULATE_STATE64;
 
