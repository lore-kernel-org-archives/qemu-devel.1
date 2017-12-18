Received: from eggs.gnu.org ([2001:4830:134:3::10]:60132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2ed-0002AM-Qm
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2ea-0003Wf-6b
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:55 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:16 -0500
Message-Id: <20171218210819.31576-8-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] block/sheepdog: remove spurious NULL check
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

'tag' is already checked in the lines immediately preceding this check,
and set to non-NULL if NULL.  No need to check again, it hasn't changed.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 696a714..459d93a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1632,7 +1632,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     if (!tag) {
         tag = "";
     }
-    if (tag && strlen(tag) >= SD_MAX_VDI_TAG_LEN) {
+    if (strlen(tag) >= SD_MAX_VDI_TAG_LEN) {
         error_setg(errp, "value of parameter 'tag' is too long");
         ret = -EINVAL;
         goto err_no_fd;
-- 
2.9.5
