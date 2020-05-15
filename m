Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D00720727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5gkNos0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D00720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZgRO-0001A8-Gn
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZgQm-0000dY-AJ; Fri, 15 May 2020 15:55:40 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZgQk-0007r1-V1; Fri, 15 May 2020 15:55:40 -0400
Received: by mail-io1-xd41.google.com with SMTP id w25so3978743iol.12;
 Fri, 15 May 2020 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=glBjWxTO+LzErp3EZk5U3CUS+MU9Ypjf8rUnj2dHV88=;
 b=P5gkNos0mQ1rymRacC6LMKnukf2DCnDp0hWkU5rwcvYiKHWojkDkBz4W3J7731Bn9w
 SpvuwW4ci0suKnBfeWjK/ZsczYz3Ih8tFcIZlUE41HK1VCnAHjcrLd6pQCdN6xD2hDZ9
 2vuGVRuKBNHnUdpYI4NGBY9fyZCVuJlEQvfZkDewzZxCJqwUVukO5nG8x6610GBdkooM
 ZYa9hxH2YjINmBGQkiE4rSifG4PloqqCbDkbBGGUTRZjCZyiCidbdgKx/Rpr1oG+nb3C
 l6ShEh6F9Tm3qiEPL2KWn52dDRokgnUxh4+CUSizitTm1AgIkz1bVh4HUolrpvyReQ8t
 PYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=glBjWxTO+LzErp3EZk5U3CUS+MU9Ypjf8rUnj2dHV88=;
 b=UO9sVYIvqWbeZRElYqbLjJI67/haoFSTnEF48aAwpSLvJSGyxijWkvP4SynoYRUIbo
 2aFZDz34t7d4Pe2kQq8TLhodLMlylOF/LXkaftKzSncE8dfS6UDW6b6BrdMAlAQuFn1p
 Laj51844EfMrC6rjukeacmEe0fbsHIW8IHZggoiMQiDllLheLCho+nqJHkUVDiZxrXFH
 2S+jf3lPdBpqaZvjija4dPx+qmUxixAiLINkWkx2VOuA3kQgNtC6ki9RTtl+4fqw5nUa
 uAv8ppwSPSsZmUzN8BUATIOgZIUXOlRzfBgMOhZZZA39zgVY2AeWaCRRpiJG0OXyM8QM
 2UTA==
X-Gm-Message-State: AOAM530phoLjpQfuoEsUqGeRHgoLMiplorXIl9zbNEDDR+T4zi4ahXDu
 sYDtbW5QAWr9i+5XPY/2rB4jIzPOqOyOWa2iJGoYw6WZ
X-Google-Smtp-Source: ABdhPJxbn7BlC1gbk3mwJBOnYBOB9REm7pIoqOS7/yP77NT/NoZa9fqWNbO8TrvoxcjuwodPthEKUZQEhjyESnY3oiw=
X-Received: by 2002:a02:a887:: with SMTP id l7mr4744918jam.91.1589572537454;
 Fri, 15 May 2020 12:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <11b8f3cd28fd52b10caefe21a7b70444b85792f8.1588878756.git.alistair.francis@wdc.com>
 <eddc757b-db7f-f658-4417-f3ad65e52b13@redhat.com>
In-Reply-To: <eddc757b-db7f-f658-4417-f3ad65e52b13@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 May 2020 12:46:48 -0700
Message-ID: <CAKmqyKO0XLkO2+kQQi35X8Jh65Oj2XMqcZbM69zQJC5jNi07uw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] hw/char: Initial commit of Ibex UART
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 5/7/20 9:13 PM, Alistair Francis wrote:
> > This is the initial commit of the Ibex UART device. Serial TX is
> > working, while RX has been implemeneted but untested.
> >
> > This is based on the documentation from:
> > https://docs.opentitan.org/hw/ip/uart/doc/
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   MAINTAINERS                 |   2 +
> >   hw/char/Makefile.objs       |   1 +
> >   hw/char/ibex_uart.c         | 490 +++++++++++++++++++++++++++++++++++=
+
> >   hw/riscv/Kconfig            |   4 +
> >   include/hw/char/ibex_uart.h | 110 ++++++++
>
> If possible setup scripts/git.orderfile to ease review (avoid scrolling).

I have set this up.

>
> >   5 files changed, 607 insertions(+)
> >   create mode 100644 hw/char/ibex_uart.c
> >   create mode 100644 include/hw/char/ibex_uart.h
> >
> [...]
> > +static void ibex_uart_write(void *opaque, hwaddr addr,
> > +                                  uint64_t val64, unsigned int size)
> > +{
> > +    IbexUartState *s =3D opaque;
> > +    uint32_t value =3D val64;
> > +
> > +    switch (addr) {
> > +    case IBEX_UART_INTR_STATE:
> > +        /* Write 1 clear */
> > +        s->uart_intr_state &=3D ~value;
> > +        ibex_uart_update_irqs(s);
> > +        break;
> > +    case IBEX_UART_INTR_ENABLE:
> > +        s->uart_intr_enable =3D value;
> > +        ibex_uart_update_irqs(s);
> > +        break;
> > +    case IBEX_UART_INTR_TEST:
> > +        s->uart_intr_state |=3D value;
> > +        ibex_uart_update_irqs(s);
> > +        break;
> > +
> > +    case IBEX_UART_CTRL:
> > +        s->uart_ctrl =3D value;
> > +
> > +        if (value & UART_CTRL_NF) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_NF is not supported\n", __fun=
c__);
> > +        }
> > +        if (value & UART_CTRL_SLPBK) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_SLPBK is not supported\n", __=
func__);
> > +        }
> > +        if (value & UART_CTRL_LLPBK) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_LLPBK is not supported\n", __=
func__);
> > +        }
> > +        if (value & UART_CTRL_PARITY_EN) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_PARITY_EN is not supported\n"=
,
> > +                          __func__);
> > +        }
> > +        if (value & UART_CTRL_PARITY_ODD) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_PARITY_ODD is not supported\n=
",
> > +                          __func__);
> > +        }
> > +        if (value & UART_CTRL_RXBLVL) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_RXBLVL is not supported\n", _=
_func__);
> > +        }
> > +        if (value & UART_CTRL_NCO) {
> > +            uint64_t baud =3D ((value & UART_CTRL_NCO) >> 16);
> > +            baud *=3D 1000;
> > +            baud /=3D 2 ^ 20;
> > +
> > +            s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> > +        }
> > +        break;
> > +    case IBEX_UART_STATUS:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: status is read only\n", __func__);
> > +        break;
> > +
> > +    case IBEX_UART_RDATA:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: rdata is read only\n", __func__);
> > +        break;
> > +    case IBEX_UART_WDATA:
> > +        uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> > +        break;
> > +
> > +    case IBEX_UART_FIFO_CTRL:
> > +        s->uart_fifo_ctrl =3D value;
> > +
> > +        if (value & FIFO_CTRL_RXRST) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: RX fifos are not supported\n", __func__=
);
> > +        }
> > +        if (value & FIFO_CTRL_TXRST) {
> > +            s->tx_level =3D 0;
> > +        }
> > +        break;
> > +    case IBEX_UART_FIFO_STATUS:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: fifo_status is read only\n", __func__);
> > +        break;
> > +
> > +    case IBEX_UART_OVRD:
> > +        s->uart_ovrd =3D value;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: ovrd is not supported\n", __func__);
> > +        break;
> > +    case IBEX_UART_VAL:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: val is read only\n", __func__);
> > +        break;
> > +    case IBEX_UART_TIMEOUT_CTRL:
> > +        s->uart_timeout_ctrl =3D value;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: timeout_ctrl is not supported\n", __func__)=
;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, a=
ddr);
> > +    }
> > +}
> > +
> > +static void fifo_trigger_update(void *opaque)
> > +{
> > +    IbexUartState *s =3D opaque;
> > +
> > +    if (s->uart_ctrl & UART_CTRL_TX_ENABLE) {
> > +        ibex_uart_xmit(NULL, G_IO_OUT, s);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps ibex_uart_ops =3D {
> > +    .read =3D ibex_uart_read,
> > +    .write =3D ibex_uart_write,
>
> As all registers are 32-bit, you want .impl min/max =3D 4 here.

Added.

>
> Otherwise patch looks good.

Thanks!

Alistair

>
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> [...]
> > diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
> > new file mode 100644
> > index 0000000000..2bec772615
> > --- /dev/null
> > +++ b/include/hw/char/ibex_uart.h
> > @@ -0,0 +1,110 @@
> > +/*
> > + * QEMU lowRISC Ibex UART device
> > + *
> > + * Copyright (c) 2020 Western Digital
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef HW_IBEX_UART_H
> > +#define HW_IBEX_UART_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "chardev/char-fe.h"
> > +#include "qemu/timer.h"
> > +
> > +#define IBEX_UART_INTR_STATE   0x00
> > +    #define INTR_STATE_TX_WATERMARK (1 << 0)
> > +    #define INTR_STATE_RX_WATERMARK (1 << 1)
> > +    #define INTR_STATE_TX_EMPTY     (1 << 2)
> > +    #define INTR_STATE_RX_OVERFLOW  (1 << 3)
> > +#define IBEX_UART_INTR_ENABLE  0x04
> > +#define IBEX_UART_INTR_TEST    0x08
> > +
> > +#define IBEX_UART_CTRL         0x0c
> > +    #define UART_CTRL_TX_ENABLE     (1 << 0)
> > +    #define UART_CTRL_RX_ENABLE     (1 << 1)
> > +    #define UART_CTRL_NF            (1 << 2)
> > +    #define UART_CTRL_SLPBK         (1 << 4)
> > +    #define UART_CTRL_LLPBK         (1 << 5)
> > +    #define UART_CTRL_PARITY_EN     (1 << 6)
> > +    #define UART_CTRL_PARITY_ODD    (1 << 7)
> > +    #define UART_CTRL_RXBLVL        (3 << 8)
> > +    #define UART_CTRL_NCO           (0xFFFF << 16)
> > +
> > +#define IBEX_UART_STATUS       0x10
> > +    #define UART_STATUS_TXFULL  (1 << 0)
> > +    #define UART_STATUS_RXFULL  (1 << 1)
> > +    #define UART_STATUS_TXEMPTY (1 << 2)
> > +    #define UART_STATUS_RXIDLE  (1 << 4)
> > +    #define UART_STATUS_RXEMPTY (1 << 5)
> > +
> > +#define IBEX_UART_RDATA        0x14
> > +#define IBEX_UART_WDATA        0x18
> > +
> > +#define IBEX_UART_FIFO_CTRL    0x1c
> > +    #define FIFO_CTRL_RXRST          (1 << 0)
> > +    #define FIFO_CTRL_TXRST          (1 << 1)
> > +    #define FIFO_CTRL_RXILVL         (7 << 2)
> > +    #define FIFO_CTRL_RXILVL_SHIFT   (2)
> > +    #define FIFO_CTRL_TXILVL         (3 << 5)
> > +    #define FIFO_CTRL_TXILVL_SHIFT   (5)
> > +
> > +#define IBEX_UART_FIFO_STATUS  0x20
> > +#define IBEX_UART_OVRD         0x24
> > +#define IBEX_UART_VAL          0x28
> > +#define IBEX_UART_TIMEOUT_CTRL 0x2c
> > +
> > +#define IBEX_UART_TX_FIFO_SIZE 16
> > +
> > +#define TYPE_IBEX_UART "ibex-uart"
> > +#define IBEX_UART(obj) \
> > +    OBJECT_CHECK(IbexUartState, (obj), TYPE_IBEX_UART)
> > +
> > +typedef struct {
> > +    /* <private> */
> > +    SysBusDevice parent_obj;
> > +
> > +    /* <public> */
> > +    MemoryRegion mmio;
> > +
> > +    uint8_t tx_fifo[IBEX_UART_TX_FIFO_SIZE];
> > +    uint32_t tx_level;
> > +
> > +    QEMUTimer *fifo_trigger_handle;
> > +    uint64_t char_tx_time;
> > +
> > +    uint32_t uart_intr_state;
> > +    uint32_t uart_intr_enable;
> > +    uint32_t uart_ctrl;
> > +    uint32_t uart_status;
> > +    uint32_t uart_rdata;
> > +    uint32_t uart_fifo_ctrl;
> > +    uint32_t uart_fifo_status;
> > +    uint32_t uart_ovrd;
> > +    uint32_t uart_val;
> > +    uint32_t uart_timeout_ctrl;
> > +
> > +    CharBackend chr;
> > +    qemu_irq tx_watermark;
> > +    qemu_irq rx_watermark;
> > +    qemu_irq tx_empty;
> > +    qemu_irq rx_overflow;
> > +} IbexUartState;
> > +#endif /* HW_IBEX_UART_H */
> >
>

