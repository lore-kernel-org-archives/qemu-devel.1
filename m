Received: from eggs.gnu.org ([2001:4830:134:3::10]:47087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiW-0002DC-14
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiT-00069C-A0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiT-00068y-3X
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:45 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:00 +0200
Message-Id: <1506935300-132598-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 18/38] sh4: shix: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Aurelien Jarno <aurelien@aurel32.net>
---
 hw/sh4/shix.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 50ee36a..4add230 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -45,7 +45,6 @@
 
 static void shix_init(MachineState *machine)
 {
-    const char *cpu_model = machine->cpu_model;
     int ret;
     SuperHCPU *cpu;
     struct SH7750State *s;
@@ -53,10 +52,7 @@ static void shix_init(MachineState *machine)
     MemoryRegion *rom = g_new(MemoryRegion, 1);
     MemoryRegion *sdram = g_new(MemoryRegion, 2);
     
-    if (!cpu_model)
-        cpu_model = "any";
-
-    cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
+    cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
 
     /* Allocate memory space */
     memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
@@ -89,6 +85,7 @@ static void shix_machine_init(MachineClass *mc)
     mc->desc = "shix card";
     mc->init = shix_init;
     mc->is_default = 1;
+    mc->default_cpu_type = TYPE_SH7750R_CPU;
 }
 
 DEFINE_MACHINE("shix", shix_machine_init)
-- 
2.7.4
