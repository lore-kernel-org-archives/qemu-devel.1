Received: from eggs.gnu.org ([2001:4830:134:3::10]:33564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLN-00009G-89
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLL-0004cO-NG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:41 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 17:27:21 -0500
Message-Id: <8a612e6e2f30e4c3fb367270f78d359e881ac1e6.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] block/sheepdog: code beautification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com, eblake@redhat.com

No functional changes, just whitespace manipulation.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
