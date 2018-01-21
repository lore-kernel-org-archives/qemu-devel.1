Received: from eggs.gnu.org ([2001:4830:134:3::10]:36121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gh-0000Zi-7b
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Ge-0007LY-ST
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 21 Jan 2018 16:33:47 +1100
Message-Id: <20180121053353.25970-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180121053353.25970-1-david@gibson.dropbear.id.au>
References: <20180121053353.25970-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/12] spapr: drop duplicate variable in
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, David Gibson <david@gibson.dropbear.id.au>

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
index a781dd22e7..fe38c56ff3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3357,9 +3357,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
