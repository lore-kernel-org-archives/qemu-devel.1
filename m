Received: from eggs.gnu.org ([2001:4830:134:3::10]:57575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTl-0004WM-FJ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTk-0003s2-Mf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:05 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:21 +0200
Message-Id: <20180628000745.4477-8-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 07/31] iotests.py: Add node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This function queries a node; since we cannot do that right now, it
executes query-named-block-nodes and returns the matching node's object.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5c45788dac..3b18907f6a 100644
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
+        assert False
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
-- 
2.17.1
