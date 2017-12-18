Received: from eggs.gnu.org ([2001:4830:134:3::10]:60174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2ef-0002CA-Eb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2ed-0003a1-UB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:57 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:17 -0500
Message-Id: <20171218210819.31576-9-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] block/sheepdog: code beautification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org

No functional changes, just whitespace manipulation.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 164 +++++++++++++++++++++++++++----------------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 459d93a..488bad3 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -400,7 +400,7 @@ typedef struct BDRVSheepdogReopenState {
     int cache_flags;
 } BDRVSheepdogReopenState;
 
-static const char * sd_strerror(int err)
+static const char *sd_strerror(int err)
 {
     int i;
 
@@ -3078,111 +3078,111 @@ static QemuOptsList sd_create_opts = {
 };
 
 static BlockDriver bdrv_sheepdog = {
-    .format_name    = "sheepdog",
-    .protocol_name  = "sheepdog",
-    .instance_size  = sizeof(BDRVSheepdogState),
-    .bdrv_parse_filename    = sd_parse_filename,
-    .bdrv_file_open = sd_open,
-    .bdrv_reopen_prepare    = sd_reopen_prepare,
-    .bdrv_reopen_commit     = sd_reopen_commit,
-    .bdrv_reopen_abort      = sd_reopen_abort,
-    .bdrv_close     = sd_close,
-    .bdrv_create    = sd_create,
-    .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_getlength = sd_getlength,
+    .format_name                  = "sheepdog",
+    .protocol_name                = "sheepdog",
+    .instance_size                = sizeof(BDRVSheepdogState),
+    .bdrv_parse_filename          = sd_parse_filename,
+    .bdrv_file_open               = sd_open,
+    .bdrv_reopen_prepare          = sd_reopen_prepare,
+    .bdrv_reopen_commit           = sd_reopen_commit,
+    .bdrv_reopen_abort            = sd_reopen_abort,
+    .bdrv_close                   = sd_close,
+    .bdrv_create                  = sd_create,
+    .bdrv_has_zero_init           = bdrv_has_zero_init_1,
+    .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
-    .bdrv_truncate  = sd_truncate,
+    .bdrv_truncate                = sd_truncate,
 
-    .bdrv_co_readv  = sd_co_readv,
-    .bdrv_co_writev = sd_co_writev,
-    .bdrv_co_flush_to_disk  = sd_co_flush_to_disk,
-    .bdrv_co_pdiscard = sd_co_pdiscard,
-    .bdrv_co_get_block_status = sd_co_get_block_status,
+    .bdrv_co_readv                = sd_co_readv,
+    .bdrv_co_writev               = sd_co_writev,
+    .bdrv_co_flush_to_disk        = sd_co_flush_to_disk,
+    .bdrv_co_pdiscard             = sd_co_pdiscard,
+    .bdrv_co_get_block_status     = sd_co_get_block_status,
 
-    .bdrv_snapshot_create   = sd_snapshot_create,
-    .bdrv_snapshot_goto     = sd_snapshot_goto,
-    .bdrv_snapshot_delete   = sd_snapshot_delete,
-    .bdrv_snapshot_list     = sd_snapshot_list,
+    .bdrv_snapshot_create         = sd_snapshot_create,
+    .bdrv_snapshot_goto           = sd_snapshot_goto,
+    .bdrv_snapshot_delete         = sd_snapshot_delete,
+    .bdrv_snapshot_list           = sd_snapshot_list,
 
-    .bdrv_save_vmstate  = sd_save_vmstate,
-    .bdrv_load_vmstate  = sd_load_vmstate,
+    .bdrv_save_vmstate            = sd_save_vmstate,
+    .bdrv_load_vmstate            = sd_load_vmstate,
 
-    .bdrv_detach_aio_context = sd_detach_aio_context,
-    .bdrv_attach_aio_context = sd_attach_aio_context,
+    .bdrv_detach_aio_context      = sd_detach_aio_context,
+    .bdrv_attach_aio_context      = sd_attach_aio_context,
 
-    .create_opts    = &sd_create_opts,
+    .create_opts                  = &sd_create_opts,
 };
 
 static BlockDriver bdrv_sheepdog_tcp = {
-    .format_name    = "sheepdog",
-    .protocol_name  = "sheepdog+tcp",
-    .instance_size  = sizeof(BDRVSheepdogState),
-    .bdrv_parse_filename    = sd_parse_filename,
-    .bdrv_file_open = sd_open,
-    .bdrv_reopen_prepare    = sd_reopen_prepare,
-    .bdrv_reopen_commit     = sd_reopen_commit,
-    .bdrv_reopen_abort      = sd_reopen_abort,
-    .bdrv_close     = sd_close,
-    .bdrv_create    = sd_create,
-    .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_getlength = sd_getlength,
+    .format_name                  = "sheepdog",
+    .protocol_name                = "sheepdog+tcp",
+    .instance_size                = sizeof(BDRVSheepdogState),
+    .bdrv_parse_filename          = sd_parse_filename,
+    .bdrv_file_open               = sd_open,
+    .bdrv_reopen_prepare          = sd_reopen_prepare,
+    .bdrv_reopen_commit           = sd_reopen_commit,
+    .bdrv_reopen_abort            = sd_reopen_abort,
+    .bdrv_close                   = sd_close,
+    .bdrv_create                  = sd_create,
+    .bdrv_has_zero_init           = bdrv_has_zero_init_1,
+    .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
-    .bdrv_truncate  = sd_truncate,
+    .bdrv_truncate                = sd_truncate,
 
-    .bdrv_co_readv  = sd_co_readv,
-    .bdrv_co_writev = sd_co_writev,
-    .bdrv_co_flush_to_disk  = sd_co_flush_to_disk,
-    .bdrv_co_pdiscard = sd_co_pdiscard,
-    .bdrv_co_get_block_status = sd_co_get_block_status,
+    .bdrv_co_readv                = sd_co_readv,
+    .bdrv_co_writev               = sd_co_writev,
+    .bdrv_co_flush_to_disk        = sd_co_flush_to_disk,
+    .bdrv_co_pdiscard             = sd_co_pdiscard,
+    .bdrv_co_get_block_status     = sd_co_get_block_status,
 
-    .bdrv_snapshot_create   = sd_snapshot_create,
-    .bdrv_snapshot_goto     = sd_snapshot_goto,
-    .bdrv_snapshot_delete   = sd_snapshot_delete,
-    .bdrv_snapshot_list     = sd_snapshot_list,
+    .bdrv_snapshot_create         = sd_snapshot_create,
+    .bdrv_snapshot_goto           = sd_snapshot_goto,
+    .bdrv_snapshot_delete         = sd_snapshot_delete,
+    .bdrv_snapshot_list           = sd_snapshot_list,
 
-    .bdrv_save_vmstate  = sd_save_vmstate,
-    .bdrv_load_vmstate  = sd_load_vmstate,
+    .bdrv_save_vmstate            = sd_save_vmstate,
+    .bdrv_load_vmstate            = sd_load_vmstate,
 
-    .bdrv_detach_aio_context = sd_detach_aio_context,
-    .bdrv_attach_aio_context = sd_attach_aio_context,
+    .bdrv_detach_aio_context      = sd_detach_aio_context,
+    .bdrv_attach_aio_context      = sd_attach_aio_context,
 
-    .create_opts    = &sd_create_opts,
+    .create_opts                  = &sd_create_opts,
 };
 
 static BlockDriver bdrv_sheepdog_unix = {
-    .format_name    = "sheepdog",
-    .protocol_name  = "sheepdog+unix",
-    .instance_size  = sizeof(BDRVSheepdogState),
-    .bdrv_parse_filename    = sd_parse_filename,
-    .bdrv_file_open = sd_open,
-    .bdrv_reopen_prepare    = sd_reopen_prepare,
-    .bdrv_reopen_commit     = sd_reopen_commit,
-    .bdrv_reopen_abort      = sd_reopen_abort,
-    .bdrv_close     = sd_close,
-    .bdrv_create    = sd_create,
-    .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_getlength = sd_getlength,
+    .format_name                  = "sheepdog",
+    .protocol_name                = "sheepdog+unix",
+    .instance_size                = sizeof(BDRVSheepdogState),
+    .bdrv_parse_filename          = sd_parse_filename,
+    .bdrv_file_open               = sd_open,
+    .bdrv_reopen_prepare          = sd_reopen_prepare,
+    .bdrv_reopen_commit           = sd_reopen_commit,
+    .bdrv_reopen_abort            = sd_reopen_abort,
+    .bdrv_close                   = sd_close,
+    .bdrv_create                  = sd_create,
+    .bdrv_has_zero_init           = bdrv_has_zero_init_1,
+    .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
-    .bdrv_truncate  = sd_truncate,
+    .bdrv_truncate                = sd_truncate,
 
-    .bdrv_co_readv  = sd_co_readv,
-    .bdrv_co_writev = sd_co_writev,
-    .bdrv_co_flush_to_disk  = sd_co_flush_to_disk,
-    .bdrv_co_pdiscard = sd_co_pdiscard,
-    .bdrv_co_get_block_status = sd_co_get_block_status,
+    .bdrv_co_readv                = sd_co_readv,
+    .bdrv_co_writev               = sd_co_writev,
+    .bdrv_co_flush_to_disk        = sd_co_flush_to_disk,
+    .bdrv_co_pdiscard             = sd_co_pdiscard,
+    .bdrv_co_get_block_status     = sd_co_get_block_status,
 
-    .bdrv_snapshot_create   = sd_snapshot_create,
-    .bdrv_snapshot_goto     = sd_snapshot_goto,
-    .bdrv_snapshot_delete   = sd_snapshot_delete,
-    .bdrv_snapshot_list     = sd_snapshot_list,
+    .bdrv_snapshot_create         = sd_snapshot_create,
+    .bdrv_snapshot_goto           = sd_snapshot_goto,
+    .bdrv_snapshot_delete         = sd_snapshot_delete,
+    .bdrv_snapshot_list           = sd_snapshot_list,
 
-    .bdrv_save_vmstate  = sd_save_vmstate,
-    .bdrv_load_vmstate  = sd_load_vmstate,
+    .bdrv_save_vmstate            = sd_save_vmstate,
+    .bdrv_load_vmstate            = sd_load_vmstate,
 
-    .bdrv_detach_aio_context = sd_detach_aio_context,
-    .bdrv_attach_aio_context = sd_attach_aio_context,
+    .bdrv_detach_aio_context      = sd_detach_aio_context,
+    .bdrv_attach_aio_context      = sd_attach_aio_context,
 
-    .create_opts    = &sd_create_opts,
+    .create_opts                  = &sd_create_opts,
 };
 
 static void bdrv_sheepdog_init(void)
-- 
2.9.5
