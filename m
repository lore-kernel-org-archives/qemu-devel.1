Received: from eggs.gnu.org ([2001:4830:134:3::10]:49193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cwEVR-0003dt-QE
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cwEVQ-0002jI-Nj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 16:59:49 -0400
Date: Thu, 6 Apr 2017 21:59:39 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170406205939.GA28584@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
	<1488314205-16264-44-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488314205-16264-44-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write
 permissions
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

On Tue, Feb 28, 2017 at 09:36:42PM +0100, Kevin Wolf wrote:
> This adds assertions that ensure that the necessary write permissions
> have been granted before someone attempts to write to a node.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Acked-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index 2592ca1..4c79745 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -945,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>      size_t skip_bytes;
>      int ret;
>  
> +    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));


This assertion is thrown in the libguestfs test suite.  I filed a bug
about it against the Fedora package:

https://lists.gnu.org/archive/html/qemu-block/2017-02/msg01305.html

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
