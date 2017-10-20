Received: from eggs.gnu.org ([2001:4830:134:3::10]:40412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dBz-0004ZD-3v
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dBw-0004ua-0u
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:42:51 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:48113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5dBv-0004uE-Rr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:42:47 -0400
Received: by mail-qt0-x244.google.com with SMTP id z50so19808467qtj.4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:42:47 -0700 (PDT)
From: Gabriel Augusto Costa <gabriel291075@gmail.com>
Date: Fri, 20 Oct 2017 11:38:31 -0400
Message-Id: <1508513911-15630-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v3 03/11] kinetis_k64_pmux.h has been added
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
 include/hw/misc/kinetis_k64_pmux.h | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 include/hw/misc/kinetis_k64_pmux.h

diff --git a/include/hw/misc/kinetis_k64_pmux.h b/include/hw/misc/kinetis_k64_pmux.h
new file mode 100644
index 0000000..fb6a6d5
--- /dev/null
+++ b/include/hw/misc/kinetis_k64_pmux.h
@@ -0,0 +1,73 @@
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
+/* Kinetis K64 series PMUX controller.  */
+
+#ifndef KINETIS_PMUX_H
+#define KINETIS_PMUX_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_PMUX "kinetis_k64_pmux"
+#define KINETIS_K64_PMUX(obj) \
+    OBJECT_CHECK(kinetis_k64_pmux_state, (obj), TYPE_KINETIS_K64_PMUX)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t PCR00;/**< Pin Control Register n, offset: 0x0, array step: 0x4 */
+    uint32_t PCR01;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR02;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR03;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR04;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR05;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR06;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR07;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR08;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR09;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR10;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR11;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR12;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR13;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR14;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR15;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR16;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR17;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR18;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR19;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR20;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR21;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR22;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR23;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR24;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR25;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR26;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR27;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR28;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR29;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR30;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t PCR31;     /**< Pin Control Register n, offset: 0x0, step: 0x4 */
+    uint32_t GPCLR;     /**< Global Pin Control Low Register, offset: 0x80 */
+    uint32_t GPCHR;     /**< Global Pin Control High Register, offset: 0x84 */
+    uint32_t ISFR;      /**< Interrupt Status Flag Register, offset: 0xA0 */
+    uint32_t DFER;      /**< Digital Filter Enable Register, offset: 0xC0 */
+    uint32_t DFCR;      /**< Digital Filter Clock Register, offset: 0xC4 */
+    uint32_t DFWR;      /**< Digital Filter Width Register, offset: 0xC8 */
+
+    qemu_irq irq;
+} kinetis_k64_pmux_state;
+
+#endif
-- 
2.1.4
