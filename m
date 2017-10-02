Received: from eggs.gnu.org ([2001:4830:134:3::10]:47291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywis-0002ZK-Pt
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywir-0006LP-N5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywir-0006L6-Gg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:09 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:18 +0200
Message-Id: <1506935300-132598-37-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 36/38] mips: Magnum/Acer Pica 61: replace
 cpu_model with cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, hpoussin@reactos.org, aurelien@aurel32.net, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: hpoussin@reactos.org
CC: aurelien@aurel32.net
CC: yongbok.kim@imgtec.com
---
 hw/mips/mips_jazz.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 7e6626d..fe4f173 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -122,7 +122,6 @@ static void mips_jazz_init(MachineState *machine,
                            enum jazz_model_e jazz_model)
 {
     MemoryRegion *address_space = get_system_memory();
-    const char *cpu_model = machine->cpu_model;
     char *filename;
     int bios_size, n;
     MIPSCPU *cpu;
@@ -148,10 +147,7 @@ static void mips_jazz_init(MachineState *machine,
     MemoryRegion *bios2 = g_new(MemoryRegion, 1);
 
     /* init CPUs */
-    if (cpu_model == NULL) {
-        cpu_model = "R4000";
-    }
-    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
@@ -349,6 +345,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->desc = "MIPS Magnum";
     mc->init = mips_magnum_init;
     mc->block_default_type = IF_SCSI;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -364,6 +361,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->desc = "Acer Pica 61";
     mc->init = mips_pica61_init;
     mc->block_default_type = IF_SCSI;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
 }
 
 static const TypeInfo mips_pica61_type = {
-- 
2.7.4
