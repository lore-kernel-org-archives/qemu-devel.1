Received: from eggs.gnu.org ([2001:4830:134:3::10]:37988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96E-0004JB-Vx
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96D-0002E4-M0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:10 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:54093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96D-0002Bm-Du
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:09 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b188-v6so4122502wme.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:18 +0200
Message-Id: <20180630061040.6018-26-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/47] hw/tricore: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20180625124238.25339-24-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/tricore/tricore_testboard.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8e61dfc..a58096f 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -19,6 +19,7 @@
 
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -72,17 +73,17 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
     memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
-                           2 * 1024 * 1024, &error_fatal);
+                           2 * MiB, &error_fatal);
     memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram",
-                           4 * 1024 * 1024, &error_fatal);
-    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48 * 1024,
+                           4 * MiB, &error_fatal);
+    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48 * KiB,
                            &error_fatal);
-    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48 * 1024,
+    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48 * KiB,
                            &error_fatal);
     memory_region_init_ram(pcp_data, NULL, "powerlink_pcp_data.ram",
-                           16 * 1024, &error_fatal);
+                           16 * KiB, &error_fatal);
     memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram",
-                           32 * 1024, &error_fatal);
+                           32 * KiB, &error_fatal);
 
     memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
     memory_region_add_subregion(sysmem, 0xa1000000, ext_dram);
-- 
1.8.3.1
