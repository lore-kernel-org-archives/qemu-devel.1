Received: from eggs.gnu.org ([2001:4830:134:3::10]:51527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwHn9-0006IY-UB
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 21:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwHn6-0005h8-1D
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 21:02:35 -0400
From: Daniel Loffgren <daniel@loffgren.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <40DEFE92-410B-4FED-B0A5-56C186627134@loffgren.org>
Date: Sun, 24 Sep 2017 18:02:21 -0700
Subject: [Qemu-devel] [PATCH 1/2] fprintf-fn.h uses GCC_FMT,
 but doesn't include the definition of it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org


Signed-off-by: Daniel Loffgren <daniel@loffgren.org>
---
 include/qemu/fprintf-fn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/fprintf-fn.h b/include/qemu/fprintf-fn.h
index 9068a960b3..80361d87bf 100644
--- a/include/qemu/fprintf-fn.h
+++ b/include/qemu/fprintf-fn.h
@@ -8,6 +8,8 @@
 #ifndef QEMU_FPRINTF_FN_H
 #define QEMU_FPRINTF_FN_H
 
+#include "compiler.h"
+
 typedef int (*fprintf_function)(FILE *f, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
-- 
