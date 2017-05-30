Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFj4j-0007or-FT
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dFj4i-0004E5-Ll
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:49 -0400
Date: Tue, 30 May 2017 11:28:43 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170530152843.GA2665@localhost.localdomain>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
	<1496157773-10779-2-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496157773-10779-2-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/4] block: Fix anonymous
 BBs in blk_root_inactivate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, May 30, 2017 at 05:22:50PM +0200, Kevin Wolf wrote:
> blk->name isn't an array, but a pointer that can be NULL. Checking for
> an anonymous BB must involve a NULL check first, otherwise we get
> crashes.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/block-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index f3a6008..7d7f369 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -168,7 +168,7 @@ static int blk_root_inactivate(BdrvChild *child)
>       * this point because the VM is stopped) and unattached monitor-owned
>       * BlockBackends. If there is still any other user like a block job, then
>       * we simply can't inactivate the image. */
> -    if (!blk->dev && !blk->name[0]) {
> +    if (!blk->dev && !blk_name(blk)[0]) {
>          return -EPERM;
>      }
>  
> -- 
> 1.8.3.1
> 
>

Reviewed-by: Jeff Cody <jcody@redhat.com>
