Received: from eggs.gnu.org ([2001:4830:134:3::10]:59725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXir-0002Mg-Bt
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXin-0005rD-GX
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:45:45 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:12 +0300
Message-Id: <e8758b62290c45b5b2f3c7925e250b9f16293f27.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 08/22] trivial: Remove unneeded ifndef in
 memory.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Juan Quintela <quintela@redhat.com>

All the file is surounded already by #ifndef CONFIG_USER_ONLY.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/exec/memory.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index bfdc685f24..80e605a96a 100644
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
2.11.0
