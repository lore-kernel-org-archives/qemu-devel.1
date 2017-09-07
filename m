Received: from eggs.gnu.org ([2001:4830:134:3::10]:38499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsI5-00035X-In
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsI4-0004GN-Ap
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsI4-0004GA-4r
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F03AC047B62
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:35:59 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:35:51 +0800
Message-Id: <20170907083552.17725-2-famz@redhat.com>
In-Reply-To: <20170907083552.17725-1-famz@redhat.com>
References: <20170907083552.17725-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vl: Don't include vde header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

Nothing in vl.c uses anything from the vde package, do remove the
unnecessary include.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 vl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/vl.c b/vl.c
index e75757f977..293cd91ec9 100644
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
