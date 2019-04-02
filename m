Received: from eggs.gnu.org ([209.51.188.92]:60324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hBItR-0004Wt-Ib
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hBItN-0001Bg-Bm
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:51:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hBItK-00015X-N7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:51:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id z5so5323708pfn.3
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 05:51:47 -0700 (PDT)
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue,  2 Apr 2019 18:21:31 +0530
Message-Id: <20190402125131.10275-1-aruna.15@cse.mrt.ac.lk>
Subject: [Qemu-devel] [PATCH 2/3] Header cleanups qemu_is* macros were moved
 from qemu-common.h to qemu/cutils.h This task was under
 https://wiki.qemu.org/Contribute/BiteSizedTasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 hw/core/qdev-properties.c |  1 +
 include/qemu-common.h     | 11 -----------
 include/qemu/cutils.h     | 12 ++++++++++++
 qapi/qapi-util.c          |  2 +-
 util/id.c                 |  2 +-
 5 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5da1439a8b..821a4ab311 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qemu/cutils.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
diff --git a/include/qemu-common.h b/include/qemu-common.h
index a102245519..0066e45a6b 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -33,17 +33,6 @@ int qemu_main(int argc, char **argv, char **envp);
 void qemu_get_timedate(struct tm *tm, int offset);
 int qemu_timedate_diff(struct tm *tm);
 
-#define qemu_isalnum(c)		isalnum((unsigned char)(c))
-#define qemu_isalpha(c)		isalpha((unsigned char)(c))
-#define qemu_iscntrl(c)		iscntrl((unsigned char)(c))
-#define qemu_isdigit(c)		isdigit((unsigned char)(c))
-#define qemu_isgraph(c)		isgraph((unsigned char)(c))
-#define qemu_islower(c)		islower((unsigned char)(c))
-#define qemu_isprint(c)		isprint((unsigned char)(c))
-#define qemu_ispunct(c)		ispunct((unsigned char)(c))
-#define qemu_isspace(c)		isspace((unsigned char)(c))
-#define qemu_isupper(c)		isupper((unsigned char)(c))
-#define qemu_isxdigit(c)	isxdigit((unsigned char)(c))
 #define qemu_tolower(c)		tolower((unsigned char)(c))
 #define qemu_toupper(c)		toupper((unsigned char)(c))
 #define qemu_isascii(c)		isascii((unsigned char)(c))
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d2dad3057c..797c5bc560 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -3,6 +3,18 @@
 
 #include "qemu/fprintf-fn.h"
 
+#define qemu_isalnum(c)    isalnum((unsigned char)(c))
+#define qemu_isalpha(c)    isalpha((unsigned char)(c))
+#define qemu_iscntrl(c)    iscntrl((unsigned char)(c))
+#define qemu_isdigit(c)    isdigit((unsigned char)(c))
+#define qemu_isgraph(c)    isgraph((unsigned char)(c))
+#define qemu_islower(c)    islower((unsigned char)(c))
+#define qemu_isprint(c)    isprint((unsigned char)(c))
+#define qemu_ispunct(c)    ispunct((unsigned char)(c))
+#define qemu_isspace(c)    isspace((unsigned char)(c))
+#define qemu_isupper(c)    isupper((unsigned char)(c))
+#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
+
 /**
  * pstrcpy:
  * @buf: buffer to copy string into
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index e9b266bb70..944347cc76 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 
 const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
 {
diff --git a/util/id.c b/util/id.c
index 3f8e13bd6f..a1faff1f9e 100644
--- a/util/id.c
+++ b/util/id.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/id.h"
-#include "qemu-common.h"
+#include "qemu/cutils.h"
 
 bool id_wellformed(const char *id)
 {
-- 
2.17.1
