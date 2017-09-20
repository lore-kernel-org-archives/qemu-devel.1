Received: from eggs.gnu.org ([2001:4830:134:3::10]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dufN4-0004s0-9Y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dufN1-0002Zk-7J
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dufN1-0002ZV-23
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D56EE7CB8C
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 08:59:59 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Wed, 20 Sep 2017 16:59:52 +0800
Message-Id: <20170920085952.3872-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: Use angle brackets for cacard include
 directive
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

This is a library header, so angle brackets are more appropriate; also
move the line to before QEMU headers, as is recommended in HACKING.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/usb/ccid-card-passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 45d96b03c6..117711862e 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,11 +9,11 @@
  */
 
 #include "qemu/osdep.h"
+#include <cacard/vscard_common.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "ccid.h"
-#include "cacard/vscard_common.h"
 
 #define DPRINTF(card, lvl, fmt, ...)                    \
 do {                                                    \
-- 
2.13.5
