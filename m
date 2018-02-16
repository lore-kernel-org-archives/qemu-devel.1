Received: from eggs.gnu.org ([2001:4830:134:3::10]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dL-Mz
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003gB-Lr
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003eR-Dc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDB734023112
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:13 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:03 +0100
Message-Id: <20180216115410.27287-3-kraxel@redhat.com>
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] vnc: add qapi/error.h include to stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Fixes --disable-vnc build failure.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180213070526.22475-1-kraxel@redhat.com
---
 ui/vnc-stubs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
index f51280549a..06c4ac6296 100644
--- a/ui/vnc-stubs.c
+++ b/ui/vnc-stubs.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "ui/console.h"
+#include "qapi/error.h"
 
 int vnc_display_password(const char *id, const char *password)
 {
-- 
2.9.3
