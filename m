Received: from eggs.gnu.org ([2001:4830:134:3::10]:59278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeGC-00085X-7G
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeGB-0002jv-Ey
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:59:08 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  5 Dec 2018 18:58:25 -0200
Message-Id: <20181205205827.19387-4-ehabkost@redhat.com>
In-Reply-To: <20181205205827.19387-1-ehabkost@redhat.com>
References: <20181205205827.19387-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 3/5] spapr: Use default_machine_opts to
 set suppress_vmdesc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

Instead of setting suppress_vmdesc at instance_init time, set
default_machine_opts on spapr_machine_2_2_class_options() to
implement equivalent behavior.

This will let us eliminate the need for separate instance_init
functions for each spapr machine-type.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f6b60e6fbd..0c3b27a8cc 100644
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
