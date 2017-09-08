Received: from eggs.gnu.org ([2001:4830:134:3::10]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG17-0008Gv-II
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG13-0004xe-46
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG12-0004x2-UJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:56:01 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:54 +0800
Message-Id: <20170908095506.13594-27-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 26/38] vl: Don't include vde header
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
index fb1f05b937..7187e6c350 100644
--- a/vl.c
+++ b/vl.c
@@ -31,10 +31,6 @@
 #include "sysemu/seccomp.h"
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
