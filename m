Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSu-0007FQ-EL
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSt-0002mc-Ji
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:08 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSt-0002mT-Ee
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:07 -0500
Received: by mail-qt0-x244.google.com with SMTP id 33so12079467qtv.1
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:46 -0300
Message-Id: <20180108024558.17983-18-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/29] piix: move piix4 declaration into new
 southbridge/i82371_piix.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/pc.h                 |  2 --
 include/hw/southbridge/i82371_piix.h | 17 +++++++++++++++++
 hw/isa/piix4.c                       |  1 +
 hw/mips/gt64xxx_pci.c                |  1 +
 MAINTAINERS                          |  1 +
 5 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/southbridge/i82371_piix.h

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d2b67e44a7..195c02febe 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -272,8 +272,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
                     MemoryRegion *ram_memory);
 
 PCIBus *find_i440fx(void);
-/* piix4.c */
-extern PCIDevice *piix4_dev;
 
 /* pc_sysfw.c */
 void pc_system_firmware_init(MemoryRegion *rom_memory,
diff --git a/include/hw/southbridge/i82371_piix.h b/include/hw/southbridge/i82371_piix.h
new file mode 100644
index 0000000000..95ac25becd
--- /dev/null
+++ b/include/hw/southbridge/i82371_piix.h
@@ -0,0 +1,17 @@
+/*
+ * Intel 82371 PIIX South Bridge Emulation
+ *
+ * Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef HW_ISA_PIIX_H
+#define HW_ISA_PIIX_H
+
+#include "hw/pci/pci.h"
+
+/* piix4.c */
+extern PCIDevice *piix4_dev;
+
+#endif /* HW_ISA_PIIX_H */
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index c19aa5a74f..b0f6a0a342 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -28,6 +28,7 @@
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "hw/sysbus.h"
 
 PCIDevice *piix4_dev;
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 5a9dad9aae..24cc4044d7 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
+#include "hw/southbridge/i82371_piix.h"
 #include "exec/address-spaces.h"
 
 //#define DEBUG
diff --git a/MAINTAINERS b/MAINTAINERS
index 6f867da743..cead15b69b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -888,6 +888,7 @@ F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/isa/superio.h
 F: include/hw/input/i8042.h
+F: include/hw/southbridge/i82371_piix.h
 F: include/hw/timer/hpet.h
 F: include/hw/timer/i8254*
 F: include/hw/timer/mc146818rtc*
-- 
2.15.1
