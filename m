Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C289CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2765E20735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNB7v5V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2765E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXW9G-0001Np-3D
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 17:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXW7Q-0008Vj-0o; Tue, 27 Oct 2020 17:03:00 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:45004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXW7N-0001C5-Da; Tue, 27 Oct 2020 17:02:59 -0400
Received: by mail-il1-x144.google.com with SMTP id z2so2778163ilh.11;
 Tue, 27 Oct 2020 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OVNLD2nQhMRiM4MBqEtyY3a69HJiwMfbE/AY7Uj1qWw=;
 b=nNB7v5V2JZt17Hynr/s/LG2M1fDw6XCpl+3Njfm6Kzo5szrL5B93n2hUfup/0cg7t9
 lvW7nJJ2twmItOmOrNeCPjzt1KZH/AhHxXCFV04EaUAsQ9TDTOhDx3bUpSQOAf5zm74A
 rmIETDJBdUFxJN6mF2etf+b1zvJ4VJx+MUxhhRj4rw4Vog59A9D3cUXBKzkwF6UqN/zi
 rl8Ent8yCCytLJ63a0UunycY4v3ztgwXR1BAwCCbtAxsF/5c8ERn2CRU3dRBe1svfOth
 8JrX35MFz/O3Do9yi7D9a/3aUIxy/iL5z3kFJM7QvEOrny/pMlKV76l+wqyRFXomuuHs
 HSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OVNLD2nQhMRiM4MBqEtyY3a69HJiwMfbE/AY7Uj1qWw=;
 b=ri4h/6n/ZiwG10yFCrJzsg6kgg/zMLcDBuNTWdoUcQHcm807qYFrfY0JjLu5DZgk0q
 JWKDJhybVJzKOF4/2KsNH2vJS2xZ5Avjjex7oF+zgywTxEzQq+QoV/NSRIRYnO5J4Vo0
 aL3do7ipV69JHQR/oqgt61AYTkuTyLwxlK/64lM1sLYk1L12XvPRlTjwSBuJ75txzcqg
 kZltcElyaVrcbMR+7EqL/08DXUi83QP6WV3Cqvy6Vt+JjlxRIYoSlJ/Rqgb2HJpOBrqT
 WHJyJOJR0wVwAdV6sG42HwfzwpwYqeZUjW19AR0qskNH6vInq8LsVdANkTN5Ha3oFt7R
 tb5Q==
X-Gm-Message-State: AOAM533otuuwSb3x6HOBhzLdsKuYg+XiO/I+zL1aqOIFUtiuW+Y7Tsth
 v/dhJKqW6n20jGfF7ySbL0hoXyELpOMe6DpOHco=
X-Google-Smtp-Source: ABdhPJyvoqBGE7+UBE1CIwfwfJriyMrNH0Wn52kTNqndXG1D5p5cMIc6ftmwqCWPn0v+GPg1eTR/mYMpDDb5/YRpMNA=
X-Received: by 2002:a05:6e02:c:: with SMTP id
 h12mr3636234ilr.177.1603832575836; 
 Tue, 27 Oct 2020 14:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
 <20201027141740.18336-6-bmeng.cn@gmail.com>
In-Reply-To: <20201027141740.18336-6-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 13:51:06 -0700
Message-ID: <CAKmqyKOYdkU6fnutBeCaZ1RB38EOmJ-_X9uq2NDziMik4Y2LLg@mail.gmail.com>
Subject: Re: [RESEND PATCH 5/9] hw/misc: Add Microchip PolarFire SoC SYSREG
 module support
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup.patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 7:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This creates a minimum model for Microchip PolarFire SoC SYSREG
> module. It only implements the ENVM_CR register to tell guest
> software that eNVM is running at the configured divider rate.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  MAINTAINERS                         |  2 +
>  hw/misc/Kconfig                     |  3 +
>  hw/misc/mchp_pfsoc_sysreg.c         | 99 +++++++++++++++++++++++++++++
>  hw/misc/meson.build                 |  1 +
>  include/hw/misc/mchp_pfsoc_sysreg.h | 39 ++++++++++++
>  5 files changed, 144 insertions(+)
>  create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
>  create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebbc62a62f..e82f2b35e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1328,10 +1328,12 @@ F: hw/riscv/microchip_pfsoc.c
>  F: hw/char/mchp_pfsoc_mmuart.c
>  F: hw/misc/mchp_pfsoc_dmc.c
>  F: hw/misc/mchp_pfsoc_ioscb.c
> +F: hw/misc/mchp_pfsoc_sysreg.c
>  F: include/hw/riscv/microchip_pfsoc.h
>  F: include/hw/char/mchp_pfsoc_mmuart.h
>  F: include/hw/misc/mchp_pfsoc_dmc.h
>  F: include/hw/misc/mchp_pfsoc_ioscb.h
> +F: include/hw/misc/mchp_pfsoc_sysreg.h
>
>  RX Machines
>  -----------
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 3db15e06b4..546e2fab9b 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -140,6 +140,9 @@ config MCHP_PFSOC_DMC
>  config MCHP_PFSOC_IOSCB
>      bool
>
> +config MCHP_PFSOC_SYSREG
> +    bool
> +
>  config SIFIVE_TEST
>      bool
>
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> new file mode 100644
> index 0000000000..248a313345
> --- /dev/null
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -0,0 +1,99 @@
> +/*
> + * Microchip PolarFire SoC SYSREG module emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/mchp_pfsoc_sysreg.h"
> +
> +#define ENVM_CR         0xb8
> +
> +static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
> +                                       unsigned size)
> +{
> +    uint32_t val = 0;
> +
> +    switch (offset) {
> +    case ENVM_CR:
> +        /* Indicate the eNVM is running at the configured divider rate */
> +        val = BIT(6);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
> +                      "(size %d, offset 0x%" HWADDR_PRIx ")\n",
> +                      __func__, size, offset);
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
> +                                    uint64_t value, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> +                  "(size %d, value 0x%" PRIx64
> +                  ", offset 0x%" HWADDR_PRIx ")\n",
> +                  __func__, size, value, offset);
> +}
> +
> +static const MemoryRegionOps mchp_pfsoc_sysreg_ops = {
> +    .read = mchp_pfsoc_sysreg_read,
> +    .write = mchp_pfsoc_sysreg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void mchp_pfsoc_sysreg_realize(DeviceState *dev, Error **errp)
> +{
> +    MchpPfSoCSysregState *s = MCHP_PFSOC_SYSREG(dev);
> +
> +    memory_region_init_io(&s->sysreg, OBJECT(dev),
> +                          &mchp_pfsoc_sysreg_ops, s,
> +                          "mchp.pfsoc.sysreg",
> +                          MCHP_PFSOC_SYSREG_REG_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sysreg);
> +}
> +
> +static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "Microchip PolarFire SoC SYSREG module";
> +    dc->realize = mchp_pfsoc_sysreg_realize;
> +}
> +
> +static const TypeInfo mchp_pfsoc_sysreg_info = {
> +    .name          = TYPE_MCHP_PFSOC_SYSREG,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(MchpPfSoCSysregState),
> +    .class_init    = mchp_pfsoc_sysreg_class_init,
> +};
> +
> +static void mchp_pfsoc_sysreg_register_types(void)
> +{
> +    type_register_static(&mchp_pfsoc_sysreg_info);
> +}
> +
> +type_init(mchp_pfsoc_sysreg_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 6d3c1a3455..8ed75254c4 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -24,6 +24,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
>  # RISC-V devices
>  softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
>  softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
> +softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>  softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
> diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
> new file mode 100644
> index 0000000000..546ba68f6a
> --- /dev/null
> +++ b/include/hw/misc/mchp_pfsoc_sysreg.h
> @@ -0,0 +1,39 @@
> +/*
> + * Microchip PolarFire SoC SYSREG module emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef MCHP_PFSOC_SYSREG_H
> +#define MCHP_PFSOC_SYSREG_H
> +
> +#define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
> +
> +typedef struct MchpPfSoCSysregState {
> +    SysBusDevice parent;
> +    MemoryRegion sysreg;
> +} MchpPfSoCSysregState;
> +
> +#define TYPE_MCHP_PFSOC_SYSREG "mchp.pfsoc.sysreg"
> +
> +#define MCHP_PFSOC_SYSREG(obj) \
> +    OBJECT_CHECK(MchpPfSoCSysregState, (obj), \
> +                 TYPE_MCHP_PFSOC_SYSREG)
> +
> +#endif /* MCHP_PFSOC_SYSREG_H */
> --
> 2.25.1
>
>

