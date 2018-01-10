Received: from eggs.gnu.org ([2001:4830:134:3::10]:48803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCXM-0005Kf-Ik
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCXL-0008Ed-Mo
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:19:08 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 10 Jan 2018 17:18:38 +0800
Message-Id: <20180110091846.10699-2-famz@redhat.com>
In-Reply-To: <20180110091846.10699-1-famz@redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/9] stubs: Add stubs for ram block API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

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
