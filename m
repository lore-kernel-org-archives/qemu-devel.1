Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dayrB-0006LS-Ul
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dayr9-0004z0-74
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:34:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dayr9-0004yP-1b
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:34:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AFD3C09AA1A
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 06:34:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 08:34:32 +0200
Message-Id: <20170728063432.27578-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: add pause key to linux_to_qcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-keymap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index cdad5652d3..cf979c2ce9 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -116,6 +116,7 @@ static int linux_to_qcode[KEY_CNT] = {
     [KEY_LEFTMETA]       = Q_KEY_CODE_META_L,
     [KEY_RIGHTMETA]      = Q_KEY_CODE_META_R,
     [KEY_MENU]           = Q_KEY_CODE_MENU,
+    [KEY_PAUSE]          = Q_KEY_CODE_PAUSE,
 
     [KEY_SLEEP]          = Q_KEY_CODE_SLEEP,
     [KEY_WAKEUP]         = Q_KEY_CODE_WAKE,
-- 
2.9.3
