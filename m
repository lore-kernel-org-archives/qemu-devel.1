Received: from eggs.gnu.org ([2001:4830:134:3::10]:34556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBN-00082R-EA
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBM-000494-H6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:05 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBM-00048v-Cq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:04 -0500
Received: by mail-qk0-x243.google.com with SMTP id h129so9490441qke.8
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:48 -0300
Message-Id: <20180215042900.16078-19-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/30] hw/microblaze: use the BYTE-based
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/microblaze/petalogix_ml605_mmu.c      | 6 +++---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b664dc0f9c..d2b316fcba 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -45,8 +45,8 @@
 
 #include "hw/stream.h"
 
-#define LMB_BRAM_SIZE  (128 * 1024)
-#define FLASH_SIZE     (32 * 1024 * 1024)
+#define LMB_BRAM_SIZE  (128 * K_BYTE)
+#define FLASH_SIZE     (32 * M_BYTE)
 
 #define BINARY_DEVICE_TREE_FILE "petalogix-ml605.dtb"
 
@@ -110,7 +110,7 @@ petalogix_ml605_init(MachineState *machine)
     pflash_cfi01_register(FLASH_BASEADDR,
                           NULL, "petalogix_ml605.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          (64 * 1024), FLASH_SIZE >> 16,
+                          64 * K_BYTE, FLASH_SIZE >> 16,
                           2, 0x89, 0x18, 0x0000, 0x0, 0);
 
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 5cb4deb69e..d93f7184a5 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -40,8 +40,8 @@
 
 #include "boot.h"
 
-#define LMB_BRAM_SIZE  (128 * 1024)
-#define FLASH_SIZE     (16 * 1024 * 1024)
+#define LMB_BRAM_SIZE  (128 * K_BYTE)
+#define FLASH_SIZE     (16 * M_BYTE)
 
 #define BINARY_DEVICE_TREE_FILE "petalogix-s3adsp1800.dtb"
 
@@ -88,7 +88,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     pflash_cfi01_register(FLASH_BASEADDR,
                           NULL, "petalogix_s3adsp1800.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          (64 * 1024), FLASH_SIZE >> 16,
+                          64 * K_BYTE, FLASH_SIZE >> 16,
                           1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     dev = qdev_create(NULL, "xlnx.xps-intc");
-- 
2.16.1
