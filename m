Received: from eggs.gnu.org ([2001:4830:134:3::10]:33644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5Z-0003ao-ED
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5V-0006bF-8g
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:45 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:51:03 +0200
Message-Id: <1507578671-158758-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/24] ppc: spapr: use cpu model names as
 tcg defaults instead of aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
PS:
 - patch is made separate to reduce noise in follow up patch
     "ppc: spapr: use generic cpu_model parsing"
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fda2bbe..30b4934 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3610,7 +3610,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
-    smc->tcg_default_cpu = "POWER8";
+    smc->tcg_default_cpu = "power8_v2.0";
     mc->has_hotpluggable_cpus = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
@@ -3856,7 +3856,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     spapr_machine_2_8_class_options(mc);
-    smc->tcg_default_cpu = "POWER7";
+    smc->tcg_default_cpu = "power7_v2.3";
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
     smc->phb_placement = phb_placement_2_7;
 }
-- 
2.7.4
