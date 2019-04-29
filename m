Received: from eggs.gnu.org ([209.51.188.92]:33681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuIb-0007js-1v
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuEu-0003Di-QN
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:33:49 -0400
Received: from smtpbgeu2.qq.com ([18.194.254.142]:58104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hKuEu-0003Co-HZ
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:33:48 -0400
From: driver1998 <driver1998@foxmail.com>
Date: Mon, 29 Apr 2019 00:33:39 +0000
Message-Id: <20190429003339.22956-1-driver1998@foxmail.com>
Subject: [Qemu-devel] [PATCH 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: driver1998 <driver1998@foxmail.com>

Signed-off-by: driver1998 <driver1998@foxmail.com>
---
 include/qemu/osdep.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 303d315c5d..af2b91f0b8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -85,17 +85,17 @@ extern int daemon(int, int);
 #endif
 #endif
 
+/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
+#ifdef __MINGW32__
+#define __USE_MINGW_ANSI_STDIO 1
+#endif
+
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
-
-/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
-#ifdef __MINGW32__
-#define __USE_MINGW_ANSI_STDIO 1
-#endif
 #include <stdio.h>
 
 #include <string.h>
-- 
2.17.1
