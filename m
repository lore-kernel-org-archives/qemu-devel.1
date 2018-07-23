Received: from eggs.gnu.org ([2001:4830:134:3::10]:51022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxt-0002DM-D9
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxs-0005AP-AP
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:25 +0200
Message-Id: <20180723164530.26599-3-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] block: Fix typos in comments (found by
 codespell)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c         | 2 +-
 block/backup.c  | 4 ++--
 block/curl.c    | 2 +-
 block/gluster.c | 2 +-
 block/vhdx.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index a2fe05ea96..39f373e035 100644
--- a/block.c
+++ b/block.c
@@ -3002,7 +3002,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
  *
  * Reopens all BDS specified in the queue, with the appropriate
  * flags.  All devices are prepared for reopen, and failure of any
- * device will cause all device changes to be abandonded, and intermediate
+ * device will cause all device changes to be abandoned, and intermediate
  * data cleaned up.
  *
  * If all devices prepare successfully, then the changes are committed
diff --git a/block/backup.c b/block/backup.c
index 319fc922e8..8630d32926 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -91,7 +91,7 @@ static void cow_request_end(CowRequest *req)
 }
 
 /* Copy range to target with a bounce buffer and return the bytes copied. If
- * error occured, return a negative error number */
+ * error occurred, return a negative error number */
 static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       int64_t start,
                                                       int64_t end,
@@ -148,7 +148,7 @@ fail:
 
 }
 
-/* Copy range to target and return the bytes copied. If error occured, return a
+/* Copy range to target and return the bytes copied. If error occurred, return a
  * negative error number. */
 static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
                                                 int64_t start,
diff --git a/block/curl.c b/block/curl.c
index aa42535783..229bb84a27 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -804,7 +804,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
     /* Prior CURL 7.19.4 return value of 0 could mean that the file size is not
      * know or the size is zero. From 7.19.4 CURL returns -1 if size is not
-     * known and zero if it is realy zero-length file. */
+     * known and zero if it is really zero-length file. */
 #if LIBCURL_VERSION_NUM >= 0x071304
     if (d < 0) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
diff --git a/block/gluster.c b/block/gluster.c
index a4e1c8ecd8..4fd55a9cc5 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1326,7 +1326,7 @@ static int qemu_gluster_has_zero_init(BlockDriverState *bs)
  * If @start is in a trailing hole or beyond EOF, return -ENXIO.
  * If we can't find out, return a negative errno other than -ENXIO.
  *
- * (Shamefully copied from file-posix.c, only miniscule adaptions.)
+ * (Shamefully copied from file-posix.c, only minuscule adaptions.)
  */
 static int find_allocation(BlockDriverState *bs, off_t start,
                            off_t *data, off_t *hole)
diff --git a/block/vhdx.c b/block/vhdx.c
index 4d0819750f..0795ca1985 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -185,7 +185,7 @@ uint32_t vhdx_checksum_calc(uint32_t crc, uint8_t *buf, size_t size,
 /* Validates the checksum of the buffer, with an in-place CRC.
  *
  * Zero is substituted during crc calculation for the original crc field,
- * and the crc field is restored afterwards.  But the buffer will be modifed
+ * and the crc field is restored afterwards.  But the buffer will be modified
  * during the calculation, so this may not be not suitable for multi-threaded
  * use.
  *
-- 
2.13.6
