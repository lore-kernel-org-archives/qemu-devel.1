Received: from eggs.gnu.org ([2001:4830:134:3::10]:47993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1f1ZCP-000489-ME
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1f1ZCL-0004Hb-Le
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:10:45 -0400
Received: from inet-orm.provo.novell.com ([137.65.248.124]:54507
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1f1ZCL-0004Bq-Er
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 11:10:41 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Thu, 29 Mar 2018 09:10:18 -0600
Message-Id: <20180329151018.15319-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH] sys_membarrier: fix up include directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com
Cc: brogers@suse.com

Our rule right now is to use <> for external headers only.
util/sys_membarrier.c violates that. Fix it up.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 util/sys_membarrier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/sys_membarrier.c b/util/sys_membarrier.c
index 8dcb53e63e..1362c0c4c5 100644
--- a/util/sys_membarrier.c
+++ b/util/sys_membarrier.c
@@ -6,9 +6,9 @@
  * Author: Paolo Bonzini <pbonzini@redhat.com>
  */
 
-#include <qemu/osdep.h>
-#include <qemu/sys_membarrier.h>
-#include <qemu/error-report.h>
+#include "qemu/osdep.h"
+#include "qemu/sys_membarrier.h"
+#include "qemu/error-report.h"
 
 #ifdef CONFIG_LINUX
 #include <linux/membarrier.h>
-- 
2.16.2
