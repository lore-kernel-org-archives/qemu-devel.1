Received: from eggs.gnu.org ([2001:4830:134:3::10]:41694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMR-0001ds-K4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fEVMM-0007qL-TS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fEVMM-0007pA-PJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:42:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  4 May 2018 15:42:04 +0800
Message-Id: <20180504074207.22634-2-famz@redhat.com>
In-Reply-To: <20180504074207.22634-1-famz@redhat.com>
References: <20180504074207.22634-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 1/4] qapi: Introduce UsernetTcpState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, berrange@redhat.com, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

This will be a drop-in replacement for the current TCPS_ macro/enum and
what we will return to users in the coming qmp command.

The next patch will drop TCPS_ to avoid duplication and keep further
refactoring simple.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qapi/net.json | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/qapi/net.json b/qapi/net.json
index 9117c56972..fcddce62d6 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -689,3 +689,37 @@
 ##
 { 'event': 'NIC_RX_FILTER_CHANGED',
   'data': { '*name': 'str', 'path': 'str' } }
+
+##
+# @UsernetTcpState:
+#
+# TCP States of a SLIRP connection.
+#
+# - States where connections are not established: none, closed, listen, syn-sent,
+#   syn-received
+#
+# - States where user has closed: fin-wait-1, closing, last-ack, fin-wait-2,
+#   time-wait
+#
+# - States awaiting ACK of FIN: fin-wait-1, closing, last-ack
+#
+# 'none' state is used only when host forwarding
+#
+# Since 2.13
+#
+##
+{ 'enum': 'UsernetTcpState',
+  'data':
+   ['closed',
+    'listen',
+    'syn-sent',
+    'syn-received',
+    'established',
+    'close-wait',
+    'fin-wait-1',
+    'closing',
+    'last-ack',
+    'fin-wait-2',
+    'time-wait',
+    'none'
+   ] }
-- 
2.14.3
