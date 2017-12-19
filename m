Received: from eggs.gnu.org ([2001:4830:134:3::10]:60265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnQ-0001Oi-4Z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLnO-0000b4-Oi
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:16 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:19 -0300
Message-Id: <20171219173425.8113-4-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/9] iotests: replace print statement by
 print() function for python3 compatibility
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
 tests/qemu-iotests/149        | 3 ++-
 tests/qemu-iotests/165        | 3 ++-
 tests/qemu-iotests/iotests.py | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 223cd68ad5..d3ffa259db 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -20,6 +20,7 @@
 # Exercise the QEMU 'luks' block driver to validate interoperability
 # with the Linux dm-crypt + cryptsetup implementation
 
+from __future__ import print_function
 import subprocess
 import os
 import os.path
@@ -376,7 +377,7 @@ def test_once(config, qemu_img=False):
     finally:
         iotests.log("# Delete image")
         delete_image(config)
-        print
+        print()
 
 
 # Obviously we only work with the luks image format
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index a3932db3de..ab29066076 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -18,6 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+from __future__ import print_function
 import os
 import re
 import iotests
@@ -85,7 +86,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
         log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
         if log:
-            print log
+            print(log)
 
         self.vm = self.mkVm()
         self.vm.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6f057904a9..85c9d2c211 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -16,6 +16,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+from __future__ import print_function
 import errno
 import os
 import re
@@ -145,7 +146,7 @@ def filter_qmp_event(event):
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
-    print msg
+    print(msg)
 
 class Timeout:
     def __init__(self, seconds, errmsg = "Timeout"):
@@ -417,7 +418,7 @@ def notrun(reason):
     seq = os.path.basename(sys.argv[0])
 
     open('%s/%s.notrun' % (output_dir, seq), 'wb').write(reason + '\n')
-    print '%s not run: %s' % (seq, reason)
+    print("{} not run: {}".format(seq, reason))
     sys.exit(0)
 
 def verify_image_format(supported_fmts=[], unsupported_fmts=[]):
-- 
2.15.1
