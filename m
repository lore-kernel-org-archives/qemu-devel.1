Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E410EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DDB2065E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 07:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajm8Lc7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DDB2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbho-0006in-0P
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 03:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvbgX-0005ne-FF; Wed, 15 Jul 2020 03:18:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvbgV-0002lq-T3; Wed, 15 Jul 2020 03:18:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id f2so1259142wrp.7;
 Wed, 15 Jul 2020 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tPRfIHYBCLSHUQQYdoXn/o+8FuLFRh89JGPXI8rPcus=;
 b=ajm8Lc7JSOQLz2FQHUKVV+CXU+YKx4MNANkhGqbrcIxL93dfJQXd5vl8lfl9AuLlfQ
 9lQixd6DjnQZWMKTg7v/p8OVlm+cvk0i2LoP3dmrnxYUTvn4zZh8J4nzrMSy6hUuzf0l
 XET+kDKSsfwPbwenVGdF0mjacGaIy5cgI6rdgSd4ph4AFXG+gi0qh6z8/o4iPWXwk15U
 DQf8OZUT2+ICACAcSb/4P4+GV3lga+5Xxp8H2A1cio6NMHPK8bzThtrIla4kgMvVjcO3
 Hj/nMfYxPIKGf2YtPcQbxKUPbTaaYKIbisf2956jhUroDXU/p8l8OD0RyAUHELudo+Bw
 B2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tPRfIHYBCLSHUQQYdoXn/o+8FuLFRh89JGPXI8rPcus=;
 b=rUwj2zbJEZVPPZ5J5Xt2LGDUX3aQiqUNZ/eazzzKXM3Wi/+JiZuC190JIUDkAWGPbq
 3HPG9oLl6lx1WY8nUWSnw+ER5JVy7cG/aEHruJ/8PWsOiunc1xhFUWdd6GG1bcNfmhBH
 2DBNbJdxhtqi3vfxpesNADrfDhhlImsFkIB2vJvHI5F77utGmwGeAf0l3WZERY6FbCTN
 gCpb6Ld/j7972zqZxRvmtGQmZMRmZ/cbKNnvZmCgnWS4HWqv1varsVlKMBhiYnSVjXLj
 Fg1bqL4px66/Dn7Vo9vWkQlLvX608eLFgY7+azOSYdNF7M/TcDVeg+G4DLwDEfAieRa3
 ONuw==
X-Gm-Message-State: AOAM5324unTwcJ4r7oqUvqOq5KLMLxS8Q9nXY7+goduHcM2nwVOXS2w+
 CPUacgxcJJzzLVOyH6EubLs=
X-Google-Smtp-Source: ABdhPJwqqw3m++VWYmRNe8m6rORjvp1Ywy+bnLIhSH/9FegWEFWTj62e7Jfwezl4vejvCPSjCNrbYA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr9541090wrv.162.1594797510006; 
 Wed, 15 Jul 2020 00:18:30 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t16sm2209497wru.9.2020.07.15.00.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 00:18:28 -0700 (PDT)
Subject: Re: [PATCH v5 02/11] hw/misc: Add NPCM7xx Clock Controller device
 model
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-3-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f0f730a5-d110-ec6a-7592-7c0f969c6422@amsat.org>
Date: Wed, 15 Jul 2020 09:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709003608.3834629-3-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Avi.Fishman@nuvoton.com, qemu-devel@nongnu.org, kfting@nuvoton.com,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> Enough functionality to boot the Linux kernel has been implemented. This
> includes:
> 
>   - Correct power-on reset values so the various clock rates can be
>     accurately calculated.
>   - Clock enables stick around when written.
> 
> In addition, a best effort attempt to implement SECCNT and CNTR25M was
> made even though I don't think the kernel needs them.
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  include/hw/misc/npcm7xx_clk.h |  66 ++++++++++
>  hw/misc/npcm7xx_clk.c         | 230 ++++++++++++++++++++++++++++++++++
>  hw/misc/Makefile.objs         |   1 +
>  hw/misc/trace-events          |   4 +
>  4 files changed, 301 insertions(+)
>  create mode 100644 include/hw/misc/npcm7xx_clk.h
>  create mode 100644 hw/misc/npcm7xx_clk.c
> 
...

> +static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint32_t reg = offset / sizeof(uint32_t);
> +    NPCM7xxCLKState *s = opaque;
> +    int64_t now_ns;
> +    uint32_t value = 0;
> +
> +    if (reg >= NPCM7XX_CLK_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
> +                      __func__, (unsigned int)offset);
> +        return 0;
> +    }
> +
> +    switch (reg) {
> +    case NPCM7XX_CLK_SWRSTR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is write-only\n",
> +                      __func__, (unsigned int)offset);
> +        break;
> +
> +    case NPCM7XX_CLK_SECCNT:
> +        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        value = (now_ns - s->ref_ns) / NANOSECONDS_PER_SECOND;
> +        break;
> +
> +    case NPCM7XX_CLK_CNTR25M:
> +        now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        /*
> +         * This register counts 25 MHz cycles, updating every 640 ns. It rolls
> +         * over to zero every second.
> +         *
> +         * The 4 LSBs are always zero: (1e9 / 640) << 4 = 25000000.
> +         */
> +        value = (((now_ns - s->ref_ns) / 640) << 4) % 25000000;

Can we declare NPCM7XX_TIMER_REF_HZ in hw/misc/npcm7xx_clk.h and
have the timer device include hw/misc/npcm7xx_clk.h?

> +        break;
> +
> +    default:
> +        value = s->regs[reg];
> +        break;
> +    };
> +
> +    trace_npcm7xx_clk_read(offset, value);
> +
> +    return value;
> +}
...

