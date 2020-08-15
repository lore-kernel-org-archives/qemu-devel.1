Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBACC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE1B23AA0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd6Xkjsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE1B23AA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yrv-00031d-Us
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6yqr-0001NC-07; Sat, 15 Aug 2020 12:16:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6yqp-0003SP-2x; Sat, 15 Aug 2020 12:16:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id p14so9848670wmg.1;
 Sat, 15 Aug 2020 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mG97euxq4qo2JoKRnYy0rifrEtQBNzEJf9Q7NXRtpSQ=;
 b=Cd6Xkjsc1x7aEYOgITFGuAmoOy7o/UZgPs+tFXI+/2GWN+PHEL28Jv/efBQSoyfOj3
 ZbV0ztoZtQ4gvDViC4xPWIjL8kID4V3o6cN1ljYbmg4WRB15wP3jEsSz0esvoi5fUDR8
 wGI7xRf1HfXJJsn15pch14/qmGk07T8RfTwepswEap41wBQEh6S2lBs4rb+gGgSAZK2z
 e2/Uqhm2Ppe5jrLvVQLsr3Fomyy3mjgvZUKPmC8dDuBui/uvI4AFMj+6xmtY2QSPKVSF
 OjWvM/HfH+vshLnDYORRU3RAZPKKbdj4DB9xXsJBvyy8b3QNWGICVBDunW9zmFOs1qy3
 60ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mG97euxq4qo2JoKRnYy0rifrEtQBNzEJf9Q7NXRtpSQ=;
 b=eKFcoSt2ocN13BOU1rSbuf+/Q1At68CwpqYMu44Wb+DYtOskpbTzONomYY6v8fgL/T
 y0SrHr+lq6ILxhxC4w0mnZPwlLrQ5keO/eKAKIbMflGR/dWoDAsQVWVLai6KTkO7gAh0
 wYhWmyNH9g4ZaXnweUMRlr67QFUivzqp0W7ii2sJ2WkT1U3T2TkojBR0rvlIxD0iRxoL
 opLjY/mATPND7V1Kl3UiqwQiIiXvzYDEJKL3ViaN821y7p56z+PDsUX+XHCUnCGw086o
 G+xLEIqZQIsZPT/HiSGqf5+GFuv4qwTcmE3qnfof01dtafIT37ycq6Fw5jgfTmeDSqE6
 0F0Q==
X-Gm-Message-State: AOAM5314NfmHmPv2mgwX3l/jmbk0M+ZS8M7Ur7p93CV9hA9YRGVuIih9
 n20ODrEFM3eUD+0SEPMzDsPhnEOddp8=
X-Google-Smtp-Source: ABdhPJzvfRwpk3+y7nrZEmwuDp3sGQ40mVtojjj6HJ5nIdoiXiz06E9ZWsCTuUC67SpNcsM+Nxhhxw==
X-Received: by 2002:a1c:df02:: with SMTP id w2mr6455411wmg.137.1597481510669; 
 Sat, 15 Aug 2020 01:51:50 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c10sm22522269wrn.24.2020.08.15.01.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 01:51:50 -0700 (PDT)
Subject: Re: [PATCH 10/18] hw/sd: Add Cadence SDHCI emulation
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-11-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <5480434a-563b-b89c-7258-58bc3411b03c@amsat.org>
Date: Sat, 15 Aug 2020 10:51:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597423256-14847-11-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bin.meng@windriver.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 6:40 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> Cadence SD/SDIO/eMMC Host Controller (SD4HC) is an SDHCI compatible
> controller. The SDHCI compatible registers start from offset 0x200,
> which are called Slot Register Set (SRS) in its datasheet.
> 
> This creates a Cadence SDHCI model built on top of the existing
> generic SDHCI model. Cadence specific Host Register Set (HRS) is
> implemented to make guest software happy.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/sd/Kconfig                 |   4 ++
>  hw/sd/Makefile.objs           |   1 +
>  hw/sd/cadence_sdhci.c         | 162 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/sd/cadence_sdhci.h |  65 +++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 hw/sd/cadence_sdhci.c
>  create mode 100644 include/hw/sd/cadence_sdhci.h

Please consider using scripts/git.orderfile.

> 
> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
> index c5e1e55..633b9af 100644
> --- a/hw/sd/Kconfig
> +++ b/hw/sd/Kconfig
> @@ -19,3 +19,7 @@ config SDHCI_PCI
>      default y if PCI_DEVICES
>      depends on PCI
>      select SDHCI
> +
> +config CADENCE_SDHCI
> +    bool
> +    select SDHCI
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index 0d1df17..4d500a6 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -10,3 +10,4 @@ common-obj-$(CONFIG_OMAP) += omap_mmc.o
>  common-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
>  common-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
> +common-obj-$(CONFIG_CADENCE_SDHCI) += cadence_sdhci.o
> diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
> new file mode 100644
> index 0000000..67ffd14
> --- /dev/null
> +++ b/hw/sd/cadence_sdhci.c
> @@ -0,0 +1,162 @@
> +/*
> + * Cadence SDHCI emulation
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
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/sd/cadence_sdhci.h"
> +#include "sdhci-internal.h"
> +
> +#define TO_REG(addr)    ((addr) / sizeof(uint32_t))
> +
> +static void cadence_sdhci_reset(DeviceState *dev)
> +{
> +    CadenceSDHCIState *sdhci = CADENCE_SDHCI(dev);

We usually use 's' for the model state.

> +
> +    memset(sdhci->regs, 0, CADENCE_SDHCI_REG_SIZE);
> +    sdhci->regs[TO_REG(SDHCI_CDNS_HRS00)] = SDHCI_CDNS_HRS00_POR_VAL;

As commented in previous patch, here goes:

       device_legacy_reset(DEVICE(&sdhci->slot));

> +}
> +
> +static uint64_t cadence_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    uint32_t val = 0;
> +    CadenceSDHCIState *sdhci = opaque;
> +
> +    if (addr < CADENCE_SDHCI_REG_SIZE) {
> +        val = sdhci->regs[TO_REG(addr)];
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\n",
> +                      __func__, addr);
> +    }
> +
> +    return (uint64_t)val;
> +}
> +
> +static void cadence_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
> +                                unsigned int size)
> +{
> +    CadenceSDHCIState *sdhci = opaque;
> +    uint32_t val32 = (uint32_t)val;
> +
> +    switch (addr) {
> +    case SDHCI_CDNS_HRS00:
> +        /*
> +         * The only writable bit is SWR (software reset) and it automatically
> +         * clears to zero, so essentially this register remains unchanged.
> +         */
> +        if (val32 & SDHCI_CDNS_HRS00_SWR) {
> +            cadence_sdhci_reset(DEVICE(sdhci));
> +            sdhci_poweron_reset(DEVICE(&sdhci->slot));

The 'slot' reset has to go in cadence_sdhci_reset().

> +        }
> +
> +        break;
> +    case SDHCI_CDNS_HRS04:
> +        /*
> +         * Only emulate the ACK bit behavior when read or write transaction
> +         * are requested.
> +         */
> +        if (val32 & (SDHCI_CDNS_HRS04_WR | SDHCI_CDNS_HRS04_RD)) {
> +            val32 |= SDHCI_CDNS_HRS04_ACK;
> +        } else {
> +            val32 &= ~SDHCI_CDNS_HRS04_ACK;
> +        }
> +
> +        sdhci->regs[TO_REG(addr)] = val32;
> +        break;
> +    case SDHCI_CDNS_HRS06:
> +        if (val32 & SDHCI_CDNS_HRS06_TUNE_UP) {
> +            val32 &= ~SDHCI_CDNS_HRS06_TUNE_UP;
> +        }
> +
> +        sdhci->regs[TO_REG(addr)] = val32;
> +        break;
> +    default:
> +        if (addr < CADENCE_SDHCI_REG_SIZE) {
> +            sdhci->regs[TO_REG(addr)] = val32;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "\n",
> +                          __func__, addr);
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps cadence_sdhci_ops = {
> +    .read = cadence_sdhci_read,
> +    .write = cadence_sdhci_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

To make it obvious, please also add:

       .impl = {
           .min_access_size = 4,
           .max_access_size = 4,
       },

> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
> +};
> +
> +static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    CadenceSDHCIState *sdhci = CADENCE_SDHCI(dev);
> +    SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slot);

Where is sdhci->slot initialized??

> +
> +    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &cadence_sdhci_ops,
> +                          sdhci, TYPE_CADENCE_SDHCI, 0x1000);
> +    sysbus_init_mmio(sbd, &sdhci->iomem);
> +
> +    sysbus_realize(sbd_slot, errp);
> +    memory_region_add_subregion(&sdhci->iomem, SDHCI_CDNS_SRS_BASE,
> +                                &sdhci->slot.iomem);

You should not access private field that way, you have to use
the public interface:

  memory_region_add_subregion(&sdhci->iomem, SDHCI_CDNS_SRS_BASE,
           sysbus_mmio_get_region(SYS_BUS_DEVICE(&sdhci->slot), 0));

To have this model useful, you need to propagate at least the 'sd-bus'
and 'dma' properties from the 'slot', else how the TYPE_CADENCE_SDHCI
user is supposed to set them?

> +}
> +
> +static const VMStateDescription vmstate_cadence_sdhci = {
> +    .name = TYPE_CADENCE_SDHCI,
> +    .version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, CadenceSDHCIState, CADENCE_SDHCI_NUM_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void cadence_sdhci_class_init(ObjectClass *classp, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(classp);
> +
> +    dc->realize = cadence_sdhci_realize;
> +    dc->reset = cadence_sdhci_reset;
> +    dc->vmsd = &vmstate_cadence_sdhci;
> +}
> +
> +static TypeInfo cadence_sdhci_info = {
> +    .name          = TYPE_CADENCE_SDHCI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(CadenceSDHCIState),
> +    .class_init    = cadence_sdhci_class_init,
> +};
> +
> +static void cadence_sdhci_register_types(void)
> +{
> +    type_register_static(&cadence_sdhci_info);
> +}
> +
> +type_init(cadence_sdhci_register_types)
> diff --git a/include/hw/sd/cadence_sdhci.h b/include/hw/sd/cadence_sdhci.h
> new file mode 100644
> index 0000000..9ff78a9
> --- /dev/null
> +++ b/include/hw/sd/cadence_sdhci.h
> @@ -0,0 +1,65 @@
> +/*
> + * Cadence SDHCI emulation
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
> +#ifndef CADENCE_SDHCI_H
> +#define CADENCE_SDHCI_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/sd/sdhci.h"
> +
> +/* HRS - Host Register Set (specific to Cadence) */
> +
> +#define SDHCI_CDNS_HRS00                0x00    /* general information */
> +#define SDHCI_CDNS_HRS00_SWR                BIT(0)
> +#define SDHCI_CDNS_HRS00_POR_VAL            0x00010000
> +
> +#define SDHCI_CDNS_HRS04                0x10    /* PHY access port */
> +#define SDHCI_CDNS_HRS04_WR                 BIT(24)
> +#define SDHCI_CDNS_HRS04_RD                 BIT(25)
> +#define SDHCI_CDNS_HRS04_ACK                BIT(26)
> +
> +#define SDHCI_CDNS_HRS06                0x18    /* eMMC control */
> +#define SDHCI_CDNS_HRS06_TUNE_UP            BIT(15)
> +
> +/* SRS - Slot Register Set (SDHCI-compatible) */
> +#define SDHCI_CDNS_SRS_BASE             0x200

Please keep the previous definitions local to cadence_sdhci.c.

> +
> +#define CADENCE_SDHCI_CAPABILITIES 0x01E80080
> +#define CADENCE_SDHCI_REG_SIZE     0x100
> +#define CADENCE_SDHCI_NUM_REGS     (CADENCE_SDHCI_REG_SIZE / sizeof(uint32_t))
> +
> +typedef struct CadenceSDHCIState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    uint32_t regs[CADENCE_SDHCI_NUM_REGS];
> +
> +    SDHCIState slot;

Why name this 'slot' and not 'sdhci' or 'generic_sdhci'?

Thanks,

Phil.

> +} CadenceSDHCIState;
> +
> +#define TYPE_CADENCE_SDHCI  "cadence.sdhci"
> +#define CADENCE_SDHCI(obj)  OBJECT_CHECK(CadenceSDHCIState, (obj), \
> +                                         TYPE_CADENCE_SDHCI)
> +
> +#endif /* CADENCE_SDHCI_H */
> 


