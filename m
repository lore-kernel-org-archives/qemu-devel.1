Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18772C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726B12072D
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwrjKWBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726B12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLIK-0005NE-Fv
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLHI-0004Wu-Df; Sat, 10 Oct 2020 16:15:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLHG-00042I-Qr; Sat, 10 Oct 2020 16:15:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id e18so14110217wrw.9;
 Sat, 10 Oct 2020 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LBE05g7IdbV23Wdt7K0EmKgnkuyxkVQqPxBmzbPRSak=;
 b=uwrjKWBsxlNTnMBbElRIrTNRR+pwgM62B0F4V11CK2VVPUNiJWTK+0QedQVoCdX6+6
 qdEB5iwwFDo2Az8mTFIJctQV+KgyOcFVxRz4QG4Tf196iZdlXf7Ys8JQTtH2CUg04KKo
 JaiZK6SICrw/k0pp0xJB0iDlV21NfmqoYuoNSLvLbVbGBEg5xzWKHNo1WqHhwDj1s05U
 Knf1gjVVh4uTqn+M0OojNiEQoA67EYKMSm/mJeuV27Lf+RV2ShzqI91tmAuc2qU48Jup
 nbIDhColfjlYh+GNMSB66brBB6ewcTesi3PTrGAzdowXMJ6LkbKaY9rsgIlXZTQpvIZu
 6ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LBE05g7IdbV23Wdt7K0EmKgnkuyxkVQqPxBmzbPRSak=;
 b=J2ZcwULFXmCkb5PeZE0exovr7FPaOPNoQ0QK5HT5q1tqKR7db+CrSyBLvIatVkSjnE
 2FvJZ6r6tOvYmdoffjjHUYjLHBJnCWMjuaJBYSCCDR/QiuOlWrPX4JiQqnlXsM27JnSu
 RpaiU4xsBOKa8+go+jtAMb0us9tCpDggbj8Iu0G3lUhPZj8dw9UhRwNSjQiRA27i3vaQ
 wC8qEK7Sj84PpJZlo9xmW5qNwm+FviSP6XyIyLNv5+9g+CvOeLaxD9DRu8bCFlmrSQb3
 B5YWDmDAWhwhHQL5ED+lCyTaNMASaSEZrKXxW/BpqlTI4h0qsG4xGKQL5DdBuN9KD4Qr
 nmrA==
X-Gm-Message-State: AOAM532J7uDZ+RTPvyPGbyMCjHqjKrsOBpr16++IIqM/5jHcBQNKozTS
 tr1ykbzTCUjM3FvtTipvtHI8qU548Mc=
X-Google-Smtp-Source: ABdhPJzUL2yrXgT4tZq3LCMBo8caEqOkJihRwDvg11ixFGpf+Wc7QYDsoWhPBGqNp/P1HOEazkmy3g==
X-Received: by 2002:adf:8285:: with SMTP id 5mr20790431wrc.330.1602360936071; 
 Sat, 10 Oct 2020 13:15:36 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i14sm19351867wro.96.2020.10.10.13.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 13:15:35 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] hw/timer/bcm2835: Support the timer COMPARE
 registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201002164216.1741110-1-f4bug@amsat.org>
 <20201002164216.1741110-4-f4bug@amsat.org>
 <c47c8248-0bfe-5747-1ec1-073fb755f039@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <640df684-0df2-8441-a076-a5bfa15fe607@amsat.org>
Date: Sat, 10 Oct 2020 22:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <c47c8248-0bfe-5747-1ec1-073fb755f039@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
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

On 10/3/20 7:17 PM, Richard Henderson wrote:
> On 10/2/20 11:42 AM, Philippe Mathieu-Daudé wrote:
>> @@ -78,16 +71,29 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
>>                                    uint64_t value, unsigned size)
>>   {
>>       BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
>> +    int index;
>> +    uint64_t now;
>> +    uint64_t triggers_delay_us;
>>   
>>       trace_bcm2835_systmr_write(offset, value);
>>       switch (offset) {
>>       case A_CTRL_STATUS:
>>           s->reg.ctrl_status &= ~value; /* Ack */
>> -        bcm2835_systmr_update_irq(s);
>> +        for (index = 0; index < ARRAY_SIZE(s->tmr); index++) {
>> +            if (extract32(value, index, 1)) {
>> +                trace_bcm2835_systmr_irq_ack(index);
>> +                qemu_set_irq(s->tmr[index].irq, 0);
>> +            }
> 
> I think it might be instructive to have the parameter be uint64_t value64, and
> the immediately do
> 
>      uint32_t value = value64;
> 
> That matches up better with extract32, the trace arguments...
> 
>> +        }
>>           break;
>>       case A_COMPARE0 ... A_COMPARE3:
>> -        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
>> -        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
>> +        index = (offset - A_COMPARE0) >> 2;
>> +        s->reg.compare[index] = value;
>> +        now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
>> +        /* Compare lower 32-bits of the free-running counter. */
>> +        triggers_delay_us = value - (now & UINT32_MAX);
>> +        trace_bcm2835_systmr_run(index, triggers_delay_us);
>> +        timer_mod(&s->tmr[index].timer, now + triggers_delay_us);
> 
> ... and here.
> 
> Also, the arithmetic looks off.
> 
> Consider when you want a long timeout, and pass in a value slightly below now.
>   So, e.g.
> 
>    now   = 0xabcdffffffff;
>    value = 0x0000fffffffe;
> 
> since triggers_delay_us is uint64_t, that comparison becomes
> 
>    triggers_delay_us = 0x0000fffffffe - 0xffffffff;
>                      = 0xffffffffffffffff;
> 
> Then you add back in now, and do *not* get a value in the future:
> 
>      now + triggers_delay_us
>    = 0xabcdffffffff + 0xffffffffffffffff
>    = 0xabcdfffffffe

Thanks for the example of wrong behavior...

> 
> What I think you want is
> 
>    uint32_t triggers_delay_us = value - now
>                               = 0xffffffff;
> 
> which then zero-extends when you add back to now to get
> 
>      now + triggers_delay_us
>    = 0xabcdffffffff + 0xffffffff
>    = 0xabcefffffffe
> 
> which is indeed in the future.

... and the correct one :)

I'll correct as suggested.

Thanks!

Phil.

