Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF9C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1510248D0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjgrwtUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1510248D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLsS-00010P-Fr
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kSLrK-0000De-6L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:05:02 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b]:44785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kSLrH-0006nb-KO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:05:01 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id h6so16398984ybi.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=erxsS5E9E7NdHi74fe5oUYMeKvsy8ucI2E8/UYNOQck=;
 b=qjgrwtUd4KZsOqoT3WKvrtCyLU+AN82Efpf0FTet0+ZtvZZbczfyu4HSxOpLwL7aS9
 GQmQhbkSm/liS5/OK8U+xXNC+mLmhK3drH2ES7U8i5tr4IocmAwIOiBb78X1EpQmFovV
 HGZcSyyN16CNmRAYTrFl7/u4AJ7e5pl0Iqlv6qh3ZTm1HyD/97wE4n6utacyyXptaATH
 vPxDBESK/n8p3XKaNYyDWvQ76Rw+Z2/BTxjr80iJV3eIFZh4o+QRvQD7i84lntjRLRlv
 YUOBYKzvLxvSqC7sQvJ2929EThJs7ERpFRfvR30G3mVooVTWzjMsbcjG5R7RR3+OOzEH
 FR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=erxsS5E9E7NdHi74fe5oUYMeKvsy8ucI2E8/UYNOQck=;
 b=eGzsV2SG7IkRyLptedut5FlfByHdgyYfOQ0ay+3553idbDe40GGN24XBuG8yI0+IGZ
 ynJF2i6ysos5JJbPAU1aJX1yHrkz54HIegh3BlaK9eqBaTeYqmRTyhLUE/EbpbQJisqp
 yGY9lStgeplhw1R2jrxfCOVV92kXb6/touVwh8BM2LKFGi8RIIMgFnJx7IRspSVzQGiX
 4vBFnyiNjqRcUW6tkXgtBy4ZvxPwuRS1bonNjWLHkw7VE8CBNjHLYta0G7YJbnGToF4G
 lcKgBhyJ26KnjyX2H+bUTOWp/qwjQ+Ae+e9gPRwrdCQJJ+i7ghPJadhLZpdSun/zzIw9
 6O2A==
X-Gm-Message-State: AOAM531DNpu30/gawrPvbgP964e0Rp5LdhPc4jRSPHZulqnj5Cx3ix9w
 IaJMDYCNIxSPDBAetlAUUB35191VubzCoJtbHs4UVFrWvUA=
X-Google-Smtp-Source: ABdhPJzeCG7rjfJ9b30iRoCnqI0IFEHxb+Kzy3NnzuoEPYY++/WOecOxPOHgeMMeNfu08eoleVtIH7L2SClvJrhcli0=
X-Received: by 2002:a25:380c:: with SMTP id f12mr498305yba.32.1602601497991;
 Tue, 13 Oct 2020 08:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
 <20200930204604.20663-13-cupertinomiranda@gmail.com>
 <5c3b582c-f596-4866-3bca-da4235ec95fc@amsat.org>
In-Reply-To: <5c3b582c-f596-4866-3bca-da4235ec95fc@amsat.org>
From: Cupertino Miranda <cupertinomiranda@gmail.com>
Date: Tue, 13 Oct 2020 16:04:46 +0100
Message-ID: <CAHW_Pj+LMOB+XQByMxJYdbhk9kyZts8LFf45YEez+0BkuJR42w@mail.gmail.com>
Subject: Re: [PATCH 12/14] arc: Add Synopsys ARC emulation boards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-yb1-xb2b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Claudiu Zissulescu <claziss@gmail.com>, qemu-devel@nongnu.org,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Wed, Oct 7, 2020 at 5:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Cupertino, Claudiu,
>
> On 9/30/20 10:46 PM, cupertinomiranda@gmail.com wrote:
> > From: Claudiu Zissulescu <claziss@synopsys.com>
> >
> > Add the Synopsys ARC boards, arc_sim for testing, sim-hs main emulation
> > board using standard UART and nsim which includes a Synopsys ARC specif=
ic
> > UART implementation.
> >
> > Signed-off-by: Claudiu Zissulescu <claziss@synopsys.com>
> > ---
> >  hw/arc/Makefile.objs      |  21 +++
> >  hw/arc/arc_sim.c          | 143 ++++++++++++++++++++
> >  hw/arc/arc_uart.c         | 267 ++++++++++++++++++++++++++++++++++++++
> >  hw/arc/board-hsdk.c       | 107 +++++++++++++++
> >  hw/arc/boot.c             |  95 ++++++++++++++
> >  hw/arc/boot.h             |  21 +++
> >  hw/arc/meson.build        |  13 ++
> >  hw/arc/nsim.c             |  86 ++++++++++++
> >  hw/arc/pic_cpu.c          | 111 ++++++++++++++++
> >  hw/arc/sample.c           |  77 +++++++++++
> >  hw/arc/sim-hs.c           | 107 +++++++++++++++
> >  include/hw/arc/arc_uart.h |  43 ++++++
> >  include/hw/arc/cpudevs.h  |  10 ++
> >  13 files changed, 1101 insertions(+)
> >  create mode 100644 hw/arc/Makefile.objs
> >  create mode 100644 hw/arc/arc_sim.c
> >  create mode 100644 hw/arc/arc_uart.c
> >  create mode 100644 hw/arc/board-hsdk.c
> >  create mode 100644 hw/arc/boot.c
> >  create mode 100644 hw/arc/boot.h
> >  create mode 100644 hw/arc/meson.build
> >  create mode 100644 hw/arc/nsim.c
> >  create mode 100644 hw/arc/pic_cpu.c
> >  create mode 100644 hw/arc/sample.c
> >  create mode 100644 hw/arc/sim-hs.c
> >  create mode 100644 include/hw/arc/arc_uart.h
> >  create mode 100644 include/hw/arc/cpudevs.h
>
> Please split in various commits:
>
> - hw/char/arc_uart
> - hw/intc/synopsys_pic or something
> - hw/arc/boot
> - hw/arc/*sim*
> - hw/arc/*hsdk*
>
> (Also it would simplify differentiating the architectural
> part of your patches from the hardware ones if you use the
> target/arc/ prefix in your previous patches).

Got it, will make it happen in the next submission.

>
> >
> > diff --git a/hw/arc/Makefile.objs b/hw/arc/Makefile.objs
> > new file mode 100644
> > index 0000000000..28d7766cd9
> > --- /dev/null
> > +++ b/hw/arc/Makefile.objs
> > @@ -0,0 +1,21 @@
> > +#
> > +#  QEMU ARC CPU
> > +#
> > +#  Copyright (c) 2019
> > +#
> > +#  This library is free software; you can redistribute it and/or
> > +#  modify it under the terms of the GNU Lesser General Public
> > +#  License as published by the Free Software Foundation; either
> > +#  version 2.1 of the License, or (at your option) any later version.
> > +#
> > +#  This library is distributed in the hope that it will be useful,
> > +#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > +#  Lesser General Public License for more details.
> > +#
> > +#  You should have received a copy of the GNU Lesser General Public
> > +#  License along with this library; if not, see
> > +#  http://www.gnu.org/licenses/lgpl-2.1.html
> > +#
> > +
> > +obj-y   =3D arc_sim.o arc_uart.o sample.o pic_cpu.o boot.o board-hsdk.=
o sim-hs.o nsim.o
>
> We don't use Makefile anymore.
Oups, sorry for that, we had just rebased older code ... need to remove tho=
se.

>
> > diff --git a/hw/arc/arc_sim.c b/hw/arc/arc_sim.c
> > new file mode 100644
> > index 0000000000..8020a03d85
> > --- /dev/null
> > +++ b/hw/arc/arc_sim.c
> > @@ -0,0 +1,143 @@
> > +/*
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "cpu.h"
> > +#include "hw/hw.h"
> > +#include "hw/boards.h"
> > +#include "elf.h"
> > +#include "hw/char/serial.h"
> > +#include "net/net.h"
> > +#include "hw/loader.h"
> > +#include "exec/memory.h"
> > +#include "exec/address-spaces.h"
> > +#include "sysemu/reset.h"
> > +#include "sysemu/runstate.h"
> > +#include "sysemu/sysemu.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/arc/cpudevs.h"
> > +#include "boot.h"
> > +
> > +static void arc_sim_net_init(MemoryRegion *address_space,
> > +                             hwaddr base,
> > +                             hwaddr descriptors,
> > +                             qemu_irq irq, NICInfo *nd)
> > +{
> > +    DeviceState *dev;
> > +    SysBusDevice *s;
> > +
> > +    dev =3D qdev_new("open_eth");
> > +    qdev_set_nic_properties(dev, nd);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +
> > +    s =3D SYS_BUS_DEVICE(dev);
> > +    sysbus_connect_irq(s, 0, irq);
> > +    memory_region_add_subregion(address_space, base,
> > +                                sysbus_mmio_get_region(s, 0));
> > +    memory_region_add_subregion(address_space, descriptors,
> > +                                sysbus_mmio_get_region(s, 1));
> > +}
> > +
> > +static uint64_t arc_io_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    return 0;
> > +}
> > +
> > +static void arc_io_write(void *opaque, hwaddr addr,
> > +                         uint64_t val, unsigned size)
> > +{
> > +    switch (addr) {
> > +    case 0x08: /* board reset. */
> > +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps arc_io_ops =3D {
> > +    .read =3D arc_io_read,
> > +    .write =3D arc_io_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +static void arc_sim_init(MachineState *machine)
> > +{
> > +    static struct arc_boot_info boot_info;
> > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > +    ram_addr_t ram_base =3D 0;
> > +    ram_addr_t ram_size =3D machine->ram_size;
> > +    ARCCPU *cpu =3D NULL;
> > +    MemoryRegion *ram, *system_io;
> > +    int n;
> > +
> > +    boot_info.ram_start =3D ram_base;
> > +    boot_info.ram_size =3D ram_size;
> > +    boot_info.kernel_filename =3D machine->kernel_filename;
> > +
> > +    for (n =3D 0; n < smp_cpus; n++) {
> > +        cpu =3D ARC_CPU(object_new(machine->cpu_type));
> > +        if (cpu =3D=3D NULL) {
> > +            fprintf(stderr, "Unable to find CPU definition!\n");
> > +            exit(1);
> > +        }
> > +
> > +        /* Set the initial CPU properties. */
> > +        object_property_set_uint(OBJECT(cpu), "freq_hz", 1000000, &err=
or_fatal);
> > +        object_property_set_bool(OBJECT(cpu), "rtc-opt", true, &error_=
fatal);
> > +        object_property_set_bool(OBJECT(cpu), "realized", true, &error=
_fatal);
> > +
> > +        /* Initialize internal devices. */
> > +        cpu_arc_pic_init(cpu);
> > +        cpu_arc_clock_init(cpu);
> > +
> > +        qemu_register_reset(arc_cpu_reset, cpu);
> > +    }
> > +
> > +    ram =3D g_new(MemoryRegion, 1);
> > +    memory_region_init_ram(ram, NULL, "arc.ram", ram_size, &error_fata=
l);
> > +    memory_region_add_subregion(get_system_memory(), ram_base, ram);
> > +
> > +    system_io =3D g_new(MemoryRegion, 1);
> > +    memory_region_init_io(system_io, NULL, &arc_io_ops, NULL, "arc.io"=
,
> > +                           1024);
> > +    memory_region_add_subregion(get_system_memory(), 0xf0000000, syste=
m_io);
> > +
> > +    serial_mm_init(get_system_memory(), 0x90000000, 2, cpu->env.irq[20=
],
> > +                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
> > +
> > +    if (nd_table[0].used) {
> > +        arc_sim_net_init(get_system_memory(), 0x92000000,
> > +                         0x92000400, cpu->env.irq[4], nd_table);
> > +    }
> > +
> > +    arc_load_kernel(cpu, &boot_info);
> > +}
> > +
> > +static void arc_sim_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc =3D "ARCxx simulation";
> > +    mc->init =3D arc_sim_init;
> > +    mc->max_cpus =3D 1;
> > +    mc->is_default =3D false;
> > +    mc->default_cpu_type =3D ARC_CPU_TYPE_NAME("archs");
> > +}
> > +
> > +DEFINE_MACHINE("arc-sim", arc_sim_machine_init)
>
> Can you share the link to the documentation of this simulator please?
> I couldn't find it on the link you provided in the cover
> (https://www.synopsys.com/designware-ip/processor-solutions.html)
> and https://www.synopsys.com/dw/ipdir.php?ds=3Dsim_nSIM doesn't
> seem relevant.
The free version of this simulator is in:
https://www.synopsys.com/cgi-bin/dwarcnsim/req1.cgi

Documentation is packed in that download. I am not aware of any
location that would contain documentation for this.

In any case, we believe that we will not need any nSIM board, and we
would like to remove both the nsim board and the ARC UART
implementation.
There is no real benefit, as the support for ARC UART is being phased
out even on nSIM simulator and it does not make sense to include it
now in QEMU.

We only implemented ARC UART since initially nSIM did not support
generic UART, and we wanted to execute the same binaries on both nSIM
and QEMU.
At this point sim-hs board is doing precisely that. In any case we
want to rename it to something more meaningful.

>
> > diff --git a/hw/arc/sample.c b/hw/arc/sample.c
> > new file mode 100644
> > index 0000000000..0ecc11cf15
> > --- /dev/null
> > +++ b/hw/arc/sample.c
> > @@ -0,0 +1,77 @@
> > +/*
> > + * QEMU ARC CPU
> > + *
> > + * Copyright (c) 2016 Michael Rolnik
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > + * http://www.gnu.org/licenses/lgpl-2.1.html
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "cpu.h"
> > +#include "hw/hw.h"
> > +#include "sysemu/sysemu.h"
> > +#include "sysemu/qtest.h"
> > +#include "ui/console.h"
> > +#include "hw/boards.h"
> > +#include "hw/loader.h"
> > +#include "qemu/error-report.h"
> > +#include "exec/address-spaces.h"
> > +#include "include/hw/sysbus.h"
> > +
> > +#define SIZE_RAM 0x00020000
> > +
> > +static void sample_init(MachineState *machine)
> > +{
> > +    MemoryRegion *ram;
> > +
> > +    ARCCPU *cpu_arc ATTRIBUTE_UNUSED;
> > +
> > +    ram =3D g_new(MemoryRegion, 1);
> > +
> > +    cpu_arc =3D ARC_CPU(cpu_create("archs-" TYPE_ARC_CPU));
> > +
> > +    memory_region_init_ram(ram, NULL, "ram", SIZE_RAM, &error_fatal);
> > +    memory_region_add_subregion(get_system_memory(), PHYS_BASE_RAM, ra=
m);
> > +
> > +    char const *firmware =3D NULL;
> > +    char const *filename;
> > +
> > +    if (machine->firmware) {
> > +        firmware =3D machine->firmware;
> > +    }
> > +
> > +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> > +    if (!filename) {
> > +        error_report("Could not find flash image file '%s'", firmware)=
;
> > +        exit(1);
> > +    }
> > +
> > +    load_image_targphys(filename, PHYS_BASE_RAM + 0x100, SIZE_RAM);
> > +}
> > +
> > +static void sample_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc =3D "ARC sample/example board";
> > +    mc->init =3D sample_init;
> > +    mc->is_default =3D false;
> > +}
> > +
> > +DEFINE_MACHINE("sample", sample_machine_init)
>
> You don't need a "sample" board, you can use the "none" machine instead.
Ok, will remove.

>
> Regards,
>
> Phil.

Regards,
Cupertino

