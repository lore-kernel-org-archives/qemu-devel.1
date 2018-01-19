Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAd-0002Af-De
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTAc-0000ve-NL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:11 -0500
Received: from ozlabs.org ([103.22.144.67]:47099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTAc-0000tG-CL
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:41:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:09 +1100
Message-Id: <20180119094015.28266-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180119094015.28266-1-david@gibson.dropbear.id.au>
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/13] spapr: drop duplicate variable in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

A variable is already defined at the begining of the function to
hold a pointer to the CPU core object:

    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));

No need to define it again in the pre-2.10 compatibility code snipplet.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 499ab647d8..bca838fce6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3362,9 +3362,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         int i;
 
         for (i = 0; i < cc->nr_threads; i++) {
-            sPAPRCPUCore *sc = SPAPR_CPU_CORE(dev);
-
-            cs = CPU(sc->threads[i]);
+            cs = CPU(core->threads[i]);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
         }
     }
-- 
2.14.3
