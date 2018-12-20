Received: from eggs.gnu.org ([2001:4830:134:3::10]:41330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ga3dP-0001gL-JL
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ga3dN-0003MN-Ia
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 14:05:26 -0500
MIME-Version: 1.0
References: <CAKmqyKNY4FCzXcpBMWawVA9RWGBZ7vctRLaQGhsODH6HCXkK9A@mail.gmail.com>
	<mhng-9f966fb7-686c-4427-a39c-850368f88f0e@palmer-si-x1c4>
In-Reply-To: <mhng-9f966fb7-686c-4427-a39c-850368f88f0e@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 20 Dec 2018 11:04:41 -0800
Message-ID: <CAKmqyKPXri6faCRjXnp7WCyRYcuBhiEU=W_VrW4LYUe1O_c4Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/23] Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Dec 20, 2018 at 10:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 20 Dec 2018 09:20:05 PST (-0800), alistair23@gmail.com wrote:
> > On Wed, Dec 19, 2018 at 10:07 PM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 12/19/18 11:16 AM, Alistair Francis wrote:
> >> > This patch set adds RISC-V backend support to QEMU. This is based on
> >> > Michael Clark's original work with extra work on top.
> >> >
> >> > This has been somewhat tested and can run other architecture softmmu
> >> > code. It seems that any complex OS will eventually hang, but we can
> >> > run the BIOS and OS startup code for a number of different operating
> >> > systems.
> >> >
> >> > I haven't tested linux user support at all yet. I think Michael had that
> >> > working reliably though and hopefully my changes haven't broken it.
> >> >
> >> > There are still some todos in the code (there are missing instructions
> >> > and byte swapping) but these should assert instead of generating invalid
> >> > code.
> >>
> >> Queued to tcg-next, with the extrh fix.
> >
> > Thanks Richard!
>
> Sounds good to me.  I'm still attempting to collect the RISC-V patches to get a
> PR out, a few things came up but I should have time now.  This was the biggest
> patch set, so it should be a lot easier now.
>
> Thanks for picking this up!
>
> >> Some of those todos are no longer todos, since e.g. bswap is now optional.
> >> Those asserts should never fire (as a good assert should do, I suppose).
> >>
> >> The missing instructions are only for riscv32, which afaik is just now making
> >> its way to glibc.  So a chroot complete enough to build qemu is a ways away.
> >> I'm ok with leaving that incomplete for now.
>
> We've decided to delay the rv32i glibc port until after the next glibc release,
> which is targeted for the beginning of February.  glibc should freeze at the
> end of the year, at which point we're going to do a rv32i glibc prerelease and
> try to build a proper userspace with the theory being that we'll shake out ABI
> bugs that way.

Yocto/OE has full support for building 32-bit userspaces with the
latest 32-bit glibc patchset so that is probably a good place to start
testing. It even runs QEMU!

Alistair
