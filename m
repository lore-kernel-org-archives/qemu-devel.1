Received: from eggs.gnu.org ([209.51.188.92]:36071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ghwiu-0003Nr-1e
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ghwit-0000cZ-B5
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ghwit-0000bm-5h
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:19:43 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 11 Jan 2019 14:18:36 +0100
Message-Id: <20190111131836.107549-5-sgarzare@redhat.com>
In-Reply-To: <20190111131836.107549-1-sgarzare@redhat.com>
References: <20190111131836.107549-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>, Maran Wilson <maran.wilson@oracle.com>

Use pvh.bin option rom when we are booting an uncompressed
kernel using the x86/HVM direct boot ABI.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
---
 hw/i386/pc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 06bce6a101..deab8a2816 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1005,6 +1005,10 @@ static void load_linux(PCMachineState *pcms,
             fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
                              header, sizeof(header));
=20
+            option_rom[nb_option_roms].bootindex =3D 0;
+            option_rom[nb_option_roms].name =3D "pvh.bin";
+            nb_option_roms++;
+
             return;
         }
         /* This looks like a multiboot kernel. If it is, let's stop
--=20
2.20.1
