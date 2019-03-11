Received: from eggs.gnu.org ([209.51.188.92]:48091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qm-0007eU-DV
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38qj-0003Va-NK
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38qj-0003VD-G3
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:25 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:30:49 +0100
Message-Id: <20190311003052.13778-3-philmd@redhat.com>
In-Reply-To: <20190311003052.13778-1-philmd@redhat.com>
References: <20190311003052.13778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] roms/edk2: Avoid bashism in script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Michal=20Pr=C3=ADvozn=C3=ADk?= <mprivozn@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Use the POSIX '=3D' to evaluate equality.

This fixes building the roms with a dash shell:

  $ make -C roms efi
  [...]
  cp edk2/Build/ArmVirtQemu-ARM/DEBUG_GCC5/FV/QEMU_EFI.fd \
        ../pc-bios/edk2-arm-code.fd
  truncate --size=3D64M ../pc-bios/edk2-arm-code.fd
  /bin/sh: 111: [: i686: unexpected operator
  /bin/sh: 112: [: i686: unexpected operator
  /bin/sh: 116: [: i686: unexpected operator

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/edk2-funcs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 7fc62f074c..402fc126fb 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -108,8 +108,8 @@ qemu_edk2_get_cross_prefix()
=20
   host_arch=3D$(uname -m)
=20
-  if [ "$gcc_arch" =3D=3D "$host_arch" ] ||
-     ( [ "$gcc_arch" =3D=3D i686 ] && [ "$host_arch" =3D=3D x86_64 ] ); =
then
+  if [ "$gcc_arch" =3D "$host_arch" ] ||
+     ( [ "$gcc_arch" =3D i686 ] && [ "$host_arch" =3D x86_64 ] ); then
     # no cross-compiler needed
     :
   else
--=20
2.20.1
