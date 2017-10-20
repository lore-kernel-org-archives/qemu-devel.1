Received: from eggs.gnu.org ([2001:4830:134:3::10]:40306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dBO-00048K-Ca
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dBL-0004cA-9c
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:42:14 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:56473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5dBL-0004bg-5F
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:42:11 -0400
Received: by mail-qt0-x241.google.com with SMTP id z28so19785822qtz.13
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:42:11 -0700 (PDT)
From: Gabriel Augusto Costa <gabriel291075@gmail.com>
Date: Fri, 20 Oct 2017 11:37:54 -0400
Message-Id: <1508513874-15580-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v3 02/11] kinetis_k64_mcg.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
simple arm binary file using UART0 in polling mode.
I have prepared a series of patchs to include this machine:
PATCH v3 n/11: It adds the machine and peripherals devices;
PATCH v4 n/2: It changes the Make files to compile this machine.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 include/hw/misc/kinetis_k64_mcg.h | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 include/hw/misc/kinetis_k64_mcg.h

diff --git a/include/hw/misc/kinetis_k64_mcg.h b/include/hw/misc/kinetis_k64_mcg.h
new file mode 100644
index 0000000..aac7731
--- /dev/null
+++ b/include/hw/misc/kinetis_k64_mcg.h
@@ -0,0 +1,47 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/* Kinetis K64 series MCG controller.  */
+
+#ifndef KINETIS_MCG_H
+#define KINETIS_MCG_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_MCG "kinetis_k64_mcg"
+#define KINETIS_K64_MCG(obj) \
+    OBJECT_CHECK(kinetis_k64_mcg_state, (obj), TYPE_KINETIS_K64_MCG)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t C1;     /**< MCG Control 1 Register, offset: 0x0 */
+    uint8_t C2;     /**< MCG Control 2 Register, offset: 0x1 */
+    uint8_t C3;     /**< MCG Control 3 Register, offset: 0x2 */
+    uint8_t C4;     /**< MCG Control 4 Register, offset: 0x3 */
+    uint8_t C5;     /**< MCG Control 5 Register, offset: 0x4 */
+    uint8_t C6;     /**< MCG Control 6 Register, offset: 0x5 */
+    uint8_t S;      /**< MCG Status Register, offset: 0x6 */
+    uint8_t SC;     /**< MCG Status and Control Register, offset: 0x8 */
+    uint8_t ATCVH;  /**< MCG Auto Trim Compare Value High Register, offset:0xA*/
+    uint8_t ATCVL;  /**< MCG Auto Trim Compare Value Low Register, offset:0xB*/
+    uint8_t C7;     /**< MCG Control 7 Register, offset: 0xC */
+    uint8_t C8;     /**< MCG Control 8 Register, offset: 0xD */
+
+    qemu_irq irq;
+} kinetis_k64_mcg_state;
+
+#endif
-- 
2.1.4
