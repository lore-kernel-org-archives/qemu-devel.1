Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D9A2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5GQUK9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D9A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2cEu-0005Ox-T6
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 11:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2cE8-0004lP-7w; Mon, 03 Aug 2020 11:18:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2cE6-0003dN-LO; Mon, 03 Aug 2020 11:18:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id q76so14583417wme.4;
 Mon, 03 Aug 2020 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z4xmMsWQD2mqAdPtcjUp/ocEU61w6F+BQekxWvaMzSk=;
 b=q5GQUK9aSFTwVOwwVPlwIyaJcQDyJst4okn+3ZPQgZ85zQPgDc2H45E7Vwkv4sLghn
 pe+pOIIclhkH3zVxjWrRB1SUQZUt7ZKjl7dNwpvbUIpGoZe6l6H2mt/KszW0fc8+HMp8
 Y0bF8dDjZYkgQPsIop5WwbqkEI8bMTZLH/vpG/6btXWZGogaGLZHQSri2xd7MxYkyAd7
 xi5ZC1X8kQ/3tYrinSgqeUorhxfWoW3i3muooFloJlly0xFl1XTO95FUOwG6DFQtrRTS
 nIqclwhuwSIJQXqtoz0GQy/Xzou6oqr7ps+IKOEFMrYQzA83lIHURKKm9NnuSuVu3UTX
 oLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z4xmMsWQD2mqAdPtcjUp/ocEU61w6F+BQekxWvaMzSk=;
 b=r6cOFwT64wToyIw/SBphEhn4iMjHhz2TYVf9ifrWznyfs07+H/iM75uIRaWmpOS7wL
 XPfgLjnIcgu57OvTBtZDmymEqSOMrzG8BTnsal3Su9Cx2ozzw+46C6APXmgBShSnuena
 YRXHMMvQIk2uLL/DLGMJhJLX2n1uWQadKPCAmDNVBrTvPrhAG1yGnSKSyjpEeHrbdsYA
 h8CXWmVo3/SpwR4MqlfUFnAnuLvfesQquwnOp3UCz5PPus/0jZbfmZrFZh23wBajr2Qy
 loUdyN1NNHD4eu1v8JHwhsj6qZk5s3/njdoBUCNQpLIZ1TQsOg4y4ZVQBWmJPfczLpQX
 vmSA==
X-Gm-Message-State: AOAM5336zaaZiuEds4yhE95q0Zz/5HKqYgPALibG2pKR//Zq5iQu6kO3
 2aPw/6/1xSdy45zFNO38NsU=
X-Google-Smtp-Source: ABdhPJzBleYecCexi+qXckgc9gxOqfB77uIX8UPk8G/s1vwz4EbTzJdYdR9LD+3zCdWqonfFyKy8xw==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr447428wma.158.1596467886674; 
 Mon, 03 Aug 2020 08:18:06 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id 31sm26165909wrj.94.2020.08.03.08.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 08:18:05 -0700 (PDT)
Subject: Re: [PATCH for-5.1] hw/arm/nrf51_soc: Set system_clock_scale
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200727193458.31250-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <229f73f2-941c-eed9-ae60-075410345ec1@amsat.org>
Date: Mon, 3 Aug 2020 17:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200727193458.31250-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 9:34 PM, Peter Maydell wrote:
> The nrf51 SoC model wasn't setting the system_clock_scale
> global.which meant that if guest code used the systick timer in "use
> the processor clock" mode it would hang because time never advances.
> 
> Set the global to match the documented CPU clock speed for this SoC.
> 
> This SoC in fact doesn't have a SysTick timer (which is the only thing
> currently that cares about the system_clock_scale), because it's
> a configurable option in the Cortex-M0. However our Cortex-M0 and
> thus our nrf51 and our micro:bit board do provide a SysTick, so
> we ought to provide a functional one rather than a broken one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested with 'make check'/'make check-acceptance' only.
> 
>  hw/arm/nrf51_soc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 45e6cc97d70..e15981e019f 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -32,6 +32,9 @@
>  
>  #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
>  
> +/* HCLK (the main CPU clock) on this SoC is always 16MHz */
> +#define HCLK_FRQ 16000000
> +
>  static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
>  {
>      qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
> @@ -65,6 +68,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>          return;
>      }
>  
> +    system_clock_scale = NANOSECONDS_PER_SECOND / HCLK_FRQ;

So nice when the datasheet is available, and even listed at the top of
the file!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>      object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->container),
>                               &error_abort);
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
> 

