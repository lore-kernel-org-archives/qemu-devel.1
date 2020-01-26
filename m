Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 14:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D382071A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8+oQuwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D382071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivjCW-0004EC-2l
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 09:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivjBU-0003TF-5T
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 09:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivjBP-0002B6-QN
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 09:46:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivjBP-0002A0-HY; Sun, 26 Jan 2020 09:46:39 -0500
Received: by mail-oi1-x241.google.com with SMTP id b18so374201oie.2;
 Sun, 26 Jan 2020 06:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=OKpAFs9ji2wugJpeXafBsbmoSLZKaZnCPkmA596vCCk=;
 b=G8+oQuwjBGOvTjFTgKzmvEtl/TlTZ30lRevhWWw9ceINCqxCu3NTpgGPrF3/qDyC3n
 h7x8UXmpfK6x9Sppgw4/2C5SEz3S2Pcye+SUNnAY2dXT4AWBF/iZ4Og+v9qtPfm0h2FX
 9B9eSkPVlxQp7kXKIUAGfHiOpIOLM64N+vuGWcow1bXCo7qt/yqyx/Dh/rwm9PGndMR3
 YmrQOaiMSncks22ZeoDlT8VmyY74DG6TaD4nZA8NmZ41ui7fK50Of8u6Zp8fNkvVH0oS
 toPAn9e+e9uPDZOK/muXdotckvG9++qffEWk6Lkv8mbSryr0hKCbtdpXTg3m+N0D2CMZ
 QTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=OKpAFs9ji2wugJpeXafBsbmoSLZKaZnCPkmA596vCCk=;
 b=OwWIpmhf5rW5l7Q7mo7HfyWVL3xURaJWNpm4RnVelY1Vgn8HO2z4nNua7BKYgoux5b
 aOCCLokZAElgeDaJfINmWDrnOPtgQ7/52Jri4QTni0w2bjkKLLHeT+kz3X0mnY4jBm+9
 w3p3//4cRjSYpif8UtbAAw5xm5HhQLnnedhjutPPZCwhOHwgtQpxkClHXVTqyUtxvX9J
 kC942aAZQqhi6L9IaaKxVQ7iVOITGScZxEYTdL2HBE/8PiBUvDQGRhP9C0xrBi+YyhQ7
 pR2b0xCsONa+IfckJJplKHrHwx3dKw9Y6nOyWRFENFhFvoKhf3fGm2/vUlLUE8ouo3p7
 XFBA==
X-Gm-Message-State: APjAAAWvxDaSYJaUi1+42dZAujU1EvY2MdExBkphczD0tJbHfFcEPQfu
 RpVxG8BGntg8Hos4Nfu+c5JAHppDBgNwXlR5v10=
X-Google-Smtp-Source: APXvYqzkGCsBIM4EIwl6GsSW0EZu80qiUQAIL9z20yhez7ja1HYuSqGDSOwgzrNbbA+ZuL+baYSFVpizxJ6TwFI0hj4=
X-Received: by 2002:aca:5844:: with SMTP id m65mr4990177oib.136.1580049998191; 
 Sun, 26 Jan 2020 06:46:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sun, 26 Jan 2020 06:46:37 -0800 (PST)
In-Reply-To: <20200124005131.16276-21-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-21-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 26 Jan 2020 15:46:37 +0100
Message-ID: <CAL1e-=ht6NS_ZyGAh59V2HuQkoXm=pyEz20SUPzxQkFkU=iCsQ@mail.gmail.com>
Subject: Re: [PATCH rc2 20/25] hw/avr: Add some ATmega microcontrollers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000de9fa9059d0c0e24"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000de9fa9059d0c0e24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, January 24, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:

> Add some microcontrollers from the megaAVR family (ATmega series):
>
> - middle range: ATmega168 and ATmega328
> - high range: ATmega1280 and ATmega2560
>
> For product comparison:
>   https://www.microchip.com/wwwproducts/ProductCompare/
> ATmega168P/ATmega328P
>   https://www.microchip.com/wwwproducts/ProductCompare/
> ATmega1280/ATmega2560
>
> Datasheets:
>   http://ww1.microchip.com/downloads/en/DeviceDoc/
> ATmega48A-PA-88A-PA-168A-PA-328-P-DS-DS40002061A.pdf
>   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-
> Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200120220107.17825-14-f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> rc2:
> - Squashed Kconfig patch (Thomas)
> - Correct SRAM base address
> ---
>  hw/avr/atmel_atmega.h |  48 +++++
>  hw/avr/atmel_atmega.c | 470 ++++++++++++++++++++++++++++++++++++++++++
>  hw/avr/Kconfig        |   5 +
>  hw/avr/Makefile.objs  |   1 +
>  4 files changed, 524 insertions(+)
>  create mode 100644 hw/avr/atmel_atmega.h
>  create mode 100644 hw/avr/atmel_atmega.c
>  create mode 100644 hw/avr/Kconfig
>
>
This patch introduces a terminology confusion that will be difficult to
eliminate once the code is in the tree.

"AVR" is the name (or, if someone wishes, the common name prefix) of the
family of all MCUs covered in this series. This is reflected in the
existence of the directory "hw/avr", and this is, in my opinion fine.

"Atmel" is the company that used to design AVR MCUs (there are hundreds of
such MCUs). "Atmel" was acquired several years ago by another company,
"Microchip". Trere is no element in AVR MCUs' docimentation that reffers to
the producers (except title, copyright, etc). In all recent docs, "Atmel"
is complely eradicated.

Therefore, using the name of non-existant company "Atmel" is confusing,
and, moreover, completely unnecessary. Please, remove references to "Atmel"
from file names, and from the code.

Thanks, Aleksandar



> diff --git a/hw/avr/atmel_atmega.h b/hw/avr/atmel_atmega.h
> new file mode 100644
> index 0000000000..391b8b1bf8
> --- /dev/null
> +++ b/hw/avr/atmel_atmega.h
> @@ -0,0 +1,48 @@
> +/*
> + * QEMU ATmega MCU
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_AVR_ATMEL_ATMEGA_H
> +#define HW_AVR_ATMEL_ATMEGA_H
> +
> +#include "hw/char/atmel_usart.h"
> +#include "hw/timer/atmel_timer16.h"
> +#include "hw/misc/atmel_power.h"
> +#include "target/avr/cpu.h"
> +
> +#define TYPE_ATMEGA_MCU     "ATmega"
> +#define TYPE_ATMEGA168_MCU  "ATmega168"
> +#define TYPE_ATMEGA328_MCU  "ATmega328"
> +#define TYPE_ATMEGA1280_MCU "ATmega1280"
> +#define TYPE_ATMEGA2560_MCU "ATmega2560"
> +
> +#define ATMEGA_MCU(obj) OBJECT_CHECK(AtmegaMcuState, (obj),
> TYPE_ATMEGA_MCU)
> +
> +#define POWER_MAX 2
> +#define USART_MAX 4
> +#define TIMER_MAX 6
> +#define GPIO_MAX 12
> +
> +typedef struct AtmegaMcuState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    AVRCPU cpu;
> +    MemoryRegion flash;
> +    MemoryRegion eeprom;
> +    MemoryRegion sram;
> +    DeviceState *io;
> +    AVRMaskState pwr[POWER_MAX];
> +    AVRUsartState usart[USART_MAX];
> +    AVRTimer16State timer[TIMER_MAX];
> +    uint64_t xtal_freq_hz;
> +} AtmegaMcuState;
> +
> +#endif /* HW_AVR_ATMEL_ATMEGA_H */
> diff --git a/hw/avr/atmel_atmega.c b/hw/avr/atmel_atmega.c
> new file mode 100644
> index 0000000000..790c374dee
> --- /dev/null
> +++ b/hw/avr/atmel_atmega.c
> @@ -0,0 +1,470 @@
> +/*
> + * QEMU ATmega MCU
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "hw/boards.h" /* FIXME memory_region_allocate_system_memory for
> sram */
> +#include "hw/misc/unimp.h"
> +#include "atmel_atmega.h"
> +
> +enum AtmegaPeripheral {
> +    POWER0, POWER1,
> +    GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF,
> +    GPIOG, GPIOH, GPIOI, GPIOJ, GPIOK, GPIOL,
> +    USART0, USART1, USART2, USART3,
> +    TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,
> +    PERIFMAX
> +};
> +
> +#define GPIO(n)     (n + GPIOA)
> +#define USART(n)    (n + USART0)
> +#define TIMER(n)    (n + TIMER0)
> +#define POWER(n)    (n + POWER0)
> +
> +typedef struct {
> +    uint16_t addr;
> +    enum AtmegaPeripheral power_index;
> +    uint8_t power_bit;
> +    /* timer specific */
> +    uint16_t intmask_addr;
> +    uint16_t intflag_addr;
> +    bool is_timer16;
> +} peripheral_cfg;
> +
> +typedef struct AtmegaMcuClass {
> +    /*< private >*/
> +    SysBusDeviceClass parent_class;
> +    /*< public >*/
> +    const char *uc_name;
> +    const char *cpu_type;
> +    size_t flash_size;
> +    size_t eeprom_size;
> +    size_t sram_size;
> +    size_t io_size;
> +    size_t gpio_count;
> +    size_t adc_count;
> +    const uint8_t *irq;
> +    const peripheral_cfg *dev;
> +} AtmegaMcuClass;
> +
> +#define ATMEGA_MCU_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(AtmegaMcuClass, (klass), TYPE_ATMEGA_MCU)
> +#define ATMEGA_MCU_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(AtmegaMcuClass, (obj), TYPE_ATMEGA_MCU)
> +
> +static const peripheral_cfg dev168_328[PERIFMAX] =3D {
> +    [USART0]        =3D {  0xc0, POWER0, 1 },
> +    [TIMER2]        =3D {  0xb0, POWER0, 6, 0x70, 0x37, false },
> +    [TIMER1]        =3D {  0x80, POWER0, 3, 0x6f, 0x36, true },
> +    [POWER0]        =3D {  0x64 },
> +    [TIMER0]        =3D {  0x44, POWER0, 5, 0x6e, 0x35, false },
> +    [GPIOD]         =3D {  0x29 },
> +    [GPIOC]         =3D {  0x26 },
> +    [GPIOB]         =3D {  0x23 },
> +}, dev1280_2560[PERIFMAX] =3D {
> +    [USART3]        =3D { 0x130, POWER1, 2 },
> +    [TIMER5]        =3D { 0x120, POWER1, 5, 0x73, 0x3a, true },
> +    [GPIOL]         =3D { 0x109 },
> +    [GPIOK]         =3D { 0x106 },
> +    [GPIOJ]         =3D { 0x103 },
> +    [GPIOH]         =3D { 0x100 },
> +    [USART2]        =3D {  0xd0, POWER1, 1 },
> +    [USART1]        =3D {  0xc8, POWER1, 0 },
> +    [USART0]        =3D {  0xc0, POWER0, 1 },
> +    [TIMER2]        =3D {  0xb0, POWER0, 6, 0x70, 0x37, false }, /* TODO
> async */
> +    [TIMER4]        =3D {  0xa0, POWER1, 4, 0x72, 0x39, true },
> +    [TIMER3]        =3D {  0x90, POWER1, 3, 0x71, 0x38, true },
> +    [TIMER1]        =3D {  0x80, POWER0, 3, 0x6f, 0x36, true },
> +    [POWER1]        =3D {  0x65 },
> +    [POWER0]        =3D {  0x64 },
> +    [TIMER0]        =3D {  0x44, POWER0, 5, 0x6e, 0x35, false },
> +    [GPIOG]         =3D {  0x32 },
> +    [GPIOF]         =3D {  0x2f },
> +    [GPIOE]         =3D {  0x2c },
> +    [GPIOD]         =3D {  0x29 },
> +    [GPIOC]         =3D {  0x26 },
> +    [GPIOB]         =3D {  0x23 },
> +    [GPIOA]         =3D {  0x20 },
> +};
> +
> +enum AtmegaIrq {
> +    USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,
> +    USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,
> +    USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,
> +    USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,
> +    TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,
> +        TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,
> +    TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,
> +        TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,
> +    TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,
> +        TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,
> +    TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,
> +        TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,
> +    TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,
> +        TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,
> +    TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,
> +        TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,
> +    IRQ_COUNT
> +};
> +
> +#define USART_IRQ_COUNT     3
> +#define USART_RXC_IRQ(n)    (n * USART_IRQ_COUNT + USART0_RXC_IRQ)
> +#define USART_DRE_IRQ(n)    (n * USART_IRQ_COUNT + USART0_DRE_IRQ)
> +#define USART_TXC_IRQ(n)    (n * USART_IRQ_COUNT + USART0_TXC_IRQ)
> +#define TIMER_IRQ_COUNT     5
> +#define TIMER_CAPT_IRQ(n)   (n * TIMER_IRQ_COUNT + TIMER0_CAPT_IRQ)
> +#define TIMER_COMPA_IRQ(n)  (n * TIMER_IRQ_COUNT + TIMER0_COMPA_IRQ)
> +#define TIMER_COMPB_IRQ(n)  (n * TIMER_IRQ_COUNT + TIMER0_COMPB_IRQ)
> +#define TIMER_COMPC_IRQ(n)  (n * TIMER_IRQ_COUNT + TIMER0_COMPC_IRQ)
> +#define TIMER_OVF_IRQ(n)    (n * TIMER_IRQ_COUNT + TIMER0_OVF_IRQ)
> +
> +static const uint8_t irq168_328[IRQ_COUNT] =3D {
> +    [TIMER2_COMPA_IRQ]      =3D 8,
> +    [TIMER2_COMPB_IRQ]      =3D 9,
> +    [TIMER2_OVF_IRQ]        =3D 10,
> +    [TIMER1_CAPT_IRQ]       =3D 11,
> +    [TIMER1_COMPA_IRQ]      =3D 12,
> +    [TIMER1_COMPB_IRQ]      =3D 13,
> +    [TIMER1_OVF_IRQ]        =3D 14,
> +    [TIMER0_COMPA_IRQ]      =3D 15,
> +    [TIMER0_COMPB_IRQ]      =3D 16,
> +    [TIMER0_OVF_IRQ]        =3D 17,
> +    [USART0_RXC_IRQ]        =3D 19,
> +    [USART0_DRE_IRQ]        =3D 20,
> +    [USART0_TXC_IRQ]        =3D 21,
> +}, irq1280_2560[IRQ_COUNT] =3D {
> +    [TIMER2_COMPA_IRQ]      =3D 14,
> +    [TIMER2_COMPB_IRQ]      =3D 15,
> +    [TIMER2_OVF_IRQ]        =3D 16,
> +    [TIMER1_CAPT_IRQ]       =3D 17,
> +    [TIMER1_COMPA_IRQ]      =3D 18,
> +    [TIMER1_COMPB_IRQ]      =3D 19,
> +    [TIMER1_COMPC_IRQ]      =3D 20,
> +    [TIMER1_OVF_IRQ]        =3D 21,
> +    [TIMER0_COMPA_IRQ]      =3D 22,
> +    [TIMER0_COMPB_IRQ]      =3D 23,
> +    [TIMER0_OVF_IRQ]        =3D 24,
> +    [USART0_RXC_IRQ]        =3D 26,
> +    [USART0_DRE_IRQ]        =3D 27,
> +    [USART0_TXC_IRQ]        =3D 28,
> +    [TIMER3_CAPT_IRQ]       =3D 32,
> +    [TIMER3_COMPA_IRQ]      =3D 33,
> +    [TIMER3_COMPB_IRQ]      =3D 34,
> +    [TIMER3_COMPC_IRQ]      =3D 35,
> +    [TIMER3_OVF_IRQ]        =3D 36,
> +    [USART1_RXC_IRQ]        =3D 37,
> +    [USART1_DRE_IRQ]        =3D 38,
> +    [USART1_TXC_IRQ]        =3D 39,
> +    [TIMER4_CAPT_IRQ]       =3D 42,
> +    [TIMER4_COMPA_IRQ]      =3D 43,
> +    [TIMER4_COMPB_IRQ]      =3D 44,
> +    [TIMER4_COMPC_IRQ]      =3D 45,
> +    [TIMER4_OVF_IRQ]        =3D 46,
> +    [TIMER5_CAPT_IRQ]       =3D 47,
> +    [TIMER5_COMPA_IRQ]      =3D 48,
> +    [TIMER5_COMPB_IRQ]      =3D 49,
> +    [TIMER5_COMPC_IRQ]      =3D 50,
> +    [TIMER5_OVF_IRQ]        =3D 51,
> +    [USART2_RXC_IRQ]        =3D 52,
> +    [USART2_DRE_IRQ]        =3D 53,
> +    [USART2_TXC_IRQ]        =3D 54,
> +    [USART3_RXC_IRQ]        =3D 55,
> +    [USART3_DRE_IRQ]        =3D 56,
> +    [USART3_TXC_IRQ]        =3D 57,
> +};
> +
> +static void connect_peripheral_irq(const AtmegaMcuClass *mc,
> +                                   SysBusDevice *sbd,
> +                                   DeviceState *dev, int n,
> +                                   unsigned peripheral_irq)
> +{
> +    int irq =3D mc->irq[peripheral_irq];
> +
> +    if (!irq) {
> +        return;
> +    }
> +    /* FIXME move that to avr_cpu_set_int() once 'sample' board is
> removed */
> +    assert(irq >=3D 2);
> +    irq -=3D 2;
> +
> +    sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq));
> +}
> +
> +static void connect_power_reduction_gpio(AtmegaMcuState *s,
> +                                         const AtmegaMcuClass *mc,
> +                                         DeviceState *dev,
> +                                         int peripheral_index)
> +{
> +    unsigned power_index =3D mc->dev[peripheral_index].power_index;
> +    assert(mc->dev[power_index].addr);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[power_index - POWER0]),
> +                       mc->dev[peripheral_index].power_bit,
> +                       qdev_get_gpio_in(dev, 0));
> +}
> +
> +static void atmega_realize(DeviceState *dev, Error **errp)
> +{
> +    AtmegaMcuState *s =3D ATMEGA_MCU(dev);
> +    const AtmegaMcuClass *mc =3D ATMEGA_MCU_GET_CLASS(dev);
> +    DeviceState *cpudev;
> +    SysBusDevice *sbd;
> +    Error *err =3D NULL;
> +    char *devname;
> +    size_t i;
> +
> +    assert(mc->io_size <=3D 0x200);
> +
> +    if (!s->xtal_freq_hz) {
> +        error_setg(errp, "\"xtal-frequency-hz\" property must be
> provided.");
> +        return;
> +    }
> +
> +    /* CPU */
> +    object_initialize_child(OBJECT(dev), "cpu", &s->cpu, sizeof(s->cpu),
> +                            mc->cpu_type, &err, NULL);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized",
> &error_abort);
> +    cpudev =3D DEVICE(&s->cpu);
> +
> +    /* SRAM */
> +    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
> +                           &error_abort);
> +    memory_region_add_subregion(get_system_memory(),
> +                                OFFSET_DATA + mc->io_size, &s->sram);
> +
> +    /* Flash */
> +    memory_region_init_rom(&s->flash, OBJECT(dev),
> +                           "flash", mc->flash_size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), OFFSET_CODE,
> &s->flash);
> +
> +    /*
> +     * I/O
> +     *
> +     * 0x00 - 0x1f: Registers
> +     * 0x20 - 0x5f: I/O memory
> +     * 0x60 - 0xff: Extended I/O
> +     */
> +    s->io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
> +    qdev_prop_set_string(s->io, "name", "I/O");
> +    qdev_prop_set_uint64(s->io, "size", mc->io_size);
> +    qdev_init_nofail(s->io);
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA,
> -1234);
> +
> +    /* Power Reduction */
> +    for (i =3D 0; i < POWER_MAX; i++) {
> +        int idx =3D POWER(i);
> +        if (!mc->dev[idx].addr) {
> +            continue;
> +        }
> +        devname =3D g_strdup_printf("power%zu", i);
> +        object_initialize_child(OBJECT(dev), devname,
> +                                &s->pwr[i], sizeof(s->pwr[i]),
> +                                TYPE_AVR_MASK, &error_abort, NULL);
> +        object_property_set_bool(OBJECT(&s->pwr[i]), true, "realized",
> +                                 &error_abort);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0,
> +                        OFFSET_DATA + mc->dev[idx].addr);
> +        g_free(devname);
> +    }
> +
> +    /* GPIO */
> +    for (i =3D 0; i < GPIO_MAX; i++) {
> +        int idx =3D GPIO(i);
> +        if (!mc->dev[idx].addr) {
> +            continue;
> +        }
> +        devname =3D g_strdup_printf("avr-gpio-%c", 'a' + (char)i);
> +        create_unimplemented_device(devname,
> +                                    OFFSET_DATA + mc->dev[idx].addr, 3);
> +        g_free(devname);
> +    }
> +
> +    /* USART */
> +    for (i =3D 0; i < USART_MAX; i++) {
> +        int idx =3D USART(i);
> +        if (!mc->dev[idx].addr) {
> +            continue;
> +        }
> +        devname =3D g_strdup_printf("usart%zu", i);
> +        object_initialize_child(OBJECT(dev), devname,
> +                                &s->usart[i], sizeof(s->usart[i]),
> +                                TYPE_AVR_USART, &error_abort, NULL);
> +        qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i))=
;
> +        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized",
> +                                 &error_abort);
> +        sbd =3D SYS_BUS_DEVICE(&s->usart[i]);
> +        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[USART(i)].addr);
> +        connect_peripheral_irq(mc, sbd, cpudev, 0, USART_RXC_IRQ(i));
> +        connect_peripheral_irq(mc, sbd, cpudev, 1, USART_DRE_IRQ(i));
> +        connect_peripheral_irq(mc, sbd, cpudev, 2, USART_TXC_IRQ(i));
> +        connect_power_reduction_gpio(s, mc, DEVICE(&s->usart[i]), idx);
> +        g_free(devname);
> +    }
> +
> +    /* Timer */
> +    for (i =3D 0; i < TIMER_MAX; i++) {
> +        int idx =3D TIMER(i);
> +        if (!mc->dev[idx].addr) {
> +            continue;
> +        }
> +        if (!mc->dev[idx].is_timer16) {
> +            create_unimplemented_device("avr-timer8",
> +                                        OFFSET_DATA + mc->dev[idx].addr,
> 5);
> +            create_unimplemented_device("avr-timer8-intmask",
> +                                        OFFSET_DATA
> +                                        + mc->dev[idx].intmask_addr, 1);
> +            create_unimplemented_device("avr-timer8-intflag",
> +                                        OFFSET_DATA
> +                                        + mc->dev[idx].intflag_addr, 1);
> +            continue;
> +        }
> +        devname =3D g_strdup_printf("timer%zu", i);
> +        object_initialize_child(OBJECT(dev), devname,
> +                                &s->timer[i], sizeof(s->timer[i]),
> +                                TYPE_AVR_TIMER16, &error_abort, NULL);
> +        object_property_set_uint(OBJECT(&s->timer[i]), s->xtal_freq_hz,
> +                                 "cpu-frequency-hz", &error_abort);
> +        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized",
> +                                 &error_abort);
> +        sbd =3D SYS_BUS_DEVICE(&s->timer[i]);
> +        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
> +        sysbus_mmio_map(sbd, 1, OFFSET_DATA + mc->dev[idx].intmask_addr)=
;
> +        sysbus_mmio_map(sbd, 2, OFFSET_DATA + mc->dev[idx].intflag_addr)=
;
> +        connect_peripheral_irq(mc, sbd, cpudev, 0, TIMER_CAPT_IRQ(i));
> +        connect_peripheral_irq(mc, sbd, cpudev, 1, TIMER_COMPA_IRQ(i));
> +        connect_peripheral_irq(mc, sbd, cpudev, 2, TIMER_COMPB_IRQ(i));
> +        connect_peripheral_irq(mc, sbd, cpudev, 3, TIMER_COMPC_IRQ(i));
> +        connect_peripheral_irq(mc, sbd, cpudev, 4, TIMER_OVF_IRQ(i));
> +        connect_power_reduction_gpio(s, mc, DEVICE(&s->timer[i]), idx);
> +        g_free(devname);
> +    }
> +
> +    create_unimplemented_device("avr-twi",          OFFSET_DATA + 0x0b8,
> 6);
> +    create_unimplemented_device("avr-adc",          OFFSET_DATA + 0x078,
> 8);
> +    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA + 0x074,
> 2);
> +    create_unimplemented_device("avr-watchdog",     OFFSET_DATA + 0x060,
> 1);
> +    create_unimplemented_device("avr-spi",          OFFSET_DATA + 0x04c,
> 3);
> +    create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f,
> 3);
> +}
> +
> +static Property atmega_props[] =3D {
> +    DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
> +                       xtal_freq_hz, 0),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void atmega_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D atmega_realize;
> +    dc->props =3D atmega_props;
> +    /* Reason: Mapped at fixed location on the system bus */
> +    dc->user_creatable =3D false;
> +}
> +
> +static void atmega168_class_init(ObjectClass *oc, void *data)
> +{
> +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> +
> +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
> +    amc->flash_size =3D 16 * KiB;
> +    amc->eeprom_size =3D 512;
> +    amc->sram_size =3D 1 * KiB;
> +    amc->io_size =3D 256;
> +    amc->gpio_count =3D 23;
> +    amc->adc_count =3D 6;
> +    amc->irq =3D irq168_328;
> +    amc->dev =3D dev168_328;
> +};
> +
> +static void atmega328_class_init(ObjectClass *oc, void *data)
> +{
> +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> +
> +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
> +    amc->flash_size =3D 32 * KiB;
> +    amc->eeprom_size =3D 1 * KiB;
> +    amc->sram_size =3D 2 * KiB;
> +    amc->io_size =3D 256;
> +    amc->gpio_count =3D 23;
> +    amc->adc_count =3D 6;
> +    amc->irq =3D irq168_328;
> +    amc->dev =3D dev168_328;
> +};
> +
> +static void atmega1280_class_init(ObjectClass *oc, void *data)
> +{
> +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> +
> +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
> +    amc->flash_size =3D 128 * KiB;
> +    amc->eeprom_size =3D 4 * KiB;
> +    amc->sram_size =3D 8 * KiB;
> +    amc->io_size =3D 512;
> +    amc->gpio_count =3D 86;
> +    amc->adc_count =3D 16;
> +    amc->irq =3D irq1280_2560;
> +    amc->dev =3D dev1280_2560;
> +};
> +
> +static void atmega2560_class_init(ObjectClass *oc, void *data)
> +{
> +    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
> +
> +    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
> +    amc->flash_size =3D 256 * KiB;
> +    amc->eeprom_size =3D 4 * KiB;
> +    amc->sram_size =3D 8 * KiB;
> +    amc->io_size =3D 512;
> +    amc->gpio_count =3D 54;
> +    amc->adc_count =3D 16;
> +    amc->irq =3D irq1280_2560;
> +    amc->dev =3D dev1280_2560;
> +};
> +
> +static const TypeInfo atmega_mcu_types[] =3D {
> +    {
> +        .name           =3D TYPE_ATMEGA168_MCU,
> +        .parent         =3D TYPE_ATMEGA_MCU,
> +        .class_init     =3D atmega168_class_init,
> +    }, {
> +        .name           =3D TYPE_ATMEGA328_MCU,
> +        .parent         =3D TYPE_ATMEGA_MCU,
> +        .class_init     =3D atmega328_class_init,
> +    }, {
> +        .name           =3D TYPE_ATMEGA1280_MCU,
> +        .parent         =3D TYPE_ATMEGA_MCU,
> +        .class_init     =3D atmega1280_class_init,
> +    }, {
> +        .name           =3D TYPE_ATMEGA2560_MCU,
> +        .parent         =3D TYPE_ATMEGA_MCU,
> +        .class_init     =3D atmega2560_class_init,
> +    }, {
> +        .name           =3D TYPE_ATMEGA_MCU,
> +        .parent         =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size  =3D sizeof(AtmegaMcuState),
> +        .class_size     =3D sizeof(AtmegaMcuClass),
> +        .class_init     =3D atmega_class_init,
> +        .abstract       =3D true,
> +    }
> +};
> +
> +DEFINE_TYPES(atmega_mcu_types)
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> new file mode 100644
> index 0000000000..da3b10afec
> --- /dev/null
> +++ b/hw/avr/Kconfig
> @@ -0,0 +1,5 @@
> +config ATMEL_ATMEGA_MCU
> +    bool
> +    select ATMEL_TIMER16
> +    select ATMEL_USART
> +    select ATMEL_POWER
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> index 123f174f0e..1f73fd5469 100644
> --- a/hw/avr/Makefile.objs
> +++ b/hw/avr/Makefile.objs
> @@ -1 +1,2 @@
>  obj-y +=3D boot.o
> +obj-$(CONFIG_ATMEL_ATMEGA_MCU) +=3D atmel_atmega.o
> --
> 2.21.1
>
>

--000000000000de9fa9059d0c0e24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 24, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Add some microcontrollers from the megaAVR family (ATmeg=
a series):<br>
<br>
- middle range: ATmega168 and ATmega328<br>
- high range: ATmega1280 and ATmega2560<br>
<br>
For product comparison:<br>
=C2=A0 <a href=3D"https://www.microchip.com/wwwproducts/ProductCompare/ATme=
ga168P/ATmega328P" target=3D"_blank">https://www.microchip.com/<wbr>wwwprod=
ucts/ProductCompare/<wbr>ATmega168P/ATmega328P</a><br>
=C2=A0 <a href=3D"https://www.microchip.com/wwwproducts/ProductCompare/ATme=
ga1280/ATmega2560" target=3D"_blank">https://www.microchip.com/<wbr>wwwprod=
ucts/ProductCompare/<wbr>ATmega1280/ATmega2560</a><br>
<br>
Datasheets:<br>
=C2=A0 <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A=
-PA-88A-PA-168A-PA-328-P-DS-DS40002061A.pdf" target=3D"_blank">http://ww1.m=
icrochip.com/<wbr>downloads/en/DeviceDoc/<wbr>ATmega48A-PA-88A-PA-168A-PA-<=
wbr>328-P-DS-DS40002061A.pdf</a><br>
=C2=A0 <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-254=
9-8-bit-AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf" ta=
rget=3D"_blank">http://ww1.microchip.com/<wbr>downloads/en/DeviceDoc/Atmel-=
<wbr>2549-8-bit-AVR-<wbr>Microcontroller-ATmega640-<wbr>1280-1281-2560-2561=
_datasheet.<wbr>pdf</a><br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20200120220107.17825-14-f4bug@amsat.org">=
20200120220107.17825-14-f4bug@amsat.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
---<br>
rc2:<br>
- Squashed Kconfig patch (Thomas)<br>
- Correct SRAM base address<br>
---<br>
=C2=A0hw/avr/atmel_atmega.h |=C2=A0 48 +++++<br>
=C2=A0hw/avr/atmel_atmega.c | 470 ++++++++++++++++++++++++++++++<wbr>++++++=
++++++<br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
=C2=A0hw/avr/Makefile.objs=C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A04 files changed, 524 insertions(+)<br>
=C2=A0create mode 100644 hw/avr/atmel_atmega.h<br>
=C2=A0create mode 100644 hw/avr/atmel_atmega.c<br>
=C2=A0create mode 100644 hw/avr/Kconfig<br>
<br></blockquote><div><br></div><div>This patch introduces a terminology co=
nfusion that will be difficult to eliminate once the code is in the tree.</=
div><div><br></div><div>&quot;AVR&quot; is the name (or, if someone wishes,=
 the common name prefix) of the family of all MCUs covered in this series. =
This is reflected in the existence of the directory &quot;hw/avr&quot;, and=
 this is, in my opinion fine.</div><div><br></div><div>&quot;Atmel&quot; is=
 the company that used to design AVR MCUs (there are hundreds of such MCUs)=
. &quot;Atmel&quot; was acquired several=C2=A0years ago by another company,=
 &quot;Microchip&quot;. Trere is no element in AVR MCUs&#39; docimentation =
that reffers to the producers (except title, copyright, etc). In all recent=
 docs, &quot;Atmel&quot; is complely eradicated.</div><div><br></div><div>T=
herefore, using the name of non-existant company &quot;Atmel&quot; is confu=
sing, and, moreover, completely unnecessary. Please, remove references to &=
quot;Atmel&quot; from file names, and from the code.</div><div><br></div><d=
iv>Thanks, Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
diff --git a/hw/avr/atmel_atmega.h b/hw/avr/atmel_atmega.h<br>
new file mode 100644<br>
index 0000000000..391b8b1bf8<br>
--- /dev/null<br>
+++ b/hw/avr/atmel_atmega.h<br>
@@ -0,0 +1,48 @@<br>
+/*<br>
+ * QEMU ATmega MCU<br>
+ *<br>
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPLv2 or later.<br>
+ * See the COPYING file in the top-level directory.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HW_AVR_ATMEL_ATMEGA_H<br>
+#define HW_AVR_ATMEL_ATMEGA_H<br>
+<br>
+#include &quot;hw/char/atmel_usart.h&quot;<br>
+#include &quot;hw/timer/atmel_timer16.h&quot;<br>
+#include &quot;hw/misc/atmel_power.h&quot;<br>
+#include &quot;target/avr/cpu.h&quot;<br>
+<br>
+#define TYPE_ATMEGA_MCU=C2=A0 =C2=A0 =C2=A0&quot;ATmega&quot;<br>
+#define TYPE_ATMEGA168_MCU=C2=A0 &quot;ATmega168&quot;<br>
+#define TYPE_ATMEGA328_MCU=C2=A0 &quot;ATmega328&quot;<br>
+#define TYPE_ATMEGA1280_MCU &quot;ATmega1280&quot;<br>
+#define TYPE_ATMEGA2560_MCU &quot;ATmega2560&quot;<br>
+<br>
+#define ATMEGA_MCU(obj) OBJECT_CHECK(AtmegaMcuState, (obj), TYPE_ATMEGA_MC=
U)<br>
+<br>
+#define POWER_MAX 2<br>
+#define USART_MAX 4<br>
+#define TIMER_MAX 6<br>
+#define GPIO_MAX 12<br>
+<br>
+typedef struct AtmegaMcuState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 AVRCPU cpu;<br>
+=C2=A0 =C2=A0 MemoryRegion flash;<br>
+=C2=A0 =C2=A0 MemoryRegion eeprom;<br>
+=C2=A0 =C2=A0 MemoryRegion sram;<br>
+=C2=A0 =C2=A0 DeviceState *io;<br>
+=C2=A0 =C2=A0 AVRMaskState pwr[POWER_MAX];<br>
+=C2=A0 =C2=A0 AVRUsartState usart[USART_MAX];<br>
+=C2=A0 =C2=A0 AVRTimer16State timer[TIMER_MAX];<br>
+=C2=A0 =C2=A0 uint64_t xtal_freq_hz;<br>
+} AtmegaMcuState;<br>
+<br>
+#endif /* HW_AVR_ATMEL_ATMEGA_H */<br>
diff --git a/hw/avr/atmel_atmega.c b/hw/avr/atmel_atmega.c<br>
new file mode 100644<br>
index 0000000000..790c374dee<br>
--- /dev/null<br>
+++ b/hw/avr/atmel_atmega.c<br>
@@ -0,0 +1,470 @@<br>
+/*<br>
+ * QEMU ATmega MCU<br>
+ *<br>
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPLv2 or later.<br>
+ * See the COPYING file in the top-level directory.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;exec/memory.h&quot;<br>
+#include &quot;exec/address-spaces.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/boards.h&quot; /* FIXME memory_region_allocate_system_<w=
br>memory for sram */<br>
+#include &quot;hw/misc/unimp.h&quot;<br>
+#include &quot;atmel_atmega.h&quot;<br>
+<br>
+enum AtmegaPeripheral {<br>
+=C2=A0 =C2=A0 POWER0, POWER1,<br>
+=C2=A0 =C2=A0 GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF,<br>
+=C2=A0 =C2=A0 GPIOG, GPIOH, GPIOI, GPIOJ, GPIOK, GPIOL,<br>
+=C2=A0 =C2=A0 USART0, USART1, USART2, USART3,<br>
+=C2=A0 =C2=A0 TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,<br>
+=C2=A0 =C2=A0 PERIFMAX<br>
+};<br>
+<br>
+#define GPIO(n)=C2=A0 =C2=A0 =C2=A0(n + GPIOA)<br>
+#define USART(n)=C2=A0 =C2=A0 (n + USART0)<br>
+#define TIMER(n)=C2=A0 =C2=A0 (n + TIMER0)<br>
+#define POWER(n)=C2=A0 =C2=A0 (n + POWER0)<br>
+<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 uint16_t addr;<br>
+=C2=A0 =C2=A0 enum AtmegaPeripheral power_index;<br>
+=C2=A0 =C2=A0 uint8_t power_bit;<br>
+=C2=A0 =C2=A0 /* timer specific */<br>
+=C2=A0 =C2=A0 uint16_t intmask_addr;<br>
+=C2=A0 =C2=A0 uint16_t intflag_addr;<br>
+=C2=A0 =C2=A0 bool is_timer16;<br>
+} peripheral_cfg;<br>
+<br>
+typedef struct AtmegaMcuClass {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDeviceClass parent_class;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+=C2=A0 =C2=A0 const char *uc_name;<br>
+=C2=A0 =C2=A0 const char *cpu_type;<br>
+=C2=A0 =C2=A0 size_t flash_size;<br>
+=C2=A0 =C2=A0 size_t eeprom_size;<br>
+=C2=A0 =C2=A0 size_t sram_size;<br>
+=C2=A0 =C2=A0 size_t io_size;<br>
+=C2=A0 =C2=A0 size_t gpio_count;<br>
+=C2=A0 =C2=A0 size_t adc_count;<br>
+=C2=A0 =C2=A0 const uint8_t *irq;<br>
+=C2=A0 =C2=A0 const peripheral_cfg *dev;<br>
+} AtmegaMcuClass;<br>
+<br>
+#define ATMEGA_MCU_CLASS(klass) \<br>
+=C2=A0 =C2=A0 OBJECT_CLASS_CHECK(<wbr>AtmegaMcuClass, (klass), TYPE_ATMEGA=
_MCU)<br>
+#define ATMEGA_MCU_GET_CLASS(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_GET_CLASS(<wbr>AtmegaMcuClass, (obj), TYPE_ATMEGA_MCU=
)<br>
+<br>
+static const peripheral_cfg dev168_328[PERIFMAX] =3D {<br>
+=C2=A0 =C2=A0 [USART0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc0, POWER0=
, 1 },<br>
+=C2=A0 =C2=A0 [TIMER2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xb0, POWER0=
, 6, 0x70, 0x37, false },<br>
+=C2=A0 =C2=A0 [TIMER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x80, POWER0=
, 3, 0x6f, 0x36, true },<br>
+=C2=A0 =C2=A0 [POWER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x64 },<br>
+=C2=A0 =C2=A0 [TIMER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x44, POWER0=
, 5, 0x6e, 0x35, false },<br>
+=C2=A0 =C2=A0 [GPIOD]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x29 },=
<br>
+=C2=A0 =C2=A0 [GPIOC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x26 },=
<br>
+=C2=A0 =C2=A0 [GPIOB]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x23 },=
<br>
+}, dev1280_2560[PERIFMAX] =3D {<br>
+=C2=A0 =C2=A0 [USART3]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { 0x130, POWER1, 2 }=
,<br>
+=C2=A0 =C2=A0 [TIMER5]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { 0x120, POWER1, 5, =
0x73, 0x3a, true },<br>
+=C2=A0 =C2=A0 [GPIOL]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x109 },<br>
+=C2=A0 =C2=A0 [GPIOK]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x106 },<br>
+=C2=A0 =C2=A0 [GPIOJ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x103 },<br>
+=C2=A0 =C2=A0 [GPIOH]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D { 0x100 },<br>
+=C2=A0 =C2=A0 [USART2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xd0, POWER1=
, 1 },<br>
+=C2=A0 =C2=A0 [USART1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc8, POWER1=
, 0 },<br>
+=C2=A0 =C2=A0 [USART0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xc0, POWER0=
, 1 },<br>
+=C2=A0 =C2=A0 [TIMER2]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xb0, POWER0=
, 6, 0x70, 0x37, false }, /* TODO async */<br>
+=C2=A0 =C2=A0 [TIMER4]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0xa0, POWER1=
, 4, 0x72, 0x39, true },<br>
+=C2=A0 =C2=A0 [TIMER3]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x90, POWER1=
, 3, 0x71, 0x38, true },<br>
+=C2=A0 =C2=A0 [TIMER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x80, POWER0=
, 3, 0x6f, 0x36, true },<br>
+=C2=A0 =C2=A0 [POWER1]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x65 },<br>
+=C2=A0 =C2=A0 [POWER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x64 },<br>
+=C2=A0 =C2=A0 [TIMER0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {=C2=A0 0x44, POWER0=
, 5, 0x6e, 0x35, false },<br>
+=C2=A0 =C2=A0 [GPIOG]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x32 },=
<br>
+=C2=A0 =C2=A0 [GPIOF]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x2f },=
<br>
+=C2=A0 =C2=A0 [GPIOE]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x2c },=
<br>
+=C2=A0 =C2=A0 [GPIOD]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x29 },=
<br>
+=C2=A0 =C2=A0 [GPIOC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x26 },=
<br>
+=C2=A0 =C2=A0 [GPIOB]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x23 },=
<br>
+=C2=A0 =C2=A0 [GPIOA]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D {=C2=A0 0x20 },=
<br>
+};<br>
+<br>
+enum AtmegaIrq {<br>
+=C2=A0 =C2=A0 USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,<br>
+=C2=A0 =C2=A0 USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,<br>
+=C2=A0 =C2=A0 USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,<br>
+=C2=A0 =C2=A0 USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,<br>
+=C2=A0 =C2=A0 TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,<br>
+=C2=A0 =C2=A0 TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,<br>
+=C2=A0 =C2=A0 IRQ_COUNT<br>
+};<br>
+<br>
+#define USART_IRQ_COUNT=C2=A0 =C2=A0 =C2=A03<br>
+#define USART_RXC_IRQ(n)=C2=A0 =C2=A0 (n * USART_IRQ_COUNT + USART0_RXC_IR=
Q)<br>
+#define USART_DRE_IRQ(n)=C2=A0 =C2=A0 (n * USART_IRQ_COUNT + USART0_DRE_IR=
Q)<br>
+#define USART_TXC_IRQ(n)=C2=A0 =C2=A0 (n * USART_IRQ_COUNT + USART0_TXC_IR=
Q)<br>
+#define TIMER_IRQ_COUNT=C2=A0 =C2=A0 =C2=A05<br>
+#define TIMER_CAPT_IRQ(n)=C2=A0 =C2=A0(n * TIMER_IRQ_COUNT + TIMER0_CAPT_I=
RQ)<br>
+#define TIMER_COMPA_IRQ(n)=C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_COMPA_IRQ)<=
br>
+#define TIMER_COMPB_IRQ(n)=C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_COMPB_IRQ)<=
br>
+#define TIMER_COMPC_IRQ(n)=C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_COMPC_IRQ)<=
br>
+#define TIMER_OVF_IRQ(n)=C2=A0 =C2=A0 (n * TIMER_IRQ_COUNT + TIMER0_OVF_IR=
Q)<br>
+<br>
+static const uint8_t irq168_328[IRQ_COUNT] =3D {<br>
+=C2=A0 =C2=A0 [TIMER2_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 8,<br>
+=C2=A0 =C2=A0 [TIMER2_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 9,<br>
+=C2=A0 =C2=A0 [TIMER2_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 10,<br>
+=C2=A0 =C2=A0 [TIMER1_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 11,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 12,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 13,<br>
+=C2=A0 =C2=A0 [TIMER1_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 14,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 16,<br>
+=C2=A0 =C2=A0 [TIMER0_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 17,<br>
+=C2=A0 =C2=A0 [USART0_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 19,<br>
+=C2=A0 =C2=A0 [USART0_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 20,<br>
+=C2=A0 =C2=A0 [USART0_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 21,<br>
+}, irq1280_2560[IRQ_COUNT] =3D {<br>
+=C2=A0 =C2=A0 [TIMER2_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 14,<br>
+=C2=A0 =C2=A0 [TIMER2_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
+=C2=A0 =C2=A0 [TIMER2_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 16,<br>
+=C2=A0 =C2=A0 [TIMER1_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 17,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 18,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 19,<br>
+=C2=A0 =C2=A0 [TIMER1_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 20,<br>
+=C2=A0 =C2=A0 [TIMER1_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 21,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 22,<br>
+=C2=A0 =C2=A0 [TIMER0_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 23,<br>
+=C2=A0 =C2=A0 [TIMER0_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 24,<br>
+=C2=A0 =C2=A0 [USART0_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 26,<br>
+=C2=A0 =C2=A0 [USART0_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 27,<br>
+=C2=A0 =C2=A0 [USART0_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 28,<br>
+=C2=A0 =C2=A0 [TIMER3_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 32,<br>
+=C2=A0 =C2=A0 [TIMER3_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 33,<br>
+=C2=A0 =C2=A0 [TIMER3_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 34,<br>
+=C2=A0 =C2=A0 [TIMER3_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 35,<br>
+=C2=A0 =C2=A0 [TIMER3_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 36,<br>
+=C2=A0 =C2=A0 [USART1_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 37,<br>
+=C2=A0 =C2=A0 [USART1_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 38,<br>
+=C2=A0 =C2=A0 [USART1_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 39,<br>
+=C2=A0 =C2=A0 [TIMER4_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 42,<br>
+=C2=A0 =C2=A0 [TIMER4_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 43,<br>
+=C2=A0 =C2=A0 [TIMER4_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 44,<br>
+=C2=A0 =C2=A0 [TIMER4_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 45,<br>
+=C2=A0 =C2=A0 [TIMER4_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 46,<br>
+=C2=A0 =C2=A0 [TIMER5_CAPT_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 47,<br>
+=C2=A0 =C2=A0 [TIMER5_COMPA_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 48,<br>
+=C2=A0 =C2=A0 [TIMER5_COMPB_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 49,<br>
+=C2=A0 =C2=A0 [TIMER5_COMPC_IRQ]=C2=A0 =C2=A0 =C2=A0 =3D 50,<br>
+=C2=A0 =C2=A0 [TIMER5_OVF_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 51,<br>
+=C2=A0 =C2=A0 [USART2_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 52,<br>
+=C2=A0 =C2=A0 [USART2_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 53,<br>
+=C2=A0 =C2=A0 [USART2_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 54,<br>
+=C2=A0 =C2=A0 [USART3_RXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 55,<br>
+=C2=A0 =C2=A0 [USART3_DRE_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 56,<br>
+=C2=A0 =C2=A0 [USART3_TXC_IRQ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 57,<br>
+};<br>
+<br>
+static void connect_peripheral_irq(const AtmegaMcuClass *mc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SysBusDevice *sbd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *dev, int n=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned peripheral_irq=
)<br>
+{<br>
+=C2=A0 =C2=A0 int irq =3D mc-&gt;irq[peripheral_irq];<br>
+<br>
+=C2=A0 =C2=A0 if (!irq) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* FIXME move that to avr_cpu_set_int() once &#39;sample&#39=
; board is removed */<br>
+=C2=A0 =C2=A0 assert(irq &gt;=3D 2);<br>
+=C2=A0 =C2=A0 irq -=3D 2;<br>
+<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq));<br>
+}<br>
+<br>
+static void connect_power_reduction_gpio(<wbr>AtmegaMcuState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0co=
nst AtmegaMcuClass *mc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0De=
viceState *dev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t peripheral_index)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned power_index =3D mc-&gt;dev[peripheral_index].<wbr>p=
ower_index;<br>
+=C2=A0 =C2=A0 assert(mc-&gt;dev[power_index].<wbr>addr);<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(&amp;s-&gt;pwr[power_=
index - POWER0]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mc-&gt;dev[peripheral_index].<wbr>power_bit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(dev, 0));<br>
+}<br>
+<br>
+static void atmega_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 AtmegaMcuState *s =3D ATMEGA_MCU(dev);<br>
+=C2=A0 =C2=A0 const AtmegaMcuClass *mc =3D ATMEGA_MCU_GET_CLASS(dev);<br>
+=C2=A0 =C2=A0 DeviceState *cpudev;<br>
+=C2=A0 =C2=A0 SysBusDevice *sbd;<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 char *devname;<br>
+=C2=A0 =C2=A0 size_t i;<br>
+<br>
+=C2=A0 =C2=A0 assert(mc-&gt;io_size &lt;=3D 0x200);<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;xtal_freq_hz) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;\&quot;xtal-frequency-h=
z\&quot; property must be provided.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* CPU */<br>
+=C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), &quot;cpu&quot;, &=
amp;s-&gt;cpu, sizeof(s-&gt;cpu),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 mc-&gt;cpu_type, &amp;err, NULL);<br>
+=C2=A0 =C2=A0 if (err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&gt;cpu), true, =
&quot;realized&quot;, &amp;error_abort);<br>
+=C2=A0 =C2=A0 cpudev =3D DEVICE(&amp;s-&gt;cpu);<br>
+<br>
+=C2=A0 =C2=A0 /* SRAM */<br>
+=C2=A0 =C2=A0 memory_region_init_ram(&amp;s-&gt;<wbr>sram, OBJECT(dev), &q=
uot;sram&quot;, mc-&gt;sram_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + mc-&gt;io_size, &amp;s=
-&gt;sram);<br>
+<br>
+=C2=A0 =C2=A0 /* Flash */<br>
+=C2=A0 =C2=A0 memory_region_init_rom(&amp;s-&gt;<wbr>flash, OBJECT(dev),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;flash&quot;, mc-&gt;flash_size, &amp;error_fa=
tal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(), OFFSET=
_CODE, &amp;s-&gt;flash);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* I/O<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* 0x00 - 0x1f: Registers<br>
+=C2=A0 =C2=A0 =C2=A0* 0x20 - 0x5f: I/O memory<br>
+=C2=A0 =C2=A0 =C2=A0* 0x60 - 0xff: Extended I/O<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 s-&gt;io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);<b=
r>
+=C2=A0 =C2=A0 qdev_prop_set_string(s-&gt;io, &quot;name&quot;, &quot;I/O&q=
uot;);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(s-&gt;io, &quot;size&quot;, mc-&gt;io_s=
ize);<br>
+=C2=A0 =C2=A0 qdev_init_nofail(s-&gt;io);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map_overlap(SYS_<wbr>BUS_DEVICE(s-&gt;io), 0, OF=
FSET_DATA, -1234);<br>
+<br>
+=C2=A0 =C2=A0 /* Power Reduction */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; POWER_MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D POWER(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc-&gt;dev[idx].addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;power%zu&quo=
t;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), devn=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;pwr[i], sizeof(s-&gt;pwr[=
i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_MASK, &amp;error_abort, NUL=
L);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&g=
t;pwr[i]), true, &quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_<wbr>DEVICE(&amp;s-&gt=
;pwr[i]), 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OFFSET_DATA + mc-&gt;dev[idx].addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* GPIO */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPIO_MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D GPIO(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc-&gt;dev[idx].addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;avr-gpio-%c&=
quot;, &#39;a&#39; + (char)i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(<wbr>devname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + mc-&gt;d=
ev[idx].addr, 3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* USART */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; USART_MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D USART(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc-&gt;dev[idx].addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;usart%zu&quo=
t;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), devn=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;usart[i], sizeof(s-&gt;us=
art[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_USART, &amp;error_abort, NU=
LL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(&amp;s-&gt;<wbr>usart=
[i]), &quot;chardev&quot;, serial_hd(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&g=
t;usart[i]), true, &quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(&amp;s-&gt;usart[i]);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc-&gt;d=
ev[USART(i)].addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 0, USA=
RT_RXC_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 1, USA=
RT_DRE_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 2, USA=
RT_TXC_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_power_reduction_gpio(<wbr>s, mc, DEVIC=
E(&amp;s-&gt;usart[i]), idx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Timer */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; TIMER_MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx =3D TIMER(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc-&gt;dev[idx].addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mc-&gt;dev[idx].is_timer16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(&quo=
t;<wbr>avr-timer8&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_D=
ATA + mc-&gt;dev[idx].addr, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(&quo=
t;<wbr>avr-timer8-intmask&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_D=
ATA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + mc-&gt=
;dev[idx].intmask_addr, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_unimplemented_device(&quo=
t;<wbr>avr-timer8-intflag&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_D=
ATA<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + mc-&gt=
;dev[idx].intflag_addr, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 devname =3D g_strdup_printf(&quot;timer%zu&quo=
t;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(<wbr>OBJECT(dev), devn=
ame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;timer[i], sizeof(s-&gt;ti=
mer[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AVR_TIMER16, &amp;error_abort, =
NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_uint(<wbr>OBJECT(&amp;s-&g=
t;timer[i]), s-&gt;xtal_freq_hz,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cpu-frequency-hz&quot;, =
&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&g=
t;timer[i]), true, &quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sbd =3D SYS_BUS_DEVICE(&amp;s-&gt;timer[i]);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc-&gt;d=
ev[idx].addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 1, OFFSET_DATA + mc-&gt;d=
ev[idx].intmask_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(sbd, 2, OFFSET_DATA + mc-&gt;d=
ev[idx].intflag_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 0, TIM=
ER_CAPT_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 1, TIM=
ER_COMPA_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 2, TIM=
ER_COMPB_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 3, TIM=
ER_COMPC_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_peripheral_irq(mc, sbd, cpudev, 4, TIM=
ER_OVF_IRQ(i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 connect_power_reduction_gpio(<wbr>s, mc, DEVIC=
E(&amp;s-&gt;timer[i]), idx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>avr-twi&quot;,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x0b8, 6);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>avr-adc&quot;,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x078, 8);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>avr-ext-mem-ctrl&quot=
;, OFFSET_DATA + 0x074, 2);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>avr-watchdog&quot;,=
=C2=A0 =C2=A0 =C2=A0OFFSET_DATA + 0x060, 1);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>avr-spi&quot;,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_DATA + 0x04c, 3);<br>
+=C2=A0 =C2=A0 create_unimplemented_device(&quot;<wbr>avr-eeprom&quot;,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0OFFSET_DATA + 0x03f, 3);<br>
+}<br>
+<br>
+static Property atmega_props[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;xtal-<wbr>frequency-hz&quot;, Atmeg=
aMcuState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xtal_freq_hz, 0),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST()<br>
+};<br>
+<br>
+static void atmega_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D atmega_realize;<br>
+=C2=A0 =C2=A0 dc-&gt;props =3D atmega_props;<br>
+=C2=A0 =C2=A0 /* Reason: Mapped at fixed location on the system bus */<br>
+=C2=A0 =C2=A0 dc-&gt;user_creatable =3D false;<br>
+}<br>
+<br>
+static void atmega168_class_init(<wbr>ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 amc-&gt;cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr5&quot;);<br=
>
+=C2=A0 =C2=A0 amc-&gt;flash_size =3D 16 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;eeprom_size =3D 512;<br>
+=C2=A0 =C2=A0 amc-&gt;sram_size =3D 1 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;io_size =3D 256;<br>
+=C2=A0 =C2=A0 amc-&gt;gpio_count =3D 23;<br>
+=C2=A0 =C2=A0 amc-&gt;adc_count =3D 6;<br>
+=C2=A0 =C2=A0 amc-&gt;irq =3D irq168_328;<br>
+=C2=A0 =C2=A0 amc-&gt;dev =3D dev168_328;<br>
+};<br>
+<br>
+static void atmega328_class_init(<wbr>ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 amc-&gt;cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr5&quot;);<br=
>
+=C2=A0 =C2=A0 amc-&gt;flash_size =3D 32 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;eeprom_size =3D 1 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;sram_size =3D 2 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;io_size =3D 256;<br>
+=C2=A0 =C2=A0 amc-&gt;gpio_count =3D 23;<br>
+=C2=A0 =C2=A0 amc-&gt;adc_count =3D 6;<br>
+=C2=A0 =C2=A0 amc-&gt;irq =3D irq168_328;<br>
+=C2=A0 =C2=A0 amc-&gt;dev =3D dev168_328;<br>
+};<br>
+<br>
+static void atmega1280_class_init(<wbr>ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 amc-&gt;cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr6&quot;);<br=
>
+=C2=A0 =C2=A0 amc-&gt;flash_size =3D 128 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;eeprom_size =3D 4 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;sram_size =3D 8 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;io_size =3D 512;<br>
+=C2=A0 =C2=A0 amc-&gt;gpio_count =3D 86;<br>
+=C2=A0 =C2=A0 amc-&gt;adc_count =3D 16;<br>
+=C2=A0 =C2=A0 amc-&gt;irq =3D irq1280_2560;<br>
+=C2=A0 =C2=A0 amc-&gt;dev =3D dev1280_2560;<br>
+};<br>
+<br>
+static void atmega2560_class_init(<wbr>ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 amc-&gt;cpu_type =3D AVR_CPU_TYPE_NAME(&quot;avr6&quot;);<br=
>
+=C2=A0 =C2=A0 amc-&gt;flash_size =3D 256 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;eeprom_size =3D 4 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;sram_size =3D 8 * KiB;<br>
+=C2=A0 =C2=A0 amc-&gt;io_size =3D 512;<br>
+=C2=A0 =C2=A0 amc-&gt;gpio_count =3D 54;<br>
+=C2=A0 =C2=A0 amc-&gt;adc_count =3D 16;<br>
+=C2=A0 =C2=A0 amc-&gt;irq =3D irq1280_2560;<br>
+=C2=A0 =C2=A0 amc-&gt;dev =3D dev1280_2560;<br>
+};<br>
+<br>
+static const TypeInfo atmega_mcu_types[] =3D {<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D TYPE_ATMEGA168_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D T=
YPE_ATMEGA_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmega168_c=
lass_init,<br>
+=C2=A0 =C2=A0 }, {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D TYPE_ATMEGA328_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D T=
YPE_ATMEGA_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmega328_c=
lass_init,<br>
+=C2=A0 =C2=A0 }, {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D TYPE_ATMEGA1280_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D T=
YPE_ATMEGA_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmega1280_=
class_init,<br>
+=C2=A0 =C2=A0 }, {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D TYPE_ATMEGA2560_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D T=
YPE_ATMEGA_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmega2560_=
class_init,<br>
+=C2=A0 =C2=A0 }, {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D TYPE_ATMEGA_MCU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D T=
YPE_SYS_BUS_DEVICE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size=C2=A0 =3D sizeof(AtmegaMcuState=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size=C2=A0 =C2=A0 =C2=A0=3D sizeof(Atme=
gaMcuClass),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D atmega_clas=
s_init,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D true,<=
br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+DEFINE_TYPES(atmega_mcu_<wbr>types)<br>
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
new file mode 100644<br>
index 0000000000..da3b10afec<br>
--- /dev/null<br>
+++ b/hw/avr/Kconfig<br>
@@ -0,0 +1,5 @@<br>
+config ATMEL_ATMEGA_MCU<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 select ATMEL_TIMER16<br>
+=C2=A0 =C2=A0 select ATMEL_USART<br>
+=C2=A0 =C2=A0 select ATMEL_POWER<br>
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs<br>
index 123f174f0e..1f73fd5469 100644<br>
--- a/hw/avr/Makefile.objs<br>
+++ b/hw/avr/Makefile.objs<br>
@@ -1 +1,2 @@<br>
=C2=A0obj-y +=3D boot.o<br>
+obj-$(CONFIG_ATMEL_ATMEGA_<wbr>MCU) +=3D atmel_atmega.o<br>
-- <br>
2.21.1<br>
<br>
</blockquote>

--000000000000de9fa9059d0c0e24--

