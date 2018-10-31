Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQM-0002BM-Vs
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeQJ-0003rC-Mx
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:31:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:31:10 -0300
Message-Id: <20181031003120.26771-6-ehabkost@redhat.com>
In-Reply-To: <20181031003120.26771-1-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] iotests: Use // for Python integer
 division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Max Reitz <mreitz@redhat.com>

In Python 3, / is always a floating-point division.  We usually do not
want this, and as Python 2.7 understands // as well, change all integer
divisions to use that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20181022135307.14398-5-mreitz@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qemu-iotests/030        |  2 +-
 tests/qemu-iotests/040        |  4 ++--
 tests/qemu-iotests/041        |  4 ++--
 tests/qemu-iotests/044        |  2 +-
 tests/qemu-iotests/093        | 18 +++++++++---------
 tests/qemu-iotests/136        |  2 +-
 tests/qemu-iotests/149        |  6 +++---
 tests/qemu-iotests/151        | 12 ++++++------
 tests/qemu-iotests/163        |  2 +-
 tests/qemu-iotests/iotests.py |  2 +-
 tests/qemu-iotests/qed.py     |  6 +++---
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 1dbc2ddc49..276e06b5ba 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -521,7 +521,7 @@ new_state = "2"
 state = "2"
 event = "%s"
 new_state = "1"
-''' % (event, errno, self.STREAM_BUFFER_SIZE / 512, event, event))
+''' % (event, errno, self.STREAM_BUFFER_SIZE // 512, event, event))
         file.close()
 
 class TestEIO(TestErrors):
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 1cb1ceeb33..b81133a474 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -195,7 +195,7 @@ class TestSingleDrive(ImageCommitTestCase):
 
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
-                             base=backing_img, speed=(self.image_len / 4))
+                             base=backing_img, speed=(self.image_len // 4))
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp('device_del', id='scsi0')
         self.assert_qmp(result, 'return', {})
@@ -225,7 +225,7 @@ class TestSingleDrive(ImageCommitTestCase):
 
         self.assert_no_active_block_jobs()
         result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
-                             base=backing_img, speed=(self.image_len / 4))
+                             base=backing_img, speed=(self.image_len // 4))
         self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('query-block')
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 9336ab6ff5..3615011d98 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -404,7 +404,7 @@ new_state = "2"
 state = "2"
 event = "%s"
 new_state = "1"
-''' % (event, errno, self.MIRROR_GRANULARITY / 512, event, event))
+''' % (event, errno, self.MIRROR_GRANULARITY // 512, event, event))
         file.close()
 
     def setUp(self):
@@ -569,7 +569,7 @@ new_state = "2"
 state = "2"
 event = "%s"
 new_state = "1"
-''' % (event, errno, self.MIRROR_GRANULARITY / 512, event, event))
+''' % (event, errno, self.MIRROR_GRANULARITY // 512, event, event))
         file.close()
 
     def setUp(self):
diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 69e736f687..7ef5e46fe9 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -86,7 +86,7 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
                 off = off + 1024 * 512
 
             table = b''.join(struct.pack('>Q', (1 << 63) | off + 512 * j)
-                for j in xrange(0, remaining / 512))
+                for j in xrange(0, remaining // 512))
             fd.write(table)
 
 
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 9d1971a56c..d88fbc182e 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -69,18 +69,18 @@ class ThrottleTestCase(iotests.QMPTestCase):
         # in. The throttled requests won't be executed until we
         # advance the virtual clock.
         rq_size = 512
-        rd_nr = max(params['bps'] / rq_size / 2,
-                    params['bps_rd'] / rq_size,
-                    params['iops'] / 2,
+        rd_nr = max(params['bps'] // rq_size // 2,
+                    params['bps_rd'] // rq_size,
+                    params['iops'] // 2,
                     params['iops_rd'])
         rd_nr *= seconds * 2
-        rd_nr /= ndrives
-        wr_nr = max(params['bps'] / rq_size / 2,
-                    params['bps_wr'] / rq_size,
-                    params['iops'] / 2,
+        rd_nr //= ndrives
+        wr_nr = max(params['bps'] // rq_size // 2,
+                    params['bps_wr'] // rq_size,
+                    params['iops'] // 2,
                     params['iops_wr'])
         wr_nr *= seconds * 2
-        wr_nr /= ndrives
+        wr_nr //= ndrives
 
         # Send I/O requests to all drives
         for i in range(rd_nr):
@@ -196,7 +196,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
             self.configure_throttle(ndrives, settings)
 
             # Wait for the bucket to empty so we can do bursts
-            wait_ns = nsec_per_sec * burst_length * burst_rate / rate
+            wait_ns = nsec_per_sec * burst_length * burst_rate // rate
             self.vm.qtest("clock_step %d" % wait_ns)
 
             # Test I/O at the max burst rate
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index a154d8ef9d..af7ffa4540 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -24,7 +24,7 @@ import os
 
 interval_length = 10
 nsec_per_sec = 1000000000
-op_latency = nsec_per_sec / 1000 # See qtest_latency_ns in accounting.c
+op_latency = nsec_per_sec // 1000 # See qtest_latency_ns in accounting.c
 bad_sector = 8192
 bad_offset = bad_sector * 512
 blkdebug_file = os.path.join(iotests.test_dir, 'blkdebug.conf')
diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 1225334cb8..4f363f295f 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -314,13 +314,13 @@ def test_once(config, qemu_img=False):
     image_size = 4 * oneTB
     if qemu_img:
         iotests.log("# Create image")
-        qemu_img_create(config, image_size / oneMB)
+        qemu_img_create(config, image_size // oneMB)
     else:
         iotests.log("# Create image")
-        create_image(config, image_size / oneMB)
+        create_image(config, image_size // oneMB)
 
     lowOffsetMB = 100
-    highOffsetMB = 3 * oneTB / oneMB
+    highOffsetMB = 3 * oneTB // oneMB
 
     try:
         if not qemu_img:
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index fe53b9f446..1bb74d67c4 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -67,9 +67,9 @@ class TestActiveMirror(iotests.QMPTestCase):
                             'write -P 1 0 %i' % self.image_len);
 
         # Start some background requests
-        for offset in range(1 * self.image_len / 8, 3 * self.image_len / 8, 1024 * 1024):
+        for offset in range(1 * self.image_len // 8, 3 * self.image_len // 8, 1024 * 1024):
             self.vm.hmp_qemu_io('source', 'aio_write -P 2 %i 1M' % offset)
-        for offset in range(2 * self.image_len / 8, 3 * self.image_len / 8, 1024 * 1024):
+        for offset in range(2 * self.image_len // 8, 3 * self.image_len // 8, 1024 * 1024):
             self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         # Start the block job
@@ -83,9 +83,9 @@ class TestActiveMirror(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         # Start some more requests
-        for offset in range(3 * self.image_len / 8, 5 * self.image_len / 8, 1024 * 1024):
+        for offset in range(3 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
             self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
-        for offset in range(4 * self.image_len / 8, 5 * self.image_len / 8, 1024 * 1024):
+        for offset in range(4 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
             self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         # Wait for the READY event
@@ -95,9 +95,9 @@ class TestActiveMirror(iotests.QMPTestCase):
         # the source) should be settled using the active mechanism.
         # The mirror code itself asserts that the source BDS's dirty
         # bitmap will stay clean between READY and COMPLETED.
-        for offset in range(5 * self.image_len / 8, 7 * self.image_len / 8, 1024 * 1024):
+        for offset in range(5 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
             self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
-        for offset in range(6 * self.image_len / 8, 7 * self.image_len / 8, 1024 * 1024):
+        for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
             self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         if sync_source_and_target:
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 403842354e..5fd424761b 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -38,7 +38,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
         entry_bits = 3
         entry_size = 1 << entry_bits
         l1_mask = 0x00fffffffffffe00
-        div_roundup = lambda n, d: (n + d - 1) / d
+        div_roundup = lambda n, d: (n + d - 1) // d
 
         def split_by_n(data, n):
             for x in xrange(0, len(data), n):
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7290c0b159..7ca94e9278 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -199,7 +199,7 @@ def create_image(name, size):
     file = open(name, 'wb')
     i = 0
     while i < size:
-        sector = struct.pack('>l504xl', i / 512, i / 512)
+        sector = struct.pack('>l504xl', i // 512, i // 512)
         file.write(sector)
         i = i + 512
     file.close()
diff --git a/tests/qemu-iotests/qed.py b/tests/qemu-iotests/qed.py
index ea469b9c48..8adaaf46c4 100755
--- a/tests/qemu-iotests/qed.py
+++ b/tests/qemu-iotests/qed.py
@@ -80,7 +80,7 @@ class QED(object):
 
     def load_l1_table(self):
         self.l1_table = self.read_table(self.header['l1_table_offset'])
-        self.table_nelems = self.header['table_size'] * self.header['cluster_size'] / table_elem_size
+        self.table_nelems = self.header['table_size'] * self.header['cluster_size'] // table_elem_size
 
     def write_table(self, offset, table):
         s = ''.join(pack_table_elem(x) for x in table)
@@ -167,14 +167,14 @@ def cmd_zero_cluster(qed, pos, *args):
         n = int(args[0])
 
     for i in xrange(n):
-        l1_index = pos / qed.header['cluster_size'] / len(qed.l1_table)
+        l1_index = pos // qed.header['cluster_size'] // len(qed.l1_table)
         if qed.l1_table[l1_index] == 0:
             err('no l2 table allocated')
 
         l2_offset = qed.l1_table[l1_index]
         l2_table = qed.read_table(l2_offset)
 
-        l2_index = (pos / qed.header['cluster_size']) % len(qed.l1_table)
+        l2_index = (pos // qed.header['cluster_size']) % len(qed.l1_table)
         l2_table[l2_index] = 1 # zero the data cluster
         qed.write_table(l2_offset, l2_table)
         pos += qed.header['cluster_size']
-- 
2.18.0.rc1.1.g3f1ff2140
