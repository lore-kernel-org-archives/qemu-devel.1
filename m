Received: from eggs.gnu.org ([2001:4830:134:3::10]:43218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejzNe-0004ax-51
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejzNc-0000gh-Gq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:29:42 -0500
Date: Fri, 9 Feb 2018 11:29:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180209032739.GM24289@lemon.usersys.redhat.com>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
	<b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
	<20180130163820.GC4503@localhost.localdomain>
	<20180131141247.GC23336@stefanha-x1.localdomain>
	<20180131142249.GB3598@localhost.localdomain>
	<20180201114425.GD5783@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201114425.GD5783@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, 02/01 11:44, Stefan Hajnoczi wrote:
> On Wed, Jan 31, 2018 at 03:22:49PM +0100, Kevin Wolf wrote:
> > Am 31.01.2018 um 15:12 hat Stefan Hajnoczi geschrieben:
> > > There should be a separate paragraph in docs/qemu-block-drivers.texi
> > > explaining that share-rw=on can be used safely with format=raw if the
> > > guests are configured to safely access a shared disk.  It should also
> > > mention that share-rw=on is unsafe for image formats.
> > 
> > share-rw=on is a -device option and only about the guest, not about the
> > backend. It is never unsafe if the guest can cope with external writers.
> > It just doesn't prevent qemu from locking the image file for image
> > formats.
> 
> Thanks for the explanation.  Documentation on share-rw=on|off would be
> nice.
> 
> Maybe something like:
> 
>   By default the guest has exclusive write access to its disk image.
>   This is enforced by QEMU via file locking.  If the guest can safely
>   share the disk image with other writers the -device ...,share-rw=on
>   parameter can be used.  This is only safe if the guest is running
>   software, such as a cluster file system, that coordinates disk
>   accesses to avoid corruption.
> 
>   Note that share-rw=on only declares the guest's ability to share the
>   disk.  Some QEMU features, such as image file formats, require
>   exclusive write access to the disk image and this is unaffected by the
>   share-rw=on option.

I will add these paragraphs to the "image locking" seciton in
docs/qemu-block-drivers.texi.

Fam
