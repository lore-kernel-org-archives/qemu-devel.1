Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D09620826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctE1neGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D09620826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrM2D-0005Wc-B6
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrM1C-0004r7-Ct; Fri, 03 Jul 2020 09:46:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrM1A-00064u-14; Fri, 03 Jul 2020 09:46:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so24682758wrs.0;
 Fri, 03 Jul 2020 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=95GtUp0rjOuHEAQu8pVA8GEoFVumJF70xs2/USbgzhs=;
 b=ctE1neGyFm+jUGTPbpIzXRP6KDA+rCKsj1LsxTBCvc+HTwUjeE32WfyE+tb7rXcPAR
 7B5TsJ64yF1PaRbdVStjhfFBOGAE8iOglzHhsdzMxsaQrCbN58zRF58o3qZykyJjrKxE
 LhklVRv0bhJ7YpNkE/CRFCO3MTcwypjJy8PymOvziC6PFN1deWlaQ5ceAse3scZdaHZo
 B/ZATC34yCouGln2yAn6+3d8oZ2O6bLCa0vKLluui7ekJVNWPIJb916fCWpo3Axl/VcL
 dPa5ztTPmqPFHBPZPqz7gCP7JBZtigR0S2Gzf2KhspJarxj4Kb+a0rs9g+9/+nY5DDQi
 fQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=95GtUp0rjOuHEAQu8pVA8GEoFVumJF70xs2/USbgzhs=;
 b=t1Owp7dkxaoDb65j0hh7bsXrJfoJeQwozqjnkb4XckY5fwwcw6APxBnqPhu8Kd9ltY
 M1QHK9v7jWpzLJnmLlEQCvMe1NK+EIQYQ1HqltcfzSJUo1ZJOAcU/cobPVmQ3jO3Ked3
 ZMYoEsDEnkvqAd6t+LH7nMj97yIHFhw/Vc6JgxGR3IyGwlbkJ470RZ1Gxu7vHpvW7gID
 2wfJthDnsZB/aAKStO1ppgniRHhbLi8ENqEYHZ9NZ0NetjZbWedx4wl23J5Ardn1CxYC
 hxZAYzDdlKl/e/6ZThfpwWIe3mB2t2PB2iKSymFkzb0+HOddu1ng+rCxE/ZmXDBolVSU
 QoBQ==
X-Gm-Message-State: AOAM532xh9JYP1Y/fgvO0rWTFac4MrA9KmTdO1lFC1pXLQ3Pts/48xFs
 wiyMzJS1a+vBSFZu3i6O5k4=
X-Google-Smtp-Source: ABdhPJydvXkibzcVFwCGZzKhPlFOAWYbPAeYUHsyIzboNP5K1s7AKkBFIYj2d79VFDWJFTr7FPkc+Q==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr7749936wra.150.1593783972697; 
 Fri, 03 Jul 2020 06:46:12 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b18sm5015209wrs.46.2020.07.03.06.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 06:46:11 -0700 (PDT)
Subject: Re: [PATCH v3 08/12] hw/nvram: NPCM7xx OTP device model
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org,
 clg@kaod.org, joel@jms.id.au
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-9-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <abdb209d-7268-7997-2caa-95cb984269da@amsat.org>
Date: Fri, 3 Jul 2020 15:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626235519.591734-9-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> This supports reading and writing OTP fuses and keys. Only fuse reading
> has been tested. Protection is not implemented.
> 
> Reviewed-by: Avi Fishman <avi.fishman@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  hw/arm/npcm7xx.c               |  32 +++
>  hw/nvram/Makefile.objs         |   1 +
>  hw/nvram/npcm7xx_otp.c         | 391 +++++++++++++++++++++++++++++++++
>  include/hw/arm/npcm7xx.h       |   3 +
>  include/hw/nvram/npcm7xx_otp.h |  93 ++++++++
>  5 files changed, 520 insertions(+)
>  create mode 100644 hw/nvram/npcm7xx_otp.c
>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
> 
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index f395fe84b6..825910a4bf 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -36,6 +36,10 @@
>  #define NPCM7XX_MMIO_BA         (0x80000000)
>  #define NPCM7XX_MMIO_SZ         (0x7FFD0000)
>  
> +/* OTP key storage and fuse strap array */
> +#define NPCM7XX_OTP1_BA         (0xF0189000)
> +#define NPCM7XX_OTP2_BA         (0xF018A000)
> +
>  /* Core system modules. */
>  #define NPCM7XX_L2C_BA          (0xF03FC000)
>  #define NPCM7XX_CPUP_BA         (0xF03FE000)
> @@ -122,6 +126,15 @@ void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_info *info)
>                         NPCM7XX_SMP_LOADER_START);
>  }
>  
> +static void npcm7xx_init_fuses(NPCM7xxState *s)
> +{
> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
> +    uint32_t value;
> +
> +    value = tswap32(nc->disabled_modules);
> +    npcm7xx_otp_array_write(&s->fuse_array, &value, 64, sizeof(value));
> +}
> +
>  static qemu_irq npcm7xx_irq(NPCM7xxState *s, int n)
>  {
>      return qdev_get_gpio_in(DEVICE(&s->a9mpcore), n);
> @@ -142,6 +155,10 @@ static void npcm7xx_init(Object *obj)
>      object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
>                                "power-on-straps");
>      object_initialize_child(obj, "clk", &s->clk, TYPE_NPCM7XX_CLK);
> +    object_initialize_child(obj, "otp1", &s->key_storage,
> +                            TYPE_NPCM7XX_KEY_STORAGE);
> +    object_initialize_child(obj, "otp2", &s->fuse_array,
> +                            TYPE_NPCM7XX_FUSE_ARRAY);
>  
>      for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
>          object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
> @@ -225,6 +242,21 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
>  
> +    /* OTP key storage and fuse strap array */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->key_storage), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->key_storage), 0, NPCM7XX_OTP1_BA);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->fuse_array), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM7XX_OTP2_BA);
> +    npcm7xx_init_fuses(s);
> +
>      /* Timer Modules (TIM) */
>      QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
>      for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> index f3ad921382..0270f0bbf7 100644
> --- a/hw/nvram/Makefile.objs
> +++ b/hw/nvram/Makefile.objs
> @@ -4,5 +4,6 @@ common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
>  common-obj-y += fw_cfg.o
>  common-obj-$(CONFIG_CHRP_NVRAM) += chrp_nvram.o
>  common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
> +common-obj-$(CONFIG_NPCM7XX) += npcm7xx_otp.o
>  common-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
>  obj-$(CONFIG_PSERIES) += spapr_nvram.o
> diff --git a/hw/nvram/npcm7xx_otp.c b/hw/nvram/npcm7xx_otp.c
> new file mode 100644
> index 0000000000..71fc728a2d
> --- /dev/null
> +++ b/hw/nvram/npcm7xx_otp.c
> @@ -0,0 +1,391 @@
> +/*
> + * Nuvoton NPCM7xx OTP (Fuse Array) Interface
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/nvram/npcm7xx_otp.h"
> +#include "qapi/error.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +
> +/* Each module has 4 KiB of register space. Only a fraction of it is used. */
> +#define NPCM7XX_OTP_REGS_SIZE (4 * KiB)
> +
> +/* Register field definitions. */
> +#define FST_RIEN BIT(2)
> +#define FST_RDST BIT(1)
> +#define FST_RDY BIT(0)
> +#define FST_RO_MASK (FST_RDST | FST_RDY)
> +
> +#define FADDR_BYTEADDR(rv) extract32((rv), 0, 10)
> +#define FADDR_BITPOS(rv) extract32((rv), 10, 3)
> +
> +#define FDATA_CLEAR 0x00000001
> +
> +#define FCFG_FDIS BIT(31)
> +#define FCFG_FCFGLK_MASK 0x00ff0000
> +
> +#define FCTL_PROG_CMD1 0x00000001
> +#define FCTL_PROG_CMD2 0xbf79e5d0
> +#define FCTL_READ_CMD 0x00000002
> +
> +static uint8_t ecc_encode_nibble(uint8_t n)
> +{
> +    uint8_t result = n;
> +
> +    result |= (((n >> 0) & 1) ^ ((n >> 1) & 1)) << 4;
> +    result |= (((n >> 2) & 1) ^ ((n >> 3) & 1)) << 5;
> +    result |= (((n >> 0) & 1) ^ ((n >> 2) & 1)) << 6;
> +    result |= (((n >> 1) & 1) ^ ((n >> 3) & 1)) << 7;
> +
> +    return result;
> +}
> +
> +void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
> +                             unsigned int offset, unsigned int len)
> +{
> +    const uint8_t *src = data;
> +    uint8_t *dst = s->array + offset;
> +
> +    while (len-- > 0) {
> +        uint8_t c = *src++;
> +
> +        *dst++ = ecc_encode_nibble(extract8(c, 0, 4));
> +        *dst++ = ecc_encode_nibble(extract8(c, 4, 4));
> +    }
> +}
> +
> +/* Common register read handler for both OTP classes. */
> +static uint64_t npcm7xx_otp_read(NPCM7xxOTPState *s, NPCM7xxOTPRegister reg)
> +{
> +    uint32_t value = 0;
> +
> +    switch (reg) {
> +    case NPCM7XX_OTP_FST:
> +    case NPCM7XX_OTP_FADDR:
> +    case NPCM7XX_OTP_FDATA:
> +    case NPCM7XX_OTP_FCFG:
> +        value = s->regs[reg];
> +        break;
> +
> +    case NPCM7XX_OTP_FCTL:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: read from write-only FCTL register\n",
> +                      DEVICE(s)->canonical_path);
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read from invalid offset 0x%zx\n",
> +                      DEVICE(s)->canonical_path, reg * sizeof(uint32_t));
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +/* Read a byte from the OTP array into the data register. */
> +static void npcm7xx_otp_read_array(NPCM7xxOTPState *s)
> +{
> +    uint32_t faddr = s->regs[NPCM7XX_OTP_FADDR];
> +
> +    s->regs[NPCM7XX_OTP_FDATA] = s->array[FADDR_BYTEADDR(faddr)];
> +    s->regs[NPCM7XX_OTP_FST] |= FST_RDST | FST_RDY;
> +}
> +
> +/* Program a byte from the data register into the OTP array. */
> +static void npcm7xx_otp_program_array(NPCM7xxOTPState *s)
> +{
> +    uint32_t faddr = s->regs[NPCM7XX_OTP_FADDR];
> +
> +    /* Bits can only go 0->1, never 1->0. */
> +    s->array[FADDR_BYTEADDR(faddr)] |= (1U << FADDR_BITPOS(faddr));
> +    s->regs[NPCM7XX_OTP_FST] |= FST_RDST | FST_RDY;
> +}
> +
> +/* Compute the next value of the FCFG register. */
> +static uint32_t npcm7xx_otp_compute_fcfg(uint32_t cur_value, uint32_t new_value)
> +{
> +    uint32_t lock_mask;
> +    uint32_t value;
> +
> +    /*
> +     * FCFGLK holds sticky bits 16..23, indicating which bits in FPRGLK (8..15)
> +     * and FRDLK (0..7) that are read-only.
> +     */
> +    lock_mask = (cur_value & FCFG_FCFGLK_MASK) >> 8;
> +    lock_mask |= lock_mask >> 8;
> +    /* FDIS and FCFGLK bits are sticky (write 1 to set; can't clear). */
> +    value = cur_value & (FCFG_FDIS | FCFG_FCFGLK_MASK);
> +    /* Preserve read-only bits in FPRGLK and FRDLK */
> +    value |= cur_value & lock_mask;
> +    /* Set all bits that aren't read-only. */
> +    value |= new_value & ~lock_mask;
> +
> +    return value;
> +}
> +
> +/* Common register write handler for both OTP classes. */
> +static void npcm7xx_otp_write(NPCM7xxOTPState *s, NPCM7xxOTPRegister reg,
> +                              uint32_t value)
> +{
> +    switch (reg) {
> +    case NPCM7XX_OTP_FST:
> +        /* RDST is cleared by writing 1 to it. */
> +        if (value & FST_RDST) {
> +            s->regs[NPCM7XX_OTP_FST] &= ~FST_RDST;
> +        }
> +        /* Preserve read-only and write-one-to-clear bits */
> +        value =
> +            (value & ~FST_RO_MASK) | (s->regs[NPCM7XX_OTP_FST] & FST_RO_MASK);
> +        break;
> +
> +    case NPCM7XX_OTP_FADDR:
> +        break;
> +
> +    case NPCM7XX_OTP_FDATA:
> +        /*
> +         * This register is cleared by writing a magic value to it; no other
> +         * values can be written.
> +         */
> +        if (value == FDATA_CLEAR) {
> +            value = 0;
> +        } else {
> +            value = s->regs[NPCM7XX_OTP_FDATA];
> +        }
> +        break;
> +
> +    case NPCM7XX_OTP_FCFG:
> +        value = npcm7xx_otp_compute_fcfg(s->regs[NPCM7XX_OTP_FCFG], value);
> +        break;
> +
> +    case NPCM7XX_OTP_FCTL:
> +        switch (value) {
> +        case FCTL_READ_CMD:
> +            npcm7xx_otp_read_array(s);
> +            break;
> +
> +        case FCTL_PROG_CMD1:
> +            /*
> +             * Programming requires writing two separate magic values to this
> +             * register; this is the first one. Just store it so it can be
> +             * verified later when the second magic value is received.
> +             */
> +            break;
> +
> +        case FCTL_PROG_CMD2:
> +            /*
> +             * Only initiate programming if we received the first half of the
> +             * command immediately before this one.
> +             */
> +            if (s->regs[NPCM7XX_OTP_FCTL] == FCTL_PROG_CMD1) {
> +                npcm7xx_otp_program_array(s);
> +            }
> +            break;
> +
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: unrecognized FCNTL value 0x%" PRIx32 "\n",
> +                          DEVICE(s)->canonical_path, value);
> +            break;
> +        }
> +        if (value != FCTL_PROG_CMD1) {
> +            value = 0;
> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write to invalid offset 0x%zx\n",
> +                      DEVICE(s)->canonical_path, reg * sizeof(uint32_t));
> +        return;
> +    }
> +
> +    s->regs[reg] = value;
> +}
> +
> +/* Register read handler specific to the fuse array OTP module. */
> +static uint64_t npcm7xx_fuse_array_read(void *opaque, hwaddr addr,
> +                                        unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +    uint32_t value;
> +
> +    /*
> +     * Only the Fuse Strap register needs special handling; all other registers
> +     * work the same way for both kinds of OTP modules.
> +     */
> +    if (reg != NPCM7XX_OTP_FUSTRAP) {
> +        value = npcm7xx_otp_read(s, reg);
> +    } else {
> +        /* FUSTRAP is stored as three copies in the OTP array. */
> +        uint32_t fustrap[3];
> +
> +        memcpy(fustrap, &s->array[0], sizeof(fustrap));
> +
> +        /* Determine value by a majority vote on each bit. */
> +        value = (fustrap[0] & fustrap[1]) | (fustrap[0] & fustrap[2]) |
> +                (fustrap[1] & fustrap[2]);
> +    }
> +
> +    return value;
> +}
> +
> +/* Register write handler specific to the fuse array OTP module. */
> +static void npcm7xx_fuse_array_write(void *opaque, hwaddr addr, uint64_t v,
> +                                     unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +
> +    /*
> +     * The Fuse Strap register is read-only. Other registers are handled by
> +     * common code.
> +     */
> +    if (reg != NPCM7XX_OTP_FUSTRAP) {
> +        npcm7xx_otp_write(s, reg, v);
> +    }
> +}
> +
> +static const MemoryRegionOps npcm7xx_fuse_array_ops = {
> +    .read       = npcm7xx_fuse_array_read,
> +    .write      = npcm7xx_fuse_array_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,
> +        .unaligned              = false,
> +    },
> +};
> +
> +/* Register read handler specific to the key storage OTP module. */
> +static uint64_t npcm7xx_key_storage_read(void *opaque, hwaddr addr,
> +                                         unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +
> +    /*
> +     * Only the Fuse Key Index register needs special handling; all other
> +     * registers work the same way for both kinds of OTP modules.
> +     */
> +    if (reg != NPCM7XX_OTP_FKEYIND) {
> +        return npcm7xx_otp_read(s, reg);
> +    }
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: FKEYIND is not implemented\n", __func__);
> +
> +    return s->regs[NPCM7XX_OTP_FKEYIND];
> +}
> +
> +/* Register write handler specific to the key storage OTP module. */
> +static void npcm7xx_key_storage_write(void *opaque, hwaddr addr, uint64_t v,
> +                                      unsigned int size)
> +{
> +    NPCM7xxOTPRegister reg = addr / sizeof(uint32_t);
> +    NPCM7xxOTPState *s = opaque;
> +
> +    /*
> +     * Only the Fuse Key Index register needs special handling; all other
> +     * registers work the same way for both kinds of OTP modules.
> +     */
> +    if (reg != NPCM7XX_OTP_FKEYIND) {
> +        npcm7xx_otp_write(s, reg, v);
> +        return;
> +    }
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: FKEYIND is not implemented\n", __func__);
> +
> +    s->regs[NPCM7XX_OTP_FKEYIND] = v;
> +}
> +
> +static const MemoryRegionOps npcm7xx_key_storage_ops = {
> +    .read       = npcm7xx_key_storage_read,
> +    .write      = npcm7xx_key_storage_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,
> +        .unaligned              = false,
> +    },
> +};
> +
> +static void npcm7xx_otp_enter_reset(Object *obj, ResetType type)
> +{
> +    NPCM7xxOTPState *s = NPCM7XX_OTP(obj);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    s->regs[NPCM7XX_OTP_FST] = 0x00000001;
> +    s->regs[NPCM7XX_OTP_FCFG] = 0x20000000;
> +}
> +
> +static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
> +{
> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_GET_CLASS(dev);
> +    NPCM7xxOTPState *s = NPCM7XX_OTP(dev);
> +    SysBusDevice *sbd = &s->parent;
> +
> +    s->array = g_malloc0(NPCM7XX_OTP_ARRAY_BYTES);

The possibility to reuse persistent OTP seems important.
This can be added later of course.

See simple example in hw/nvram/eeprom_at24c.c which use
a BlockBackend so the OTP content is not lost after reset
or migration.

> +
> +    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "regs",
> +                          NPCM7XX_OTP_REGS_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +

Missing migration vmstate for NPCM7xxOTPState::regs[].

> +    dc->realize = npcm7xx_otp_realize;
> +    rc->phases.enter = npcm7xx_otp_enter_reset;
> +}
> +
> +static void npcm7xx_key_storage_class_init(ObjectClass *klass, void *data)
> +{
> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
> +
> +    oc->mmio_ops = &npcm7xx_key_storage_ops;
> +}
> +
> +static void npcm7xx_fuse_array_class_init(ObjectClass *klass, void *data)
> +{
> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_CLASS(klass);
> +
> +    oc->mmio_ops = &npcm7xx_fuse_array_ops;
> +}
> +
> +static const TypeInfo npcm7xx_otp_types[] = {
> +    {
> +        .name = TYPE_NPCM7XX_OTP,
> +        .parent = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(NPCM7xxOTPState),
> +        .class_init = npcm7xx_otp_class_init,
> +        .abstract = true,
> +    },
> +    {
> +        .name = TYPE_NPCM7XX_KEY_STORAGE,
> +        .parent = TYPE_NPCM7XX_OTP,
> +        .class_init = npcm7xx_key_storage_class_init,
> +    },
> +    {
> +        .name = TYPE_NPCM7XX_FUSE_ARRAY,
> +        .parent = TYPE_NPCM7XX_OTP,
> +        .class_init = npcm7xx_fuse_array_class_init,
> +    },
> +};
> +DEFINE_TYPES(npcm7xx_otp_types);
> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> index a241af0b8c..360cd965a7 100644
> --- a/include/hw/arm/npcm7xx.h
> +++ b/include/hw/arm/npcm7xx.h
> @@ -19,6 +19,7 @@
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/misc/npcm7xx_clk.h"
>  #include "hw/misc/npcm7xx_gcr.h"
> +#include "hw/nvram/npcm7xx_otp.h"
>  #include "hw/timer/npcm7xx_timer.h"
>  #include "target/arm/cpu.h"
>  
> @@ -62,6 +63,8 @@ typedef struct NPCM7xxState {
>      NPCM7xxGCRState     gcr;
>      NPCM7xxCLKState     clk;
>      NPCM7xxTimerCtrlState tim[3];
> +    NPCM7xxOTPState     key_storage;
> +    NPCM7xxOTPState     fuse_array;
>  } NPCM7xxState;
>  
>  #define TYPE_NPCM7XX    "npcm7xx"
> diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
> new file mode 100644
> index 0000000000..1127c48fef
> --- /dev/null
> +++ b/include/hw/nvram/npcm7xx_otp.h
> @@ -0,0 +1,93 @@
> +/*
> + * Nuvoton NPCM7xx OTP (Fuse Array) Interface
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +#ifndef NPCM7XX_OTP_H
> +#define NPCM7XX_OTP_H
> +
> +#include "exec/memory.h"
> +#include "hw/sysbus.h"
> +
> +/* Each OTP module holds 8192 bits of one-time programmable storage */
> +#define NPCM7XX_OTP_ARRAY_BITS (8192)
> +#define NPCM7XX_OTP_ARRAY_BYTES (NPCM7XX_OTP_ARRAY_BITS / 8)
> +
> +/**
> + * enum NPCM7xxOTPRegister - 32-bit register indices.
> + */
> +typedef enum NPCM7xxOTPRegister {
> +    NPCM7XX_OTP_FST,
> +    NPCM7XX_OTP_FADDR,
> +    NPCM7XX_OTP_FDATA,
> +    NPCM7XX_OTP_FCFG,
> +    /* Offset 0x10 is FKEYIND in OTP1, FUSTRAP in OTP2 */
> +    NPCM7XX_OTP_FKEYIND = 0x0010 / sizeof(uint32_t),
> +    NPCM7XX_OTP_FUSTRAP = 0x0010 / sizeof(uint32_t),
> +    NPCM7XX_OTP_FCTL,
> +    NPCM7XX_OTP_NR_REGS,
> +} NPCM7xxOTPRegister;
> +
> +/**
> + * struct NPCM7xxOTPState - Device state for one OTP module.
> + * @parent: System bus device.
> + * @mmio: Memory region through which registers are accessed.
> + * @regs: Register contents.
> + * @array: OTP storage array.
> + */
> +typedef struct NPCM7xxOTPState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[NPCM7XX_OTP_NR_REGS];
> +    uint8_t *array;
> +} NPCM7xxOTPState;
> +
> +#define TYPE_NPCM7XX_OTP "npcm7xx-otp"
> +#define NPCM7XX_OTP(obj) OBJECT_CHECK(NPCM7xxOTPState, (obj), TYPE_NPCM7XX_OTP)
> +
> +#define TYPE_NPCM7XX_KEY_STORAGE "npcm7xx-key-storage"
> +#define TYPE_NPCM7XX_FUSE_ARRAY "npcm7xx-fuse-array"
> +
> +/**
> + * struct NPCM7xxOTPClass - OTP module class.
> + * @parent: System bus device class.
> + * @mmio_ops: MMIO register operations for this type of module.
> + *
> + * The two OTP modules (key-storage and fuse-array) have slightly different
> + * behavior, so we give them different MMIO register operations.
> + */
> +typedef struct NPCM7xxOTPClass {
> +    SysBusDeviceClass parent;
> +
> +    const MemoryRegionOps *mmio_ops;
> +} NPCM7xxOTPClass;
> +
> +#define NPCM7XX_OTP_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(NPCM7xxOTPClass, (klass), TYPE_NPCM7XX_OTP)
> +#define NPCM7XX_OTP_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(NPCM7xxOTPClass, (obj), TYPE_NPCM7XX_OTP)
> +
> +/**
> + * npcm7xx_otp_array_write - ECC encode and write data to OTP array.
> + * @s: OTP module.
> + * @data: Data to be encoded and written.
> + * @offset: Offset of first byte to be written in the OTP array.
> + * @len: Number of bytes before ECC encoding.
> + *
> + * Each nibble of data is encoded into a byte, so the number of bytes written
> + * to the array will be @len * 2.
> + */
> +extern void npcm7xx_otp_array_write(NPCM7xxOTPState *s, const void *data,
> +                                    unsigned int offset, unsigned int len);
> +
> +#endif /* NPCM7XX_OTP_H */
> 

