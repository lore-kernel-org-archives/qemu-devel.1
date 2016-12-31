Received: from eggs.gnu.org ([2001:4830:134:3::10]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cNKkc-0004bu-HW
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 09:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cNKkX-0003Ly-Fj
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 09:35:14 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 31 Dec 2016 15:34:16 +0100
Message-Id: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vl: disable default cdrom when using
 explicitely scsi-hd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>

'ide-hd', 'ide-cd' and 'scsi-cd' devices already disable default cdrom.
Make it the same for 'scsi-hd'.

That way, we can add/replace the device on lun=3D2 without using -nodefau=
lts.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index d77dd86..da97fe2 100644
--- a/vl.c
+++ b/vl.c
@@ -223,6 +223,7 @@ static struct {
     { .driver =3D "ide-hd",               .flag =3D &default_cdrom     }=
,
     { .driver =3D "ide-drive",            .flag =3D &default_cdrom     }=
,
     { .driver =3D "scsi-cd",              .flag =3D &default_cdrom     }=
,
+    { .driver =3D "scsi-hd",              .flag =3D &default_cdrom     }=
,
     { .driver =3D "virtio-serial-pci",    .flag =3D &default_virtcon   }=
,
     { .driver =3D "virtio-serial",        .flag =3D &default_virtcon   }=
,
     { .driver =3D "VGA",                  .flag =3D &default_vga       }=
,
--=20
2.1.4
