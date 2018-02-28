Received: from eggs.gnu.org ([2001:4830:134:3::10]:33517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1er8WL-0006zI-TW
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1er8WK-0006U2-6X
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:40:13 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:37597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1er8WJ-0006Tp-TJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:40:12 -0500
Received: by mail-oi0-x232.google.com with SMTP id f186so2820156oig.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 12:40:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kUW+cKPiwzkhLm=+3f-HnkeOCURR73JkFNtd9LE-ABA@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
	<CAFEAcA-kUW+cKPiwzkhLm=+3f-HnkeOCURR73JkFNtd9LE-ABA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 1 Mar 2018 09:40:10 +1300
Message-ID: <CAHNT7NuUj=cB99yDWLMw67YV=JNyXVBJJMzrTwSzNxBGNvaVCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Thu, Mar 1, 2018 at 12:53 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 28 February 2018 at 00:09, Michael Clark <mjc@sifive.com> wrote:
> > I've just talked to SiFive about this. They have agreed that we can
> remove
> > the sifive_e300 and sifive_u500 boards from the patch series that we are
> > going to submit upstream again later this week or early next week. These
> > machines and their devices are pretty easy for us to maintain in the
> riscv
> > or a sifive repo. This trims the number of machines from 5 to 3 and lets
> us
> > remove the SiFiveUART and SiFivePRCI from the next patch series we are
> > going to submit. e.g. v8
>
> Models of boards which people actively want and are using are fine
> (though indeed you can save them for a later round of patches if you
> like). And it sounds like the 1.9.1 stuff is genuinely wanted, so
> thanks for the clarification there. What I want to avoid is boards
> going into QEMU just because you happened to have them already. Once
> a board model goes into QEMU it's a commitment to supporting it for
> the long term, and getting rid of it again is hard.


Most folk in the community at large are interested in the 'spike' and
'virt' machines. Well, the linux distributors are currently targetting
'virt' as it has working network and block storage.

It's mostly SiFive customers that are interested in the SiFive machines.

SiFive do intend to submit their machines upstream however we've decided
that we want to review the naming of the machine/board/SOC in light of
several new models, as there are infact more MCU/SOC models than are
currently represented in the RISC-V QEMU port (E21, E31, E51, U54, U54MC).
Those are the SOCs and then there are boards like the HiFive1, the LoFive,
the HiFive Unleashed and several others (the 7th RISC-V Foundation Workshop
had an electronic badge with the FE310 designed by antmicro). SiFive might
like to review the naming and re-jig the SOC / board relationship.
Presently we created two generic boards to represent the MMU-less E-series
(sifive_e300) and the U-series (sifive_u500) however that doesn't cover the
E21 and E51. As well as silicon, there are soft-cores, including soft-cores
from other vendors (who have not yet submitted anything to the QEMU port).
After reflecting on this we don't think the naming of the two sifive
machines is quite right and they are not yet complete emulations. The
sifive_u500
is supposed to model the HiFive Unleashed however we don't have device
emulation for all of the hardware widgets yet, and some of the drivers are
not yet in upstream Linux. Linus essentially accepted the generic core,
which is what we are now suggesting for QEMU. We are totally happy to
submit them if folk don't mind us potentially renaming them later. This is
2 patches for 2 machines and 2 or 3 devices. It would reduce the patch
series from 23 patches to 18 patches and we'd maintain the 5 files and
associated headers out-of tree until things firm up. The core of the port
is pretty solid as Fedora have build stage 4 images using SMP on the 'virt'
machine.


> > However I'm inclined to leave it as it is, at this point. It is not
> > something that we can't change in the future once the code is in-tree.
>
> With my 'upstream dev' hat on, I tend to be suspicious of this
> line of argument, because in a lot of cases what tends to happen
> is that the code for some new target or device goes in-tree, and
> then the people who worked on submitting it disappear, or never
> actually do get round to refactoring[*]. You get more leeway for
> making this argument the longer you've been around and participating
> in QEMU development, because then you have a track record of
> following up on things.
>
> [*] in fact we're currently discussing deleting support for
> a couple of target architectures that were basically "once the
> code went into mainline nothing further was ever done to it except
> global-refactorings and other tree wide maintenance by other
> QEMU developers".


I might explore coalescing the two spike boards before the v8 spin then.

I was thinking about using a global to enable the backwards compatibility
mode. It seems -global is for driver properties? Is it appropriate to use a
global property to change the behaviour of a machine?

Okay, I see raspi.c contains raspi, raspi 2, raspi 3, and it just defines
multiple machines in the same file and passes a version number to routines
that are shared. We could go with that approach.
