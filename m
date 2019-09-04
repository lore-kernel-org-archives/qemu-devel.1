Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB28FC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6466A2053B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjCaEtcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6466A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5YIs-0000hA-EK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 12:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i5YHl-0008PK-BN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i5YHj-0004Hf-BS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:37:33 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i5YHi-0004G1-W5; Wed, 04 Sep 2019 12:37:31 -0400
Received: by mail-lj1-x241.google.com with SMTP id u14so13718607ljj.11;
 Wed, 04 Sep 2019 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4F7RcvqouPKF8nKeu2qeDpyCGtQ7VrPoOreh9r7TMaI=;
 b=RjCaEtcHiFxtw2aA37PDw6/4lW7ONEe9MAdpAn2kHL9TdvjFHvkD2iuDSZ9lz0mBa1
 RvafnvPbDmrcxLa9iKzvhH7ScUkcIfv/XXn2fJAFrzb9fNmIFr3t9n1vmsudBGTr06JU
 J8c4WHVF/kmpOHypoQ1lz69RRnF02GfoJlK/iwLE+9e7BSBfwUChqLe5oP1WZxAlW2UX
 FwHlaLnzBXDC6nz1Dtg5JFF2R7GjGc2mBWLi/XFiaqzc9EpqhoiG8MDBFSUZZP2SNHW4
 1NED2dv4mP6p8VZiYdi8O2iQI5geidN8oVZLh5C7CsPCxbdXGvfyCv2Q2VocW1Zkrjhp
 Tq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4F7RcvqouPKF8nKeu2qeDpyCGtQ7VrPoOreh9r7TMaI=;
 b=Fh+dEhcl4TuiYS720ROGDmsgx5iA17AgtFxp77RiYWcFZ8gkPO9v4x37fS6GnsfNev
 KxIBb4VsUuStyF1sp+f16a+OCR8xVXp2lo6WlUko0UNAQbUr6PywSHmse/kSvAq4WisL
 Nf19XDzQ5MVpZmrPwfEiRFpah3vi+MBogn2A9O3i0y4Q2z/tbVPuSL+2ZGVegtT/TpfP
 ouRQ9HPlXSY7SX+UdSWGuInYNo2QfFFDNoLvq40JDH6JmDno/sHkZg599yMjGZUHNJjY
 zok2OilsePr6K+ge7gIptu/bNNjZDehBKOpHMtvGDtjNfsrhbpv149t8F93BmMo9W698
 4Q4g==
X-Gm-Message-State: APjAAAWDb5yOu+ikWhFF06yX5fnwJCxGa/zSSbEmO+f778URuoSEGrml
 lU/avfPSpVoQjGe+3F7ZZltCQBoF6LIX6TP9luU=
X-Google-Smtp-Source: APXvYqx4q2+lnnCsVRzgaqDEBgaGttpRaGMAZF2Ivqdpeku/qkfWKWYDkIBTp72dhvtHQLthQ9lARns61p4kWqz+Ljo=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr23411306ljb.33.1567615049420; 
 Wed, 04 Sep 2019 09:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
 <1567306391-2682-27-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1567306391-2682-27-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Sep 2019 09:37:02 -0700
Message-ID: <CAKmqyKMHmRYMgv_ex-8XFzr3KSLhUC-DdNA+6JPdmjGojmX-4A@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v7 26/30] riscv: sifive: Implement a model
 for SiFive FU540 OTP
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 31, 2019 at 8:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This implements a simple model for SiFive FU540 OTP (One-Time
> Programmable) Memory interface, primarily for reading out the
> stored serial number from the first 1 KiB of the 16 KiB OTP
> memory reserved by SiFive for internal use.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> - change to use defines instead of enums
> - change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_otp
> - creating a 32-bit val variable and using that instead of casting
>   everywhere in sifive_u_otp_write()
> - move all register initialization to sifive_u_otp_reset() function
> - drop sifive_u_otp_create()
>
> Changes in v4:
> - prefix all macros/variables/functions with SIFIVE_U/sifive_u
>   in the sifive_u_otp driver
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/Makefile.objs          |   1 +
>  hw/riscv/sifive_u_otp.c         | 190 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_u_otp.h |  80 +++++++++++++++++
>  3 files changed, 271 insertions(+)
>  create mode 100644 hw/riscv/sifive_u_otp.c
>  create mode 100644 include/hw/riscv/sifive_u_otp.h
>
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index b95bbd5..fc3c6dd 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SIFIVE) += sifive_gpio.o
>  obj-$(CONFIG_SIFIVE) += sifive_plic.o
>  obj-$(CONFIG_SIFIVE) += sifive_test.o
>  obj-$(CONFIG_SIFIVE_U) += sifive_u.o
> +obj-$(CONFIG_SIFIVE_U) += sifive_u_otp.o
>  obj-$(CONFIG_SIFIVE_U) += sifive_u_prci.o
>  obj-$(CONFIG_SIFIVE) += sifive_uart.o
>  obj-$(CONFIG_SPIKE) += spike.o
> diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
> new file mode 100644
> index 0000000..7d65a85
> --- /dev/null
> +++ b/hw/riscv/sifive_u_otp.c
> @@ -0,0 +1,190 @@
> +/*
> + * QEMU SiFive U OTP (One-Time Programmable) Memory interface
> + *
> + * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> + *
> + * Simple model of the OTP to emulate register reads made by the SDK BSP
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/riscv/sifive_u_otp.h"
> +
> +static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    SiFiveUOTPState *s = opaque;
> +
> +    switch (addr) {
> +    case SIFIVE_U_OTP_PA:
> +        return s->pa;
> +    case SIFIVE_U_OTP_PAIO:
> +        return s->paio;
> +    case SIFIVE_U_OTP_PAS:
> +        return s->pas;
> +    case SIFIVE_U_OTP_PCE:
> +        return s->pce;
> +    case SIFIVE_U_OTP_PCLK:
> +        return s->pclk;
> +    case SIFIVE_U_OTP_PDIN:
> +        return s->pdin;
> +    case SIFIVE_U_OTP_PDOUT:
> +        if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
> +            (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
> +            (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> +            return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> +        } else {
> +            return 0xff;
> +        }
> +    case SIFIVE_U_OTP_PDSTB:
> +        return s->pdstb;
> +    case SIFIVE_U_OTP_PPROG:
> +        return s->pprog;
> +    case SIFIVE_U_OTP_PTC:
> +        return s->ptc;
> +    case SIFIVE_U_OTP_PTM:
> +        return s->ptm;
> +    case SIFIVE_U_OTP_PTM_REP:
> +        return s->ptm_rep;
> +    case SIFIVE_U_OTP_PTR:
> +        return s->ptr;
> +    case SIFIVE_U_OTP_PTRIM:
> +        return s->ptrim;
> +    case SIFIVE_U_OTP_PWE:
> +        return s->pwe;
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
> +                  __func__, (int)addr);

Don't cast addr to an int, use the correct macros.

> +    return 0;
> +}
> +
> +static void sifive_u_otp_write(void *opaque, hwaddr addr,
> +                               uint64_t val64, unsigned int size)
> +{
> +    SiFiveUOTPState *s = opaque;
> +    uint32_t val32 = (uint32_t)val64;
> +
> +    switch (addr) {
> +    case SIFIVE_U_OTP_PA:
> +        s->pa = val32 & SIFIVE_U_OTP_PA_MASK;
> +        break;
> +    case SIFIVE_U_OTP_PAIO:
> +        s->paio = val32;
> +        break;
> +    case SIFIVE_U_OTP_PAS:
> +        s->pas = val32;
> +        break;
> +    case SIFIVE_U_OTP_PCE:
> +        s->pce = val32;
> +        break;
> +    case SIFIVE_U_OTP_PCLK:
> +        s->pclk = val32;
> +        break;
> +    case SIFIVE_U_OTP_PDIN:
> +        s->pdin = val32;
> +        break;
> +    case SIFIVE_U_OTP_PDOUT:
> +        /* read-only */
> +        break;
> +    case SIFIVE_U_OTP_PDSTB:
> +        s->pdstb = val32;
> +        break;
> +    case SIFIVE_U_OTP_PPROG:
> +        s->pprog = val32;
> +        break;
> +    case SIFIVE_U_OTP_PTC:
> +        s->ptc = val32;
> +        break;
> +    case SIFIVE_U_OTP_PTM:
> +        s->ptm = val32;
> +        break;
> +    case SIFIVE_U_OTP_PTM_REP:
> +        s->ptm_rep = val32;
> +        break;
> +    case SIFIVE_U_OTP_PTR:
> +        s->ptr = val32;
> +        break;
> +    case SIFIVE_U_OTP_PTRIM:
> +        s->ptrim = val32;
> +        break;
> +    case SIFIVE_U_OTP_PWE:
> +        s->pwe = val32;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
> +                      __func__, (int)addr, (int)val64);

Same here.

With those fixed:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +    }
> +}
> +
> +static const MemoryRegionOps sifive_u_otp_ops = {
> +    .read = sifive_u_otp_read,
> +    .write = sifive_u_otp_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static Property sifive_u_otp_properties[] = {
> +    DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
> +{
> +    SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_otp_ops, s,
> +                          TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +}
> +
> +static void sifive_u_otp_reset(DeviceState *dev)
> +{
> +    SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
> +
> +    /* Initialize all fuses' initial value to 0xFFs */
> +    memset(s->fuse, 0xff, sizeof(s->fuse));
> +
> +    /* Make a valid content of serial number */
> +    s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
> +    s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
> +}
> +
> +static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = sifive_u_otp_properties;
> +    dc->realize = sifive_u_otp_realize;
> +    dc->reset = sifive_u_otp_reset;
> +}
> +
> +static const TypeInfo sifive_u_otp_info = {
> +    .name          = TYPE_SIFIVE_U_OTP,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SiFiveUOTPState),
> +    .class_init    = sifive_u_otp_class_init,
> +};
> +
> +static void sifive_u_otp_register_types(void)
> +{
> +    type_register_static(&sifive_u_otp_info);
> +}
> +
> +type_init(sifive_u_otp_register_types)
> diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
> new file mode 100644
> index 0000000..6392975
> --- /dev/null
> +++ b/include/hw/riscv/sifive_u_otp.h
> @@ -0,0 +1,80 @@
> +/*
> + * QEMU SiFive U OTP (One-Time Programmable) Memory interface
> + *
> + * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_SIFIVE_U_OTP_H
> +#define HW_SIFIVE_U_OTP_H
> +
> +#define SIFIVE_U_OTP_PA         0x00
> +#define SIFIVE_U_OTP_PAIO       0x04
> +#define SIFIVE_U_OTP_PAS        0x08
> +#define SIFIVE_U_OTP_PCE        0x0C
> +#define SIFIVE_U_OTP_PCLK       0x10
> +#define SIFIVE_U_OTP_PDIN       0x14
> +#define SIFIVE_U_OTP_PDOUT      0x18
> +#define SIFIVE_U_OTP_PDSTB      0x1C
> +#define SIFIVE_U_OTP_PPROG      0x20
> +#define SIFIVE_U_OTP_PTC        0x24
> +#define SIFIVE_U_OTP_PTM        0x28
> +#define SIFIVE_U_OTP_PTM_REP    0x2C
> +#define SIFIVE_U_OTP_PTR        0x30
> +#define SIFIVE_U_OTP_PTRIM      0x34
> +#define SIFIVE_U_OTP_PWE        0x38
> +
> +#define SIFIVE_U_OTP_PCE_EN     (1 << 0)
> +
> +#define SIFIVE_U_OTP_PDSTB_EN   (1 << 0)
> +
> +#define SIFIVE_U_OTP_PTRIM_EN   (1 << 0)
> +
> +#define SIFIVE_U_OTP_PA_MASK        0xfff
> +#define SIFIVE_U_OTP_NUM_FUSES      0x1000
> +#define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
> +
> +#define SIFIVE_U_OTP_REG_SIZE       0x1000
> +
> +#define TYPE_SIFIVE_U_OTP           "riscv.sifive.u.otp"
> +
> +#define SIFIVE_U_OTP(obj) \
> +    OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
> +
> +typedef struct SiFiveUOTPState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +    uint32_t pa;
> +    uint32_t paio;
> +    uint32_t pas;
> +    uint32_t pce;
> +    uint32_t pclk;
> +    uint32_t pdin;
> +    uint32_t pdstb;
> +    uint32_t pprog;
> +    uint32_t ptc;
> +    uint32_t ptm;
> +    uint32_t ptm_rep;
> +    uint32_t ptr;
> +    uint32_t ptrim;
> +    uint32_t pwe;
> +    uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
> +    /* config */
> +    uint32_t serial;
> +} SiFiveUOTPState;
> +
> +#endif /* HW_SIFIVE_U_OTP_H */
> --
> 2.7.4
>
>

