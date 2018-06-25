Received: from eggs.gnu.org ([2001:4830:134:3::10]:54563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqy-0001vW-Tr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQqy-00081a-3m
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:44:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:17 -0300
Message-Id: <20180625124238.25339-26-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 25/46] hw/nios2: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/nios2/boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 94f436e7fb..4bb5b601d3 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/option.h"
@@ -38,7 +39,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "qemu/cutils.h"
 
 #include "boot.h"
 
@@ -177,7 +177,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
             high = ddr_base + kernel_size;
         }
 
-        high = ROUND_UP(high, 1024 * 1024);
+        high = ROUND_UP(high, 1 * MiB);
 
         /* If initrd is available, it goes after the kernel, aligned to 1M. */
         if (initrd_filename) {
@@ -213,7 +213,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
         high += fdt_size;
 
         /* Kernel command is at the end, 4k aligned. */
-        boot_info.cmdline = ROUND_UP(high, 4096);
+        boot_info.cmdline = ROUND_UP(high, 4 * KiB);
         if (kernel_cmdline && strlen(kernel_cmdline)) {
             pstrcpy_targphys("cmdline", boot_info.cmdline, 256, kernel_cmdline);
         }
-- 
2.18.0
