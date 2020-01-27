Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DE7C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909392071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em/+Zbop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909392071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzOs-0003FM-Or
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivzNx-0002gR-VC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivzNs-0000NX-Ed
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:04:41 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivzNo-0000JM-4c; Mon, 27 Jan 2020 03:04:36 -0500
Received: by mail-oi1-x244.google.com with SMTP id a142so4247857oii.7;
 Mon, 27 Jan 2020 00:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gnIqBtzfSrUNd0oOsKFf0kXeZ0SxwXMQ+1IA9+KW2e8=;
 b=em/+ZboplitXfmEof4rwmm9Z9KTDb9b5/782b0jOBcPBgtYeOMd/4XJPpWhoE5voUW
 T2I1DfK2MGlgWTDxap8pCDAg6lG47cGRcQqWkkgbD9iChpxpC6oYBiQIdVb2AaTyY+Yy
 ZkVvE8KTunKmA24w8HsHlP3shLasicS3NIbZLb5/1Js5DssdzSgOg1pT/yjJuNwdyTgB
 HOm2BC12wHUxWNjdA2Owa6kiCG3bHdOBQ0RUo3oCuQRjuSLLL5rFXfhsTHHdRahzTfBi
 lP4ZqQkrDK4bdFr4t6Gr6SzOfdQiz58bJ4jvc7Rz5wk6Q6ljH4TSTTnQEc4dP7LubJIU
 mksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gnIqBtzfSrUNd0oOsKFf0kXeZ0SxwXMQ+1IA9+KW2e8=;
 b=CmOr3KEU5bcfrVNvEwKYk8l39xU7j682wwX8FIyUOrGQ53DXyYPQtgVgpCCwVknLxC
 e7SWj/+vB5Adh3v+8+fzBca4Xasy5DN+Iyc93D36x7Mk532idS4fXIhkLQpBVxhck0XJ
 c0xixKVbQuXm4oQ5uS8cica7gc8ec7JLt/C3Hj+tmlJ88Ow0ofev4gefPOBCXmRWu+5J
 pULBkKUuWg7HI296YBbTVUrwgXTBWqVAnXc9rspq/Wc3KjXmD4eoS7JHGrsurN9jEL13
 p8Ev7ZzOuLOeOO4VYUlpER2HSGf0OW+o1nHrTMgDWlmfHe76JwgBSb8cIg5+DFoN5xIW
 m1tQ==
X-Gm-Message-State: APjAAAWezJ+TAJh7BM9ZEV+ZYMb4oTkiUJtWjaEjJ+Fx+jYfz1oNk8NE
 tV0Nd4z4XY4oovbK1pVHfKNcfDqSjSMXPrbDSWI=
X-Google-Smtp-Source: APXvYqxqm6riAuANmrR6UJ8V/cEtQn3QMRtbQeuY+rkZqJnTYxs7TcOdzcb0nDzGrdF5mHClTg9mt/lbu5C8erGpOWo=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr6723495oif.53.1580112270686; 
 Mon, 27 Jan 2020 00:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-21-f4bug@amsat.org>
 <CAL1e-=ht6NS_ZyGAh59V2HuQkoXm=pyEz20SUPzxQkFkU=iCsQ@mail.gmail.com>
 <1f27af2f-290b-2f07-b29d-9b7f18345cee@redhat.com>
In-Reply-To: <1f27af2f-290b-2f07-b29d-9b7f18345cee@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 Jan 2020 09:04:13 +0100
Message-ID: <CAL1e-=h-s84UYN4_4SMYgTrvt1qus2Q+vSQ=nsHMutegYz2-uw@mail.gmail.com>
Subject: Re: [PATCH rc2 20/25] hw/avr: Add some ATmega microcontrollers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000099826b059d1a8eaa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Fam Zheng <fam@euphon.net>, "S.E.Harris@kent.ac.uk" <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000099826b059d1a8eaa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

08:59 Pon, 27.01.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 1/26/20 3:46 PM, Aleksandar Markovic wrote:
> > On Friday, January 24, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg
> > <mailto:f4bug@amsat.org>> wrote:
> >
> >     Add some microcontrollers from the megaAVR family (ATmega series):
> >
> >     - middle range: ATmega168 and ATmega328
> >     - high range: ATmega1280 and ATmega2560
> >
> >     For product comparison:
> >
https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmega328P
> >     <
https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmega328P>
> >
https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmega2560
> >     <
https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmega2560>
> >
> >     Datasheets:
> >
http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168A-PA=
-328-P-DS-DS40002061A.pdf
> >     <
http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168A-PA=
-328-P-DS-DS40002061A.pdf
>
> >
http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microc=
ontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
> >     <
http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microc=
ontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
>
> >
> >     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>>
> >     Message-Id: <20200120220107.17825-14-f4bug@amsat.org
> >     <mailto:20200120220107.17825-14-f4bug@amsat.org>>
> >     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> >     <mailto:richard.henderson@linaro.org>>
> >     ---
> >     rc2:
> >     - Squashed Kconfig patch (Thomas)
> >     - Correct SRAM base address
> >     ---
> >       hw/avr/atmel_atmega.h |  48 +++++
> >       hw/avr/atmel_atmega.c | 470
++++++++++++++++++++++++++++++++++++++++++
> >       hw/avr/Kconfig        |   5 +
> >       hw/avr/Makefile.objs  |   1 +
> >       4 files changed, 524 insertions(+)
> >       create mode 100644 hw/avr/atmel_atmega.h
> >       create mode 100644 hw/avr/atmel_atmega.c
> >       create mode 100644 hw/avr/Kconfig
> >
> >
> > This patch introduces a terminology confusion that will be difficult to
> > eliminate once the code is in the tree.
> >
> > "AVR" is the name (or, if someone wishes, the common name prefix) of
the
> > family of all MCUs covered in this series. This is reflected in the
> > existence of the directory "hw/avr", and this is, in my opinion fine.
> >
> > "Atmel" is the company that used to design AVR MCUs (there are hundreds
> > of such MCUs). "Atmel" was acquired several years ago by another
> > company, "Microchip". Trere is no element in AVR MCUs' docimentation
> > that reffers to the producers (except title, copyright, etc). In all
> > recent docs, "Atmel" is complely eradicated.
> >
> > Therefore, using the name of non-existant company "Atmel" is confusing,
> > and, moreover, completely unnecessary. Please, remove references to
> > "Atmel" from file names, and from the code.
>
> I simply used "Atmel" because this is how I discovered this chips and
> always called them by the Atmel brand.

That is understandable.

> The Microchip acquisition is
> quite recent. When I look for datasheet is I still write "Atmel
> something" and eventually end on the microchip website.
>
> IOW it was not a deliberate name, simply Microchip could not eradicate
> "Atmel" from my memory =3D)
>
> I'll rename these files at "atmega.{c,h}".
>

Thanks. It is important that we get the naming right from the outset.

> Thanks,
>
> Phil.
>
> >     diff --git a/hw/avr/atmel_atmega.h b/hw/avr/atmel_atmega.h
> >     new file mode 100644
> >     index 0000000000..391b8b1bf8
> >     --- /dev/null
> >     +++ b/hw/avr/atmel_atmega.h
> >     @@ -0,0 +1,48 @@
> >     +/*
> >     + * QEMU ATmega MCU
> >     + *
> >     + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> >     + *
> >     + * This work is licensed under the terms of the GNU GPLv2 or later=
.
> >     + * See the COPYING file in the top-level directory.
> >     + * SPDX-License-Identifier: GPL-2.0-or-later
> >     + */
> >     +
> >     +#ifndef HW_AVR_ATMEL_ATMEGA_H
> >     +#define HW_AVR_ATMEL_ATMEGA_H
> >     +
> >     +#include "hw/char/atmel_usart.h"
> >     +#include "hw/timer/atmel_timer16.h"
> >     +#include "hw/misc/atmel_power.h"
> >     +#include "target/avr/cpu.h"
> >     +
> >     +#define TYPE_ATMEGA_MCU     "ATmega"
> >     +#define TYPE_ATMEGA168_MCU  "ATmega168"
> >     +#define TYPE_ATMEGA328_MCU  "ATmega328"
> >     +#define TYPE_ATMEGA1280_MCU "ATmega1280"
> >     +#define TYPE_ATMEGA2560_MCU "ATmega2560"
> >     +
> >     +#define ATMEGA_MCU(obj) OBJECT_CHECK(AtmegaMcuState, (obj),
> >     TYPE_ATMEGA_MCU)
> >     +
> >     +#define POWER_MAX 2
> >     +#define USART_MAX 4
> >     +#define TIMER_MAX 6
> >     +#define GPIO_MAX 12
> >     +
> >     +typedef struct AtmegaMcuState {
> >     +    /*< private >*/
> >     +    SysBusDevice parent_obj;
> >     +    /*< public >*/
> >     +
> >     +    AVRCPU cpu;
> >     +    MemoryRegion flash;
> >     +    MemoryRegion eeprom;
> >     +    MemoryRegion sram;
> >     +    DeviceState *io;
> >     +    AVRMaskState pwr[POWER_MAX];
> >     +    AVRUsartState usart[USART_MAX];
> >     +    AVRTimer16State timer[TIMER_MAX];
> >     +    uint64_t xtal_freq_hz;
> >     +} AtmegaMcuState;
> >     +
> >     +#endif /* HW_AVR_ATMEL_ATMEGA_H */
> >     diff --git a/hw/avr/atmel_atmega.c b/hw/avr/atmel_atmega.c
> >     new file mode 100644
> >     index 0000000000..790c374dee
> >     --- /dev/null
> >     +++ b/hw/avr/atmel_atmega.c
> >     @@ -0,0 +1,470 @@
> >     +/*
> >     + * QEMU ATmega MCU
> >     + *
> >     + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> >     + *
> >     + * This work is licensed under the terms of the GNU GPLv2 or later=
.
> >     + * See the COPYING file in the top-level directory.
> >     + * SPDX-License-Identifier: GPL-2.0-or-later
> >     + */
> >     +
> >     +#include "qemu/osdep.h"
> >     +#include "qemu/module.h"
> >     +#include "qemu/units.h"
> >     +#include "qapi/error.h"
> >     +#include "exec/memory.h"
> >     +#include "exec/address-spaces.h"
> >     +#include "sysemu/sysemu.h"
> >     +#include "hw/qdev-properties.h"
> >     +#include "hw/sysbus.h"
> >     +#include "hw/boards.h" /* FIXME
> >     memory_region_allocate_system_memory for sram */
> >     +#include "hw/misc/unimp.h"
> >     +#include "atmel_atmega.h"
> >     +
> >     +enum AtmegaPeripheral {
> >     +    POWER0, POWER1,
> >     +    GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF,
> >     +    GPIOG, GPIOH, GPIOI, GPIOJ, GPIOK, GPIOL,
> >     +    USART0, USART1, USART2, USART3,
> >     +    TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,
> >     +    PERIFMAX
> >     +};
> >     +
> >     +#define GPIO(n)     (n + GPIOA)
> >     +#define USART(n)    (n + USART0)
> >     +#define TIMER(n)    (n + TIMER0)
> >     +#define POWER(n)    (n + POWER0)
> >     +
> >     +typedef struct {
> >     +    uint16_t addr;
> >     +    enum AtmegaPeripheral power_index;
> >     +    uint8_t power_bit;
> >     +    /* timer specific */
> >     +    uint16_t intmask_addr;
> >     +    uint16_t intflag_addr;
> >     +    bool is_timer16;
> >     +} peripheral_cfg;
> >     +
> >     +typedef struct AtmegaMcuClass {
> >     +    /*< private >*/
> >     +    SysBusDeviceClass parent_class;
> >     +    /*< public >*/
> >     +    const char *uc_name;
> >     +    const char *cpu_type;
> >     +    size_t flash_size;
> >     +    size_t eeprom_size;
> >     +    size_t sram_size;
> >     +    size_t io_size;
> >     +    size_t gpio_count;
> >     +    size_t adc_count;
> >     +    const uint8_t *irq;
> >     +    const peripheral_cfg *dev;
> >     +} AtmegaMcuClass;
> >     +
> >     +#define ATMEGA_MCU_CLASS(klass) \
> >     +    OBJECT_CLASS_CHECK(AtmegaMcuClass, (klass), TYPE_ATMEGA_MCU)
> >     +#define ATMEGA_MCU_GET_CLASS(obj) \
> >     +    OBJECT_GET_CLASS(AtmegaMcuClass, (obj), TYPE_ATMEGA_MCU)
> >     +
> >     +static const peripheral_cfg dev168_328[PERIFMAX] =3D {
> >     +    [USART0]        =3D {  0xc0, POWER0, 1 },
> >     +    [TIMER2]        =3D {  0xb0, POWER0, 6, 0x70, 0x37, false },
> >     +    [TIMER1]        =3D {  0x80, POWER0, 3, 0x6f, 0x36, true },
> >     +    [POWER0]        =3D {  0x64 },
> >     +    [TIMER0]        =3D {  0x44, POWER0, 5, 0x6e, 0x35, false },
> >     +    [GPIOD]         =3D {  0x29 },
> >     +    [GPIOC]         =3D {  0x26 },
> >     +    [GPIOB]         =3D {  0x23 },
> >     +}, dev1280_2560[PERIFMAX] =3D {
> >     +    [USART3]        =3D { 0x130, POWER1, 2 },
> >     +    [TIMER5]        =3D { 0x120, POWER1, 5, 0x73, 0x3a, true },
> >     +    [GPIOL]         =3D { 0x109 },
> >     +    [GPIOK]         =3D { 0x106 },
> >     +    [GPIOJ]         =3D { 0x103 },
> >     +    [GPIOH]         =3D { 0x100 },
> >     +    [USART2]        =3D {  0xd0, POWER1, 1 },
> >     +    [USART1]        =3D {  0xc8, POWER1, 0 },
> >     +    [USART0]        =3D {  0xc0, POWER0, 1 },
> >     +    [TIMER2]        =3D {  0xb0, POWER0, 6, 0x70, 0x37, false }, /=
*
> >     TODO async */
> >     +    [TIMER4]        =3D {  0xa0, POWER1, 4, 0x72, 0x39, true },
> >     +    [TIMER3]        =3D {  0x90, POWER1, 3, 0x71, 0x38, true },
> >     +    [TIMER1]        =3D {  0x80, POWER0, 3, 0x6f, 0x36, true },
> >     +    [POWER1]        =3D {  0x65 },
> >     +    [POWER0]        =3D {  0x64 },
> >     +    [TIMER0]        =3D {  0x44, POWER0, 5, 0x6e, 0x35, false },
> >     +    [GPIOG]         =3D {  0x32 },
> >     +    [GPIOF]         =3D {  0x2f },
> >     +    [GPIOE]         =3D {  0x2c },
> >     +    [GPIOD]         =3D {  0x29 },
> >     +    [GPIOC]         =3D {  0x26 },
> >     +    [GPIOB]         =3D {  0x23 },
> >     +    [GPIOA]         =3D {  0x20 },
> >     +};
> >     +
> >     +enum AtmegaIrq {
> >     +    USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,
> >     +    USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,
> >     +    USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,
> >     +    USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,
> >     +    TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,
> >     +        TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,
> >     +    TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,
> >     +        TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,
> >     +    TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,
> >     +        TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,
> >     +    TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,
> >     +        TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,
> >     +    TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,
> >     +        TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,
> >     +    TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,
> >     +        TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,
> >     +    IRQ_COUNT
> >     +};
> >     +
> >     +#define USART_IRQ_COUNT     3
> >     +#define USART_RXC_IRQ(n)    (n * USART_IRQ_COUNT + USART0_RXC_IRQ)
> >     +#define USART_DRE_IRQ(n)    (n * USART_IRQ_COUNT + USART0_DRE_IRQ)
> >     +#define USART_TXC_IRQ(n)    (n * USART_IRQ_COUNT + USART0_TXC_IRQ)
> >     +#define TIMER_IRQ_COUNT     5
> >     +#define TIMER_CAPT_IRQ(n)   (n * TIMER_IRQ_COUNT + TIMER0_CAPT_IRQ=
)
> >     +#define TIMER_COMPA_IRQ(n)  (n * TIMER_IRQ_COUNT +
TIMER0_COMPA_IRQ)
> >     +#define TIMER_COMPB_IRQ(n)  (n * TIMER_IRQ_COUNT +
TIMER0_COMPB_IRQ)
> >     +#define TIMER_COMPC_IRQ(n)  (n * TIMER_IRQ_COUNT +
TIMER0_COMPC_IRQ)
> >     +#define TIMER_OVF_IRQ(n)    (n * TIMER_IRQ_COUNT + TIMER0_OVF_IRQ)
> >     +
> >     +static const uint8_t irq168_328[IRQ_COUNT] =3D {
> >     +    [TIMER2_COMPA_IRQ]      =3D 8,
> >     +    [TIMER2_COMPB_IRQ]      =3D 9,
> >     +    [TIMER2_OVF_IRQ]        =3D 10,
> >     +    [TIMER1_CAPT_IRQ]       =3D 11,
> >     +    [TIMER1_COMPA_IRQ]      =3D 12,
> >     +    [TIMER1_COMPB_IRQ]      =3D 13,
> >     +    [TIMER1_OVF_IRQ]        =3D 14,
> >     +    [TIMER0_COMPA_IRQ]      =3D 15,
> >     +    [TIMER0_COMPB_IRQ]      =3D 16,
> >     +    [TIMER0_OVF_IRQ]        =3D 17,
> >     +    [USART0_RXC_IRQ]        =3D 19,
> >     +    [USART0_DRE_IRQ]        =3D 20,
> >     +    [USART0_TXC_IRQ]        =3D 21,
> >     +}, irq1280_2560[IRQ_COUNT] =3D {
> >     +    [TIMER2_COMPA_IRQ]      =3D 14,
> >     +    [TIMER2_COMPB_IRQ]      =3D 15,
> >     +    [TIMER2_OVF_IRQ]        =3D 16,
> >     +    [TIMER1_CAPT_IRQ]       =3D 17,
> >     +    [TIMER1_COMPA_IRQ]      =3D 18,
> >     +    [TIMER1_COMPB_IRQ]      =3D 19,
> >     +    [TIMER1_COMPC_IRQ]      =3D 20,
> >     +    [TIMER1_OVF_IRQ]        =3D 21,
> >     +    [TIMER0_COMPA_IRQ]      =3D 22,
> >     +    [TIMER0_COMPB_IRQ]      =3D 23,
> >     +    [TIMER0_OVF_IRQ]        =3D 24,
> >     +    [USART0_RXC_IRQ]        =3D 26,
> >     +    [USART0_DRE_IRQ]        =3D 27,
> >     +    [USART0_TXC_IRQ]        =3D 28,
> >     +    [TIMER3_CAPT_IRQ]       =3D 32,
> >     +    [TIMER3_COMPA_IRQ]      =3D 33,
> >     +    [TIMER3_COMPB_IRQ]      =3D 34,
> >     +    [TIMER3_COMPC_IRQ]      =3D 35,
> >     +    [TIMER3_OVF_IRQ]        =3D 36,
> >     +    [USART1_RXC_IRQ]        =3D 37,
> >     +    [USART1_DRE_IRQ]        =3D 38,
> >     +    [USART1_TXC_IRQ]        =3D 39,
> >     +    [TIMER4_CAPT_IRQ]       =3D 42,
> >     +    [TIMER4_COMPA_IRQ]      =3D 43,
> >     +    [TIMER4_COMPB_IRQ]      =3D 44,
> >     +    [TIMER4_COMPC_IRQ]      =3D 45,
> >     +    [TIMER4_OVF_IRQ]        =3D 46,
> >     +    [TIMER5_CAPT_IRQ]       =3D 47,
> >     +    [TIMER5_COMPA_IRQ]      =3D 48,
> >     +    [TIMER5_COMPB_IRQ]      =3D 49,
> >     +    [TIMER5_COMPC_IRQ]      =3D 50,
> >     +    [TIMER5_OVF_IRQ]        =3D 51,
> >     +    [USART2_RXC_IRQ]        =3D 52,
> >     +    [USART2_DRE_IRQ]        =3D 53,
> >     +    [USART2_TXC_IRQ]        =3D 54,
> >     +    [USART3_RXC_IRQ]        =3D 55,
> >     +    [USART3_DRE_IRQ]        =3D 56,
> >     +    [USART3_TXC_IRQ]        =3D 57,
> >     +};
> >     +
> >     +static void connect_peripheral_irq(const AtmegaMcuClass *mc,
> >     +                                   SysBusDevice *sbd,
> >     +                                   DeviceState *dev, int n,
> >     +                                   unsigned peripheral_irq)
> >     +{
> >     +    int irq =3D mc->irq[peripheral_irq];
> >     +
> >     +    if (!irq) {
> >     +        return;
> >     +    }
> >     +    /* FIXME move that to avr_cpu_set_int() once 'sample' board is
> >     removed */
> >     +    assert(irq >=3D 2);
> >     +    irq -=3D 2;
> >     +
> >     +    sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq));
> >     +}
> >     +
> >     +static void connect_power_reduction_gpio(AtmegaMcuState *s,
> >     +                                         const AtmegaMcuClass *mc,
> >     +                                         DeviceState *dev,
> >     +                                         int peripheral_index)
> >     +{
> >     +    unsigned power_index =3D mc->dev[peripheral_index].power_index=
;
> >     +    assert(mc->dev[power_index].addr);
> >     +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[power_index -
POWER0]),
> >     +                       mc->dev[peripheral_index].power_bit,
> >     +                       qdev_get_gpio_in(dev, 0));
> >     +}
> >     +
> >     +static void atmega_realize(DeviceState *dev, Error **errp)
> >     +{
> >     +    AtmegaMcuState *s =3D ATMEGA_MCU(dev);
> >     +    const AtmegaMcuClass *mc =3D ATMEGA_MCU_GET_CLASS(dev);
> >     +    DeviceState *cpudev;
> >     +    SysBusDevice *sbd;
> >     +    Error *err =3D NULL;
> >     +    char *devname;
> >     +    size_t i;
> >     +
> >     +    assert(mc->io_size <=3D 0x200);
> >     +
> >     +    if (!s->xtal_freq_hz) {
> >     +        error_setg(errp, "\"xtal-frequency-hz\" property must be
> >     provided.");
> >     +        return;
> >     +    }
> >     +
> >     +    /* CPU */
> >     +    object_initialize_child(OBJECT(dev), "cpu", &s->cpu,
> >     sizeof(s->cpu),
> >     +                            mc->cpu_type, &err, NULL);
> >     +    if (err) {
> >     +        error_propagate(errp, err);
> >     +        return;
> >     +    }
> >     +    object_property_set_bool(OBJECT(&s->cpu), true, "realized",
> >     &error_abort);
> >     +    cpudev =3D DEVICE(&s->cpu);
> >     +
> >     +    /* SRAM */
> >     +    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
> >     mc->sram_size,
> >     +                           &error_abort);
> >     +    memory_region_add_subregion(get_system_memory(),
> >     +                                OFFSET_DATA + mc->io_size,
&s->sram);
> >     +
> >     +    /* Flash */
> >     +    memory_region_init_rom(&s->flash, OBJECT(dev),
> >     +                           "flash", mc->flash_size, &error_fatal);
> >     +    memory_region_add_subregion(get_system_memory(), OFFSET_CODE,
> >     &s->flash);
> >     +
> >     +    /*
> >     +     * I/O
> >     +     *
> >     +     * 0x00 - 0x1f: Registers
> >     +     * 0x20 - 0x5f: I/O memory
> >     +     * 0x60 - 0xff: Extended I/O
> >     +     */
> >     +    s->io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
> >     +    qdev_prop_set_string(s->io, "name", "I/O");
> >     +    qdev_prop_set_uint64(s->io, "size", mc->io_size);
> >     +    qdev_init_nofail(s->io);
> >     +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA,
> >     -1234);
> >     +
> >     +    /* Power Reduction */
> >     +    for (i =3D 0; i < POWER_MAX; i++) {
> >     +        int idx =3D POWER(i);
> >     +        if (!mc->dev[idx].addr) {
> >     +            continue;
> >     +        }
> >     +        devname =3D g_strdup_printf("power%zu", i);
> >     +        object_initialize_child(OBJECT(dev), devname,
> >     +                                &s->pwr[i], sizeof(s->pwr[i]),
> >     +                                TYPE_AVR_MASK, &error_abort, NULL)=
;
> >     +        object_property_set_bool(OBJECT(&s->pwr[i]), true,
"realized",
> >     +                                 &error_abort);
> >     +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0,
> >     +                        OFFSET_DATA + mc->dev[idx].addr);
> >     +        g_free(devname);
> >     +    }
> >     +
> >     +    /* GPIO */
> >     +    for (i =3D 0; i < GPIO_MAX; i++) {
> >     +        int idx =3D GPIO(i);
> >     +        if (!mc->dev[idx].addr) {
> >     +            continue;
> >     +        }
> >     +        devname =3D g_strdup_printf("avr-gpio-%c", 'a' + (char)i);
> >     +        create_unimplemented_device(devname,
> >     +                                    OFFSET_DATA +
> >     mc->dev[idx].addr, 3);
> >     +        g_free(devname);
> >     +    }
> >     +
> >     +    /* USART */
> >     +    for (i =3D 0; i < USART_MAX; i++) {
> >     +        int idx =3D USART(i);
> >     +        if (!mc->dev[idx].addr) {
> >     +            continue;
> >     +        }
> >     +        devname =3D g_strdup_printf("usart%zu", i);
> >     +        object_initialize_child(OBJECT(dev), devname,
> >     +                                &s->usart[i], sizeof(s->usart[i]),
> >     +                                TYPE_AVR_USART, &error_abort,
NULL);
> >     +        qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev",
> >     serial_hd(i));
> >     +        object_property_set_bool(OBJECT(&s->usart[i]), true,
> >     "realized",
> >     +                                 &error_abort);
> >     +        sbd =3D SYS_BUS_DEVICE(&s->usart[i]);
> >     +        sysbus_mmio_map(sbd, 0, OFFSET_DATA +
mc->dev[USART(i)].addr);
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 0,
USART_RXC_IRQ(i));
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 1,
USART_DRE_IRQ(i));
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 2,
USART_TXC_IRQ(i));
> >     +        connect_power_reduction_gpio(s, mc, DEVICE(&s->usart[i]),
idx);
> >     +        g_free(devname);
> >     +    }
> >     +
> >     +    /* Timer */
> >     +    for (i =3D 0; i < TIMER_MAX; i++) {
> >     +        int idx =3D TIMER(i);
> >     +        if (!mc->dev[idx].addr) {
> >     +            continue;
> >     +        }
> >     +        if (!mc->dev[idx].is_timer16) {
> >     +            create_unimplemented_device("avr-timer8",
> >     +                                        OFFSET_DATA +
> >     mc->dev[idx].addr, 5);
> >     +            create_unimplemented_device("avr-timer8-intmask",
> >     +                                        OFFSET_DATA
> >     +                                        +
> >     mc->dev[idx].intmask_addr, 1);
> >     +            create_unimplemented_device("avr-timer8-intflag",
> >     +                                        OFFSET_DATA
> >     +                                        +
> >     mc->dev[idx].intflag_addr, 1);
> >     +            continue;
> >     +        }
> >     +        devname =3D g_strdup_printf("timer%zu", i);
> >     +        object_initialize_child(OBJECT(dev), devname,
> >     +                                &s->timer[i], sizeof(s->timer[i]),
> >     +                                TYPE_AVR_TIMER16, &error_abort,
NULL);
> >     +        object_property_set_uint(OBJECT(&s->timer[i]),
s->xtal_freq_hz,
> >     +                                 "cpu-frequency-hz", &error_abort)=
;
> >     +        object_property_set_bool(OBJECT(&s->timer[i]), true,
> >     "realized",
> >     +                                 &error_abort);
> >     +        sbd =3D SYS_BUS_DEVICE(&s->timer[i]);
> >     +        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
> >     +        sysbus_mmio_map(sbd, 1, OFFSET_DATA +
> >     mc->dev[idx].intmask_addr);
> >     +        sysbus_mmio_map(sbd, 2, OFFSET_DATA +
> >     mc->dev[idx].intflag_addr);
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 0,
TIMER_CAPT_IRQ(i));
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 1,
TIMER_COMPA_IRQ(i));
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 2,
TIMER_COMPB_IRQ(i));
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 3,
TIMER_COMPC_IRQ(i));
> >     +        connect_peripheral_irq(mc, sbd, cpudev, 4,
TIMER_OVF_IRQ(i));
> >     +        connect_power_reduction_gpio(s, mc, DEVICE(&s->timer[i]),
idx);
> >     +        g_free(devname);
> >     +    }
> >     +
> >     +    create_unimplemented_device("avr-twi",          OFFSET_DATA +
> >     0x0b8, 6);
> >     +    create_unimplemented_device("avr-adc",          OFFSET_DATA +
> >     0x078, 8);
> >     +    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA +
> >     0x074, 2);
> >     +    create_unimplemented_device("avr-watchdog",     OFFSET_DATA +
> >     0x060, 1);
> >     +    create_unimplemented_device("avr-spi",          OFFSET_DATA +
> >     0x04c, 3);
> >     +    create_unimplemented_device("avr-eeprom",       OFFSET_DATA +
> >     0x03f, 3);
> >     +}
> >     +
> >     +static Property atmega_props[] =3D {
> >     +    DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
> >     +                       xtal_freq_hz, 0),
> >     +    DEFINE_PROP_END_OF_LIST()
> >     +};
> >     +
> >     +static void atmega_class_init(ObjectClass *oc, void *data)
> >     +{
> >     +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> >     +
> >     +    dc->realize =3D atmega_realize;
> >     +    dc->props =3D atmega_props;
> >     +    /* Reason: Mapped at fixed location on the system bus */
> >     +    dc->user_creatable =3D false;
> >     +}
> >     +
> >     +static void atmega168_class_init(ObjectClass *oc, void *data)
> >     +{
> >     +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> >     +
> >     +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
> >     +    amc->flash_size =3D 16 * KiB;
> >     +    amc->eeprom_size =3D 512;
> >     +    amc->sram_size =3D 1 * KiB;
> >     +    amc->io_size =3D 256;
> >     +    amc->gpio_count =3D 23;
> >     +    amc->adc_count =3D 6;
> >     +    amc->irq =3D irq168_328;
> >     +    amc->dev =3D dev168_328;
> >     +};
> >     +
> >     +static void atmega328_class_init(ObjectClass *oc, void *data)
> >     +{
> >     +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> >     +
> >     +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
> >     +    amc->flash_size =3D 32 * KiB;
> >     +    amc->eeprom_size =3D 1 * KiB;
> >     +    amc->sram_size =3D 2 * KiB;
> >     +    amc->io_size =3D 256;
> >     +    amc->gpio_count =3D 23;
> >     +    amc->adc_count =3D 6;
> >     +    amc->irq =3D irq168_328;
> >     +    amc->dev =3D dev168_328;
> >     +};
> >     +
> >     +static void atmega1280_class_init(ObjectClass *oc, void *data)
> >     +{
> >     +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> >     +
> >     +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
> >     +    amc->flash_size =3D 128 * KiB;
> >     +    amc->eeprom_size =3D 4 * KiB;
> >     +    amc->sram_size =3D 8 * KiB;
> >     +    amc->io_size =3D 512;
> >     +    amc->gpio_count =3D 86;
> >     +    amc->adc_count =3D 16;
> >     +    amc->irq =3D irq1280_2560;
> >     +    amc->dev =3D dev1280_2560;
> >     +};
> >     +
> >     +static void atmega2560_class_init(ObjectClass *oc, void *data)
> >     +{
> >     +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> >     +
> >     +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
> >     +    amc->flash_size =3D 256 * KiB;
> >     +    amc->eeprom_size =3D 4 * KiB;
> >     +    amc->sram_size =3D 8 * KiB;
> >     +    amc->io_size =3D 512;
> >     +    amc->gpio_count =3D 54;
> >     +    amc->adc_count =3D 16;
> >     +    amc->irq =3D irq1280_2560;
> >     +    amc->dev =3D dev1280_2560;
> >     +};
> >     +
> >     +static const TypeInfo atmega_mcu_types[] =3D {
> >     +    {
> >     +        .name           =3D TYPE_ATMEGA168_MCU,
> >     +        .parent         =3D TYPE_ATMEGA_MCU,
> >     +        .class_init     =3D atmega168_class_init,
> >     +    }, {
> >     +        .name           =3D TYPE_ATMEGA328_MCU,
> >     +        .parent         =3D TYPE_ATMEGA_MCU,
> >     +        .class_init     =3D atmega328_class_init,
> >     +    }, {
> >     +        .name           =3D TYPE_ATMEGA1280_MCU,
> >     +        .parent         =3D TYPE_ATMEGA_MCU,
> >     +        .class_init     =3D atmega1280_class_init,
> >     +    }, {
> >     +        .name           =3D TYPE_ATMEGA2560_MCU,
> >     +        .parent         =3D TYPE_ATMEGA_MCU,
> >     +        .class_init     =3D atmega2560_class_init,
> >     +    }, {
> >     +        .name           =3D TYPE_ATMEGA_MCU,
> >     +        .parent         =3D TYPE_SYS_BUS_DEVICE,
> >     +        .instance_size  =3D sizeof(AtmegaMcuState),
> >     +        .class_size     =3D sizeof(AtmegaMcuClass),
> >     +        .class_init     =3D atmega_class_init,
> >     +        .abstract       =3D true,
> >     +    }
> >     +};
> >     +
> >     +DEFINE_TYPES(atmega_mcu_types)
> >     diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> >     new file mode 100644
> >     index 0000000000..da3b10afec
> >     --- /dev/null
> >     +++ b/hw/avr/Kconfig
> >     @@ -0,0 +1,5 @@
> >     +config ATMEL_ATMEGA_MCU
> >     +    bool
> >     +    select ATMEL_TIMER16
> >     +    select ATMEL_USART
> >     +    select ATMEL_POWER
> >     diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> >     index 123f174f0e..1f73fd5469 100644
> >     --- a/hw/avr/Makefile.objs
> >     +++ b/hw/avr/Makefile.objs
> >     @@ -1 +1,2 @@
> >       obj-y +=3D boot.o
> >     +obj-$(CONFIG_ATMEL_ATMEGA_MCU) +=3D atmel_atmega.o
> >     --
> >     2.21.1
> >
>

--00000000000099826b059d1a8eaa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPjwvcD4NCjxwIGRpcj0ibHRyIj4wODo1OSBQb24sIDI3LjAxLjIwMjAuIFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5j
b20iPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDsg0ZjQtSDQvdCw0L/QuNGB0LDQvi/Qu9CwOjxi
cj4NCiZndDs8YnI+DQomZ3Q7IE9uIDEvMjYvMjAgMzo0NiBQTSwgQWxla3NhbmRhciBNYXJrb3Zp
YyB3cm90ZTo8YnI+DQomZ3Q7ICZndDsgT24gRnJpZGF5LCBKYW51YXJ5IDI0LCAyMDIwLCBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmY0YnVnQGFtc2F0Lm9yZyI+
ZjRidWdAYW1zYXQub3JnPC9hPiA8YnI+DQomZ3Q7ICZndDsgJmx0O21haWx0bzo8YSBocmVmPSJt
YWlsdG86ZjRidWdAYW1zYXQub3JnIj5mNGJ1Z0BhbXNhdC5vcmc8L2E+Jmd0OyZndDsgd3JvdGU6
PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgQWRkIHNvbWUgbWljcm9jb250
cm9sbGVycyBmcm9tIHRoZSBtZWdhQVZSIGZhbWlseSAoQVRtZWdhIHNlcmllcyk6PGJyPg0KJmd0
OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgLSBtaWRkbGUgcmFuZ2U6IEFUbWVnYTE2OCBh
bmQgQVRtZWdhMzI4PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAtIGhpZ2ggcmFuZ2U6IEFUbWVnYTEy
ODAgYW5kIEFUbWVnYTI1NjA8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBG
b3IgcHJvZHVjdCBjb21wYXJpc29uOjxicj4NCiZndDsgJmd0O8KgIMKgIMKgPGEgaHJlZj0iaHR0
cHM6Ly93d3cubWljcm9jaGlwLmNvbS93d3dwcm9kdWN0cy9Qcm9kdWN0Q29tcGFyZS9BVG1lZ2Ex
NjhQL0FUbWVnYTMyOFAiPmh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vd3d3cHJvZHVjdHMvUHJv
ZHVjdENvbXBhcmUvQVRtZWdhMTY4UC9BVG1lZ2EzMjhQPC9hPjxicj4NCiZndDsgJmd0O8KgIMKg
IMKgJmx0OzxhIGhyZWY9Imh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vd3d3cHJvZHVjdHMvUHJv
ZHVjdENvbXBhcmUvQVRtZWdhMTY4UC9BVG1lZ2EzMjhQIj5odHRwczovL3d3dy5taWNyb2NoaXAu
Y29tL3d3d3Byb2R1Y3RzL1Byb2R1Y3RDb21wYXJlL0FUbWVnYTE2OFAvQVRtZWdhMzI4UDwvYT4m
Z3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqA8YSBocmVmPSJodHRwczovL3d3dy5taWNyb2NoaXAu
Y29tL3d3d3Byb2R1Y3RzL1Byb2R1Y3RDb21wYXJlL0FUbWVnYTEyODAvQVRtZWdhMjU2MCI+aHR0
cHM6Ly93d3cubWljcm9jaGlwLmNvbS93d3dwcm9kdWN0cy9Qcm9kdWN0Q29tcGFyZS9BVG1lZ2Ex
MjgwL0FUbWVnYTI1NjA8L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAmbHQ7PGEgaHJlZj0iaHR0
cHM6Ly93d3cubWljcm9jaGlwLmNvbS93d3dwcm9kdWN0cy9Qcm9kdWN0Q29tcGFyZS9BVG1lZ2Ex
MjgwL0FUbWVnYTI1NjAiPmh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vd3d3cHJvZHVjdHMvUHJv
ZHVjdENvbXBhcmUvQVRtZWdhMTI4MC9BVG1lZ2EyNTYwPC9hPiZndDs8YnI+DQomZ3Q7ICZndDsg
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBEYXRhc2hlZXRzOjxicj4NCiZndDsgJmd0O8KgIMKgIMKg
PGEgaHJlZj0iaHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2Mv
QVRtZWdhNDhBLVBBLTg4QS1QQS0xNjhBLVBBLTMyOC1QLURTLURTNDAwMDIwNjFBLnBkZiI+aHR0
cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQVRtZWdhNDhBLVBB
LTg4QS1QQS0xNjhBLVBBLTMyOC1QLURTLURTNDAwMDIwNjFBLnBkZjwvYT48YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCZsdDs8YSBocmVmPSJodHRwOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRz
L2VuL0RldmljZURvYy9BVG1lZ2E0OEEtUEEtODhBLVBBLTE2OEEtUEEtMzI4LVAtRFMtRFM0MDAw
MjA2MUEucGRmIj5odHRwOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2VuL0RldmljZURv
Yy9BVG1lZ2E0OEEtUEEtODhBLVBBLTE2OEEtUEEtMzI4LVAtRFMtRFM0MDAwMjA2MUEucGRmPC9h
PiZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoDxhIGhyZWY9Imh0dHA6Ly93dzEubWljcm9jaGlw
LmNvbS9kb3dubG9hZHMvZW4vRGV2aWNlRG9jL0F0bWVsLTI1NDktOC1iaXQtQVZSLU1pY3JvY29u
dHJvbGxlci1BVG1lZ2E2NDAtMTI4MC0xMjgxLTI1NjAtMjU2MV9kYXRhc2hlZXQucGRmIj5odHRw
Oi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2VuL0RldmljZURvYy9BdG1lbC0yNTQ5LTgt
Yml0LUFWUi1NaWNyb2NvbnRyb2xsZXItQVRtZWdhNjQwLTEyODAtMTI4MS0yNTYwLTI1NjFfZGF0
YXNoZWV0LnBkZjwvYT48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCZsdDs8YSBocmVmPSJodHRwOi8v
d3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2VuL0RldmljZURvYy9BdG1lbC0yNTQ5LTgtYml0
LUFWUi1NaWNyb2NvbnRyb2xsZXItQVRtZWdhNjQwLTEyODAtMTI4MS0yNTYwLTI1NjFfZGF0YXNo
ZWV0LnBkZiI+aHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2Mv
QXRtZWwtMjU0OS04LWJpdC1BVlItTWljcm9jb250cm9sbGVyLUFUbWVnYTY0MC0xMjgwLTEyODEt
MjU2MC0yNTYxX2RhdGFzaGVldC5wZGY8L2E+Jmd0Ozxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8
YSBocmVmPSJtYWlsdG86ZjRidWdAYW1zYXQub3JnIj5mNGJ1Z0BhbXNhdC5vcmc8L2E+PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpmNGJ1Z0BhbXNhdC5v
cmciPmY0YnVnQGFtc2F0Lm9yZzwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgTWVz
c2FnZS1JZDogJmx0OzxhIGhyZWY9Im1haWx0bzoyMDIwMDEyMDIyMDEwNy4xNzgyNS0xNC1mNGJ1
Z0BhbXNhdC5vcmciPjIwMjAwMTIwMjIwMTA3LjE3ODI1LTE0LWY0YnVnQGFtc2F0Lm9yZzwvYT48
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOjIwMjAwMTIw
MjIwMTA3LjE3ODI1LTE0LWY0YnVnQGFtc2F0Lm9yZyI+MjAyMDAxMjAyMjAxMDcuMTc4MjUtMTQt
ZjRidWdAYW1zYXQub3JnPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBTaWduZWQt
b2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmciPnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc8L2E+PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnIj5yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPC9hPiZndDsmZ3Q7
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAtLS08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoHJjMjo8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoC0gU3F1YXNoZWQgS2NvbmZpZyBwYXRjaCAoVGhvbWFzKTxicj4N
CiZndDsgJmd0O8KgIMKgIMKgLSBDb3JyZWN0IFNSQU0gYmFzZSBhZGRyZXNzPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAtLS08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGh3L2F2ci9hdG1lbF9hdG1l
Z2EuaCB8wqAgNDggKysrKys8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGh3L2F2ci9hdG1lbF9h
dG1lZ2EuYyB8IDQ3MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoGh3L2F2ci9LY29uZmlnwqAgwqAgwqAgwqAgfMKgIMKg
NSArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBody9hdnIvTWFrZWZpbGUub2Jqc8KgIHzCoCDC
oDEgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgNCBmaWxlcyBjaGFuZ2VkLCA1MjQgaW5zZXJ0
aW9ucygrKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2F2
ci9hdG1lbF9hdG1lZ2EuaDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2F2ci9hdG1lbF9hdG1lZ2EuYzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2F2ci9LY29uZmlnPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0
OyA8YnI+DQomZ3Q7ICZndDsgVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgdGVybWlub2xvZ3kgY29u
ZnVzaW9uIHRoYXQgd2lsbCBiZSBkaWZmaWN1bHQgdG8gPGJyPg0KJmd0OyAmZ3Q7IGVsaW1pbmF0
ZSBvbmNlIHRoZSBjb2RlIGlzIGluIHRoZSB0cmVlLjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7
ICZndDsgJnF1b3Q7QVZSJnF1b3Q7IGlzIHRoZSBuYW1lIChvciwgaWYgc29tZW9uZSB3aXNoZXMs
IHRoZSBjb21tb24gbmFtZSBwcmVmaXgpIG9mIHRoZSA8YnI+DQomZ3Q7ICZndDsgZmFtaWx5IG9m
IGFsbCBNQ1VzIGNvdmVyZWQgaW4gdGhpcyBzZXJpZXMuIFRoaXMgaXMgcmVmbGVjdGVkIGluIHRo
ZSA8YnI+DQomZ3Q7ICZndDsgZXhpc3RlbmNlIG9mIHRoZSBkaXJlY3RvcnkgJnF1b3Q7aHcvYXZy
JnF1b3Q7LCBhbmQgdGhpcyBpcywgaW4gbXkgb3BpbmlvbiBmaW5lLjxicj4NCiZndDsgJmd0OyA8
YnI+DQomZ3Q7ICZndDsgJnF1b3Q7QXRtZWwmcXVvdDsgaXMgdGhlIGNvbXBhbnkgdGhhdCB1c2Vk
IHRvIGRlc2lnbiBBVlIgTUNVcyAodGhlcmUgYXJlIGh1bmRyZWRzIDxicj4NCiZndDsgJmd0OyBv
ZiBzdWNoIE1DVXMpLiAmcXVvdDtBdG1lbCZxdW90OyB3YXMgYWNxdWlyZWQgc2V2ZXJhbMKgeWVh
cnMgYWdvIGJ5IGFub3RoZXIgPGJyPg0KJmd0OyAmZ3Q7IGNvbXBhbnksICZxdW90O01pY3JvY2hp
cCZxdW90Oy4gVHJlcmUgaXMgbm8gZWxlbWVudCBpbiBBVlIgTUNVcyYjMzk7IGRvY2ltZW50YXRp
b24gPGJyPg0KJmd0OyAmZ3Q7IHRoYXQgcmVmZmVycyB0byB0aGUgcHJvZHVjZXJzIChleGNlcHQg
dGl0bGUsIGNvcHlyaWdodCwgZXRjKS4gSW4gYWxsIDxicj4NCiZndDsgJmd0OyByZWNlbnQgZG9j
cywgJnF1b3Q7QXRtZWwmcXVvdDsgaXMgY29tcGxlbHkgZXJhZGljYXRlZC48YnI+DQomZ3Q7ICZn
dDsgPGJyPg0KJmd0OyAmZ3Q7IFRoZXJlZm9yZSwgdXNpbmcgdGhlIG5hbWUgb2Ygbm9uLWV4aXN0
YW50IGNvbXBhbnkgJnF1b3Q7QXRtZWwmcXVvdDsgaXMgY29uZnVzaW5nLCA8YnI+DQomZ3Q7ICZn
dDsgYW5kLCBtb3Jlb3ZlciwgY29tcGxldGVseSB1bm5lY2Vzc2FyeS4gUGxlYXNlLCByZW1vdmUg
cmVmZXJlbmNlcyB0byA8YnI+DQomZ3Q7ICZndDsgJnF1b3Q7QXRtZWwmcXVvdDsgZnJvbSBmaWxl
IG5hbWVzLCBhbmQgZnJvbSB0aGUgY29kZS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBJIHNpbXBseSB1
c2VkICZxdW90O0F0bWVsJnF1b3Q7IGJlY2F1c2UgdGhpcyBpcyBob3cgSSBkaXNjb3ZlcmVkIHRo
aXMgY2hpcHMgYW5kIDxicj4NCiZndDsgYWx3YXlzIGNhbGxlZCB0aGVtIGJ5IHRoZSBBdG1lbCBi
cmFuZC48L3A+DQo8cCBkaXI9Imx0ciI+VGhhdCBpcyB1bmRlcnN0YW5kYWJsZS48L3A+DQo8cCBk
aXI9Imx0ciI+Jmd0OyBUaGUgTWljcm9jaGlwIGFjcXVpc2l0aW9uIGlzIDxicj4NCiZndDsgcXVp
dGUgcmVjZW50LiBXaGVuIEkgbG9vayBmb3IgZGF0YXNoZWV0IGlzIEkgc3RpbGwgd3JpdGUgJnF1
b3Q7QXRtZWwgPGJyPg0KJmd0OyBzb21ldGhpbmcmcXVvdDsgYW5kIGV2ZW50dWFsbHkgZW5kIG9u
IHRoZSBtaWNyb2NoaXAgd2Vic2l0ZS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBJT1cgaXQgd2FzIG5v
dCBhIGRlbGliZXJhdGUgbmFtZSwgc2ltcGx5IE1pY3JvY2hpcCBjb3VsZCBub3QgZXJhZGljYXRl
IDxicj4NCiZndDsgJnF1b3Q7QXRtZWwmcXVvdDsgZnJvbSBteSBtZW1vcnkgPSk8YnI+DQomZ3Q7
PGJyPg0KJmd0OyBJJiMzOTtsbCByZW5hbWUgdGhlc2UgZmlsZXMgYXQgJnF1b3Q7YXRtZWdhLntj
LGh9JnF1b3Q7Ljxicj4NCiZndDs8L3A+DQo8cCBkaXI9Imx0ciI+VGhhbmtzLiBJdCBpcyBpbXBv
cnRhbnQgdGhhdCB3ZSBnZXQgdGhlIG5hbWluZyByaWdodCBmcm9tIHRoZSBvdXRzZXQuPC9wPg0K
PHAgZGlyPSJsdHIiPiZndDsgVGhhbmtzLDxicj4NCiZndDs8YnI+DQomZ3Q7IFBoaWwuPGJyPg0K
Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgZGlmZiAtLWdpdCBhL2h3L2F2ci9hdG1lbF9hdG1l
Z2EuaCBiL2h3L2F2ci9hdG1lbF9hdG1lZ2EuaDxicj4NCiZndDsgJmd0O8KgIMKgIMKgbmV3IGZp
bGUgbW9kZSAxMDA2NDQ8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoGluZGV4IDAwMDAwMDAwMDAuLjM5
MWI4YjFiZjg8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoC0tLSAvZGV2L251bGw8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCsrKyBiL2h3L2F2ci9hdG1lbF9hdG1lZ2EuaDxicj4NCiZndDsgJmd0O8KgIMKg
IMKgQEAgLTAsMCArMSw0OCBAQDxicj4NCiZndDsgJmd0O8KgIMKgIMKgKy8qPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArICogUUVNVSBBVG1lZ2EgTUNVPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArICo8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsgKiBDb3B5cmlnaHQgKGMpIDIwMTkgUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6k8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsgKjxicj4NCiZndDsgJmd0O8KgIMKg
IMKgKyAqIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
UEx2MiBvciBsYXRlci48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsgKiBTZWUgdGhlIENPUFlJTkcg
ZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsg
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcjxicj4NCiZndDsgJmd0
O8KgIMKgIMKgKyAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgKyNpZm5kZWYgSFdfQVZSX0FUTUVMX0FUTUVHQV9IPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAr
I2RlZmluZSBIV19BVlJfQVRNRUxfQVRNRUdBX0g8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtody9jaGFyL2F0bWVsX3VzYXJ0Lmgm
cXVvdDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtody90aW1lci9hdG1l
bF90aW1lcjE2LmgmcXVvdDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDto
dy9taXNjL2F0bWVsX3Bvd2VyLmgmcXVvdDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVk
ZSAmcXVvdDt0YXJnZXQvYXZyL2NwdS5oJnF1b3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBUWVBFX0FUTUVHQV9NQ1XCoCDCoCDCoCZxdW90
O0FUbWVnYSZxdW90Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVFlQRV9BVE1FR0Ex
NjhfTUNVwqAgJnF1b3Q7QVRtZWdhMTY4JnF1b3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2Rl
ZmluZSBUWVBFX0FUTUVHQTMyOF9NQ1XCoCAmcXVvdDtBVG1lZ2EzMjgmcXVvdDs8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCsjZGVmaW5lIFRZUEVfQVRNRUdBMTI4MF9NQ1UgJnF1b3Q7QVRtZWdhMTI4
MCZxdW90Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVFlQRV9BVE1FR0EyNTYwX01D
VSAmcXVvdDtBVG1lZ2EyNTYwJnF1b3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBBVE1FR0FfTUNVKG9iaikgT0JKRUNUX0NIRUNLKEF0bWVn
YU1jdVN0YXRlLCAob2JqKSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoFRZUEVfQVRNRUdBX01DVSk8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjZGVmaW5lIFBP
V0VSX01BWCAyPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBVU0FSVF9NQVggNDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVElNRVJfTUFYIDY8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCsjZGVmaW5lIEdQSU9fTUFYIDEyPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArdHlwZWRlZiBzdHJ1Y3QgQXRtZWdhTWN1U3RhdGUgezxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIC8qJmx0OyBwcml2YXRlICZndDsqLzxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK8KgIMKgIFN5c0J1c0RldmljZSBwYXJlbnRfb2JqOzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgK8KgIMKgIC8qJmx0OyBwdWJsaWMgJmd0OyovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgQVZSQ1BVIGNwdTs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCBNZW1vcnlSZWdpb24gZmxhc2g7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAg
wqAgTWVtb3J5UmVnaW9uIGVlcHJvbTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBNZW1v
cnlSZWdpb24gc3JhbTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBEZXZpY2VTdGF0ZSAq
aW87PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgQVZSTWFza1N0YXRlIHB3cltQT1dFUl9N
QVhdOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIEFWUlVzYXJ0U3RhdGUgdXNhcnRbVVNB
UlRfTUFYXTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBBVlJUaW1lcjE2U3RhdGUgdGlt
ZXJbVElNRVJfTUFYXTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCB1aW50NjRfdCB4dGFs
X2ZyZXFfaHo7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArfSBBdG1lZ2FNY3VTdGF0ZTs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjZW5kaWYgLyogSFdfQVZS
X0FUTUVMX0FUTUVHQV9IICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEvaHcv
YXZyL2F0bWVsX2F0bWVnYS5jIGIvaHcvYXZyL2F0bWVsX2F0bWVnYS5jPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqBuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCiZndDsgJmd0O8KgIMKgIMKgaW5kZXgg
MDAwMDAwMDAwMC4uNzkwYzM3NGRlZTxicj4NCiZndDsgJmd0O8KgIMKgIMKgLS0tIC9kZXYvbnVs
bDxicj4NCiZndDsgJmd0O8KgIMKgIMKgKysrIGIvaHcvYXZyL2F0bWVsX2F0bWVnYS5jPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqBAQCAtMCwwICsxLDQ3MCBAQDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
Ky8qPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArICogUUVNVSBBVG1lZ2EgTUNVPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArICo8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsgKiBDb3B5cmlnaHQgKGMpIDIw
MTkgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6k8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsgKjxicj4N
CiZndDsgJmd0O8KgIMKgIMKgKyAqIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBHUEx2MiBvciBsYXRlci48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsgKiBT
ZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS48YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cjxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O3FlbXUvb3NkZXAuaCZxdW90Ozxicj4N
CiZndDsgJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O3FlbXUvbW9kdWxlLmgmcXVvdDs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtxZW11L3VuaXRzLmgmcXVvdDs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtxYXBpL2Vycm9yLmgmcXVvdDs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtleGVjL21lbW9yeS5oJnF1b3Q7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7ZXhlYy9hZGRyZXNzLXNwYWNlcy5o
JnF1b3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7c3lzZW11L3N5c2Vt
dS5oJnF1b3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7aHcvcWRldi1w
cm9wZXJ0aWVzLmgmcXVvdDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDto
dy9zeXNidXMuaCZxdW90Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O2h3
L2JvYXJkcy5oJnF1b3Q7IC8qIEZJWE1FPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBtZW1vcnlfcmVn
aW9uX2FsbG9jYXRlX3N5c3RlbV9tZW1vcnkgZm9yIHNyYW0gKi88YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCsjaW5jbHVkZSAmcXVvdDtody9taXNjL3VuaW1wLmgmcXVvdDs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCsjaW5jbHVkZSAmcXVvdDthdG1lbF9hdG1lZ2EuaCZxdW90Ozxicj4NCiZndDsgJmd0
O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK2VudW0gQXRtZWdhUGVyaXBoZXJhbCB7
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgUE9XRVIwLCBQT1dFUjEsPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgR1BJT0EsIEdQSU9CLCBHUElPQywgR1BJT0QsIEdQSU9FLCBHUElP
Riw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBHUElPRywgR1BJT0gsIEdQSU9JLCBHUElP
SiwgR1BJT0ssIEdQSU9MLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFVTQVJUMCwgVVNB
UlQxLCBVU0FSVDIsIFVTQVJUMyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBUSU1FUjAs
IFRJTUVSMSwgVElNRVIyLCBUSU1FUjMsIFRJTUVSNCwgVElNRVI1LDxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK8KgIMKgIFBFUklGTUFYPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArfTs8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjZGVmaW5lIEdQSU8obinCoCDC
oCDCoChuICsgR1BJT0EpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBVU0FSVChuKcKg
IMKgIChuICsgVVNBUlQwKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVElNRVIobinC
oCDCoCAobiArIFRJTUVSMCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjZGVmaW5lIFBPV0VSKG4p
wqAgwqAgKG4gKyBQT1dFUjApPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArdHlwZWRlZiBzdHJ1Y3Qgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHVp
bnQxNl90IGFkZHI7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgZW51bSBBdG1lZ2FQZXJp
cGhlcmFsIHBvd2VyX2luZGV4Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQ4X3Qg
cG93ZXJfYml0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIC8qIHRpbWVyIHNwZWNpZmlj
ICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgdWludDE2X3QgaW50bWFza19hZGRyOzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQxNl90IGludGZsYWdfYWRkcjs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBib29sIGlzX3RpbWVyMTY7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArfSBwZXJpcGhlcmFsX2NmZzs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCt0eXBlZGVmIHN0cnVjdCBBdG1lZ2FNY3VDbGFzcyB7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgLyombHQ7IHByaXZhdGUgJmd0OyovPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArwqAgwqAgU3lzQnVzRGV2aWNlQ2xhc3MgcGFyZW50X2NsYXNzOzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIC8qJmx0OyBwdWJsaWMgJmd0OyovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgY29uc3QgY2hhciAqdWNfbmFtZTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCBjb25zdCBjaGFyICpjcHVfdHlwZTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBzaXpl
X3QgZmxhc2hfc2l6ZTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBzaXplX3QgZWVwcm9t
X3NpemU7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgc2l6ZV90IHNyYW1fc2l6ZTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBzaXplX3QgaW9fc2l6ZTs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCBzaXplX3QgZ3Bpb19jb3VudDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvC
oCDCoCBzaXplX3QgYWRjX2NvdW50Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGNvbnN0
IHVpbnQ4X3QgKmlycTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBjb25zdCBwZXJpcGhl
cmFsX2NmZyAqZGV2Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK30gQXRtZWdhTWN1Q2xhc3M7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBBVE1F
R0FfTUNVX0NMQVNTKGtsYXNzKSBcPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgT0JKRUNU
X0NMQVNTX0NIRUNLKEF0bWVnYU1jdUNsYXNzLCAoa2xhc3MpLCBUWVBFX0FUTUVHQV9NQ1UpPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBBVE1FR0FfTUNVX0dFVF9DTEFTUyhvYmopIFw8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBPQkpFQ1RfR0VUX0NMQVNTKEF0bWVnYU1jdUNs
YXNzLCAob2JqKSwgVFlQRV9BVE1FR0FfTUNVKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK3N0YXRpYyBjb25zdCBwZXJpcGhlcmFsX2NmZyBkZXYxNjhfMzI4
W1BFUklGTUFYXSA9IHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVVNBUlQwXcKgIMKg
IMKgIMKgID0ge8KgIDB4YzAsIFBPV0VSMCwgMSB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIFtUSU1FUjJdwqAgwqAgwqAgwqAgPSB7wqAgMHhiMCwgUE9XRVIwLCA2LCAweDcwLCAweDM3
LCBmYWxzZSB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjFdwqAgwqAgwqAg
wqAgPSB7wqAgMHg4MCwgUE9XRVIwLCAzLCAweDZmLCAweDM2LCB0cnVlIH0sPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgW1BPV0VSMF3CoCDCoCDCoCDCoCA9IHvCoCAweDY0IH0sPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSMF3CoCDCoCDCoCDCoCA9IHvCoCAweDQ0LCBQ
T1dFUjAsIDUsIDB4NmUsIDB4MzUsIGZhbHNlIH0sPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAg
wqAgW0dQSU9EXcKgIMKgIMKgIMKgIMKgPSB7wqAgMHgyOSB9LDxicj4NCiZndDsgJmd0O8KgIMKg
IMKgK8KgIMKgIFtHUElPQ13CoCDCoCDCoCDCoCDCoD0ge8KgIDB4MjYgfSw8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCvCoCDCoCBbR1BJT0JdwqAgwqAgwqAgwqAgwqA9IHvCoCAweDIzIH0sPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArfSwgZGV2MTI4MF8yNTYwW1BFUklGTUFYXSA9IHs8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCvCoCDCoCBbVVNBUlQzXcKgIMKgIMKgIMKgID0geyAweDEzMCwgUE9XRVIx
LCAyIH0sPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSNV3CoCDCoCDCoCDCoCA9
IHsgMHgxMjAsIFBPV0VSMSwgNSwgMHg3MywgMHgzYSwgdHJ1ZSB9LDxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK8KgIMKgIFtHUElPTF3CoCDCoCDCoCDCoCDCoD0geyAweDEwOSB9LDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIFtHUElPS13CoCDCoCDCoCDCoCDCoD0geyAweDEwNiB9LDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtHUElPSl3CoCDCoCDCoCDCoCDCoD0geyAweDEwMyB9
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtHUElPSF3CoCDCoCDCoCDCoCDCoD0geyAw
eDEwMCB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDJdwqAgwqAgwqAgwqAg
PSB7wqAgMHhkMCwgUE9XRVIxLCAxIH0sPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1VT
QVJUMV3CoCDCoCDCoCDCoCA9IHvCoCAweGM4LCBQT1dFUjEsIDAgfSw8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCBbVVNBUlQwXcKgIMKgIMKgIMKgID0ge8KgIDB4YzAsIFBPV0VSMCwgMSB9
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjJdwqAgwqAgwqAgwqAgPSB7wqAg
MHhiMCwgUE9XRVIwLCA2LCAweDcwLCAweDM3LCBmYWxzZSB9LCAvKjxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgVE9ETyBhc3luYyAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjRd
wqAgwqAgwqAgwqAgPSB7wqAgMHhhMCwgUE9XRVIxLCA0LCAweDcyLCAweDM5LCB0cnVlIH0sPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSM13CoCDCoCDCoCDCoCA9IHvCoCAweDkw
LCBQT1dFUjEsIDMsIDB4NzEsIDB4MzgsIHRydWUgfSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvC
oCDCoCBbVElNRVIxXcKgIMKgIMKgIMKgID0ge8KgIDB4ODAsIFBPV0VSMCwgMywgMHg2ZiwgMHgz
NiwgdHJ1ZSB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtQT1dFUjFdwqAgwqAgwqAg
wqAgPSB7wqAgMHg2NSB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtQT1dFUjBdwqAg
wqAgwqAgwqAgPSB7wqAgMHg2NCB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1F
UjBdwqAgwqAgwqAgwqAgPSB7wqAgMHg0NCwgUE9XRVIwLCA1LCAweDZlLCAweDM1LCBmYWxzZSB9
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtHUElPR13CoCDCoCDCoCDCoCDCoD0ge8Kg
IDB4MzIgfSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbR1BJT0ZdwqAgwqAgwqAgwqAg
wqA9IHvCoCAweDJmIH0sPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW0dQSU9FXcKgIMKg
IMKgIMKgIMKgPSB7wqAgMHgyYyB9LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtHUElP
RF3CoCDCoCDCoCDCoCDCoD0ge8KgIDB4MjkgfSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCBbR1BJT0NdwqAgwqAgwqAgwqAgwqA9IHvCoCAweDI2IH0sPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgW0dQSU9CXcKgIMKgIMKgIMKgIMKgPSB7wqAgMHgyMyB9LDxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIFtHUElPQV3CoCDCoCDCoCDCoCDCoD0ge8KgIDB4MjAgfSw8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCt9Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK2VudW0gQXRtZWdhSXJxIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBV
U0FSVDBfUlhDX0lSUSwgVVNBUlQwX0RSRV9JUlEsIFVTQVJUMF9UWENfSVJRLDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIFVTQVJUMV9SWENfSVJRLCBVU0FSVDFfRFJFX0lSUSwgVVNBUlQx
X1RYQ19JUlEsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgVVNBUlQyX1JYQ19JUlEsIFVT
QVJUMl9EUkVfSVJRLCBVU0FSVDJfVFhDX0lSUSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCBVU0FSVDNfUlhDX0lSUSwgVVNBUlQzX0RSRV9JUlEsIFVTQVJUM19UWENfSVJRLDxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgK8KgIMKgIFRJTUVSMF9DQVBUX0lSUSwgVElNRVIwX0NPTVBBX0lSUSwg
VElNRVIwX0NPTVBCX0lSUSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBUSU1F
UjBfQ09NUENfSVJRLCBUSU1FUjBfT1ZGX0lSUSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCBUSU1FUjFfQ0FQVF9JUlEsIFRJTUVSMV9DT01QQV9JUlEsIFRJTUVSMV9DT01QQl9JUlEsPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVElNRVIxX0NPTVBDX0lSUSwgVElNRVIx
X09WRl9JUlEsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgVElNRVIyX0NBUFRfSVJRLCBU
SU1FUjJfQ09NUEFfSVJRLCBUSU1FUjJfQ09NUEJfSVJRLDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIFRJTUVSMl9DT01QQ19JUlEsIFRJTUVSMl9PVkZfSVJRLDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIFRJTUVSM19DQVBUX0lSUSwgVElNRVIzX0NPTVBBX0lSUSwgVElN
RVIzX0NPTVBCX0lSUSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBUSU1FUjNf
Q09NUENfSVJRLCBUSU1FUjNfT1ZGX0lSUSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBU
SU1FUjRfQ0FQVF9JUlEsIFRJTUVSNF9DT01QQV9JUlEsIFRJTUVSNF9DT01QQl9JUlEsPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVElNRVI0X0NPTVBDX0lSUSwgVElNRVI0X09W
Rl9JUlEsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgVElNRVI1X0NBUFRfSVJRLCBUSU1F
UjVfQ09NUEFfSVJRLCBUSU1FUjVfQ09NUEJfSVJRLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIFRJTUVSNV9DT01QQ19JUlEsIFRJTUVSNV9PVkZfSVJRLDxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIElSUV9DT1VOVDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK307PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2RlZmluZSBVU0FSVF9J
UlFfQ09VTlTCoCDCoCDCoDM8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjZGVmaW5lIFVTQVJUX1JY
Q19JUlEobinCoCDCoCAobiAqIFVTQVJUX0lSUV9DT1VOVCArIFVTQVJUMF9SWENfSVJRKTxicj4N
CiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVVNBUlRfRFJFX0lSUShuKcKgIMKgIChuICogVVNB
UlRfSVJRX0NPVU5UICsgVVNBUlQwX0RSRV9JUlEpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArI2Rl
ZmluZSBVU0FSVF9UWENfSVJRKG4pwqAgwqAgKG4gKiBVU0FSVF9JUlFfQ09VTlQgKyBVU0FSVDBf
VFhDX0lSUSk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCsjZGVmaW5lIFRJTUVSX0lSUV9DT1VOVMKg
IMKgIMKgNTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVElNRVJfQ0FQVF9JUlEobinC
oCDCoChuICogVElNRVJfSVJRX0NPVU5UICsgVElNRVIwX0NBUFRfSVJRKTxicj4NCiZndDsgJmd0
O8KgIMKgIMKgKyNkZWZpbmUgVElNRVJfQ09NUEFfSVJRKG4pwqAgKG4gKiBUSU1FUl9JUlFfQ09V
TlQgKyBUSU1FUjBfQ09NUEFfSVJRKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVElN
RVJfQ09NUEJfSVJRKG4pwqAgKG4gKiBUSU1FUl9JUlFfQ09VTlQgKyBUSU1FUjBfQ09NUEJfSVJR
KTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKyNkZWZpbmUgVElNRVJfQ09NUENfSVJRKG4pwqAgKG4g
KiBUSU1FUl9JUlFfQ09VTlQgKyBUSU1FUjBfQ09NUENfSVJRKTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgKyNkZWZpbmUgVElNRVJfT1ZGX0lSUShuKcKgIMKgIChuICogVElNRVJfSVJRX0NPVU5UICsg
VElNRVIwX09WRl9JUlEpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArc3RhdGljIGNvbnN0IHVpbnQ4X3QgaXJxMTY4XzMyOFtJUlFfQ09VTlRdID0gezxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjJfQ09NUEFfSVJRXcKgIMKgIMKgID0gOCw8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVElNRVIyX0NPTVBCX0lSUV3CoCDCoCDCoCA9
IDksPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSMl9PVkZfSVJRXcKgIMKgIMKg
IMKgID0gMTAsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSMV9DQVBUX0lSUV3C
oCDCoCDCoCDCoD0gMTEsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSMV9DT01Q
QV9JUlFdwqAgwqAgwqAgPSAxMiw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVElNRVIx
X0NPTVBCX0lSUV3CoCDCoCDCoCA9IDEzLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtU
SU1FUjFfT1ZGX0lSUV3CoCDCoCDCoCDCoCA9IDE0LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIFtUSU1FUjBfQ09NUEFfSVJRXcKgIMKgIMKgID0gMTUsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgW1RJTUVSMF9DT01QQl9JUlFdwqAgwqAgwqAgPSAxNiw8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCBbVElNRVIwX09WRl9JUlFdwqAgwqAgwqAgwqAgPSAxNyw8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCvCoCDCoCBbVVNBUlQwX1JYQ19JUlFdwqAgwqAgwqAgwqAgPSAxOSw8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVVNBUlQwX0RSRV9JUlFdwqAgwqAgwqAgwqAgPSAy
MCw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVVNBUlQwX1RYQ19JUlFdwqAgwqAgwqAg
wqAgPSAyMSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCt9LCBpcnExMjgwXzI1NjBbSVJRX0NPVU5U
XSA9IHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVElNRVIyX0NPTVBBX0lSUV3CoCDC
oCDCoCA9IDE0LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjJfQ09NUEJfSVJR
XcKgIMKgIMKgID0gMTUsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSMl9PVkZf
SVJRXcKgIMKgIMKgIMKgID0gMTYsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVS
MV9DQVBUX0lSUV3CoCDCoCDCoCDCoD0gMTcsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAg
W1RJTUVSMV9DT01QQV9JUlFdwqAgwqAgwqAgPSAxOCw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvC
oCDCoCBbVElNRVIxX0NPTVBCX0lSUV3CoCDCoCDCoCA9IDE5LDxicj4NCiZndDsgJmd0O8KgIMKg
IMKgK8KgIMKgIFtUSU1FUjFfQ09NUENfSVJRXcKgIMKgIMKgID0gMjAsPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArwqAgwqAgW1RJTUVSMV9PVkZfSVJRXcKgIMKgIMKgIMKgID0gMjEsPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSMF9DT01QQV9JUlFdwqAgwqAgwqAgPSAyMiw8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVElNRVIwX0NPTVBCX0lSUV3CoCDCoCDCoCA9IDIz
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjBfT1ZGX0lSUV3CoCDCoCDCoCDC
oCA9IDI0LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDBfUlhDX0lSUV3CoCDC
oCDCoCDCoCA9IDI2LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDBfRFJFX0lS
UV3CoCDCoCDCoCDCoCA9IDI3LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDBf
VFhDX0lSUV3CoCDCoCDCoCDCoCA9IDI4LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtU
SU1FUjNfQ0FQVF9JUlFdwqAgwqAgwqAgwqA9IDMyLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIFtUSU1FUjNfQ09NUEFfSVJRXcKgIMKgIMKgID0gMzMsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgW1RJTUVSM19DT01QQl9JUlFdwqAgwqAgwqAgPSAzNCw8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCBbVElNRVIzX0NPTVBDX0lSUV3CoCDCoCDCoCA9IDM1LDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjNfT1ZGX0lSUV3CoCDCoCDCoCDCoCA9IDM2LDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDFfUlhDX0lSUV3CoCDCoCDCoCDCoCA9IDM3
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDFfRFJFX0lSUV3CoCDCoCDCoCDC
oCA9IDM4LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDFfVFhDX0lSUV3CoCDC
oCDCoCDCoCA9IDM5LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjRfQ0FQVF9J
UlFdwqAgwqAgwqAgwqA9IDQyLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjRf
Q09NUEFfSVJRXcKgIMKgIMKgID0gNDMsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJ
TUVSNF9DT01QQl9JUlFdwqAgwqAgwqAgPSA0NCw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCBbVElNRVI0X0NPTVBDX0lSUV3CoCDCoCDCoCA9IDQ1LDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIFtUSU1FUjRfT1ZGX0lSUV3CoCDCoCDCoCDCoCA9IDQ2LDxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK8KgIMKgIFtUSU1FUjVfQ0FQVF9JUlFdwqAgwqAgwqAgwqA9IDQ3LDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjVfQ09NUEFfSVJRXcKgIMKgIMKgID0gNDgsPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgW1RJTUVSNV9DT01QQl9JUlFdwqAgwqAgwqAgPSA0OSw8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBbVElNRVI1X0NPTVBDX0lSUV3CoCDCoCDCoCA9
IDUwLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtUSU1FUjVfT1ZGX0lSUV3CoCDCoCDC
oCDCoCA9IDUxLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDJfUlhDX0lSUV3C
oCDCoCDCoCDCoCA9IDUyLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FSVDJfRFJF
X0lSUV3CoCDCoCDCoCDCoCA9IDUzLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIFtVU0FS
VDJfVFhDX0lSUV3CoCDCoCDCoCDCoCA9IDU0LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IFtVU0FSVDNfUlhDX0lSUV3CoCDCoCDCoCDCoCA9IDU1LDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIFtVU0FSVDNfRFJFX0lSUV3CoCDCoCDCoCDCoCA9IDU2LDxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK8KgIMKgIFtVU0FSVDNfVFhDX0lSUV3CoCDCoCDCoCDCoCA9IDU3LDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK307PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArc3RhdGljIHZvaWQgY29ubmVjdF9wZXJpcGhlcmFsX2lycShjb25zdCBBdG1lZ2FNY3VD
bGFzcyAqbWMsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBTeXNCdXNEZXZpY2UgKnNiZCw8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoERldmljZVN0YXRlICpkZXYsIGludCBuLDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW5z
aWduZWQgcGVyaXBoZXJhbF9pcnEpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArezxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIGludCBpcnEgPSBtYy0mZ3Q7aXJxW3BlcmlwaGVyYWxfaXJxXTs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBpZiAo
IWlycSkgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgLyog
RklYTUUgbW92ZSB0aGF0IHRvIGF2cl9jcHVfc2V0X2ludCgpIG9uY2UgJiMzOTtzYW1wbGUmIzM5
OyBib2FyZCBpczxicj4NCiZndDsgJmd0O8KgIMKgIMKgcmVtb3ZlZCAqLzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIGFzc2VydChpcnEgJmd0Oz0gMik7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgaXJxIC09IDI7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArwqAgwqAgc3lzYnVzX2Nvbm5lY3RfaXJxKHNiZCwgbiwgcWRldl9nZXRfZ3Bpb19p
bihkZXYsIGlycSkpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK308YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBjb25uZWN0X3Bvd2VyX3Jl
ZHVjdGlvbl9ncGlvKEF0bWVnYU1jdVN0YXRlICpzLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY29uc3QgQXRtZWdhTWN1Q2xhc3MgKm1jLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
RGV2aWNlU3RhdGUgKmRldiw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBwZXJpcGhl
cmFsX2luZGV4KTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCvCoCDCoCB1bnNpZ25lZCBwb3dlcl9pbmRleCA9IG1jLSZndDtkZXZbcGVyaXBoZXJhbF9pbmRl
eF0ucG93ZXJfaW5kZXg7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYXNzZXJ0KG1jLSZn
dDtkZXZbcG93ZXJfaW5kZXhdLmFkZHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHN5
c2J1c19jb25uZWN0X2lycShTWVNfQlVTX0RFVklDRSgmYW1wO3MtJmd0O3B3cltwb3dlcl9pbmRl
eCAtIFBPV0VSMF0pLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgbWMtJmd0O2RldltwZXJpcGhlcmFsX2luZGV4XS5wb3dlcl9iaXQsPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBx
ZGV2X2dldF9ncGlvX2luKGRldiwgMCkpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK308YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhdG1l
Z2FfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIEF0bWVnYU1jdVN0YXRlICpz
ID0gQVRNRUdBX01DVShkZXYpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGNvbnN0IEF0
bWVnYU1jdUNsYXNzICptYyA9IEFUTUVHQV9NQ1VfR0VUX0NMQVNTKGRldik7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgRGV2aWNlU3RhdGUgKmNwdWRldjs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCBTeXNCdXNEZXZpY2UgKnNiZDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCBFcnJvciAqZXJyID0gTlVMTDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBjaGFyICpk
ZXZuYW1lOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHNpemVfdCBpOzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFzc2VydChtYy0mZ3Q7
aW9fc2l6ZSAmbHQ7PSAweDIwMCk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgaWYgKCFzLSZndDt4dGFsX2ZyZXFfaHopIHs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBlcnJvcl9zZXRnKGVycnAsICZxdW90O1wmcXVvdDt4dGFs
LWZyZXF1ZW5jeS1oelwmcXVvdDsgcHJvcGVydHkgbXVzdCBiZTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgcHJvdmlkZWQuJnF1b3Q7KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBy
ZXR1cm47PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIC8qIENQVSAqLzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChkZXYpLCAmcXVv
dDtjcHUmcXVvdDssICZhbXA7cy0mZ3Q7Y3B1LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgc2l6ZW9m
KHMtJmd0O2NwdSksPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgbWMtJmd0O2NwdV90eXBlLCAmYW1wO2VyciwgTlVMTCk7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKGVycikgezxicj4NCiZndDsgJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBlcnIpOzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29s
KE9CSkVDVCgmYW1wO3MtJmd0O2NwdSksIHRydWUsICZxdW90O3JlYWxpemVkJnF1b3Q7LDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgJmFtcDtlcnJvcl9hYm9ydCk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgY3B1ZGV2ID0gREVWSUNFKCZhbXA7cy0mZ3Q7Y3B1KTs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCAvKiBTUkFNICovPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArwqAgwqAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmYW1wO3MtJmd0O3Ny
YW0sIE9CSkVDVChkZXYpLCAmcXVvdDtzcmFtJnF1b3Q7LDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
bWMtJmd0O3NyYW1fc2l6ZSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZXJyb3JfYWJvcnQpOzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihnZXRfc3lzdGVtX21l
bW9yeSgpLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9GRlNFVF9EQVRBICsgbWMtJmd0O2lvX3NpemUsICZhbXA7
cy0mZ3Q7c3JhbSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgLyogRmxhc2ggKi88YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBtZW1vcnlf
cmVnaW9uX2luaXRfcm9tKCZhbXA7cy0mZ3Q7Zmxhc2gsIE9CSkVDVChkZXYpLDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1
b3Q7Zmxhc2gmcXVvdDssIG1jLSZndDtmbGFzaF9zaXplLCAmYW1wO2Vycm9yX2ZhdGFsKTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oZ2V0
X3N5c3RlbV9tZW1vcnkoKSwgT0ZGU0VUX0NPREUsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAmYW1w
O3MtJmd0O2ZsYXNoKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCAvKjxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgKiBJL088YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCo8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDC
oCogMHgwMCAtIDB4MWY6IFJlZ2lzdGVyczxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKg
KiAweDIwIC0gMHg1ZjogSS9PIG1lbW9yeTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKg
KiAweDYwIC0gMHhmZjogRXh0ZW5kZWQgSS9PPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAg
wqAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2lvID0gcWRldl9jcmVhdGUo
TlVMTCwgVFlQRV9VTklNUExFTUVOVEVEX0RFVklDRSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAr
wqAgwqAgcWRldl9wcm9wX3NldF9zdHJpbmcocy0mZ3Q7aW8sICZxdW90O25hbWUmcXVvdDssICZx
dW90O0kvTyZxdW90Oyk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgcWRldl9wcm9wX3Nl
dF91aW50NjQocy0mZ3Q7aW8sICZxdW90O3NpemUmcXVvdDssIG1jLSZndDtpb19zaXplKTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBxZGV2X2luaXRfbm9mYWlsKHMtJmd0O2lvKTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBzeXNidXNfbW1pb19tYXBfb3ZlcmxhcChTWVNfQlVT
X0RFVklDRShzLSZndDtpbyksIDAsIE9GRlNFVF9EQVRBLDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
LTEyMzQpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIC8qIFBvd2VyIFJlZHVjdGlvbiAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGZv
ciAoaSA9IDA7IGkgJmx0OyBQT1dFUl9NQVg7IGkrKykgezxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGludCBpZHggPSBQT1dFUihpKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBpZiAoIW1jLSZndDtkZXZbaWR4XS5hZGRyKSB7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGRldm5hbWUg
PSBnX3N0cmR1cF9wcmludGYoJnF1b3Q7cG93ZXIlenUmcXVvdDssIGkpOzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChkZXYp
LCBkZXZuYW1lLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7cy0mZ3Q7cHdyW2ldLCBzaXplb2Yocy0mZ3Q7
cHdyW2ldKSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUWVBFX0FWUl9NQVNLLCAmYW1wO2Vycm9yX2Fib3J0LCBO
VUxMKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBvYmplY3RfcHJvcGVydHlf
c2V0X2Jvb2woT0JKRUNUKCZhbXA7cy0mZ3Q7cHdyW2ldKSwgdHJ1ZSwgJnF1b3Q7cmVhbGl6ZWQm
cXVvdDssPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2Vycm9yX2Fib3J0KTs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoJmFtcDtz
LSZndDtwd3JbaV0pLCAwLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIE9GRlNFVF9EQVRBICsgbWMtJmd0O2RldltpZHhdLmFkZHIpOzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGdfZnJlZShkZXZuYW1lKTs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArwqAgwqAgLyogR1BJTyAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIGZvciAoaSA9IDA7IGkgJmx0OyBHUElPX01BWDsgaSsrKSB7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgaW50IGlkeCA9IEdQSU8oaSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgaWYgKCFtYy0mZ3Q7ZGV2W2lkeF0uYWRkcikgezxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIH08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBkZXZu
YW1lID0gZ19zdHJkdXBfcHJpbnRmKCZxdW90O2F2ci1ncGlvLSVjJnF1b3Q7LCAmIzM5O2EmIzM5
OyArIChjaGFyKWkpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGNyZWF0ZV91
bmltcGxlbWVudGVkX2RldmljZShkZXZuYW1lLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9GRlNFVF9E
QVRBICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoG1jLSZndDtkZXZbaWR4XS5hZGRyLCAzKTs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBnX2ZyZWUoZGV2bmFtZSk7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIC8qIFVTQVJUICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAg
wqAgZm9yIChpID0gMDsgaSAmbHQ7IFVTQVJUX01BWDsgaSsrKSB7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgaW50IGlkeCA9IFVTQVJUKGkpOzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIGlmICghbWMtJmd0O2RldltpZHhdLmFkZHIpIHs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgZGV2
bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigmcXVvdDt1c2FydCV6dSZxdW90OywgaSk7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNU
KGRldiksIGRldm5hbWUsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtzLSZndDt1c2FydFtpXSwgc2l6ZW9m
KHMtJmd0O3VzYXJ0W2ldKSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUWVBFX0FWUl9VU0FSVCwgJmFtcDtlcnJv
cl9hYm9ydCwgTlVMTCk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcWRldl9w
cm9wX3NldF9jaHIoREVWSUNFKCZhbXA7cy0mZ3Q7dXNhcnRbaV0pLCAmcXVvdDtjaGFyZGV2JnF1
b3Q7LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgc2VyaWFsX2hkKGkpKTs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woT0JKRUNUKCZhbXA7
cy0mZ3Q7dXNhcnRbaV0pLCB0cnVlLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgJnF1b3Q7cmVhbGl6
ZWQmcXVvdDssPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2Vycm9yX2Fib3J0KTs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzYmQgPSBTWVNfQlVTX0RFVklDRSgmYW1wO3MtJmd0O3Vz
YXJ0W2ldKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzeXNidXNfbW1pb19t
YXAoc2JkLCAwLCBPRkZTRVRfREFUQSArIG1jLSZndDtkZXZbVVNBUlQoaSldLmFkZHIpOzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGNvbm5lY3RfcGVyaXBoZXJhbF9pcnEobWMs
IHNiZCwgY3B1ZGV2LCAwLCBVU0FSVF9SWENfSVJRKGkpKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBjb25uZWN0X3BlcmlwaGVyYWxfaXJxKG1jLCBzYmQsIGNwdWRldiwgMSwg
VVNBUlRfRFJFX0lSUShpKSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgY29u
bmVjdF9wZXJpcGhlcmFsX2lycShtYywgc2JkLCBjcHVkZXYsIDIsIFVTQVJUX1RYQ19JUlEoaSkp
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGNvbm5lY3RfcG93ZXJfcmVkdWN0
aW9uX2dwaW8ocywgbWMsIERFVklDRSgmYW1wO3MtJmd0O3VzYXJ0W2ldKSwgaWR4KTs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBnX2ZyZWUoZGV2bmFtZSk7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0
O8KgIMKgIMKgK8KgIMKgIC8qIFRpbWVyICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAg
Zm9yIChpID0gMDsgaSAmbHQ7IFRJTUVSX01BWDsgaSsrKSB7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgaW50IGlkeCA9IFRJTUVSKGkpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGlmICghbWMtJmd0O2RldltpZHhdLmFkZHIpIHs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgaWYgKCFt
Yy0mZ3Q7ZGV2W2lkeF0uaXNfdGltZXIxNikgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgmcXVvdDthdnItdGltZXI4
JnF1b3Q7LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9GRlNFVF9EQVRBICs8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoG1jLSZndDtkZXZbaWR4XS5hZGRyLCA1KTs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoJnF1b3Q7
YXZyLXRpbWVyOC1pbnRtYXNrJnF1b3Q7LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE9GRlNF
VF9EQVRBPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKg
bWMtJmd0O2RldltpZHhdLmludG1hc2tfYWRkciwgMSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgwqAgwqAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCZxdW90O2F2ci10
aW1lcjgtaW50ZmxhZyZxdW90Oyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPRkZTRVRfREFU
QTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoG1jLSZn
dDtkZXZbaWR4XS5pbnRmbGFnX2FkZHIsIDEpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IH08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBkZXZuYW1lID0gZ19zdHJkdXBf
cHJpbnRmKCZxdW90O3RpbWVyJXp1JnF1b3Q7LCBpKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QoZGV2KSwgZGV2bmFtZSw8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmYW1wO3MtJmd0O3RpbWVyW2ldLCBzaXplb2Yocy0mZ3Q7dGltZXJbaV0p
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFRZUEVfQVZSX1RJTUVSMTYsICZhbXA7ZXJyb3JfYWJvcnQsIE5VTEwp
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIG9iamVjdF9wcm9wZXJ0eV9zZXRf
dWludChPQkpFQ1QoJmFtcDtzLSZndDt0aW1lcltpXSksIHMtJmd0O3h0YWxfZnJlcV9oeiw8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCZxdW90O2NwdS1mcmVxdWVuY3ktaHomcXVvdDssICZhbXA7ZXJyb3JfYWJv
cnQpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIG9iamVjdF9wcm9wZXJ0eV9z
ZXRfYm9vbChPQkpFQ1QoJmFtcDtzLSZndDt0aW1lcltpXSksIHRydWUsPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAmcXVvdDtyZWFsaXplZCZxdW90Oyw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7ZXJyb3Jf
YWJvcnQpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHNiZCA9IFNZU19CVVNf
REVWSUNFKCZhbXA7cy0mZ3Q7dGltZXJbaV0pOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIHN5c2J1c19tbWlvX21hcChzYmQsIDAsIE9GRlNFVF9EQVRBICsgbWMtJmd0O2Rldltp
ZHhdLmFkZHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHN5c2J1c19tbWlv
X21hcChzYmQsIDEsIE9GRlNFVF9EQVRBICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoG1jLSZndDtk
ZXZbaWR4XS5pbnRtYXNrX2FkZHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHN5c2J1c19tbWlvX21hcChzYmQsIDIsIE9GRlNFVF9EQVRBICs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoG1jLSZndDtkZXZbaWR4XS5pbnRmbGFnX2FkZHIpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGNvbm5lY3RfcGVyaXBoZXJhbF9pcnEobWMsIHNiZCwgY3B1ZGV2LCAwLCBU
SU1FUl9DQVBUX0lSUShpKSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgY29u
bmVjdF9wZXJpcGhlcmFsX2lycShtYywgc2JkLCBjcHVkZXYsIDEsIFRJTUVSX0NPTVBBX0lSUShp
KSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgY29ubmVjdF9wZXJpcGhlcmFs
X2lycShtYywgc2JkLCBjcHVkZXYsIDIsIFRJTUVSX0NPTVBCX0lSUShpKSk7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgY29ubmVjdF9wZXJpcGhlcmFsX2lycShtYywgc2JkLCBj
cHVkZXYsIDMsIFRJTUVSX0NPTVBDX0lSUShpKSk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgY29ubmVjdF9wZXJpcGhlcmFsX2lycShtYywgc2JkLCBjcHVkZXYsIDQsIFRJTUVS
X09WRl9JUlEoaSkpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGNvbm5lY3Rf
cG93ZXJfcmVkdWN0aW9uX2dwaW8ocywgbWMsIERFVklDRSgmYW1wO3MtJmd0O3RpbWVyW2ldKSwg
aWR4KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBnX2ZyZWUoZGV2bmFtZSk7
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgKzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgm
cXVvdDthdnItdHdpJnF1b3Q7LMKgIMKgIMKgIMKgIMKgIE9GRlNFVF9EQVRBICs8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoDB4MGI4LCA2KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBjcmVh
dGVfdW5pbXBsZW1lbnRlZF9kZXZpY2UoJnF1b3Q7YXZyLWFkYyZxdW90OyzCoCDCoCDCoCDCoCDC
oCBPRkZTRVRfREFUQSArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAweDA3OCwgOCk7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArwqAgwqAgY3JlYXRlX3VuaW1wbGVtZW50ZWRfZGV2aWNlKCZxdW90O2F2
ci1leHQtbWVtLWN0cmwmcXVvdDssIE9GRlNFVF9EQVRBICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oDB4MDc0LCAyKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBjcmVhdGVfdW5pbXBsZW1l
bnRlZF9kZXZpY2UoJnF1b3Q7YXZyLXdhdGNoZG9nJnF1b3Q7LMKgIMKgIMKgT0ZGU0VUX0RBVEEg
Kzxicj4NCiZndDsgJmd0O8KgIMKgIMKgMHgwNjAsIDEpOzxicj4NCiZndDsgJmd0O8KgIMKgIMKg
K8KgIMKgIGNyZWF0ZV91bmltcGxlbWVudGVkX2RldmljZSgmcXVvdDthdnItc3BpJnF1b3Q7LMKg
IMKgIMKgIMKgIMKgIE9GRlNFVF9EQVRBICs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoDB4MDRjLCAz
KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBjcmVhdGVfdW5pbXBsZW1lbnRlZF9kZXZp
Y2UoJnF1b3Q7YXZyLWVlcHJvbSZxdW90OyzCoCDCoCDCoCDCoE9GRlNFVF9EQVRBICs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoDB4MDNmLCAzKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCt9PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArc3RhdGljIFByb3BlcnR5
IGF0bWVnYV9wcm9wc1tdID0gezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIERFRklORV9Q
Uk9QX1VJTlQ2NCgmcXVvdDt4dGFsLWZyZXF1ZW5jeS1oeiZxdW90OywgQXRtZWdhTWN1U3RhdGUs
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB4dGFsX2ZyZXFfaHosIDApLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIERFRklORV9Q
Uk9QX0VORF9PRl9MSVNUKCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCt9Ozxicj4NCiZndDsgJmd0
O8KgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF0bWVnYV9jbGFz
c19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSk8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCt7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNF
X0NMQVNTKG9jKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCvCoCDCoCBkYy0mZ3Q7cmVhbGl6ZSA9IGF0bWVnYV9yZWFsaXplOzxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK8KgIMKgIGRjLSZndDtwcm9wcyA9IGF0bWVnYV9wcm9wczs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCAvKiBSZWFzb246IE1hcHBlZCBhdCBmaXhlZCBsb2NhdGlvbiBvbiB0aGUg
c3lzdGVtIGJ1cyAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGRjLSZndDt1c2VyX2Ny
ZWF0YWJsZSA9IGZhbHNlOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK308YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhdG1lZ2ExNjhfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqArezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIEF0bWVnYU1jdUNsYXNzICphbWMgPSBB
VE1FR0FfTUNVX0NMQVNTKG9jKTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O2NwdV90eXBlID0gQVZSX0NQVV9UWVBFX05BTUUoJnF1
b3Q7YXZyNSZxdW90Oyk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtmbGFz
aF9zaXplID0gMTYgKiBLaUI7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtl
ZXByb21fc2l6ZSA9IDUxMjs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O3Ny
YW1fc2l6ZSA9IDEgKiBLaUI7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtp
b19zaXplID0gMjU2Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7Z3Bpb19j
b3VudCA9IDIzOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7YWRjX2NvdW50
ID0gNjs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O2lycSA9IGlycTE2OF8z
Mjg7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtkZXYgPSBkZXYxNjhfMzI4
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK307PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArc3RhdGljIHZvaWQgYXRtZWdhMzI4X2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKm9jLCB2b2lkICpkYXRhKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCvCoCDCoCBBdG1lZ2FNY3VDbGFzcyAqYW1jID0gQVRNRUdBX01DVV9DTEFT
UyhvYyk7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAg
wqAgYW1jLSZndDtjcHVfdHlwZSA9IEFWUl9DUFVfVFlQRV9OQU1FKCZxdW90O2F2cjUmcXVvdDsp
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7Zmxhc2hfc2l6ZSA9IDMyICog
S2lCOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7ZWVwcm9tX3NpemUgPSAx
ICogS2lCOzxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7c3JhbV9zaXplID0g
MiAqIEtpQjs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O2lvX3NpemUgPSAy
NTY7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtncGlvX2NvdW50ID0gMjM7
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDthZGNfY291bnQgPSA2Ozxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7aXJxID0gaXJxMTY4XzMyODs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O2RldiA9IGRldjE2OF8zMjg7PGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqArfTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCtzdGF0aWMgdm9pZCBhdG1lZ2ExMjgwX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9j
LCB2b2lkICpkYXRhKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCBBdG1lZ2FNY3VDbGFzcyAqYW1jID0gQVRNRUdBX01DVV9DTEFTUyhvYyk7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZn
dDtjcHVfdHlwZSA9IEFWUl9DUFVfVFlQRV9OQU1FKCZxdW90O2F2cjYmcXVvdDspOzxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7Zmxhc2hfc2l6ZSA9IDEyOCAqIEtpQjs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O2VlcHJvbV9zaXplID0gNCAqIEtpQjs8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O3NyYW1fc2l6ZSA9IDggKiBLaUI7
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtpb19zaXplID0gNTEyOzxicj4N
CiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7Z3Bpb19jb3VudCA9IDg2Ozxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7YWRjX2NvdW50ID0gMTY7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtpcnEgPSBpcnExMjgwXzI1NjA7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtkZXYgPSBkZXYxMjgwXzI1NjA7PGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArfTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCtzdGF0aWMgdm9pZCBhdG1lZ2EyNTYwX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2
b2lkICpkYXRhKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCvCoCDCoCBBdG1lZ2FNY3VDbGFzcyAqYW1jID0gQVRNRUdBX01DVV9DTEFTUyhvYyk7PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtj
cHVfdHlwZSA9IEFWUl9DUFVfVFlQRV9OQU1FKCZxdW90O2F2cjYmcXVvdDspOzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7Zmxhc2hfc2l6ZSA9IDI1NiAqIEtpQjs8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O2VlcHJvbV9zaXplID0gNCAqIEtpQjs8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCBhbWMtJmd0O3NyYW1fc2l6ZSA9IDggKiBLaUI7PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgYW1jLSZndDtpb19zaXplID0gNTEyOzxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7Z3Bpb19jb3VudCA9IDU0Ozxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIGFtYy0mZ3Q7YWRjX2NvdW50ID0gMTY7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArwqAgwqAgYW1jLSZndDtpcnEgPSBpcnExMjgwXzI1NjA7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArwqAgwqAgYW1jLSZndDtkZXYgPSBkZXYxMjgwXzI1NjA7PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArfTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCtzdGF0aWMgY29uc3QgVHlwZUluZm8gYXRtZWdhX21jdV90eXBlc1tdID0gezxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAu
bmFtZcKgIMKgIMKgIMKgIMKgIMKgPSBUWVBFX0FUTUVHQTE2OF9NQ1UsPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgLnBhcmVudMKgIMKgIMKgIMKgIMKgPSBUWVBFX0FUTUVHQV9N
Q1UsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLmNsYXNzX2luaXTCoCDCoCDC
oD0gYXRtZWdhMTY4X2NsYXNzX2luaXQsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgfSwg
ezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIC5uYW1lwqAgwqAgwqAgwqAgwqAg
wqA9IFRZUEVfQVRNRUdBMzI4X01DVSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCAucGFyZW50wqAgwqAgwqAgwqAgwqA9IFRZUEVfQVRNRUdBX01DVSw8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCAuY2xhc3NfaW5pdMKgIMKgIMKgPSBhdG1lZ2EzMjhfY2xhc3Nf
aW5pdCw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCB9LCB7PGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgLm5hbWXCoCDCoCDCoCDCoCDCoCDCoD0gVFlQRV9BVE1FR0ExMjgw
X01DVSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAucGFyZW50wqAgwqAgwqAg
wqAgwqA9IFRZUEVfQVRNRUdBX01DVSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCAuY2xhc3NfaW5pdMKgIMKgIMKgPSBhdG1lZ2ExMjgwX2NsYXNzX2luaXQsPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgfSwgezxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IC5uYW1lwqAgwqAgwqAgwqAgwqAgwqA9IFRZUEVfQVRNRUdBMjU2MF9NQ1UsPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLnBhcmVudMKgIMKgIMKgIMKgIMKgPSBUWVBFX0FUTUVH
QV9NQ1UsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLmNsYXNzX2luaXTCoCDC
oCDCoD0gYXRtZWdhMjU2MF9jbGFzc19pbml0LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKg
IH0sIHs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAubmFtZcKgIMKgIMKgIMKg
IMKgIMKgPSBUWVBFX0FUTUVHQV9NQ1UsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAg
wqAgLnBhcmVudMKgIMKgIMKgIMKgIMKgPSBUWVBFX1NZU19CVVNfREVWSUNFLDxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIC5pbnN0YW5jZV9zaXplwqAgPSBzaXplb2YoQXRtZWdh
TWN1U3RhdGUpLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIC5jbGFzc19zaXpl
wqAgwqAgwqA9IHNpemVvZihBdG1lZ2FNY3VDbGFzcyksPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgLmNsYXNzX2luaXTCoCDCoCDCoD0gYXRtZWdhX2NsYXNzX2luaXQsPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLmFic3RyYWN0wqAgwqAgwqAgwqA9IHRydWUs
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK307
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqArREVGSU5FX1RZ
UEVTKGF0bWVnYV9tY3VfdHlwZXMpPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEv
aHcvYXZyL0tjb25maWcgYi9ody9hdnIvS2NvbmZpZzxicj4NCiZndDsgJmd0O8KgIMKgIMKgbmV3
IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoGluZGV4IDAwMDAwMDAwMDAu
LmRhM2IxMGFmZWM8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoC0tLSAvZGV2L251bGw8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCsrKyBiL2h3L2F2ci9LY29uZmlnPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBA
QCAtMCwwICsxLDUgQEA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCtjb25maWcgQVRNRUxfQVRNRUdB
X01DVTxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIGJvb2w8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCvCoCDCoCBzZWxlY3QgQVRNRUxfVElNRVIxNjxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8Kg
IMKgIHNlbGVjdCBBVE1FTF9VU0FSVDxicj4NCiZndDsgJmd0O8KgIMKgIMKgK8KgIMKgIHNlbGVj
dCBBVE1FTF9QT1dFUjxicj4NCiZndDsgJmd0O8KgIMKgIMKgZGlmZiAtLWdpdCBhL2h3L2F2ci9N
YWtlZmlsZS5vYmpzIGIvaHcvYXZyL01ha2VmaWxlLm9ianM8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oGluZGV4IDEyM2YxNzRmMGUuLjFmNzNmZDU0NjkgMTAwNjQ0PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAtLS0gYS9ody9hdnIvTWFrZWZpbGUub2Jqczxicj4NCiZndDsgJmd0O8KgIMKgIMKgKysrIGIv
aHcvYXZyL01ha2VmaWxlLm9ianM8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoEBAIC0xICsxLDIgQEA8
YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoG9iai15ICs9IGJvb3Qubzxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgK29iai0kKENPTkZJR19BVE1FTF9BVE1FR0FfTUNVKSArPSBhdG1lbF9hdG1lZ2Eubzxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgLS0gPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAyLjIxLjE8YnI+
DQomZ3Q7ICZndDsgPGJyPg0KJmd0Ozxicj4NCjwvcD4NCg==
--00000000000099826b059d1a8eaa--

