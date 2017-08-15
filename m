Received: from eggs.gnu.org ([2001:4830:134:3::10]:59123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhba3-000843-FO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhba2-0007cx-Kr
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:08:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 21:07:37 +0800
Message-Id: <20170815130740.31229-2-famz@redhat.com>
In-Reply-To: <20170815130740.31229-1-famz@redhat.com>
References: <20170815130740.31229-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2 1/4] stubs: Add vm state change
 handler stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, stefanha@redhat.com

They will be used by BlockBackend code in block-obj-y, which doesn't
always get linked with common-obj-y. Add stubs to keep ld happy.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 stubs/Makefile.objs          |  1 +
 stubs/change-state-handler.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 stubs/change-state-handler.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f5b47bfd74..e69c217aff 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -19,6 +19,7 @@ stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
+stub-obj-y += change-state-handler.o
 stub-obj-y += monitor.o
 stub-obj-y += notify-event.o
 stub-obj-y += qtest.o
diff --git a/stubs/change-state-handler.c b/stubs/change-state-handler.c
new file mode 100644
index 0000000000..01b1c6986d
--- /dev/null
+++ b/stubs/change-state-handler.c
@@ -0,0 +1,14 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+
+VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
+                                                     void *opaque)
+{
+    return NULL;
+}
+
+void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
+{
+    /* Nothing to do. */
+}
-- 
2.13.4
