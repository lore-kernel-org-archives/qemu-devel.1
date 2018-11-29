Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJI-0006px-Ps
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gSPJF-0007Fk-CQ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:37:04 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 29 Nov 2018 17:36:52 +0100
Message-Id: <20181129163655.20370-2-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-1-edgar.iglesias@gmail.com>
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/4] hw/arm: versal: Remove bogus
 virtio-mmio creation
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

Remove bogus virtio-mmio creation. This was an accidental
left-over an experiment.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 1e31a3f442..41b8d801c8 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -364,7 +364,6 @@ static void create_virtio_regions(VersalVirt *s)
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
-        sysbus_create_simple("virtio-mmio", base, pic_irq);
     }
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-- 
2.17.1
