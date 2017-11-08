Received: from eggs.gnu.org ([2001:4830:134:3::10]:51677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eCNv0-0000X2-Pc
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eCNv0-00055q-1s
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:49:14 -0500
Date: Wed, 8 Nov 2017 10:48:57 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171108104857.yvg3p3j3wxpbvlrl@starbug-vm.ie.oracle.com>
References: <cover.1510093478.git.jcody@redhat.com>
	<fa437e7bf3f9d825544d3833f779b417ba1f39a3.1510093478.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <fa437e7bf3f9d825544d3833f779b417ba1f39a3.1510093478.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 3/7] block/sheepdog: remove
 spurious NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

On Tue, Nov 07, 2017 at 05:27:20PM -0500, Jeff Cody wrote:
>'tag' is already checked in the lines immediately preceding this check,
>and set to non-NULL if NULL.  No need to check again, it hasn't changed.
>
>Signed-off-by: Jeff Cody <jcody@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> block/sheepdog.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/block/sheepdog.c b/block/sheepdog.c
>index 696a714..459d93a 100644
>--- a/block/sheepdog.c
>+++ b/block/sheepdog.c
>@@ -1632,7 +1632,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
>     if (!tag) {
>         tag = "";
>     }
>-    if (tag && strlen(tag) >= SD_MAX_VDI_TAG_LEN) {
>+    if (strlen(tag) >= SD_MAX_VDI_TAG_LEN) {
>         error_setg(errp, "value of parameter 'tag' is too long");
>         ret = -EINVAL;
>         goto err_no_fd;
>-- 
>2.9.5
>
>
