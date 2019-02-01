Received: from eggs.gnu.org ([209.51.188.92]:44387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpWVq-0007nU-CR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpWVp-0002fo-Jm
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:57:34 -0500
Date: Fri, 1 Feb 2019 11:57:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201105723.GD5730@localhost.localdomain>
References: <20181210112649.11581-1-peter.maydell@linaro.org>
	<20190118161746.GG4530@dhcp-200-176.str.redhat.com>
	<CAFEAcA95dfYRZE9YnpX=JQanfi_Y2HcYkj5RW5VGu2KiWiBDhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA95dfYRZE9YnpX=JQanfi_Y2HcYkj5RW5VGu2KiWiBDhQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] block: fix last
 address-of-packed-member warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>

Am 01.02.2019 um 11:30 hat Peter Maydell geschrieben:
> On Fri, 18 Jan 2019 at 16:17, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 10.12.2018 um 12:26 hat Peter Maydell geschrieben:
> > > This patchset fixes the remaining clang warnings in the block/ code
> > > about taking the address of a packed struct member, which are all
> > > in block/vpc and block/vdi code handling UUIDs. Mostly I fix
> > > these by copying the unaligned field to/from a local variable.
> > > In the case of qemu_uuid_bswap() I opted to change the API to
> > > take and return the QemuUUID rather than taking a pointer to it,
> > > which makes almost all the callsites simpler. This does mean
> > > a struct copy but the struct is only 16 bytes and I didn't
> > > judge any of the callsites performance-sensitive enough to care
> > > about a struct copy of that size.
> > >
> > > As usual, tested with "make check" only.
> >
> > Thanks, applied to the block branch.
> 
> Ping? These don't seem to have made it into master yet.

It's in my queue.

Kevin
