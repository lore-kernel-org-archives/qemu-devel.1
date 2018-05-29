Received: from eggs.gnu.org ([2001:4830:134:3::10]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNlP0-0003Ja-KW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNlOy-0007uj-Kc
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:39:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 29 May 2018 22:38:59 +0200
Message-Id: <20180529203910.7615-6-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-1-kwolf@redhat.com>
References: <20180529203910.7615-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/16] qemu-iotests: Add
 VM.get_qmp_events_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This adds a helper function that returns a list of QMP events that are
already filtered through filter_qmp_event().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 28159d837a..17aa7c88dc 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -383,6 +383,11 @@ class VM(qtest.QEMUQtestMachine):
             output_list += [key + '=' + obj[key]]
         return ','.join(output_list)
 
+    def get_qmp_events_filtered(self, wait=True):
+        result = []
+        for ev in self.get_qmp_events(wait=wait):
+            result.append(filter_qmp_event(ev))
+        return result
 
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
-- 
2.13.6
