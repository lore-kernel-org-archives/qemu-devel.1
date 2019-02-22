Received: from eggs.gnu.org ([209.51.188.92]:39071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGi0-0003rl-3e
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxGhy-00089b-Qv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:42:08 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri, 22 Feb 2019 14:41:40 -0500
Message-Id: <20190222194146.13102-2-crosa@redhat.com>
In-Reply-To: <20190222194146.13102-1-crosa@redhat.com>
References: <20190222194146.13102-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] Acceptance tests: drop usage of ":avocado:
 enable"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

The Avocado test runner attemps to find its INSTRUMENTED (that is,
Python based tests) in a manner that is as safe as possible to the
user.  Different from plain Python unittest, it won't load or
execute test code on an operation such as:

 $ avocado list tests/acceptance/

Before version 68.0, the logic implemented to identify INSTRUMENTED
tests would require either the ":avocado: enable" or ":avocado:
recursive" statement as a flag for tests that would not inherit
directly from "avocado.Test".  This is not necessary anymore,
and because of that the boiler plate statements can now be removed.

Reference: https://avocado-framework.readthedocs.io/en/68.0/release_notes=
/68_0.html#users-test-writers
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20190218173723.26120-1-crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                 | 1 -
 tests/acceptance/boot_linux_console.py | 1 -
 tests/acceptance/linux_initrd.py       | 1 -
 tests/acceptance/version.py            | 1 -
 tests/acceptance/virtio_version.py     | 1 -
 tests/acceptance/vnc.py                | 1 -
 tests/requirements.txt                 | 2 +-
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 135743a2bf..3ce171829d 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -600,7 +600,6 @@ the ``avocado_qemu.Test`` class.  Here's a simple usa=
ge example:
=20
   class Version(Test):
       """
-      :avocado: enable
       :avocado: tags=3Dquick
       """
       def test_qmp_human_info_version(self):
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 98324f7591..beeb1e59e8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -18,7 +18,6 @@ class BootLinuxConsole(Test):
     Boots a x86_64 Linux kernel and checks that the console is operation=
al
     and the kernel command line is properly passed from QEMU to the kern=
el
=20
-    :avocado: enable
     :avocado: tags=3Dx86_64
     """
=20
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
index 737355c2ef..5a15fc4347 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -18,7 +18,6 @@ class LinuxInitrd(Test):
     """
     Checks QEMU evaluates correctly the initrd file passed as -initrd op=
tion.
=20
-    :avocado: enable
     :avocado: tags=3Dx86_64
     """
=20
diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
index 13b0a7440d..67c2192c93 100644
--- a/tests/acceptance/version.py
+++ b/tests/acceptance/version.py
@@ -14,7 +14,6 @@ from avocado_qemu import Test
=20
 class Version(Test):
     """
-    :avocado: enable
     :avocado: tags=3Dquick
     """
     def test_qmp_human_info_version(self):
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio=
_version.py
index ce990250d8..464d75aa4e 100644
--- a/tests/acceptance/virtio_version.py
+++ b/tests/acceptance/virtio_version.py
@@ -61,7 +61,6 @@ class VirtioVersionCheck(Test):
     same device tree created by `disable-modern` and
     `disable-legacy`.
=20
-    :avocado: enable
     :avocado: tags=3Dx86_64
     """
=20
diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
index b1ef9d71b1..064ceabcc1 100644
--- a/tests/acceptance/vnc.py
+++ b/tests/acceptance/vnc.py
@@ -13,7 +13,6 @@ from avocado_qemu import Test
=20
 class Vnc(Test):
     """
-    :avocado: enable
     :avocado: tags=3Dvnc,quick
     """
     def test_no_vnc(self):
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 64c6e27a94..002ded6a22 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,4 +1,4 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D65.0
+avocado-framework=3D=3D68.0
--=20
2.20.1
