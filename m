Received: from eggs.gnu.org ([2001:4830:134:3::10]:44404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbf-0005MP-Ux
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dNfbe-0003ZG-R8
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dNfbe-0003Ym-LL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:23:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B84D68EB41
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 13:23:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Jun 2017 15:23:40 +0200
Message-Id: <20170621132340.27686-7-kraxel@redhat.com>
In-Reply-To: <20170621132340.27686-1-kraxel@redhat.com>
References: <20170621132340.27686-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] ui: Remove inclusion of "hw/qdev.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Looks like #include "hw/qdev.h" is not needed here, so remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1497894617-12143-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input.c | 1 -
 ui/vnc.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index 290ca9f54d..2abd46de93 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi-types.h"
 #include "qemu/error-report.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 47b49c7318..26136f5d29 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -28,7 +28,6 @@
 #include "vnc.h"
 #include "vnc-jobs.h"
 #include "trace.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-- 
2.9.3
