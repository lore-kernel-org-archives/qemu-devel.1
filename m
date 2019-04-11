Received: from eggs.gnu.org ([209.51.188.92]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEgSk-0003sR-42
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hEgSh-0004Ty-By
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:38:20 -0400
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
	<20190411140629.3a672b39@redhat.com>
	<CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-oOfZD=tas4QP3SeSOJJ+eM_9o=v05U=scsc78Z4p3FQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 11 Apr 2019 13:35:49 -0700
Message-ID: <CAKmqyKO779w8sYXcwtnJyCZN0TuKOAjUjd_xca4k2wff4vfEHQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ijc@hellion.org.uk" <ijc@hellion.org.uk>

On Thu, Apr 11, 2019 at 5:18 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 11 Apr 2019 at 13:07, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed, 10 Apr 2019 23:11:00 +0000
> > Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > > +    /* register system main memory (actual RAM) */
> > > +    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
> > > +                           machine->ram_size, &error_fatal);
> > do you really care about migration? if not then _nomigrate flavor would
> > be more suitable.
>
> Every machine model should care about migration, at least to
> the extent of making savevm/loadvm snapshots work. Using
> memory_region_init_ram_nomigrate() is a bad idea in new
> code: it exists only for the benefit of older code which
> is handling the migration of the backing RAM by hand for
> migration-compatibility reasons.

Ok, I'll leave this as is then.

>
> > >      /* Initialize SOC */
> > >      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
> > >                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> > > @@ -254,6 +343,12 @@ static void spike_v1_09_1_board_init(MachineState *machine)
> > >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> > >      int i;
> > >
> > > +    if (!qtest_enabled()) {
> > > +        info_report("The Spike v1.09.1 machine has been depreceated. "
> > > +                    "Please use the deneric spike machine and specify the ISA "
>
> "generic"

Fixed in v4.

Alistair

>
> > > +                    "versions using -cpu.");
> > > +    }
> > > +
>
> thanks
> -- PMM
