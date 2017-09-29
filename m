Received: from eggs.gnu.org ([2001:4830:134:3::10]:50335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2V-0007IP-Pz
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dxt2Q-0001Qo-4Y
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dxt2P-0001QN-VJ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:00:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E42764ACA7
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 11:00:56 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Sep 2017 13:00:52 +0200
Message-Id: <20170929110052.6111-4-kraxel@redhat.com>
In-Reply-To: <20170929110052.6111-1-kraxel@redhat.com>
References: <20170929110052.6111-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] usb: Use angle brackets for cacard include
 directive
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <qemu-devel.nongnu.org>

From: Fam Zheng <famz@redhat.com>

This is a library header, so angle brackets are more appropriate; also
move the line to before QEMU headers, as is recommended in HACKING.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170920085952.3872-1-famz@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
