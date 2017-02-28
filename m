Received: from eggs.gnu.org ([2001:4830:134:3::10]:45101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cidkE-0004c3-Gl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cidk9-0000u8-Jf
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:06:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cidk9-0000t8-Dx
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:06:49 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EE2680F7C
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:06:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 28 Feb 2017 10:06:44 +0100
Message-Id: <1488272804-27144-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
References: <1488272804-27144-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] seabios: update to 1.10.2 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

git shortlog rel-1.10.1..rel-1.10.2
===================================

Ben Warren (5):
      QEMU DMA: Add DMA write capability
      romfile-loader: Switch to using named structs
      QEMU fw_cfg: Add command to write back address of file
      QEMU fw_cfg: Add functions for accessing files by key
      QEMU fw_cfg: Write fw_cfg back on S3 resume

Kevin O'Connor (1):
      ps2port: Disable keyboard/mouse prior to resetting ps2 controller

Ladi Prosek (1):
      ahci: Set upper 32-bit registers to zero

Paul Menzel (1):
      vgasrc: Increase debug level

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin           | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-cirrus.bin | Bin 38400 -> 38400 bytes
 pc-bios/vgabios-qxl.bin    | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-stdvga.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-virtio.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-vmware.bin | Bin 38912 -> 38912 bytes
 pc-bios/vgabios.bin        | Bin 38400 -> 38400 bytes
 roms/seabios               |   2 +-
 9 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/bios-256k.bin b/pc-bios/bios-256k.bin
index 229b5af..18666c9 100644
Binary files a/pc-bios/bios-256k.bin and b/pc-bios/bios-256k.bin differ
diff --git a/pc-bios/bios.bin b/pc-bios/bios.bin
index 9a9b0f0..a394411 100644
Binary files a/pc-bios/bios.bin and b/pc-bios/bios.bin differ
diff --git a/pc-bios/vgabios-cirrus.bin b/pc-bios/vgabios-cirrus.bin
index 9dadce2..e6c42bd 100644
Binary files a/pc-bios/vgabios-cirrus.bin and b/pc-bios/vgabios-cirrus.bin differ
diff --git a/pc-bios/vgabios-qxl.bin b/pc-bios/vgabios-qxl.bin
index a89725c..915eba7 100644
Binary files a/pc-bios/vgabios-qxl.bin and b/pc-bios/vgabios-qxl.bin differ
diff --git a/pc-bios/vgabios-stdvga.bin b/pc-bios/vgabios-stdvga.bin
index ea04141..40eca8c 100644
Binary files a/pc-bios/vgabios-stdvga.bin and b/pc-bios/vgabios-stdvga.bin differ
diff --git a/pc-bios/vgabios-virtio.bin b/pc-bios/vgabios-virtio.bin
index 71e22fc..8b3abfa 100644
Binary files a/pc-bios/vgabios-virtio.bin and b/pc-bios/vgabios-virtio.bin differ
diff --git a/pc-bios/vgabios-vmware.bin b/pc-bios/vgabios-vmware.bin
index ad239cb..6a90b94 100644
Binary files a/pc-bios/vgabios-vmware.bin and b/pc-bios/vgabios-vmware.bin differ
diff --git a/pc-bios/vgabios.bin b/pc-bios/vgabios.bin
index 9947c2c..d3ed89d 100644
Binary files a/pc-bios/vgabios.bin and b/pc-bios/vgabios.bin differ
diff --git a/roms/seabios b/roms/seabios
index 8891697..5f4c7b1 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit 8891697e3f7d84355420573efd98e94f14736768
+Subproject commit 5f4c7b13cdf9c450eb55645f4362ea58fa61b79b
-- 
1.8.3.1
