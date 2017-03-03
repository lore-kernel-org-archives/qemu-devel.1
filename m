Received: from eggs.gnu.org ([2001:4830:134:3::10]:38516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cjtjT-0001Yn-GE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1cjtjP-0007Iy-FL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:23:19 -0500
From: Suramya Shah <shah.suramya@gmail.com>
Date: Sat,  4 Mar 2017 01:52:27 +0530
Message-Id: <20170303202227.1950-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH v2]util:Removed header qemu-common.h from path.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-trivial@nongnu.org, Suramya Shah <shah.suramya@gmail.com>

Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
--- fix of typo in v1 that broke compilation
 util/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/util/path.c b/util/path.c
index 5479f76..7f9fc27 100644
--- a/util/path.c
+++ b/util/path.c
@@ -6,7 +6,6 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 #include <dirent.h>
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
 
-- 
2.9.3
