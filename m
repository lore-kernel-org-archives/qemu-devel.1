Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWl-0006Y7-DJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWf-0006xu-Bq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwWe-0006xI-Q3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:13 +0000
Message-Id: <20171218143530.12082-7-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 06/23] qdev: drop unused #include
 "sysemu/iothread.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Commit 1351d1ec89eabebc9fdff20451a62c413d7accc1 ("qdev: drop iothread
property type") forgot to remove this include.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171205133954.31006-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/qdev-properties-system.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c17364655c..46b3843cf8 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -22,7 +22,6 @@
 #include "qapi/visitor.h"
 #include "chardev/char-fe.h"
 #include "sysemu/tpm_backend.h"
-#include "sysemu/iothread.h"
 
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
                         char *(*print)(void *ptr),
-- 
2.14.3
