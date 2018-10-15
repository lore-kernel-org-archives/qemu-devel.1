Received: from eggs.gnu.org ([2001:4830:134:3::10]:50873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByoj-0001xz-PT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByoi-0008VE-1u
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gByoh-0008N3-Lv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:35 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Oct 2018 11:05:17 +0200
Message-Id: <20181015090517.26884-8-kraxel@redhat.com>
In-Reply-To: <20181015090517.26884-1-kraxel@redhat.com>
References: <20181015090517.26884-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] Makefile: Install new vgabios binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Difficult to make use of if not installed

Fixes: cd1bfd5ef336 ("seabios: update bios and vgabios binaries")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 153936155938.28040.11513367417790075721.stgit@gimli.home
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 1144d6e3ba..f2947186a4 100644
--- a/Makefile
+++ b/Makefile
@@ -802,6 +802,7 @@ bepo    cz
 ifdef INSTALL_BLOBS
 BLOBS=3Dbios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bi=
n \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin=
 \
+vgabios-ramfb.bin vgabios-bochs-display.bin \
 ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin =
QEMU,cgthree.bin \
 pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
 pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
--=20
2.9.3
