Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2773C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 22:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E172084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 22:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL7JgynE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E172084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ38j-0002rq-La
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 18:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iJ380-0002Lk-BA
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 18:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iJ37y-0007c8-Ez
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 18:11:16 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iJ37y-0007bq-4C; Fri, 11 Oct 2019 18:11:14 -0400
Received: by mail-lf1-x142.google.com with SMTP id w67so8066471lff.4;
 Fri, 11 Oct 2019 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9DXU3yKjKAMChI4byGdPlcohmpc4C0dCHpkm1aEEEAc=;
 b=dL7JgynE6VQKjSznZ+NP6Viea08wuvk5Uwx9PEK4Vk7y6OhL0SjgDT8Pp6UsH3o9wf
 3LQRYzEjnnjb3eGCsYXdsWJH5u0FRPnWlxrvZXHdjoS4uOHjmCNM3LP8GH/aHGrHevmG
 MEegIs1JhPg22a7ZGRRQX1HZtcH8/hPADYTr+lGGUHLR5DLzNFiFQGv4KMmapjcWm6kk
 f0ZiZI8BdvObhgpgKHFUloitOG95FYIyBTdG60GkCN3pVO4UUJhn/1+79bHfVIU+Xo9x
 dyYyRevCcvzJFzb/qsGu5MczxMC0PFR8/x46v8qXARB2SspgztJ00HE00wUOLjhWMb96
 EmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9DXU3yKjKAMChI4byGdPlcohmpc4C0dCHpkm1aEEEAc=;
 b=UptZGUmKmN6Lo1W0ry+fao4yUyUWvYVt3FWV0KRjSNFhXtF3aSWUW4vYedFmBca5bJ
 OfcHdOxUhEE4bX6olidmCI4RsHORN3J6zHAMImP3ETlfb4XG/5oaZLsdx9ikXZbnP3nI
 L26ku6iJPrrqZ07DzsYCXggv3f+hhgggCAYtQA3qfR1epEwKLblFYh0WeJG0PSr6VlBv
 Eg1vVad2AifwZ/sy8JBm6Qo++nWqtceFE7hjcNHfwi7KYheMfPwCAT+QB0FyfZ1nmF/x
 tISQDRv2oBEKnBjqyU+K8GpWTYDZ57dkWeVyH6hdUCFcQmlK9+KolIs7vc2xUjvs6dR/
 TRpQ==
X-Gm-Message-State: APjAAAVFo47X4+Q3XuRZuu11J+TH3KC31JC2o6+kO41rEINL7QVzhUoF
 zsTElP4AcvdPKeadxPFncX5dslClqF/VuayQcxU=
X-Google-Smtp-Source: APXvYqy/GWd7yMk0nKmV0A2sMYNz4vJcuTAw99WlarkBqQlsjSfcZ36X5y3TKaiDGrdy5U77jMh101EsL2+2ardNoHI=
X-Received: by 2002:a19:c38c:: with SMTP id t134mr9798538lff.44.1570831872541; 
 Fri, 11 Oct 2019 15:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191007170646.14961-1-f4bug@amsat.org>
 <20191007170646.14961-2-f4bug@amsat.org>
In-Reply-To: <20191007170646.14961-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2019 15:05:56 -0700
Message-ID: <CAKmqyKM-7caCkev3U2x_ZhCJc-zgRk5SN1QkfHAxCQk1C44cZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/char: Add the BCM2835 miniuart
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 7, 2019 at 10:18 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> The miniuart code is already present in the multi-device
> hw/char/bcm2835_aux.c. Simply extracting it does not generate
> patch easy to review. Instead, add it again, rename the function
> names accordingly, use the "hw/registerfields.h" API.
> This is roughtly a copy of commit 97398d900caacc.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/Makefile.objs              |   1 +
>  hw/char/bcm2835_miniuart.c         | 327 +++++++++++++++++++++++++++++
>  hw/char/trace-events               |   4 +
>  include/hw/char/bcm2835_miniuart.h |  37 ++++
>  4 files changed, 369 insertions(+)
>  create mode 100644 hw/char/bcm2835_miniuart.c
>  create mode 100644 include/hw/char/bcm2835_miniuart.h
>
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 02d8a66925..5bd93bde9f 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -22,6 +22,7 @@ obj-$(CONFIG_DIGIC) +=3D digic-uart.o
>  obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
>  obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
>
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_miniuart.o
>  common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
>  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
>  common-obj-$(CONFIG_ISA_DEBUG) +=3D debugcon.o
> diff --git a/hw/char/bcm2835_miniuart.c b/hw/char/bcm2835_miniuart.c
> new file mode 100644
> index 0000000000..0e99cecce7
> --- /dev/null
> +++ b/hw/char/bcm2835_miniuart.c
> @@ -0,0 +1,327 @@
> +/*
> + * BCM2835 (Raspberry Pi) mini UART block.
> + *
> + * Copyright (c) 2015, Microsoft
> + * Written by Andrew Baumann
> + * Based on pl011.c.
> + *
> + * This code is licensed under the GPL.
> + *
> + * At present only the core UART functions (data path for tx/rx) are
> + * implemented. The following features/registers are unimplemented:
> + *  - Line/modem control
> + *  - Scratch register
> + *  - Extra control
> + *  - Baudrate
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/char/bcm2835_miniuart.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/registerfields.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +REG32(MU_IO,        0x00)
> +REG32(MU_IER,       0x04)
> +REG32(MU_IIR,       0x08)
> +REG32(MU_LCR,       0x0c)
> +REG32(MU_MCR,       0x10)
> +REG32(MU_LSR,       0x14)
> +REG32(MU_MSR,       0x18)
> +REG32(MU_SCRATCH,   0x1c)
> +REG32(MU_CNTL,      0x20)
> +REG32(MU_STAT,      0x24)
> +REG32(MU_BAUD,      0x28)
> +
> +/* bits in IER/IIR registers */
> +#define RX_INT  0x1
> +#define TX_INT  0x2
> +
> +static void bcm2835_miniuart_update(BCM2835MiniUartState *s)
> +{
> +    /*
> +     * Signal an interrupt if either:
> +     *
> +     * 1. rx interrupt is enabled and we have a non-empty rx fifo, or
> +     * 2. the tx interrupt is enabled (since we instantly drain the tx f=
ifo)
> +     */
> +    s->iir =3D 0;
> +    if ((s->ier & RX_INT) && s->read_count !=3D 0) {
> +        s->iir |=3D RX_INT;
> +    }
> +    if (s->ier & TX_INT) {
> +        s->iir |=3D TX_INT;
> +    }
> +    qemu_set_irq(s->irq, s->iir !=3D 0);
> +}
> +
> +static bool is_16650(hwaddr offset)
> +{
> +    return offset < A_MU_CNTL;
> +}
> +
> +static uint64_t bcm2835_miniuart_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    BCM2835MiniUartState *s =3D opaque;
> +    uint32_t c, res =3D 0;
> +
> +    switch (offset) {
> +    case A_MU_IO:
> +        /* "DLAB bit set means access baudrate register" is NYI */
> +        c =3D s->read_fifo[s->read_pos];
> +        if (s->read_count > 0) {
> +            s->read_count--;
> +            if (++s->read_pos =3D=3D BCM2835_MINIUART_RX_FIFO_LEN) {
> +                s->read_pos =3D 0;
> +            }
> +        }
> +        qemu_chr_fe_accept_input(&s->chr);
> +        bcm2835_miniuart_update(s);
> +        res =3D c;
> +        break;
> +
> +    case A_MU_IER:
> +        /* "DLAB bit set means access baudrate register" is NYI */
> +        res =3D 0xc0 | s->ier; /* FIFO enables always read 1 */
> +        break;
> +
> +    case A_MU_IIR:
> +        res =3D 0xc0; /* FIFO enables */
> +        /*
> +         * The spec is unclear on what happens when both tx and rx
> +         * interrupts are active, besides that this cannot occur. At
> +         * present, we choose to prioritise the rx interrupt, since
> +         * the tx fifo is always empty.
> +         */
> +        if (s->read_count !=3D 0) {
> +            res |=3D 0x4;
> +        } else {
> +            res |=3D 0x2;
> +        }
> +        if (s->iir =3D=3D 0) {
> +            res |=3D 0x1;
> +        }
> +        break;
> +
> +    case A_MU_LCR:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_LCR_REG unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_MCR:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_MCR_REG unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_LSR:
> +        res =3D 0x60; /* tx idle, empty */
> +        if (s->read_count !=3D 0) {
> +            res |=3D 0x1;
> +        }
> +        break;
> +
> +    case A_MU_MSR:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_MSR_REG unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_SCRATCH:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_SCRATCH unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_CNTL:
> +        res =3D 0x3; /* tx, rx enabled */
> +        break;
> +
> +    case A_MU_STAT:
> +        res =3D 0x30e; /* space in the output buffer, empty tx fifo, idl=
e tx/rx */
> +        if (s->read_count > 0) {
> +            res |=3D 0x1; /* data in input buffer */
> +            assert(s->read_count < BCM2835_MINIUART_RX_FIFO_LEN);
> +            res |=3D ((uint32_t)s->read_count) << 16; /* rx fifo fill le=
vel */
> +        }
> +        break;
> +
> +    case A_MU_BAUD:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_BAUD_REG unsupported\n", __fu=
nc__);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +                      __func__, offset);
> +        break;
> +    }
> +
> +    if (is_16650(offset)) {
> +        trace_serial_ioport_read((offset & 0x1f) >> 2, res);
> +    } else {
> +        trace_bcm2835_miniuart_read(offset, res);
> +    }
> +
> +    return res;
> +}
> +
> +static void bcm2835_miniuart_write(void *opaque, hwaddr offset, uint64_t=
 value,
> +                                   unsigned size)
> +{
> +    BCM2835MiniUartState *s =3D opaque;
> +    unsigned char ch;
> +
> +    if (is_16650(offset)) {
> +        trace_serial_ioport_write((offset & 0x1f) >> 2, value);
> +    } else {
> +        trace_bcm2835_miniuart_write(offset, value);
> +    }
> +
> +    switch (offset) {
> +    case A_MU_IO:
> +        /* "DLAB bit set means access baudrate register" is NYI */
> +        ch =3D value;
> +        /*
> +         * XXX this blocks entire thread. Rewrite to use
> +         * qemu_chr_fe_write and background I/O callbacks
> +         */
> +        qemu_chr_fe_write_all(&s->chr, &ch, 1);
> +        break;
> +
> +    case A_MU_IER:
> +        /* "DLAB bit set means access baudrate register" is NYI */
> +        s->ier =3D value & (TX_INT | RX_INT);
> +        bcm2835_miniuart_update(s);
> +        break;
> +
> +    case A_MU_IIR:
> +        if (value & 0x2) {
> +            s->read_count =3D 0;
> +        }
> +        break;
> +
> +    case A_MU_LCR:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_LCR_REG unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_MCR:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_MCR_REG unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_SCRATCH:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_SCRATCH unsupported\n", __fun=
c__);
> +        break;
> +
> +    case A_MU_CNTL:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_CNTL_REG unsupported\n", __fu=
nc__);
> +        break;
> +
> +    case A_MU_BAUD:
> +        qemu_log_mask(LOG_UNIMP, "%s: A_MU_BAUD_REG unsupported\n", __fu=
nc__);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +                      __func__, offset);
> +    }
> +
> +    bcm2835_miniuart_update(s);
> +}
> +
> +static int bcm2835_miniuart_can_receive(void *opaque)
> +{
> +    BCM2835MiniUartState *s =3D opaque;
> +
> +    return s->read_count < BCM2835_MINIUART_RX_FIFO_LEN;
> +}
> +
> +static void bcm2835_miniuart_put_fifo(void *opaque, uint8_t value)
> +{
> +    BCM2835MiniUartState *s =3D opaque;
> +    int slot;
> +
> +    slot =3D s->read_pos + s->read_count;
> +    if (slot >=3D BCM2835_MINIUART_RX_FIFO_LEN) {
> +        slot -=3D BCM2835_MINIUART_RX_FIFO_LEN;
> +    }
> +    s->read_fifo[slot] =3D value;
> +    s->read_count++;
> +    if (s->read_count =3D=3D BCM2835_MINIUART_RX_FIFO_LEN) {
> +        /* buffer full */
> +    }
> +    bcm2835_miniuart_update(s);
> +}
> +
> +static void bcm2835_miniuart_receive(void *opaque, const uint8_t *buf, i=
nt size)
> +{
> +    bcm2835_miniuart_put_fifo(opaque, *buf);
> +}
> +
> +static const MemoryRegionOps bcm2835_miniuart_ops =3D {
> +    .read =3D bcm2835_miniuart_read,
> +    .write =3D bcm2835_miniuart_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +};
> +
> +static const VMStateDescription vmstate_bcm2835_aux =3D {
> +    .name =3D TYPE_BCM2835_MINIUART,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(read_fifo, BCM2835MiniUartState,
> +                            BCM2835_MINIUART_RX_FIFO_LEN),
> +        VMSTATE_UINT8(read_pos, BCM2835MiniUartState),
> +        VMSTATE_UINT8(read_count, BCM2835MiniUartState),
> +        VMSTATE_UINT8(ier, BCM2835MiniUartState),
> +        VMSTATE_UINT8(iir, BCM2835MiniUartState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void bcm2835_miniuart_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    BCM2835MiniUartState *s =3D BCM2835_MINIUART(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_miniuart_ops, s=
,
> +                          TYPE_BCM2835_MINIUART, 0x40);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void bcm2835_miniuart_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2835MiniUartState *s =3D BCM2835_MINIUART(dev);
> +
> +    qemu_chr_fe_set_handlers(&s->chr, bcm2835_miniuart_can_receive,
> +                             bcm2835_miniuart_receive, NULL, NULL,
> +                             s, NULL, true);
> +}
> +
> +static Property bcm2835_miniuart_props[] =3D {
> +    DEFINE_PROP_CHR("chardev", BCM2835MiniUartState, chr),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void bcm2835_miniuart_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D bcm2835_miniuart_realize;
> +    dc->vmsd =3D &vmstate_bcm2835_aux;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    dc->props =3D bcm2835_miniuart_props;
> +}
> +
> +static const TypeInfo bcm2835_miniuart_info =3D {
> +    .name          =3D TYPE_BCM2835_MINIUART,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(BCM2835MiniUartState),
> +    .instance_init =3D bcm2835_miniuart_init,
> +    .class_init    =3D bcm2835_miniuart_class_init,
> +};
> +
> +static void bcm2835_miniuart_register_types(void)
> +{
> +    type_register_static(&bcm2835_miniuart_info);
> +}
> +
> +type_init(bcm2835_miniuart_register_types)
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 2ce7f2f998..f1e6dd9918 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -1,5 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
> +# bcm2835_miniuart.c
> +bcm2835_miniuart_read(uint64_t addr, uint32_t value) "read addr 0x%"PRIx=
64" value 0x%x"
> +bcm2835_miniuart_write(uint64_t addr, uint32_t value) "read addr 0x%"PRI=
x64" value 0x%x"
> +
>  # parallel.c
>  parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "re=
ad [%s] addr 0x%02x val 0x%02x"
>  parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "w=
rite [%s] addr 0x%02x val 0x%02x"
> diff --git a/include/hw/char/bcm2835_miniuart.h b/include/hw/char/bcm2835=
_miniuart.h
> new file mode 100644
> index 0000000000..54d3b622ed
> --- /dev/null
> +++ b/include/hw/char/bcm2835_miniuart.h
> @@ -0,0 +1,37 @@
> +/*
> + * BCM2835 (Raspberry Pi) mini UART block.
> + *
> + * Copyright (c) 2015, Microsoft
> + * Written by Andrew Baumann
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_CHAR_BCM2835_MINIUART_H
> +#define HW_CHAR_BCM2835_MINIUART_H
> +
> +#include "chardev/char-fe.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +
> +#define TYPE_BCM2835_MINIUART "bcm2835-miniuart"
> +#define BCM2835_MINIUART(obj) \
> +            OBJECT_CHECK(BCM2835MiniUartState, (obj), TYPE_BCM2835_MINIU=
ART)
> +
> +#define BCM2835_MINIUART_RX_FIFO_LEN 8
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +    CharBackend chr;
> +    qemu_irq irq;
> +
> +    uint8_t read_fifo[BCM2835_MINIUART_RX_FIFO_LEN];
> +    uint8_t read_pos, read_count;
> +    uint8_t ier, iir;
> +} BCM2835MiniUartState;
> +
> +#endif
> --
> 2.21.0
>
>

