Received: from eggs.gnu.org ([2001:4830:134:3::10]:37705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQa4-0000rx-IJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQa3-0005ff-KH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:03:32 -0500
Date: Mon, 27 Feb 2017 14:03:24 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170227190324.GI25637@localhost.localdomain>
References: <20170227171314.9518-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227171314.9518-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: fix broken sparseness
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Mon, Feb 27, 2017 at 12:13:14PM -0500, John Snow wrote:
> int64_t is in all likelihood the actual scalar type we want.
> Yep, really.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1219541
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index ca8547b..7b4cfbd 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -386,7 +386,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>                              nb_chunks * sectors_per_chunk);
>      bitmap_set(s->in_flight_bitmap, sector_num / sectors_per_chunk, nb_chunks);
>      while (nb_chunks > 0 && sector_num < end) {
> -        int ret;
> +        int64_t ret;
>          int io_sectors, io_sectors_acct;
>          BlockDriverState *file;
>          enum MirrorMethod {
> -- 
> 2.9.3
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc.git block

-Jeff
