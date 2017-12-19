Received: from eggs.gnu.org ([2001:4830:134:3::10]:60407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnb-0001Y2-0M
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnZ-0000pA-Js
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:26 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:20 -0300
Message-Id: <20171219173425.8113-5-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/9] iotests: use octal numbers for python3
 compatibility
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
 tests/qemu-iotests/118 | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 8a9e838c90..3cf21218f0 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -417,14 +417,14 @@ class TestChangeReadOnly(ChangeBaseClass):
 
     def tearDown(self):
         self.vm.shutdown()
-        os.chmod(old_img, 0666)
-        os.chmod(new_img, 0666)
+        os.chmod(old_img, 0o666)
+        os.chmod(new_img, 0o666)
         os.remove(old_img)
         os.remove(new_img)
 
     def test_ro_ro_retain(self):
-        os.chmod(old_img, 0444)
-        os.chmod(new_img, 0444)
+        os.chmod(old_img, 0o444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
@@ -443,7 +443,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_ro_rw_retain(self):
-        os.chmod(old_img, 0444)
+        os.chmod(old_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
@@ -462,7 +462,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_rw_ro_retain(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
@@ -483,7 +483,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
     def test_ro_rw(self):
-        os.chmod(old_img, 0444)
+        os.chmod(old_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
@@ -503,7 +503,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_rw_ro(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
@@ -542,7 +542,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_make_ro_rw(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
@@ -562,7 +562,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
     def test_make_rw_ro_by_retain(self):
-        os.chmod(old_img, 0444)
+        os.chmod(old_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk,read-only=on', 'floppy')
         self.vm.launch()
 
@@ -581,7 +581,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_make_ro_rw_by_retain(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
@@ -600,7 +600,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
     def test_rw_ro_cycle(self):
-        os.chmod(new_img, 0444)
+        os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=disk', 'floppy')
         self.vm.launch()
 
-- 
2.15.1
