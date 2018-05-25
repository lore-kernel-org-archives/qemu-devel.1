Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fM4jg-0007rn-Uy
	for qemu-devel@nongnu.org; Fri, 25 May 2018 00:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fM4jd-0001dw-SK
	for qemu-devel@nongnu.org; Fri, 25 May 2018 00:53:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fM4jd-0001dh-OB
	for qemu-devel@nongnu.org; Fri, 25 May 2018 00:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21883BB41B
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 04:53:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 25 May 2018 06:53:44 +0200
Message-Id: <20180525045344.28347-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] bochs-display: add missing break
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

Fixes: CID 1391291
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index c33524b558..1187d77576 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -158,6 +158,7 @@ static int bochs_display_get_mode(BochsDisplayState *s,
         /* best effort: support native endianess only */
         mode->format = PIXMAN_r5g6b5;
         mode->bytepp = 2;
+        break;
     case 32:
         mode->format = s->big_endian_fb
             ? PIXMAN_BE_x8r8g8b8
-- 
2.9.3
