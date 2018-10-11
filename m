Received: from eggs.gnu.org ([2001:4830:134:3::10]:45226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1gAhwr-0006t5-20
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1gAhwm-00063A-K5
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:44 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:45470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1gAhwl-0003ld-Px
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:40 -0400
Received: by mail-ot1-x332.google.com with SMTP id u22so10287364ota.12
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_fmoBRTk0VKEjuu82eb7piCkq588+v7RT7r6f=_4=OVw@mail.gmail.com>
	<mhng-e2fff6d4-8420-48c5-92d9-cc03e16dfa48@palmer-si-x1c4>
In-Reply-To: <mhng-e2fff6d4-8420-48c5-92d9-cc03e16dfa48@palmer-si-x1c4>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 12 Oct 2018 09:52:07 +1300
Message-ID: <CAHNT7NvSYFtnKyFjPZqbHL=QM82zgRq5oU+mJW9vm7=QO9yTEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair23@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Richard Henderson <richard.henderson@linaro.org>, Karsten Merker <merker@debian.org>, Stefan O'Rear <sorear2@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>

Hi All,

On Thu, Oct 11, 2018 at 7:22 AM Palmer Dabbelt <palmer@sifive.com> wrote:

> On Wed, 10 Oct 2018 11:10:07 PDT (-0700), peter.maydell@linaro.org wrote:
> > On 10 October 2018 at 18:49, Palmer Dabbelt <palmer@sifive.com> wrote:
> >> we should really
> >> get the ball rolling on our big patch backlog.
> >
> > Yes, please do. Softfreeze is not all that far away and I
> > would strongly prefer not to get an enormous sized pull
> > request at the last minute. The ideal pattern is that
> > code changes come in at a steady rate across the whole
> > of the 'open' part of the development cycle.
>
> Ya, sorry, we've been a bit out of it.  If I understand correctly, the
> soft
> freeze is the 30th?  If so it's really time to get started, and it looks
> like
> Michael is busy so I'll have to go figure this out.
>

Yes. I should think twice about the Signed-off-by: on my commits. I need to
run a regression on this out-of-order subset. I currently only run tests on
the top of the riscv-qemu tree in-order, and when I rebase against master.
If the commits need any significant effort to rebase because they are taken
in some random order then the testing will be invalidated. i.e. I haven't
checked the dependencies for these commits.

I am happy to review whoever posts the contents of the tree. I can test
apply the PRs against the riscv-qemu tree and if they give us lumps, we'll
reject, including my own changes (if rebased).

Alastair, I suggest you confer with Debian and Fedora folk. Don't break the
Linux distros... I'm petrified that we might break Debian.

Palmer, I disagree with idea, I would like to maintain the soft-fork until
we have the CI running our regression test suite (currently manual)

Peter, I have to pull in your remote wholesale. I don't cherry-pick from
your tree. I think this is truly dumb. This might serve the needs of some
folk running Linux but we have emulation fidelity fixes for the RISC-V
community as a whole. Alastair is the only person not submitting his
patches via the (sub)maintainer tree. BTW Who is the RISC-V port
maintainer? Puzzled.

Here is the pull queue. But I'm not ready to make a PR until we have the CI
running the regression. I certainly don't want rebases of random commits to
the riscv-qemu tree coming in when we pull.

- https://github.com/riscv/riscv-qemu/tree/qemu-for-upstream

That said, they have sign-off. There are plenty of other "RISC-V"
maintainers. Do what you think is wise.

Most important thing here is the Debian builders and other RISC-V virtual
machines in production. Having the Debian folk or some other helpful tester
running the entire tree. Pulling it in one go means we don't have a
bisection problem interspersed with a whole lot of other random patches.
You may not have all of the interrupt related changes that require
extensive parallel burn-in tests (GCC bootstrap). i.e. we do significantly
more than "make check" when we pull changes into our tree.

Thanks and Regards,
Michael.
