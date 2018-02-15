Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBF-0007x5-IA
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBE-00045L-Nx
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:57 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBE-00045D-Iv
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:56 -0500
Received: by mail-qt0-x241.google.com with SMTP id u6so10464148qtg.13
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:29:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:45 -0300
Message-Id: <20180215042900.16078-16-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
Subject: [Qemu-devel] [PATCH 15/30] hw/lm32: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>

It ease code review, unit is explicit.
---
 hw/lm32/lm32_boards.c | 12 ++++++------
 hw/lm32/milkymist.c   |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 527bcc229c..15315101be 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -88,10 +88,10 @@ static void lm32_evr_init(MachineState *machine)
 
     /* memory map */
     hwaddr flash_base  = 0x04000000;
-    size_t flash_sector_size       = 256 * 1024;
-    size_t flash_size              = 32 * 1024 * 1024;
+    size_t flash_sector_size       = 256 * K_BYTE;
+    size_t flash_size              = 32 * M_BYTE;
     hwaddr ram_base    = 0x08000000;
-    size_t ram_size                = 64 * 1024 * 1024;
+    size_t ram_size                = 64 * M_BYTE;
     hwaddr timer0_base = 0x80002000;
     hwaddr uart0_base  = 0x80006000;
     hwaddr timer1_base = 0x8000a000;
@@ -174,10 +174,10 @@ static void lm32_uclinux_init(MachineState *machine)
 
     /* memory map */
     hwaddr flash_base   = 0x04000000;
-    size_t flash_sector_size        = 256 * 1024;
-    size_t flash_size               = 32 * 1024 * 1024;
+    size_t flash_sector_size        = 256 * K_BYTE;
+    size_t flash_size               = 32 * M_BYTE;
     hwaddr ram_base     = 0x08000000;
-    size_t ram_size                 = 64 * 1024 * 1024;
+    size_t ram_size                 = 64 * M_BYTE;
     hwaddr uart0_base   = 0x80000000;
     hwaddr timer0_base  = 0x80002000;
     hwaddr timer1_base  = 0x80010000;
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index c28379399f..b884b825bc 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -36,7 +36,7 @@
 
 #define BIOS_FILENAME    "mmone-bios.bin"
 #define BIOS_OFFSET      0x00860000
-#define BIOS_SIZE        (512*1024)
+#define BIOS_SIZE        (512 * K_BYTE)
 #define KERNEL_LOAD_ADDR 0x40000000
 
 typedef struct {
@@ -95,10 +95,10 @@ milkymist_init(MachineState *machine)
 
     /* memory map */
     hwaddr flash_base   = 0x00000000;
-    size_t flash_sector_size        = 128 * 1024;
-    size_t flash_size               = 32 * 1024 * 1024;
+    size_t flash_sector_size        = 128 * K_BYTE;
+    size_t flash_size               = 32 * M_BYTE;
     hwaddr sdram_base   = 0x40000000;
-    size_t sdram_size               = 128 * 1024 * 1024;
+    size_t sdram_size               = 128 * M_BYTE;
 
     hwaddr initrd_base  = sdram_base + 0x1002000;
     hwaddr cmdline_base = sdram_base + 0x1000000;
-- 
2.16.1
