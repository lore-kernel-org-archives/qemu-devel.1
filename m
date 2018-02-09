Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBCv-0006jT-KD
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekBCs-0000sk-Eu
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:07:25 -0500
Received: from newton.telenet-ops.be ([2a02:1800:120:4::f00:d]:53568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekBCs-0000rp-89
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:07:22 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
	[IPv6:2a02:1800:120:4::f00:14])
	by newton.telenet-ops.be (Postfix) with ESMTPS id 3zdJvz3FGLzMr19P
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:15 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:16:51 +0100
Message-Id: <1518189413-2761-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
References: <1518189413-2761-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 4/6] arm64: renesas_defconfig: Enable
 VFIO_PLATFORM and VFIO_NOIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, qemu-devel@nongnu.org, Geert Uytterhoeven <geert+renesas@glider.be>

Enable VFIO_PLATFORM for platform device pass-through.
Enable VFIO_NOIOMMU for devices not part of an IOMMU group.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not intended for upstream merge.
---
 arch/arm64/configs/renesas_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/renesas_defconfig b/arch/arm64/configs/renesas_defconfig
index 386211464efa4885..959aa9de8792ae2d 100644
--- a/arch/arm64/configs/renesas_defconfig
+++ b/arch/arm64/configs/renesas_defconfig
@@ -259,7 +259,9 @@ CONFIG_DMADEVICES=y
 CONFIG_RCAR_DMAC=y
 CONFIG_RENESAS_USB_DMAC=y
 CONFIG_VFIO=y
+CONFIG_VFIO_NOIOMMU=y
 CONFIG_VFIO_PCI=y
+CONFIG_VFIO_PLATFORM=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y
-- 
2.7.4
