Received: from eggs.gnu.org ([2001:4830:134:3::10]:34527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBL-0007zm-2q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBK-00047G-7i
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:03 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBK-00047C-3t
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:02 -0500
Received: by mail-qk0-x241.google.com with SMTP id g2so8417542qkd.12
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:47 -0300
Message-Id: <20180215042900.16078-18-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/30] hw/tricore: use the BYTE-based
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/tricore/tricore_testboard.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index ac75eb2128..032bcc8efb 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -74,17 +74,17 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
     memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
-                           2 * 1024 * 1024, &error_fatal);
+                           2 * M_BYTE, &error_fatal);
     memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram",
-                           4 * 1024 * 1024, &error_fatal);
-    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48 * 1024,
+                           4 * M_BYTE, &error_fatal);
+    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48 * K_BYTE,
                            &error_fatal);
-    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48 * 1024,
+    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48 * K_BYTE,
                            &error_fatal);
     memory_region_init_ram(pcp_data, NULL, "powerlink_pcp_data.ram",
-                           16 * 1024, &error_fatal);
+                           16 * K_BYTE, &error_fatal);
     memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram",
-                           32 * 1024, &error_fatal);
+                           32 * K_BYTE, &error_fatal);
 
     memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
     memory_region_add_subregion(sysmem, 0xa1000000, ext_dram);
-- 
2.16.1
