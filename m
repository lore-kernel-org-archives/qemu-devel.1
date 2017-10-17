Received: from eggs.gnu.org ([2001:4830:134:3::10]:47331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V0x-0002eA-6G
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V0v-0003gb-1L
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 13:44:17 -0300
Message-Id: <20171017164426.25277-34-f4bug@amsat.org>
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 33/42] hw/acpi: ACPI_PM_* defines are not
 restricted to i386 arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

this allows to remove the old i386/pc dependency on acpi/core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/acpi/acpi.h | 11 +++++++++++
 include/hw/i386/pc.h   | 11 -----------
 hw/acpi/core.c         |  1 -
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index 7b3d93cf0d..39ff512129 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -39,6 +39,17 @@
 #define ACPI_PM2_REGISTER_WIDTH         8
 #define ACPI_PM_TIMER_WIDTH             32
 
+/* PC-style peripherals (also used by other machines).  */
+#define ACPI_PM_PROP_S3_DISABLED "disable_s3"
+#define ACPI_PM_PROP_S4_DISABLED "disable_s4"
+#define ACPI_PM_PROP_S4_VAL "s4_val"
+#define ACPI_PM_PROP_SCI_INT "sci_int"
+#define ACPI_PM_PROP_ACPI_ENABLE_CMD "acpi_enable_cmd"
+#define ACPI_PM_PROP_ACPI_DISABLE_CMD "acpi_disable_cmd"
+#define ACPI_PM_PROP_PM_IO_BASE "pm_io_base"
+#define ACPI_PM_PROP_GPE0_BLK "gpe0_blk"
+#define ACPI_PM_PROP_GPE0_BLK_LEN "gpe0_blk_len"
+
 /* PM Timer ticks per second (HZ) */
 #define PM_TIMER_FREQUENCY  3579545
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 087d184ef5..6335e2bf47 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -151,17 +151,6 @@ struct PCMachineClass {
 #define PC_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(PCMachineClass, (klass), TYPE_PC_MACHINE)
 
-/* PC-style peripherals (also used by other machines).  */
-
-#define ACPI_PM_PROP_S3_DISABLED "disable_s3"
-#define ACPI_PM_PROP_S4_DISABLED "disable_s4"
-#define ACPI_PM_PROP_S4_VAL "s4_val"
-#define ACPI_PM_PROP_SCI_INT "sci_int"
-#define ACPI_PM_PROP_ACPI_ENABLE_CMD "acpi_enable_cmd"
-#define ACPI_PM_PROP_ACPI_DISABLE_CMD "acpi_disable_cmd"
-#define ACPI_PM_PROP_PM_IO_BASE "pm_io_base"
-#define ACPI_PM_PROP_GPE0_BLK "gpe0_blk"
-#define ACPI_PM_PROP_GPE0_BLK_LEN "gpe0_blk_len"
 #define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
 
 /* parallel.c */
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index cd0a1d357b..eb9b76f70b 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/config-file.h"
-- 
2.15.0.rc0
