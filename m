Received: from eggs.gnu.org ([2001:4830:134:3::10]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGpCW-0001Sf-9B
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eGpCT-0001bp-7E
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:45:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eGpCT-0001be-0I
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:45:37 -0500
Date: Mon, 20 Nov 2017 17:45:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171120164532.GF7197@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-4-anatol.pomozov@gmail.com>
	<CAOMFOmUaJT+OdfN9Yin91AiP_+HXMbVFXuPY0FORb1PNvzYCmw@mail.gmail.com>
	<20171019093647.GA6195@localhost.localdomain>
	<CAOMFOmVQ0zWgqjMED-AWfS5Nt2caoHz5JxXmc690AEqD1Kji_w@mail.gmail.com>
	<CAOMFOmUNrgZhpzkXLx2Ne1RKpPS6AbVU7LvBmKE=E6QZiWnw8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmUNrgZhpzkXLx2Ne1RKpPS6AbVU7LvBmKE=E6QZiWnw8w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] multiboot: load elf sections and
 section headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, peter.maydell@linaro.org

Am 17.11.2017 um 22:33 hat Anatol Pomozov geschrieben:
> On Tue, Oct 31, 2017 at 11:38 AM, Anatol Pomozov
> <anatol.pomozov@gmail.com> wrote:
> > Hi
> >
> > On Thu, Oct 19, 2017 at 2:36 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> >> Am 18.10.2017 um 19:22 hat Anatol Pomozov geschrieben:
> >>> Hello qemu-devs,
> >>>
> >>> This patchset has been posted a while ago. I would like to move
> >>> forward with it and look at the next task (e.g. multiboot2 support in
> >>> QEMU). Who is the multiboot code maintainer who can help to review
> >>> this patchset and give go/no-go answer?
> >>
> >> I think that's exactly your problem, there is nobody who feels
> >> responsible for Multiboot support. Officially, it is part of the PC/x86
> >> subsystems:
> >
> > In this case I would like to become the official Qemu/Multiboot
> > maintainer. I do development related to x86 osdev and actively use
> > qemu for my projects. I am interested in having a feature-rich and
> > robust Multiboot implementation.
> 
> It is very unfortunate to see lack of interest in improving
> qemu/multiboot functionality. I guess my best option for now is to
> avoid using qemu multiboot implementation and use grub instead.

Let's wait until 2.11 is out and we're out of freeze, and then I think
your best bet is to just prepare a pull request that adds you to
MAINTAINERS and applies the patches you created so far.

Peter, does this sound right?

Kevin
