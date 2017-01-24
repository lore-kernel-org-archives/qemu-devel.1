Received: from eggs.gnu.org ([2001:4830:134:3::10]:47273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqF-0000fL-Q0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVzqC-00006C-IF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:04:51 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:18 +0300
Message-Id: <9fcf8d63ea603736391d0508c08e0a50e4a2c091.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 14/31] block: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Paolo Bonzini <pbonzini@redhat.com>

options must be non-NULL here, because a NULL value is replaced with
qdict_new earlier in the function.  Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 39ddea3..a0346c8 100644
--- a/block.c
+++ b/block.c
@@ -1851,7 +1851,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     bdrv_refresh_filename(bs);
 
     /* Check if any unknown options were used */
-    if (options && (qdict_size(options) != 0)) {
+    if (qdict_size(options) != 0) {
         const QDictEntry *entry = qdict_first(options);
         if (flags & BDRV_O_PROTOCOL) {
             error_setg(errp, "Block protocol '%s' doesn't support the option "
-- 
2.1.4
