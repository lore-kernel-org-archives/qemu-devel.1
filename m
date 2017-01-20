Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUVtZ-0001Vx-Aa
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUVtY-0007bN-Ja
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:54:09 -0500
Date: Fri, 20 Jan 2017 17:53:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170120095359.GE29561@lemon>
References: <20170119205134.50112-1-farman@linux.vnet.ibm.com>
	<20170119205134.50112-4-farman@linux.vnet.ibm.com>
	<20170120093151.GD29561@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170120093151.GD29561@lemon>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: get max_transfer limit for
 char (scsi-generic) devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, 01/20 17:31, Fam Zheng wrote:
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 2115155..94068ca 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -657,9 +657,11 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> >      int max_sectors = 0;
> >      short max_sectors_short = 0;
> >      if (bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
> > +        /* sg returns a value in bytes */
> >          return max_sectors;
> 
> The variable name is now misleading, maybe use "bytes" instead?

BTW patch 2 should already make the function return bytes consistently.  Doing
it here is meaningless code churn.

Fam
