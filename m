Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eN2YB-0007Vt-JB
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eN2YA-0006sD-PN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 15:13:43 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  7 Dec 2017 20:13:18 +0000
Message-Id: <20171207201320.19284-5-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-1-stefanha@redhat.com>
References: <20171207201320.19284-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] iotests: add VM.add_object()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The VM.add_object() method can be used to add IOThreads or memory
backend objects.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6f057904a9..44477e9295 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -197,6 +197,11 @@ class VM(qtest.QEMUQtestMachine):
                                  socket_scm_helper=socket_scm_helper)
         self._num_drives = 0
 
+    def add_object(self, opts):
+        self._args.append('-object')
+        self._args.append(opts)
+        return self
+
     def add_device(self, opts):
         self._args.append('-device')
         self._args.append(opts)
-- 
2.14.3
