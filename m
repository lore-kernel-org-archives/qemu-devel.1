Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C9C74A41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CF720844
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo+oX55J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CF720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlPAa-00038k-8n
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 22:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60685)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hlP9f-0002cQ-Gk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hlP9Y-0004Ps-7u
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:49:55 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hlP9W-0004Dv-UD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:49:47 -0400
Received: by mail-qt1-x842.google.com with SMTP id z4so4804692qtc.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GsuNK6y9gpWQm++o9p/pd+JkYzHhdDN1bPwA0Mg926w=;
 b=jo+oX55JGUjQWdTyLo8OhfZg6Ly9A16gRDWbHT0TK2RNv42PgjwUXBWuhpD8RIr19z
 Bu5T/RVnWk/Q+UhucEpPQCP6PMe0ihKefBkENCmmijSkoR6qGd6orzUgodPHh+qhTvD9
 KPg24l9oE6obnbe4JNcIp9a8B3ryGcdYclntXHDw7Zo2pMfcozpwt+1jQ9UzpSh9XK6m
 BLOsRYu1jXfhEko0726OsC6NahNzvn1ewLlKcGOGcmzs9I4TRNjxfuT3M8za8vjVNt1A
 zEBbhKfrQ5+IoLExDN5gLYLxYVg8iKzlnlzI98AhqFffW88LR0ubmXZZOzroOOhPLJ/O
 Y4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GsuNK6y9gpWQm++o9p/pd+JkYzHhdDN1bPwA0Mg926w=;
 b=H79wwARdrpzUpYdfEVIPYFcX7GnFmfq6uR0+hIycI5bg3LOxOLdfAyP9NjaiG9QHgO
 PubYNopVE6n9VbpkOqlyoolYwwc8uevRcsA3RokLUH99CeUeas1axcKo6/ejzFn2Jkf9
 9SqIUtTUUS4yOrTLcfvcer5Rof/zaWK/N1mAJJiB0xVlb8GYIsJn7o80qadh0lPGunKn
 gBzesC/f2rHyxxLIZvfmqXy2x+YM56NZRRg3IHpw/98UTnpdlrcaNiMFc5RQeBU+6bVf
 CERs8W6h3CQnlHlLOcX9ut4DRo5m+Cgz9t+43pyIsquM+9WBjtJ8hoKxUU/s+pSqywHs
 Uv5w==
X-Gm-Message-State: APjAAAVBnOHMoPNgmUsAU6Yh2YrnFbX7r3xC3RbJZLh21xQ4VRjUvBmd
 hHsIGW4j3X/eSUT5+m7bRmJKOsQvnb915ydDPlU=
X-Google-Smtp-Source: APXvYqyYK6i2MXHMiRzBk9DxCbkS+CLVJOaS221RF/5QQG/yxXSjtPdxWOyragrX1myp9saK3jjAjyQ5advoxMl7gzE=
X-Received: by 2002:a0c:818f:: with SMTP id 15mr915876qvd.162.1562813365148;
 Wed, 10 Jul 2019 19:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190709213651.77315-1-mrolnik@gmail.com>
 <20190709213651.77315-6-mrolnik@gmail.com>
 <0c7166ff-616b-574d-428c-6463e34aca0e@redhat.com>
In-Reply-To: <0c7166ff-616b-574d-428c-6463e34aca0e@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 11 Jul 2019 05:48:47 +0300
Message-ID: <CAK4993h_P6isJc_1m=Ye0yHota4fZ0nu=9VPgTibAYkuKyxX1A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v25 5/7] target/avr: Add limited support
 for USART and 16 bit timer peripherals
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
Cc: Igor Mammedov <imammedo@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe.

Thanks for you review.
Please explain how to link a device.

Regards,
Michael

On Wed, Jul 10, 2019 at 1:06 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Michael, Sarah.
>
> Sorry for reviewing this series that late.
>
> On 7/9/19 11:36 PM, Michael Rolnik wrote:
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > These were designed to facilitate testing but should provide enough
> function to be useful in other contexts.
> > Only a subset of the functions of each peripheral is implemented, mainl=
y
> due to the lack of a standard way to handle electrical connections (like
> GPIO pins).
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  hw/char/Kconfig                |   3 +
> >  hw/char/Makefile.objs          |   1 +
> >  hw/char/avr_usart.c            | 316 ++++++++++++++++++
> >  hw/timer/Kconfig               |   3 +
> >  hw/timer/Makefile.objs         |   1 +
> >  hw/timer/avr_timer16.c         | 587 +++++++++++++++++++++++++++++++++
> >  include/hw/char/avr_usart.h    |  99 ++++++
> >  include/hw/timer/avr_timer16.h |  99 ++++++
> >  8 files changed, 1109 insertions(+)
> >  create mode 100644 hw/char/avr_usart.c
> >  create mode 100644 hw/timer/avr_timer16.c
> >  create mode 100644 include/hw/char/avr_usart.h
> >  create mode 100644 include/hw/timer/avr_timer16.h
> >
> > diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> > index 40e7a8b8bb..331b20983f 100644
> > --- a/hw/char/Kconfig
> > +++ b/hw/char/Kconfig
> > @@ -46,3 +46,6 @@ config SCLPCONSOLE
> >
> >  config TERMINAL3270
> >      bool
> > +
> > +config AVR_USART
> > +    bool
> > diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> > index 02d8a66925..09ed50f1d0 100644
> > --- a/hw/char/Makefile.objs
> > +++ b/hw/char/Makefile.objs
> > @@ -21,6 +21,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
> >  obj-$(CONFIG_DIGIC) +=3D digic-uart.o
> >  obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
> >  obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
> > +obj-$(CONFIG_AVR_USART) +=3D avr_usart.o
> >
> >  common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
> >  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
> > diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
> > new file mode 100644
> > index 0000000000..26c711336b
> > --- /dev/null
> > +++ b/hw/char/avr_usart.c
> > @@ -0,0 +1,316 @@
> > +/*
> > + * AVR USART
> > + *
> > + * Copyright (c) 2018 University of Kent
> > + * Author: Sarah Harris
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/char/avr_usart.h"
> > +#include "qemu/log.h"
> > +
> > +static int avr_usart_can_receive(void *opaque)
> > +{
> > +    AVRUsartState *usart =3D opaque;
> > +
> > +    if (usart->data_valid || !(usart->csrb & USART_CSRB_RXEN)) {
> > +        return 0;
> > +    }
> > +    return 1;
> > +}
> > +
> > +static void avr_usart_receive(void *opaque, const uint8_t *buffer, int
> size)
> > +{
> > +    AVRUsartState *usart =3D opaque;
> > +    assert(size =3D=3D 1);
> > +    assert(!usart->data_valid);
> > +    usart->data =3D buffer[0];
> > +    usart->data_valid =3D true;
> > +    usart->csra |=3D USART_CSRA_RXC;
> > +    if (usart->csrb & USART_CSRB_RXCIE) {
> > +        qemu_set_irq(usart->rxc_irq, 1);
> > +    }
> > +}
> > +
> > +static void update_char_mask(AVRUsartState *usart)
> > +{
> > +    uint8_t mode =3D ((usart->csrc & USART_CSRC_CSZ0) ? 1 : 0) |
> > +        ((usart->csrc & USART_CSRC_CSZ1) ? 2 : 0) |
> > +        ((usart->csrb & USART_CSRB_CSZ2) ? 4 : 0);
> > +    switch (mode) {
> > +    case 0:
> > +        usart->char_mask =3D 0b11111;
> > +        break;
> > +    case 1:
> > +        usart->char_mask =3D 0b111111;
> > +        break;
> > +    case 2:
> > +        usart->char_mask =3D 0b1111111;
> > +        break;
> > +    case 3:
> > +        usart->char_mask =3D 0b11111111;
> > +        break;
> > +    case 4:
> > +        /* Fallthrough. */
> > +    case 5:
> > +        /* Fallthrough. */
> > +    case 6:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Reserved character size 0x%x\n",
> > +            __func__,
> > +            mode);
> > +        break;
> > +    case 7:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Nine bit character size not supported (forcing
> eight)\n",
> > +            __func__);
> > +        usart->char_mask =3D 0b11111111;
> > +        break;
> > +    default:
> > +        assert(0);
> > +    }
> > +}
> > +
> > +static void avr_usart_reset(DeviceState *dev)
> > +{
> > +    AVRUsartState *usart =3D AVR_USART(dev);
> > +    usart->data_valid =3D false;
> > +    usart->csra =3D 0b00100000;
> > +    usart->csrb =3D 0b00000000;
> > +    usart->csrc =3D 0b00000110;
> > +    usart->brrl =3D 0;
> > +    usart->brrh =3D 0;
> > +    update_char_mask(usart);
> > +    qemu_set_irq(usart->rxc_irq, 0);
> > +    qemu_set_irq(usart->txc_irq, 0);
> > +    qemu_set_irq(usart->dre_irq, 0);
> > +}
> > +
> > +static uint64_t avr_usart_read(void *opaque, hwaddr addr, unsigned int
> size)
> > +{
> > +    AVRUsartState *usart =3D opaque;
> > +    uint8_t prr;
> > +    uint8_t data;
> > +    assert(size =3D=3D 1);
> > +
> > +    cpu_physical_memory_read(usart->prr_address, &prr, 1);
>
> This looks wrong...
>
> You should implement the PowerManagement block as a device, map it, link
> it to this device, then access directly usart->prr_link->regs[PRR0].
>
How do I link devices? example please

>
> > +    if (prr & usart->prr_mask) {
> > +        /* USART disabled, ignore. */
> > +        avr_usart_reset(DEVICE(usart));
> > +        return 0;
> > +    }
> > +
> > +    switch (addr) {
> > +    case USART_DR:
> > +        if (!(usart->csrb & USART_CSRB_RXEN)) {
> > +            /* Receiver disabled, ignore. */
> > +            return 0;
> > +        }
> > +        if (usart->data_valid) {
> > +            data =3D usart->data & usart->char_mask;
> > +            usart->data_valid =3D false;
> > +        } else {
> > +            data =3D 0;
> > +        }
> > +        usart->csra &=3D 0xff ^ USART_CSRA_RXC;
> > +        qemu_set_irq(usart->rxc_irq, 0);
> > +        qemu_chr_fe_accept_input(&usart->chr);
> > +        return data;
> > +    case USART_CSRA:
> > +        return usart->csra;
> > +    case USART_CSRB:
> > +        return usart->csrb;
> > +    case USART_CSRC:
> > +        return usart->csrc;
> > +    case USART_BRRL:
> > +        return usart->brrl;
> > +    case USART_BRRH:
> > +        return usart->brrh;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> > +            __func__,
> > +            addr);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static void avr_usart_write(void *opaque, hwaddr addr, uint64_t value,
> > +                                unsigned int size)
> > +{
> > +    AVRUsartState *usart =3D opaque;
> > +    uint8_t mask;
> > +    uint8_t data;
> > +    assert((value & 0xff) =3D=3D value);
> > +    assert(size =3D=3D 1);
> > +
> > +    uint8_t prr;
> > +    cpu_physical_memory_read(usart->prr_address, &prr, 1);
> > +    if (prr & usart->prr_mask) {
> > +        /* USART disabled, ignore. */
> > +        avr_usart_reset(DEVICE(usart));
> > +        return;
> > +    }
> > +
> > +    switch (addr) {
> > +    case USART_DR:
> > +        if (!(usart->csrb & USART_CSRB_TXEN)) {
> > +            /* Transmitter disabled, ignore. */
> > +            return;
> > +        }
> > +        usart->csra |=3D USART_CSRA_TXC;
> > +        usart->csra |=3D USART_CSRA_DRE;
> > +        if (usart->csrb & USART_CSRB_TXCIE) {
> > +            qemu_set_irq(usart->txc_irq, 1);
> > +            usart->csra &=3D 0xff ^ USART_CSRA_TXC;
> > +        }
> > +        if (usart->csrb & USART_CSRB_DREIE) {
> > +            qemu_set_irq(usart->dre_irq, 1);
> > +        }
> > +        data =3D value;
> > +        qemu_chr_fe_write_all(&usart->chr, &data, 1);
> > +        break;
> > +    case USART_CSRA:
> > +        mask =3D 0b01000011;
> > +        /* Mask read-only bits. */
> > +        value =3D (value & mask) | (usart->csra & (0xff ^ mask));
> > +        usart->csra =3D value;
> > +        if (value & USART_CSRA_TXC) {
> > +            usart->csra ^=3D USART_CSRA_TXC;
> > +            qemu_set_irq(usart->txc_irq, 0);
> > +        }
> > +        if (value & USART_CSRA_MPCM) {
> > +            qemu_log_mask(
> > +                LOG_GUEST_ERROR,
> > +                "%s: MPCM not supported by USART\n",
> > +                __func__);
> > +        }
> > +        break;
> > +    case USART_CSRB:
> > +        mask =3D 0b11111101;
> > +        /* Mask read-only bits. */
> > +        value =3D (value & mask) | (usart->csrb & (0xff ^ mask));
> > +        usart->csrb =3D value;
> > +        if (!(value & USART_CSRB_RXEN)) {
> > +            /* Receiver disabled, flush input buffer. */
> > +            usart->data_valid =3D false;
> > +        }
> > +        qemu_set_irq(usart->rxc_irq,
> > +            ((value & USART_CSRB_RXCIE) &&
> > +            (usart->csra & USART_CSRA_RXC)) ? 1 : 0);
> > +        qemu_set_irq(usart->txc_irq,
> > +            ((value & USART_CSRB_TXCIE) &&
> > +            (usart->csra & USART_CSRA_TXC)) ? 1 : 0);
> > +        qemu_set_irq(usart->dre_irq,
> > +            ((value & USART_CSRB_DREIE) &&
> > +            (usart->csra & USART_CSRA_DRE)) ? 1 : 0);
> > +        update_char_mask(usart);
> > +        break;
> > +    case USART_CSRC:
> > +        usart->csrc =3D value;
> > +        if ((value & USART_CSRC_MSEL1) && (value & USART_CSRC_MSEL0)) =
{
> > +            qemu_log_mask(
> > +                LOG_GUEST_ERROR,
> > +                "%s: SPI mode not supported by USART\n",
> > +                __func__);
> > +        }
> > +        if ((value & USART_CSRC_MSEL1) && !(value & USART_CSRC_MSEL0))=
 {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad USART mode\n",
> __func__);
> > +        }
> > +        if (!(value & USART_CSRC_PM1) && (value & USART_CSRC_PM0)) {
> > +            qemu_log_mask(
> > +                LOG_GUEST_ERROR,
> > +                "%s: Bad USART parity mode\n",
> > +                __func__);
> > +        }
> > +        update_char_mask(usart);
> > +        break;
> > +    case USART_BRRL:
> > +        usart->brrl =3D value;
> > +        break;
> > +    case USART_BRRH:
> > +        usart->brrh =3D value & 0b00001111;
> > +        break;
> > +    default:
> > +        qemu_log_mask(
> > +            LOG_GUEST_ERROR,
> > +            "%s: Bad offset 0x%"HWADDR_PRIx"\n",
> > +            __func__,
> > +            addr);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps avr_usart_ops =3D {
> > +    .read =3D avr_usart_read,
> > +    .write =3D avr_usart_write,
>
> This misses:
>
>        .impl.max =3D 1,
>
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +static Property avr_usart_properties[] =3D {
> > +    DEFINE_PROP_CHR("chardev", AVRUsartState, chr),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void avr_usart_init(Object *obj)
> > +{
> > +    AVRUsartState *s =3D AVR_USART(obj);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
> > +    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s,
> TYPE_AVR_USART, 7);
>
> USART is 8 byte wide.
>
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static void avr_usart_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AVRUsartState *s =3D AVR_USART(dev);
> > +    qemu_chr_fe_set_handlers(&s->chr, avr_usart_can_receive,
> > +                             avr_usart_receive, NULL, NULL,
> > +                             s, NULL, true);
> > +    avr_usart_reset(dev);
> > +}
> > +
> > +static void avr_usart_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D avr_usart_reset;
> > +    dc->props =3D avr_usart_properties;
> > +    dc->realize =3D avr_usart_realize;
> > +}
> > +
> > +static const TypeInfo avr_usart_info =3D {
> > +    .name          =3D TYPE_AVR_USART,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(AVRUsartState),
> > +    .instance_init =3D avr_usart_init,
> > +    .class_init    =3D avr_usart_class_init,
> > +};
> > +
> > +static void avr_usart_register_types(void)
> > +{
> > +    type_register_static(&avr_usart_info);
> > +}
> > +
> > +type_init(avr_usart_register_types)
> > diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> > index 51921eb63f..ad754df750 100644
> > --- a/hw/timer/Kconfig
> > +++ b/hw/timer/Kconfig
> > @@ -61,3 +61,6 @@ config CMSDK_APB_TIMER
> >  config CMSDK_APB_DUALTIMER
> >      bool
> >      select PTIMER
> > +
> > +config AVR_TIMER16
> > +    bool
> > diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> > index 123d92c969..4f853e265d 100644
> > --- a/hw/timer/Makefile.objs
> > +++ b/hw/timer/Makefile.objs
> > @@ -35,6 +35,7 @@ obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
> >  obj-$(CONFIG_SH4) +=3D sh_timer.o
> >  obj-$(CONFIG_DIGIC) +=3D digic-timer.o
> >  obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
> > +obj-$(CONFIG_AVR_TIMER16) +=3D avr_timer16.o
> >
> >  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
> >
> > diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
> > new file mode 100644
> > index 0000000000..89f8f55eaa
> > --- /dev/null
> > +++ b/hw/timer/avr_timer16.c
> > @@ -0,0 +1,587 @@
> > +/*
> > + * AVR 16 bit timer
> > + *
> > + * Copyright (c) 2018 University of Kent
> > + * Author: Ed Robbins
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +/*
> > + * Driver for 16 bit timers on 8 bit AVR devices.
> > + * Note:
> > + * ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16
> bit
> > + */
> > +
> > +/*
> > + * XXX TODO: Power Reduction Register support
> > + *           prescaler pause support
> > + *           PWM modes, GPIO, output capture pins, input compare pin
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/timer/avr_timer16.h"
> > +#include "qemu/log.h"
> > +
> > +/* Register offsets */
> > +#define T16_CRA     0x0
> > +#define T16_CRB     0x1
> > +#define T16_CRC     0x2
> > +#define T16_CNTL    0x4
> > +#define T16_CNTH    0x5
> > +#define T16_ICRL    0x6
> > +#define T16_ICRH    0x7
> > +#define T16_OCRAL   0x8
> > +#define T16_OCRAH   0x9
> > +#define T16_OCRBL   0xa
> > +#define T16_OCRBH   0xb
> > +#define T16_OCRCL   0xc
> > +#define T16_OCRCH   0xd
> > +
> > +/* Field masks */
> > +#define T16_CRA_WGM01   0x3
> > +#define T16_CRA_COMC    0xc
> > +#define T16_CRA_COMB    0x30
> > +#define T16_CRA_COMA    0xc0
> > +#define T16_CRA_OC_CONF \
> > +    (T16_CRA_COMA | T16_CRA_COMB | T16_CRA_COMC)
> > +
> > +#define T16_CRB_CS      0x7
> > +#define T16_CRB_WGM23   0x18
> > +#define T16_CRB_ICES    0x40
> > +#define T16_CRB_ICNC    0x80
> > +
> > +#define T16_CRC_FOCC    0x20
> > +#define T16_CRC_FOCB    0x40
> > +#define T16_CRC_FOCA    0x80
> > +
> > +/* Fields masks both TIMSK and TIFR (interrupt mask/flag registers) */
> > +#define T16_INT_TOV    0x1 /* Timer overflow */
> > +#define T16_INT_OCA    0x2 /* Output compare A */
> > +#define T16_INT_OCB    0x4 /* Output compare B */
> > +#define T16_INT_OCC    0x8 /* Output compare C */
> > +#define T16_INT_IC     0x20 /* Input capture */
> > +
> > +/* Clock source values */
> > +#define T16_CLKSRC_STOPPED     0
> > +#define T16_CLKSRC_DIV1        1
> > +#define T16_CLKSRC_DIV8        2
> > +#define T16_CLKSRC_DIV64       3
> > +#define T16_CLKSRC_DIV256      4
> > +#define T16_CLKSRC_DIV1024     5
> > +#define T16_CLKSRC_EXT_FALLING 6
> > +#define T16_CLKSRC_EXT_RISING  7
> > +
> > +/* Timer mode values (not including PWM modes) */
> > +#define T16_MODE_NORMAL     0
> > +#define T16_MODE_CTC_OCRA   4
> > +#define T16_MODE_CTC_ICR    12
> > +
> > +/* Accessors */
> > +#define CLKSRC(t16) (t16->crb & T16_CRB_CS)
> > +#define MODE(t16)   (((t16->crb & T16_CRB_WGM23) >> 1) | \
> > +                     (t16->cra & T16_CRA_WGM01))
> > +#define CNT(t16)    VAL16(t16->cntl, t16->cnth)
> > +#define OCRA(t16)   VAL16(t16->ocral, t16->ocrah)
> > +#define OCRB(t16)   VAL16(t16->ocrbl, t16->ocrbh)
> > +#define OCRC(t16)   VAL16(t16->ocrcl, t16->ocrch)
> > +#define ICR(t16)    VAL16(t16->icrl, t16->icrh)
> > +
> > +/* Helper macros */
> > +#define VAL16(l, h) ((h << 8) | l)
> > +#define ERROR(fmt, args...) \
> > +    qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## args)
> > +#define DB_PRINT(fmt, args...) /* Nothing */
> > +/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ##
> args)*/
> > +
> > +static inline int64_t avr_timer16_ns_to_ticks(AVRTimer16State *t16,
> int64_t t)
> > +{
> > +    if (t16->period_ns =3D=3D 0) {
> > +        return 0;
> > +    }
> > +    return t / t16->period_ns;
> > +}
> > +
> > +static void avr_timer16_update_cnt(AVRTimer16State *t16)
> > +{
> > +    uint16_t cnt;
> > +    cnt =3D avr_timer16_ns_to_ticks(t16,
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
> > +                                       t16->reset_time_ns);
> > +    t16->cntl =3D (uint8_t)(cnt & 0xff);
> > +    t16->cnth =3D (uint8_t)((cnt & 0xff00) >> 8);
> > +}
> > +
> > +static inline void avr_timer16_recalc_reset_time(AVRTimer16State *t16)
> > +{
> > +    t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
> > +                         CNT(t16) * t16->period_ns;
> > +}
> > +
> > +static void avr_timer16_clock_reset(AVRTimer16State *t16)
> > +{
> > +    t16->cntl =3D 0;
> > +    t16->cnth =3D 0;
> > +    t16->reset_time_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +}
> > +
> > +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
> > +{
> > +    uint16_t divider =3D 0;
> > +    switch (CLKSRC(t16)) {
> > +    case T16_CLKSRC_EXT_FALLING:
> > +    case T16_CLKSRC_EXT_RISING:
> > +        ERROR("external clock source unsupported");
> > +        goto end;
> > +    case T16_CLKSRC_STOPPED:
> > +        goto end;
> > +    case T16_CLKSRC_DIV1:
> > +        divider =3D 1;
> > +        break;
> > +    case T16_CLKSRC_DIV8:
> > +        divider =3D 8;
> > +        break;
> > +    case T16_CLKSRC_DIV64:
> > +        divider =3D 64;
> > +        break;
> > +    case T16_CLKSRC_DIV256:
> > +        divider =3D 256;
> > +        break;
> > +    case T16_CLKSRC_DIV1024:
> > +        divider =3D 1024;
> > +        break;
> > +    default:
> > +        goto end;
> > +    }
> > +    t16->freq_hz =3D t16->cpu_freq_hz / divider;
> > +    t16->period_ns =3D 1000000000ULL / t16->freq_hz;
> > +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%=
f
> s)",
> > +             t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
> > +end:
> > +    return;
> > +}
> > +
> > +static void avr_timer16_set_alarm(AVRTimer16State *t16)
> > +{
> > +    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
> > +        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
> > +        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
> > +        /* Timer is disabled or set to external clock source
> (unsupported) */
> > +        goto end;
> > +    }
> > +
> > +    uint64_t alarm_offset =3D 0xffff;
> > +    enum NextInterrupt next_interrupt =3D OVERFLOW;
> > +
> > +    switch (MODE(t16)) {
> > +    case T16_MODE_NORMAL:
> > +        /* Normal mode */
> > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
> > +            (t16->imsk & T16_INT_OCA)) {
> > +            alarm_offset =3D OCRA(t16);
> > +            next_interrupt =3D COMPA;
> > +        }
> > +        break;
> > +    case T16_MODE_CTC_OCRA:
> > +        /* CTC mode, top =3D ocra */
> > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
> > +            alarm_offset =3D OCRA(t16);
> > +            next_interrupt =3D COMPA;
> > +        }
> > +       break;
> > +    case T16_MODE_CTC_ICR:
> > +        /* CTC mode, top =3D icr */
> > +        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
> > +            alarm_offset =3D ICR(t16);
> > +            next_interrupt =3D CAPT;
> > +        }
> > +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
> > +            (t16->imsk & T16_INT_OCA)) {
> > +            alarm_offset =3D OCRA(t16);
> > +            next_interrupt =3D COMPA;
> > +        }
> > +        break;
> > +    default:
> > +        ERROR("pwm modes are unsupported");
> > +        goto end;
> > +    }
> > +    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> > +        (t16->imsk & T16_INT_OCB)) {
> > +        alarm_offset =3D OCRB(t16);
> > +        next_interrupt =3D COMPB;
> > +    }
> > +    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
> > +        (t16->imsk & T16_INT_OCC)) {
> > +        alarm_offset =3D OCRB(t16);
> > +        next_interrupt =3D COMPC;
> > +    }
> > +    alarm_offset -=3D CNT(t16);
> > +
> > +    t16->next_interrupt =3D next_interrupt;
> > +    uint64_t alarm_ns =3D
> > +        t16->reset_time_ns + ((CNT(t16) + alarm_offset) *
> t16->period_ns);
> > +    timer_mod(t16->timer, alarm_ns);
> > +
> > +    DB_PRINT("next alarm %" PRIu64 " ns from now",
> > +        alarm_offset * t16->period_ns);
> > +
> > +end:
> > +    return;
> > +}
> > +
> > +static void avr_timer16_interrupt(void *opaque)
> > +{
> > +    AVRTimer16State *t16 =3D opaque;
> > +    uint8_t mode =3D MODE(t16);
> > +
> > +    avr_timer16_update_cnt(t16);
> > +
> > +    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
> > +        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
> > +        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
> > +        /* Timer is disabled or set to external clock source
> (unsupported) */
> > +        return;
> > +    }
> > +
> > +    DB_PRINT("interrupt, cnt =3D %d", CNT(t16));
> > +
> > +    /* Counter overflow */
> > +    if (t16->next_interrupt =3D=3D OVERFLOW) {
> > +        DB_PRINT("0xffff overflow");
> > +        avr_timer16_clock_reset(t16);
> > +        if (t16->imsk & T16_INT_TOV) {
> > +            t16->ifr |=3D T16_INT_TOV;
> > +            qemu_set_irq(t16->ovf_irq, 1);
> > +        }
> > +    }
> > +    /* Check for ocra overflow in CTC mode */
> > +    if (mode =3D=3D T16_MODE_CTC_OCRA && t16->next_interrupt =3D=3D CO=
MPA) {
> > +        DB_PRINT("CTC OCRA overflow");
> > +        avr_timer16_clock_reset(t16);
> > +    }
> > +    /* Check for icr overflow in CTC mode */
> > +    if (mode =3D=3D T16_MODE_CTC_ICR && t16->next_interrupt =3D=3D CAP=
T) {
> > +        DB_PRINT("CTC ICR overflow");
> > +        avr_timer16_clock_reset(t16);
> > +        if (t16->imsk & T16_INT_IC) {
> > +            t16->ifr |=3D T16_INT_IC;
> > +            qemu_set_irq(t16->capt_irq, 1);
> > +        }
> > +    }
> > +    /* Check for output compare interrupts */
> > +    if (t16->imsk & T16_INT_OCA && t16->next_interrupt =3D=3D COMPA) {
> > +        t16->ifr |=3D T16_INT_OCA;
> > +        qemu_set_irq(t16->compa_irq, 1);
> > +    }
> > +    if (t16->imsk & T16_INT_OCB && t16->next_interrupt =3D=3D COMPB) {
> > +        t16->ifr |=3D T16_INT_OCB;
> > +        qemu_set_irq(t16->compb_irq, 1);
> > +    }
> > +    if (t16->imsk & T16_INT_OCC && t16->next_interrupt =3D=3D COMPC) {
> > +        t16->ifr |=3D T16_INT_OCC;
> > +        qemu_set_irq(t16->compc_irq, 1);
> > +    }
> > +    avr_timer16_set_alarm(t16);
> > +}
> > +
> > +static void avr_timer16_reset(DeviceState *dev)
> > +{
> > +    AVRTimer16State *t16 =3D AVR_TIMER16(dev);
> > +
> > +    avr_timer16_clock_reset(t16);
> > +    avr_timer16_clksrc_update(t16);
> > +    avr_timer16_set_alarm(t16);
> > +
> > +    qemu_set_irq(t16->capt_irq, 0);
> > +    qemu_set_irq(t16->compa_irq, 0);
> > +    qemu_set_irq(t16->compb_irq, 0);
> > +    qemu_set_irq(t16->compc_irq, 0);
> > +    qemu_set_irq(t16->ovf_irq, 0);
> > +}
> > +
> > +static uint64_t avr_timer16_read(void *opaque, hwaddr offset, unsigned
> size)
> > +{
> > +    assert(size =3D=3D 1);
> > +    AVRTimer16State *t16 =3D opaque;
> > +    uint8_t retval =3D 0;
> > +
> > +    switch (offset) {
> > +    case T16_CRA:
> > +        retval =3D t16->cra;
> > +        break;
> > +    case T16_CRB:
> > +        retval =3D t16->crb;
> > +        break;
> > +    case T16_CRC:
> > +        retval =3D t16->crc;
> > +        break;
> > +    case T16_CNTL:
> > +        avr_timer16_update_cnt(t16);
> > +        t16->rtmp =3D t16->cnth;
> > +        retval =3D t16->cntl;
> > +        break;
> > +    case T16_CNTH:
> > +        retval =3D t16->rtmp;
> > +        break;
> > +    case T16_ICRL:
> > +        /*
> > +         * The timer copies cnt to icr when the input capture pin
> changes
> > +         * state or when the analog comparator has a match. We don't
> > +         * emulate this behaviour. We do support it's use for defining=
 a
> > +         * TOP value in T16_MODE_CTC_ICR
> > +         */
> > +        t16->rtmp =3D t16->icrh;
> > +        retval =3D t16->icrl;
> > +        break;
> > +    case T16_ICRH:
> > +        retval =3D t16->rtmp;
> > +        break;
> > +    case T16_OCRAL:
> > +        retval =3D t16->ocral;
> > +        break;
> > +    case T16_OCRAH:
> > +        retval =3D t16->ocrah;
> > +        break;
> > +    case T16_OCRBL:
> > +        retval =3D t16->ocrbl;
> > +        break;
> > +    case T16_OCRBH:
> > +        retval =3D t16->ocrbh;
> > +        break;
> > +    case T16_OCRCL:
> > +        retval =3D t16->ocrcl;
> > +        break;
> > +    case T16_OCRCH:
> > +        retval =3D t16->ocrch;
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +    return (uint64_t)retval;
> > +}
> > +
> > +static void avr_timer16_write(void *opaque, hwaddr offset,
> > +                              uint64_t val64, unsigned size)
> > +{
> > +    assert(size =3D=3D 1);
> > +    AVRTimer16State *t16 =3D opaque;
> > +    uint8_t val8 =3D (uint8_t)val64;
> > +    uint8_t prev_clk_src =3D CLKSRC(t16);
> > +
> > +    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
> > +
> > +    switch (offset) {
> > +    case T16_CRA:
> > +        t16->cra =3D val8;
> > +        if (t16->cra & T16_CRA_OC_CONF) {
> > +            ERROR("output compare pins unsupported");
> > +        }
> > +        break;
> > +    case T16_CRB:
> > +        t16->crb =3D val8;
> > +        if (t16->crb & T16_CRB_ICNC) {
> > +            ERROR("input capture noise canceller unsupported");
> > +        }
> > +        if (t16->crb & T16_CRB_ICES) {
> > +            ERROR("input capture unsupported");
> > +        }
> > +        if (CLKSRC(t16) !=3D prev_clk_src) {
> > +            avr_timer16_clksrc_update(t16);
> > +            if (prev_clk_src =3D=3D T16_CLKSRC_STOPPED) {
> > +                t16->reset_time_ns =3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +            }
> > +        }
> > +        break;
> > +    case T16_CRC:
> > +        t16->crc =3D val8;
> > +        ERROR("output compare pins unsupported");
> > +        break;
> > +    case T16_CNTL:
> > +        /*
> > +         * CNT is the 16-bit counter value, it must be read/written vi=
a
> > +         * a temporary register (rtmp) to make the read/write atomic.
> > +         */
> > +        /* ICR also has this behaviour, and shares rtmp */
> > +        /*
> > +         * Writing CNT blocks compare matches for one clock cycle.
> > +         * Writing CNT to TOP or to an OCR value (if in use) will
> > +         * skip the relevant interrupt
> > +         */
> > +        t16->cntl =3D val8;
> > +        t16->cnth =3D t16->rtmp;
> > +        avr_timer16_recalc_reset_time(t16);
> > +        break;
> > +    case T16_CNTH:
> > +        t16->rtmp =3D val8;
> > +        break;
> > +    case T16_ICRL:
> > +        /* ICR can only be written in mode T16_MODE_CTC_ICR */
> > +        if (MODE(t16) =3D=3D T16_MODE_CTC_ICR) {
> > +            t16->icrl =3D val8;
> > +            t16->icrh =3D t16->rtmp;
> > +        }
> > +        break;
> > +    case T16_ICRH:
> > +        if (MODE(t16) =3D=3D T16_MODE_CTC_ICR) {
> > +            t16->rtmp =3D val8;
> > +        }
> > +        break;
> > +    case T16_OCRAL:
> > +        /*
> > +         * OCRn cause the relevant output compare flag to be raised, a=
nd
> > +         * trigger an interrupt, when CNT is equal to the value here
> > +         */
> > +        t16->ocral =3D val8;
> > +        break;
> > +    case T16_OCRAH:
> > +        t16->ocrah =3D val8;
> > +        break;
> > +    case T16_OCRBL:
> > +        t16->ocrbl =3D val8;
> > +        break;
> > +    case T16_OCRBH:
> > +        t16->ocrbh =3D val8;
> > +        break;
> > +    case T16_OCRCL:
> > +        t16->ocrcl =3D val8;
> > +        break;
> > +    case T16_OCRCH:
> > +        t16->ocrch =3D val8;
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +    avr_timer16_set_alarm(t16);
> > +}
> > +
> > +static uint64_t avr_timer16_imsk_read(void *opaque,
> > +                                      hwaddr offset,
> > +                                      unsigned size)
> > +{
> > +    assert(size =3D=3D 1);
> > +    AVRTimer16State *t16 =3D opaque;
> > +    if (offset !=3D 0) {
> > +        return 0;
> > +    }
> > +    return t16->imsk;
> > +}
> > +
> > +static void avr_timer16_imsk_write(void *opaque, hwaddr offset,
> > +                                   uint64_t val64, unsigned size)
> > +{
> > +    assert(size =3D=3D 1);
> > +    AVRTimer16State *t16 =3D opaque;
> > +    if (offset !=3D 0) {
> > +        return;
> > +    }
> > +    t16->imsk =3D (uint8_t)val64;
> > +}
> > +
> > +static uint64_t avr_timer16_ifr_read(void *opaque,
> > +                                     hwaddr offset,
> > +                                     unsigned size)
> > +{
> > +    assert(size =3D=3D 1);
> > +    AVRTimer16State *t16 =3D opaque;
> > +    if (offset !=3D 0) {
> > +        return 0;
> > +    }
> > +    return t16->ifr;
> > +}
> > +
> > +static void avr_timer16_ifr_write(void *opaque, hwaddr offset,
> > +                                  uint64_t val64, unsigned size)
> > +{
> > +    assert(size =3D=3D 1);
> > +    AVRTimer16State *t16 =3D opaque;
> > +    if (offset !=3D 0) {
> > +        return;
> > +    }
> > +    t16->ifr =3D (uint8_t)val64;
> > +}
> > +
> > +static const MemoryRegionOps avr_timer16_ops =3D {
> > +    .read =3D avr_timer16_read,
> > +    .write =3D avr_timer16_write
> if you use .impl { .min =3D 2 } you simplify your design.
>
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN
> > +};
> > +
> > +static const MemoryRegionOps avr_timer16_imsk_ops =3D {
> > +    .read =3D avr_timer16_imsk_read,
> > +    .write =3D avr_timer16_imsk_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN
> > +};
> > +
> > +static const MemoryRegionOps avr_timer16_ifr_ops =3D {
> > +    .read =3D avr_timer16_ifr_read,
> > +    .write =3D avr_timer16_ifr_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN
> > +};
> > +
> > +static Property avr_timer16_properties[] =3D {
> > +    DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
> > +                       cpu_freq_hz, 20000000),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void avr_timer16_init(Object *obj)
> > +{
> > +    AVRTimer16State *s =3D AVR_TIMER16(obj);
> > +
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->capt_irq);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compa_irq);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compb_irq);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compc_irq);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->ovf_irq);
> > +
> > +    memory_region_init_io(&s->iomem, obj, &avr_timer16_ops,
> > +                          s, TYPE_AVR_TIMER16, 0xe);
>
> A timer region is 0x10 wide, Ok.
>
> > +    memory_region_init_io(&s->imsk_iomem, obj, &avr_timer16_imsk_ops,
> > +                          s, TYPE_AVR_TIMER16, 0x1);
> > +    memory_region_init_io(&s->ifr_iomem, obj, &avr_timer16_ifr_ops,
> > +                          s, TYPE_AVR_TIMER16, 0x1);
>
> These 2 registers seem part of the Interrupt Controller, and don't
> belong here. You might want to use a LINK_PROPERTY to link a timer
> device to the INTC.
>
How do I do it?

>
> > +
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->imsk_iomem);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ifr_iomem);
> > +
> > +    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, avr_timer16_interrup=
t,
> s);
> > +}
> > +
> > +static void avr_timer16_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->reset =3D avr_timer16_reset;
> > +    dc->props =3D avr_timer16_properties;
> > +}
> > +
> > +static const TypeInfo avr_timer16_info =3D {
> > +    .name          =3D TYPE_AVR_TIMER16,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(AVRTimer16State),
> > +    .instance_init =3D avr_timer16_init,
> > +    .class_init    =3D avr_timer16_class_init,
> > +};
> > +
> > +static void avr_timer16_register_types(void)
> > +{
> > +    type_register_static(&avr_timer16_info);
> > +}
> > +
> > +type_init(avr_timer16_register_types)
> > diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
> > new file mode 100644
> > index 0000000000..ba28fbe5d1
> > --- /dev/null
> > +++ b/include/hw/char/avr_usart.h
> > @@ -0,0 +1,99 @@
> > +/*
> > + * AVR USART
> > + *
> > + * Copyright (c) 2018 University of Kent
> > + * Author: Sarah Harris
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_AVR_USART_H
> > +#define HW_AVR_USART_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "chardev/char-fe.h"
> > +#include "hw/hw.h"
> > +
> > +/* Offsets of registers. */
> > +#define USART_DR   0x06
> > +#define USART_CSRA  0x00
> > +#define USART_CSRB  0x01
> > +#define USART_CSRC  0x02
> > +#define USART_BRRH 0x05
> > +#define USART_BRRL 0x04
> > +
> > +/* Relevant bits in regiters. */
> > +#define USART_CSRA_RXC    (1 << 7)
> > +#define USART_CSRA_TXC    (1 << 6)
> > +#define USART_CSRA_DRE    (1 << 5)
> > +#define USART_CSRA_MPCM   (1 << 0)
> > +
> > +#define USART_CSRB_RXCIE  (1 << 7)
> > +#define USART_CSRB_TXCIE  (1 << 6)
> > +#define USART_CSRB_DREIE  (1 << 5)
> > +#define USART_CSRB_RXEN   (1 << 4)
> > +#define USART_CSRB_TXEN   (1 << 3)
> > +#define USART_CSRB_CSZ2   (1 << 2)
> > +#define USART_CSRB_RXB8   (1 << 1)
> > +#define USART_CSRB_TXB8   (1 << 0)
> > +
> > +#define USART_CSRC_MSEL1  (1 << 7)
> > +#define USART_CSRC_MSEL0  (1 << 6)
> > +#define USART_CSRC_PM1    (1 << 5)
> > +#define USART_CSRC_PM0    (1 << 4)
> > +#define USART_CSRC_CSZ1   (1 << 2)
> > +#define USART_CSRC_CSZ0   (1 << 1)
> > +
> > +#define TYPE_AVR_USART "avr-usart"
> > +#define AVR_USART(obj) \
> > +    OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
> > +
> > +typedef struct {
> > +    /* <private> */
> > +    SysBusDevice parent_obj;
> > +
> > +    /* <public> */
> > +    MemoryRegion mmio;
> > +
> > +    CharBackend chr;
> > +
> > +    /* Address of Power Reduction Register and bit that controls this
> UART */
> > +    hwaddr prr_address;
> > +    uint8_t prr_mask;
>
> So ideally you'd use a link to the PowerManagement block here.
>
Please explain.

>
> > +
> > +    uint8_t data;
> > +    bool data_valid;
> > +    uint8_t char_mask;
> > +    /* Control and Status Registers */
> > +    uint8_t csra;
> > +    uint8_t csrb;
> > +    uint8_t csrc;
> > +    /* Baud Rate Registers (low/high byte) */
> > +    uint8_t brrh;
> > +    uint8_t brrl;
> > +
> > +    /* Receive Complete */
> > +    qemu_irq rxc_irq;
> > +    /* Transmit Complete */
> > +    qemu_irq txc_irq;
> > +    /* Data Register Empty */
> > +    qemu_irq dre_irq;
> > +} AVRUsartState;
> > +
> > +#endif /* HW_AVR_USART_H */
> > diff --git a/include/hw/timer/avr_timer16.h
> b/include/hw/timer/avr_timer16.h
> > new file mode 100644
> > index 0000000000..301e36a154
> > --- /dev/null
> > +++ b/include/hw/timer/avr_timer16.h
> > @@ -0,0 +1,99 @@
> > +/*
> > + * AVR 16 bit timer
> > + *
> > + * Copyright (c) 2018 University of Kent
> > + * Author: Ed Robbins
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> obtaining a copy
> > + * of this software and associated documentation files (the
> "Software"), to deal
> > + * in the Software without restriction, including without limitation
> the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r
> sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
> OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +/*
> > + * Driver for 16 bit timers on 8 bit AVR devices.
> > + * Note:
> > + * On ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are
> 16 bit
> > + */
> > +
> > +#ifndef AVR_TIMER16_H
> > +#define AVR_TIMER16_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "qemu/timer.h"
> > +#include "hw/hw.h"
> > +
> > +enum NextInterrupt {
> > +    OVERFLOW,
> > +    COMPA,
> > +    COMPB,
> > +    COMPC,
> > +    CAPT
> > +};
> > +
> > +#define TYPE_AVR_TIMER16 "avr-timer16"
> > +#define AVR_TIMER16(obj) \
> > +    OBJECT_CHECK(AVRTimer16State, (obj), TYPE_AVR_TIMER16)
> > +
> > +typedef struct AVRTimer16State {
> > +    /* <private> */
> > +    SysBusDevice parent_obj;
> > +
> > +    /* <public> */
> > +    MemoryRegion iomem;
> > +    MemoryRegion imsk_iomem;
> > +    MemoryRegion ifr_iomem;
> > +    QEMUTimer *timer;
> > +    qemu_irq capt_irq;
> > +    qemu_irq compa_irq;
> > +    qemu_irq compb_irq;
> > +    qemu_irq compc_irq;
> > +    qemu_irq ovf_irq;
> > +
> > +    /* Address of Power Reduction Register and bit that controls this
> timer */
> > +    hwaddr prr_address;
> > +    uint8_t prr_mask;
>
> Again, you should use a link to the PowerManagement block here.
>
> > +
> > +    /* registers */
> > +    uint8_t cra;
> > +    uint8_t crb;
> > +    uint8_t crc;
>
> Using 16-bit for following...
>
> > +    uint8_t cntl;
> > +    uint8_t cnth;
> > +    uint8_t icrl;
> > +    uint8_t icrh;
> > +    uint8_t ocral;
> > +    uint8_t ocrah;
> > +    uint8_t ocrbl;
> > +    uint8_t ocrbh;
> > +    uint8_t ocrcl;
> > +    uint8_t ocrch;
>
> ... until here would simplify your model.
>
> > +    /*
> > +     * Reads and writes to CNT and ICR utilise a bizarre temporary
> > +     * register, which we emulate
> > +     */
> > +    uint8_t rtmp;
> > +    uint8_t imsk;
> > +    uint8_t ifr;
> > +
> > +    uint64_t cpu_freq_hz;
> > +    uint64_t freq_hz;
> > +    uint64_t period_ns;
> > +    uint64_t reset_time_ns;
> > +    enum NextInterrupt next_interrupt;
> > +} AVRTimer16State;
> > +
> > +#endif /* AVR_TIMER16_H */
> >
>
> If the maintainer taking your series don't think my comments are
> blockers, you might consider them as later cleanup.
>
> Regards,
>
> Phil.
>


--=20
Best Regards,
Michael Rolnik
