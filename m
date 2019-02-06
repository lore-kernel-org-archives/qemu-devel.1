Received: from eggs.gnu.org ([209.51.188.92]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1grQH5-0001lQ-72
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1grQH4-000561-2X
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:42:11 -0500
Date: Wed, 6 Feb 2019 16:37:04 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190206163704.GV12500@redhat.com>
References: <20190206152919.5532-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206152919.5532-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, Feb 06, 2019 at 04:29:17PM +0100, Max Reitz wrote:
> This series implements .bdrv_refresh_filename() for the ssh block
> driver, along with an appropriate .bdrv_dirname() so we don't chop off
> query strings for backing files with relative filenames.
> 
> This series depends on my "block: Fix some filename generation issues"
> series.
> 
> Based-on: 20190201192935.18394-1-mreitz@redhat.com

I have verified that this doesn't appear to break the existing driver:
ssh connections to block devices still work as well as they did before
(which is to say, not very well, I wish we would replace this driver
with Pino Toscano's reimplementation that uses libssh1).

However I wasn't sure how I could trigger the bdrv_refresh_filename
code path, so I don't think I tested that.

Rich.

> 
> v2:
> - No longer based on the libssh2 -> libssh patches
> - Put /* and */ on their own lines to make checkpatch happy
> 
> 
> Max Reitz (2):
>   block/ssh: Implement .bdrv_refresh_filename()
>   block/ssh: Implement .bdrv_dirname()
> 
>  block/ssh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 5 deletions(-)
> 
> -- 
> 2.20.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
