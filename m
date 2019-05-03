Received: from eggs.gnu.org ([209.51.188.92]:37797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMH3-0003lt-W0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMH3-0006qB-37
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMH2-0006pu-UG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:20 -0300
Message-Id: <20190503004130.8285-10-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/19] tests/boot_linux_console: add common
 kernel command line options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

From: Cleber Rosa <crosa@redhat.com>

The 'printk.time=3D0' option makes it easier to parse the console
output.  Let's set it as a default, and reusable, kernel command line
options for this and future similar tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-10-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 03a4445176..a94f5cd2c8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -21,6 +21,8 @@ class BootLinuxConsole(Test):
=20
     timeout =3D 60
=20
+    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=3Darch:x86_64
@@ -33,7 +35,7 @@ class BootLinuxConsole(Test):
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
2.18.0.rc1.1.g3f1ff2140
