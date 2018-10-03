Received: from eggs.gnu.org ([2001:4830:134:3::10]:34974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g7eK9-0006Qz-7b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g7eK6-0006n1-3l
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:24:09 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  3 Oct 2018 13:23:13 +0300
Message-Id: <20181003102313.3953-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] block: replace "discard" literal with
 BDRV_OPT_DISCARD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 7710b399a3..0d6e5f1a76 100644
--- a/block.c
+++ b/block.c
@@ -1327,7 +1327,7 @@ QemuOptsList bdrv_runtime_opts = {
             .help = "try to optimize zero writes (off, on, unmap)",
         },
         {
-            .name = "discard",
+            .name = BDRV_OPT_DISCARD,
             .type = QEMU_OPT_STRING,
             .help = "discard operation (ignore/off, unmap/on)",
         },
@@ -1432,7 +1432,7 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
         }
     }
 
-    discard = qemu_opt_get(opts, "discard");
+    discard = qemu_opt_get(opts, BDRV_OPT_DISCARD);
     if (discard != NULL) {
         if (bdrv_parse_discard_flags(discard, &bs->open_flags) != 0) {
             error_setg(errp, "Invalid discard option");
@@ -3186,7 +3186,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     update_flags_from_options(&reopen_state->flags, opts);
 
-    discard = qemu_opt_get_del(opts, "discard");
+    discard = qemu_opt_get_del(opts, BDRV_OPT_DISCARD);
     if (discard != NULL) {
         if (bdrv_parse_discard_flags(discard, &reopen_state->flags) != 0) {
             error_setg(errp, "Invalid discard option");
-- 
2.11.0
