Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1753C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 22:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D89E2065C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgHM3vep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D89E2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLwD-0002Ky-Qp
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 18:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZLvR-0001kQ-Kj; Thu, 14 May 2020 18:01:57 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:36742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jZLvQ-0006V5-Iy; Thu, 14 May 2020 18:01:57 -0400
Received: by mail-il1-x142.google.com with SMTP id 17so449617ilj.3;
 Thu, 14 May 2020 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ya1IodZ6PLMHH//lThMrCWMkmCqVM1gzMGaR4JqPxDI=;
 b=fgHM3vepvc7aicVDbbLglqs3bbGYjx5bCmDCwtFfoKV6g/09wgdxlftuqvrS+ZFxhg
 Ld+E9SUF8oPa4weoQ0TY/pSG2p/uhGPXdZdMqysX6w+F2Uew73BzgDImJpJaKGEa3xbI
 FzsC9A7WgPM6IzxaAuaQltVhhOPChFR01zaIVkwP8H0fiq2xv9f4wAwEwDMePU6XoryR
 KULoMFJ/oYY5n0kUeQK3T1OCXfBFwMOC5Cb7L+KAM/rnJGYg2iK/mH/yu0bbQtqCtlPd
 FzRuBMqygOx2jI1YwhD69CxO6QNE6GjpLYExjcebz1I3LQgM6gahpDcUqlC+giicmhRK
 FXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ya1IodZ6PLMHH//lThMrCWMkmCqVM1gzMGaR4JqPxDI=;
 b=HTQ+yA9UuUt9S0nJLlDJfzEMhBG0QE6rOsejw65rR8AvTakt6TvffZLyPBY2p/5+sN
 QnBEe4sjlwFzUYPtTg4Bq82J3XqWXw0xOR+nXF6TvrTdvedsAhlnfmHHIsbMTs0iPNK8
 DK2WTPwnFg0Q954edgKVnG5Lt27kPqR00bJgLgjK2qrnY9o6ywl3DvjpkBel8i4uMvvq
 0pLuAy+GLze7j37py9V4tePn82rgGjkC4wJUh19vI5Ka6VCNVPxFEoL74JMjC6dfCy7+
 QyQo55X8pzp8oVq8uEIgJZG8DeG3bxNdxU40xh9Yv7J7gxQP7+09RgNCNIZEFYGayOEC
 ehPg==
X-Gm-Message-State: AOAM530PqtpufvbSslDRLgry1FC1vDFfGqpxmum6jBKb90tf96v/+DCC
 A0K4WvNwCLccRVvrX46K3eaj6jeglKOwT1raYQA=
X-Google-Smtp-Source: ABdhPJxjrXnuXNhSab8CzX3TPK/0pBiS4F6Oc0wodh547OzZRGRGpNWOHU1kRjiv/YUVdBt+JSTqD+QprSbRk98cP+U=
X-Received: by 2002:a92:ad09:: with SMTP id w9mr305515ilh.177.1589493715046;
 Thu, 14 May 2020 15:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <27436e8864997f4d67d9562f1db41da2db05f4cf.1588878756.git.alistair.francis@wdc.com>
 <50effad3-3f41-2d36-e4dd-d14c05e6ea8c@redhat.com>
In-Reply-To: <50effad3-3f41-2d36-e4dd-d14c05e6ea8c@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 May 2020 14:53:07 -0700
Message-ID: <CAKmqyKOhoMG+Gc1FwJBRJe1DC5TEHFBDN1pdtR-YtHLEEc3EEw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] hw/intc: Initial commit of lowRISC Ibex PLIC
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

On Thu, May 14, 2020 at 11:40 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 5/7/20 9:13 PM, Alistair Francis wrote:
> > The Ibex core contains a PLIC that although similar to the RISC-V spec
> > is not RISC-V spec compliant.
> >
> > This patch implements a Ibex PLIC in a somewhat generic way.
> >
> > As the current RISC-V PLIC needs tidying up, my hope is that as the Ibe=
x
> > PLIC move towards spec compliance this PLIC implementation can be
> > updated until it can replace the current PLIC.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   MAINTAINERS                 |   2 +
> >   hw/intc/Makefile.objs       |   1 +
> >   hw/intc/ibex_plic.c         | 261 +++++++++++++++++++++++++++++++++++=
+
> >   include/hw/intc/ibex_plic.h |  63 +++++++++
> >   4 files changed, 327 insertions(+)
> >   create mode 100644 hw/intc/ibex_plic.c
> >   create mode 100644 include/hw/intc/ibex_plic.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d3d47564ce..f8c3cf6182 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1237,8 +1237,10 @@ L: qemu-riscv@nongnu.org
> >   S: Supported
> >   F: hw/riscv/opentitan.c
> >   F: hw/char/ibex_uart.c
> > +F: hw/intc/ibex_plic.c
> >   F: include/hw/riscv/opentitan.h
> >   F: include/hw/char/ibex_uart.h
> > +F: include/hw/intc/ibex_plic.h
> >
> >
> >   SH4 Machines
> > diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> > index f726d87532..a61e6728fe 100644
> > --- a/hw/intc/Makefile.objs
> > +++ b/hw/intc/Makefile.objs
> > @@ -49,3 +49,4 @@ obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_cpuif.o
> >   obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o
> >   obj-$(CONFIG_NIOS2) +=3D nios2_iic.o
> >   obj-$(CONFIG_OMPIC) +=3D ompic.o
> > +obj-$(CONFIG_IBEX) +=3D ibex_plic.o
> > diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
> > new file mode 100644
> > index 0000000000..35c52d9d16
> > --- /dev/null
> > +++ b/hw/intc/ibex_plic.c
> > @@ -0,0 +1,261 @@
> > +/*
> > + * QEMU RISC-V lowRISC Ibex PLIC
> > + *
> > + * Copyright (c) 2020 Western Digital
> > + *
> > + * Documentation avaliable: https://docs.opentitan.org/hw/ip/rv_plic/d=
oc/
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/core/cpu.h"
> > +#include "hw/boards.h"
> > +#include "hw/pci/msi.h"
> > +#include "target/riscv/cpu_bits.h"
> > +#include "target/riscv/cpu.h"
> > +#include "hw/intc/ibex_plic.h"
> > +
> > +static bool addr_between(uint32_t addr, uint32_t base, uint32_t num)
> > +{
> > +    uint32_t end =3D base + (num * 0x04);
> > +
> > +    if (addr >=3D base && addr < end) {
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool=
 level)
> > +{
> > +    int pending_num =3D irq / 32;
> > +
> > +    s->pending[pending_num] |=3D level << (irq % 32);
> > +}
> > +
> > +static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < s->pending_num; i++) {
> > +        uint32_t irq_num =3D ctz64(s->pending[i]) + (i * 32);
> > +
> > +        if (!(s->pending[i] & s->enable[i])) {
> > +            /* No pending and enabled IRQ */
> > +            continue;
> > +        }
> > +
> > +        if (s->priority[irq_num] > s->threshold) {
> > +            if (!s->claim) {
> > +                s->claim =3D irq_num;
> > +            }
> > +            return true;
> > +        }
> > +    }
> > +
> > +    return 0;
>
> return 'false'.

Fixed.

>
> > +}
> > +
> > +static void ibex_plic_update(IbexPlicState *s)
> > +{
> > +    CPUState *cpu;
> > +    int level, i;
> > +
> > +    for (i =3D 0; i < s->num_cpus; i++) {
> > +        cpu =3D qemu_get_cpu(i);
> > +
> > +        if (!cpu) {
> > +            continue;
> > +        }
> > +
> > +        level =3D ibex_plic_irqs_pending(s, 0);
> > +
> > +        riscv_cpu_update_mip(RISCV_CPU(cpu), MIP_MEIP, BOOL_TO_MASK(le=
vel));
> > +    }
> > +}
> > +
> > +static void ibex_plic_reset(DeviceState *dev)
> > +{
> > +    IbexPlicState *s =3D IBEX_PLIC(dev);
> > +
> > +    s->threshold =3D 0x00000000;
> > +    s->claim =3D 0x00000000;
>
> I haven't check the datasheet reset values, for the rest:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for reviewing these :)

Alistair

