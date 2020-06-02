Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F79AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE502072F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDwABg4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE502072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgB9m-0004Sj-Hm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jgB92-0003ma-Ev; Tue, 02 Jun 2020 13:56:12 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:35359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jgB90-0001kM-9y; Tue, 02 Jun 2020 13:56:12 -0400
Received: by mail-il1-x143.google.com with SMTP id l6so2853936ilo.2;
 Tue, 02 Jun 2020 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C9/BWwFUSjQYUZHpR2U1n+ipK0D5/2jLfdW86QPc1hg=;
 b=WDwABg4fNUWg3zFCu2yGRDxjHVctYlkDQq8O83gm5UCdwXh/ybi3vkLbo/IV9UzOZz
 hC2oNxcf3oE94ORQYmN4j11lPm+6EvGVwSivBeI78q+qLSLcU+lyYmvXhgl0ji8RoYhL
 QgDcZRW8Xup3IhvSDmXGKkLoAyiw0qUhW8N9Y6hJMNoyI1ks/HjGy/l8Bnxz03/gCqP2
 oeSfs1TvcOub9qi//XpmDFIl145SoRqblc7SjPiM4GtKUBQeoymI7mFtGMRW/tWSWlqL
 HN9WZ65tgu3eBnugv2+XBv+WlbLmltkSS5yGeDBA/EK3XsOBtVGmjIHaWJ6eeoa/9V5w
 FKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C9/BWwFUSjQYUZHpR2U1n+ipK0D5/2jLfdW86QPc1hg=;
 b=LIxphDe6NVmiP+Sn2FpwNDmeAQv/VAU0M68UQqID2GwrqWspQtpuG0K07k2M4LAuVx
 DpH4vG1lFNjxzxdyEVlOu5qIfxvshGaTxYk21ZkpUoJSsnl9WzgLqMBUqUHINIU2BdYj
 8SgFYqIjz38x+czwuXXP2zAR7f15apR3Q2fl6Cge/XOVza8dBgYxXynQ5QAAAdeHbCue
 WLeadMlQmliaZQPCYUhK5yMmPuBdJroTKyu1lwzrq6GhYoX/jx54kR1Xv1LRaXzfYZv8
 zVyqUlmOcJzV9a7xiMAySGzxOXP8w8Vr5CNFp1OV22EUxJVyRGiKXLWDz0U2EWwA6dIK
 6eCQ==
X-Gm-Message-State: AOAM533u6abWw/YfhOZMZzAWK/c37IFxMGKx36X1TpdbwzJpaU9Zx44y
 N+c9J28bsgzjFgHEFKLNIE243l1cP+d/E3B9ArY=
X-Google-Smtp-Source: ABdhPJzulg6spPE7rM5COuFdQbhuKX8DOKU8dLEM0c4BmrIkBBpgiLnzq0uSLdNIjsTFHYo7urPR+O1lud2dZH28Yl4=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr543108ili.40.1591120568150;
 Tue, 02 Jun 2020 10:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <73cce2d0edd0d41ba15df403a2096bfa70bf0565.1590704015.git.alistair.francis@wdc.com>
 <cc1a1671-b926-bb31-1ed2-d2920f0faf38@c-sky.com>
In-Reply-To: <cc1a1671-b926-bb31-1ed2-d2920f0faf38@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jun 2020 10:46:58 -0700
Message-ID: <CAKmqyKOobaARcCuUsDW9ScbHaY7ydBULpxxVcMPYDuE86K2tjA@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] hw/char: Initial commit of Ibex UART
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 2, 2020 at 4:22 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/5/29 6:14, Alistair Francis wrote:
> > This is the initial commit of the Ibex UART device. Serial TX is
> > working, while RX has been implemeneted but untested.
> >
> > This is based on the documentation from:
> > https://docs.opentitan.org/hw/ip/uart/doc/
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   include/hw/char/ibex_uart.h | 110 ++++++++
> >   hw/char/ibex_uart.c         | 492 ++++++++++++++++++++++++++++++++++++
> >   MAINTAINERS                 |   2 +
> >   hw/char/Makefile.objs       |   1 +
> >   hw/riscv/Kconfig            |   4 +
> >   5 files changed, 609 insertions(+)
> >   create mode 100644 include/hw/char/ibex_uart.h
> >   create mode 100644 hw/char/ibex_uart.c
> >
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
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
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
> > diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> > new file mode 100644
> > index 0000000000..c416325d73
> > --- /dev/null
> > +++ b/hw/char/ibex_uart.c
> > @@ -0,0 +1,492 @@
> > +/*
> > + * QEMU lowRISC Ibex UART device
> > + *
> > + * Copyright (c) 2020 Western Digital
> > + *
> > + * For details check the documentation here:
> > + *    https://docs.opentitan.org/hw/ip/uart/doc/
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/char/ibex_uart.h"
> > +#include "hw/irq.h"
> > +#include "hw/qdev-properties.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +
> > +static void ibex_uart_update_irqs(IbexUartState *s)
> > +{
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_WATERMARK) {
> > +        qemu_set_irq(s->tx_watermark, 1);
> > +    } else {
> > +        qemu_set_irq(s->tx_watermark, 0);
> > +    }
> > +
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_WATERMARK) {
> > +        qemu_set_irq(s->rx_watermark, 1);
> > +    } else {
> > +        qemu_set_irq(s->rx_watermark, 0);
> > +    }
> > +
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_EMPTY) {
> > +        qemu_set_irq(s->tx_empty, 1);
> > +    } else {
> > +        qemu_set_irq(s->tx_empty, 0);
> > +    }
> > +
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_OVERFLOW) {
> > +        qemu_set_irq(s->rx_overflow, 1);
> > +    } else {
> > +        qemu_set_irq(s->rx_overflow, 0);
> > +    }
> > +}
> > +
> > +static int ibex_uart_can_receive(void *opaque)
> > +{
> > +    IbexUartState *s = opaque;
> > +
> > +    if (s->uart_ctrl & UART_CTRL_RX_ENABLE) {
> > +        return 1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void ibex_uart_receive(void *opaque, const uint8_t *buf, int size)
> > +{
> > +    IbexUartState *s = opaque;
> > +    uint8_t rx_fifo_level = (s->uart_fifo_ctrl & FIFO_CTRL_RXILVL)
> > +                            >> FIFO_CTRL_RXILVL_SHIFT;
> > +
> > +    s->uart_rdata = *buf;
> > +
> > +    s->uart_status &= ~UART_STATUS_RXIDLE;
> > +    s->uart_status &= ~UART_STATUS_RXEMPTY;
> > +
> > +    if (size > rx_fifo_level) {
> > +        s->uart_intr_state |= INTR_STATE_RX_WATERMARK;
> > +    }
> > +
> > +    ibex_uart_update_irqs(s);
> > +}
> > +
> > +static gboolean ibex_uart_xmit(GIOChannel *chan, GIOCondition cond,
> > +                               void *opaque)
> > +{
> > +    IbexUartState *s = opaque;
> > +    uint8_t tx_fifo_level = (s->uart_fifo_ctrl & FIFO_CTRL_TXILVL)
> > +                            >> FIFO_CTRL_TXILVL_SHIFT;
> > +    int ret;
> > +
> > +    /* instant drain the fifo when there's no back-end */
> > +    if (!qemu_chr_fe_backend_connected(&s->chr)) {
> > +        s->tx_level = 0;
> > +        return FALSE;
> > +    }
> > +
> > +    if (!s->tx_level) {
> > +        s->uart_status &= UART_STATUS_TXFULL;
> Maybe  s->uart_status &= ~UART_STATUS_TXFULL;

Good spot, fixed.

> > +        s->uart_status |= UART_STATUS_TXEMPTY;
> > +        s->uart_intr_state |= INTR_STATE_TX_EMPTY;
> > +        s->uart_intr_state &= ~INTR_STATE_TX_WATERMARK;
> > +        ibex_uart_update_irqs(s);
> > +        return FALSE;
> > +    }
> > +
> > +    ret = qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
> > +
> > +    if (ret >= 0) {
> > +        s->tx_level -= ret;
> > +        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
> > +    }
> > +
> > +    if (s->tx_level) {
> > +        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
> > +                                        ibex_uart_xmit, s);
> > +        if (!r) {
> > +            s->tx_level = 0;
> > +            return FALSE;
> > +        }
> > +    }
> > +
> > +    /* Clear the TX Full bit */
> > +    if (s->tx_level != IBEX_UART_TX_FIFO_SIZE) {
> > +        s->uart_status &= ~UART_STATUS_TXFULL;
> > +    }
> > +
> > +    /* Disable the TX_WATERMARK IRQ */
> > +    if (s->tx_level < tx_fifo_level) {
> > +        s->uart_intr_state &= ~INTR_STATE_TX_WATERMARK;
> > +    }
> > +
> > +    /* Set TX empty */
> > +    if (s->tx_level == 0) {
> > +        s->uart_status |= UART_STATUS_TXEMPTY;
> > +        s->uart_intr_state |= INTR_STATE_TX_EMPTY;
> > +    }
> > +
> > +    ibex_uart_update_irqs(s);
> > +    return FALSE;
> > +}
> > +
> > +static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
> > +                               int size)
> > +{
> > +    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    uint8_t tx_fifo_level = (s->uart_fifo_ctrl & FIFO_CTRL_TXILVL)
> > +                            >> FIFO_CTRL_TXILVL_SHIFT;
> > +
> > +    if (size > IBEX_UART_TX_FIFO_SIZE - s->tx_level) {
> > +        size = IBEX_UART_TX_FIFO_SIZE - s->tx_level;
> > +        qemu_log_mask(LOG_GUEST_ERROR, "ibex_uart: TX FIFO overflow");
> > +    }
> > +
> > +    memcpy(s->tx_fifo + s->tx_level, buf, size);
> > +    s->tx_level += size;
> > +
> > +    if (s->tx_level > 0) {
> > +        s->uart_status &= ~UART_STATUS_TXEMPTY;
> > +    }
> > +
> > +    if (s->tx_level >= tx_fifo_level) {
> > +        s->uart_intr_state |= INTR_STATE_TX_WATERMARK;
> > +        ibex_uart_update_irqs(s);
> > +    }
> > +
> > +    if (s->tx_level == IBEX_UART_TX_FIFO_SIZE) {
> > +        s->uart_status |= UART_STATUS_TXFULL;
> > +    }
> > +
> > +    timer_mod(s->fifo_trigger_handle, current_time +
> > +              (s->char_tx_time * 4));
> > +}
> > +
> > +static void ibex_uart_reset(DeviceState *dev)
> > +{
> > +    IbexUartState *s = IBEX_UART(dev);
> > +
> > +    s->uart_intr_state = 0x00000000;
> > +    s->uart_intr_state = 0x00000000;
> > +    s->uart_intr_enable = 0x00000000;
> > +    s->uart_ctrl = 0x00000000;
> > +    s->uart_status = 0x0000003c;
> > +    s->uart_rdata = 0x00000000;
> > +    s->uart_fifo_ctrl = 0x00000000;
> > +    s->uart_fifo_status = 0x00000000;
> > +    s->uart_ovrd = 0x00000000;
> > +    s->uart_val = 0x00000000;
> > +    s->uart_timeout_ctrl = 0x00000000;
> > +
> > +    s->tx_level = 0;
> > +
> > +    s->char_tx_time = (NANOSECONDS_PER_SECOND / 230400) * 10;
> > +
> > +    ibex_uart_update_irqs(s);
> > +}
> > +
> > +static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
> > +                                       unsigned int size)
> > +{
> > +    IbexUartState *s = opaque;
> > +    uint64_t retvalue = 0;
> > +
> > +    switch (addr) {
> > +    case IBEX_UART_INTR_STATE:
> > +        retvalue = s->uart_intr_state;
> > +        break;
> > +    case IBEX_UART_INTR_ENABLE:
> > +        retvalue = s->uart_intr_enable;
> > +        break;
> > +    case IBEX_UART_INTR_TEST:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: wdata is write only\n", __func__);
> > +        break;
> > +
> > +    case IBEX_UART_CTRL:
> > +        retvalue = s->uart_ctrl;
> > +        break;
> > +    case IBEX_UART_STATUS:
> > +        retvalue = s->uart_status;
> > +        break;
> > +
> > +    case IBEX_UART_RDATA:
> > +        retvalue = s->uart_rdata;
> > +        if (s->uart_ctrl & UART_CTRL_RX_ENABLE) {
> > +            qemu_chr_fe_accept_input(&s->chr);
> > +
> > +            s->uart_status |= UART_STATUS_RXIDLE;
> > +            s->uart_status |= UART_STATUS_RXEMPTY;
> > +        }
> > +        break;
> > +    case IBEX_UART_WDATA:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: wdata is write only\n", __func__);
> > +        break;
> > +
> > +    case IBEX_UART_FIFO_CTRL:
> > +        retvalue = s->uart_fifo_ctrl;
> > +        break;
> > +    case IBEX_UART_FIFO_STATUS:
> > +        retvalue = s->uart_fifo_status;
> > +
> > +        retvalue |= s->tx_level & 0x1F;
> > +
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: RX fifos are not supported\n", __func__);
> > +        break;
> > +
> > +    case IBEX_UART_OVRD:
> > +        retvalue = s->uart_ovrd;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: ovrd is not supported\n", __func__);
> > +        break;
> > +    case IBEX_UART_VAL:
> > +        retvalue = s->uart_val;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: val is not supported\n", __func__);
> > +        break;
> > +    case IBEX_UART_TIMEOUT_CTRL:
> > +        retvalue = s->uart_timeout_ctrl;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: timeout_ctrl is not supported\n", __func__);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> > +        return 0;
> > +    }
> > +
> > +    return retvalue;
> > +}
> > +
> > +static void ibex_uart_write(void *opaque, hwaddr addr,
> > +                                  uint64_t val64, unsigned int size)
> > +{
> > +    IbexUartState *s = opaque;
> > +    uint32_t value = val64;
> > +
> > +    switch (addr) {
> > +    case IBEX_UART_INTR_STATE:
> > +        /* Write 1 clear */
> > +        s->uart_intr_state &= ~value;
> > +        ibex_uart_update_irqs(s);
> > +        break;
> > +    case IBEX_UART_INTR_ENABLE:
> > +        s->uart_intr_enable = value;
> > +        ibex_uart_update_irqs(s);
> > +        break;
> > +    case IBEX_UART_INTR_TEST:
> > +        s->uart_intr_state |= value;
> > +        ibex_uart_update_irqs(s);
> > +        break;
> > +
> > +    case IBEX_UART_CTRL:
> > +        s->uart_ctrl = value;
> > +
> > +        if (value & UART_CTRL_NF) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_NF is not supported\n", __func__);
> > +        }
> > +        if (value & UART_CTRL_SLPBK) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_SLPBK is not supported\n", __func__);
> > +        }
> > +        if (value & UART_CTRL_LLPBK) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_LLPBK is not supported\n", __func__);
> > +        }
> > +        if (value & UART_CTRL_PARITY_EN) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_PARITY_EN is not supported\n",
> > +                          __func__);
> > +        }
> > +        if (value & UART_CTRL_PARITY_ODD) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_PARITY_ODD is not supported\n",
> > +                          __func__);
> > +        }
> > +        if (value & UART_CTRL_RXBLVL) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: UART_CTRL_RXBLVL is not supported\n", __func__);
> > +        }
> > +        if (value & UART_CTRL_NCO) {
> > +            uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
> > +            baud *= 1000;
> > +            baud /= 2 ^ 20;
> > +
> > +            s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
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
> > +        s->uart_fifo_ctrl = value;
> > +
> > +        if (value & FIFO_CTRL_RXRST) {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "%s: RX fifos are not supported\n", __func__);
> > +        }
> > +        if (value & FIFO_CTRL_TXRST) {
> > +            s->tx_level = 0;
> > +        }
> > +        break;
> > +    case IBEX_UART_FIFO_STATUS:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: fifo_status is read only\n", __func__);
> > +        break;
> > +
> > +    case IBEX_UART_OVRD:
> > +        s->uart_ovrd = value;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: ovrd is not supported\n", __func__);
> > +        break;
> > +    case IBEX_UART_VAL:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: val is read only\n", __func__);
> > +        break;
> > +    case IBEX_UART_TIMEOUT_CTRL:
> > +        s->uart_timeout_ctrl = value;
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "%s: timeout_ctrl is not supported\n", __func__);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
> > +    }
> > +}
> > +
> > +static void fifo_trigger_update(void *opaque)
> > +{
> > +    IbexUartState *s = opaque;
> > +
> > +    if (s->uart_ctrl & UART_CTRL_TX_ENABLE) {
> > +        ibex_uart_xmit(NULL, G_IO_OUT, s);
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps ibex_uart_ops = {
> > +    .read = ibex_uart_read,
> > +    .write = ibex_uart_write,
> > +    .endianness = DEVICE_NATIVE_ENDIAN,
> > +    .impl.min_access_size = 4,
> > +    .impl.max_access_size = 4,
> > +};
> > +
> > +static int cadence_uart_post_load(void *opaque, int version_id)
> Not a good name.

Also fixed.

Alistair

> > +{
> > +    IbexUartState *s = opaque;
> > +
> > +    ibex_uart_update_irqs(s);
> > +    return 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_ibex_uart = {
> > +    .name = TYPE_IBEX_UART,
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .post_load = cadence_uart_post_load,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT8_ARRAY(tx_fifo, IbexUartState,
> > +                            IBEX_UART_TX_FIFO_SIZE),
> > +        VMSTATE_UINT32(tx_level, IbexUartState),
> > +        VMSTATE_UINT64(char_tx_time, IbexUartState),
> > +        VMSTATE_TIMER_PTR(fifo_trigger_handle, IbexUartState),
> > +        VMSTATE_UINT32(uart_intr_state, IbexUartState),
> > +        VMSTATE_UINT32(uart_intr_enable, IbexUartState),
> > +        VMSTATE_UINT32(uart_ctrl, IbexUartState),
> > +        VMSTATE_UINT32(uart_status, IbexUartState),
> > +        VMSTATE_UINT32(uart_rdata, IbexUartState),
> > +        VMSTATE_UINT32(uart_fifo_ctrl, IbexUartState),
> > +        VMSTATE_UINT32(uart_fifo_status, IbexUartState),
> > +        VMSTATE_UINT32(uart_ovrd, IbexUartState),
> > +        VMSTATE_UINT32(uart_val, IbexUartState),
> > +        VMSTATE_UINT32(uart_timeout_ctrl, IbexUartState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static Property ibex_uart_properties[] = {
> > +    DEFINE_PROP_CHR("chardev", IbexUartState, chr),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void ibex_uart_init(Object *obj)
> > +{
> > +    IbexUartState *s = IBEX_UART(obj);
> > +
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
> > +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
> > +
> > +    memory_region_init_io(&s->mmio, obj, &ibex_uart_ops, s,
> > +                          TYPE_IBEX_UART, 0x400);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static void ibex_uart_realize(DeviceState *dev, Error **errp)
> > +{
> > +    IbexUartState *s = IBEX_UART(dev);
> > +
> > +    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                          fifo_trigger_update, s);
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, ibex_uart_can_receive,
> > +                             ibex_uart_receive, NULL, NULL,
> > +                             s, NULL, true);
> > +}
> > +
> > +static void ibex_uart_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->reset = ibex_uart_reset;
> > +    dc->realize = ibex_uart_realize;
> > +    dc->vmsd = &vmstate_ibex_uart;
> > +    device_class_set_props(dc, ibex_uart_properties);
> > +}
> > +
> > +static const TypeInfo ibex_uart_info = {
> > +    .name          = TYPE_IBEX_UART,
> > +    .parent        = TYPE_SYS_BUS_DEVICE,
> > +    .instance_size = sizeof(IbexUartState),
> > +    .instance_init = ibex_uart_init,
> > +    .class_init    = ibex_uart_class_init,
> > +};
> > +
> > +static void ibex_uart_register_types(void)
> > +{
> > +    type_register_static(&ibex_uart_info);
> > +}
> > +
> > +type_init(ibex_uart_register_types)
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e7d9cb0a5..a1ce186a7e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1245,7 +1245,9 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
> >   L: qemu-riscv@nongnu.org
> >   S: Supported
> >   F: hw/riscv/opentitan.c
> > +F: hw/char/ibex_uart.c
> >   F: include/hw/riscv/opentitan.h
> > +F: include/hw/char/ibex_uart.h
> >
> >   SH4 Machines
> >   ------------
> > diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> > index 9e9a6c1aff..633996be5b 100644
> > --- a/hw/char/Makefile.objs
> > +++ b/hw/char/Makefile.objs
> > @@ -12,6 +12,7 @@ common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
> >   common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
> >   common-obj-$(CONFIG_XEN) += xen_console.o
> >   common-obj-$(CONFIG_CADENCE) += cadence_uart.o
> > +common-obj-$(CONFIG_IBEX) += ibex_uart.o
> >
> >   common-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
> >   common-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 94d19571f7..28947ef3e0 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -4,6 +4,9 @@ config HTIF
> >   config HART
> >       bool
> >
> > +config IBEX
> > +    bool
> > +
> >   config SIFIVE
> >       bool
> >       select MSI_NONBROKEN
> > @@ -29,6 +32,7 @@ config SPIKE
> >
> >   config OPENTITAN
> >       bool
> > +    select IBEX
> >       select HART
> >       select UNIMP
> >
>
>

