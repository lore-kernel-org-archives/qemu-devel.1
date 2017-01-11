Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgT-00039E-7u
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgS-0003LR-5M
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:45 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:33869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgR-0003LH-V5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:44 -0500
Received: by mail-wj0-x244.google.com with SMTP id qs7so54428104wjc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:43 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:05 +0100
Message-Id: <1484163327-111841-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/33] stubs: group all monitor_fdset_*
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
1.8.3.1
