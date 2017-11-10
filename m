Received: from eggs.gnu.org ([2001:4830:134:3::10]:47374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDFND-0005OK-9y
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDFNC-0006FQ-Ai
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 14:53:55 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 10 Nov 2017 14:53:45 -0500
Message-Id: <1510343626-25861-5-git-send-email-cota@braap.org>
In-Reply-To: <1510343626-25861-1-git-send-email-cota@braap.org>
References: <1510343626-25861-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH for 2.11 4/5] xlnx-zcu102: Specify the max
 number of CPUs for the EP108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Just like the zcu102, the ep108 can instantiate several CPUs.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/arm/xlnx-zcu102.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index adddd23..190eb69 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -188,6 +188,7 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
 }
 
 static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
-- 
2.7.4
