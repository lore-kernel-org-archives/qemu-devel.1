Received: from eggs.gnu.org ([209.51.188.92]:56427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEYfJ-0006Ni-Ko
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEYfH-0001q7-Me
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEYfE-0001mU-2k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:45 -0400
Received: by mail-oi1-x241.google.com with SMTP id l203so4698659oia.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 05:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
	<20190411140629.3a672b39@redhat.com>
In-Reply-To: <20190411140629.3a672b39@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 13:18:30 +0100
Message-ID: <CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 6/6] riscv: Add a generic spike
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ijc@hellion.org.uk" <ijc@hellion.org.uk>

On Thu, 11 Apr 2019 at 13:07, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 10 Apr 2019 23:11:00 +0000
> Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > +    /* register system main memory (actual RAM) */
> > +    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> > +                           machine->ram_size, &error_fatal);
> do you really care about migration? if not then _nomigrate flavor would
> be more suitable.

Every machine model should care about migration, at least to
the extent of making savevm/loadvm snapshots work. Using
memory_region_init_ram_nomigrate() is a bad idea in new
code: it exists only for the benefit of older code which
is handling the migration of the backing RAM by hand for
migration-compatibility reasons.

> >      /* Initialize SOC */
> >      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> >                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> > @@ -254,6 +343,12 @@ static void spike_v1_09_1_board_init(MachineState *machine)
> >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> >      int i;
> >
> > +    if (!qtest_enabled()) {
> > +        info_report("The Spike v1.09.1 machine has been depreceated. "
> > +                    "Please use the deneric spike machine and specify the ISA "

"generic"

> > +                    "versions using -cpu.");
> > +    }
> > +

thanks
-- PMM
