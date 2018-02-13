Received: from eggs.gnu.org ([2001:4830:134:3::10]:52153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1elUf3-0002kY-0I
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1elUez-0008Q8-4S
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:05:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1elUez-0008AI-0j
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 545787D67B
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:05:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Feb 2018 08:05:26 +0100
Message-Id: <20180213070526.22475-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] vnc: add qapi/error.h include to stubs
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
