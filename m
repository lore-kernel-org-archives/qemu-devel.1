Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHBIK-0003Q2-Di
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHBIH-0001pQ-2J
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:25:39 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gHBID-0001gu-Ti
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:25:34 -0400
Received: by mail-lj1-x244.google.com with SMTP id t22-v6so8612390lji.7
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 10:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKPXFOw3hv+wYbVPn2c4xPCiUXVyzDPJ3XpOuBx0zp9xGw@mail.gmail.com>
	<mhng-81205b33-ccd0-4600-9fbd-0a025c55dcfa@palmer-si-x1c4>
In-Reply-To: <mhng-81205b33-ccd0-4600-9fbd-0a025c55dcfa@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Oct 2018 10:24:56 -0700
Message-ID: <CAKmqyKN0krmpALnU=zKMkMZDG53v53w67A2fxncK+Fj7xGZ-fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: philmd@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Mon, Oct 29, 2018 at 10:14 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 29 Oct 2018 09:48:30 PDT (-0700), alistair23@gmail.com wrote:
> > On Mon, Oct 29, 2018 at 9:44 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> On 29/10/18 17:16, Palmer Dabbelt wrote:
> >> > Alistair has been contributing to the RISC-V QEMU port for a while n=
ow
> >> > so I'd like him to be officially listed as a maintainer.  I've check=
ed
> >> > with the other RISC-V mainatiners and there are no objectics, and I'=
ve
> >>
> >> "maintainers" "objections"
> >>
> >> > also checked with Alistair so he knows I'm volunteering him.
> >> >
> >> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> >>
> >> FWIW:
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > I can send a pull request with this patch (and the other RISC-V
> > patch). I'll fix the typos in the PR.
>
> I don't think we have anything ready to go right now: your PCIe patches s=
till
> have some outstanding feedback (on interrupt stuff), and Bastian's decode=
tree
> stuff has some patches from Richard Henderson that should be merged in.  =
I was
> hoping to get through reviewing Michael's patches to fix the FS dirty bit=
, but
> haven't had time yet -- they're tested, but I haven't actually read throu=
gh
> them.

Dayeol Lee's patch "target/riscv/pmp.c: pmpcfg_csr_read returns bogus
value on RV64" is ready to be applied.

It's probably too close to soft freeze for anything else to make it in for =
3.1.

>
> Maybe we should get a RISC-V QEMU mailing list so we can keep everyone in=
 sync
> without spamming the whole world?

We can, but I don't think we have that much traffic at the moment.

Alistair

>
> >
> > Alistair
> >
> >>
> >> > ---
> >> >   MAINTAINERS | 1 +
> >> >   1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > index d794bd7a66fe..d550fd8b809c 100644
> >> > --- a/MAINTAINERS
> >> > +++ b/MAINTAINERS
> >> > @@ -241,6 +241,7 @@ F: disas/ppc.c
> >> >   RISC-V
> >> >   M: Michael Clark <mjc@sifive.com>
> >> >   M: Palmer Dabbelt <palmer@sifive.com>
> >> > +M: Alistair Francis <Alistair.Francis@wdc.com>
> >> >   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> >> >   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> >> >   S: Maintained
> >> >
> >>
