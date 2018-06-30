Received: from eggs.gnu.org ([2001:4830:134:3::10]:37712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95t-0003yL-Kg
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95q-0001dy-SS
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:49 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95q-0001dF-LE
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:46 -0400
Received: by mail-wr0-x22f.google.com with SMTP id p1-v6so10653404wrs.9
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:09:56 +0200
Message-Id: <20180630061040.6018-4-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/47] include: Add IEC binary prefixes in
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Loosely based on 076b35b5a56.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-2-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/units.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/qemu/units.h

diff --git a/include/qemu/units.h b/include/qemu/units.h
new file mode 100644
index 0000000..692db3f
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
1.8.3.1
