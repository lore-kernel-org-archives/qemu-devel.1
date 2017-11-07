Received: from eggs.gnu.org ([2001:4830:134:3::10]:33513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLL-00007N-N0
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLL-0004by-1B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:39 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 17:27:20 -0500
Message-Id: <fa437e7bf3f9d825544d3833f779b417ba1f39a3.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/7] block/sheepdog: remove spurious NULL
 check
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

'tag' is already checked in the lines immediately preceding this check,
and set to non-NULL if NULL.  No need to check again, it hasn't changed.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
