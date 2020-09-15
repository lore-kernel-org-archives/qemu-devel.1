Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F61C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DB1208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psg9Dzps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DB1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIExh-0004J1-19
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIEgO-0002hH-EK; Tue, 15 Sep 2020 13:23:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIEgK-00040d-Po; Tue, 15 Sep 2020 13:23:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id o5so4111279wrn.13;
 Tue, 15 Sep 2020 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qp7N7QxO8l5yd/m+RHUvnhfQp46w82pPPeIeGC4A7cQ=;
 b=Psg9DzpslwoM2iu5BlzdM7w7nz98OCoE9JoYU8AmsZvNUt1LRZ3Wc3FsSc7SxPQTCM
 GZymX/AJ+wWzu/4B3Zd+uST3C5xHOAwmgNBY/i5znPt+T8Xi7S33/L/ASxk1KXUc335l
 nSPOw0UHPG2fK4RJivdXeZNxHR4fTFFglUk/MACvlqxVST2bpMXQsePSSgrc0pzmLFJT
 ++qeSATykKyBo3/AdpuBdjr0Jx5bUF4aL3O/27GDV9QGbNf/5J32Epoz0n75I89SkMSA
 m1EhAHuO3wxvelfE8DKRp/Vry8J/7ZPTf/7Y1r7xyZ1rGfaLk1XW2M8iXrnk8+XYwOHI
 dp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qp7N7QxO8l5yd/m+RHUvnhfQp46w82pPPeIeGC4A7cQ=;
 b=LToCxuUkmynNJuQxUgMzo2XjUw1QWQfoqinCT9VbDh1ac7lJnWXqsmSwuGtui0uSaO
 r/oDmcaExJEd6FD3tdLb+wl0r8Xdb+HpdoY7YKGN0u6aAd9sP68Md3DvnSxP9qJ1VASv
 Y8zUNnFTiR4inLeYtQ7w9Mb8rOQBfpwGcN1IRcz5rTGVtar3RgdLqZnovJlri1+pT17S
 ayFwhDq6n5v7o7vj20Kewe6/YuJVUIA61QAJqxeWyiPGRo/G7mW/R3bbHL0VECfg72Cw
 dIln65oNL0/HiWgFrsh/gsfkwVAjXbmWIoEuX8xv3EQnyCx6m4ntqC03HRnX8bVGJp/b
 T5VQ==
X-Gm-Message-State: AOAM531FV5GLf+8Ss7CbGctYtpN1sD0mcypFH0Aln1AbEv9/r4EktNXD
 uhzJDq9ZM+dzOoFxeSBKGzA=
X-Google-Smtp-Source: ABdhPJyBpPvkm3HE+yiKI4bxECKbb7D8ykJX0L8hU4yCWMLsYg6F1DdW/QWOXixZcM+D7XMn8jxeSA==
X-Received: by 2002:adf:eecb:: with SMTP id a11mr22810464wrp.356.1600190629749; 
 Tue, 15 Sep 2020 10:23:49 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v6sm27577421wrt.90.2020.09.15.10.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:23:49 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/aspeed: Map the UART5 device unconditionally
To: qemu-devel@nongnu.org
References: <20200905212415.760452-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e640309b-b694-e815-d64d-40dd453e52ef@amsat.org>
Date: Tue, 15 Sep 2020 19:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200905212415.760452-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 9/5/20 11:24 PM, Philippe Mathieu-Daudé wrote:
> The UART5 is present on the machine regardless there is a
> character device connected to it. Map it unconditionally.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/aspeed_ast2600.c | 8 +++-----
>  hw/arm/aspeed_soc.c     | 8 +++-----
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 9d95e421435..1450bde7cf2 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -325,11 +325,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* UART - attach an 8250 to the IO space as our UART5 */
> -    if (serial_hd(0)) {
> -        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
> -        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
> -                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> -    }
> +    serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
> +                   aspeed_soc_get_irq(s, ASPEED_DEV_UART5),
> +                   38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>  
>      /* I2C */
>      object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 35be126db6f..7eefd54ac07 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -283,11 +283,9 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* UART - attach an 8250 to the IO space as our UART5 */
> -    if (serial_hd(0)) {
> -        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
> -        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
> -                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> -    }
> +    serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
> +                   aspeed_soc_get_irq(s, ASPEED_DEV_UART5), 38400,
> +                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
>  
>      /* I2C */
>      object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
> 

