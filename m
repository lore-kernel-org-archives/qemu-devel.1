Received: from eggs.gnu.org ([209.51.188.92]:52781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNElw-00045K-Mj
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNElv-00013d-Q9
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:53:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hNElv-00012w-Fv
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:53:31 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 May 2019 13:51:12 +0300
Message-Id: <20190505105112.22691-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/rdma: Delete unused headers inclusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>

This is a trivial cleanup patch.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d1660b6474..05f6b03221 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -14,16 +14,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
-#include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
 #include "qapi/qapi-events-rdma.h"
 
 #include <infiniband/verbs.h>
-#include <infiniband/umad_types.h>
-#include <infiniband/umad.h>
-#include <rdma/rdma_user_cm.h>
 
 #include "contrib/rdmacm-mux/rdmacm-mux.h"
 #include "trace.h"
-- 
2.20.1
