Received: from eggs.gnu.org ([2001:4830:134:3::10]:38164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdT5-00042l-7x
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhdT4-0002Yd-DM
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhdT4-0002Y7-7D
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:09:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48D86C058EB7
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 15:09:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 15 Aug 2017 10:09:03 -0500
Message-Id: <20170815150907.21495-4-eblake@redhat.com>
In-Reply-To: <20170815150907.21495-1-eblake@redhat.com>
References: <20170815150907.21495-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] stubs: Add vm state change handler stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Fam Zheng <famz@redhat.com>

They will be used by BlockBackend code in block-obj-y, which doesn't
always get linked with common-obj-y. Add stubs to keep ld happy.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170815130740.31229-2-famz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 stubs/change-state-handler.c | 14 ++++++++++++++
 stubs/Makefile.objs          |  1 +
 2 files changed, 15 insertions(+)
 create mode 100644 stubs/change-state-handler.c

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
-- 
2.13.5
