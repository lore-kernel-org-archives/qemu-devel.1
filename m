Received: from eggs.gnu.org ([209.51.188.92]:52808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzo0S-0004Lq-24
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzo0R-00028T-27
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:39:39 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d36a2f9c-09db-e5cc-21e9-bab43a6f0744@redhat.com>
Date: Fri, 1 Mar 2019 13:39:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block/dirty-bitmaps: prohibit
 removing readonly bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

On 3/1/19 1:15 PM, John Snow wrote:
> Remove is an inherently RW operation, so this will fail anyway, but
> we can fail it very quickly instead of trying and failing, so do so.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/blockdev.c b/blockdev.c
> index c8255dda0b..a9a059c570 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2881,7 +2881,8 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>          return;
>      }
>  
> -    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY, errp)) {
> +    if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_RO,
> +                                errp)) {
>          return;
>      }
>  
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
