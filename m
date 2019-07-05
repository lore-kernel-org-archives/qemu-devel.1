Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00760C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B70218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B70218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKtW-0003rn-Au
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45304)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjKpp-00006X-Lp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjKpo-0007rL-JI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:53 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjKpo-0007qL-Bw
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:52 -0400
Received: by mail-wm1-f46.google.com with SMTP id p74so5173336wme.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 02:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fIBdNpUcLIDD98ru36unjYxeeeyxL4SC8FVSGenKXuU=;
 b=KYssDV9C0utBwm1zIlliBEd6ZJchxsXHjcjxHGBYpquEeMavHFEFinRbX7bxc+6lAz
 n2rEPWuCFOkcrvXVAUff1yZgbpNmpZdsup//OdKZs5EKT/ImmBdMC66ek3GIJ3dUlVgX
 ZGWSpGQTzTuQeLldNV8r5RR5Al49AmwhRTvyBS/qal+CEvN/8+rCsJvilkiqAYiZrG4/
 6GSAG5cNhoNhovuHII+H/wrz1XS4KAdpGJRz0iFKJp6KNTS4BPwuzf1LjsUTKMHWDtaq
 w7scQcW3fUVDCb1SO+KiBumErC8s9CQFs7DQsT39XJZ+sK6gvyTjQ7SS4i8oxoDKgHDU
 GIRA==
X-Gm-Message-State: APjAAAWVyaaFUcWQDth9PotYx+wjx93zQ6my7MOzcW/0lQ/1U78CRs/5
 geV/yOZE8pBVwTQNgHVIrybkContj+g=
X-Google-Smtp-Source: APXvYqwLM2XkEOJn7bIRGvVgbJXI8r12PDbhPsLuj0bfv2+XgSquotG3HeuRPEcIjMAzoWIPXZYc4g==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr2883979wma.25.1562320130376; 
 Fri, 05 Jul 2019 02:48:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id b19sm2204078wmj.13.2019.07.05.02.48.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 02:48:49 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
Date: Fri, 5 Jul 2019 11:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.46
Subject: Re: [Qemu-devel] pl031 time across vm save/reload
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/19 18:02, Peter Maydell wrote:
> I've had a report that the way the PL031 model handles time
> across a vm save/reload fails to correctly advance the guest
> RTC when the host RTC has advanced between the save and reload.
> I looked at the code and my correspondent's analysis (which
> I quote below, lightly edited) looks correct to me, but I'm not
> entirely sure how our RTC stuff is supposed to work. Paolo,
> you wrote this (way back in commit b0f26631bc5179006) -- any opinions?
> 
> In the pl031 RTC device. the current time is given by:
> 
>     int64_t now = qemu_clock_get_ns(rtc_clock);
>     return s->tick_offset + now / NANOSECONDS_PER_SECOND;
> 
> On save we do:
> 
>     /* tick_offset is base_time - rtc_clock base time.  Instead, we want to
>      * store the base time relative to the QEMU_CLOCK_VIRTUAL for
> backwards-compatibility.  */
>     int64_t delta = qemu_clock_get_ns(rtc_clock) -
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>     s->tick_offset_vmstate = s->tick_offset + delta / NANOSECONDS_PER_SECOND;
> 
> On restore:
> 
>     int64_t delta = qemu_clock_get_ns(rtc_clock) -
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>     s->tick_offset = s->tick_offset_vmstate - delta / NANOSECONDS_PER_SECOND;
> 
> So, no matter what is requested, if "qemu_clock_get_ns(rtc_clock)"
> increases (eg, because host time increased), then tick_offset
> reduces, which makes time follow QEMU_CLOCK_VIRTUAL no matter what
> was requested on qemu's command line.
> 
> (That is, because we migrate "offset relative to CLOCK_VIRTUAL"
> and CLOCK_VIRTUAL does not advance when the VM is stopped,
> we don't get the right behaviour of "offset is relative to
> the new CLOCK_RTC, which might have advanced".).

You're right, the compatibility causes wrong behavior for the default
-rtc settings (the RC pauses across migration).  The right thing to do
would be to store the base rather than the offset: that is, you store
the time at which LR was written.  Then the offset is s->lr - s->base
and it's independent of the machine on which the rtc_clock is being read.

By the way, the data sheet says "the counter and match values are
compared in a comparator. When both values are equal, the RTCINTR
interrupt is asserted HIGH"; QEMU compares the RTC value (read from
RTC_DR) and not the counter value, but Linux code seems to expect QEMU's
behavior.

Paolo

