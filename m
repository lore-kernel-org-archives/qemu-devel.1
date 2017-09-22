Received: from eggs.gnu.org ([2001:4830:134:3::10]:41361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4c-0004Yu-3r
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ4a-0003Ak-Uj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:48 -0300
Message-Id: <20170922154014.29350-9-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/34] nios2: remove duplicated includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/nios2/cpu.h       | 1 -
 disas/nios2.c            | 3 ---
 hw/nios2/boot.c          | 1 -
 target/nios2/helper.c    | 7 ++-----
 target/nios2/op_helper.c | 1 +
 target/nios2/translate.c | 1 +
 6 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 50d803a217..fda02c39b9 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -20,7 +20,6 @@
 #ifndef CPU_NIOS2_H
 #define CPU_NIOS2_H
 
-#include "qemu/osdep.h"
 #include "qemu-common.h"
 
 #define TARGET_LONG_BITS 32
diff --git a/disas/nios2.c b/disas/nios2.c
index b342936d21..de11f04cc4 100644
--- a/disas/nios2.c
+++ b/disas/nios2.c
@@ -1756,7 +1756,6 @@ extern const int nios2_num_r2_reg_range_mappings;
 #endif /* _NIOS2_H */
 
 /*#include "sysdep.h"
-#include <stdio.h>
 #include "opcode/nios2.h"
 */
 /* Register string table */
@@ -2521,8 +2520,6 @@ const int nios2_num_r2_reg_range_mappings = 8;
 #include "dis-asm.h"
 #include "opcode/nios2.h"
 #include "libiberty.h"
-#include <string.h>
-#include <assert.h>
 */
 /* No symbol table is available when this code runs out in an embedded
    system as when it is used for disassembler support in a monitor.  */
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 2b31f5b844..94f436e7fb 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -34,7 +34,6 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index ef9ee05798..9f741a8f19 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -18,12 +18,9 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
-#include <stdio.h>
-#include <string.h>
-#include <assert.h>
-
-#include "cpu.h"
 #include "qemu/osdep.h"
+
+#include "cpu.h"
 #include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "exec/exec-all.h"
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index efb1c489c9..c853aeae02 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -18,6 +18,7 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
+#include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 6b0961837d..796d399bd1 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -21,6 +21,7 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
+#include "qemu/osdep.h"
 #include "cpu.h"
 #include "tcg-op.h"
 #include "exec/exec-all.h"
-- 
2.14.1
