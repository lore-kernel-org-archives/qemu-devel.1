Received: from eggs.gnu.org ([2001:4830:134:3::10]:37049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJI-0006pw-Pl
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJG-0007Gd-Tt
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:04 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 29 Nov 2018 17:36:53 +0100
Message-Id: <20181129163655.20370-3-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-1-edgar.iglesias@gmail.com>
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/4] hw/arm: versal: Reduce number of
 virtio-mmio instances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, luc.michel@greensocs.com, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reduce number of virtio-mmio instances. This is in preparation
for correcting the interrupt setup for Versal.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 41b8d801c8..2ed6ee9934 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -342,7 +342,7 @@ static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
     return board->fdt;
 }
 
-#define NUM_VIRTIO_TRANSPORT 32
+#define NUM_VIRTIO_TRANSPORT 8
 static void create_virtio_regions(VersalVirt *s)
 {
     int virtio_mmio_size = 0x200;
-- 
2.17.1
