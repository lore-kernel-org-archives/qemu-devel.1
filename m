Received: from eggs.gnu.org ([2001:4830:134:3::10]:58237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egFdD-0004dk-Tg
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egFd9-0008B5-2B
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1egFd8-0008An-SV
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:02:14 -0500
Date: Mon, 29 Jan 2018 21:02:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129200210.GT6141@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-2-anatol.pomozov@gmail.com>
	<20180115144944.GG32271@localhost.localdomain>
	<CAOMFOmU4pLtJMQ_SLqffpritydx4ghs9gUJBfyVT+zN_fudCRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmU4pLtJMQ_SLqffpritydx4ghs9gUJBfyVT+zN_fudCRA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] multiboot: Change multiboot_info from
 array of bytes to a C struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 29.01.2018 um 19:21 hat Anatol Pomozov geschrieben:
> Hi
> 
> On Mon, Jan 15, 2018 at 6:49 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 13.10.2017 um 01:54 hat Anatol Pomozov geschrieben:
> >> Using C structs makes the code more readable and prevents type conversion
> >> errors.
> >>
> >> Borrow multiboot1 header from GRUB project.
> >>
> >> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> >> ---
> >>  hw/i386/multiboot.c         | 124 +++++++++------------
> >>  hw/i386/multiboot_header.h  | 254 ++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/multiboot/mmap.c      |  14 +--
> >>  tests/multiboot/mmap.out    |  10 ++
> >>  tests/multiboot/modules.c   |  12 ++-
> >>  tests/multiboot/modules.out |  10 ++
> >>  tests/multiboot/multiboot.h |  66 ------------
> >>  7 files changed, 339 insertions(+), 151 deletions(-)
> >>  create mode 100644 hw/i386/multiboot_header.h
> >>  delete mode 100644 tests/multiboot/multiboot.h
> >
> > This is a good change in general. However, I'm not sure if we should
> > really replace the header used in the tests. After all, the tests also
> > test whether things are at the right place, and if there is an error in
> > the header file, we can only catch it if the tests keep using their own
> > definitions.
> 
> The added multibooh.h is from GRUB - the developers of multiboot. I
> think we can trust it. Having a single header will make future tests
> maintainence easier.
> 
> But if you feel strongly that qemu tests should use it's own version
> of multiboot header then I can add it back.

No, I don't feel strongly, just wanted to mention that there is an
advantage of having a separate header in case you had not thought of it.
The decision is up to you.

Kevin
