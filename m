Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj3OG-0006gi-Cy
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj3OE-000268-CH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:29:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cj3OE-000260-67
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:29:54 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  1 Mar 2017 13:29:50 +0100
Message-Id: <20170301122950.3587-4-pbonzini@redhat.com>
In-Reply-To: <20170301122950.3587-1-pbonzini@redhat.com>
References: <20170301122950.3587-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/19] vl: disable default cdrom when using
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

In commit af6bf1328ef90fae617857c02697e0174b84d596 (May 2011),
ide-hd, ide-cd and scsi-cd have been added to disable default cdrom,
"or else you can't put one on secondary master without -nodefaults".

Make it the same for scsi-hd, so you can put one on scsi-id 2 without
using -nodefaults.
scsi-hd has probably been forgotten, as it has been added in the
preceding commit (b443ae67130d32ad06b06fc9aa6d04d05ccd93ce).

Affected users are the ones using a machine with SCSI devices and start Q=
EMU
with -device scsi-hd but without -device scsi-cd or -cdrom
In that case, the default cdrom device will disappear instead of being em=
pty.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <1487623279-29930-1-git-send-email-hpoussin@reactos.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 7f57ded..16a3b5e 100644
--- a/vl.c
+++ b/vl.c
@@ -227,6 +227,7 @@ static struct {
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
2.9.3
