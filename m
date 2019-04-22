Received: from eggs.gnu.org ([209.51.188.92]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexw-0004eI-N2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexv-0008CC-Jt
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:00 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 22 Apr 2019 21:50:16 +0200
Message-Id: <20190422195020.1494-4-philmd@redhat.com>
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
References: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/7] hw/i386: Extract fw_cfg definitions to
 local "fw_cfg.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Extract the architecture-specific fw_cfg definitions to "fw_cfg.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/fw_cfg.h | 20 ++++++++++++++++++++
 hw/i386/pc.c     |  7 +------
 2 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 hw/i386/fw_cfg.h

diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
new file mode 100644
index 00000000000..17a4bc32f22
--- /dev/null
+++ b/hw/i386/fw_cfg.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU fw_cfg helpers (X86 specific)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_I386_FW_CFG_H
+#define HW_I386_FW_CFG_H
+
+#include "hw/nvram/fw_cfg.h"
+
+#define FW_CFG_ACPI_TABLES      (FW_CFG_ARCH_LOCAL + 0)
+#define FW_CFG_SMBIOS_ENTRIES   (FW_CFG_ARCH_LOCAL + 1)
+#define FW_CFG_IRQ0_OVERRIDE    (FW_CFG_ARCH_LOCAL + 2)
+#define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
+#define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
+
+#endif
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2c..acb8fd9667d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -30,6 +30,7 @@
 #include "hw/char/parallel.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
+#include "hw/i386/fw_cfg.h"
 #include "sysemu/cpus.h"
 #include "hw/block/fdc.h"
 #include "hw/ide.h"
@@ -88,12 +89,6 @@
 #define DPRINTF(fmt, ...)
 #endif
=20
-#define FW_CFG_ACPI_TABLES (FW_CFG_ARCH_LOCAL + 0)
-#define FW_CFG_SMBIOS_ENTRIES (FW_CFG_ARCH_LOCAL + 1)
-#define FW_CFG_IRQ0_OVERRIDE (FW_CFG_ARCH_LOCAL + 2)
-#define FW_CFG_E820_TABLE (FW_CFG_ARCH_LOCAL + 3)
-#define FW_CFG_HPET (FW_CFG_ARCH_LOCAL + 4)
-
 #define E820_NR_ENTRIES		16
=20
 struct e820_entry {
--=20
2.20.1
