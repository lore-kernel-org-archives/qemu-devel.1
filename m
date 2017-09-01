Received: from eggs.gnu.org ([2001:4830:134:3::10]:37808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpg7-0006ng-0V
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpg2-00048P-B3
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:24:23 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:19 +0200
Message-Id: <1504286483-23327-17-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 16/20] hw/arm/sysbus-fdt: Pass the platform
 bus base address in PlatformBusFDTData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

The Base address of the platform bus may be useful for device node
creation function. This is typically the case if the node creation
function also prepares data for ACPI table generation.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/sysbus-fdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d92a983..f8c4909 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -46,6 +46,7 @@
 typedef struct PlatformBusFDTData {
     void *fdt; /* device tree handle */
     int irq_start; /* index of the first IRQ usable by platform bus devices */
+    hwaddr base; /* base address of the platform bus */
     const char *pbus_node_name; /* name of the platform bus node */
     PlatformBusDevice *pbus;
     VirtMachineState *vms;
@@ -514,6 +515,7 @@ static void add_all_platform_bus_fdt_nodes(ARMPlatformBusFDTParams *fdt_params)
     PlatformBusFDTData data = {
         .fdt = fdt,
         .irq_start = irq_start,
+        .base = addr,
         .pbus_node_name = node,
         .pbus = pbus,
         .vms = fdt_params->vms,
-- 
2.5.5
