Received: from eggs.gnu.org ([2001:4830:134:3::10]:52125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqF0-0000fh-JY
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEz-00055y-Rk
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqEz-00054A-Km
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:34:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:52 +0100
Message-Id: <1543851204-41186-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 39/71] tests/qgraph: add generic virtio
 testcases
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
 tests/virtio-test.c    | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tests/virtio-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4545232..9603022 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -692,6 +692,7 @@ qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
 qos-test-obj-y += tests/e1000e-test.o
 qos-test-obj-y += tests/pci-test.o
 qos-test-obj-y += tests/sdhci-test.o
+qos-test-obj-y += tests/virtio-test.o
 
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
diff --git a/tests/virtio-test.c b/tests/virtio-test.c
new file mode 100644
index 0000000..804e537
--- /dev/null
+++ b/tests/virtio-test.c
@@ -0,0 +1,25 @@
+/*
+ * QTest testcase for virtio
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
+static void register_virtio_test(void)
+{
+    qos_add_test("nop", "virtio", nop, NULL);
+}
+
+libqos_init(register_virtio_test);
-- 
1.8.3.1
