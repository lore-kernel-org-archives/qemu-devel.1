Received: from eggs.gnu.org ([2001:4830:134:3::10]:57984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd2-0000oe-Qh
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd0-000054-Pw
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAd0-00004s-Hn
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:30 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B5A4C04B302
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:30 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGUw001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:29 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:55 +0100
Message-Id: <20170116165916.8575-12-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/32] stubs: group all monitor_fdset_*
 functions in a single file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It makes little sense to implement only one of them, so avoid
proliferation of stubs files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/Makefile.objs     |  5 +----
 stubs/fdset-add-fd.c    |  8 --------
 stubs/fdset-find-fd.c   |  8 --------
 stubs/fdset-get-fd.c    |  8 --------
 stubs/fdset-remove-fd.c |  7 -------
 stubs/fdset.c           | 22 ++++++++++++++++++++++
 6 files changed, 23 insertions(+), 35 deletions(-)
 delete mode 100644 stubs/fdset-add-fd.c
 delete mode 100644 stubs/fdset-find-fd.c
 delete mode 100644 stubs/fdset-get-fd.c
 delete mode 100644 stubs/fdset-remove-fd.c
 create mode 100644 stubs/fdset.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 1eec1fb..40b4e15 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -10,10 +10,7 @@ stub-obj-y += cpu-get-clock.o
 stub-obj-y += cpu-get-icount.o
 stub-obj-y += dump.o
 stub-obj-y += error-printf.o
-stub-obj-y += fdset-add-fd.o
-stub-obj-y += fdset-find-fd.o
-stub-obj-y += fdset-get-fd.o
-stub-obj-y += fdset-remove-fd.o
+stub-obj-y += fdset.o
 stub-obj-y += gdbstub.o
 stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
diff --git a/stubs/fdset-add-fd.c b/stubs/fdset-add-fd.c
deleted file mode 100644
index bf9e60a..0000000
--- a/stubs/fdset-add-fd.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "monitor/monitor.h"
-
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
-{
-    return -1;
-}
diff --git a/stubs/fdset-find-fd.c b/stubs/fdset-find-fd.c
deleted file mode 100644
index 1d9caf3..0000000
--- a/stubs/fdset-find-fd.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "monitor/monitor.h"
-
-int monitor_fdset_dup_fd_find(int dup_fd)
-{
-    return -1;
-}
diff --git a/stubs/fdset-get-fd.c b/stubs/fdset-get-fd.c
deleted file mode 100644
index 5325044..0000000
--- a/stubs/fdset-get-fd.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "monitor/monitor.h"
-
-int monitor_fdset_get_fd(int64_t fdset_id, int flags)
-{
-    return -1;
-}
diff --git a/stubs/fdset-remove-fd.c b/stubs/fdset-remove-fd.c
deleted file mode 100644
index 47ea297..0000000
--- a/stubs/fdset-remove-fd.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "monitor/monitor.h"
-
-void monitor_fdset_dup_fd_remove(int dupfd)
-{
-}
diff --git a/stubs/fdset.c b/stubs/fdset.c
new file mode 100644
index 0000000..6020cf2
--- /dev/null
+++ b/stubs/fdset.c
@@ -0,0 +1,22 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "monitor/monitor.h"
+
+int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
+{
+    return -1;
+}
+
+int monitor_fdset_dup_fd_find(int dup_fd)
+{
+    return -1;
+}
+
+int monitor_fdset_get_fd(int64_t fdset_id, int flags)
+{
+    return -1;
+}
+
+void monitor_fdset_dup_fd_remove(int dupfd)
+{
+}
-- 
2.9.3
