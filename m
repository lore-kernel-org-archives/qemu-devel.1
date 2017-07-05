Received: from eggs.gnu.org ([2001:4830:134:3::10]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUA-0004y1-JX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkU9-0004Fb-Rk
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:36:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  5 Jul 2017 21:36:30 +0800
Message-Id: <20170705133635.11850-2-famz@redhat.com>
In-Reply-To: <20170705133635.11850-1-famz@redhat.com>
References: <20170705133635.11850-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/6] stubs: Add stubs for ram block API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

These functions will be wanted by block-obj-y but the actual definition
is in obj-y, so stub them to keep the linker happy.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/Makefile.objs |  1 +
 stubs/ram-block.c   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 stubs/ram-block.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f5b47bf..c93a800 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -39,3 +39,4 @@ stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
+stub-obj-y += ram-block.o
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
new file mode 100644
index 0000000..cfa5d86
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
2.9.4
