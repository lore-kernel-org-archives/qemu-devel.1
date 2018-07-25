Received: from eggs.gnu.org ([2001:4830:134:3::10]:52430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fiSFz-0001oL-AB
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 18:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fiSFw-00010D-9i
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 18:27:43 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fiSFw-0000yT-1G
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 18:27:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so16789257oik.2
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 15:27:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518100214.5e14a753@redhat.com>
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
	<1526400000-66561-1-git-send-email-imammedo@redhat.com>
	<CAHNT7NtoqQDpQCMF9C92KHvn6jLAy0K1fOJaT6nTTAAJ0s+utQ@mail.gmail.com>
	<20180518100214.5e14a753@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Jul 2018 10:27:38 +1200
Message-ID: <CAHNT7NtYMYXYZW=zRVpHYsnvcUy6BnmM2gZ5oJyXnHuwOnb_Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, May 18, 2018 at 8:02 PM, Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 18 May 2018 14:10:24 +1200
> Michael Clark <mjc@sifive.com> wrote:
>
> > On Wed, May 16, 2018 at 4:00 AM, Igor Mammedov <imammedo@redhat.com>
> wrote:
> >
> > > cpu_init() was removed since 2.12, so drop the define that is now
> unused.
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >
> >
> > Reviewed-by: Michael Clark <mjc@sifive.com>
> Michael,
>
> could you merge it through RISCV queue?


Yes indeed. Sorry I missed this email.

I'm going to bring this into the riscv-qemu queue right away and move it to
the head of the queue, now we have Alastair's stuff in master. Although I
won't be making any PRs until after 3.0 is released.

I'm currently re-basing and testing the RISC-V tree against Alastair's
changes. There were quite a few conflicts so it is going to take a bit of
testing. I also need to spend some time re-testing master.

I've been AWOL for the last month and a half due to some work related to
SiFive's new E20 and E21 cores which were recently announced. In the QEMU
3.1 or 3.2 time-frame we should have the new CLIC interrupt controller
which supports multiple levels of interrupt pre-emption, interrupt tail
chaining and new vectored interrupt modes. In the proposed CLIC spec (Core
Level Interrupt Controller), pre-emption is mostly handled in software but
there is a tiny bit of hardware support. We don't have any magic hardware
state machines that save multiple registers at a time. The proposed CLIC
sticks pretty closely to a set of RISC-V ideals with respect to how much is
done in a micro-op in the ISA and avoidance of complex hardware state
machines (e.g. no wiring of the ABI caller save registers into hardware).
I'm currently working on test cases for the CLIC and hopefully SiFive will
have tests for other changes we have in the RISC-V tree, so we have
"proofs" accompanying each patch that makes any sufficiantly complex
change. It of course will take a bit of time for us to accompany each of
our changes with a test. SiFive do actually have resources devoted to
formal verification but I have not yet been able to convince them to devote
resources to formally verifying the RISC-V QEMU implementation. Anyway we
do at least hope to have some tests for the RISC-V QEMU target in the near
future...

Phillipe, I noticed the recent cross complier infrastructure support so we
could potentially bring in riscv-tests as a submodule in QEMU... this will
help...

Michael.


> > ---
> > > v2:
> > >   * refine commit message (Eric Blake <eblake@redhat.com>)
> > > ---
> > >  target/riscv/cpu.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index 34abc38..0562a02 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -251,7 +251,6 @@ int riscv_cpu_handle_mmu_fault(CPUState *cpu,
> vaddr
> > > address, int size,
> > >  char *riscv_isa_string(RISCVCPU *cpu);
> > >  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
> > >
> > > -#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU,
> cpu_model)
> > >  #define cpu_signal_handler cpu_riscv_signal_handler
> > >  #define cpu_list riscv_cpu_list
> > >  #define cpu_mmu_index riscv_cpu_mmu_index
> > > --
> > > 2.7.4
> > >
> > >
>
>
