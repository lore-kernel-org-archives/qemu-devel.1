Received: from eggs.gnu.org ([2001:4830:134:3::10]:41679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbp0-00069y-1C
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejbov-0004RQ-VH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejbov-0004R7-Qt
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 21:20:17 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  8 Feb 2018 10:19:44 +0800
Message-Id: <20180208021953.7354-8-famz@redhat.com>
In-Reply-To: <20180208021953.7354-1-famz@redhat.com>
References: <20180208021953.7354-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 07/16] stubs: Add stubs for ram block API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

These functions will be wanted by block-obj-y but the actual definition
is in obj-y, so stub them to keep the linker happy.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180110091846.10699-2-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 stubs/Makefile.objs |  1 +
 stubs/ram-block.c   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 stubs/ram-block.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 8cfe34328a..2d59d84091 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -42,3 +42,4 @@ stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
 stub-obj-y += pci-host-piix.o
+stub-obj-y += ram-block.o
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
new file mode 100644
index 0000000000..cfa5d8678f
--- /dev/null
+++ b/stubs/ram-block.c
@@ -0,0 +1,16 @@
+#include "qemu/osdep.h"
+#include "exec/ramlist.h"
+#include "exec/cpu-common.h"
+
+void ram_block_notifier_add(RAMBlockNotifier *n)
+{
+}
+
+void ram_block_notifier_remove(RAMBlockNotifier *n)
+{
+}
+
+int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
+{
+    return 0;
+}
-- 
2.14.3
