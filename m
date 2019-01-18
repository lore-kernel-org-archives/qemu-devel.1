Received: from eggs.gnu.org ([209.51.188.92]:49793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gkSzI-0005yi-IB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gkSzH-0005MT-UB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:11:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gkSzH-0005Le-No
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:11:03 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 18 Jan 2019 13:01:42 +0100
Message-Id: <20190118120143.21631-5-sgarzare@redhat.com>
In-Reply-To: <20190118120143.21631-1-sgarzare@redhat.com>
References: <20190118120143.21631-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Use pvh.bin option rom when we are booting an uncompressed
kernel using the x86/HVM direct boot ABI.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9ed5063de8..2833b130ba 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1252,6 +1252,10 @@ static void load_linux(PCMachineState *pcms,
                                  initrd_size);
             }
=20
+            option_rom[nb_option_roms].bootindex =3D 0;
+            option_rom[nb_option_roms].name =3D "pvh.bin";
+            nb_option_roms++;
+
             return;
         }
         /* This looks like a multiboot kernel. If it is, let's stop
@@ -1703,6 +1707,7 @@ void xen_load_linux(PCMachineState *pcms)
     for (i =3D 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
+               !strcmp(option_rom[i].name, "pvh.bin") ||
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
--=20
2.20.1
