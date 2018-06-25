Received: from eggs.gnu.org ([2001:4830:134:3::10]:53406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpm-0000r7-1G
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQpk-0007Pn-U7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:43:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:41:53 -0300
Message-Id: <20180625124238.25339-2-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/46] include: Add IEC binary prefixes in
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Loosely based on 076b35b5a56.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/units.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/qemu/units.h

diff --git a/include/qemu/units.h b/include/qemu/units.h
new file mode 100644
index 0000000000..692db3fbb2
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
+#define KiB     (INT64_C(1) << 10)
+#define MiB     (INT64_C(1) << 20)
+#define GiB     (INT64_C(1) << 30)
+#define TiB     (INT64_C(1) << 40)
+#define PiB     (INT64_C(1) << 50)
+#define EiB     (INT64_C(1) << 60)
+
+#endif
-- 
2.18.0
