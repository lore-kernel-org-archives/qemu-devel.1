Received: from eggs.gnu.org ([2001:4830:134:3::10]:51015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6oD-0003ns-Qt
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6oB-00046H-Pe
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6oB-00045k-JD
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:35 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:37:26 -0600
Message-ID: <153962504594.21502.15359981103500928453.stgit@gimli.home>
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 5/6] hw/arm/virt: Allow dynamic vfio-platform
 devices again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Eric Auger <eric.auger@redhat.com>Eric Auger <eric.auger@redhat.com>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Allow the instantation of generic dynamic vfio-platform devices again,
without the need to create a new device-specific vfio type.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/arm/virt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a47256607480..96dd4ef10c50 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1758,6 +1758,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_CALXEDA_XGMAC);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
