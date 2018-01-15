Received: from eggs.gnu.org ([2001:4830:134:3::10]:51923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb67y-0008Ef-G6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb67u-0005O9-Kg
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:52:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eb67u-0005NC-EJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:52:42 -0500
Date: Mon, 15 Jan 2018 15:52:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180115145212.GH32271@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-3-anatol.pomozov@gmail.com>
	<20171013192550.GC3246@localhost.localdomain>
	<CAOMFOmW+r86WHWPUMtG54BrAQXqSWZ67oF-6G697ox-7AKL4GA@mail.gmail.com>
	<20171013232114.GD3246@localhost.localdomain>
	<CAFEAcA-zYJUOqH=WU_XnyxEfiZM7a2yqmzndTrf=pKkp=1wUGA@mail.gmail.com>
	<20171016082755.GA5145@localhost.localdomain>
	<CAOMFOmUM7Ct6kUdrB=y2vk6Fm+dFybQb=8hbcUmKNb2RrL2Lew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmUM7Ct6kUdrB=y2vk6Fm+dFybQb=8hbcUmKNb2RrL2Lew@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 16.10.2017 um 20:38 hat Anatol Pomozov geschrieben:
> Hi
> 
> On Mon, Oct 16, 2017 at 1:27 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 14.10.2017 um 15:41 hat Peter Maydell geschrieben:
> >> On 14 October 2017 at 00:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> > I don't believe the spec restricts that, but I don't see why it
> >> > would be useful to load an ELF file that doesn't match the target
> >> > architecture (e.g. loading non-x86 ELF files on a x86 machine
> >> > like PC).
> 
> I see what do you mean Eduardo. Yes it makes sense to restrict ELF to
> the currently emulated platform.
> 
> On a second thought adding multiboot support for non x86 needs to go
> with other changes, e.g. multiboot.c should be moved out of hw/i386 to
> some platform-independent location. It probably worth to postpone this
> change until after Qemu gets multiboot2 support that explicitly states
> MIPS support, thus it will be easier to test this codepath on multiple
> platforms.
> 
> So if you don't mind I'll remove this patch from the current patch
> series and put it into later one.

I can't find a new version of this patch series with this patch dropped.
Are you still planning to send one?

Kevin
