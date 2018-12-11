Received: from eggs.gnu.org ([2001:4830:134:3::10]:41524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMY-0005hp-Od
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMW-0005Jb-Sj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMW-0005Ia-HU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:28 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:23 -0200
Message-Id: <20181211180129.7661-19-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 18/24] pc: Use default_machine_opts to set
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
default_machine_opts on pc_i440fx_2_2_machine_options() to
implement equivalent behavior.

This will let us eliminate the need for pc_compat_*() functions
for PC machine-types.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181205205827.19387-6-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d9b04c8427..6981cfa740 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -321,7 +321,6 @@ static void pc_compat_2_3(MachineState *machine)
 static void pc_compat_2_2(MachineState *machine)
 {
     pc_compat_2_3(machine);
-    machine->suppress_vmdesc = true;
 }
 
 static void pc_compat_2_1(MachineState *machine)
@@ -572,6 +571,7 @@ static void pc_i440fx_2_2_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_2_3_machine_options(m);
     m->hw_version = "2.2.0";
+    m->default_machine_opts = "firmware=bios-256k.bin,suppress-vmdesc=on";
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_2);
     pcmc->rsdp_in_ram = false;
 }
-- 
2.18.0.rc1.1.g3f1ff2140
