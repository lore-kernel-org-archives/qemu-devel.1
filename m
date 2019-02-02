Received: from eggs.gnu.org ([209.51.188.92]:54883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcb-0002jx-8f
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcM-0003fn-PT
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:14 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  1 Feb 2019 19:55:58 -0500
Message-Id: <20190202005610.24048-9-crosa@redhat.com>
In-Reply-To: <20190202005610.24048-1-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/20] Boot Linux Console Test: rename the
 x86_64 after the arch and machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Cleber Rosa <crosa@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>

Given that the test is specific to x86_64 and pc, and new tests are
going to be added to the same class, let's rename it accordingly.
Also, let's make the class documentation not architecture specific.

Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 46b20bdfe2..89df7f6e4f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -15,16 +15,19 @@ from avocado_qemu import Test
=20
 class BootLinuxConsole(Test):
     """
-    Boots a x86_64 Linux kernel and checks that the console is operation=
al
-    and the kernel command line is properly passed from QEMU to the kern=
el
+    Boots a Linux kernel and checks that the console is operational and =
the
+    kernel command line is properly passed from QEMU to the kernel
=20
     :avocado: enable
-    :avocado: tags=3Darch:x86_64
     """
=20
     timeout =3D 60
=20
-    def test(self):
+    def test_x86_64_pc(self):
+        """
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:pc
+        """
         kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28/'
                       'Everything/x86_64/os/images/pxeboot/vmlinuz')
         kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
--=20
2.20.1
