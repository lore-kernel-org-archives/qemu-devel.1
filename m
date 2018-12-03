Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEl-0000LA-BI
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEj-0004lw-9V
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEj-0004lB-4P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:17 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:42 +0100
Message-Id: <1543851204-41186-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 29/71] tests/qgraph: add generic PCI testcases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include |  1 +
 tests/pci-test.c       | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/pci-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e6be21c..f749fae 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -686,6 +686,7 @@ qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
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
