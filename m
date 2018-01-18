Received: from eggs.gnu.org ([2001:4830:134:3::10]:46122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfP-0000rq-2l
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfL-0004nC-3a
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:10:59 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:49 -0200
Message-Id: <20180118021000.27203-9-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/19] ppc: e500: Allow only supported dynamic
 sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

platform_bus_create_devtree() already rejects all dynamic sysbus
devices except TYPE_ETSEC_COMMON, so register it as the only
allowed dynamic sysbus device for the ppce500 machine-type.

Cc: Alexander Graf <agraf@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20171125151610.20547-4-ehabkost@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/e500plat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 438118c29b..81d03e1038 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "e500.h"
+#include "hw/net/fsl_etsec/etsec.h"
 #include "hw/boards.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/kvm.h"
@@ -64,8 +65,7 @@ static void e500plat_machine_init(MachineClass *mc)
     mc->desc = "generic paravirt e500 platform";
     mc->init = e500plat_init;
     mc->max_cpus = 32;
-    /*TODO: allow only sysbus devices that really work with this machine */
-    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
 }
 
-- 
2.14.3
