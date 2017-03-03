Received: from eggs.gnu.org ([2001:4830:134:3::10]:44203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqU-00083q-LU
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjdqT-0001LV-Lx
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 22:25:30 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  3 Mar 2017 14:25:00 +1100
Message-Id: <20170303032507.16142-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/17] hw/ppc/spapr: Add POWER9 to pseries cpu
 models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add POWER9 cpu to list of spapr core models which allows it to be specified
as the cpu model for a pseries guest (e.g. -machine pseries -cpu POWER9).

This now allows a POWER9 cpu to boot to userspace in tcg emulation for a
pseries machine with a legacy kernel.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 90d682f..d37832d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -238,6 +238,9 @@ static const char *spapr_core_models[] = {
 
     /* POWER8NVL */
     "POWER8NVL_v1.0",
+
+    /* POWER9 */
+    "POWER9_v1.0",
 };
 
 void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
-- 
2.9.3
