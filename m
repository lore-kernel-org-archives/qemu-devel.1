Received: from eggs.gnu.org ([2001:4830:134:3::10]:38910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9D7-0008As-KP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9D6-0002Af-KY
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:37 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37672)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9D6-00028k-Bc
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:07:36 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:07:33 +0300
Message-ID: <151127325284.6888.645379954526299685.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 03/45] windbg: modified windbgkd.h
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
 include/exec/windbgkd.h |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/exec/windbgkd.h b/include/exec/windbgkd.h
index b8f98925e7..40a23f8cd0 100755
--- a/include/exec/windbgkd.h
+++ b/include/exec/windbgkd.h
@@ -870,4 +870,79 @@ typedef struct _DBGKD_TRACE_IO {
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
+#define KD_API_NAME(id) \
+    (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate) ? \
+        kd_api_names[id - DbgKdMinimumManipulate] : \
+        kd_api_names[DbgKdMaximumManipulate - DbgKdMinimumManipulate] \
+
+#define KD_PKT_TYPE_NAME(id) kd_packet_type_names[id]
+
 #endif
