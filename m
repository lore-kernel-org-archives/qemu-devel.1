Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ56-000563-Hu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQ55-0003T7-Ja
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:41:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 12:39:58 -0300
Message-Id: <20170922154014.29350-19-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/34] hw/unicore32: restrict hw addr defines
 to source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

and drop unused #includes

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/unicore32/puv3.h | 10 ----------
 hw/unicore32/puv3.c         | 16 ++++++++++------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index 5a4839f8df..f587a1f622 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -14,16 +14,6 @@
 
 #define PUV3_REGS_OFFSET        (0x1000) /* 4K is reasonable */
 
-/* PKUnity System bus (AHB): 0xc0000000 - 0xedffffff (640MB) */
-#define PUV3_DMA_BASE           (0xc0200000) /* AHB-4 */
-
-/* PKUnity Peripheral bus (APB): 0xee000000 - 0xefffffff (128MB) */
-#define PUV3_GPIO_BASE          (0xee500000) /* APB-5 */
-#define PUV3_INTC_BASE          (0xee600000) /* APB-6 */
-#define PUV3_OST_BASE           (0xee800000) /* APB-8 */
-#define PUV3_PM_BASE            (0xeea00000) /* APB-10 */
-#define PUV3_PS2_BASE           (0xeeb00000) /* APB-11 */
-
 /* Hardware interrupts */
 #define PUV3_IRQS_NR            (32)
 
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 504ea46211..6849bac59c 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -11,16 +11,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "ui/console.h"
-#include "elf.h"
-#include "exec/address-spaces.h"
-#include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
-#include "hw/i386/pc.h"
-#include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 
 #undef DEBUG_PUV3
@@ -29,6 +23,16 @@
 #define KERNEL_LOAD_ADDR        0x03000000
 #define KERNEL_MAX_SIZE         0x00800000 /* Just a guess */
 
+/* PKUnity System bus (AHB): 0xc0000000 - 0xedffffff (640MB) */
+#define PUV3_DMA_BASE           (0xc0200000) /* AHB-4 */
+
+/* PKUnity Peripheral bus (APB): 0xee000000 - 0xefffffff (128MB) */
+#define PUV3_GPIO_BASE          (0xee500000) /* APB-5 */
+#define PUV3_INTC_BASE          (0xee600000) /* APB-6 */
+#define PUV3_OST_BASE           (0xee800000) /* APB-8 */
+#define PUV3_PM_BASE            (0xeea00000) /* APB-10 */
+#define PUV3_PS2_BASE           (0xeeb00000) /* APB-11 */
+
 static void puv3_intc_cpu_handler(void *opaque, int irq, int level)
 {
     UniCore32CPU *cpu = opaque;
-- 
2.14.1
