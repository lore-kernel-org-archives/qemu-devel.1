Received: from eggs.gnu.org ([2001:4830:134:3::10]:44340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWE-0003U1-H9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fVcWC-0006AR-TJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fVcWC-0006AE-PW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:47:24 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Jun 2018 14:47:14 +0200
Message-Id: <20180620124719.16450-3-kraxel@redhat.com>
In-Reply-To: <20180620124719.16450-1-kraxel@redhat.com>
References: <20180620124719.16450-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] seabios: add vga configs for bochs-display
 and ramfb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org, qemu-devel@nongnu.org
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
