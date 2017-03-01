Received: from eggs.gnu.org ([2001:4830:134:3::10]:46268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7i-0007vZ-Vt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7h-0008UE-DG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:21 +1100
Message-Id: <20170301044405.1792-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/50] sysemu: support up to 1024 vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Greg Kurz <gkurz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <gkurz@linux.vnet.ibm.com>

Some systems can already provide more than 255 hardware threads.

Bumping the QEMU limit to 1024 seems reasonable:
- it has no visible overhead in top;
- the limit itself has no effect on hot paths.

Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 87d8366..0b57aad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2891,7 +2891,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->init = ppc_spapr_init;
     mc->reset = ppc_spapr_reset;
     mc->block_default_type = IF_SCSI;
-    mc->max_cpus = 255;
+    mc->max_cpus = 1024;
     mc->no_parallel = 1;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * M_BYTE;
-- 
2.9.3
