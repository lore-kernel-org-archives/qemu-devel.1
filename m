Received: from eggs.gnu.org ([209.51.188.92]:39406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqe-00031W-Ss
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1wqe-0007zs-3i
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:56277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1wqd-0007zI-Ro
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:30:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id q187so10149493wme.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:30:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Mar 2019 18:29:22 +0100
Message-Id: <1551979804-6060-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
References: <1551979804-6060-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/57] tests/qgraph: add generic PCI testcases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lviver@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  1 +
 tests/pci-test.c       | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/pci-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4b545ac..4391b7f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -760,6 +760,7 @@ qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
 qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 
 # Tests
+qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
diff --git a/tests/pci-test.c b/tests/pci-test.c
new file mode 100644
index 0000000..ff80985
--- /dev/null
+++ b/tests/pci-test.c
@@ -0,0 +1,25 @@
+/*
+ * QTest testcase for PCI
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
+
+/* Tests only initialization so far. TODO: Replace with functional tests */
+static void nop(void *obj, void *data, QGuestAllocator *alloc)
+{
+}
+
+static void register_pci_test(void)
+{
+    qos_add_test("nop", "pci-device", nop, NULL);
+}
+
+libqos_init(register_pci_test);
-- 
1.8.3.1
