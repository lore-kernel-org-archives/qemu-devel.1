Received: from eggs.gnu.org ([2001:4830:134:3::10]:60730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnu-0001o9-OL
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnt-0001FR-Ko
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:46 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:22 -0300
Message-Id: <20171219173425.8113-7-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/9] iotests: replace dict.has_key() by 'in'
 operator for python3 compatibility
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
 tests/qemu-iotests/093 | 2 +-
 tests/qemu-iotests/096 | 4 ++--
 tests/qemu-iotests/136 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 5c36a5fb4d..28b1d021ca 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -237,7 +237,7 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
                 if name:
                     self.assertEqual(info["group"], name)
                 else:
-                    self.assertFalse(info.has_key('group'))
+                    self.assertFalse('group' in info)
                 return
 
         raise Exception("No group information found for '%s'" % device)
diff --git a/tests/qemu-iotests/096 b/tests/qemu-iotests/096
index aeeb3753cf..a69439602d 100644
--- a/tests/qemu-iotests/096
+++ b/tests/qemu-iotests/096
@@ -53,9 +53,9 @@ class TestLiveSnapshot(iotests.QMPTestCase):
                 self.assertEqual(r['iops'], self.iops)
                 self.assertEqual(r['iops_size'], self.iops_size)
             else:
-                self.assertFalse(r.has_key('group'))
+                self.assertFalse('group' in r)
                 self.assertEqual(r['iops'], 0)
-                self.assertFalse(r.has_key('iops_size'))
+                self.assertFalse('iops_size' in r)
 
     def testSnapshot(self):
         self.checkConfig('base')
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 88b97ea7c6..a154d8ef9d 100644
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -203,7 +203,7 @@ sector = "%d"
         if (self.accounted_ops(read = True, write = True, flush = True) != 0):
             self.assertLess(0, stats['idle_time_ns'])
         else:
-            self.assertFalse(stats.has_key('idle_time_ns'))
+            self.assertFalse('idle_time_ns' in stats)
 
         # This test does not alter these, so they must be all 0
         self.assertEqual(0, stats['rd_merged'])
-- 
2.15.1
