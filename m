Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D0C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8562064C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPvt0Rbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8562064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlCi-0002dw-Dd
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOlAW-0000Nx-6w
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:18:00 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOlAT-0000M1-Rf
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:17:59 -0400
Received: by mail-ot1-x341.google.com with SMTP id a2so4529354otr.11
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ps1yBSWRLshT21UqWJvkNa3TNt4oEyDKJhmb+3Q/taM=;
 b=DPvt0Rbzm3oaBnyIqelVN9Ixm9DuhZti9e7s3itN8weWeUuwsBOIsNBBVBZHQE5wbY
 1QH+gKEc6MzaJcbNX7o/kT8zluA95MIopharzt9fM9xa9LJD28YQkwZiuC0FMsPluDEF
 /C0AxD3540BYbaWkw71+elvmjbYYnhmebfiMvuWrf8TEIKYfTBhriE6uCV2vQDLYFCZs
 OtB2SCdNKcrtWoC/mO4Q9zh7EMZKIqvOrEUPauKrcOnz7ZgbCAbnF0cUWvRZ6BUIOcbG
 hKfhhA3jzf+RSHVUvEgQE76MrN1y14QLG5zhaU/sI08womhas/NoBXvTyrPyFJDzVFsp
 DoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ps1yBSWRLshT21UqWJvkNa3TNt4oEyDKJhmb+3Q/taM=;
 b=VBHv8bvDNFsa81MGFEeBIMPsZigC66Uzuev2pfHDyhQkvdIDWp8gteaDDm5zsTh42p
 x3jiYj2JLBdOx1k4jGzJYpXIPjJGlRq5E6tyqj7ZeiCnEi9SG3VMKd8i/t/wANi3TsZD
 Qu0sjLMuxYWguyGAHCQfMAUUaRSavqfFpl695nqx2hP4fJw8ERufjDdwZM4vZxdsUXV5
 ihtv3Q4636dV52QHs/qNbhA6Z8Imk1cXfYn449nwr32Z51eUai1VQJ4sW/McFNrzwIC4
 58YD68FFUZA57tkJ2wctN0Baxsvf62X+FljsyTNUqBDdC+h3AyAC1YpRrezn3D2OTwTv
 9sLA==
X-Gm-Message-State: AOAM530HLdCtNB+bGDGwB4clnLpmpTosWkmi9TyXbFcB+d82UKKHplXh
 oMRKyfdA+ErgkafXNg85Wv++eA==
X-Google-Smtp-Source: ABdhPJzVGPrzEaicaTEKLeCXow6pFh16AJlY6y4uZKYgLOKOB9hSjMiiNBKmr7i2d5lbxbbituUppQ==
X-Received: by 2002:a9d:70cb:: with SMTP id w11mr5720973otj.222.1601745475995; 
 Sat, 03 Oct 2020 10:17:55 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id j1sm1088387oii.5.2020.10.03.10.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:17:55 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] hw/timer/bcm2835: Support the timer COMPARE
 registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201002164216.1741110-1-f4bug@amsat.org>
 <20201002164216.1741110-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c47c8248-0bfe-5747-1ec1-073fb755f039@linaro.org>
Date: Sat, 3 Oct 2020 12:17:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002164216.1741110-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.252,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:42 AM, Philippe Mathieu-Daudé wrote:
> @@ -78,16 +71,29 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
>                                   uint64_t value, unsigned size)
>  {
>      BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
> +    int index;
> +    uint64_t now;
> +    uint64_t triggers_delay_us;
>  
>      trace_bcm2835_systmr_write(offset, value);
>      switch (offset) {
>      case A_CTRL_STATUS:
>          s->reg.ctrl_status &= ~value; /* Ack */
> -        bcm2835_systmr_update_irq(s);
> +        for (index = 0; index < ARRAY_SIZE(s->tmr); index++) {
> +            if (extract32(value, index, 1)) {
> +                trace_bcm2835_systmr_irq_ack(index);
> +                qemu_set_irq(s->tmr[index].irq, 0);
> +            }

I think it might be instructive to have the parameter be uint64_t value64, and
the immediately do

    uint32_t value = value64;

That matches up better with extract32, the trace arguments...

> +        }
>          break;
>      case A_COMPARE0 ... A_COMPARE3:
> -        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
> -        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
> +        index = (offset - A_COMPARE0) >> 2;
> +        s->reg.compare[index] = value;
> +        now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
> +        /* Compare lower 32-bits of the free-running counter. */
> +        triggers_delay_us = value - (now & UINT32_MAX);
> +        trace_bcm2835_systmr_run(index, triggers_delay_us);
> +        timer_mod(&s->tmr[index].timer, now + triggers_delay_us);

... and here.

Also, the arithmetic looks off.

Consider when you want a long timeout, and pass in a value slightly below now.
 So, e.g.

  now   = 0xabcdffffffff;
  value = 0x0000fffffffe;

since triggers_delay_us is uint64_t, that comparison becomes

  triggers_delay_us = 0x0000fffffffe - 0xffffffff;
                    = 0xffffffffffffffff;

Then you add back in now, and do *not* get a value in the future:

    now + triggers_delay_us
  = 0xabcdffffffff + 0xffffffffffffffff
  = 0xabcdfffffffe

What I think you want is

  uint32_t triggers_delay_us = value - now
                             = 0xffffffff;

which then zero-extends when you add back to now to get

    now + triggers_delay_us
  = 0xabcdffffffff + 0xffffffff
  = 0xabcefffffffe

which is indeed in the future.


r~

