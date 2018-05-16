Received: from eggs.gnu.org ([2001:4830:134:3::10]:53942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fIzwp-0004Ag-Nd
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fIzwp-0002Qx-1d
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:10:43 -0400
Date: Wed, 16 May 2018 13:10:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180516171038.GC6999@localhost.localdomain>
References: <20180516161034.27440-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516161034.27440-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nfs: Fix error path in
 nfs_options_qdict_to_qapi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Wed, May 16, 2018 at 06:10:34PM +0200, Kevin Wolf wrote:
> Don't throw away local_err, but propagate it to errp.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/nfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index d6364d28bb..3349b67a76 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -571,6 +571,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
>      qobject_unref(crumpled);
>  
>      if (local_err) {
> +        error_propagate(errp, local_err);
>          return NULL;
>      }
>  
> -- 
> 2.13.6
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
