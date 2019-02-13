Received: from eggs.gnu.org ([209.51.188.92]:34941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gu39F-0002fM-O4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:36:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gu39E-0007aS-Td
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:36:57 -0500
MIME-Version: 1.0
References: <20190212173839.31587-1-chouteau@adacore.com>
	<CAKmqyKOAVDbJQ6avwWgDHP1fHD_EXdZmi+Sjucm05ZqNkQoUog@mail.gmail.com>
	<CAFEAcA_5jYqTWVBiTFjumkAHEEwvDkt_f_LHAo=00gkEfoY9sA@mail.gmail.com>
	<49bd9805-2f40-7d5d-8814-e0a59a9c5be1@redhat.com>
	<CAFEAcA9GD+Cr_nAgz1CxfrWi7OuEZHrz=Gnh1PLrFJo6-BkOtw@mail.gmail.com>
In-Reply-To: <CAFEAcA9GD+Cr_nAgz1CxfrWi7OuEZHrz=Gnh1PLrFJo6-BkOtw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 Feb 2019 14:35:58 -0800
Message-ID: <CAKmqyKNBVusma92pD-Ad5k=2LNqpm7M=Euvih-MhRuDzW4EymA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] SiFive RISC-V GPIO Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>, Alistair Francis <Alistair.Francis@wdc.com>

On Wed, Feb 13, 2019 at 1:36 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 13 Feb 2019 at 18:54, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 2019-02-13 18:14, Peter Maydell wrote:
> > > On Wed, 13 Feb 2019 at 00:13, Alistair Francis <alistair23@gmail.com>=
 wrote:
> > >> I know the other RISC-V files don't do it, but this should go in the
> > >> hw/gpio directory instead of hw/riscv.
> > >
> > > It might be nice to move those existing riscv devices into
> > > their proper places at some point: should be a fairly easy
> > > cleanup patch if somebody wants to take it on. (Advice
> > > on what should live where available on request.)
> >
> > If devices only work on riscv, they should IMHO stay in hw/riscv/. I
> > think hw/gpio/ and friends should primarily be used if a device is
> > shared between architectures. If they stay in hw/riscv/ it is way easie=
r
> > to match the devices with wildcards in the MAINTAINERS file. Just my
> > 0.02 =E2=82=AC only, of course.
>
> This is not the way we generally arrange the source tree,
> at least not the parts I'm familiar with. The rule of
> thumb I use is that devices of type X go in hw/X, and
> hw/$ARCH is only for board models and SoC container objects.
> I think the model for this is the Linux kernel, which
> splits drivers for devices into directories by device
> family, rather than putting them all in arch/whatever.
> A split that puts all the architecture-specific device
> models in hw/$ARCH has the significant disadvantage that
> it would put a huge number of files in hw/arm ...

That is how I understood it as well.

I think some of the current files in hw/riscv/ could be moved, but
they are somewhat border line and we don't have many files yet so I
wasn't bothering yet.

This GPIO device doesn't have to be RISC-V specific so it makes sense
to put it under hw/gpio. The maintainers file will need to be updated
though.

Alistair

>
> (More generally, I don't think the exact way we split
> the source files between directories matters much, but
> I do think it helps if we try to be consistent about it.)
>
> thanks
> -- PMM
