Received: from eggs.gnu.org ([2001:4830:134:3::10]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gB0Gu-0004y4-91
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gB0Gr-0001Au-51
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gB0Gq-00019d-VJ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58F8581DF0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 16:26:36 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 12 Oct 2018 10:26:31 -0600
Message-ID: <153936155938.28040.11513367417790075721.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] Makefile: Install new vgabios binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Difficult to make use of if not installed

Fixes: cd1bfd5ef336 ("seabios: update bios and vgabios binaries")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

 Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 1144d6e3ba0e..f2947186a4c3 100644
--- a/Makefile
+++ b/Makefile
@@ -802,6 +802,7 @@ bepo    cz
 ifdef INSTALL_BLOBS
 BLOBS=bios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
+vgabios-ramfb.bin vgabios-bochs-display.bin \
 ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin \
 pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
 pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
