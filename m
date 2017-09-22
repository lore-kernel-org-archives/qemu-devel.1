Received: from eggs.gnu.org ([2001:4830:134:3::10]:37704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgN-00087r-AQ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgM-0000yY-KQ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgM-0000yK-F4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:36 +0800
Message-Id: <20170922074659.30097-14-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 13/36] vl: Don't include vde header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Nothing in vl.c uses anything from the vde package, do remove the
unnecessary include.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170907083552.17725-2-famz@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 vl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/vl.c b/vl.c
index 9bb5058c3a..88ae727486 100644
--- a/vl.c
+++ b/vl.c
@@ -32,10 +32,6 @@
 #include "sys/prctl.h"
 #endif
 
-#if defined(CONFIG_VDE)
-#include <libvdeplug.h>
-#endif
-
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
 #include <SDL.h>
-- 
2.13.5
