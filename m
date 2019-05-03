Received: from eggs.gnu.org ([209.51.188.92]:37777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMH2-0003jo-0e
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMH1-0006pB-1D
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMH0-0006op-Rb
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  2 May 2019 21:41:19 -0300
Message-Id: <20190503004130.8285-9-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/19] tests/boot_linux_console: update the
 x86_64 kernel
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

Update to the stock Fedora 29 kernel, from the Fedora 28.  New tests
will be added using the 29 kernel, so for consistency, let's also
update it here.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Caio Carrara <ccarrara@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190312171824.5134-9-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 4d57741bd8..03a4445176 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -26,9 +26,9 @@ class BootLinuxConsole(Test):
         :avocado: tags=3Darch:x86_64
         :avocado: tags=3Dmachine:pc
         """
-        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28/'
-                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
-        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
+        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
+                      'releases/29/Everything/x86_64/os/images/pxeboot/v=
mlinuz')
+        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
         kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
=20
         self.vm.set_machine('pc')
--=20
2.18.0.rc1.1.g3f1ff2140
