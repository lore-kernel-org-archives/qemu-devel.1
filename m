Received: from eggs.gnu.org ([2001:4830:134:3::10]:59097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fj1hK-0002Q1-DV
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1fj1hH-0008CQ-7l
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:18:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1fj1hH-0008Bs-0b
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:18:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so3775581edp.9
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180724084739.580-1-famz@redhat.com>
	<20180727092215.GG19416@lemon.usersys.redhat.com>
	<20180727100442.GC4355@localhost.localdomain>
In-Reply-To: <20180727100442.GC4355@localhost.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 27 Jul 2018 20:17:37 +0800
Message-ID: <CAK1Eb9mW5eZ3opbB=qd4dJUngw4HP9_VOXsO2WLo208tUw2pYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Fix 226 on _my_ system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 27, 2018 at 6:04 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 27.07.2018 um 11:24 hat Fam Zheng geschrieben:
> > On Tue, 07/24 16:47, Fam Zheng wrote:
> > > Something has locked /dev/null on my system (I still don't know what to do with
> > > the annoying incapability of lslocks, or more precisely /proc/locks, on
> > > inspecting OFD lock information), and as a result 226 cannot pass due to the
> > > unexpected image locking error.
> > >
> > > Fix the test case by disabling locking, and add a doc text about using test
> > > images.
> > >
> > > Fam Zheng (2):
> > >   docs: Describe using images in writing iotests
> > >   iotests: Don't lock /dev/null in 226
> > >
> > >  docs/devel/testing.rst | 11 +++++++++++
> > >  tests/qemu-iotests/226 |  4 ++--
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > Kevin, could you apply this for 3.0 too?
>
> Sure, applied to the block branch.
>
> Out of curiosity, did you find out what had locked the devices?

No, but I'll for sure allocate some time to understand kernel's OFD
internals, find the holder application, then hopefully, propose
something that can fix lslocks.

Thanks,
Fam

>
> Kevin
