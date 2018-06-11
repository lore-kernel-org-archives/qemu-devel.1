Received: from eggs.gnu.org ([2001:4830:134:3::10]:42379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBQe-0004Td-RB
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBQd-0002IF-SA
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:15:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:14:22 -0300
Message-Id: <20180611011501.10235-2-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/40] include: Add IEC binary prefixes in
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Loosely based on 076b35b5a56.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I suppose the following warning is irrelevant:

  WARNING: 1 added file, does MAINTAINERS need updating

 include/qemu/units.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/qemu/units.h

diff --git a/include/qemu/units.h b/include/qemu/units.h
new file mode 100644
index 0000000000..e3a39ed59e
--- /dev/null
+++ b/include/qemu/units.h
@@ -0,0 +1,20 @@
+/*
+ * IEC binary prefixes definitions
+ *
+ * Copyright (C) 2015 Nikunj A Dadhania, IBM Corporation
+ * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_UNITS_H
+#define QEMU_UNITS_H
+
+#define KiB     (1ULL << 10)
+#define MiB     (1ULL << 20)
+#define GiB     (1ULL << 30)
+#define TiB     (1ULL << 40)
+#define PiB     (1ULL << 50)
+#define EiB     (1ULL << 60)
+
+#endif
-- 
2.17.1
