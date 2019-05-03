Received: from eggs.gnu.org ([209.51.188.92]:37728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGw-0003eQ-C9
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGv-0006ms-7S
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMGv-0006me-1r
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:18 -0300
Message-Id: <20190503004130.8285-8-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/19] tests/boot_linux_console: rename the
 x86_64 after the arch and machine
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

Given that the test is specific to x86_64 and pc, and new tests are
going to be added to the same class, let's rename it accordingly.
Also, let's make the class documentation not architecture specific.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-8-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index fa4594f612..4d57741bd8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -15,15 +15,17 @@ from avocado_qemu import Test
=20
 class BootLinuxConsole(Test):
     """
-    Boots a x86_64 Linux kernel and checks that the console is operation=
al
-    and the kernel command line is properly passed from QEMU to the kern=
el
-
-    :avocado: tags=3Darch:x86_64
+    Boots a Linux kernel and checks that the console is operational and =
the
+    kernel command line is properly passed from QEMU to the kernel
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
2.18.0.rc1.1.g3f1ff2140
