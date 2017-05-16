Received: from eggs.gnu.org ([2001:4830:134:3::10]:47796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAX8Q-0007fB-DH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAX8P-0005rg-IG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:43:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 16 May 2017 09:42:55 +0200
Message-Id: <20170516074256.24731-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] block/win32: fix 'ret not initialized' warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:raw" <qemu-block@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 block/file-win32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/file-win32.c b/block/file-win32.c
index 1a35dbabf2..8f14f0bdcd 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -346,6 +346,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (qdict_get_try_bool(options, "locking", false)) {
         error_setg(errp, "locking=on is not supported on Windows");
+        ret = -EINVAL;
         goto fail;
     }
 
-- 
2.9.3
