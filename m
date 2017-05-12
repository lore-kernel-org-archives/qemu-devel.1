Received: from eggs.gnu.org ([2001:4830:134:3::10]:41330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aN-0000ec-99
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aK-0005DM-VC
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d99aK-0005D4-Po
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C23F43DBEE
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 12:22:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 14:21:57 +0200
Message-Id: <20170512122158.32032-6-kraxel@redhat.com>
In-Reply-To: <20170512122158.32032-1-kraxel@redhat.com>
References: <20170512122158.32032-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] xhci: relax link check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

The strict td link limit added by commit "05f43d4 xhci: limit the
number of link trbs we are willing to process" causes problems with
Windows guests. Let's raise the limit.

This change is analogous to:

  commit ab6b1105a2259c7072905887f71caa850ce63190
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Tue Mar 7 09:40:18 2017 +0100

      ohci: relax link check

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 20170512102100.22675-1-lprosek@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d3d47bf925..77d8e1137a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -50,7 +50,7 @@
 /* Very pessimistic, let's hope it's enough for all cases */
 #define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
 
-#define TRB_LINK_LIMIT  4
+#define TRB_LINK_LIMIT  32
 #define COMMAND_LIMIT   256
 #define TRANSFER_LIMIT  256
 
-- 
2.9.3
