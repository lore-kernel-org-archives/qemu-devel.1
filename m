Received: from eggs.gnu.org ([2001:4830:134:3::10]:47019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Kp-0005vj-8Y
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g85Ko-0006D8-Dz
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1g85Ko-0006Cm-7o
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:14:38 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 11:14:25 -0400
Message-Id: <20181004151429.7232-4-crosa@redhat.com>
In-Reply-To: <20181004151429.7232-1-crosa@redhat.com>
References: <20181004151429.7232-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] scripts/qemu.py: add method and private
 attribute for arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

Because some sane defaults may require the knowledge of the arch,
let's give the QEMUMachine the opportunity to hold that information.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..d9e24a0c1a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -113,6 +113,7 @@ class QEMUMachine(object):
         self._test_dir = test_dir
         self._temp_dir = None
         self._launched = False
+        self._arch = None
         self._machine = None
         self._console_device_type = None
         self._console_address = None
@@ -406,6 +407,12 @@ class QEMUMachine(object):
         '''
         self._args.extend(args)
 
+    def set_arch(self, arch):
+        """
+        Sets the architecture of this machine
+        """
+        self._arch = arch
+
     def set_machine(self, machine_type):
         '''
         Sets the machine type
-- 
2.17.1
