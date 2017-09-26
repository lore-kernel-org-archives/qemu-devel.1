Received: from eggs.gnu.org ([2001:4830:134:3::10]:58653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnf2-0002yZ-Im
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnew-00088Z-OQ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:20 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51600)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnew-00088E-8H
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:14 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:04:11 +0300
Message-ID: <150642385177.3900.1958854094941574053.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 01/43] windbg: added empty windbgstub files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 Makefile.target                 |    5 +++++
 include/exec/windbgstub-utils.h |   18 ++++++++++++++++++
 include/exec/windbgstub.h       |   17 +++++++++++++++++
 windbgstub-utils.c              |   12 ++++++++++++
 windbgstub.c                    |   18 ++++++++++++++++++
 5 files changed, 70 insertions(+)
 create mode 100755 include/exec/windbgstub-utils.h
 create mode 100755 include/exec/windbgstub.h
 create mode 100755 windbgstub-utils.c
 create mode 100755 windbgstub.c

diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..0272b5e0ab 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -148,6 +148,11 @@ obj-y += dump.o
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
 
+# WinDbg support
+ifeq ($(TARGET_NAME), i386)
+obj-y += windbgstub.o windbgstub-utils.o
+endif
+
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
 obj-y += hw/sparc64/
diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
new file mode 100755
index 0000000000..67d190bf6c
--- /dev/null
+++ b/include/exec/windbgstub-utils.h
@@ -0,0 +1,18 @@
+/*
+ * windbgstub-utils.h
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef WINDBGSTUB_UTILS_H
+#define WINDBGSTUB_UTILS_H
+
+#include "qemu/osdep.h"
+#include "exec/windbgstub.h"
+
+#endif
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
new file mode 100755
index 0000000000..1a6e1cc6e5
--- /dev/null
+++ b/include/exec/windbgstub.h
@@ -0,0 +1,17 @@
+/*
+ * windbgstub.h
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef WINDBGSTUB_H
+#define WINDBGSTUB_H
+
+int windbg_server_start(const char *device);
+
+#endif
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
new file mode 100755
index 0000000000..dc5e505c63
--- /dev/null
+++ b/windbgstub-utils.c
@@ -0,0 +1,12 @@
+/*
+ * windbgstub-utils.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "exec/windbgstub-utils.h"
diff --git a/windbgstub.c b/windbgstub.c
new file mode 100755
index 0000000000..4951f59203
--- /dev/null
+++ b/windbgstub.c
@@ -0,0 +1,18 @@
+/*
+ * windbgstub.c
+ *
+ * Copyright (c) 2010-2017 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "exec/windbgstub.h"
+
+int windbg_server_start(const char *device)
+{
+    return 0;
+}
