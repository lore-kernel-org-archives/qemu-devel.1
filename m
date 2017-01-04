Received: from eggs.gnu.org ([2001:4830:134:3::10]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOn28-0002KB-JO
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOn25-0006Wg-Dr
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:59:20 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jan 2017 15:59:14 +0100
Message-Id: <20170104145914.3361-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] block: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

options must be non-NULL here, because a NULL value is replaced with
qdict_new earlier in the function.  Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.9.3
