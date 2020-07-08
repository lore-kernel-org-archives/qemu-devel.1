Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095BB2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy0+DhEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095BB2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt5rL-0001Fk-BP
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 04:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jt5qk-0000iL-5I; Wed, 08 Jul 2020 04:54:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jt5qi-00028Y-Fw; Wed, 08 Jul 2020 04:54:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id 17so2087148wmo.1;
 Wed, 08 Jul 2020 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S1rP8Ms+mBDrZ41IF5ukoxx4o/JG7cf/l3a9EZXKYLc=;
 b=jy0+DhEsGh0xIkYABoe+Yns5+MLNAa9k7wRJ39U3Eth7+d0BAJ7P8Q7aHV0y+8xOqS
 D839IW5qrdLEclqQC7zqIWFFFdnkBUUTUvIHePz5rYhV9ZThcFeOjx3NPtfbso1fyDgU
 PUqFtzsw06BGfga0LWF46TReevRVmgSNDOJNDoHEg7tvQlH0JEsvVymWKvax88qEIUQc
 19L4ioggnU4X7Vne4QKS+gAr9BWRwuhenXNBi+QFhSx6p//XNn7ziXUx9Y5Z4ZzycEES
 7upBlSMovRYVxpY0dJwt6SmMljyNgd9T979ZD4DTWj9Wc1Fn8F+oJJAAEYMZHg2u6cWh
 +d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=S1rP8Ms+mBDrZ41IF5ukoxx4o/JG7cf/l3a9EZXKYLc=;
 b=UP3Dje4sj2wvvs/csSOToVPBswELF7tRX+2TsaYXicZsFgjKFxWzmFmk8k2+QBrrsZ
 ZNMKmChoOvXMqcNLybomUb3bAuD+s0TpwdPUGlCHDIr/p7jYYdBx6dwfcEhVGid1UGNc
 Z2+H2IK1E+RZ1p8Uc/uFl8y/pINh4RDHNeIiG5IMG7wXTngU0cUcAlOifH8x2lHLI2wQ
 o8DNmjBbjDgFr9/jte4dHBIagvKGylvETU8Ijr7sLWZvUs8UVUG9FKP6mWi7iiJDt475
 gsDvma2aeY0dhCUika2ztPXKEYiUckVG32ZcDd6ULURihULt3WmmekJRmpssrXMT6FWY
 QWCw==
X-Gm-Message-State: AOAM530zScRlrgfZ9ogGn/7loiingfVP+Vm6FTLxykOC5t284yJyBvdB
 9TMN3ckbJoMhsauV4o0bgY0=
X-Google-Smtp-Source: ABdhPJyH0tJClY6LRePfXKJRswLprUtJ8WDlXD51bAW3oKfm5RyGO+E/R2PbGFS3MLuhntUtalK35Q==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr8076444wmb.53.1594198478606; 
 Wed, 08 Jul 2020 01:54:38 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a15sm5437328wrh.54.2020.07.08.01.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 01:54:37 -0700 (PDT)
Subject: Re: [PATCH v4 08/12] hw/nvram: NPCM7xx OTP device model
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-9-hskinnemoen@google.com>
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
Message-ID: <f303f648-91a3-b59b-390f-8f25ec7b4ff1@amsat.org>
Date: Wed, 8 Jul 2020 10:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707184730.3047754-9-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> This supports reading and writing OTP fuses and keys. Only fuse reading
> has been tested. Protection is not implemented.
> 
> Reviewed-by: Avi Fishman <avi.fishman@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  hw/arm/npcm7xx.c               |  32 +++
>  hw/nvram/Makefile.objs         |   1 +
>  hw/nvram/npcm7xx_otp.c         | 405 +++++++++++++++++++++++++++++++++
>  include/hw/arm/npcm7xx.h       |   3 +
>  include/hw/nvram/npcm7xx_otp.h |  94 ++++++++
>  5 files changed, 535 insertions(+)
>  create mode 100644 hw/nvram/npcm7xx_otp.c
>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
> 
...
> +static void npcm7xx_init_fuses(NPCM7xxState *s)
> +{
> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
> +    uint32_t value;
> +
> +    value = tswap32(nc->disabled_modules);
> +    npcm7xx_otp_array_write(&s->fuse_array, &value, 64, sizeof(value));

What is magic offset 64 for?

...
> diff --git a/hw/nvram/npcm7xx_otp.c b/hw/nvram/npcm7xx_otp.c
> new file mode 100644
> index 0000000000..18908bc839
> --- /dev/null
> +++ b/hw/nvram/npcm7xx_otp.c
...
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

Trivial to review as:

           value &= ~FST_RO_MASK;
           value |= s->regs[NPCM7XX_OTP_FST] & FST_RO_MASK;

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
...
> diff --git a/include/hw/nvram/npcm7xx_otp.h b/include/hw/nvram/npcm7xx_otp.h
> new file mode 100644
> index 0000000000..b52330dadc
> --- /dev/null
> +++ b/include/hw/nvram/npcm7xx_otp.h
> @@ -0,0 +1,94 @@
> +/*
> + * Nuvoton NPCM7xx OTP (Fuse Array) Interface
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
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

You could replace 8 by BITS_PER_BYTE.

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
> +    uint8_t array[NPCM7XX_OTP_ARRAY_BYTES];
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

If nothing outside of the model implementation requires accessing
the class fields (which is certainly the case here, no code out of
npcm7xx_otp.c should access mmio_ops directly), then I recommend
to keep the class definitions local to the single source file where
it is used. This also makes this header simpler to look at.

Very high code quality, so I just made nitpicking comments.
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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


