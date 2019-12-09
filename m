Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E0C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E062054F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQuA+LHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E062054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO6U-0007xw-EM
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieNhZ-0000rQ-Qe
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieNhV-0003Su-Gm
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:24:09 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieNhV-0003Sl-6m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:24:05 -0500
Received: by mail-oi1-x242.google.com with SMTP id l136so7259937oig.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=vSE7fbcPyRIxeCO8DxQjaPm1pon01p8/ZMEA6g1kCwc=;
 b=BQuA+LHrBGJwd7kxEaH7kl/iR6ByMnQllrZWwUL/XqYAbd+OpqMvTyOJed7NEZWpk+
 xbIOWBBiqNIjYA8kI7FXK2Kvy/piZBOWcNmKkkfFhlJw/1iRxQWaync4gR8m2ESfeIek
 7mUcOMihwWkamVlKgUFVut/Ob9bWGpHDFM6RHDgnfa8Ebs/RgPsgTxtiCAfI1CFiOwym
 rThbAtbYWA2ekgSZNxyfabU98rm89HDrV3m6KeJX7LYPTJahDCpHmgvCB65WY9S16quA
 rzkhKJbaisfr04IJA39Mvpp3HpI7B6Jh3+be9+VpTQEIvc763mhxGK9uCNSzZvli1IKt
 IVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=vSE7fbcPyRIxeCO8DxQjaPm1pon01p8/ZMEA6g1kCwc=;
 b=NPGfbC6YcZLYabReRxao1jg9efFdwSCa66ITYMAA2kbaeAaflTGmQdRE0ser+asifd
 zryjQ0Z/jgiNN70vqnAD4E47vMuhha5vk4Ne84m6SJVmBIQFGXLBSNy1Rs6WCONYH5L7
 x5WDGrR8sfBAjeuJZilSqsP2nJCj43LLJ4fzOwptOMnn54ylACOltEFcoguIgI26/zee
 D2Gun5xc/vvdKukOfGhxusVZEqDO0L25mIbESSzaiVMMjaYPqmlR7+MWkf8agjcKb4zj
 qvH43qLAXWigXeWYRkGLpdgF1NomFWDNVJDj4xvUx1RkF++t7mc+K+T8oDcO/jTueLJL
 r34Q==
X-Gm-Message-State: APjAAAUL9WXS7oL4XTIMs8z6NMkXezAWErwGDq92g4aVNMbvuB4sQuN5
 fv4H+PEXNWwp3xISDI5s5waMdjjuB6xiBx8WuAA=
X-Google-Smtp-Source: APXvYqxmHZ150tA2CQKnM1kRTnvqDfrL29Z8vR2VlqxcioOzdWzLiAp84fsxhOXxz8f1QkNl9OSVw+6dcZ+trqUOthk=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr353506oib.106.1575915844240;
 Mon, 09 Dec 2019 10:24:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 10:24:03 -0800 (PST)
In-Reply-To: <20191208183922.13757-16-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-16-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 19:24:03 +0100
Message-ID: <CAL1e-=hOw0_bfejCqj-VHG9Ww3HK3_C_P1f8KWy2myQ2GbTrQA@mail.gmail.com>
Subject: Re: [PATCH v38 15/22] target/avr: Add example board configuration
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001789a605994980c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001789a605994980c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> A simple board setup that configures an AVR CPU to run a given firmware
> image.
> This is all that's useful to implement without peripheral emulation as AV=
R
> CPUs include a lot of on-board peripherals.
>
> NOTE: this is not a real board !!!!
> NOTE: it's used for CPU testing!!!!
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Nacked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/elf.h        |   2 +
>  include/hw/elf_ops.h |   6 +-
>  include/hw/loader.h  |   3 +-
>  hw/avr/sample.c      | 293 +++++++++++++++++++++++++++++++++++++++++++
>  hw/core/loader.c     |  13 +-
>  hw/Kconfig           |   1 +
>  hw/avr/Kconfig       |   6 +
>  hw/avr/Makefile.objs |   1 +
>  8 files changed, 317 insertions(+), 8 deletions(-)
>  create mode 100644 hw/avr/sample.c
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>
> diff --git a/include/elf.h b/include/elf.h
> index 3501e0c8d0..53cdfa23b7 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
>  #define EM_MOXIE           223     /* Moxie processor family */
>  #define EM_MOXIE_OLD       0xFEED
>
> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
> +
>  /* This is the info that is needed to parse the dynamic section of the
> file */
>  #define DT_NULL                0
>  #define DT_NEEDED      1
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e07d276df7..9f28c16490 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>                                void *translate_opaque,
>                                int must_swab, uint64_t *pentry,
>                                uint64_t *lowaddr, uint64_t *highaddr,
> -                              int elf_machine, int clear_lsb, int
> data_swab,
> +                              int elf_machine, uint32_t *pflags,
> +                              int clear_lsb, int data_swab,
>                                AddressSpace *as, bool load_rom,
>                                symbol_fn_t sym_cb)


>
 New parameter uint32_t *pflags should go before int elf_machine, so that
input and output parameters are grouped together. The mane should be more
precise, like pe_flags.

But, it looks to me that you are breaking all other platforms with this
change. Did you try full qemu build after your series is applied?


>

 {
> @@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>          }
>      }
>
> +    if (pflags) {
> +        *pflags =3D (uint32_t)(elf_sword)ehdr.e_flags;
> +    }
>      if (lowaddr)
>          *lowaddr =3D (uint64_t)(elf_sword)low;
>      if (highaddr)
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 48a96cd559..3dbdd1868d 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -132,7 +132,8 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
>                       uint64_t *lowaddr, uint64_t *highaddr, int
> big_endian,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     int elf_machine, uint32_t *pflags,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
);
>
>  /** load_elf_ram:
> diff --git a/hw/avr/sample.c b/hw/avr/sample.c
> new file mode 100644
> index 0000000000..6574733b57
> --- /dev/null
> +++ b/hw/avr/sample.c
> @@ -0,0 +1,293 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +/*
> + *  NOTE:
> + *      This is not a real AVR board, this is an example!
> + *      The CPU is an approximation of an ATmega2560, but is missing
> various
> + *      built-in peripherals.
> + *
> + *      This example board loads provided binary file into flash memory
> and
> + *      executes it from 0x00000000 address in the code memory space.
> + *
> + *      Currently used for AVR CPU validation
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
> +#include "ui/console.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "qemu/error-report.h"
> +#include "exec/address-spaces.h"
> +#include "include/hw/sysbus.h"
> +#include "include/hw/char/avr_usart.h"
> +#include "include/hw/timer/avr_timer16.h"
> +#include "include/hw/misc/avr_mask.h"
> +#include "elf.h"
> +#include "hw/misc/unimp.h"
> +
> +#define SIZE_FLASH 0x00040000
> +#define SIZE_SRAM 0x00002000
> +/*
> + * Size of additional "external" memory, as if the AVR were configured t=
o
> use
> + * an external RAM chip.
> + * Note that the configuration registers that normally enable this
> feature are
> + * unimplemented.
> + */
> +#define SIZE_EXMEM 0x00000000
> +
> +/* Offsets of peripherals in emulated memory space (i.e. not host
> addresses)  */
> +#define PRR0_BASE 0x64
> +#define PRR1_BASE 0x65
> +#define USART_BASE 0xc0
> +#define TIMER1_BASE 0x80
> +#define TIMER1_IMSK_BASE 0x6f
> +#define TIMER1_IFR_BASE 0x36
> +
> +/* Interrupt numbers used by peripherals */
> +#define USART_RXC_IRQ 24
> +#define USART_DRE_IRQ 25
> +#define USART_TXC_IRQ 26
> +
> +#define TIMER1_CAPT_IRQ 15
> +#define TIMER1_COMPA_IRQ 16
> +#define TIMER1_COMPB_IRQ 17
> +#define TIMER1_COMPC_IRQ 18
> +#define TIMER1_OVF_IRQ 19
> +
> +/*  Power reduction     */
> +#define PRR1_BIT_PRTIM5     0x05    /*  Timer/Counter5  */
> +#define PRR1_BIT_PRTIM4     0x04    /*  Timer/Counter4  */
> +#define PRR1_BIT_PRTIM3     0x03    /*  Timer/Counter3  */
> +#define PRR1_BIT_PRUSART3   0x02    /*  USART3  */
> +#define PRR1_BIT_PRUSART2   0x01    /*  USART2  */
> +#define PRR1_BIT_PRUSART1   0x00    /*  USART1  */
> +
> +#define PRR0_BIT_PRTWI      0x06    /*  TWI */
> +#define PRR0_BIT_PRTIM2     0x05    /*  Timer/Counter2  */
> +#define PRR0_BIT_PRTIM0     0x04    /*  Timer/Counter0  */
> +#define PRR0_BIT_PRTIM1     0x03    /*  Timer/Counter1  */
> +#define PRR0_BIT_PRSPI      0x02    /*  Serial Peripheral Interface */
> +#define PRR0_BIT_PRUSART0   0x01    /*  USART0  */
> +#define PRR0_BIT_PRADC      0x00    /*  ADC */
> +
> +typedef struct {
> +    MachineClass parent;
> +} SampleMachineClass;
> +
> +typedef struct {
> +    MachineState parent;
> +    MemoryRegion *ram;
> +    MemoryRegion *flash;
> +    AVRUsartState *usart0;
> +    AVRTimer16State *timer1;
> +    AVRMaskState *prr[2];
> +} SampleMachineState;
> +
> +#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
> +
> +#define SAMPLE_MACHINE(obj) \
> +    OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHINE)
> +#define SAMPLE_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_MACHINE)
> +#define SAMPLE_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMPLE_MACHINE)
> +
> +static void sample_init(MachineState *machine)
> +{
> +    SampleMachineState *sms =3D SAMPLE_MACHINE(machine);
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    AVRCPU *cpu;
> +    const char *firmware =3D NULL;
> +    const char *filename =3D NULL;
> +    const char *cpu_type =3D NULL;
> +    uint32_t flags;
> +    int bytes_loaded;
> +    SysBusDevice *busdev;
> +    DeviceState *cpudev;
> +
> +    system_memory =3D get_system_memory();
> +    sms->ram =3D g_new(MemoryRegion, 1);
> +    sms->flash =3D g_new(MemoryRegion, 1);
> +
> +    /* if ELF file is provided, determine CPU type reading ELF flags */
> +    cpu_type =3D machine->cpu_type;
> +    firmware =3D machine->firmware;
> +    if (firmware !=3D NULL) {
> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> +        if (filename =3D=3D NULL) {
> +            error_report("Unable to find %s", firmware);
> +            exit(1);
> +        }
> +
> +        bytes_loaded =3D load_elf_ram_sym(filename, NULL, NULL, NULL, NU=
LL,
> NULL,
> +                NULL, 0, EM_AVR, &flags, 0, 0, NULL, 0, 0);
> +        if (bytes_loaded > 0) {
> +            cpu_type =3D avr_flags_to_cpu_type(flags, cpu_type);
> +        }
> +    }
> +
> +    cpu =3D AVR_CPU(cpu_create(cpu_type));
> +    cpudev =3D DEVICE(cpu);
> +
> +    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
> +            &error_fatal);
> +    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flash);
> +
> +    /* following are atmel2560 device */
> +    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130, 0x0007)=
;
> +    create_unimplemented_device("timer-counter-16bit 5",
> +            OFFSET_DATA + 0x0120, 0x000e);
> +    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x0003);
> +    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x0003);
> +    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x0003);
> +    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x0003);
> +    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0, 0x0007)=
;
> +    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8, 0x0007)=
;
> +    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0, 0x0007)=
;
> +    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
> +    create_unimplemented_device("timer-counter-async-8bit 2",
> +            OFFSET_DATA + 0x00b0, 0x0007);
> +    create_unimplemented_device("timer-counter-16bit 4",
> +            OFFSET_DATA + 0x00a0, 0x000e);
> +    create_unimplemented_device("timer-counter-16bit 3",
> +            OFFSET_DATA + 0x0090, 0x000e);
> +    create_unimplemented_device("timer-counter-16bit 1",
> +            OFFSET_DATA + 0x0080, 0x000e);
> +    create_unimplemented_device("ac / adc",
> +            OFFSET_DATA + 0x0078, 0x0008);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x0074, 0x0002);
> +    create_unimplemented_device("int-controller",
> +            OFFSET_DATA + 0x0068, 0x000c);
> +    create_unimplemented_device("sys",
> +            OFFSET_DATA + 0x0060, 0x0007);
> +    create_unimplemented_device("spi",
> +            OFFSET_DATA + 0x004c, 0x0003);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x004a, 0x0002);
> +    create_unimplemented_device("timer-counter-pwm-8bit 0",
> +            OFFSET_DATA + 0x0043, 0x0006);
> +    create_unimplemented_device("ext-mem-iface",
> +            OFFSET_DATA + 0x003e, 0x0005);
> +    create_unimplemented_device("int-controller",
> +            OFFSET_DATA + 0x0035, 0x0009);
> +    create_unimplemented_device("gpio G", OFFSET_DATA + 0x0032, 0x0003);
> +    create_unimplemented_device("gpio F", OFFSET_DATA + 0x002f, 0x0003);
> +    create_unimplemented_device("gpio E", OFFSET_DATA + 0x002c, 0x0003);
> +    create_unimplemented_device("gpio D", OFFSET_DATA + 0x0029, 0x0003);
> +    create_unimplemented_device("gpio C", OFFSET_DATA + 0x0026, 0x0003);
> +    create_unimplemented_device("gpio B", OFFSET_DATA + 0x0023, 0x0003);
> +    create_unimplemented_device("gpio A", OFFSET_DATA + 0x0020, 0x0003);
> +
> +    memory_region_allocate_system_memory(
> +        sms->ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
> +    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200,
> sms->ram);
> +
> +    /* Power Reduction built-in peripheral */
> +    sms->prr[0] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> +                    OFFSET_DATA + PRR0_BASE, NULL));
> +    sms->prr[1] =3D AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
> +                    OFFSET_DATA + PRR1_BASE, NULL));
> +
> +    /* USART 0 built-in peripheral */
> +    sms->usart0 =3D AVR_USART(object_new(TYPE_AVR_USART));
> +    busdev =3D SYS_BUS_DEVICE(sms->usart0);
> +    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
> +    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
> +            &error_fatal);
> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
> +    /*
> +     * These IRQ numbers don't match the datasheet because we're countin=
g
> from
> +     * zero and not including reset.
> +     */
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
> USART_RXC_IRQ));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
> USART_DRE_IRQ));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
> USART_TXC_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1,
> +            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
> +
> +    /* Timer 1 built-in periphal */
> +    sms->timer1 =3D AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
> +    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
> +            &error_fatal);
> +    busdev =3D SYS_BUS_DEVICE(sms->timer1);
> +    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
> +    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
> +    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
> +    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev,
> TIMER1_CAPT_IRQ));
> +    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev,
> TIMER1_COMPA_IRQ));
> +    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev,
> TIMER1_COMPB_IRQ));
> +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev,
> TIMER1_COMPC_IRQ));
> +    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev,
> TIMER1_OVF_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
> +            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
> +
> +    /* Load firmware (contents of flash) trying to auto-detect format */
> +    if (filename !=3D NULL) {
> +        bytes_loaded =3D load_elf(
> +            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0,
> 0);
> +        if (bytes_loaded < 0) {
> +            bytes_loaded =3D load_image_targphys(
> +                filename, OFFSET_CODE, SIZE_FLASH);
> +        }
> +        if (bytes_loaded < 0) {
> +            error_report(
> +                "Unable to load firmware image %s as ELF or raw binary",
> +                firmware);
> +            exit(1);
> +        }
> +    }
> +}
> +
> +static void sample_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "AVR sample/example board (ATmega2560)";
> +    mc->init =3D sample_init;
> +    mc->default_cpus =3D 1;
> +    mc->min_cpus =3D mc->default_cpus;
> +    mc->max_cpus =3D mc->default_cpus;
> +    mc->default_cpu_type =3D "avr6-avr-cpu"; /* ATmega2560. */
> +    mc->is_default =3D 1;
> +}
> +
> +static const TypeInfo sample_info =3D {
> +    .name =3D TYPE_SAMPLE_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(SampleMachineState),
> +    .class_size =3D sizeof(SampleMachineClass),
> +    .class_init =3D sample_class_init,
> +};
> +
> +static void sample_machine_init(void)
> +{
> +    type_register_static(&sample_info);
> +}
> +
> +type_init(sample_machine_init);
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5099f27dc8..e6511466ba 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -439,7 +439,7 @@ int load_elf_ram(const char *filename,
>      return load_elf_ram_sym(filename, elf_note_fn,
>                              translate_fn, translate_opaque,
>                              pentry, lowaddr, highaddr, big_endian,
> -                            elf_machine, clear_lsb, data_swab, as,
> +                            elf_machine, NULL, clear_lsb, data_swab, as,
>                              load_rom, NULL);
>  }
>
> @@ -449,7 +449,8 @@ int load_elf_ram_sym(const char *filename,
>                       uint64_t (*translate_fn)(void *, uint64_t),
>                       void *translate_opaque, uint64_t *pentry,
>                       uint64_t *lowaddr, uint64_t *highaddr, int
> big_endian,
> -                     int elf_machine, int clear_lsb, int data_swab,
> +                     int elf_machine, uint32_t *pflags,
> +                     int clear_lsb, int data_swab,
>                       AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
)
>  {
>      int fd, data_order, target_data_order, must_swab, ret =3D
> ELF_LOAD_FAILED;
> @@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
>      if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
>          ret =3D load_elf64(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine,
> clear_lsb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, elf_machine, pflags,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      } else {
>          ret =3D load_elf32(filename, fd, elf_note_fn,
>                           translate_fn, translate_opaque, must_swab,
> -                         pentry, lowaddr, highaddr, elf_machine,
> clear_lsb,
> -                         data_swab, as, load_rom, sym_cb);
> +                         pentry, lowaddr, highaddr, elf_machine, pflags,
> +                         clear_lsb, data_swab, as, load_rom, sym_cb);
>      }
>
>   fail:
> diff --git a/hw/Kconfig b/hw/Kconfig
> index b9685b3944..07b8abb342 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -44,6 +44,7 @@ source watchdog/Kconfig
>  # arch Kconfig
>  source arm/Kconfig
>  source alpha/Kconfig
> +source avr/Kconfig
>  source cris/Kconfig
>  source hppa/Kconfig
>  source i386/Kconfig
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> new file mode 100644
> index 0000000000..92aa1e6afb
> --- /dev/null
> +++ b/hw/avr/Kconfig
> @@ -0,0 +1,6 @@
> +config AVR_SAMPLE
> +    bool
> +    select AVR_TIMER16
> +    select AVR_USART
> +    select AVR_MASK
> +    select UNIMP
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> new file mode 100644
> index 0000000000..626b7064b3
> --- /dev/null
> +++ b/hw/avr/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y +=3D sample.o
> --
> 2.17.2 (Apple Git-113)
>
>

--0000000000001789a605994980c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 8, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">A simple board setup that configures an AVR CPU to run a given fi=
rmware image.<br>
This is all that&#39;s useful to implement without peripheral emulation as =
AVR CPUs include a lot of on-board peripherals.<br>
<br>
NOTE: this is not a real board !!!!<br>
NOTE: it&#39;s used for CPU testing!!!!<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om">amarkovic@wavecomp.com</a>&gt;<br>
Nacked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0include/hw/elf_ops.h |=C2=A0 =C2=A06 +-<br>
=C2=A0include/hw/loader.h=C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 | 293 +++++++++++++++++++++++++++=
+++<wbr>+++++++++++++<br>
=C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<=
br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +<br>
=C2=A0hw/avr/Makefile.objs |=C2=A0 =C2=A01 +<br>
=C2=A08 files changed, 317 insertions(+), 8 deletions(-)<br>
=C2=A0create mode 100644 hw/avr/sample.c<br>
=C2=A0create mode 100644 hw/avr/Kconfig<br>
=C2=A0create mode 100644 hw/avr/Makefile.objs<br>
<br>
diff --git a/include/elf.h b/include/elf.h<br>
index 3501e0c8d0..53cdfa23b7 100644<br>
--- a/include/elf.h<br>
+++ b/include/elf.h<br>
@@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {<br>
=C2=A0#define EM_MOXIE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0223=C2=A0 =
=C2=A0 =C2=A0/* Moxie processor family */<br>
=C2=A0#define EM_MOXIE_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A00xFEED<br>
<br>
+#define EM_AVR 83 /* AVR 8-bit microcontroller */<br>
+<br>
=C2=A0/* This is the info that is needed to parse the dynamic section of th=
e file */<br>
=C2=A0#define DT_NULL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0<br>
=C2=A0#define DT_NEEDED=C2=A0 =C2=A0 =C2=A0 1<br>
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h<br>
index e07d276df7..9f28c16490 100644<br>
--- a/include/hw/elf_ops.h<br>
+++ b/include/hw/elf_ops.h<br>
@@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int fd,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *translate_opaque,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int must_swab, uint64_t *pentry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *lowaddr, uint64_t *highaddr=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, int clear_lsb, int data_sw=
ab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int elf_machine, uint32_t *pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int clear_lsb, int data_swab,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace *as, bool load_rom,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0symbol_fn_t sym_cb)</blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br></blockquote><div><br></div><div>=C2=A0New pa=
rameter uint32_t *pflags should go before=C2=A0int elf_machine, so that inp=
ut and output parameters are grouped together. The mane should be more prec=
ise, like pe_flags.</div><div><br></div><div>But, it looks to me that you a=
re breaking all other platforms with this change. Did you try full qemu bui=
ld after your series is applied?</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=C2=A0</blockquote=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
=C2=A0{<br>
@@ -594,6 +595,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (pflags) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pflags =3D (uint32_t)(elf_sword)ehdr.e_<wbr>f=
lags;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (lowaddr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*lowaddr =3D (uint64_t)(elf_sword)low;<br=
>
=C2=A0 =C2=A0 =C2=A0if (highaddr)<br>
diff --git a/include/hw/loader.h b/include/hw/loader.h<br>
index 48a96cd559..3dbdd1868d 100644<br>
--- a/include/hw/loader.h<br>
+++ b/include/hw/loader.h<br>
@@ -132,7 +132,8 @@ int load_elf_ram_sym(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t (*translate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void *translate_opaque, uint64_t *pentry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t *lowaddr, uint64_t *highaddr, int big_endian,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int elf_machine, int clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int elf_machine, uint32_t *pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int clear_lsb, int data_swab,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AddressSpace *as, bool load_rom, symbol_fn_t sym_cb);<br>
<br>
=C2=A0/** load_elf_ram:<br>
diff --git a/hw/avr/sample.c b/hw/avr/sample.c<br>
new file mode 100644<br>
index 0000000000..6574733b57<br>
--- /dev/null<br>
+++ b/hw/avr/sample.c<br>
@@ -0,0 +1,293 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+/*<br>
+ *=C2=A0 NOTE:<br>
+ *=C2=A0 =C2=A0 =C2=A0 This is not a real AVR board, this is an example!<b=
r>
+ *=C2=A0 =C2=A0 =C2=A0 The CPU is an approximation of an ATmega2560, but i=
s missing various<br>
+ *=C2=A0 =C2=A0 =C2=A0 built-in peripherals.<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 This example board loads provided binary file into =
flash memory and<br>
+ *=C2=A0 =C2=A0 =C2=A0 executes it from 0x00000000 address in the code mem=
ory space.<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 Currently used for AVR CPU validation<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;hw/hw.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;sysemu/qtest.h&quot;<br>
+#include &quot;ui/console.h&quot;<br>
+#include &quot;hw/boards.h&quot;<br>
+#include &quot;hw/loader.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;exec/address-spaces.h&quot;<br>
+#include &quot;include/hw/sysbus.h&quot;<br>
+#include &quot;include/hw/char/avr_usart.h&quot;<br>
+#include &quot;include/hw/timer/avr_timer16.<wbr>h&quot;<br>
+#include &quot;include/hw/misc/avr_mask.h&quot;<br>
+#include &quot;elf.h&quot;<br>
+#include &quot;hw/misc/unimp.h&quot;<br>
+<br>
+#define SIZE_FLASH 0x00040000<br>
+#define SIZE_SRAM 0x00002000<br>
+/*<br>
+ * Size of additional &quot;external&quot; memory, as if the AVR were conf=
igured to use<br>
+ * an external RAM chip.<br>
+ * Note that the configuration registers that normally enable this feature=
 are<br>
+ * unimplemented.<br>
+ */<br>
+#define SIZE_EXMEM 0x00000000<br>
+<br>
+/* Offsets of peripherals in emulated memory space (i.e. not host addresse=
s)=C2=A0 */<br>
+#define PRR0_BASE 0x64<br>
+#define PRR1_BASE 0x65<br>
+#define USART_BASE 0xc0<br>
+#define TIMER1_BASE 0x80<br>
+#define TIMER1_IMSK_BASE 0x6f<br>
+#define TIMER1_IFR_BASE 0x36<br>
+<br>
+/* Interrupt numbers used by peripherals */<br>
+#define USART_RXC_IRQ 24<br>
+#define USART_DRE_IRQ 25<br>
+#define USART_TXC_IRQ 26<br>
+<br>
+#define TIMER1_CAPT_IRQ 15<br>
+#define TIMER1_COMPA_IRQ 16<br>
+#define TIMER1_COMPB_IRQ 17<br>
+#define TIMER1_COMPC_IRQ 18<br>
+#define TIMER1_OVF_IRQ 19<br>
+<br>
+/*=C2=A0 Power reduction=C2=A0 =C2=A0 =C2=A0*/<br>
+#define PRR1_BIT_PRTIM5=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter5=C2=A0 */<br>
+#define PRR1_BIT_PRTIM4=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter4=C2=A0 */<br>
+#define PRR1_BIT_PRTIM3=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter3=C2=A0 */<br>
+#define PRR1_BIT_PRUSART3=C2=A0 =C2=A00x02=C2=A0 =C2=A0 /*=C2=A0 USART3=C2=
=A0 */<br>
+#define PRR1_BIT_PRUSART2=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USART2=C2=
=A0 */<br>
+#define PRR1_BIT_PRUSART1=C2=A0 =C2=A00x00=C2=A0 =C2=A0 /*=C2=A0 USART1=C2=
=A0 */<br>
+<br>
+#define PRR0_BIT_PRTWI=C2=A0 =C2=A0 =C2=A0 0x06=C2=A0 =C2=A0 /*=C2=A0 TWI =
*/<br>
+#define PRR0_BIT_PRTIM2=C2=A0 =C2=A0 =C2=A00x05=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter2=C2=A0 */<br>
+#define PRR0_BIT_PRTIM0=C2=A0 =C2=A0 =C2=A00x04=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter0=C2=A0 */<br>
+#define PRR0_BIT_PRTIM1=C2=A0 =C2=A0 =C2=A00x03=C2=A0 =C2=A0 /*=C2=A0 Time=
r/Counter1=C2=A0 */<br>
+#define PRR0_BIT_PRSPI=C2=A0 =C2=A0 =C2=A0 0x02=C2=A0 =C2=A0 /*=C2=A0 Seri=
al Peripheral Interface */<br>
+#define PRR0_BIT_PRUSART0=C2=A0 =C2=A00x01=C2=A0 =C2=A0 /*=C2=A0 USART0=C2=
=A0 */<br>
+#define PRR0_BIT_PRADC=C2=A0 =C2=A0 =C2=A0 0x00=C2=A0 =C2=A0 /*=C2=A0 ADC =
*/<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 MachineClass parent;<br>
+} SampleMachineClass;<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 MachineState parent;<br>
+=C2=A0 =C2=A0 MemoryRegion *ram;<br>
+=C2=A0 =C2=A0 MemoryRegion *flash;<br>
+=C2=A0 =C2=A0 AVRUsartState *usart0;<br>
+=C2=A0 =C2=A0 AVRTimer16State *timer1;<br>
+=C2=A0 =C2=A0 AVRMaskState *prr[2];<br>
+} SampleMachineState;<br>
+<br>
+#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME(&quot;sample&quot;)<br>
+<br>
+#define SAMPLE_MACHINE(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(<wbr>SampleMachineState, obj, TYPE_SAMPLE_MACHI=
NE)<br>
+#define SAMPLE_MACHINE_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_GET_CLASS(<wbr>SampleMachineClass, obj, TYPE_SAMPLE_M=
ACHINE)<br>
+#define SAMPLE_MACHINE_CLASS(klass) \<br>
+=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(<wbr>SampleMachineClass, klass, TYPE_SAMP=
LE_MACHINE)<br>
+<br>
+static void sample_init(MachineState *machine)<br>
+{<br>
+=C2=A0 =C2=A0 SampleMachineState *sms =3D SAMPLE_MACHINE(machine);<br>
+=C2=A0 =C2=A0 MemoryRegion *system_memory =3D get_system_memory();<br>
+=C2=A0 =C2=A0 AVRCPU *cpu;<br>
+=C2=A0 =C2=A0 const char *firmware =3D NULL;<br>
+=C2=A0 =C2=A0 const char *filename =3D NULL;<br>
+=C2=A0 =C2=A0 const char *cpu_type =3D NULL;<br>
+=C2=A0 =C2=A0 uint32_t flags;<br>
+=C2=A0 =C2=A0 int bytes_loaded;<br>
+=C2=A0 =C2=A0 SysBusDevice *busdev;<br>
+=C2=A0 =C2=A0 DeviceState *cpudev;<br>
+<br>
+=C2=A0 =C2=A0 system_memory =3D get_system_memory();<br>
+=C2=A0 =C2=A0 sms-&gt;ram =3D g_new(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 sms-&gt;flash =3D g_new(MemoryRegion, 1);<br>
+<br>
+=C2=A0 =C2=A0 /* if ELF file is provided, determine CPU type reading ELF f=
lags */<br>
+=C2=A0 =C2=A0 cpu_type =3D machine-&gt;cpu_type;<br>
+=C2=A0 =C2=A0 firmware =3D machine-&gt;firmware;<br>
+=C2=A0 =C2=A0 if (firmware !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FILE_TYPE_<wb=
r>BIOS, firmware);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filename =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable to fin=
d %s&quot;, firmware);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf_ram_sym(filename, NU=
LL, NULL, NULL, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, 0, EM_AVR, &=
amp;flags, 0, 0, NULL, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_type =3D avr_flags_to_cpu_ty=
pe(flags, cpu_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cpu =3D AVR_CPU(cpu_create(cpu_type));<br>
+=C2=A0 =C2=A0 cpudev =3D DEVICE(cpu);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_rom(sms-&gt;<wbr>flash, NULL, &quot;avr.f=
lash&quot;, SIZE_FLASH,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>system_memory, OFFSET_CODE,=
 sms-&gt;flash);<br>
+<br>
+=C2=A0 =C2=A0 /* following are atmel2560 device */<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 3&quot;, OFFSET=
_DATA + 0x0130, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 5=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0120, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio L&quot;, OFFSET_=
DATA + 0x0109, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio K&quot;, OFFSET_=
DATA + 0x0106, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio J&quot;, OFFSET_=
DATA + 0x0103, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio H&quot;, OFFSET_=
DATA + 0x0100, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 2&quot;, OFFSET=
_DATA + 0x00d0, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 1&quot;, OFFSET=
_DATA + 0x00c8, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>usart 0&quot;, OFFSET=
_DATA + 0x00c0, 0x0007);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>twi&quot;, OFFSET_DAT=
A + 0x00b8, 0x0006);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-async-8=
bit 2&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00b0, 0x0007);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 4=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x00a0, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 3=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0090, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-16bit 1=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0080, 0x000e);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ac / adc&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0078, 0x0008);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ext-mem-iface&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0074, 0x0002);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>int-controller&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0068, 0x000c);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>sys&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0060, 0x0007);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>spi&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004c, 0x0003);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ext-mem-iface&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x004a, 0x0002);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>timer-counter-pwm-8bi=
t 0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0043, 0x0006);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>ext-mem-iface&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x003e, 0x0005);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>int-controller&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0035, 0x0009);<b=
r>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio G&quot;, OFFSET_=
DATA + 0x0032, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio F&quot;, OFFSET_=
DATA + 0x002f, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio E&quot;, OFFSET_=
DATA + 0x002c, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio D&quot;, OFFSET_=
DATA + 0x0029, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio C&quot;, OFFSET_=
DATA + 0x0026, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio B&quot;, OFFSET_=
DATA + 0x0023, 0x0003);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>gpio A&quot;, OFFSET_=
DATA + 0x0020, 0x0003);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sms-&gt;ram, NULL, &quot;avr.ram&quot;, SIZE_S=
RAM + SIZE_EXMEM);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>system_memory, OFFSET_DATA =
+ 0x200, sms-&gt;ram);<br>
+<br>
+=C2=A0 =C2=A0 /* Power Reduction built-in peripheral */<br>
+=C2=A0 =C2=A0 sms-&gt;prr[0] =3D AVR_MASK(sysbus_create_simple(<wbr>TYPE_A=
VR_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFS=
ET_DATA + PRR0_BASE, NULL));<br>
+=C2=A0 =C2=A0 sms-&gt;prr[1] =3D AVR_MASK(sysbus_create_simple(<wbr>TYPE_A=
VR_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFS=
ET_DATA + PRR1_BASE, NULL));<br>
+<br>
+=C2=A0 =C2=A0 /* USART 0 built-in peripheral */<br>
+=C2=A0 =C2=A0 sms-&gt;usart0 =3D AVR_USART(object_new(TYPE_AVR_<wbr>USART)=
);<br>
+=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms-&gt;usart0);<br>
+=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sms-&gt;<wbr>usart0), &quot;chardev=
&quot;, serial_hd(0));<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(sms-&gt;usart0), true, =
&quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* These IRQ numbers don&#39;t match the datasheet beca=
use we&#39;re counting from<br>
+=C2=A0 =C2=A0 =C2=A0* zero and not including reset.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, USART=
_RXC_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, USART=
_DRE_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, USART=
_TXC_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(sms-&gt;prr[1]), PRR1=
_BIT_PRUSART1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sms-&gt;=
<wbr>usart0), 0));<br>
+<br>
+=C2=A0 =C2=A0 /* Timer 1 built-in periphal */<br>
+=C2=A0 =C2=A0 sms-&gt;timer1 =3D AVR_TIMER16(object_new(TYPE_<wbr>AVR_TIME=
R16));<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(sms-&gt;timer1), true, =
&quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 busdev =3D SYS_BUS_DEVICE(sms-&gt;timer1);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);<=
br>
+=C2=A0 =C2=A0 sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);<b=
r>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, TIMER=
1_CAPT_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, TIMER=
1_COMPA_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, TIMER=
1_COMPB_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, TIMER=
1_COMPC_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, TIMER=
1_OVF_IRQ));<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(sms-&gt;prr[0]), PRR0=
_BIT_PRTIM1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(sms-&gt;=
<wbr>timer1), 0));<br>
+<br>
+=C2=A0 =C2=A0 /* Load firmware (contents of flash) trying to auto-detect f=
ormat */<br>
+=C2=A0 =C2=A0 if (filename !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_elf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, NULL, NULL, NULL, NULL=
, NULL, NULL, 0, EM_NONE, 0, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_image_targ=
phys(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename, OFFSET_C=
ODE, SIZE_FLASH);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Unable to lo=
ad firmware image %s as ELF or raw binary&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firmware);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void sample_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;AVR sample/example board (ATmega2560)&=
quot;;<br>
+=C2=A0 =C2=A0 mc-&gt;init =3D sample_init;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpus =3D 1;<br>
+=C2=A0 =C2=A0 mc-&gt;min_cpus =3D mc-&gt;default_cpus;<br>
+=C2=A0 =C2=A0 mc-&gt;max_cpus =3D mc-&gt;default_cpus;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D &quot;avr6-avr-cpu&quot;; /* ATm=
ega2560. */<br>
+=C2=A0 =C2=A0 mc-&gt;is_default =3D 1;<br>
+}<br>
+<br>
+static const TypeInfo sample_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_SAMPLE_MACHINE,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(SampleMachineState),<br>
+=C2=A0 =C2=A0 .class_size =3D sizeof(SampleMachineClass),<br>
+=C2=A0 =C2=A0 .class_init =3D sample_class_init,<br>
+};<br>
+<br>
+static void sample_machine_init(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;sample_<wbr>info);<br>
+}<br>
+<br>
+type_init(sample_machine_<wbr>init);<br>
diff --git a/hw/core/loader.c b/hw/core/loader.c<br>
index 5099f27dc8..e6511466ba 100644<br>
--- a/hw/core/loader.c<br>
+++ b/hw/core/loader.c<br>
@@ -439,7 +439,7 @@ int load_elf_ram(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0return load_elf_ram_sym(filename, elf_note_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0translate_fn, translate_opaque,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, big_endian,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 elf_machine, clear_lsb, data_swab, as,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 elf_machine, NULL, clear_lsb, data_swab, as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_rom, NULL);<br>
=C2=A0}<br>
<br>
@@ -449,7 +449,8 @@ int load_elf_ram_sym(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t (*translate_fn)(void *, uint64_t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void *translate_opaque, uint64_t *pentry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint64_t *lowaddr, uint64_t *highaddr, int big_endian,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int elf_machine, int clear_lsb, int data_swab,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int elf_machine, uint32_t *pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int clear_lsb, int data_swab,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int fd, data_order, target_data_order, must_swab, ret =
=3D ELF_LOAD_FAILED;<br>
@@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf64(filename, fd, elf_note=
_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque, must_swab,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, clear_lsb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D load_elf32(filename, fd, elf_note=
_fn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 translate_fn, translate_opaque, must_swab,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, clear_lsb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0data_swab, as, load_rom, sym_cb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pentry, lowaddr, highaddr, elf_machine, pflags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0clear_lsb, data_swab, as, load_rom, sym_cb);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 fail:<br>
diff --git a/hw/Kconfig b/hw/Kconfig<br>
index b9685b3944..07b8abb342 100644<br>
--- a/hw/Kconfig<br>
+++ b/hw/Kconfig<br>
@@ -44,6 +44,7 @@ source watchdog/Kconfig<br>
=C2=A0# arch Kconfig<br>
=C2=A0source arm/Kconfig<br>
=C2=A0source alpha/Kconfig<br>
+source avr/Kconfig<br>
=C2=A0source cris/Kconfig<br>
=C2=A0source hppa/Kconfig<br>
=C2=A0source i386/Kconfig<br>
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
new file mode 100644<br>
index 0000000000..92aa1e6afb<br>
--- /dev/null<br>
+++ b/hw/avr/Kconfig<br>
@@ -0,0 +1,6 @@<br>
+config AVR_SAMPLE<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 select AVR_TIMER16<br>
+=C2=A0 =C2=A0 select AVR_USART<br>
+=C2=A0 =C2=A0 select AVR_MASK<br>
+=C2=A0 =C2=A0 select UNIMP<br>
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs<br>
new file mode 100644<br>
index 0000000000..626b7064b3<br>
--- /dev/null<br>
+++ b/hw/avr/Makefile.objs<br>
@@ -0,0 +1 @@<br>
+obj-y +=3D sample.o<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--0000000000001789a605994980c9--

