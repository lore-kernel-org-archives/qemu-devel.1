Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwHn9-0006IX-U8
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 21:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@loffgren.org>) id 1dwHn7-0005id-0p
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 21:02:35 -0400
From: Daniel Loffgren <daniel@loffgren.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
Date: Sun, 24 Sep 2017 18:02:24 -0700
Subject: [Qemu-devel] [PATCH 2/2] thunk.h uses TARGET_ABI_BITS without
 including abitypes.h
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
 include/exec/user/thunk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index f19ef4b230..12b5449d8c 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -19,6 +19,7 @@
 #ifndef THUNK_H
 #define THUNK_H
 
+#include "abitypes.h"
 #include "cpu.h"
 
 /* types enums definitions */
-- 
