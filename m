Received: from eggs.gnu.org ([2001:4830:134:3::10]:33206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO1o-0008VH-JC
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO1n-0001Y6-A9
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:21:52 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43282)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO1m-0001XH-Sf
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:21:51 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:21:35 +0300
Message-ID: <151299849551.4808.6986816612829228878.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 03/46] windbg: modified windbgkd.h
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

Added useful name arrays of some defines. Not used yet. Needs for the future.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgkd.h |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/exec/windbgkd.h b/include/exec/windbgkd.h
index b8f98925e7..5008cbb729 100755
--- a/include/exec/windbgkd.h
+++ b/include/exec/windbgkd.h
@@ -870,4 +870,87 @@ typedef struct _DBGKD_TRACE_IO {
    } u;
 } DBGKD_TRACE_IO, *PDBGKD_TRACE_IO;
 
+__attribute__ ((unused)) /* maybe unused */
+static const char *kd_api_names[] = {
+    "DbgKdReadVirtualMemoryApi",
+    "DbgKdWriteVirtualMemoryApi",
+    "DbgKdGetContextApi",
+    "DbgKdSetContextApi",
+    "DbgKdWriteBreakPointApi",
+    "DbgKdRestoreBreakPointApi",
+    "DbgKdContinueApi",
+    "DbgKdReadControlSpaceApi",
+    "DbgKdWriteControlSpaceApi",
+    "DbgKdReadIoSpaceApi",
+    "DbgKdWriteIoSpaceApi",
+    "DbgKdRebootApi",
+    "DbgKdContinueApi2",
+    "DbgKdReadPhysicalMemoryApi",
+    "DbgKdWritePhysicalMemoryApi",
+    "DbgKdQuerySpecialCallsApi",
+    "DbgKdSetSpecialCallApi",
+    "DbgKdClearSpecialCallsApi",
+    "DbgKdSetInternalBreakPointApi",
+    "DbgKdGetInternalBreakPointApi",
+    "DbgKdReadIoSpaceExtendedApi",
+    "DbgKdWriteIoSpaceExtendedApi",
+    "DbgKdGetVersionApi",
+    "DbgKdWriteBreakPointExApi",
+    "DbgKdRestoreBreakPointExApi",
+    "DbgKdCauseBugCheckApi",
+    "",
+    "",
+    "",
+    "",
+    "",
+    "",
+    "DbgKdSwitchProcessor",
+    "DbgKdPageInApi",
+    "DbgKdReadMachineSpecificRegister",
+    "DbgKdWriteMachineSpecificRegister",
+    "OldVlm1",
+    "OldVlm2",
+    "DbgKdSearchMemoryApi",
+    "DbgKdGetBusDataApi",
+    "DbgKdSetBusDataApi",
+    "DbgKdCheckLowMemoryApi",
+    "DbgKdClearAllInternalBreakpointsApi",
+    "DbgKdFillMemoryApi",
+    "DbgKdQueryMemoryApi",
+    "DbgKdSwitchPartition",
+    "DbgKdUnknownApi"
+};
+
+__attribute__ ((unused)) /* maybe unused */
+static const char *kd_packet_type_names[] = {
+    "PACKET_TYPE_UNUSED",
+    "PACKET_TYPE_KD_STATE_CHANGE32",
+    "PACKET_TYPE_KD_STATE_MANIPULATE",
+    "PACKET_TYPE_KD_DEBUG_IO",
+    "PACKET_TYPE_KD_ACKNOWLEDGE",
+    "PACKET_TYPE_KD_RESEND",
+    "PACKET_TYPE_KD_RESET",
+    "PACKET_TYPE_KD_STATE_CHANGE64",
+    "PACKET_TYPE_KD_POLL_BREAKIN",
+    "PACKET_TYPE_KD_TRACE_IO",
+    "PACKET_TYPE_KD_CONTROL_REQUEST",
+    "PACKET_TYPE_KD_FILE_IO",
+    "PACKET_TYPE_MAX"
+};
+
+#define KD_API_NAME(id) ({                                                  \
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(kd_api_names) ==                           \
+                      DbgKdMaximumManipulate - DbgKdMinimumManipulate + 2); \
+    (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate) ?         \
+        kd_api_names[id - DbgKdMinimumManipulate] :                         \
+        kd_api_names[DbgKdMaximumManipulate - DbgKdMinimumManipulate];      \
+})
+
+#define KD_PKT_TYPE_NAME(id) ({                                             \
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(kd_packet_type_names) == PACKET_TYPE_MAX); \
+    (id >= 0 && id < PACKET_TYPE_MAX) ?                                     \
+        kd_packet_type_names[id] :                                          \
+        kd_packet_type_names[PACKET_TYPE_MAX - 1];                          \
+})
+
 #endif
