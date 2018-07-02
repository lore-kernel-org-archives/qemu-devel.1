Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0yC-0004aL-4o
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa0y9-0006Ed-0j
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa0y8-0006EP-QW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:42:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0C4E308402F
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:42:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 17:42:17 +0200
Message-Id: <20180702154222.3130-3-kraxel@redhat.com>
In-Reply-To: <20180702154222.3130-1-kraxel@redhat.com>
References: <20180702154222.3130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] seabios: add vga configs for bochs-display
 and ramfb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Both bochs-display and ramfb are devices with a simple framebuffer and
no vga emulation or text mode.  seavgabios has support for text mode
emulation (at vgabios call level), we are using that to provide some
vga compatibility support for these devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile                 | 2 +-
 roms/config.vga-bochs-display | 3 +++
 roms/config.vga-ramfb         | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 roms/config.vga-bochs-display
 create mode 100644 roms/config.vga-ramfb

diff --git a/roms/Makefile b/roms/Makefile
index 02b69fbac8..a73778f60b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -1,5 +1,5 @@
 
-vgabios_variants := stdvga cirrus vmware qxl isavga virtio
+vgabios_variants := stdvga cirrus vmware qxl isavga virtio bochs-display ramfb
 vgabios_targets  := $(subst -isavga,,$(patsubst %,vgabios-%.bin,$(vgabios_variants)))
 pxerom_variants  := e1000 e1000e eepro100 ne2k_pci pcnet rtl8139 virtio vmxnet3
 pxerom_targets   := 8086100e 808610d3 80861209 10500940 10222000 10ec8139 1af41000 15ad07b0
diff --git a/roms/config.vga-bochs-display b/roms/config.vga-bochs-display
new file mode 100644
index 0000000000..d2adaaef66
--- /dev/null
+++ b/roms/config.vga-bochs-display
@@ -0,0 +1,3 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_DISPLAY_BOCHS=y
+CONFIG_VGA_PCI=y
diff --git a/roms/config.vga-ramfb b/roms/config.vga-ramfb
new file mode 100644
index 0000000000..c809c799b9
--- /dev/null
+++ b/roms/config.vga-ramfb
@@ -0,0 +1,3 @@
+CONFIG_BUILD_VGABIOS=y
+CONFIG_VGA_RAMFB=y
+CONFIG_VGA_PCI=n
-- 
2.9.3
