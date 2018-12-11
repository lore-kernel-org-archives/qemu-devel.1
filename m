Received: from eggs.gnu.org ([2001:4830:134:3::10]:41525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMY-0005hq-Oc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMV-0005IB-N2
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMV-0005BB-Cc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:27 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:21 -0200
Message-Id: <20181211180129.7661-17-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 16/24] spapr: Use default_machine_opts to set
 suppress_vmdesc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Instead of setting suppress_vmdesc at instance_init time, set
default_machine_opts on spapr_machine_2_2_class_options() to
implement equivalent behavior.

This will let us eliminate the need for separate instance_init
functions for each spapr machine-type.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181205205827.19387-4-ehabkost@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a3f4c86a44..fa3c74e81d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4368,13 +4368,13 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
 static void spapr_machine_2_2_instance_options(MachineState *machine)
 {
     spapr_machine_2_3_instance_options(machine);
-    machine->suppress_vmdesc = true;
 }
 
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     spapr_machine_2_3_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_2);
+    mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
 }
 DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
 
-- 
2.18.0.rc1.1.g3f1ff2140
