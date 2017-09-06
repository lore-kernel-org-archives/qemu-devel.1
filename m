Received: from eggs.gnu.org ([2001:4830:134:3::10]:55400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpb8B-0007cJ-PQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpb86-00084V-NK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:16:39 -0400
Date: Wed, 6 Sep 2017 15:16:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170906141631.GE15535@stefanha-x1.localdomain>
References: <20170901201054.11738-1-briansteffens@gmail.com>
	<20170905095610.GF17449@stefanha-x1.localdomain>
	<CALGxsMdOM_pv-uqMoC0MSVo0ai1vm_nHdZ5U8BNt+YNMXQEpkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALGxsMdOM_pv-uqMoC0MSVo0ai1vm_nHdZ5U8BNt+YNMXQEpkA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: add block device shared field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brian Steffens <briansteffens@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Tue, Sep 05, 2017 at 11:10:55AM -0400, Brian Steffens wrote:
> > Have you considered extending the 'migrate' command with a list of
> > drives instead?
> 
> That was my original plan but I thought having information on whether a
> device is shared or not could potentially be useful to other systems. If
> not then you're right, it would be a lighter touch to add it only to the
> 'migrate' command.

I agree with Fam that bs->shared doesn't necessarily have the same
meaning to everyone.  Therefore I suggest extending the 'migrate'
command instead.

> > In case you haven't seen it, the preferred approach for non-shared
> > storage migration is drive-mirror + NBD.  The block/migration.c code is
> > an older feature that is less flexible.  More info on drive-mirror +
> > NBD:
> 
> I didn't realize drive-mirror + NBD was the preferred approach. Are
> there any plans to drop support for the block/migration.c style?

migration/block.c is not formally deprecated yet.  It's still used by
libvirt in situations where NBD connections are not desirable.
Eventually it will probably be deprecated and then removed after 2 more
QEMU releases according to the deprecation policy (see qemu-doc.texi).

Stefan
