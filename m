Received: from eggs.gnu.org ([209.51.188.92]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzB6-0000ZP-8j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEzB5-0001Ol-EW
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEzB5-0001Ny-6X
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:37:23 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 18:37:06 +0200
Message-Id: <20190412163706.3878-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vl: Add missing descriptions to the VGA
 adapters list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Some VGA adapters do not contain an helpful description,
this can be confusing:

  $ qemu-system-arm -M virt -vga help
  none
  std                  standard VGA
  cirrus               Cirrus VGA (default)
  vmware               VMWare SVGA
  xenfb

Add a description to the missing adapters:

  $ qemu-system-arm -M virt -vga help
  none                 no graphic card
  std                  standard VGA
  cirrus               Cirrus VGA (default)
  vmware               VMWare SVGA
  xenfb                Xen paravirtualized framebuffer

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20190412152713.16018-1-marcandre.lureau@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 840c45c00fa..dfeda8bd7fc 100644
--- a/vl.c
+++ b/vl.c
@@ -2029,6 +2029,7 @@ typedef struct VGAInterfaceInfo {
 static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
     [VGA_NONE] =3D {
         .opt_name =3D "none",
+        .name =3D "no graphic card",
     },
     [VGA_STD] =3D {
         .opt_name =3D "std",
@@ -2067,6 +2068,7 @@ static const VGAInterfaceInfo vga_interfaces[VGA_TY=
PE_MAX] =3D {
     },
     [VGA_XENFB] =3D {
         .opt_name =3D "xenfb",
+        .name =3D "Xen paravirtualized framebuffer",
     },
 };
=20
--=20
2.20.1
