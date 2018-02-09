Received: from eggs.gnu.org ([2001:4830:134:3::10]:48369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekAyP-0001XR-8S
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekAyM-0007iL-Tw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:52:25 -0500
Received: from newton.telenet-ops.be ([2a02:1800:120:4::f00:d]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekAyM-0007hH-MH
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:52:22 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
	[IPv6:2a02:1800:120:4::f00:14])
	by newton.telenet-ops.be (Postfix) with ESMTPS id 3zdJwj1mlhzMqgcr
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:53 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:17:34 +0100
Message-Id: <1518189456-2873-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 3/5] hw/arm/virt: Allow dynamic sysbus
 devices again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Allow the instantation of generic dynamic sysbus devices again, without
the need to create a new device-specific vfio type.

This is a partial revert of commit  6f2062b9758ebc64 ("hw/arm/virt:
Allow only supported dynamic sysbus devices").

Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b334c82edae9fb1f..fa83784fc08ed076 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1596,6 +1596,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 255;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
-- 
2.7.4
