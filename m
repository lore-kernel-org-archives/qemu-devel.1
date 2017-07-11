Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxJ-0002IE-Pf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxI-0007SV-Qn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:01 +1000
Message-Id: <20170711043917.1757-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/17] spapr: make
 spapr_populate_hotplug_cpu_dt() static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Since commit ff9006ddbfd1 ("spapr: move spapr_core_[foo]plug() callbacks
close to machine code in spapr.c"), this function doesn't need to be extern
anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 4 ++--
 include/hw/ppc/spapr.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ee9fac..65d8ad2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2863,8 +2863,8 @@ out:
     error_propagate(errp, local_err);
 }
 
-void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
-                                    sPAPRMachineState *spapr)
+static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
+                                           sPAPRMachineState *spapr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a66bbac..12bf969 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -640,8 +640,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
 void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
 void spapr_cpu_parse_features(sPAPRMachineState *spapr);
-void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
-                                    sPAPRMachineState *spapr);
 
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
-- 
2.9.4
