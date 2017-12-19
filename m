Received: from eggs.gnu.org ([2001:4830:134:3::10]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLoD-00026K-E9
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLoC-0001eK-97
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:36:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:24 -0300
Message-Id: <20171219173425.8113-9-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/9] iotests: replace assertEquals() by
 assertEqual() for python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/041        | 6 +++---
 tests/qemu-iotests/118        | 4 ++--
 tests/qemu-iotests/iotests.py | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index a860a31e9a..fa0f20af0e 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -457,7 +457,7 @@ new_state = "1"
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
-        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
+        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'read')
         result = self.vm.qmp('query-block-jobs')
@@ -478,7 +478,7 @@ new_state = "1"
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
-        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
+        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'read')
         result = self.vm.qmp('query-block-jobs')
@@ -609,7 +609,7 @@ new_state = "1"
         self.assert_qmp(result, 'return', {})
 
         event = self.vm.get_qmp_event(wait=True)
-        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
+        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'write')
         result = self.vm.qmp('query-block-jobs')
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 3cf21218f0..8158b4bd25 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -295,7 +295,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result = self.vm.qmp('blockdev-close-tray', device='drive0')
         # Should be a no-op
         self.assert_qmp(result, 'return', {})
-        self.assertEquals(self.vm.get_qmp_events(wait=False), [])
+        self.assertEqual(self.vm.get_qmp_events(wait=False), [])
 
     def test_remove_on_closed(self):
         if not self.has_real_tray:
@@ -476,7 +476,7 @@ class TestChangeReadOnly(ChangeBaseClass):
                                                        read_only_mode='retain')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        self.assertEquals(self.vm.get_qmp_events(wait=False), [])
+        self.assertEqual(self.vm.get_qmp_events(wait=False), [])
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 85c9d2c211..4c515d2e6c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -385,7 +385,7 @@ class QMPTestCase(unittest.TestCase):
     def wait_ready_and_cancel(self, drive='drive0'):
         self.wait_ready(drive=drive)
         event = self.cancel_and_wait(drive=drive)
-        self.assertEquals(event['event'], 'BLOCK_JOB_COMPLETED')
+        self.assertEqual(event['event'], 'BLOCK_JOB_COMPLETED')
         self.assert_qmp(event, 'data/type', 'mirror')
         self.assert_qmp(event, 'data/offset', event['data']['len'])
 
-- 
2.15.1
