Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9kJ-0004OS-Rr
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gP9kI-0003MD-UU
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:23:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Nov 2018 18:22:52 +0100
Message-Id: <20181120172252.17800-3-kwolf@redhat.com>
In-Reply-To: <20181120172252.17800-1-kwolf@redhat.com>
References: <20181120172252.17800-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] iotests: Replace assertEquals() with
 assertEqual()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

TestCase.assertEquals() is deprecated since Python 2.7. Recent Python
versions print a warning when the function is called, which makes test
cases fail.

Replace it with the preferred spelling assertEqual().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041        | 6 +++---
 tests/qemu-iotests/118        | 4 ++--
 tests/qemu-iotests/iotests.py | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 3615011d98..26bf1701eb 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -469,7 +469,7 @@ new_state =3D "1"
             self.assert_qmp(event, 'data/id', 'drive0')
             event =3D self.vm.get_qmp_event(wait=3DTrue)
=20
-        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
+        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'read')
         result =3D self.vm.qmp('query-block-jobs')
@@ -494,7 +494,7 @@ new_state =3D "1"
             self.assert_qmp(event, 'data/id', 'drive0')
             event =3D self.vm.get_qmp_event(wait=3DTrue)
=20
-        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
+        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'read')
         result =3D self.vm.qmp('query-block-jobs')
@@ -625,7 +625,7 @@ new_state =3D "1"
         self.assert_qmp(result, 'return', {})
=20
         event =3D self.vm.event_wait(name=3D'BLOCK_JOB_ERROR')
-        self.assertEquals(event['event'], 'BLOCK_JOB_ERROR')
+        self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
         self.assert_qmp(event, 'data/device', 'drive0')
         self.assert_qmp(event, 'data/operation', 'write')
         result =3D self.vm.qmp('query-block-jobs')
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index c4f4c213ca..603e10e8a2 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -261,7 +261,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         result =3D self.vm.qmp('blockdev-close-tray', id=3Dself.device_n=
ame)
         # Should be a no-op
         self.assert_qmp(result, 'return', {})
-        self.assertEquals(self.vm.get_qmp_events(wait=3DFalse), [])
+        self.assertEqual(self.vm.get_qmp_events(wait=3DFalse), [])
=20
     def test_remove_on_closed(self):
         if not self.has_real_tray:
@@ -448,7 +448,7 @@ class TestChangeReadOnly(ChangeBaseClass):
                                                        read_only_mode=3D=
'retain')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
-        self.assertEquals(self.vm.get_qmp_events(wait=3DFalse), [])
+        self.assertEqual(self.vm.get_qmp_events(wait=3DFalse), [])
=20
         result =3D self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 27bb2b600c..d537538ba0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -581,7 +581,7 @@ class QMPTestCase(unittest.TestCase):
     def wait_ready_and_cancel(self, drive=3D'drive0'):
         self.wait_ready(drive=3Ddrive)
         event =3D self.cancel_and_wait(drive=3Ddrive)
-        self.assertEquals(event['event'], 'BLOCK_JOB_COMPLETED')
+        self.assertEqual(event['event'], 'BLOCK_JOB_COMPLETED')
         self.assert_qmp(event, 'data/type', 'mirror')
         self.assert_qmp(event, 'data/offset', event['data']['len'])
=20
--=20
2.19.1
