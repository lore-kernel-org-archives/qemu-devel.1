Received: from eggs.gnu.org ([2001:4830:134:3::10]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgii-0002NH-4k
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgig-0004p9-W7
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:49 -0300
Message-Id: <20171215033015.738-18-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 17/43] nios2: remove duplicated includes (in
 code commented out)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

applied using ./scripts/clean-includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/nios2/cpu.h       | 1 -
 disas/nios2.c            | 3 ---
 hw/nios2/boot.c          | 1 -
 target/nios2/helper.c    | 5 +----
 target/nios2/op_helper.c | 1 +
 target/nios2/translate.c | 1 +
 6 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 9119eee587..88823a6d4d 100644
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
+#include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "qemu/osdep.h"
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
index 72329002ac..51a54ff760 100644
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
2.15.1
