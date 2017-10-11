Received: from eggs.gnu.org ([2001:4830:134:3::10]:47178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=450336ad9=anthony.perard@citrix.com>)
	id 1e2JXV-0006VB-BW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=450336ad9=anthony.perard@citrix.com>)
	id 1e2JXS-0003cS-7M
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:07:21 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=450336ad9=anthony.perard@citrix.com>)
	id 1e2JXR-0003c4-W3
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:07:18 -0400
Date: Wed, 11 Oct 2017 17:06:51 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171011160651.GR1771@perard.uk.xensource.com>
References: <20171011155203.16502-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171011155203.16502-1-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen: Log errno rather than return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Oct 11, 2017 at 04:52:03PM +0100, Ross Lagerwall wrote:
> xen_modified_memory() sets errno to communicate what went wrong so log
> this rather than the return value which is not interesting.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d9ccd5d..8028bed 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1446,7 +1446,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
>          if (rc) {
>              fprintf(stderr,
>                      "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
> -                    __func__, start, nb_pages, rc, strerror(-rc));
> +                    __func__, start, nb_pages, errno, strerror(errno));
>          }
>      }
>  }

There is already a patch, not applied yet for it,
https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg07541.html
with the only difference is printing the value of rc and not errno (both
patch user errno for strerror).

I guess this patch is better, so
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
