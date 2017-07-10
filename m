Received: from eggs.gnu.org ([2001:4830:134:3::10]:54527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVVI-0004VR-Rz
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVVF-0006Ht-Pz
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:01:20 -0400
References: <20170707182151.29872-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61844356-96a4-d466-fdb8-b0f59e693517@redhat.com>
Date: Mon, 10 Jul 2017 12:01:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170707182151.29872-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 07/07/2017 20:21, Eric Blake wrote:
> We are promising more than just odd fixes, and Paolo is hoping
> to offload the pull requests to me.  Also, enough of NBD is related
> to the block layer that it is worth including qemu-block on patches.
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
> +T: git git://repo.or.cz/qemu/ericb.git nbd
> +
>  NFS
>  M: Jeff Cody <jcody@redhat.com>
>  M: Peter Lieven <pl@kamp.de>
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
