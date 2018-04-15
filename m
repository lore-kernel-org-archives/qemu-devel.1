Received: from eggs.gnu.org ([2001:4830:134:3::10]:50518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rJ6-0004RP-DY
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rJ5-0000Gn-Iz
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:32 -0300
Message-Id: <20180415234307.28132-7-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/41] cutils: Extract byte-based
 definitions into a new header: "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

(added in 076b35b5a56)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/cutils.h |  8 +-------
 include/qemu/units.h  | 11 +++++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)
 create mode 100644 include/qemu/units.h

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index a663340b23..056e6629bb 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -2,6 +2,7 @@
 #define QEMU_CUTILS_H
 
 #include "qemu/fprintf-fn.h"
+#include "qemu/units.h"
 
 /**
  * pstrcpy:
@@ -147,13 +148,6 @@ int qemu_strtosz(const char *nptr, char **end, uint64_t *result);
 int qemu_strtosz_MiB(const char *nptr, char **end, uint64_t *result);
 int qemu_strtosz_metric(const char *nptr, char **end, uint64_t *result);
 
-#define K_BYTE     (1ULL << 10)
-#define M_BYTE     (1ULL << 20)
-#define G_BYTE     (1ULL << 30)
-#define T_BYTE     (1ULL << 40)
-#define P_BYTE     (1ULL << 50)
-#define E_BYTE     (1ULL << 60)
-
 /* used to print char* safely */
 #define STR_OR_NULL(str) ((str) ? (str) : "null")
 
diff --git a/include/qemu/units.h b/include/qemu/units.h
new file mode 100644
index 0000000000..81f5cc6f7f
--- /dev/null
+++ b/include/qemu/units.h
@@ -0,0 +1,11 @@
+#ifndef QEMU_UNITS_H
+#define QEMU_UNITS_H
+
+#define K_BYTE     (1ULL << 10)
+#define M_BYTE     (1ULL << 20)
+#define G_BYTE     (1ULL << 30)
+#define T_BYTE     (1ULL << 40)
+#define P_BYTE     (1ULL << 50)
+#define E_BYTE     (1ULL << 60)
+
+#endif
-- 
2.17.0
