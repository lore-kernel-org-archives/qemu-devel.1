Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14911C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BD6207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHv/W2kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BD6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZLM-0004U0-4g
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtZKL-0003fp-Be; Thu, 09 Jul 2020 12:23:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtZKJ-0003wR-Gi; Thu, 09 Jul 2020 12:23:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so2477382wml.3;
 Thu, 09 Jul 2020 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JBNfwnstZejoe/GMZ8w1uNxxtCqPWZLaNZg7PmTT63A=;
 b=ZHv/W2kB1hygRWs2AeiATZOfn93v77MrsfVnvgP1RfSJY7FmS7E0JePACV0FF5LQlr
 k3LTUDZVlaqKksnFwAX68cklQkUf2oqkodgwmQ4kUXtmtUzHpKvoWHxEE0aMLjHs+j/Y
 J/78pjXuR6mUvgp6NTY/beV9tR1bgudSvynSpbnMESXcWL9xpiUjwdsQzRfzgzgVoPuL
 7R0Y4MjRYM4km9E9zhNEkn0nqx0n6eCudshdide5poB+NCmrtwl4kwhTe6Y8mjwVDIcx
 VaBADRbOUut9R5Hbx6N5X1yXf+kF7Ar/6OfCqXksKabnMBN8A6VPN45IvlD+sGLel5Cn
 53jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JBNfwnstZejoe/GMZ8w1uNxxtCqPWZLaNZg7PmTT63A=;
 b=NuBXIkYFtnXZmIIf7mU2a3Sw5yOuIY5w0jsChn2JPcvHziMwPJNhY+qrSzp9jg4Rgi
 CmdCQzo3Q+ibOz1m9ar+nuTSf63/AADK+E50kL7CjS4jO8r2KaQPkyOZ+YVxN1tCBRrq
 buGBhDRuudDi35Ul0X6JEJphW/SCdfb3hFM5GKU2VcTqytYjrh1cxC6wahSnB6mnjl7l
 VEyFu8XcX03iiv+yIQK60DcR+2UUIPH8GXh9l5t12AcZFbArD+hRwoZW33a1H/fpdLvK
 7GCn8CE1s1/Q3zUSkyAtwjAuqEkScVipFbzzpcB2kNt4hYO+E0b7QLSrnGdP2B/PssWr
 ERrw==
X-Gm-Message-State: AOAM530MChLGwof2cdzKBSfuIdQ0/23KmWX2HEiuEJoxcd0O4yheYMvT
 a6x6Wsfzz+sy6WLEwF6f+sM=
X-Google-Smtp-Source: ABdhPJw4bBnSXlPFhHSMbNsxFSFA1TiT9JzCbTSMkD1SpcaBUd22v+H5y3IGwaCi+lBPPZGAtOUBRw==
X-Received: by 2002:a1c:2041:: with SMTP id g62mr793120wmg.172.1594311789348; 
 Thu, 09 Jul 2020 09:23:09 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n16sm5618319wra.19.2020.07.09.09.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 09:23:08 -0700 (PDT)
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
 <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
 <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bd2972b0-0684-e379-6d66-16ceb62deade@amsat.org>
Date: Thu, 9 Jul 2020 18:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRYx99PpWz6bftCvBR7=YRftD_WNex_A9aoDaeRg=4tsCw@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 8:43 AM, Havard Skinnemoen wrote:
> On Wed, Jul 8, 2020 at 11:04 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
>>> Implement a device model for the System Global Control Registers in the
>>> NPCM730 and NPCM750 BMC SoCs.
>>>
>>> This is primarily used to enable SMP boot (the boot ROM spins reading
>>> the SCRPAD register) and DDR memory initialization; other registers are
>>> best effort for now.
>>>
>>> The reset values of the MDLR and PWRON registers are determined by the
>>> SoC variant (730 vs 750) and board straps respectively.
>>>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>> ---
[...]
>>> diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
>>> new file mode 100644
>>> index 0000000000..9934cd238d
>>> --- /dev/null
>>> +++ b/hw/misc/npcm7xx_gcr.c
>>> @@ -0,0 +1,226 @@
>>> +/*
>>> + * Nuvoton NPCM7xx System Global Control Registers.
>>> + *
>>> + * Copyright 2020 Google LLC
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify it
>>> + * under the terms of the GNU General Public License as published by the
>>> + * Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but WITHOUT
>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
>>> + * for more details.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +
>>> +#include "hw/misc/npcm7xx_gcr.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "migration/vmstate.h"
>>> +#include "qapi/error.h"
>>> +#include "qemu/log.h"
>>> +#include "qemu/module.h"
>>> +#include "qemu/units.h"
>>> +
>>> +#include "trace.h"
>>> +
>>> +static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
>>> +    [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
>>> +    [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
>>> +    [NPCM7XX_GCR_SPSWC]         = 0x00000003,
>>> +    [NPCM7XX_GCR_INTCR]         = 0x0000035e,
>>> +    [NPCM7XX_GCR_HIFCR]         = 0x0000004e,
>>> +    [NPCM7XX_GCR_INTCR2]        = (1U << 19),   /* DDR initialized */
>>> +    [NPCM7XX_GCR_RESSR]         = 0x80000000,
>>> +    [NPCM7XX_GCR_DSCNT]         = 0x000000c0,
>>> +    [NPCM7XX_GCR_DAVCLVLR]      = 0x5a00f3cf,
>>> +    [NPCM7XX_GCR_SCRPAD]        = 0x00000008,
>>> +    [NPCM7XX_GCR_USB1PHYCTL]    = 0x034730e4,
>>> +    [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730e4,
>>> +};
>>> +
>>> +static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
>>> +{
>>> +    uint32_t reg = offset / sizeof(uint32_t);
>>> +    NPCM7xxGCRState *s = opaque;
>>> +
>>> +    if (reg >= NPCM7XX_GCR_NR_REGS) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
>>> +                      __func__, (unsigned int)offset);
>>
>> Maybe use HWADDR_PRIx instead of casting to int?
> 
> Will do, thanks!

Glad you are not annoyed by my review comments.

FYI your series quality is in my top-4 "adding new machine to QEMU".
I'd like to use it as example to follow.

I am slowly reviewing because this is not part of my work duties,
so I do that in my free time before/after work, which is why I can
barely do more that 2 per day, as I have to learn the SoC and
cross check documentation (or in this case, existing firmware code
since there is no public doc).

[...]
>>> +static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    NPCM7xxGCRState *s = NPCM7XX_GCR(dev);
>>> +    uint64_t dram_size;
>>> +    Error *err = NULL;
>>> +    Object *obj;
>>> +
>>> +    obj = object_property_get_link(OBJECT(dev), "dram-mr", &err);
>>> +    if (!obj) {
>>> +        error_setg(errp, "%s: required dram-mr link not found: %s",
>>> +                   __func__, error_get_pretty(err));
>>> +        return;
>>> +    }
>>> +    dram_size = memory_region_size(MEMORY_REGION(obj));
>>> +
>>> +    /* Power-on reset value */
>>> +    s->reset_intcr3 = 0x00001002;
>>> +
>>> +    /*
>>> +     * The GMMAP (Graphics Memory Map) field is used by u-boot to detect the
>>> +     * DRAM size, and is normally initialized by the boot block as part of DRAM
>>> +     * training. However, since we don't have a complete emulation of the
>>> +     * memory controller and try to make it look like it has already been
>>> +     * initialized, the boot block will skip this initialization, and we need
>>> +     * to make sure this field is set correctly up front.
>>> +     *
>>> +     * WARNING: some versions of u-boot only looks at bits 8 and 9, so 2 GiB or
>>> +     * more of DRAM will be interpreted as 128 MiB.
>>
>> I'd say u-boot is right in wrapping at 2GB, as more DRAM is
>> un-addressable.
> 
> Ah, maybe I shouldn't have said "or more". The bug is that if you
> specify _exactly_ 2GiB, u-boot will see 128 MiB.
> 
> But I agree more than 2GiB doesn't make sense, so I'll add a check for that.
> 
> Not sure if I agree that the check should be here. > 2 GiB is an
> addressing limitation, and the GCR module shouldn't really know what
> the SoC's address space looks like. The lower limit is because the GCR
> module can't encode anything less than 128 MiB.
> 
>>> +     *
>>> +     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
>>> +     */
>>> +    if (dram_size >= 2 * GiB) {
>>
>> See my comment in this series on the machine patch.
>>
>>> +        s->reset_intcr3 |= 4 << 8;
>>> +    } else if (dram_size >= 1 * GiB) {
>>> +        s->reset_intcr3 |= 3 << 8;
>>> +    } else if (dram_size >= 512 * MiB) {
>>> +        s->reset_intcr3 |= 2 << 8;
>>> +    } else if (dram_size >= 256 * MiB) {
>>> +        s->reset_intcr3 |= 1 << 8;
>>> +    } else if (dram_size >= 128 * MiB) {
>>> +        s->reset_intcr3 |= 0 << 8;

I think this can be simplified as:

         s->reset_intcr3 = (4 - clz32(dram_size)) << 8;

Which implicitly truncate to power of 2 (which is what this
block does, as you can have only 1 bank managed per this SGC).

But checking is_power_of_2(dram_size) and reporting an error
else, is probably even better.

>>> +    } else {
>>> +        error_setg(errp,
>>> +                   "npcm7xx_gcr: DRAM size %" PRIu64
>>> +                   " is too small (need 128 MiB minimum)",
>>> +                   dram_size);
>>
>> Ah, so you could add the same error for >2GB. Easier.
>>
>> Preferably using HWADDR_PRIx, and similar error for >2GB:
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

