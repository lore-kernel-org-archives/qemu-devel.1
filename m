Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32861C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B462081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPpsAV5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B462081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaTT-0002zN-61
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:51:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaRv-00027W-AM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaRt-0002co-D1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:50:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaRt-0002bT-1c
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:50:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id c12so8469023wrt.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=c0atO9NOAbhT7Kz5SKZmhwdYpZVmrxVdlv3MRjJtSV4=;
	b=fPpsAV5JaiNpNL+B1OwegNGijDle+g+7IGxPinGDPgRAUnSiqVoNwTx0dOofKAg7B3
	4eBJvubBfTp9MojaHzl6/wU7OT6bFY3jxHQKxw3/Alw517MXnFw5rwmqPmtmE1PAXfpm
	Icb0Ux+xns2wIiu/TFK+2qqYQ1xEwiWZMx6i4orpJHWOlLf9b3SuzIb9RxBA4IaJR7Gt
	oO4DJsqGV2HJXvdGTdNhtLKB/mynibWcOTjlNmXeTY0yozyZrGsJNojKAvS0oD3xy++q
	4spOp3Q96YAbiH8+xKb0OSGpE/+DbkJhvhM6jXz3/Uoh5bFhHZSHTqusl/EtXJVLoxSh
	h3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=c0atO9NOAbhT7Kz5SKZmhwdYpZVmrxVdlv3MRjJtSV4=;
	b=YLIW45xlVWWVauS2XtltB0QUsSYvkrY6bKt6VqxutmT3J78dhQKygdvwiCFG0KAJwH
	U4oGyVfqQVmxBrLBh7NkXR+Hw2VZYn+7JygMBmyAl0ekxrpzl9MiqOP005zNnIBvdyqV
	H/kHQW6uIKrBO0VxH49abQ0FwClErQPG5DZ32jEvFGRqjUorLR4UxWnhBKi5+dUVzmVn
	fJJdbHi5MCLGPomNg9RTs3/8YnIRuPP1Pnzgrk27m+vW6K+t+KJheFqXWYxPlTjE4k3X
	Ns7UTr981rf/zEOxoI2THqKjLHIukVKG1i1n0u9Hp0kdf59jqVqEnNfVSBxt+7QkOymr
	WWYg==
X-Gm-Message-State: APjAAAXEvmuEgR4qxyKiNwi2wiA/5afm6u2zmxccGuhdawq3PYXVE55x
	cvnTiK+MOUbazrjncUGjAdujIQ==
X-Google-Smtp-Source: APXvYqxActcP4iXrTGLioKVlkVB1BVXjrHm1AJa3lX1yNf/txWL6SarvGJjC58Lt/MGD9HxMbF5Vog==
X-Received: by 2002:adf:f2c9:: with SMTP id d9mr7760995wrp.36.1556898605897;
	Fri, 03 May 2019 08:50:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id k1sm1690144wmi.48.2019.05.03.08.50.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 08:50:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 906491FF87;
	Fri,  3 May 2019 16:50:04 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-7-ysato@users.sourceforge.jp>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190502143409.59600-7-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:50:04 +0100
Message-ID: <87imur4jwz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH RFC v8 06/12] hw/intc: RX62N interrupt
 controller (ICUa)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503155004.3OOmu4ngiElCtO-Iln1VfA5kXR21GFl0TrHty7qlFnU@z>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> This implementation supported only ICUa.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/intc/rx_icu.h |  49 +++++++
>  hw/intc/rx_icu.c         | 373 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/intc/Makefile.objs    |   1 +
>  3 files changed, 423 insertions(+)
>  create mode 100644 include/hw/intc/rx_icu.h
>  create mode 100644 hw/intc/rx_icu.c
>
> diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
> new file mode 100644
> index 0000000000..bc46b3079b
> --- /dev/null
> +++ b/include/hw/intc/rx_icu.h
> @@ -0,0 +1,49 @@
> +#ifndef RX_ICU_H
> +#define RX_ICU_H
> +
> +#include "qemu-common.h"
> +#include "hw/irq.h"
> +
> +struct IRQSource {
> +    int sense;
> +    int level;
> +};
> +
> +struct RXICUState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion memory;
> +    struct IRQSource src[256];
> +    char *icutype;
> +    uint32_t nr_irqs;
> +    uint32_t *map;
> +    uint32_t nr_sense;
> +    uint32_t *init_sense;
> +
> +    uint8_t ir[256];
> +    uint8_t dtcer[256];
> +    uint8_t ier[32];
> +    uint8_t ipr[142];
> +    uint8_t dmasr[4];
> +    uint16_t fir;
> +    uint8_t nmisr;
> +    uint8_t nmier;
> +    uint8_t nmiclr;
> +    uint8_t nmicr;
> +    int req_irq;
> +    qemu_irq _irq;
> +    qemu_irq _fir;
> +    qemu_irq _swi;
> +};
> +typedef struct RXICUState RXICUState;
> +
> +#define TYPE_RXICU "rxicu"
> +#define RXICU(obj) OBJECT_CHECK(RXICUState, (obj), TYPE_RXICU)
> +
> +#define SWI 27
> +#define TRG_LEVEL 0
> +#define TRG_NEDGE 1
> +#define TRG_PEDGE 2
> +#define TRG_BEDGE 3
> +
> +#endif /* RX_ICU_H */
> diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
> new file mode 100644
> index 0000000000..7c7336960d
> --- /dev/null
> +++ b/hw/intc/rx_icu.c
> @@ -0,0 +1,373 @@
> +/*
> + * RX Interrupt control unit
> + *
> + * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
> + * (Rev.1.40 R01UH0033EJ0140)
> + *
> + * Copyright (c) 2019 Yoshinori Sato
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/registerfields.h"
> +#include "hw/intc/rx_icu.h"
> +#include "qemu/error-report.h"
> +
> +REG8(IR, 0)
> +  FIELD(IR, IR,  0, 1)
> +REG8(DTCER, 0x100)
> +  FIELD(DTCER, DTCE,  0, 1)
> +REG8(IER, 0x200)
> +REG8(SWINTR, 0x2e0)
> +  FIELD(SWINTR, SWINT, 0, 1)
> +REG16(FIR, 0x2f0)
> +  FIELD(FIR, FVCT, 0, 8)
> +  FIELD(FIR, FIEN, 15, 1)
> +REG8(IPR, 0x300)
> +  FIELD(IPR, IPR, 0, 4)
> +REG8(DMRSR, 0x400)
> +REG8(IRQCR, 0x500)
> +  FIELD(IRQCR, IRQMD, 2, 2)
> +REG8(NMISR, 0x580)
> +  FIELD(NMISR, NMIST, 0, 1)
> +  FIELD(NMISR, LVDST, 1, 1)
> +  FIELD(NMISR, OSTST, 2, 1)
> +REG8(NMIER, 0x581)
> +  FIELD(NMIER, NMIEN, 0, 1)
> +  FIELD(NMIER, LVDEN, 1, 1)
> +  FIELD(NMIER, OSTEN, 2, 1)
> +REG8(NMICLR, 0x582)
> +  FIELD(NMICLR, NMICLR, 0, 1)
> +  FIELD(NMICLR, OSTCLR, 2, 1)
> +REG8(NMICR, 0x583)
> +  FIELD(NMICR, NMIMD, 3, 1)
> +
> +#define request(icu, n) (icu->ipr[icu->map[n]] << 8 | n)
> +
> +static qemu_irq *rxicu_pin(RXICUState *icu, int n_IRQ)
> +{
> +    if ((icu->fir & R_FIR_FIEN_MASK) &&
> +        (icu->fir & R_FIR_FVCT_MASK) =3D=3D n_IRQ) {
> +        return &icu->_fir;
> +    } else {
> +        return &icu->_irq;
> +    }
> +}
> +
> +static void rxicu_request(RXICUState *icu, int n_IRQ)
> +{
> +    int enable;
> +
> +    enable =3D icu->ier[n_IRQ / 8] & (1 << (n_IRQ & 7));
> +    if (n_IRQ > 0 && enable !=3D 0 && atomic_read(&icu->req_irq) < 0) {
> +        atomic_set(&icu->req_irq, n_IRQ);
> +        qemu_set_irq(*rxicu_pin(icu, n_IRQ), request(icu, n_IRQ));
> +    }
> +}
> +
> +static void rxicu_set_irq(void *opaque, int n_IRQ, int level)
> +{
> +    RXICUState *icu =3D opaque;
> +    struct IRQSource *src;
> +    int issue;
> +
> +    if (n_IRQ >=3D 256) {
> +        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
> +        return;
> +    }
> +
> +    src =3D &icu->src[n_IRQ];
> +
> +    level =3D (level !=3D 0);
> +    switch (src->sense) {
> +    case TRG_LEVEL:
> +        /* level-sensitive irq */
> +        issue =3D level;
> +        src->level =3D level;
> +        break;
> +    case TRG_NEDGE:
> +        issue =3D (level =3D=3D 0 && src->level =3D=3D 1);
> +        src->level =3D level;
> +        break;
> +    case TRG_PEDGE:
> +        issue =3D (level =3D=3D 1 && src->level =3D=3D 0);
> +        src->level =3D level;
> +        break;
> +    case TRG_BEDGE:
> +        issue =3D ((level ^ src->level) & 1);
> +        src->level =3D level;
> +        break;
> +    }

You need a default leg here to either set issue or g_assert_not_reached();

> +    if (issue =3D=3D 0 && src->sense =3D=3D TRG_LEVEL) {
> +        icu->ir[n_IRQ] =3D 0;
> +        if (atomic_read(&icu->req_irq) =3D=3D n_IRQ) {
> +            /* clear request */
> +            qemu_set_irq(*rxicu_pin(icu, n_IRQ), 0);
> +            atomic_set(&icu->req_irq, -1);
> +        }
> +        return;
> +    }
> +    if (issue) {
> +        icu->ir[n_IRQ] =3D 1;
> +        rxicu_request(icu, n_IRQ);
> +    }
> +}
> +
> +static void rxicu_ack_irq(void *opaque, int no, int level)
> +{
> +    RXICUState *icu =3D opaque;
> +    int i;
> +    int n_IRQ;
> +    int max_pri;
> +
> +    n_IRQ =3D atomic_read(&icu->req_irq);
> +    if (n_IRQ < 0) {
> +        return;
> +    }
> +    atomic_set(&icu->req_irq, -1);
> +    if (icu->src[n_IRQ].sense !=3D TRG_LEVEL) {
> +        icu->ir[n_IRQ] =3D 0;
> +    }
> +
> +    max_pri =3D 0;
> +    n_IRQ =3D -1;
> +    for (i =3D 0; i < 256; i++) {
> +        if (icu->ir[i]) {
> +            if (max_pri < icu->ipr[icu->map[i]]) {
> +                n_IRQ =3D i;
> +                max_pri =3D icu->ipr[icu->map[i]];
> +            }
> +        }
> +    }
> +
> +    if (n_IRQ >=3D 0) {
> +        rxicu_request(icu, n_IRQ);
> +    }
> +}
> +
> +static uint64_t icu_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    hwaddr offset =3D addr & 0xfff;
> +    RXICUState *icu =3D opaque;
> +    int reg =3D addr & 0xff;
> +
> +    if ((offset !=3D A_FIR && size !=3D 1) ||
> +        (offset =3D=3D A_FIR && size !=3D 2)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "rx_icu: Invalid read size %08lx.\n", offset);
> +        return 0xffffffffffffffffULL;
> +    }
> +    switch (offset) {
> +    case A_IR ... A_IR + 0xff:
> +        return icu->ir[reg] & R_IR_IR_MASK;
> +    case A_DTCER ... A_DTCER + 0xff:
> +        return icu->dtcer[reg] & R_DTCER_DTCE_MASK;
> +    case A_IER ... A_IER + 0x1f:
> +        return icu->ier[reg];
> +    case A_SWINTR:
> +        return 0;
> +    case A_FIR:
> +        return icu->fir & (R_FIR_FIEN_MASK | R_FIR_FVCT_MASK);
> +    case A_IPR ... A_IPR + 0x8f:
> +        return icu->ipr[reg] & R_IPR_IPR_MASK;
> +    case A_DMRSR:
> +    case A_DMRSR + 4:
> +    case A_DMRSR + 8:
> +    case A_DMRSR + 12:
> +        return icu->dmasr[reg >> 2];
> +    case A_IRQCR ... A_IRQCR + 0x1f:
> +        return icu->src[64 + reg].sense << R_IRQCR_IRQMD_SHIFT;
> +    case A_NMISR:
> +    case A_NMICLR:
> +        return 0;
> +    case A_NMIER:
> +        return icu->nmier;
> +    case A_NMICR:
> +        return icu->nmicr;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "rx_icu: Register %08lx not implemented\n", offset=
);
> +        break;
> +    }
> +    return 0xffffffffffffffffULL;
> +}
> +
> +static void icu_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
> +{
> +    hwaddr offset =3D addr & 0xfff;
> +    RXICUState *icu =3D opaque;
> +    int reg =3D addr & 0xff;
> +
> +    if ((offset !=3D A_FIR && size !=3D 1) ||
> +        (offset =3D=3D A_FIR && size !=3D 2)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "rx_icu: Invalid write size at %08lx.\n", offset);
> +        return;
> +    }
> +    switch (offset) {
> +    case A_IR ... A_IR + 0xff:
> +        if (icu->src[reg].sense !=3D TRG_LEVEL && val =3D=3D 0) {
> +            icu->ir[reg] =3D 0;
> +        }
> +        break;
> +    case A_DTCER ... A_DTCER + 0xff:
> +        icu->dtcer[reg] =3D val & R_DTCER_DTCE_MASK;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "rx_icu: DTC not implemented\n");
> +        break;
> +    case A_IER ... A_IER + 0x1f:
> +        icu->ier[reg] =3D val;
> +        break;
> +    case A_SWINTR:
> +        if (val & R_SWINTR_SWINT_MASK) {
> +            qemu_irq_pulse(icu->_swi);
> +        }
> +        break;
> +    case A_FIR:
> +        icu->fir =3D val & (R_FIR_FIEN_MASK | R_FIR_FVCT_MASK);
> +        break;
> +    case A_IPR ... A_IPR + 0x8f:
> +        icu->ipr[reg] =3D val & R_IPR_IPR_MASK;
> +        break;
> +    case A_DMRSR:
> +    case A_DMRSR + 4:
> +    case A_DMRSR + 8:
> +    case A_DMRSR + 12:
> +        icu->dmasr[reg >> 2] =3D val;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "rx_icu: DMAC not implemented\n");
> +        break;
> +    case A_IRQCR ... A_IRQCR + 0x1f:
> +        icu->src[64 + reg].sense =3D val >> R_IRQCR_IRQMD_SHIFT;
> +        break;
> +    case A_NMICLR:
> +        break;
> +    case A_NMIER:
> +        icu->nmier |=3D val & (R_NMIER_NMIEN_MASK |
> +                             R_NMIER_LVDEN_MASK |
> +                             R_NMIER_OSTEN_MASK);
> +            break;
> +    case A_NMICR:
> +        if ((icu->nmier & R_NMIER_NMIEN_MASK) =3D=3D 0) {
> +            icu->nmicr =3D val & R_NMICR_NMIMD_MASK;
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "rx_icu: Register %08lx not implemented\n", offset=
);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps icu_ops =3D {
> +    .write =3D icu_write,
> +    .read  =3D icu_read,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .max_access_size =3D 2,
> +    },
> +};
> +
> +static void rxicu_realize(DeviceState *dev, Error **errp)
> +{
> +    RXICUState *icu =3D RXICU(dev);
> +    int i, j;
> +
> +    if (icu->init_sense =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "rx_icu: trigger-level property must be set.");
> +        return;
> +    }
> +    for (i =3D j =3D 0; i < 256; i++) {
> +        if (icu->init_sense[j] =3D=3D i) {
> +            icu->src[i].sense =3D TRG_LEVEL;
> +            if (j < icu->nr_sense) {
> +                j++;
> +            }
> +        } else
> +            icu->src[i].sense =3D TRG_PEDGE;
> +    }
> +    icu->req_irq =3D -1;
> +}
> +
> +static void rxicu_init(Object *obj)
> +{
> +    SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
> +    RXICUState *icu =3D RXICU(obj);
> +
> +    memory_region_init_io(&icu->memory, OBJECT(icu), &icu_ops,
> +                          icu, "rx-icu", 0x600);
> +    sysbus_init_mmio(d, &icu->memory);
> +
> +    qdev_init_gpio_in(DEVICE(d), rxicu_set_irq, 256);
> +    qdev_init_gpio_in_named(DEVICE(d), rxicu_ack_irq, "ack", 1);
> +    sysbus_init_irq(d, &icu->_irq);
> +    sysbus_init_irq(d, &icu->_fir);
> +    sysbus_init_irq(d, &icu->_swi);
> +}
> +
> +static void rxicu_fini(Object *obj)
> +{
> +    RXICUState *icu =3D RXICU(obj);
> +    g_free(icu->map);
> +    g_free(icu->init_sense);
> +}
> +
> +static const VMStateDescription vmstate_rxicu =3D {
> +    .name =3D "rx-icu",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property rxicu_properties[] =3D {
> +    DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
> +                      qdev_prop_uint32, uint32_t),
> +    DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
> +                      qdev_prop_uint32, uint32_t),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rxicu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D rxicu_realize;
> +    dc->props =3D rxicu_properties;
> +    dc->vmsd =3D &vmstate_rxicu;
> +}
> +
> +static const TypeInfo rxicu_info =3D {
> +    .name       =3D TYPE_RXICU,
> +    .parent     =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RXICUState),
> +    .instance_init =3D rxicu_init,
> +    .instance_finalize =3D rxicu_fini,
> +    .class_init =3D rxicu_class_init,
> +};
> +
> +static void rxicu_register_types(void)
> +{
> +    type_register_static(&rxicu_info);
> +}
> +
> +type_init(rxicu_register_types)
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index df712c3e6c..b54b09b12e 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -48,3 +48,4 @@ obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_cpuif.o
>  obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o
>  obj-$(CONFIG_NIOS2) +=3D nios2_iic.o
>  obj-$(CONFIG_OMPIC) +=3D ompic.o
> +obj-$(CONFIG_RX) +=3D rx_icu.o


--
Alex Benn=C3=A9e

