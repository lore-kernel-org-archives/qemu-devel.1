Received: from eggs.gnu.org ([2001:4830:134:3::10]:50599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-0008MY-0r
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOX-00074o-Jy
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:41 +1100
Message-Id: <20171017042152.29443-24-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/34] ppc: spapr: use cpu model names as tcg
 defaults instead of aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c32f33314..f7c5df3832 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3622,7 +3622,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
-    smc->tcg_default_cpu = "POWER8";
+    smc->tcg_default_cpu = "power8_v2.0";
     mc->has_hotpluggable_cpus = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
@@ -3868,7 +3868,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     spapr_machine_2_8_class_options(mc);
-    smc->tcg_default_cpu = "POWER7";
+    smc->tcg_default_cpu = "power7_v2.3";
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
     smc->phb_placement = phb_placement_2_7;
 }
-- 
2.13.6
