Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC34C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB44D2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACuau9WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB44D2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZJDI-0001hS-13
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZJCC-000185-2L
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZJC7-0004B8-6N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:34:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZJC2-00047W-KW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:34:41 -0500
Received: by mail-ot1-x344.google.com with SMTP id d5so13536408otp.4
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IRwYwl0WOvYLmUrqJBTLe1M8xX7czjtn8seHKY0u1OI=;
 b=ACuau9WEB6fM6PYNWmY0+JVxjOeKt3CAf5rSc9pwEwow42YbG+ZYRrSN0WnRQnYbO0
 P2ubSLSnAwdvGtJ9EDmDNTeWtLcHDlBUvVyNYmdtle2GrOZK6xgPNrIveW0111SbKKtN
 HyV07Tb5VVryQ9a9JSYeMY/eu4nd3OLlUMfb7BmEa9ppbAhh6x3SPcCKjG5olJasY2Xm
 Nx8gWVoQHJKEOQd8bZ0Ix+Uz2aApsjRI9Tgcec7+WIVONgVA0aeuE2ubki6ErL+OK89Q
 lIls5Z44DEnZr5IUB11NUWvV1ZozHFNxurxhk08z7uGUjnc53B1cvF3axs+e2+XW2IJf
 zI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IRwYwl0WOvYLmUrqJBTLe1M8xX7czjtn8seHKY0u1OI=;
 b=aqON/2vE+UgolYsoyqOF8QakObtQNZ6+20P3w+aFPw4ftj4tnMU71uXyjmonL4acbZ
 rE4ALOw/Xb4i72NPA/Ms7+TJIhU3XPNstarqDcvdl2nhhv37/SYpY14aXNrzER0Eujwi
 lZTvB+/5JoPUpgmnEUHDnJ3xQllZrcn6fk2tMMgIvSSyiXyT7llEw8Hy2enmQzCTiEgc
 Vyzpj/9ht2Y7DodNcr8fYGQytq/8OJdX0h7aWmdyPXTxW0+MPY7G4fHvvuBR+q4Cd+23
 vTTVm8LFjdKOVLV503+ec07YfhvLcK1IrBffYZVVYF6lEG3befPzXWuvJrZ7E8ujTpmC
 upjw==
X-Gm-Message-State: APjAAAUgwDNj7bcMAWPFl0KP+NM9HnEzCbsKKOod3fM1r/YT6MYQ4JEP
 V6PS7gy6v10ecCM4QpaZJe/u1qZkXUFp13te6BY=
X-Google-Smtp-Source: APXvYqwLekSiNub6oFiq+qYj9VxSBoHIebI2wMQyutpHileamop0uDroqVTUbfsL+V3FblYUnGKy019hM3cncq1t/LU=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr20233958otc.121.1574706875068; 
 Mon, 25 Nov 2019 10:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-11-mrolnik@gmail.com>
 <CAL1e-=hciFV8OjoiEBVz3B1ZWREh441M8PaESnQCafeSZX2WFw@mail.gmail.com>
 <20191125155638.4529e02722ad36231366dd09@kent.ac.uk>
In-Reply-To: <20191125155638.4529e02722ad36231366dd09@kent.ac.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 19:34:24 +0100
Message-ID: <CAL1e-=hqz04NLbrQbxMN70LVc-kaKjEK1waPJw8yyPQeqc=jZQ@mail.gmail.com>
Subject: Re: [PATCH v35 10/13] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: Sarah Harris <seh53@kent.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Thomas Huth <thuth@redhat.com>, "S.Harris" <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 4:56 PM Sarah Harris <seh53@kent.ac.uk> wrote:
>
> Hi Aleksandar,
>
> I think returning immediately should be ok, it just happened to make sense to me to think in terms of this being a special case of a normal read.
> The else handles the case in which no data has been received, but the user's program reads the incoming buffer anyway.
> (As far as I'm aware this is undefined behaviour, so returning zero is reasonable)
>

Since people were testing with the current code for some time, and
taking into account what Sarah just said, I suggest that we don't
change the code in question (leaving "data = 0;" line as is).

Thanks again,
Aleksandar

> Kind regards,
> Sarah Harris
>
>
> On Fri, 22 Nov 2019 17:48:56 +0100
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>
> > On Tue, Oct 29, 2019 at 10:25 PM Michael Rolnik <mrolnik@gmail.com> wrote:
> > >
> > > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> > >
> > > These were designed to facilitate testing but should provide enough function to be useful in other contexts.
> > > Only a subset of the functions of each peripheral is implemented, mainly due to the lack of a standard way to handle electrical connections (like GPIO pins).
> > >
> > > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > > ---
> > >  hw/char/Kconfig                |   3 +
> > >  hw/char/Makefile.objs          |   1 +
> > >  hw/char/avr_usart.c            | 324 ++++++++++++++++++
> > >  hw/misc/Kconfig                |   3 +
> > >  hw/misc/Makefile.objs          |   2 +
> > >  hw/misc/avr_mask.c             | 112 ++++++
> > >  hw/timer/Kconfig               |   3 +
> > >  hw/timer/Makefile.objs         |   2 +
> > >  hw/timer/avr_timer16.c         | 605 +++++++++++++++++++++++++++++++++
> > >  include/hw/char/avr_usart.h    |  97 ++++++
> > >  include/hw/misc/avr_mask.h     |  47 +++
> > >  include/hw/timer/avr_timer16.h |  97 ++++++
> > >  12 files changed, 1296 insertions(+)
> > >  create mode 100644 hw/char/avr_usart.c
> > >  create mode 100644 hw/misc/avr_mask.c
> > >  create mode 100644 hw/timer/avr_timer16.c
> > >  create mode 100644 include/hw/char/avr_usart.h
> > >  create mode 100644 include/hw/misc/avr_mask.h
> > >  create mode 100644 include/hw/timer/avr_timer16.h
> > >
> > > diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> > > index 40e7a8b8bb..331b20983f 100644
> > > --- a/hw/char/Kconfig
> > > +++ b/hw/char/Kconfig
> > > @@ -46,3 +46,6 @@ config SCLPCONSOLE
> > >
> > >  config TERMINAL3270
> > >      bool
> > > +
> > > +config AVR_USART
> > > +    bool
> > > diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> > > index 02d8a66925..f05c1f5667 100644
> > > --- a/hw/char/Makefile.objs
> > > +++ b/hw/char/Makefile.objs
> > > @@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
> > >  obj-$(CONFIG_DIGIC) += digic-uart.o
> > >  obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
> > >  obj-$(CONFIG_RASPI) += bcm2835_aux.o
> > > +common-obj-$(CONFIG_AVR_USART) += avr_usart.o
> > >
> > >  common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
> > >  common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
> > > diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
> > > new file mode 100644
> > > index 0000000000..9ca3c2a1cd
> > > --- /dev/null
> > > +++ b/hw/char/avr_usart.c
> > > @@ -0,0 +1,324 @@
> > > +/*
> > > + * AVR USART
> > > + *
> > > + * Copyright (c) 2018 University of Kent
> > > + * Author: Sarah Harris
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/char/avr_usart.h"
> > > +#include "qemu/log.h"
> > > +#include "hw/irq.h"
> > > +#include "hw/qdev-properties.h"
> > > +
> > > +static int avr_usart_can_receive(void *opaque)
> > > +{
> > > +    AVRUsartState *usart = opaque;
> > > +
> > > +    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
> > > +        return 0;
> > > +    }
> > > +    return 1;
> > > +}
> > > +
> > > +static void avr_usart_receive(void *opaque, const uint8_t *buffer, int size)
> > > +{
> > > +    AVRUsartState *usart = opaque;
> > > +    assert(size == 1);
> > > +    assert(!usart->data_valid);
> > > +    usart->data = buffer[0];
> > > +    usart->data_valid = true;
> > > +    usart->csra |= USART_CSRA_RXC;
> > > +    if (usart->csrb & USART_CSRB_RXCIE) {
> > > +        qemu_set_irq(usart->rxc_irq, 1);
> > > +    }
> > > +}
> > > +
> > > +static void update_char_mask(AVRUsartState *usart)
> > > +{
> > > +    uint8_t mode = ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0) |
> > > +        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
> > > +        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
> > > +    switch (mode) {
> > > +    case 0:
> > > +        usart->char_mask = 0b11111;
> > > +        break;
> > > +    case 1:
> > > +        usart->char_mask = 0b111111;
> > > +        break;
> > > +    case 2:
> > > +        usart->char_mask = 0b1111111;
> > > +        break;
> > > +    case 3:
> > > +        usart->char_mask = 0b11111111;
> > > +        break;
> > > +    case 4:
> > > +        /* Fallthrough. */
> > > +    case 5:
> > > +        /* Fallthrough. */
> > > +    case 6:
> > > +        qemu_log_mask(
> > > +            LOG_GUEST_ERROR,
> > > +            "%s: Reserved character size 0x%x\n",
> > > +            __func__,
> > > +            mode);
> > > +        break;
> > > +    case 7:
> > > +        qemu_log_mask(
> > > +            LOG_GUEST_ERROR,
> > > +            "%s: Nine bit character size not supported (forcing eight)\n",
> > > +            __func__);
> > > +        usart->char_mask = 0b11111111;
> > > +        break;
> > > +    default:
> > > +        assert(0);
> > > +    }
> > > +}
> > > +
> > > +static void avr_usart_reset(DeviceState *dev)
> > > +{
> > > +    AVRUsartState *usart = AVR_USART(dev);
> > > +    usart->data_valid = false;
> > > +    usart->csra = 0b00100000;
> > > +    usart->csrb = 0b00000000;
> > > +    usart->csrc = 0b00000110;
> > > +    usart->brrl = 0;
> > > +    usart->brrh = 0;
> > > +    update_char_mask(usart);
> > > +    qemu_set_irq(usart->rxc_irq, 0);
> > > +    qemu_set_irq(usart->txc_irq, 0);
> > > +    qemu_set_irq(usart->dre_irq, 0);
> > > +}
> > > +
> > > +static uint64_t avr_usart_read(void *opaque, hwaddr addr, unsigned int size)
> > > +{
> > > +    AVRUsartState *usart = opaque;
> > > +    uint8_t data;
> > > +    assert(size == 1);
> > > +
> > > +    if (!usart->enabled) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    switch (addr) {
> > > +    case USART_DR:
> > > +        if (!(usart->csrb & USART_CSRB_RXEN)) {
> > > +            /* Receiver disabled, ignore. */
> > > +            return 0;
> > > +        }
> > > +        if (usart->data_valid) {
> > > +            data = usart->data & usart->char_mask;
> > > +            usart->data_valid = false;
> > > +        } else {
> > > +            data = 0;
> > > +        }
> > > +        usart->csra &= 0xff ^ USART_CSRA_RXC;
> > > +        qemu_set_irq(usart->rxc_irq, 0);
> > > +        qemu_chr_fe_accept_input(&usart->chr);
> > > +        return data;
> >
> > Hi, Michael.
> >
> > Can you please explain to me why in the only "else" block within
> > avr_usart_read():
> >
> >         } else {
> >             data = 0;
> >         }
> >
> > we don't use "return 0;" instead of "data = 0;"?
> >
> > Yours,
> > Aleksandar
> >
> > > +    case USART_CSRA:
> > > +        return usart->csra;
> > > +    case USART_CSRB:
> > > +        return usart->csrb;
> > > +    case USART_CSRC:
> > > +        return usart->csrc;
> > > +    case USART_BRRL:
> > > +        return usart->brrl;
> > > +    case USART_BRRH:
> > > +        return usart->brrh;
> > > +    default:
> > > +        qemu_log_mask(
> > > +            LOG_GUEST_ERROR,
> > > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> > > +            __func__,
> > > +            addr);
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > > +static void avr_usart_write(void *opaque, hwaddr addr, uint64_t value,
> > > +                                unsigned int size)
> > > +{
> > > +    AVRUsartState *usart = opaque;
> > > +    uint8_t mask;
> > > +    uint8_t data;
> > > +    assert((value & 0xff) == value);
> > > +    assert(size == 1);
> > > +
> > > +    if (!usart->enabled) {
> > > +        return;
> > > +    }
> > > +
> > > +    switch (addr) {
> > > +    case USART_DR:
> > > +        if (!(usart->csrb & USART_CSRB_TXEN)) {
> > > +            /* Transmitter disabled, ignore. */
> > > +            return;
> > > +        }
> > > +        usart->csra |= USART_CSRA_TXC;
> > > +        usart->csra |= USART_CSRA_DRE;
> > > +        if (usart->csrb & USART_CSRB_TXCIE) {
> > > +            qemu_set_irq(usart->txc_irq, 1);
> > > +            usart->csra &= 0xff ^ USART_CSRA_TXC;
> > > +        }
> > > +        if (usart->csrb & USART_CSRB_DREIE) {
> > > +            qemu_set_irq(usart->dre_irq, 1);
> > > +        }
> > > +        data = value;
> > > +        qemu_chr_fe_write_all(&usart->chr, &data, 1);
> > > +        break;
> > > +    case USART_CSRA:
> > > +        mask = 0b01000011;
> > > +        /* Mask read-only bits. */
> > > +        value = (value & mask) | (usart->csra & (0xff ^ mask));
> > > +        usart->csra = value;
> > > +        if (value & USART_CSRA_TXC) {
> > > +            usart->csra ^= USART_CSRA_TXC;
> > > +            qemu_set_irq(usart->txc_irq, 0);
> > > +        }
> > > +        if (value & USART_CSRA_MPCM) {
> > > +            qemu_log_mask(
> > > +                LOG_GUEST_ERROR,
> > > +                "%s: MPCM not supported by USART\n",
> > > +                __func__);
> > > +        }
> > > +        break;
> > > +    case USART_CSRB:
> > > +        mask = 0b11111101;
> > > +        /* Mask read-only bits. */
> > > +        value = (value & mask) | (usart->csrb & (0xff ^ mask));
> > > +        usart->csrb = value;
> > > +        if (!(value & USART_CSRB_RXEN)) {
> > > +            /* Receiver disabled, flush input buffer. */
> > > +            usart->data_valid = false;
> > > +        }
> > > +        qemu_set_irq(usart->rxc_irq,
> > > +            ((value & USART_CSRB_RXCIE) &&
> > > +            (usart->csra & USART_CSRA_RXC)) ? 1 : 0);
> > > +        qemu_set_irq(usart->txc_irq,
> > > +            ((value & USART_CSRB_TXCIE) &&
> > > +            (usart->csra & USART_CSRA_TXC)) ? 1 : 0);
> > > +        qemu_set_irq(usart->dre_irq,
> > > +            ((value & USART_CSRB_DREIE) &&
> > > +            (usart->csra & USART_CSRA_DRE)) ? 1 : 0);
> > > +        update_char_mask(usart);
> > > +        break;
> > > +    case USART_CSRC:
> > > +        usart->csrc = value;
> > > +        if ((value & USART_CSRC_MSEL1) && (value & USART_CSRC_MSEL0)) {
> > > +            qemu_log_mask(
> > > +                LOG_GUEST_ERROR,
> > > +                "%s: SPI mode not supported by USART\n",
> > > +                __func__);
> > > +        }
> > > +        if ((value & USART_CSRC_MSEL1) && !(value & USART_CSRC_MSEL0)) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART mode\n", __func__);
> > > +        }
> > > +        if (!(value & USART_CSRC_PM1) && (value & USART_CSRC_PM0)) {
> > > +            qemu_log_mask(
> > > +                LOG_GUEST_ERROR,
> > > +                "%s: Bad USART parity mode\n",
> > > +                __func__);
> > > +        }
> > > +        update_char_mask(usart);
> > > +        break;
> > > +    case USART_BRRL:
> > > +        usart->brrl = value;
> > > +        break;
> > > +    case USART_BRRH:
> > > +        usart->brrh = value & 0b00001111;
> > > +        break;
> > > +    default:
> > > +        qemu_log_mask(
> > > +            LOG_GUEST_ERROR,
> > > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> > > +            __func__,
> > > +            addr);
> > > +    }
> > > +}
> > > +
> > > +static const MemoryRegionOps avr_usart_ops = {
> > > +    .read = avr_usart_read,
> > > +    .write = avr_usart_write,
> > > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .impl = {.min_access_size = 1, .max_access_size = 1}
> > > +};
> > > +
> > > +static Property avr_usart_properties[] = {
> > > +    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void avr_usart_pr(void *opaque, int irq, int level)
> > > +{
> > > +    AVRUsartState *s = AVR_USART(opaque);
> > > +
> > > +    s->enabled = !level;
> > > +
> > > +    if (!s->enabled) {
> > > +        avr_usart_reset(DEVICE(s));
> > > +    }
> > > +}
> > > +
> > > +static void avr_usart_init(Object *obj)
> > > +{
> > > +    AVRUsartState *s = AVR_USART(obj);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
> > > +    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 8);
> > > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > > +    qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
> > > +    s->enabled = true;
> > > +}
> > > +
> > > +static void avr_usart_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    AVRUsartState *s = AVR_USART(dev);
> > > +    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
> > > +                             avr_usart_receive, NULL, NULL,
> > > +                             s, NULL, true);
> > > +    avr_usart_reset(dev);
> > > +}
> > > +
> > > +static void avr_usart_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > > +
> > > +    dc->reset = avr_usart_reset;
> > > +    dc->props = avr_usart_properties;
> > > +    dc->realize = avr_usart_realize;
> > > +}
> > > +
> > > +static const TypeInfo avr_usart_info = {
> > > +    .name          = TYPE_AVR_USART,
> > > +    .parent        = TYPE_SYS_BUS_DEVICE,
> > > +    .instance_size = sizeof(AVRUsartState),
> > > +    .instance_init = avr_usart_init,
> > > +    .class_init    = avr_usart_class_init,
> > > +};
> > > +
> > > +static void avr_usart_register_types(void)
> > > +{
> > > +    type_register_static(&avr_usart_info);
> > > +}
> > > +
> > > +type_init(avr_usart_register_types)
> > > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > > index 2164646553..e79841e3a4 100644
> > > --- a/hw/misc/Kconfig
> > > +++ b/hw/misc/Kconfig
> > > @@ -125,4 +125,7 @@ config MAC_VIA
> > >      select MOS6522
> > >      select ADB
> > >
> > > +config AVR_MASK
> > > +    bool
> > > +
> > >  source macio/Kconfig
> > > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> > > index ba898a5781..3a8093be6a 100644
> > > --- a/hw/misc/Makefile.objs
> > > +++ b/hw/misc/Makefile.objs
> > > @@ -82,3 +82,5 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
> > >  obj-$(CONFIG_MAC_VIA) += mac_via.o
> > >
> > >  common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
> > > +
> > > +obj-$(CONFIG_AVR_MASK) += avr_mask.o
> > > diff --git a/hw/misc/avr_mask.c b/hw/misc/avr_mask.c
> > > new file mode 100644
> > > index 0000000000..3af82ed9c1
> > > --- /dev/null
> > > +++ b/hw/misc/avr_mask.c
> > > @@ -0,0 +1,112 @@
> > > +/*
> > > + * AVR Power Reduction
> > > + *
> > > + * Copyright (c) 2019 Michael Rolnik
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/misc/avr_mask.h"
> > > +#include "qemu/log.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "hw/irq.h"
> > > +
> > > +#define DB_PRINT(fmt, args...) /* Nothing */
> > > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args)*/
> > > +
> > > +static void avr_mask_reset(DeviceState *dev)
> > > +{
> > > +    AVRMaskState *s = AVR_MASK(dev);
> > > +
> > > +    s->val = 0x00;
> > > +
> > > +    for (int i = 0; i < 8; i++) {
> > > +        qemu_set_irq(s->irq[i], 0);
> > > +    }
> > > +}
> > > +
> > > +static uint64_t avr_mask_read(void *opaque, hwaddr offset, unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    assert(offset == 0);
> > > +    AVRMaskState *s = opaque;
> > > +
> > > +    return (uint64_t)s->val;
> > > +}
> > > +
> > > +static void avr_mask_write(void *opaque, hwaddr offset,
> > > +                              uint64_t val64, unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    assert(offset == 0);
> > > +    AVRMaskState *s = opaque;
> > > +    uint8_t val8 = val64;
> > > +
> > > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> > > +
> > > +    s->val = val8;
> > > +    for (int i = 0; i < 8; i++) {
> > > +        qemu_set_irq(s->irq[i], (val8 & (1 << i)) != 0);
> > > +    }
> > > +}
> > > +
> > > +static const MemoryRegionOps avr_mask_ops = {
> > > +    .read = avr_mask_read,
> > > +    .write = avr_mask_write,
> > > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .impl = {.max_access_size = 1}
> > > +};
> > > +
> > > +static void avr_mask_init(Object *dev)
> > > +{
> > > +    AVRMaskState *s = AVR_MASK(dev);
> > > +    SysBusDevice *busdev = SYS_BUS_DEVICE(dev);
> > > +
> > > +    memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
> > > +            0x01);
> > > +    sysbus_init_mmio(busdev, &s->iomem);
> > > +
> > > +    for (int i = 0; i < 8; i++) {
> > > +        sysbus_init_irq(busdev, &s->irq[i]);
> > > +    }
> > > +    s->val = 0x00;
> > > +}
> > > +
> > > +static void avr_mask_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > > +
> > > +    dc->reset = avr_mask_reset;
> > > +}
> > > +
> > > +static const TypeInfo avr_mask_info = {
> > > +    .name          = TYPE_AVR_MASK,
> > > +    .parent        = TYPE_SYS_BUS_DEVICE,
> > > +    .instance_size = sizeof(AVRMaskState),
> > > +    .class_init    = avr_mask_class_init,
> > > +    .instance_init = avr_mask_init,
> > > +};
> > > +
> > > +static void avr_mask_register_types(void)
> > > +{
> > > +    type_register_static(&avr_mask_info);
> > > +}
> > > +
> > > +type_init(avr_mask_register_types)
> > > diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> > > index a990f9fe35..4343bc23f3 100644
> > > --- a/hw/timer/Kconfig
> > > +++ b/hw/timer/Kconfig
> > > @@ -34,3 +34,6 @@ config CMSDK_APB_TIMER
> > >  config CMSDK_APB_DUALTIMER
> > >      bool
> > >      select PTIMER
> > > +
> > > +config AVR_TIMER16
> > > +    bool
> > > diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> > > index dece235fd7..af0913ca3b 100644
> > > --- a/hw/timer/Makefile.objs
> > > +++ b/hw/timer/Makefile.objs
> > > @@ -35,3 +35,5 @@ common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
> > >  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
> > >  common-obj-$(CONFIG_MSF2) += mss-timer.o
> > >  common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
> > > +
> > > +obj-$(CONFIG_AVR_TIMER16) += avr_timer16.o
> > > diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
> > > new file mode 100644
> > > index 0000000000..ac6ef73e77
> > > --- /dev/null
> > > +++ b/hw/timer/avr_timer16.c
> > > @@ -0,0 +1,605 @@
> > > +/*
> > > + * AVR 16 bit timer
> > > + *
> > > + * Copyright (c) 2018 University of Kent
> > > + * Author: Ed Robbins
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +/*
> > > + * Driver for 16 bit timers on 8 bit AVR devices.
> > > + * Note:
> > > + * ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16 bit
> > > + */
> > > +
> > > +/*
> > > + * XXX TODO: Power Reduction Register support
> > > + *           prescaler pause support
> > > + *           PWM modes, GPIO, output capture pins, input compare pin
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "hw/timer/avr_timer16.h"
> > > +#include "qemu/log.h"
> > > +#include "hw/irq.h"
> > > +#include "hw/qdev-properties.h"
> > > +
> > > +/* Register offsets */
> > > +#define T16_CRA     0x0
> > > +#define T16_CRB     0x1
> > > +#define T16_CRC     0x2
> > > +#define T16_CNTL    0x4
> > > +#define T16_CNTH    0x5
> > > +#define T16_ICRL    0x6
> > > +#define T16_ICRH    0x7
> > > +#define T16_OCRAL   0x8
> > > +#define T16_OCRAH   0x9
> > > +#define T16_OCRBL   0xa
> > > +#define T16_OCRBH   0xb
> > > +#define T16_OCRCL   0xc
> > > +#define T16_OCRCH   0xd
> > > +
> > > +/* Field masks */
> > > +#define T16_CRA_WGM01   0x3
> > > +#define T16_CRA_COMC    0xc
> > > +#define T16_CRA_COMB    0x30
> > > +#define T16_CRA_COMA    0xc0
> > > +#define T16_CRA_OC_CONF \
> > > +    (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_COMC)
> > > +
> > > +#define T16_CRB_CS      0x7
> > > +#define T16_CRB_WGM23   0x18
> > > +#define T16_CRB_ICES    0x40
> > > +#define T16_CRB_ICNC    0x80
> > > +
> > > +#define T16_CRC_FOCC    0x20
> > > +#define T16_CRC_FOCB    0x40
> > > +#define T16_CRC_FOCA    0x80
> > > +
> > > +/* Fields masks both TIMSK and TIFR (interrupt mask/flag registers) */
> > > +#define T16_INT_TOV    0x1 /* Timer overflow */
> > > +#define T16_INT_OCA    0x2 /* Output compare A */
> > > +#define T16_INT_OCB    0x4 /* Output compare B */
> > > +#define T16_INT_OCC    0x8 /* Output compare C */
> > > +#define T16_INT_IC     0x20 /* Input capture */
> > > +
> > > +/* Clock source values */
> > > +#define T16_CLKSRC_STOPPED     0
> > > +#define T16_CLKSRC_DIV1        1
> > > +#define T16_CLKSRC_DIV8        2
> > > +#define T16_CLKSRC_DIV64       3
> > > +#define T16_CLKSRC_DIV256      4
> > > +#define T16_CLKSRC_DIV1024     5
> > > +#define T16_CLKSRC_EXT_FALLING 6
> > > +#define T16_CLKSRC_EXT_RISING  7
> > > +
> > > +/* Timer mode values (not including PWM modes) */
> > > +#define T16_MODE_NORMAL     0
> > > +#define T16_MODE_CTC_OCRA   4
> > > +#define T16_MODE_CTC_ICR    12
> > > +
> > > +/* Accessors */
> > > +#define CLKSRC(t16) (t16->crb & T16_CRB_CS)
> > > +#define MODE(t16)   (((t16->crb & T16_CRB_WGM23) >> 1) | \
> > > +                     (t16->cra & T16_CRA_WGM01))
> > > +#define CNT(t16)    VAL16(t16->cntl, t16->cnth)
> > > +#define OCRA(t16)   VAL16(t16->ocral, t16->ocrah)
> > > +#define OCRB(t16)   VAL16(t16->ocrbl, t16->ocrbh)
> > > +#define OCRC(t16)   VAL16(t16->ocrcl, t16->ocrch)
> > > +#define ICR(t16)    VAL16(t16->icrl, t16->icrh)
> > > +
> > > +/* Helper macros */
> > > +#define VAL16(l, h) ((h << 8) | l)
> > > +#define ERROR(fmt, args...) \
> > > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## args)
> > > +#define DB_PRINT(fmt, args...) /* Nothing */
> > > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args)*/
> > > +
> > > +static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State *t16, int64_t t)
> > > +{
> > > +    if (t16->period_ns == 0) {
> > > +        return 0;
> > > +    }
> > > +    return t / t16->period_ns;
> > > +}
> > > +
> > > +static void avr_timer16_update_cnt(AVRTimer16State *t16)
> > > +{
> > > +    uint16_t cnt;
> > > +    cnt = avr_timer16_ns_to_ticks(t16, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
> > > +                                       t16->reset_time_ns);
> > > +    t16->cntl = (uint8_t)(cnt & 0xff);
> > > +    t16->cnth = (uint8_t)((cnt & 0xff00) >> 8);
> > > +}
> > > +
> > > +static inline void avr_timer16_recalc_reset_time(AVRTimer16State *t16)
> > > +{
> > > +    t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
> > > +                         CNT(t16) * t16->period_ns;
> > > +}
> > > +
> > > +static void avr_timer16_clock_reset(AVRTimer16State *t16)
> > > +{
> > > +    t16->cntl = 0;
> > > +    t16->cnth = 0;
> > > +    t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > > +}
> > > +
> > > +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
> > > +{
> > > +    uint16_t divider = 0;
> > > +    switch (CLKSRC(t16)) {
> > > +    case T16_CLKSRC_EXT_FALLING:
> > > +    case T16_CLKSRC_EXT_RISING:
> > > +        ERROR("external clock source unsupported");
> > > +        goto end;
> > > +    case T16_CLKSRC_STOPPED:
> > > +        goto end;
> > > +    case T16_CLKSRC_DIV1:
> > > +        divider = 1;
> > > +        break;
> > > +    case T16_CLKSRC_DIV8:
> > > +        divider = 8;
> > > +        break;
> > > +    case T16_CLKSRC_DIV64:
> > > +        divider = 64;
> > > +        break;
> > > +    case T16_CLKSRC_DIV256:
> > > +        divider = 256;
> > > +        break;
> > > +    case T16_CLKSRC_DIV1024:
> > > +        divider = 1024;
> > > +        break;
> > > +    default:
> > > +        goto end;
> > > +    }
> > > +    t16->freq_hz = t16->cpu_freq_hz / divider;
> > > +    t16->period_ns = 1000000000ULL / t16->freq_hz;
> > > +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%f s)",
> > > +             t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
> > > +end:
> > > +    return;
> > > +}
> > > +
> > > +static void avr_timer16_set_alarm(AVRTimer16State *t16)
> > > +{
> > > +    if (CLKSRC(t16) == T16_CLKSRC_EXT_FALLING ||
> > > +        CLKSRC(t16) == T16_CLKSRC_EXT_RISING ||
> > > +        CLKSRC(t16) == T16_CLKSRC_STOPPED) {
> > > +        /* Timer is disabled or set to external clock source (unsupported) */
> > > +        goto end;
> > > +    }
> > > +
> > > +    uint64_t alarm_offset = 0xffff;
> > > +    enum NextInterrupt next_interrupt = OVERFLOW;
> > > +
> > > +    switch (MODE(t16)) {
> > > +    case T16_MODE_NORMAL:
> > > +        /* Normal mode */
> > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
> > > +            (t16->imsk & T16_INT_OCA)) {
> > > +            alarm_offset = OCRA(t16);
> > > +            next_interrupt = COMPA;
> > > +        }
> > > +        break;
> > > +    case T16_MODE_CTC_OCRA:
> > > +        /* CTC mode, top = ocra */
> > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
> > > +            alarm_offset = OCRA(t16);
> > > +            next_interrupt = COMPA;
> > > +        }
> > > +       break;
> > > +    case T16_MODE_CTC_ICR:
> > > +        /* CTC mode, top = icr */
> > > +        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
> > > +            alarm_offset = ICR(t16);
> > > +            next_interrupt = CAPT;
> > > +        }
> > > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
> > > +            (t16->imsk & T16_INT_OCA)) {
> > > +            alarm_offset = OCRA(t16);
> > > +            next_interrupt = COMPA;
> > > +        }
> > > +        break;
> > > +    default:
> > > +        ERROR("pwm modes are unsupported");
> > > +        goto end;
> > > +    }
> > > +    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> > > +        (t16->imsk & T16_INT_OCB)) {
> > > +        alarm_offset = OCRB(t16);
> > > +        next_interrupt = COMPB;
> > > +    }
> > > +    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> > > +        (t16->imsk & T16_INT_OCC)) {
> > > +        alarm_offset = OCRB(t16);
> > > +        next_interrupt = COMPC;
> > > +    }
> > > +    alarm_offset -= CNT(t16);
> > > +
> > > +    t16->next_interrupt = next_interrupt;
> > > +    uint64_t alarm_ns =
> > > +        t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_ns);
> > > +    timer_mod(t16->timer, alarm_ns);
> > > +
> > > +    DB_PRINT("next alarm %" PRIu64 " ns from now",
> > > +        alarm_offset * t16->period_ns);
> > > +
> > > +end:
> > > +    return;
> > > +}
> > > +
> > > +static void avr_timer16_interrupt(void *opaque)
> > > +{
> > > +    AVRTimer16State *t16 = opaque;
> > > +    uint8_t mode = MODE(t16);
> > > +
> > > +    avr_timer16_update_cnt(t16);
> > > +
> > > +    if (CLKSRC(t16) == T16_CLKSRC_EXT_FALLING ||
> > > +        CLKSRC(t16) == T16_CLKSRC_EXT_RISING ||
> > > +        CLKSRC(t16) == T16_CLKSRC_STOPPED) {
> > > +        /* Timer is disabled or set to external clock source (unsupported) */
> > > +        return;
> > > +    }
> > > +
> > > +    DB_PRINT("interrupt, cnt = %d", CNT(t16));
> > > +
> > > +    /* Counter overflow */
> > > +    if (t16->next_interrupt == OVERFLOW) {
> > > +        DB_PRINT("0xffff overflow");
> > > +        avr_timer16_clock_reset(t16);
> > > +        if (t16->imsk & T16_INT_TOV) {
> > > +            t16->ifr |= T16_INT_TOV;
> > > +            qemu_set_irq(t16->ovf_irq, 1);
> > > +        }
> > > +    }
> > > +    /* Check for ocra overflow in CTC mode */
> > > +    if (mode == T16_MODE_CTC_OCRA && t16->next_interrupt == COMPA) {
> > > +        DB_PRINT("CTC OCRA overflow");
> > > +        avr_timer16_clock_reset(t16);
> > > +    }
> > > +    /* Check for icr overflow in CTC mode */
> > > +    if (mode == T16_MODE_CTC_ICR && t16->next_interrupt == CAPT) {
> > > +        DB_PRINT("CTC ICR overflow");
> > > +        avr_timer16_clock_reset(t16);
> > > +        if (t16->imsk & T16_INT_IC) {
> > > +            t16->ifr |= T16_INT_IC;
> > > +            qemu_set_irq(t16->capt_irq, 1);
> > > +        }
> > > +    }
> > > +    /* Check for output compare interrupts */
> > > +    if (t16->imsk & T16_INT_OCA && t16->next_interrupt == COMPA) {
> > > +        t16->ifr |= T16_INT_OCA;
> > > +        qemu_set_irq(t16->compa_irq, 1);
> > > +    }
> > > +    if (t16->imsk & T16_INT_OCB && t16->next_interrupt == COMPB) {
> > > +        t16->ifr |= T16_INT_OCB;
> > > +        qemu_set_irq(t16->compb_irq, 1);
> > > +    }
> > > +    if (t16->imsk & T16_INT_OCC && t16->next_interrupt == COMPC) {
> > > +        t16->ifr |= T16_INT_OCC;
> > > +        qemu_set_irq(t16->compc_irq, 1);
> > > +    }
> > > +    avr_timer16_set_alarm(t16);
> > > +}
> > > +
> > > +static void avr_timer16_reset(DeviceState *dev)
> > > +{
> > > +    AVRTimer16State *t16 = AVR_TIMER16(dev);
> > > +
> > > +    avr_timer16_clock_reset(t16);
> > > +    avr_timer16_clksrc_update(t16);
> > > +    avr_timer16_set_alarm(t16);
> > > +
> > > +    qemu_set_irq(t16->capt_irq, 0);
> > > +    qemu_set_irq(t16->compa_irq, 0);
> > > +    qemu_set_irq(t16->compb_irq, 0);
> > > +    qemu_set_irq(t16->compc_irq, 0);
> > > +    qemu_set_irq(t16->ovf_irq, 0);
> > > +}
> > > +
> > > +static uint64_t avr_timer16_read(void *opaque, hwaddr offset, unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    AVRTimer16State *t16 = opaque;
> > > +    uint8_t retval = 0;
> > > +
> > > +    switch (offset) {
> > > +    case T16_CRA:
> > > +        retval = t16->cra;
> > > +        break;
> > > +    case T16_CRB:
> > > +        retval = t16->crb;
> > > +        break;
> > > +    case T16_CRC:
> > > +        retval = t16->crc;
> > > +        break;
> > > +    case T16_CNTL:
> > > +        avr_timer16_update_cnt(t16);
> > > +        t16->rtmp = t16->cnth;
> > > +        retval = t16->cntl;
> > > +        break;
> > > +    case T16_CNTH:
> > > +        retval = t16->rtmp;
> > > +        break;
> > > +    case T16_ICRL:
> > > +        /*
> > > +         * The timer copies cnt to icr when the input capture pin changes
> > > +         * state or when the analog comparator has a match. We don't
> > > +         * emulate this behaviour. We do support it's use for defining a
> > > +         * TOP value in T16_MODE_CTC_ICR
> > > +         */
> > > +        t16->rtmp = t16->icrh;
> > > +        retval = t16->icrl;
> > > +        break;
> > > +    case T16_ICRH:
> > > +        retval = t16->rtmp;
> > > +        break;
> > > +    case T16_OCRAL:
> > > +        retval = t16->ocral;
> > > +        break;
> > > +    case T16_OCRAH:
> > > +        retval = t16->ocrah;
> > > +        break;
> > > +    case T16_OCRBL:
> > > +        retval = t16->ocrbl;
> > > +        break;
> > > +    case T16_OCRBH:
> > > +        retval = t16->ocrbh;
> > > +        break;
> > > +    case T16_OCRCL:
> > > +        retval = t16->ocrcl;
> > > +        break;
> > > +    case T16_OCRCH:
> > > +        retval = t16->ocrch;
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > > +    return (uint64_t)retval;
> > > +}
> > > +
> > > +static void avr_timer16_write(void *opaque, hwaddr offset,
> > > +                              uint64_t val64, unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    AVRTimer16State *t16 = opaque;
> > > +    uint8_t val8 = (uint8_t)val64;
> > > +    uint8_t prev_clk_src = CLKSRC(t16);
> > > +
> > > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> > > +
> > > +    switch (offset) {
> > > +    case T16_CRA:
> > > +        t16->cra = val8;
> > > +        if (t16->cra & T16_CRA_OC_CONF) {
> > > +            ERROR("output compare pins unsupported");
> > > +        }
> > > +        break;
> > > +    case T16_CRB:
> > > +        t16->crb = val8;
> > > +        if (t16->crb & T16_CRB_ICNC) {
> > > +            ERROR("input capture noise canceller unsupported");
> > > +        }
> > > +        if (t16->crb & T16_CRB_ICES) {
> > > +            ERROR("input capture unsupported");
> > > +        }
> > > +        if (CLKSRC(t16) != prev_clk_src) {
> > > +            avr_timer16_clksrc_update(t16);
> > > +            if (prev_clk_src == T16_CLKSRC_STOPPED) {
> > > +                t16->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > > +            }
> > > +        }
> > > +        break;
> > > +    case T16_CRC:
> > > +        t16->crc = val8;
> > > +        ERROR("output compare pins unsupported");
> > > +        break;
> > > +    case T16_CNTL:
> > > +        /*
> > > +         * CNT is the 16-bit counter value, it must be read/written via
> > > +         * a temporary register (rtmp) to make the read/write atomic.
> > > +         */
> > > +        /* ICR also has this behaviour, and shares rtmp */
> > > +        /*
> > > +         * Writing CNT blocks compare matches for one clock cycle.
> > > +         * Writing CNT to TOP or to an OCR value (if in use) will
> > > +         * skip the relevant interrupt
> > > +         */
> > > +        t16->cntl = val8;
> > > +        t16->cnth = t16->rtmp;
> > > +        avr_timer16_recalc_reset_time(t16);
> > > +        break;
> > > +    case T16_CNTH:
> > > +        t16->rtmp = val8;
> > > +        break;
> > > +    case T16_ICRL:
> > > +        /* ICR can only be written in mode T16_MODE_CTC_ICR */
> > > +        if (MODE(t16) == T16_MODE_CTC_ICR) {
> > > +            t16->icrl = val8;
> > > +            t16->icrh = t16->rtmp;
> > > +        }
> > > +        break;
> > > +    case T16_ICRH:
> > > +        if (MODE(t16) == T16_MODE_CTC_ICR) {
> > > +            t16->rtmp = val8;
> > > +        }
> > > +        break;
> > > +    case T16_OCRAL:
> > > +        /*
> > > +         * OCRn cause the relevant output compare flag to be raised, and
> > > +         * trigger an interrupt, when CNT is equal to the value here
> > > +         */
> > > +        t16->ocral = val8;
> > > +        break;
> > > +    case T16_OCRAH:
> > > +        t16->ocrah = val8;
> > > +        break;
> > > +    case T16_OCRBL:
> > > +        t16->ocrbl = val8;
> > > +        break;
> > > +    case T16_OCRBH:
> > > +        t16->ocrbh = val8;
> > > +        break;
> > > +    case T16_OCRCL:
> > > +        t16->ocrcl = val8;
> > > +        break;
> > > +    case T16_OCRCH:
> > > +        t16->ocrch = val8;
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > > +    avr_timer16_set_alarm(t16);
> > > +}
> > > +
> > > +static uint64_t avr_timer16_imsk_read(void *opaque,
> > > +                                      hwaddr offset,
> > > +                                      unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    AVRTimer16State *t16 = opaque;
> > > +    if (offset != 0) {
> > > +        return 0;
> > > +    }
> > > +    return t16->imsk;
> > > +}
> > > +
> > > +static void avr_timer16_imsk_write(void *opaque, hwaddr offset,
> > > +                                   uint64_t val64, unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    AVRTimer16State *t16 = opaque;
> > > +    if (offset != 0) {
> > > +        return;
> > > +    }
> > > +    t16->imsk = (uint8_t)val64;
> > > +}
> > > +
> > > +static uint64_t avr_timer16_ifr_read(void *opaque,
> > > +                                     hwaddr offset,
> > > +                                     unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    AVRTimer16State *t16 = opaque;
> > > +    if (offset != 0) {
> > > +        return 0;
> > > +    }
> > > +    return t16->ifr;
> > > +}
> > > +
> > > +static void avr_timer16_ifr_write(void *opaque, hwaddr offset,
> > > +                                  uint64_t val64, unsigned size)
> > > +{
> > > +    assert(size == 1);
> > > +    AVRTimer16State *t16 = opaque;
> > > +    if (offset != 0) {
> > > +        return;
> > > +    }
> > > +    t16->ifr = (uint8_t)val64;
> > > +}
> > > +
> > > +static const MemoryRegionOps avr_timer16_ops = {
> > > +    .read = avr_timer16_read,
> > > +    .write = avr_timer16_write,
> > > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .impl = {.max_access_size = 1}
> > > +};
> > > +
> > > +static const MemoryRegionOps avr_timer16_imsk_ops = {
> > > +    .read = avr_timer16_imsk_read,
> > > +    .write = avr_timer16_imsk_write,
> > > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .impl = {.max_access_size = 1}
> > > +};
> > > +
> > > +static const MemoryRegionOps avr_timer16_ifr_ops = {
> > > +    .read = avr_timer16_ifr_read,
> > > +    .write = avr_timer16_ifr_write,
> > > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > > +    .impl = {.max_access_size = 1}
> > > +};
> > > +
> > > +static Property avr_timer16_properties[] = {
> > > +    DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
> > > +                       cpu_freq_hz, 20000000),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void avr_timer16_pr(void *opaque, int irq, int level)
> > > +{
> > > +    AVRTimer16State *s = AVR_TIMER16(opaque);
> > > +
> > > +    s->enabled = !level;
> > > +
> > > +    if (!s->enabled) {
> > > +        avr_timer16_reset(DEVICE(s));
> > > +    }
> > > +}
> > > +
> > > +static void avr_timer16_init(Object *obj)
> > > +{
> > > +    AVRTimer16State *s = AVR_TIMER16(obj);
> > > +
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->capt_irq);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compa_irq);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compb_irq);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compc_irq);
> > > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->ovf_irq);
> > > +
> > > +    memory_region_init_io(&s->iomem, obj, &avr_timer16_ops,
> > > +                          s, TYPE_AVR_TIMER16, 0xe);
> > > +    memory_region_init_io(&s->imsk_iomem, obj, &avr_timer16_imsk_ops,
> > > +                          s, TYPE_AVR_TIMER16, 0x1);
> > > +    memory_region_init_io(&s->ifr_iomem, obj, &avr_timer16_ifr_ops,
> > > +                          s, TYPE_AVR_TIMER16, 0x1);
> > > +
> > > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> > > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->imsk_iomem);
> > > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ifr_iomem);
> > > +    qdev_init_gpio_in(DEVICE(s), avr_timer16_pr, 1);
> > > +
> > > +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, avr_timer16_interrupt, s);
> > > +    s->enabled = true;
> > > +}
> > > +
> > > +static void avr_timer16_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > > +
> > > +    dc->reset = avr_timer16_reset;
> > > +    dc->props = avr_timer16_properties;
> > > +}
> > > +
> > > +static const TypeInfo avr_timer16_info = {
> > > +    .name          = TYPE_AVR_TIMER16,
> > > +    .parent        = TYPE_SYS_BUS_DEVICE,
> > > +    .instance_size = sizeof(AVRTimer16State),
> > > +    .instance_init = avr_timer16_init,
> > > +    .class_init    = avr_timer16_class_init,
> > > +};
> > > +
> > > +static void avr_timer16_register_types(void)
> > > +{
> > > +    type_register_static(&avr_timer16_info);
> > > +}
> > > +
> > > +type_init(avr_timer16_register_types)
> > > diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
> > > new file mode 100644
> > > index 0000000000..8e9ee88bbd
> > > --- /dev/null
> > > +++ b/include/hw/char/avr_usart.h
> > > @@ -0,0 +1,97 @@
> > > +/*
> > > + * AVR USART
> > > + *
> > > + * Copyright (c) 2018 University of Kent
> > > + * Author: Sarah Harris
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef HW_AVR_USART_H
> > > +#define HW_AVR_USART_H
> > > +
> > > +#include "hw/sysbus.h"
> > > +#include "chardev/char-fe.h"
> > > +#include "hw/hw.h"
> > > +
> > > +/* Offsets of registers. */
> > > +#define USART_DR   0x06
> > > +#define USART_CSRA  0x00
> > > +#define USART_CSRB  0x01
> > > +#define USART_CSRC  0x02
> > > +#define USART_BRRH 0x05
> > > +#define USART_BRRL 0x04
> > > +
> > > +/* Relevant bits in regiters. */
> > > +#define USART_CSRA_RXC    (1 << 7)
> > > +#define USART_CSRA_TXC    (1 << 6)
> > > +#define USART_CSRA_DRE    (1 << 5)
> > > +#define USART_CSRA_MPCM   (1 << 0)
> > > +
> > > +#define USART_CSRB_RXCIE  (1 << 7)
> > > +#define USART_CSRB_TXCIE  (1 << 6)
> > > +#define USART_CSRB_DREIE  (1 << 5)
> > > +#define USART_CSRB_RXEN   (1 << 4)
> > > +#define USART_CSRB_TXEN   (1 << 3)
> > > +#define USART_CSRB_CSZ2   (1 << 2)
> > > +#define USART_CSRB_RXB8   (1 << 1)
> > > +#define USART_CSRB_TXB8   (1 << 0)
> > > +
> > > +#define USART_CSRC_MSEL1  (1 << 7)
> > > +#define USART_CSRC_MSEL0  (1 << 6)
> > > +#define USART_CSRC_PM1    (1 << 5)
> > > +#define USART_CSRC_PM0    (1 << 4)
> > > +#define USART_CSRC_CSZ1   (1 << 2)
> > > +#define USART_CSRC_CSZ0   (1 << 1)
> > > +
> > > +#define TYPE_AVR_USART "avr-usart"
> > > +#define AVR_USART(obj) \
> > > +    OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
> > > +
> > > +typedef struct {
> > > +    /* <private> */
> > > +    SysBusDevice parent_obj;
> > > +
> > > +    /* <public> */
> > > +    MemoryRegion mmio;
> > > +
> > > +    CharBackend chr;
> > > +
> > > +    bool enabled;
> > > +
> > > +    uint8_t data;
> > > +    bool data_valid;
> > > +    uint8_t char_mask;
> > > +    /* Control and Status Registers */
> > > +    uint8_t csra;
> > > +    uint8_t csrb;
> > > +    uint8_t csrc;
> > > +    /* Baud Rate Registers (low/high byte) */
> > > +    uint8_t brrh;
> > > +    uint8_t brrl;
> > > +
> > > +    /* Receive Complete */
> > > +    qemu_irq rxc_irq;
> > > +    /* Transmit Complete */
> > > +    qemu_irq txc_irq;
> > > +    /* Data Register Empty */
> > > +    qemu_irq dre_irq;
> > > +} AVRUsartState;
> > > +
> > > +#endif /* HW_AVR_USART_H */
> > > diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/avr_mask.h
> > > new file mode 100644
> > > index 0000000000..d3e21972d8
> > > --- /dev/null
> > > +++ b/include/hw/misc/avr_mask.h
> > > @@ -0,0 +1,47 @@
> > > +/*
> > > + * AVR Power Reduction
> > > + *
> > > + * Copyright (c) 2019 Michael Rolnik
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +#ifndef HW_avr_mask_H
> > > +#define HW_avr_mask_H
> > > +
> > > +#include "hw/sysbus.h"
> > > +#include "chardev/char-fe.h"
> > > +#include "hw/hw.h"
> > > +
> > > +
> > > +#define TYPE_AVR_MASK "avr-mask"
> > > +#define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)
> > > +
> > > +typedef struct {
> > > +    /* <private> */
> > > +    SysBusDevice parent_obj;
> > > +
> > > +    /* <public> */
> > > +    MemoryRegion iomem;
> > > +
> > > +    uint8_t val;
> > > +    qemu_irq irq[8];
> > > +} AVRMaskState;
> > > +
> > > +#endif /* HW_avr_mask_H */
> > > diff --git a/include/hw/timer/avr_timer16.h b/include/hw/timer/avr_timer16.h
> > > new file mode 100644
> > > index 0000000000..5639074ce5
> > > --- /dev/null
> > > +++ b/include/hw/timer/avr_timer16.h
> > > @@ -0,0 +1,97 @@
> > > +/*
> > > + * AVR 16 bit timer
> > > + *
> > > + * Copyright (c) 2018 University of Kent
> > > + * Author: Ed Robbins
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> > > + */
> > > +
> > > +/*
> > > + * Driver for 16 bit timers on 8 bit AVR devices.
> > > + * Note:
> > > + * On ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16 bit
> > > + */
> > > +
> > > +#ifndef AVR_TIMER16_H
> > > +#define AVR_TIMER16_H
> > > +
> > > +#include "hw/sysbus.h"
> > > +#include "qemu/timer.h"
> > > +#include "hw/hw.h"
> > > +
> > > +enum NextInterrupt {
> > > +    OVERFLOW,
> > > +    COMPA,
> > > +    COMPB,
> > > +    COMPC,
> > > +    CAPT
> > > +};
> > > +
> > > +#define TYPE_AVR_TIMER16 "avr-timer16"
> > > +#define AVR_TIMER16(obj) \
> > > +    OBJECT_CHECK(AVRTimer16State, (obj), TYPE_AVR_TIMER16)
> > > +
> > > +typedef struct AVRTimer16State {
> > > +    /* <private> */
> > > +    SysBusDevice parent_obj;
> > > +
> > > +    /* <public> */
> > > +    MemoryRegion iomem;
> > > +    MemoryRegion imsk_iomem;
> > > +    MemoryRegion ifr_iomem;
> > > +    QEMUTimer *timer;
> > > +    qemu_irq capt_irq;
> > > +    qemu_irq compa_irq;
> > > +    qemu_irq compb_irq;
> > > +    qemu_irq compc_irq;
> > > +    qemu_irq ovf_irq;
> > > +
> > > +    bool enabled;
> > > +
> > > +    /* registers */
> > > +    uint8_t cra;
> > > +    uint8_t crb;
> > > +    uint8_t crc;
> > > +    uint8_t cntl;
> > > +    uint8_t cnth;
> > > +    uint8_t icrl;
> > > +    uint8_t icrh;
> > > +    uint8_t ocral;
> > > +    uint8_t ocrah;
> > > +    uint8_t ocrbl;
> > > +    uint8_t ocrbh;
> > > +    uint8_t ocrcl;
> > > +    uint8_t ocrch;
> > > +    /*
> > > +     * Reads and writes to CNT and ICR utilise a bizarre temporary
> > > +     * register, which we emulate
> > > +     */
> > > +    uint8_t rtmp;
> > > +    uint8_t imsk;
> > > +    uint8_t ifr;
> > > +
> > > +    uint64_t cpu_freq_hz;
> > > +    uint64_t freq_hz;
> > > +    uint64_t period_ns;
> > > +    uint64_t reset_time_ns;
> > > +    enum NextInterrupt next_interrupt;
> > > +} AVRTimer16State;
> > > +
> > > +#endif /* AVR_TIMER16_H */
> > > --
> > > 2.17.2 (Apple Git-113)
> > >

