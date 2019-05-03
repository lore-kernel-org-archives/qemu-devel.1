Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D048C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3371C2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g1fBUTKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3371C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42181 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMa2Q-0005rZ-Ku
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:23:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMa1R-0005HR-1X
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMa1P-0002ZE-82
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:22:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMa1O-0002YY-Vj
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:22:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id c5so8339954wrs.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=nFNkW1Gl3qAkrD1bJiRqinsfbJyMxUBYb80L7QhGeAk=;
	b=g1fBUTKO5GIMXAogYABjlEPvX81Jok0NBW6/FnwHIuSrdVHo1tJa46WnhaMjPyD62G
	lpEW7ui+Dnxd1HyQuvvPo55vNhT/FpmpS5El7sDHDRLfbkoweB+vTgWf0EBPYK9HgFfR
	btG3J2KzeQXbcjdM51zRhrIhcO8kehW52mkWv7GLz7Ltg1S8+HBjlBfeNUPf0hB8f8/U
	v0nXOeJk2l39CAbPE6j6LdYOm5QuKrTZGG8U6JS9a+bjOJQoStxPFqHVrsnnLrYYbVMF
	DZjR7fqQl76rzdheUu1cGElqEtXW7RlfH8F2Q34qaEb56MgQWrGCbFfOYtPMU8V26/DT
	xpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=nFNkW1Gl3qAkrD1bJiRqinsfbJyMxUBYb80L7QhGeAk=;
	b=iLNWFtjIgY6xhCvxALjsYEL1jP+n190mh4VhUOWTKQta+CtosEap/4rkm2QIkU3gkW
	zWYTbQJUdQqQy54LdxcbqoUiS62TuZFnMoln6xJytFQidpQM0jSOJuOPwM9+1pVnvb0g
	aF4NehYQ/uM/ZBrblnZknhvO16jIemZWY+8B+fcoYdiIsZKCXiY3uF2BAfo0Yh60gIIz
	0F1rXGGfuP87exkIHEwGcNovqtsLQWC8yEdxTf9d8fbXo5MOwvpVgGL2NNBQeSbkeWRM
	/DOFoE01bcik7BluLgThv+G88DvqPNiug4RLKJjQBVnyw2JDOFkKGdfdLwqOS2MqnewP
	768A==
X-Gm-Message-State: APjAAAV8m4m9KkgI0Yph7jS0xCi2O5T53RAPlOdEwX0eJml7KCe3/Gfc
	R6BPh9y7mfkU4/H1BXcimT8gSQ==
X-Google-Smtp-Source: APXvYqxkVMOrs8TR3uN8uUNkdMDaTnlczscukLPDEdgq+d9NnVska4XGyrRwzNlF0pRLgLYELVv1sQ==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr7076934wri.220.1556896965353; 
	Fri, 03 May 2019 08:22:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z7sm3296621wme.26.2019.05.03.08.22.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 08:22:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 53B191FF87;
	Fri,  3 May 2019 16:22:44 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-9-ysato@users.sourceforge.jp>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190502143409.59600-9-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:22:44 +0100
Message-ID: <87o94j4l6j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH RFC v8 08/12] hw/char: RX62N serical
 communication interface (SCI)
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
Message-ID: <20190503152244.gNv-7JA0xg7Ohr5_xMtacKP_CHXOMkiOvI2g5d06cF8@z>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:


nit: typo in subject (serical->serial)

> This module supported only non FIFO type.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033=
ej0140_rx62n.pdf
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/char/renesas_sci.h |  45 ++++++
>  hw/char/renesas_sci.c         | 341 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/char/Kconfig               |   3 +
>  hw/char/Makefile.objs         |   2 +-
>  4 files changed, 390 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/char/renesas_sci.h
>  create mode 100644 hw/char/renesas_sci.c
>
> diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
> new file mode 100644
> index 0000000000..50d1336944
> --- /dev/null
> +++ b/include/hw/char/renesas_sci.h
> @@ -0,0 +1,45 @@
> +/*
> + * Renesas Serial Communication Interface
> + *
> + * Copyright (c) 2018 Yoshinori Sato
> + *
> + * This code is licensed under the GPL version 2 or later.
> + *
> + */
> +
> +#include "chardev/char-fe.h"
> +#include "qemu/timer.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_RENESAS_SCI "renesas-sci"
> +#define RSCI(obj) OBJECT_CHECK(RSCIState, (obj), TYPE_RENESAS_SCI)
> +
> +enum {
> +    ERI =3D 0,
> +    RXI =3D 1,
> +    TXI =3D 2,
> +    TEI =3D 3,
> +    SCI_NR_IRQ =3D 4,
> +};
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion memory;
> +
> +    uint8_t smr;
> +    uint8_t brr;
> +    uint8_t scr;
> +    uint8_t tdr;
> +    uint8_t ssr;
> +    uint8_t rdr;
> +    uint8_t scmr;
> +    uint8_t semr;
> +
> +    uint8_t read_ssr;
> +    int64_t trtime;
> +    int64_t rx_next;
> +    QEMUTimer *timer;
> +    CharBackend chr;
> +    uint64_t input_freq;
> +    qemu_irq irq[SCI_NR_IRQ];
> +} RSCIState;
> diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
> new file mode 100644
> index 0000000000..719fa2f938
> --- /dev/null
> +++ b/hw/char/renesas_sci.c
> @@ -0,0 +1,341 @@
> +/*
> + * Renesas Serial Communication Interface
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
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/registerfields.h"
> +#include "hw/char/renesas_sci.h"
> +#include "qemu/error-report.h"
> +
> +/* SCI register map */
> +REG8(SMR, 0)
> +  FIELD(SMR, CKS,  0, 2)
> +  FIELD(SMR, MP,   2, 1)
> +  FIELD(SMR, STOP, 3, 1)
> +  FIELD(SMR, PM,   4, 1)
> +  FIELD(SMR, PE,   5, 1)
> +  FIELD(SMR, CHR,  6, 1)
> +  FIELD(SMR, CM,   7, 1)
> +REG8(BRR, 1)
> +REG8(SCR, 2)
> +  FIELD(SCR, CKE, 0, 2)
> +  FIELD(SCR, TEIE, 2, 1)
> +  FIELD(SCR, MPIE, 3, 1)
> +  FIELD(SCR, RE,   4, 1)
> +  FIELD(SCR, TE,   5, 1)
> +  FIELD(SCR, RIE,  6, 1)
> +  FIELD(SCR, TIE,  7, 1)
> +REG8(TDR, 3)
> +REG8(SSR, 4)
> +  FIELD(SSR, MPBT, 0, 1)
> +  FIELD(SSR, MPB,  1, 1)
> +  FIELD(SSR, TEND, 2, 1)
> +  FIELD(SSR, ERR, 3, 3)
> +    FIELD(SSR, PER,  3, 1)
> +    FIELD(SSR, FER,  4, 1)
> +    FIELD(SSR, ORER, 5, 1)
> +  FIELD(SSR, RDRF, 6, 1)
> +  FIELD(SSR, TDRE, 7, 1)
> +REG8(RDR, 5)
> +REG8(SCMR, 6)
> +  FIELD(SCMR, SMIF, 0, 1)
> +  FIELD(SCMR, SINV, 2, 1)
> +  FIELD(SCMR, SDIR, 3, 1)
> +  FIELD(SCMR, BCP2, 7, 1)
> +REG8(SEMR, 7)
> +  FIELD(SEMR, ACS0, 0, 1)
> +  FIELD(SEMR, ABCS, 4, 1)
> +
> +static int can_receive(void *opaque)
> +{
> +    RSCIState *sci =3D RSCI(opaque);
> +    if (sci->rx_next > qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) {
> +        return 0;
> +    } else {
> +        return FIELD_EX8(sci->scr, SCR, RE);
> +    }
> +}
> +
> +static void receive(void *opaque, const uint8_t *buf, int size)
> +{
> +    RSCIState *sci =3D RSCI(opaque);
> +    sci->rx_next =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime;
> +    if (FIELD_EX8(sci->ssr, SSR, RDRF) || size > 1) {
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, ORER, 1);
> +        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> +            qemu_set_irq(sci->irq[ERI], 1);
> +        }
> +    } else {
> +        sci->rdr =3D buf[0];
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, RDRF, 1);
> +        if (FIELD_EX8(sci->scr, SCR, RIE)) {
> +            qemu_irq_pulse(sci->irq[RXI]);
> +        }
> +    }
> +}
> +
> +static void send_byte(RSCIState *sci)
> +{
> +    if (qemu_chr_fe_backend_connected(&sci->chr)) {
> +        qemu_chr_fe_write_all(&sci->chr, &sci->tdr, 1);
> +    }
> +    timer_mod(sci->timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + sci->trtime);
> +    sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TEND, 0);
> +    sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TDRE, 1);
> +    qemu_set_irq(sci->irq[TEI], 0);
> +    if (FIELD_EX8(sci->scr, SCR, TIE)) {
> +        qemu_irq_pulse(sci->irq[TXI]);
> +    }
> +}
> +
> +static void txend(void *opaque)
> +{
> +    RSCIState *sci =3D RSCI(opaque);
> +    if (!FIELD_EX8(sci->ssr, SSR, TDRE)) {
> +        send_byte(sci);
> +    } else {
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TEND, 1);
> +        if (FIELD_EX8(sci->scr, SCR, TEIE)) {
> +            qemu_set_irq(sci->irq[TEI], 1);
> +        }
> +    }
> +}
> +
> +static void update_trtime(RSCIState *sci)
> +{
> +    /* char per bits */
> +    sci->trtime =3D 8 - FIELD_EX8(sci->smr, SMR, CHR);
> +    sci->trtime +=3D FIELD_EX8(sci->smr, SMR, PE);
> +    sci->trtime +=3D FIELD_EX8(sci->smr, SMR, STOP) + 1;
> +    /* x bit transmit time (32 * divrate * brr) / base freq */
> +    sci->trtime *=3D 32 * sci->brr;
> +    sci->trtime *=3D 1 << (2 * FIELD_EX8(sci->smr, SMR, CKS));
> +    sci->trtime *=3D NANOSECONDS_PER_SECOND;
> +    sci->trtime /=3D sci->input_freq;
> +}
> +
> +#define IS_TR_ENABLED(scr) \
> +    (FIELD_EX8(scr, SCR, TE) || FIELD_EX8(scr, SCR, RE))
> +
> +static void sci_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
> +{
> +    hwaddr offset =3D addr & 0x07;
> +    RSCIState *sci =3D RSCI(opaque);
> +
> +    switch (offset) {
> +    case A_SMR:
> +        if (!IS_TR_ENABLED(sci->scr)) {
> +            sci->smr =3D val;
> +            update_trtime(sci);
> +        }
> +        break;
> +    case A_BRR:
> +        if (!IS_TR_ENABLED(sci->scr)) {
> +            sci->brr =3D val;
> +            update_trtime(sci);
> +        }
> +        break;
> +    case A_SCR:
> +        sci->scr =3D val;
> +        if (FIELD_EX8(sci->scr, SCR, TE)) {
> +            sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TDRE, 1);
> +            sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TEND, 1);
> +            if (FIELD_EX8(sci->scr, SCR, TIE)) {
> +                qemu_irq_pulse(sci->irq[TXI]);
> +            }
> +        }
> +        if (!FIELD_EX8(sci->scr, SCR, TEIE)) {
> +            qemu_set_irq(sci->irq[TEI], 0);
> +        }
> +        if (!FIELD_EX8(sci->scr, SCR, RIE)) {
> +            qemu_set_irq(sci->irq[ERI], 0);
> +        }
> +        break;
> +    case A_TDR:
> +        sci->tdr =3D val;
> +        if (FIELD_EX8(sci->ssr, SSR, TEND)) {
> +            send_byte(sci);
> +        } else {
> +            sci->ssr =3D FIELD_DP8(sci->ssr, SSR, TDRE, 0);
> +        }
> +        break;
> +    case A_SSR:
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, MPBT,
> +                             FIELD_EX8(val, SSR, MPBT));
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, ERR,
> +                             FIELD_EX8(val, SSR, ERR) & 0x07);
> +        if (FIELD_EX8(sci->read_ssr, SSR, ERR) &&
> +            FIELD_EX8(sci->ssr, SSR, ERR) =3D=3D 0) {
> +            qemu_set_irq(sci->irq[ERI], 0);
> +        }
> +        break;
> +    case A_RDR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "reneas_sci: RDR is read only.\n"=
);
> +        break;
> +    case A_SCMR:
> +        sci->scmr =3D val; break;
> +    case A_SEMR: /* SEMR */
> +        sci->semr =3D val; break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "renesas_sci: Register %08lx not implemented\n", o=
ffset);
> +    }
> +}
> +
> +static uint64_t sci_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    hwaddr offset =3D addr & 0x07;
> +    RSCIState *sci =3D RSCI(opaque);
> +
> +    switch (offset) {
> +    case A_SMR:
> +        return sci->smr;
> +    case A_BRR:
> +        return sci->brr;
> +    case A_SCR:
> +        return sci->scr;
> +    case A_TDR:
> +        return sci->tdr;
> +    case A_SSR:
> +        sci->read_ssr =3D sci->ssr;
> +        return sci->ssr;
> +    case A_RDR:
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, RDRF, 0);
> +        return sci->rdr;
> +    case A_SCMR:
> +        return sci->scmr;
> +    case A_SEMR:
> +        return sci->semr;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "renesas_sci: Register %08lx not implemented.\n", =
offset);
> +    }
> +    return -1;
> +}
> +
> +static const MemoryRegionOps sci_ops =3D {
> +    .write =3D sci_write,
> +    .read  =3D sci_read,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .max_access_size =3D 1,
> +    },
> +};
> +
> +static void rsci_reset(DeviceState *dev)
> +{
> +    RSCIState *sci =3D RSCI(dev);
> +    sci->smr =3D sci->scr =3D 0x00;
> +    sci->brr =3D 0xff;
> +    sci->tdr =3D 0xff;
> +    sci->rdr =3D 0x00;
> +    sci->ssr =3D 0x84;
> +    sci->scmr =3D 0x00;
> +    sci->semr =3D 0x00;
> +    sci->rx_next =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +}
> +
> +static void sci_event(void *opaque, int event)
> +{
> +    RSCIState *sci =3D RSCI(opaque);
> +    if (event =3D=3D CHR_EVENT_BREAK) {
> +        sci->ssr =3D FIELD_DP8(sci->ssr, SSR, FER, 1);
> +        printf("ssr %s %d %02x\n", __func__, __LINE__, sci->ssr);

stray debug printf

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

