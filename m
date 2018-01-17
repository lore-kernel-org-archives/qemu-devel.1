Received: from eggs.gnu.org ([2001:4830:134:3::10]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebjtb-0000fS-61
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebjtX-0006l8-U6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:35 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:60724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ebjtX-0006k2-No
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 04:20:31 -0500
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 395A78F163
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 10:20:30 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 17 Jan 2018 10:20:27 +0100
Message-ID: <151618082784.20461.10973754439669848191.stgit@bahia.lan>
In-Reply-To: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
References: <151618081462.20461.3393245354775542888.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] spapr: drop duplicate variable in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

A variable is already defined at the begining of the function to
hold a pointer to the CPU core object:

    sPAPRCPUCore *core = SPAPR_CPU_CORE(OBJECT(dev));

No need to define it again in the pre-2.10 compatibility code snipplet.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 499ab647d882..bca838fce638 100644
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
