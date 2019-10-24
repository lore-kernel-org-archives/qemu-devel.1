Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42787CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123C620856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123C620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbsD-0004Yl-Nw
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNbCM-0006Ky-7O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNbCK-0006Pp-V0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:22:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNbCK-0006P3-LY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:22:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06DF0757C5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:22:31 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e25so12117665wra.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 04:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ruuFxXL1LpflxoJmVZDBBYvsxawHPfgZFAEmI3wJrgk=;
 b=WeH1UkCqKMbAKVNrOUsVOL4SbcmTPxynAwz8KEXPUCWzafnTzd6a969bu7A5ErjRuc
 MNnrGhJFIkgO2qN28cApyI2mazoaQp/SbIRPSMScXs7GfQctLcUVasJK34Z0C0nz5yNP
 MPao862cqXBtNohhxiE5hLO08rIIyzRdRlH4l9/xVlbPgcsXKaTkRPJGc7Xe6hClMvff
 /7BprgvBUR2TR6Kul3FkohrJigtZf+YTS6y59G4f7oMpOeiof5S5FfEqrIKPeM27pyrb
 zOCOqL2F3/+TEqYDR01uldLtiNyiRjwQU3kaJicddZeCTWljS9Utf/9tx/DjbMlbnJOw
 3WVQ==
X-Gm-Message-State: APjAAAXKRJQa5ZOf3MoaDtZOCtBCstHI70aTBv4u4hD4t9PO4A5Z5W6T
 /VVwS1HyjWQ/kC2nFam0AqEMA2IrQjvkyz2+mGChuQZMjQ8Jai24OwO3BlBGy2aSLhU4r6G9QXw
 cqAF8lO9xc3ZTUJo=
X-Received: by 2002:adf:e446:: with SMTP id t6mr3306634wrm.7.1571916149650;
 Thu, 24 Oct 2019 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjCj4KKrsNYOJg6tbE976jv3LS2JTKvR2RoIknrzobCLCTCwP8bc9pAgCu0SQwaUcsRtYw1A==
X-Received: by 2002:adf:e446:: with SMTP id t6mr3306614wrm.7.1571916149430;
 Thu, 24 Oct 2019 04:22:29 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id r13sm36952734wra.74.2019.10.24.04.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 04:22:28 -0700 (PDT)
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20191010123008.GA19158@amt.cnet>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cc492782-8e5a-5c39-226d-a4e97cabf914@redhat.com>
Date: Thu, 24 Oct 2019 13:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010123008.GA19158@amt.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 2:30 PM, Marcelo Tosatti wrote:
> 
> commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
> reinjection when there is no period change by the guest.
> 
> In that case, old_period is 0, which ends up zeroing irq_coalesced
> (counter of reinjected interrupts).
> 
> The consequence is Windows 7 is unable to synchronize time via NTP.
> Easily reproducible by playing a fullscreen video with cirrus and VNC.
> 
> Fix by not updating s->irq_coalesced when old_period is 0.
> 
> V2: reorganize code (Paolo Bonzini)

^ This line shouldn't be part of git history,
Paolo if possible can you drop it?

> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6cb378751b..0e7cf97042 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -203,24 +203,28 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>   
>       period = rtc_periodic_clock_ticks(s);
>   
> -    if (period) {
> -        /* compute 32 khz clock */
> -        cur_clock =
> -            muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +    if (!period) {
> +        s->irq_coalesced = 0;
> +        timer_del(s->periodic_timer);
> +        return;
> +    }

This is the first change, simplify the if statement with a return.

>   
> -        /*
> -        * if the periodic timer's update is due to period re-configuration,
> -        * we should count the clock since last interrupt.
> -        */
> -        if (old_period) {
> -            int64_t last_periodic_clock, next_periodic_clock;
> -
> -            next_periodic_clock = muldiv64(s->next_periodic_time,
> -                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> -            last_periodic_clock = next_periodic_clock - old_period;
> -            lost_clock = cur_clock - last_periodic_clock;
> -            assert(lost_clock >= 0);
> -        }
> +    /* compute 32 khz clock */
> +    cur_clock =
> +        muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +
> +    /*
> +     * if the periodic timer's update is due to period re-configuration,
> +     * we should count the clock since last interrupt.
> +     */
> +    if (old_period) {
> +        int64_t last_periodic_clock, next_periodic_clock;
> +
> +        next_periodic_clock = muldiv64(s->next_periodic_time,
> +                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +        last_periodic_clock = next_periodic_clock - old_period;
> +        lost_clock = cur_clock - last_periodic_clock;
> +        assert(lost_clock >= 0);
>   
>           /*
>            * s->irq_coalesced can change for two reasons:
> @@ -251,22 +255,19 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>                   rtc_coalesced_timer_update(s);
>               }
>           } else {
> -           /*
> +            /*
>                * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
>                * is not used, we should make the time progress anyway.
>                */
>               lost_clock = MIN(lost_clock, period);
>           }
> +    }

This is the second change, changing the logic and fixing the bug.

>   
> -        assert(lost_clock >= 0 && lost_clock <= period);
> +    assert(lost_clock >= 0 && lost_clock <= period);
>   
> -        next_irq_clock = cur_clock + period - lost_clock;
> -        s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
> -        timer_mod(s->periodic_timer, s->next_periodic_time);
> -    } else {
> -        s->irq_coalesced = 0;
> -        timer_del(s->periodic_timer);
> -    }
> +    next_irq_clock = cur_clock + period - lost_clock;
> +    s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
> +    timer_mod(s->periodic_timer, s->next_periodic_time);

This is part of the 1st change.

I'd rather see this patch split in 2 logical changes...

>   }
>   
>   static void rtc_periodic_timer(void *opaque)
> 
> 

