Received: from eggs.gnu.org ([2001:4830:134:3::10]:47273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBInZ-000211-Ki
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBInW-0005YT-Ih
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:36:49 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 12:36:42 +0200
Message-Id: <20170518103642.27796-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] trivial: Remove unneeded ifndef in memory.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, qemu-trivial@nongnu.org

All the file is surounded already by #ifndef CONFIG_USER_ONLY.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/exec/memory.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 99e0f54..6b5b953 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -17,9 +17,7 @@
 #ifndef CONFIG_USER_ONLY
 
 #include "exec/cpu-common.h"
-#ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-#endif
 #include "exec/memattrs.h"
 #include "exec/ramlist.h"
 #include "qemu/queue.h"
-- 
2.9.3
