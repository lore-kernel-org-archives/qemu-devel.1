Received: from eggs.gnu.org ([2001:4830:134:3::10]:57765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhT6H-0007XP-F4
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhT6G-00054f-O2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:05:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 12:04:51 +0800
Message-Id: <20170815040454.4223-2-famz@redhat.com>
In-Reply-To: <20170815040454.4223-1-famz@redhat.com>
References: <20170815040454.4223-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/4] stubs: Add vm state change
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

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
index 0000000000..9833ba4e94
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
+    return g_malloc0(1);
+}
+
+void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
+{
+    g_free(e);
+}
-- 
2.13.4
