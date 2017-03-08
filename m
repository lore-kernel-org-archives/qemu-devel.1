Received: from eggs.gnu.org ([2001:4830:134:3::10]:54926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgAi-00035u-Hu
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgAh-00034Z-Go
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:18:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  8 Mar 2017 19:18:33 +0100
Message-Id: <20170308181833.32110-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Kevin Wolf <kwolf@redhat.com>

In order to use error_setg() and similar functions, we need to include
qapi/error.h.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/archipelago.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/archipelago.c b/block/archipelago.c
index 2449cfc702..01c4ff2f7d 100644
--- a/block/archipelago.c
+++ b/block/archipelago.c
@@ -55,6 +55,7 @@
 #include "block/block_int.h"
 #include "qemu/error-report.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qint.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-- 
2.12.0
