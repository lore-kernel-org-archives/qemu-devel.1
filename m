Received: from eggs.gnu.org ([2001:4830:134:3::10]:58352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUVji-00034T-8Y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUVjh-0008J3-7J
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:16:14 -0400
Date: Mon, 10 Jul 2017 18:16:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170710101604.GA19707@lemon.lan>
References: <20170707182151.29872-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707182151.29872-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Promote NBD to supported,
 with new maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org

On Fri, 07/07 13:21, Eric Blake wrote:
> We are promising more than just odd fixes, and Paolo is hoping
> to offload the pull requests to me.  Also, enough of NBD is related
> to the block layer that it is worth including qemu-block on patches.

Cool!

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> If there are no objections, I'll include this patch and Vladimir's
> series in my first NBD pull request.
> 
>  MAINTAINERS | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e17216..beaba51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1348,15 +1348,6 @@ W: http://info.iet.unipi.it/~luigi/netmap/
>  S: Maintained
>  F: net/netmap.c
> 
> -Network Block Device (NBD)
> -M: Paolo Bonzini <pbonzini@redhat.com>
> -S: Odd Fixes
> -F: block/nbd*
> -F: nbd/
> -F: include/block/nbd*
> -F: qemu-nbd.c
> -T: git git://github.com/bonzini/qemu.git nbd-next
> -
>  NUMA
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  S: Maintained
> @@ -1710,6 +1701,17 @@ S: Supported
>  F: block/iscsi.c
>  F: block/iscsi-opts.c
> 
> +Network Block Device (NBD)
> +M: Eric Blake <eblake@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +L: qemu-block@nongnu.org
> +S: Maintained
> +F: block/nbd*
> +F: nbd/
> +F: include/block/nbd*
> +F: qemu-nbd.c

While we are at it, add qemu-nbd.texi when you send pull request, if you don't
respin?

> +T: git git://repo.or.cz/qemu/ericb.git nbd

Out of curiosity: Paolo is still in "M:", but his "T:" is gone.  Intended?

> +
>  NFS
>  M: Jeff Cody <jcody@redhat.com>
>  M: Peter Lieven <pl@kamp.de>
> -- 
> 2.9.4
> 
> 

Fam
