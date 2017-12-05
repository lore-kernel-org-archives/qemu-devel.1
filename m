Received: from eggs.gnu.org ([2001:4830:134:3::10]:48830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMDS9-0006HY-5P
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMDS3-0003xm-Ml
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:40:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMDS3-0003xd-GX
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1F3B5D9F5
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 13:39:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Dec 2017 13:39:54 +0000
Message-Id: <20171205133954.31006-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] qdev: drop unused #include "sysemu/iothread.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Commit 1351d1ec89eabebc9fdff20451a62c413d7accc1 ("qdev: drop iothread
property type") forgot to remove this include.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/qdev-properties-system.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index ec10da7424..e6a697c39a 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -21,7 +21,6 @@
 #include "net/hub.h"
 #include "qapi/visitor.h"
 #include "chardev/char-fe.h"
-#include "sysemu/iothread.h"
 
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
                         char *(*print)(void *ptr),
-- 
2.14.3
