Received: from eggs.gnu.org ([2001:4830:134:3::10]:46190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwXa-0007J1-Mq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwXZ-0007ry-Sm
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwXZ-0007pa-Mt
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:37:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:28 +0000
Message-Id: <20171218143530.12082-22-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 21/23] iotests: add VM.add_object()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The VM.add_object() method can be used to add IOThreads or memory
backend objects.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171207201320.19284-5-stefanha@redhat.com
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
