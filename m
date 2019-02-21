Received: from eggs.gnu.org ([209.51.188.92]:33125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwchB-00060R-OT
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gwch9-00011i-2f
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:58:36 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 20 Feb 2019 19:57:41 -0500
Message-Id: <20190221005753.27955-9-crosa@redhat.com>
In-Reply-To: <20190221005753.27955-1-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/20] Boot Linux Console Test: rename the
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
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Given that the test is specific to x86_64 and pc, and new tests are
going to be added to the same class, let's rename it accordingly.
Also, let's make the class documentation not architecture specific.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
