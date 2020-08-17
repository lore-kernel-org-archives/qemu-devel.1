Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A6EC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 21:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21A02072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 21:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXL5IkiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21A02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7mH6-0003s5-SK
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 17:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7mGG-0003E2-5k; Mon, 17 Aug 2020 17:01:44 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7mGE-0004yS-2h; Mon, 17 Aug 2020 17:01:43 -0400
Received: by mail-io1-xd41.google.com with SMTP id g13so4782274ioo.9;
 Mon, 17 Aug 2020 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jRvgnwynUsTh8rQgUrHkptyW0TT2ujuA1qFHWSdEv1I=;
 b=tXL5IkiMFKHmUhYsOea7z5C8jXGSPrpAYMc+1UN3B+uavdP3HN3s0qeQqDUEGDInlp
 WRWnwlg5y33Nqt5EVRXR+tbEM+VpYy5bIQXKjd3nTAsrvtkws2miQYeulSzBb9CtHCGW
 bFZ5RDBMzZZxxPe4/ckTKbDHem28+qcVU/fbR3xL6u6vYzUeCsHNhExTQvT8dw63RSyp
 Xtlhd/OWbCw/+CA5r7dyWZgIWO6oRxxC6PBppqzS8I5coldTRbFVbkjijH2Pu+pnkggE
 PI61F6A0L75Qsn7LlOYg7nU2eJ+CrXUR5RMoADoZHjZy1SXViZfky0ZDz7qSHSHUmEQ8
 o1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jRvgnwynUsTh8rQgUrHkptyW0TT2ujuA1qFHWSdEv1I=;
 b=R9siZG945APRf0FGDEPQYOYj0qih6at5QczOQGgt11zC1DQ1qPjsWa64W9xt1irPQV
 S7a8/i5zuivK2YJkkqIA0TUyPY8l7ocTEAQZQ5s7qs/dQxCiH/9SKj9IhRmLsf/kT4kq
 1GF9A73q06MNx2y2oh98Kyk6Cz7vDNTD7L2IL7vfY0n24tGN9rAYIW1tW3yXuF07H1yb
 7dLqZS/pGSYgU9zpScaAxXlXzVRNTMBO7NHFlJrlqqGIa0WEJG/upAUqSlVNY/v80b4k
 T/I9lNI+bwYlmDWtbvoZmkKNsGennC6e/0Ekn+Hfv24axLWT4Fwrj3T2x+lYdO+nGxy3
 XUWQ==
X-Gm-Message-State: AOAM533A6ZBy0fLGAeYO0Vva6DNzbx94YKIjfUpWjt8+6ol2ZM+GDEep
 pn7TDwpVoLdBlkujaxLTThl8yVaC/N0skXgQJZs=
X-Google-Smtp-Source: ABdhPJxXW8D+eMZVhyaCw/0nqkBCM2e0c6LFrpwjcgLrEpcJ9nfxLUdNg6/ovUIOzC8P7eMWYC0LT0RTTY7HL+AKzJ0=
X-Received: by 2002:a6b:400e:: with SMTP id k14mr13523328ioa.175.1597698099543; 
 Mon, 17 Aug 2020 14:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-6-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-6-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 13:51:07 -0700
Message-ID: <CAKmqyKMrBYAUkiyTzbp9UazZ8-tBmMzn1V+CdFJ-K=aeaLV85w@mail.gmail.com>
Subject: Re: [PATCH 05/18] hw/char: Add Microchip PolarFire SoC MMUART
 emulation
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 9:45 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Microchip PolarFire SoC MMUART is ns16550 compatible, with some
> additional registers. Create a simple MMUART model built on top
> of the existing ns16550 model.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  MAINTAINERS                         |  2 +
>  hw/char/Kconfig                     |  3 ++
>  hw/char/Makefile.objs               |  1 +
>  hw/char/mchp_pfsoc_mmuart.c         | 82 +++++++++++++++++++++++++++++++++++++
>  include/hw/char/mchp_pfsoc_mmuart.h | 61 +++++++++++++++++++++++++++
>  5 files changed, 149 insertions(+)
>  create mode 100644 hw/char/mchp_pfsoc_mmuart.c
>  create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8716cb6..e51edac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1319,7 +1319,9 @@ M: Bin Meng <bin.meng@windriver.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: hw/riscv/microchip_pfsoc.c
> +F: hw/char/mchp_pfsoc_mmuart.c
>  F: include/hw/riscv/microchip_pfsoc.h
> +F: include/hw/char/mchp_pfsoc_mmuart.h
>
>  RX Machines
>  -----------
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index b7e0e4d..1d64555 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -52,3 +52,6 @@ config RENESAS_SCI
>
>  config AVR_USART
>      bool
> +
> +config MCHP_PFSOC_MMUART
> +    bool
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index bf177ac..f705845 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -33,6 +33,7 @@ common-obj-$(CONFIG_LM32) += lm32_juart.o
>  common-obj-$(CONFIG_LM32) += lm32_uart.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
>  common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
> +common-obj-$(CONFIG_MCHP_PFSOC_MMUART) += mchp_pfsoc_mmuart.o
>
>  obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
>  obj-$(CONFIG_PSERIES) += spapr_vty.o
> diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
> new file mode 100644
> index 0000000..9984acc
> --- /dev/null
> +++ b/hw/char/mchp_pfsoc_mmuart.c
> @@ -0,0 +1,82 @@
> +/*
> + * Microchip PolarFire SoC MMUART emulation
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
> +#include "qemu/log.h"
> +#include "chardev/char.h"
> +#include "exec/address-spaces.h"
> +#include "hw/char/mchp_pfsoc_mmuart.h"
> +
> +static uint64_t mchp_pfsoc_mmuart_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MchpPfSoCMMUartState *s = opaque;
> +
> +    if ((addr % sizeof(uint32_t)) || (addr >= 0x34)) {

You can specify impl.min_access_size and impl.max_access_size as part
of MemoryRegionOps so the allignment check isn't required here.

> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +        return 0;
> +    }
> +
> +    return s->reg[addr / sizeof(uint32_t)];
> +}
> +
> +static void mchp_pfsoc_mmuart_write(void *opaque, hwaddr addr,
> +                                    uint64_t value, unsigned size)
> +{
> +    MchpPfSoCMMUartState *s = opaque;
> +    uint32_t val32 = (uint32_t)value;
> +
> +    if ((addr % sizeof(uint32_t)) || (addr >= 0x34)) {

Same comment here about allignment.

Alistair

> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
> +                      " v=0x%x\n", __func__, addr, val32);
> +        return;
> +    }
> +
> +    s->reg[addr / sizeof(uint32_t)] = val32;
> +}
> +
> +static const MemoryRegionOps mchp_pfsoc_mmuart_ops = {
> +    .read = mchp_pfsoc_mmuart_read,
> +    .write = mchp_pfsoc_mmuart_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
> +    hwaddr base, qemu_irq irq, Chardev *chr)
> +{
> +    MchpPfSoCMMUartState *s;
> +
> +    s = g_new0(MchpPfSoCMMUartState, 1);
> +
> +    memory_region_init_io(&s->iomem, NULL, &mchp_pfsoc_mmuart_ops, s,
> +                          "mchp.pfsoc.mmuart", 0x1000);
> +
> +    s->base = base;
> +    s->irq = irq;
> +
> +    s->serial = serial_mm_init(sysmem, base, 2, irq, 399193, chr,
> +                               DEVICE_LITTLE_ENDIAN);
> +
> +    memory_region_add_subregion(sysmem, base + 0x20, &s->iomem);
> +
> +    return s;
> +}
> diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
> new file mode 100644
> index 0000000..f619902
> --- /dev/null
> +++ b/include/hw/char/mchp_pfsoc_mmuart.h
> @@ -0,0 +1,61 @@
> +/*
> + * Microchip PolarFire SoC MMUART emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_MCHP_PFSOC_MMUART_H
> +#define HW_MCHP_PFSOC_MMUART_H
> +
> +#include "hw/char/serial.h"
> +
> +#define MCHP_PFSOC_MMUART_REG_SIZE  52
> +
> +typedef struct MchpPfSoCMMUartState {
> +    MemoryRegion iomem;
> +    hwaddr base;
> +    qemu_irq irq;
> +
> +    SerialMM *serial;
> +
> +    uint32_t reg[MCHP_PFSOC_MMUART_REG_SIZE / sizeof(uint32_t)];
> +} MchpPfSoCMMUartState;
> +
> +/**
> + * mchp_pfsoc_mmuart_create - Create a Microchip PolarFire SoC MMUART
> + *
> + * This is a helper routine for board to create a MMUART device that is
> + * compatible with Microchip PolarFire SoC.
> + *
> + * @sysmem: system memory region to map
> + * @base: base address of the MMUART registers
> + * @irq: IRQ number of the MMUART device
> + * @chr: character device to associate to
> + *
> + * @return: a pointer to the device specific control structure
> + */
> +MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
> +    hwaddr base, qemu_irq irq, Chardev *chr);
> +
> +#endif /* HW_MCHP_PFSOC_MMUART_H */
> --
> 2.7.4
>
>

