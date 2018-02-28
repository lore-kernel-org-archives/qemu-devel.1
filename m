Received: from eggs.gnu.org ([2001:4830:134:3::10]:40987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqpJ6-0000dS-EJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 19:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqpJ3-0003vd-TE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 19:09:16 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:36773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eqpJ3-0003vG-JX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 19:09:13 -0500
Received: by mail-oi0-x234.google.com with SMTP id u73so500665oie.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:09:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Feb 2018 13:09:11 +1300
Message-ID: <CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re:  [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stef O'Rear <sorear2@gmail.com>
Cc: RISC-V Patches <patches@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Feb 28, 2018 at 4:50 AM, Stef O'Rear <sorear2@gmail.com> wrote:

> On Tue, Feb 27, 2018 at 6:01 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > On 27 February 2018 at 00:15, Michael Clark <mjc@sifive.com> wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5a
> f8c5c2a6d0:
> >>
> >>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07
> +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v7
> >>
> >> for you to fetch changes up to 170a9d412ca1eb3b7ae6f6c1ff86dc
> bdff0fd7a8:
> >>
> >>   RISC-V Build Infrastructure (2018-02-27 11:09:43 +1300)
> >>
> >> - ----------------------------------------------------------------
> >> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
> >
> > Hi; thanks for this pull request. Unfortunately it seems to
> > be missing Signed-off-by: tags. Every commit needs to have
> > the Signed-off-by: tags from the people who contributed code to
> > it, indicating that they're OK with the code going into QEMU.
> > (If the work was done by and copyright a company then you don't
> > need to provide signoffs from every person at the company who
> > worked on the code if you don't want to.)
>
> I'll add mine.
>
> >> The spike_v1.9
> >> machine has been renamed to spike_v1.9.1 to match the privileged ISA
> >> version and spike_v1.10 has been made the default machine.
> >
> > I'm confused about this. Generally QEMU boards should model
> > hardware, and the board shouldn't care about the ISA versions.
>
> The spike boards model the Berkeley architectural simulator "spike"
> (https://github.com/riscv/riscv-isa-sim), which does not have a formal
> release process or version numbers so we are using the ISA version as
> a proxy for spike's version.
>
> When physical boards are released with full documentation I presume we
> will be adding board definitions for them, and they will imply
> specific ISA versions.
>
> > Versioned board names in QEMU generally follow _QEMU_'s versioning,
> > and indicate that a board is identical to whatever we modelled
> > in that earlier QEMU version, for VM migration compatibility.
>
> In this case we're handling two logically distinct boards.  We could
> combine them and implement a parameter; I was having trouble finding a
> suitable example to follow earlier but it looks like gic-version in
> hw/arm/virt.c is one.  This seems like a bad thing to change this late
> in the review though?
>
> > Board renames for minor ISA version bumps sounds like there's going
> > to be a lot of churn and breakage -- is this stuff really ready?
> > (Also, should we really have two different board source files
> > for two different ISA versions? I would have expected these to
> > share a source file to share code.)
>
> 1.10 is the version we have committed to long term support for; it
> matches all public hardware the upstream Linux port, so it seems
> appropriate to use for QEMU.
>
> 1.9.1 was the version supported by riscv-qemu at the time Michael
> Clark took over maintainership; we have not removed support for it
> because we cannot prove that there is nobody depending on it, although
> I do not use it myself and do not know anyone else who does, so I
> would not personably object to removing it if that were required.
>
> Combining spike_v1.10 and spike_v1.9.1 would also be an option amenable to
> us.
>

I've just talked to SiFive about this. They have agreed that we can remove
the sifive_e300 and sifive_u500 boards from the patch series that we are
going to submit upstream again later this week or early next week. These
machines and their devices are pretty easy for us to maintain in the riscv
or a sifive repo. This trims the number of machines from 5 to 3 and lets us
remove the SiFiveUART and SiFivePRCI from the next patch series we are
going to submit. e.g. v8

SiFive have indicated that they would like to keep privileged ISA v1.9.1
support. It's likely the RISC-V foundation would also like us to start
supporting backwards compatibility from this point. Removing support for a
specification version only 4 months after the latest specification has been
implemented is too severe of a deprecation period. They have said they
would like QEMU to support at least 2 specification versions so we won't
consider removing privileged ISA v1.9.1 support until privileged ISA v1.11
has been released and implemented. There are still several OS ports and
private tape-outs and test chips that target privileged ISA v1.9.1. In
fact, someone may very well add privileged ISA v1.9 and privileged ISA v1.7
support, perhaps as a computing history project. The published
specifications are all available however the chips implementing these
versions of the spec are mostly test chips. Nevertheless, they are part of
RISC-V history.

With respect to combining them, we could investigate triggering the config
string vs flattened device-tree, based on a restricted set of cpu models.
e.g. make spike-10901 and spike-11000 CPU models and have the spike board
supply config string or flattened device-tree based on the cpu model it is
being invoked with.

However I'm inclined to leave it as it is, at this point. It is not
something that we can't change in the future once the code is in-tree.

There will be strong resistance to removing privileged ISA v1.9.1. The
privileged
ISA specification version number is currently the only strong contract as
to the behaviour of the privileged control and status registers. The Base
ISA however is pretty much rock-solid before we started work on QEMU.
Privileged
ISA specification v1.10 will likely not make backwards incompatible
changes, however this does not change our stance on maintaining
compatibility with the official RISC-V ISA Simulator, for both privileged
ISA v1.9.1 and privileged ISA v1.10.

It's likely going forward that we won't see version compatibility breaks,
but in the process of implementing this discipline, it means we must keep
support for historical privileged ISA versions in one of the simulators, as
a runtime flag, not just in its commit history.

With respect to the other issues. I'm going to be seeking Signed-off-by
from the various contributors for the next patch series. v8

BTW somewhat coincidentally, the binary translator I wrote; RV8, which is
practicaly twice as fast as QEMU only supports privileged ISA v1.9.1 and I
personally want to keep binary compatiblity with it. This is as an aside to
the desire of foundation members that wish to preserve privileged ISA
v1.9.1 support. In RV8, we yet don't have binary translation on the
privileged ISA _yet_, but when we do, we will implement shadow paging, so
out privileged ISA support will be Hard MMU. RISC-V page tables are close
enough to x86_64 pages tables such that we could emulate them using shadow
paging vs softmmu, and with the addition of a register allocator (rv8 uses
a static register allocation from the 31 RISC-V registers to the 16 x86_64
registers) it's likely we'll get simulation performance up around 10
Billion Instructions per second (currently we're peaking at approximately 6
Billion RISC-V instructions per second on a Broadwell Core i7 5557U).
Unfortunaly I haven't had much time to spend on rv8 as QEMU is what SiFive
want me to support. One day we'll add Hard MMU for the translated target...
in fact we could consider doing this in QEMU?... The core rv8 engine is
much faster but it has terrible device support. It's possibly easier to
implement Hard MMU emulation support in an alternate translator? maybe we
could use KVM and do Hard MMU for RISC-V in QEMU?

- https://rv8.io/
- https://rv8.io/bench
- https://anarch128.org/~mclark/rv8-carrv.pdf
- https://anarch128.org/~mclark/rv8-slides.pdf
