Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB8EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4E22067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4E22067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXuj-0006j9-NQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIXfm-00017q-PM
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIXfl-0002Oi-KV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:36:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIXfl-0002OT-CF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:36:01 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E4E9612A4
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 12:36:00 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o10so2682741wrm.22
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 05:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=asHo5mBKpjRpk1FQDS5Jp/Sf3xrGfza1k2thjaSjJAw=;
 b=NrnKNskKWizeIYcS+cV2CLRF/VipBtDgwRnvHFwp43g0mcmTM+CIddT8o7apd7dQO2
 Fe4Goia4+8vbxB+dqp6fCFbD3/PsKWt1p+uMJuuhjlog69pDP9fCxtlM9IkbG9loLsSx
 Edi1YHnS75A++hzaObZX8vG/WotkF7U9iuRLWziszjaXQCAPVviD+/sE8B1TLE7Z6Sb9
 MbigW+ylP9GlPGA7r9XuLC3fHT9NDQ8OdlynRLYQ2OqsZ34o21I98b6dseYEoHsf6nVf
 daF5vPoq+kaTtZxhyWNsE18Z6ud7PalACf4Ja7acl+WXMT9R7BXEQMYoks6QUOfqEW9E
 9HCA==
X-Gm-Message-State: APjAAAVK5HmRCcpaAOSufZH4ahcG5MRXFeCaEb4UcNUaZIaJ2hkru7DX
 7jT76JsMQkg8zYFWcfITvewv2UfM99gnKt29bHxVV2KEJdxuvtIFF+S9rCHk1Listrq/Wl5BBiV
 dFkACne8wPmmkGwU=
X-Received: by 2002:adf:fcd2:: with SMTP id f18mr2089806wrs.388.1570710959065; 
 Thu, 10 Oct 2019 05:35:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1Hg8/kFjo3a2c+x/O5jxcRhZjf5GkzZbtJVVE6dKp5zLcZcllX3U8vcq+yMOYXKv2pyAj/A==
X-Received: by 2002:adf:fcd2:: with SMTP id f18mr2089787wrs.388.1570710958766; 
 Thu, 10 Oct 2019 05:35:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id r13sm8685116wrn.0.2019.10.10.05.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 05:35:58 -0700 (PDT)
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20191010123008.GA19158@amt.cnet>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3d2338c1-a7b6-9281-4db5-16278165c751@redhat.com>
Date: Thu, 10 Oct 2019 14:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010123008.GA19158@amt.cnet>
Content-Type: text/plain; charset=utf-8
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
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 14:30, Marcelo Tosatti wrote:
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
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6cb378751b..0e7cf97042 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -203,24 +203,28 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>  
>      period = rtc_periodic_clock_ticks(s);
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
>          /*
>           * s->irq_coalesced can change for two reasons:
> @@ -251,22 +255,19 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
>                  rtc_coalesced_timer_update(s);
>              }
>          } else {
> -           /*
> +            /*
>               * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
>               * is not used, we should make the time progress anyway.
>               */
>              lost_clock = MIN(lost_clock, period);
>          }
> +    }
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
>  }
>  
>  static void rtc_periodic_timer(void *opaque)
> 

Queued, thanks.

Paolo

