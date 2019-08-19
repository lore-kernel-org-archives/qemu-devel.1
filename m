Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4FBC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0079E2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0079E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzlCd-0005W6-42
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzlC1-00056F-7b
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzlBz-0002mX-V0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzlBz-0002mF-NC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:11:39 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B16378125C
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 17:11:38 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f9so5561016wrq.14
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 10:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S+gPQdpjHg1nC1ohM0yJPgqVs8t1VA5su8rnANAtoLI=;
 b=LkfQUCBDg++VlmJDccmtz3Ckxe0iQaJdjij+0DjotOARjkwNTYh5aM4eXSrnaXTjHI
 5kVE+j+k6mYfhfEktQLR1eQ489YFzCLvAm64xwJqCSvpa23wHN8qldb9J7IvHqAvipwi
 DRQbqrbQgWtkjJxHhhHYXBneZnUhicLkVFJtYQWw5qxLv7G3QBYzjqDfYagVz+6RPTYD
 MH5kKES5aTklT1yH+HjpPSNwAAA0m1ifsPTXmSOwHnS8jGNZxeOY093oeISD8rtQwhlf
 wNtp66ReEkG7ZqXVASxpc8xX7R4/BAflyNtQ5Tb3d/jobhAjwti5mkTdjFp+ubgCu3Ug
 Bs6Q==
X-Gm-Message-State: APjAAAV0BfM9Phv9stq2j6q6jhFXHtXusuCLQ5CUMmXfB0CuTyoHaPop
 WhMiSNZvPMN6fSe9gPXu2rgH7mMq84q6b8KhK56vGJiate9RttQ6kJa9Yo7fxlX7yzQEJtt3p+3
 owQ9vpuPsNhOkTgA=
X-Received: by 2002:adf:f04d:: with SMTP id t13mr28666369wro.133.1566234697254; 
 Mon, 19 Aug 2019 10:11:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWDUFamJ6CPwvgPV0lsCHdIqt3xLAow4f128YKsYRhCIgY3+5hME476Zjn290KYEsloaYTLg==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr28666348wro.133.1566234696949; 
 Mon, 19 Aug 2019 10:11:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id g15sm18068537wrp.29.2019.08.19.10.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 10:11:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
 <2013231565163716@vla1-1374b6242101.qloud-c.yandex.net>
 <3137561565860372@sas1-fc7737ec834f.qloud-c.yandex.net>
 <82eb0ad0-d4ee-bfc8-0087-d8910f6cf504@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6193fef9-244a-fbd7-5506-160d841145fa@redhat.com>
Date: Mon, 19 Aug 2019 19:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <82eb0ad0-d4ee-bfc8-0087-d8910f6cf504@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] High downtime with 95+ throttle pct
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
Cc: "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/19 18:39, Paolo Bonzini wrote:
> On 15/08/19 11:13, Yury Kotov wrote:
>> Ping ping
> 
> Hi,
> 
> sorry for the delay, I was waiting for the 4.1 release.
> 
> I would like to make a small change so that preemption of QEMU does not
> result in overly long sleeps.  The following patch on top of yours computes
> the throttle-end time just once.  Of course you can still be unlucky if
> you are preempted at the wrong time, but the window becomes much smaller.

The new unit test is hanging for me on aarch64-softmmu.

Paolo

> diff --git a/cpus.c b/cpus.c
> index d091dbd..d7e2145 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -781,7 +781,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>  {
>      double pct;
>      double throttle_ratio;
> -    int64_t sleeptime_ns;
> +    int64_t sleeptime_ns, end;
>  
>      if (!cpu_throttle_get_percentage()) {
>          return;
> @@ -792,18 +792,17 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>      /* Add 1ns to fix double's rounding error (like 0.9999999...) */
>      sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
>  
> -    while (sleeptime_ns >= SCALE_MS && !cpu->stop) {
> -        int64_t start, end;
> -        start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> -        qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
> -                            sleeptime_ns / SCALE_MS);
> -        end = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> -        sleeptime_ns -= end - start;
> -    }
> -    if (sleeptime_ns >= SCALE_US && !cpu->stop) {
> -        qemu_mutex_unlock_iothread();
> -        g_usleep(sleeptime_ns / SCALE_US);
> -        qemu_mutex_lock_iothread();
> +    end = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
> +    while (sleeptime_ns > 0 && !cpu->stop) {
> +        if (sleeptime_ns > SCALE_MS) {
> +            qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
> +                                sleeptime_ns / SCALE_MS);
> +        } else {
> +            qemu_mutex_unlock_iothread();
> +            g_usleep(sleeptime_ns / SCALE_US);
> +            qemu_mutex_lock_iothread();
> +        }
> +        sleeptime_ns = end - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      }
>      atomic_set(&cpu->throttle_thread_scheduled, 0);
>  }
> 


