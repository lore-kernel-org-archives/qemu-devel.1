Received: from eggs.gnu.org ([2001:4830:134:3::10]:35599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4ry-0005nn-0f
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1db4ro-0008Oy-Ls
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1db4ro-0008NQ-CS
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3730CB7CC2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 12:59:43 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 28 Jul 2017 14:59:35 +0200
Message-Id: <20170728125935.18167-4-kraxel@redhat.com>
In-Reply-To: <20170728125935.18167-1-kraxel@redhat.com>
References: <20170728125935.18167-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] ui: add pause key to linux_to_qcode
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
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170728063432.27578-1-kraxel@redhat.com
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
