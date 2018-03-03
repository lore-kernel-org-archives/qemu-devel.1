Received: from eggs.gnu.org ([2001:4830:134:3::10]:42976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erwbo-00076Y-4d
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erwbl-0004t1-Fg
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:09:12 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:38813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erwbl-0004sr-65
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:09:09 -0500
Received: by mail-oi0-x22e.google.com with SMTP id 123so8422321oig.5
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 18:09:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuUj=cB99yDWLMw67YV=JNyXVBJJMzrTwSzNxBGNvaVCw@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
	<CAFEAcA-kUW+cKPiwzkhLm=+3f-HnkeOCURR73JkFNtd9LE-ABA@mail.gmail.com>
	<CAHNT7NuUj=cB99yDWLMw67YV=JNyXVBJJMzrTwSzNxBGNvaVCw@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 3 Mar 2018 15:09:07 +1300
Message-ID: <CAHNT7NtrRVewRx94prJDbuSBSFxUxvyuA896C8hQocxPi+XZVA@mail.gmail.com>
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

On Thu, Mar 1, 2018 at 9:40 AM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Thu, Mar 1, 2018 at 12:53 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On 28 February 2018 at 00:09, Michael Clark <mjc@sifive.com> wrote:
>> > I've just talked to SiFive about this. They have agreed that we can
>> remove
>> > the sifive_e300 and sifive_u500 boards from the patch series that we are
>> > going to submit upstream again later this week or early next week. These
>> > machines and their devices are pretty easy for us to maintain in the
>> riscv
>> > or a sifive repo. This trims the number of machines from 5 to 3 and
>> lets us
>> > remove the SiFiveUART and SiFivePRCI from the next patch series we are
>> > going to submit. e.g. v8
>>
>> Models of boards which people actively want and are using are fine
>> (though indeed you can save them for a later round of patches if you
>> like). And it sounds like the 1.9.1 stuff is genuinely wanted, so
>> thanks for the clarification there. What I want to avoid is boards
>> going into QEMU just because you happened to have them already. Once
>> a board model goes into QEMU it's a commitment to supporting it for
>> the long term, and getting rid of it again is hard.
>
>
> Most folk in the community at large are interested in the 'spike' and
> 'virt' machines. Well, the linux distributors are currently targetting
> 'virt' as it has working network and block storage.
>
> It's mostly SiFive customers that are interested in the SiFive machines.
>
> SiFive do intend to submit their machines upstream however we've decided
> that we want to review the naming of the machine/board/SOC in light of
> several new models, as there are infact more MCU/SOC models than are
> currently represented in the RISC-V QEMU port (E21, E31, E51, U54, U54MC).
> Those are the SOCs and then there are boards like the HiFive1, the LoFive,
> the HiFive Unleashed and several others (the 7th RISC-V Foundation Workshop
> had an electronic badge with the FE310 designed by antmicro). SiFive might
> like to review the naming and re-jig the SOC / board relationship.
> Presently we created two generic boards to represent the MMU-less E-series
> (sifive_e300) and the U-series (sifive_u500) however that doesn't cover the
> E21 and E51. As well as silicon, there are soft-cores, including soft-cores
> from other vendors (who have not yet submitted anything to the QEMU port).
> After reflecting on this we don't think the naming of the two sifive
> machines is quite right and they are not yet complete emulations. The sifive_u500
> is supposed to model the HiFive Unleashed however we don't have device
> emulation for all of the hardware widgets yet, and some of the drivers are
> not yet in upstream Linux. Linus essentially accepted the generic core,
> which is what we are now suggesting for QEMU. We are totally happy to
> submit them if folk don't mind us potentially renaming them later. This
> is 2 patches for 2 machines and 2 or 3 devices. It would reduce the patch
> series from 23 patches to 18 patches and we'd maintain the 5 files and
> associated headers out-of tree until things firm up. The core of the port
> is pretty solid as Fedora have build stage 4 images using SMP on the 'virt'
> machine.
>

We had internal discussions about the SiFive machines and SiFive decided to
rename SiFive E300 (sifive_e300.c) and SiFive U500 (sifive_u500.c) to
SiFive E Series (sifive_e.c) and SiFive U Series (sifive_u.c). This was the
result of synchronising with the product marketing folk.

- sifive_e will instantiate a e31 nommu core when run in qemu-system-riscv32
- sifive_e will instantiate a e51 nommu core when run in qemu-system-riscv64
- sifive_u will instantiate a u34 mmu core when run in qemu-system-riscv32
- sifive_u will instantiate a u54 mmu core when run in qemu-system-riscv64

The riscv port is interesting because the machines are designed to be
instantiated with either 32-bit or 64-bit cores. SiFive decided they wanted
to get this right before we contributed the SiFive boards. We think we now
have a model we are satisfied with submittting.

We did some last minute changes to strengthen the riscv-qemu port
specificaiton compliance. The nommu machines worked previously but the lack
of an mmu was not enforced. We've now disabled mmu on cores that lack mmu
(SiFive E series). We've also made some changes to strengthen specification
compliance. It is possible for a core to implement S mode and U mode
(Supervisor and User privilege mode) either with or without an mmu. We've
now matches the hardware behaviour and discard mstatus.mpp writes for modes
that are not supported by the core, making it not possible to enter S mode
on the E series cores. We are pretty confident that these are low risk
changes, and we have tested that Linux still works fine in the 'virt'
machine. The 'virt' machine is likely to be the most popular machine for
use by the Linux community.

Given SiFive has SOCs and Soft-core IP, we would like to in the future make
the sifive_u and sifive_e configurable with different memory maps and
hardware widgets, via runtime configuration (command line switches or
configuration file). The intention is for SiFive to be able to model custom
soft-core IP configurations in the  SiFive E series (Everywhere) SiFive U
series (Unleashed). The primary difference between these two machines is
that E series is a nommu MCU and U series is an application processor
capable of running Linux.


> > However I'm inclined to leave it as it is, at this point. It is not
>> > something that we can't change in the future once the code is in-tree.
>>
>
I've coalesced the two spike machines into spike.c and they now share
common code, with two different init routines, one privileged ISA v1.9.1
pre device-tree and one privileged ISA v1.10 with device-tree. We could
refactor further to eliminate some small sections of duplicated code,
although that is a relatively minor issue.

The spike machines are designed to match the riscv-isa-sim (spike)
behaviour and we have created retrospective tags for priv-1.9.1 as we will
be adding this to our test suite. SiFive is committed to maintaining binary
compatibility from privileged ISA v1.9.1 forwards, which in this case
requires command line switches to select the historical behaviour. We are
using this as the starting point of a discipline to not break backwards
compatibility.

With my 'upstream dev' hat on, I tend to be suspicious of this
>> line of argument, because in a lot of cases what tends to happen
>> is that the code for some new target or device goes in-tree, and
>> then the people who worked on submitting it disappear, or never
>> actually do get round to refactoring[*]. You get more leeway for
>> making this argument the longer you've been around and participating
>> in QEMU development, because then you have a track record of
>> following up on things.
>>
>> [*] in fact we're currently discussing deleting support for
>> a couple of target architectures that were basically "once the
>> code went into mainline nothing further was ever done to it except
>> global-refactorings and other tree wide maintenance by other
>> QEMU developers".
>
>
> I might explore coalescing the two spike boards before the v8 spin then.
>
> I was thinking about using a global to enable the backwards compatibility
> mode. It seems -global is for driver properties? Is it appropriate to use
> a global property to change the behaviour of a machine?
>
> Okay, I see raspi.c contains raspi, raspi 2, raspi 3, and it just defines
> multiple machines in the same file and passes a version number to routines
> that are shared. We could go with that approach.
>

I sent the patches for final review as we had been asked to add
Signed-off-by for all of the contributors, which is why I sent out a v8
patch series. The changes are relatively small and are primarily related to
adding the SiFive cores, and making sure that the -cpu help returns the
correct list of cores in qemu-system-riscv32 and qemu-system-riscv64. The
changes were made so that we could keep the two SiFive boards in the port,
so I kind of went out of my way to get these changes in before our final
patch submission.

I am working on some very minor cleanups that I'm working on in my own tree
after going over the code about 8 times:

- https://github.com/michaeljclark/riscv-qemu/commits/qemu-devel

I believe the riscv-qemu-upstream-v8 branch is good to pull. I can hold off
on any other changes for now and we can just still in a rebase loop,
although if we have to rebase again I might be inclined to include the
small set of cleanups that i've noticed on my 9th time over the code.

Apologies if the v8 pull request was premature, but I believe the series
has been rock solid since v6, and subsequent to that the changes have been
license changes, contributor sign offs and some last minute changes to make
it possible for SiFive to submit the SiFive boards upstream with the
correct naming, after internal review.

Thanks,
Michael.
