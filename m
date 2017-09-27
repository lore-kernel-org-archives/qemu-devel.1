Received: from eggs.gnu.org ([2001:4830:134:3::10]:52165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=43635ca44=anthony.perard@citrix.com>)
	id 1dxFGr-0000pK-ER
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=43635ca44=anthony.perard@citrix.com>)
	id 1dxFGn-00084m-Fc
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:33:13 -0400
Received: from smtp.citrix.com ([66.165.176.89]:11727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=43635ca44=anthony.perard@citrix.com>)
	id 1dxFGn-000844-9y
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:33:09 -0400
Date: Wed, 27 Sep 2017 17:33:06 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170927163306.GI1859@perard.uk.xensource.com>
References: <20170927161009.28091-1-wei.liu2@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170927161009.28091-1-wei.liu2@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-hvm: use errno in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Liu <wei.liu2@citrix.com>
Cc: qemu-devel@nongnu.org, Xen-devel <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Sep 27, 2017 at 05:10:09PM +0100, Wei Liu wrote:
> The error code is encoding in errno, not rc.

                    ^ encoded
I think.

Otherwise,
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

> 
> Signed-off-by: Wei Liu <wei.liu2@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d9ccd5d0d6..f79816a649 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1446,7 +1446,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
>          if (rc) {
>              fprintf(stderr,
>                      "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
> -                    __func__, start, nb_pages, rc, strerror(-rc));
> +                    __func__, start, nb_pages, rc, strerror(errno));
>          }
>      }
>  }
> -- 
> 2.11.0
> 

-- 
Anthony PERARD
