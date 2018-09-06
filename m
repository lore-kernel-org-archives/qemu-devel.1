Received: from eggs.gnu.org ([2001:4830:134:3::10]:58215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxh1-0004Nj-Es
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxh0-0007tP-Ki
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:03:43 -0400
Date: Thu, 6 Sep 2018 13:03:34 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180906170334.GN22117@localhost.localdomain>
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-17-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906130225.5118-17-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 16/16] blockdev: document transactional
 shortcomings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Sep 06, 2018 at 09:02:25AM -0400, John Snow wrote:
> Presently only the backup job really guarantees what one would consider
> transactional semantics. To guard against someone helpfully adding them
> in the future, document that there are shortcomings in the model that
> would need to be audited at that time.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  blockdev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 0cf8febe6c..d4b42403df 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2182,7 +2182,13 @@ static const BlkActionOps actions[] = {
>          .instance_size = sizeof(BlockDirtyBitmapState),
>          .prepare = block_dirty_bitmap_disable_prepare,
>          .abort = block_dirty_bitmap_disable_abort,
> -     }
> +    },
> +    /* Where are transactions for MIRROR, COMMIT and STREAM?
> +     * Although these blockjobs use transaction callbacks like the backup job,
> +     * these jobs do not necessarily adhere to transaction semantics.
> +     * These jobs may not fully undo all of their actions on abort, nor do they
> +     * necessarily work in transactions with more than one job in them.
> +     */
>  };
>  
>  /**
> -- 
> 2.14.4
> 
