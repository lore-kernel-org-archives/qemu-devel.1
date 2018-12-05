Received: from eggs.gnu.org ([2001:4830:134:3::10]:59447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeGS-0008Jv-7a
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeGN-0003ap-MF
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:59:24 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  5 Dec 2018 18:58:27 -0200
Message-Id: <20181205205827.19387-6-ehabkost@redhat.com>
In-Reply-To: <20181205205827.19387-1-ehabkost@redhat.com>
References: <20181205205827.19387-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 5/5] pc: Use default_machine_opts to
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
default_machine_opts on pc_i440fx_2_2_machine_options() to
implement equivalent behavior.

This will let us eliminate the need for pc_compat_*() functions
for PC machine-types.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cfaa83ee2f..c1f6f3dfda 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -320,7 +320,6 @@ static void pc_compat_2_3(MachineState *machine)
 static void pc_compat_2_2(MachineState *machine)
 {
     pc_compat_2_3(machine);
-    machine->suppress_vmdesc = true;
 }
 
 static void pc_compat_2_1(MachineState *machine)
@@ -571,6 +570,7 @@ static void pc_i440fx_2_2_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_2_3_machine_options(m);
     m->hw_version = "2.2.0";
+    m->default_machine_opts = "firmware=bios-256k.bin,suppress-vmdesc=on";
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_2);
     pcmc->rsdp_in_ram = false;
 }
-- 
2.18.0.rc1.1.g3f1ff2140
