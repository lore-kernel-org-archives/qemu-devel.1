Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24045C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DA921850
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="VOz646PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DA921850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOkt-0000fk-SR
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@posteo.de>) id 1hiMpE-0000Yq-03
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@posteo.de>) id 1hiMp4-0007AM-DQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:44:15 -0400
Received: from mout02.posteo.de ([185.67.36.66]:55177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1hiMp0-00074f-0X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:44:04 -0400
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 66F1B2400FB
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 19:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1562089434; bh=BvZdj8H4iuVyuBB8YmX4ziuTBQ1L4q7LJ52DqEILq5I=;
 h=Subject:To:Cc:From:Date:From;
 b=VOz646PJNzXyDQyKE+C1N3YlyPT1OvoFhpm/K097GE76r3tqYpdU+ZSeigyE9EDKx
 4osX2ndQMzrUOBSHJVjfpWxjm3OVtaJ9i69l5FvpHeB+niT9iNoRER3L1+ZmG70Dos
 VLXE2JjfjaDNI9Dpdn52Xy8fmePN6iRpdKbAxQ1wUTHk2rn3joeUUJXJV3Crzp/6F/
 GGm4NGrS0DC6BOW62kffEw/j7UhoPfusg/fxVL1PK4zHU6uue30zAOnn1rAW8N2gJN
 b7503SHnSaSUZVY3gBgdmmunV8WHSA04/mcStZcgP/UxBvXEY70t2cdne4K9YqqEq7
 6cotuwEGDh3ew==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 45dWnJ4MKDz9rxN;
 Tue,  2 Jul 2019 19:43:48 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20190628181536.13729-1-huth@tuxfamily.org>
 <20190628181536.13729-4-huth@tuxfamily.org>
 <074eb5c6-8a7f-1018-47f9-9801e0aba704@redhat.com>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <9b4187dd-9079-b511-aea7-2b8c992a3067@posteo.de>
Date: Tue, 2 Jul 2019 19:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <074eb5c6-8a7f-1018-47f9-9801e0aba704@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.67.36.66
Subject: Re: [Qemu-devel] [PATCH v2 3/4] m68k: Add NeXTcube machine
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/2019 14.26, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/28/19 8:15 PM, Thomas Huth wrote:
>> It is still quite incomplete (no SCSI, no floppy emulation, no network=
,
>> etc.), but the firmware already shows up the debug monitor prompt in t=
he
>> framebuffer display, so at least the very basics are already working.
>>
>> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>>
>>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-cube.c
>>
>> and altered quite a bit to fit the latest interface and coding convent=
ions
>> of the current QEMU.
>>
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>> ---
>>  hw/m68k/Makefile.objs       |   2 +-
>>  hw/m68k/next-cube.c         | 988 +++++++++++++++++++++++++++++++++++=
+
>>  include/hw/m68k/next-cube.h |  38 ++
>>  3 files changed, 1027 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/m68k/next-cube.c
>>
>> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
>> index 688002cac1..f25854730d 100644
>> --- a/hw/m68k/Makefile.objs
>> +++ b/hw/m68k/Makefile.objs
>> @@ -1,3 +1,3 @@
>>  obj-$(CONFIG_AN5206) +=3D an5206.o mcf5206.o
>>  obj-$(CONFIG_MCF5208) +=3D mcf5208.o mcf_intc.o
>> -obj-$(CONFIG_NEXTCUBE) +=3D next-kbd.o
>> +obj-$(CONFIG_NEXTCUBE) +=3D next-kbd.o next-cube.o
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> new file mode 100644
>> index 0000000000..700d386fb9
>> --- /dev/null
>> +++ b/hw/m68k/next-cube.c
>> @@ -0,0 +1,988 @@
>> +/*
>> + * NeXT Cube System Driver
>> + *
>> + * Copyright (c) 2011 Bryce Lanham
>> + *
>> + * This code is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published
>> + * by the Free Software Foundation; either version 2 of the License,
>> + * or (at your option) any later version.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "exec/hwaddr.h"
>> +#include "exec/address-spaces.h"
>> +#include "sysemu/sysemu.h"
>> +#include "sysemu/qtest.h"
>> +#include "hw/hw.h"
>> +#include "hw/m68k/next-cube.h"
>> +#include "hw/boards.h"
>> +#include "hw/loader.h"
>> +#include "hw/scsi/esp.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
>> +#include "hw/block/fdc.h"
>> +#include "qapi/error.h"
>> +#include "ui/console.h"
>> +#include "target/m68k/cpu.h"
>> +
>> +/* #define DEBUG_NEXT */
>> +#ifdef DEBUG_NEXT
>> +#define DPRINTF(fmt, ...) \
>> +    do { printf("NeXT: " fmt , ## __VA_ARGS__); } while (0)
>> +#else
>> +#define DPRINTF(fmt, ...) do { } while (0)
>> +#endif
>> +
>> +#define TYPE_NEXT_MACHINE MACHINE_TYPE_NAME("next-cube")
>> +#define NEXT_MACHINE(obj) OBJECT_CHECK(NeXTState, (obj), TYPE_NEXT_MA=
CHINE)
>> +
>> +#define ENTRY       0x0100001e
>> +#define RAM_SIZE    0x4000000
>> +#define ROM_FILE    "rom66.bin"
>=20
> Where can we find this file to test your work?

Bryce added that file to his repository ... but the one from the
location that you've mentioned in your other mail seems to work fine, too=
.

[...]
>> +static uint32_t mmio_readb(NeXTState *s, hwaddr addr)
>> +{
>> +    switch (addr) {
>> +    case 0xc000:
>> +        return (s->scr1 >> 24) & 0xFF;
>> +    case 0xc001:
>> +        return (s->scr1 >> 16) & 0xFF;
>> +    case 0xc002:
>> +        return (s->scr1 >> 8)  & 0xFF;
>> +    case 0xc003:
>> +        return (s->scr1 >> 0)  & 0xFF;
>=20
> So you have a 32-bit implementation (DMA accessed device?).
>=20
> memory::access_with_adjusted_size() already does this work
> for you if you use:
>=20
>    .impl.min_access_size =3D 4,
>    .valid.min_access_size =3D 1,
>    .valid.max_access_size =3D 4,

Yeah, it's old code from 2011 ... I'll try to rework it as you suggested.

>> +
>> +    case 0xd000:
>> +        return (s->scr2 >> 24) & 0xFF;
>> +    case 0xd001:
>> +        return (s->scr2 >> 16) & 0xFF;
>> +    case 0xd002:
>> +        return (s->scr2 >> 8)  & 0xFF;
>> +    case 0xd003:
>> +        return (s->scr2 >> 0)  & 0xFF;
>> +    case 0x14020:
>> +        DPRINTF("MMIO Read 0x4020\n");
>> +        return 0x7f;
>> +
>> +    default:
>> +        DPRINTF("MMIO Read B @ %"HWADDR_PRIx"\n", addr);
>> +        return 0x0;
>> +    }
[...]
>> +static uint64_t dma_readfn(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    NeXTState *ns =3D NEXT_MACHINE(opaque);
>> +
>> +    switch (size) {
>> +    case 4:
>> +        return dma_readl(ns, addr);
>=20
> Well, maybe you can directly use dma_readfn prototype for dma_readl, an=
d
> remove this function and dma_writefn (you know we'll ever get 32-bit
> accesses here due to .valid.min/max_access_size =3D 4).

Funny, bit this function is still triggered with size =3D 1 when you use
the Rev_2.1_v59.bin firmware file... looks like I need an additional
.impl.min_access_size =3D 4 to get it right.

>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
[...]
>> +static void next_cube_init(MachineState *machine)
>> +{
>> +    M68kCPU *cpu;
>> +    CPUM68KState *env;
>> +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *rom =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *mmiomem =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *scrmem =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *dmamem =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *unknownmem =3D g_new(MemoryRegion, 1);
>> +    MemoryRegion *sysmem =3D get_system_memory();
>> +    NeXTState *ns =3D NEXT_MACHINE(machine);
>> +
>> +    /* Initialize the cpu core */
>> +    cpu =3D M68K_CPU(cpu_create(machine->cpu_type));
>> +    if (!cpu) {
>> +        error_report("Unable to find m68k CPU definition");
>> +        exit(1);
>> +    }
>> +    env =3D &cpu->env;
>> +
>> +    /* Initialize CPU registers.  */
>> +    env->vbr =3D 0;
>> +    env->pc  =3D 0x100001e; /* technically should read vector */
>> +    env->sr  =3D 0x2700;
>> +
>> +    /* Set internal registers to initial values */
>> +    /*     0x0000XX00 << vital bits */
>> +    ns->scr1 =3D 0x00011102;
>> +    ns->scr2 =3D 0x00ff0c80;
>> +
>> +    ns->int_mask =3D 0x0; /* 88027640; */
>> +    ns->int_status =3D 0x0; /* 200; */
>=20
> What mean those comments?

No clue, they were part of Bryce code. Maybe I should simply remove them.

>> +
>> +    /* Load RTC RAM - TODO: provide possibility to load contents from=
 file */
>> +    memcpy(ns->rtc_ram, rtc_ram2, 32);
>> +
>> +    /* 64MB RAM starting at 0x4000000  */
>> +    memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_s=
ize);
>> +    memory_region_add_subregion(sysmem, 0x4000000, ram);
>=20
> 0x04000000
>=20
>> +
>> +    /* Framebuffer */
>> +    nextfb_init();
>=20
> Todays QEMU style seems to create device in place (here).
>=20
>> +
>> +    /* MMIO */
>> +    memory_region_init_io(mmiomem, NULL, &mmio_ops, machine, "next.mm=
io",
>> +                          0xD0000);
>> +    memory_region_add_subregion(sysmem, 0x2000000, mmiomem);
>=20
> 0x02000000

Ok.

>> +
>> +    /* BMAP - acts as a catch-all for now */
>> +    memory_region_init_io(scrmem, NULL, &scr_ops, machine, "next.scr"=
,
>> +                          0x3A7FF);
>=20
> 0x3A7FF? 0x3a800 at least, but why not use a 256 * KiB full range?

Ok.

> Wait... Isn't this I/O range of 128KB?

Hmm, yes, according to the Previous sources, it's 128kB only... I'll
have a try with 0x20000, and if there are no regressions, I'll use that
value instead.

>> +    /* TODO: */
>> +    /* Serial */
>> +    /* Network */
>> +    /* SCSI */
>=20
> Can you use create_unimplemented_device() here?

There are already patches for these devices available (just not working
yet), so I don't think it's worth the effort to take the detour via the
unimplemented device here.

>> +    /* FIXME: Why does the bios access this memory area? */
>> +    memory_region_allocate_system_memory(unknownmem, NULL, "next.unkn=
own", 16);
>> +    memory_region_add_subregion(sysmem, 0x820c0020, unknownmem);
>=20
> Isn't this uncached access to 0x020c0000?

No clue, but looking at the Previous sources, this seems to be a mirror
of 0x020c0000 indeed. I'll change that accordingly.

[...]
>> diff --git a/include/hw/m68k/next-cube.h b/include/hw/m68k/next-cube.h
>> index 88e94f6595..d7df6a223b 100644
>> --- a/include/hw/m68k/next-cube.h
>> +++ b/include/hw/m68k/next-cube.h
>> @@ -2,6 +2,44 @@
>>  #ifndef NEXT_CUBE_H
>>  #define NEXT_CUBE_H
>> =20
>> +enum next_dma_chan {
>> +    NEXTDMA_FD,
>> +    NEXTDMA_ENRX,
>> +    NEXTDMA_ENTX,
>> +    NEXTDMA_SCSI,
>> +    NEXTDMA_SCC,
>> +    NEXTDMA_SND
>> +};
>> +
>> +#define DMA_ENABLE      0x01000000
>> +#define DMA_SUPDATE     0x02000000
>> +#define DMA_COMPLETE    0x08000000
>> +
>> +#define DMA_M2DEV       0x0
>> +#define DMA_SETENABLE   0x00010000
>> +#define DMA_SETSUPDATE  0x00020000
>> +#define DMA_DEV2M       0x00040000
>> +#define DMA_CLRCOMPLETE 0x00080000
>> +#define DMA_RESET       0x00100000
>=20
> The DMA code is consequent enough to deserve its own file IMO.

Maybe later ... I'd like to keep the initial patches close to the code
from Bryce if possible.

 Thanks for the review,
  Thomas

