Received: from eggs.gnu.org ([2001:4830:134:3::10]:56900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8ZiC-0002vw-Pq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8ZiB-00080p-VB
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:39:59 +0200
Message-Id: <20181005234023.8104-8-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 07/31] iotests.py: Add node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This function queries a node; since we cannot do that right now, it
executes query-named-block-nodes and returns the matching node's object.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5c45788dac..604f200600 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -465,6 +465,13 @@ class VM(qtest.QEMUQtestMachine):
                 else:
                     iotests.log(ev)
 
+    def node_info(self, node_name):
+        nodes = self.qmp('query-named-block-nodes')
+        for x in nodes['return']:
+            if x['node-name'] == node_name:
+                return x
+        return None
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
-- 
2.17.1
