Received: from eggs.gnu.org ([209.51.188.92]:54646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcO-0002bg-Ai
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpjcL-0003aK-Ix
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 19:57:10 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  1 Feb 2019 19:56:00 -0500
Message-Id: <20190202005610.24048-11-crosa@redhat.com>
In-Reply-To: <20190202005610.24048-1-crosa@redhat.com>
References: <20190202005610.24048-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/20] Boot Linux Console Test: add common
 kernel command line options
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

The 'printk.time=3D0' option makes it easier to parse the console
output.  Let's set it as a default, and reusable, kernel command line
options for this and future similar tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 35b31162d4..cc5dcd7373 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -23,6 +23,8 @@ class BootLinuxConsole(Test):
=20
     timeout =3D 60
=20
+    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=3Darch:x86_64
@@ -35,7 +37,7 @@ class BootLinuxConsole(Test):
=20
         self.vm.set_machine('pc')
         self.vm.set_console()
-        kernel_command_line =3D 'console=3DttyS0'
+        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
--=20
2.20.1
