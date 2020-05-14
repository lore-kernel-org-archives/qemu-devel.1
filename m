Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E9BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 22:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD1A2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 22:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep02vZlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZME7-0005hU-DE
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 18:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZM1O-0005ON-SL; Thu, 14 May 2020 18:08:06 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:37817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZM1N-0003md-Qh; Thu, 14 May 2020 18:08:06 -0400
Received: by mail-il1-x142.google.com with SMTP id n11so459715ilj.4;
 Thu, 14 May 2020 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iZeAqpbW47Gesb2jwakRkz0J2mHYBvwMNg2UWjEe/oU=;
 b=ep02vZlRADUkzoBno4CmhJhLqmSITM7v7eQq6s/I2O8pMwZ1mp/7K3zd/JwHIJvtHr
 Ur3Q8mMl4H+AJWklZYXQHrBvXeJK+WShAj3RCs3oMYZxOHT1ZHrMll5Yp52qmmUSTB0l
 zZeIrr3sGWzvAygT6l+pHZ557tuALYbQXDSGVMfkYdAhfmAXIA6FKQDRzJs/KVgCfLjO
 x2CmILYvfb/byEPqRaQtlreARrN8bk0U/foqj/t4vdqTgmBkRs0tUdnOblR/QezkjSCu
 lXNVoMAgm5DZ6lTdbqmmNbYZ5R4SsZx5cX/PIufjRbG0zKaKFozzygGBCbTqNW1cMgcb
 2+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iZeAqpbW47Gesb2jwakRkz0J2mHYBvwMNg2UWjEe/oU=;
 b=O7TexjW09gF0nok45B+WFz9asEVh/+TVr/dDUveGoO6xDJeWE4l+/R26nf5sNWSDI+
 EJNu742nxj+BHXWAKdG2FeS/dYc68KSHPlMv2Q8TFoWxozw0v6v1bWYPX/bwxxhGahex
 V8yh3LfYwljxDh3wMyYMChBIuBFk6AWmn80JDGZBx3VCieGUoRr7yG4zjufn8oYvm9h+
 ++V03BE6GZ4auupA/BEQNv2QXm6uZPNOeuGY8OqU21cijldQSWG5jUd+6qn7CbvERbZt
 4BkR+hb9aIT9+7SnIy3QcPa5IhckqStCY9e0eXwDj9VJD9rHWX0avWkKdiBj+nh0NZQl
 KcaA==
X-Gm-Message-State: AOAM533CvmbbSgI7b4C/uene0ynu/5lpLhjFM2VVwiSxkVCHry/ll66k
 meeEF+prDof3BZOJItB1oOfjRrdCaO364shrAqI=
X-Google-Smtp-Source: ABdhPJzFfbmPTzpoKPeyztB+cRThAcoe0mz/JGSOnBjuPrq8kE1kSe9yY3uabnklpv66RzwAotNG+lmPOGQJQE69gYg=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr340672ila.227.1589494084046;
 Thu, 14 May 2020 15:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <11b8f3cd28fd52b10caefe21a7b70444b85792f8.1588878756.git.alistair.francis@wdc.com>
 <44285916-1542-5ba3-eb39-48f9728c1e8d@redhat.com>
In-Reply-To: <44285916-1542-5ba3-eb39-48f9728c1e8d@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 May 2020 14:59:16 -0700
Message-ID: <CAKmqyKPuv=jFOfO-Vgub1x1ddoLkmkZTgd2ZbSxNKMv7ySMBFQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] hw/char: Initial commit of Ibex UART
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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

On Thu, May 14, 2020 at 11:00 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Alistair,
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
> >   5 files changed, 607 insertions(+)
> >   create mode 100644 hw/char/ibex_uart.c
> >   create mode 100644 include/hw/char/ibex_uart.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c3d77f0861..d3d47564ce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1236,7 +1236,9 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
> >   L: qemu-riscv@nongnu.org
> >   S: Supported
> >   F: hw/riscv/opentitan.c
> > +F: hw/char/ibex_uart.c
> >   F: include/hw/riscv/opentitan.h
> > +F: include/hw/char/ibex_uart.h
> >
> >
> >   SH4 Machines
> > diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> > index 9e9a6c1aff..633996be5b 100644
> > --- a/hw/char/Makefile.objs
> > +++ b/hw/char/Makefile.objs
> > @@ -12,6 +12,7 @@ common-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-consol=
e.o
> >   common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
> >   common-obj-$(CONFIG_XEN) +=3D xen_console.o
> >   common-obj-$(CONFIG_CADENCE) +=3D cadence_uart.o
> > +common-obj-$(CONFIG_IBEX) +=3D ibex_uart.o
> >
> >   common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_uart.o
> >   common-obj-$(CONFIG_COLDFIRE) +=3D mcf_uart.o
> > diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> > new file mode 100644
> > index 0000000000..f6215ae23d
> > --- /dev/null
> > +++ b/hw/char/ibex_uart.c
> > @@ -0,0 +1,490 @@
> > +/*
> > + * QEMU lowRISC Ibex UART device
> > + *
> > + * Copyright (c) 2020 Western Digital
> > + *
> > + * For details check the documentation here:
> > + *    https://docs.opentitan.org/hw/ip/uart/doc/
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
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_WATER=
MARK) {
> > +        qemu_set_irq(s->tx_watermark, 1);
> > +    } else {
> > +        qemu_set_irq(s->tx_watermark, 0);
> > +    }
> > +
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_WATER=
MARK) {
> > +        qemu_set_irq(s->rx_watermark, 1);
> > +    } else {
> > +        qemu_set_irq(s->rx_watermark, 0);
>
> I wonder if having both bit separate can't lead to odd pulse behavior
> (this function should have the same result if you invert the RX/TX
> processing here). I'd be safer using a local 'raise_watermark' boolean
> variable, then call qemu_set_irq() once.

I'm not sure what you mean. Are you worried that TX and RX will both
go high/low at the same time?

Alistair

>
> > +    }
> > +
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_EMPTY=
) {
> > +        qemu_set_irq(s->tx_empty, 1);
> > +    } else {
> > +        qemu_set_irq(s->tx_empty, 0);
> > +    }
> > +
> > +    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_OVERF=
LOW) {
> > +        qemu_set_irq(s->rx_overflow, 1);
> > +    } else {
> > +        qemu_set_irq(s->rx_overflow, 0);
> > +    }
> > +}
> [...]
>

