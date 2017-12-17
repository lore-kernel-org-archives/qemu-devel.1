Received: from eggs.gnu.org ([2001:4830:134:3::10]:57383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhg9-0006GK-6o
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhg4-0004wA-CI
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:45:05 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:54 +0300
Message-Id: <52d51afc0ff3de17d916adef09863e9a66f7ae0a.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 49/61] hw/unicore32: restrict hw addr defines to
 source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

and drop unused #includes

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/unicore32/puv3.c         | 15 ++++++++++-----
 include/hw/unicore32/puv3.h | 10 ----------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 1b39cc035b..db26959a1d 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -11,16 +11,11 @@
=20
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
 #include "hw/i386/pc.h"
-#include "qemu/error-report.h"
 #include "sysemu/qtest.h"
=20
 #undef DEBUG_PUV3
@@ -29,6 +24,16 @@
 #define KERNEL_LOAD_ADDR        0x03000000
 #define KERNEL_MAX_SIZE         0x00800000 /* Just a guess */
=20
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
     UniCore32CPU *cpu =3D opaque;
diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index 5a4839f8df..f587a1f622 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -14,16 +14,6 @@
=20
 #define PUV3_REGS_OFFSET        (0x1000) /* 4K is reasonable */
=20
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
=20
--=20
2.11.0
