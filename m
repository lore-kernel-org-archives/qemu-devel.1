Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBABEC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5343205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="tnh7BobC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5343205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icY2V-0001Ks-Lu
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1icXhy-0007UQ-8a
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1icXhr-0000Mr-1x
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:40:53 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:54638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1icXhe-0006zr-A7; Wed, 04 Dec 2019 11:40:39 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 8907096EF0;
 Wed,  4 Dec 2019 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1575477632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjGKPB5c4P8bd8a+QNrfUgzYWNg71wjN6eLs9KmHosA=;
 b=tnh7BobCcUBp+eIoC+Yfy9v91Q7AWWdA7AjwLJ6+QFRosm74E1i+ny0zlQro1llKDSDPEG
 E4opTNCd77Et0TWfXjt+L5z1r5/w2ZKJ4Jcy1kWUEZj0BwXZ9eT/VR8YFglupA8cATtPnB
 IL2V3unVulskwovAVJQyo3TLI3SjiDI=
Subject: Re: [PATCH v6 0/9] Clock framework API
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <CAFEAcA98rt6nRDSrwk8XRbaBT67LZXvF=XEV13dtJBp4fPUscw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <be199ad6-1b79-f77d-afad-faeb042151ed@greensocs.com>
Date: Wed, 4 Dec 2019 17:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98rt6nRDSrwk8XRbaBT67LZXvF=XEV13dtJBp4fPUscw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1575477632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjGKPB5c4P8bd8a+QNrfUgzYWNg71wjN6eLs9KmHosA=;
 b=31u+hFb35XIKDa1zPuVQ0clcg3xiPu4NiiRlCFmzEoaTMeZIlUAjP3BPdvy+D+SRLbcGNP
 E4KVIJnlSGQFOK69lfi8gKbAGuuLI50zbCmkY+T+Gg7c1udlnaLQNcMwj6PhGnWGOITGvM
 V7nkn9+3+Zvl+DzoLkYU2q7bGMfU65A=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1575477632; a=rsa-sha256; cv=none;
 b=TRASPnEhWHWxFEkSUF/96I1NtUBXdQQaIT/hRwFBCIAVi8JltKJ72k9cDo+RVLqy0TwkdS
 +Lgp8RyONz60AWHMPlNzUyoa3Ldt1uBI3bszI0LavHW1b0fFbO/VR9UqDOxBmuX29KB02m
 kn5VpMDZ376B8+uebQQbfzPJZd0OP3M=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/2/19 5:15 PM, Peter Maydell wrote:
> 
> The one topic I think we could do with discussing is whether
> a simple uint64_t giving the frequency of the clock in Hz is
> the right representation. In particular in your patch 9 the
> board has a clock frequency that's not a nice integer number
> of Hz. I think Philippe also mentioned on irc some board where
> the UART clock ends up at a weird frequency. Since the
> representation of the frequency is baked into the migration
> format it's going to be easier to get it right first rather
> than trying to change it later.
> 
> So what should the representation be? Some random thoughts:
> 
> 1) ptimer internally uses a 'period plus fraction' representation:
>  int64_t period is the integer part of the period in nanoseconds,
>  uint32_t period_frac is the fractional part of the period
> (if you like you can think of this as "96-bit integer
> period measured in units of one-2^32nd of a nanosecond").
> However its only public interfaces for setting the frequency
> are (a) set the frequency in Hz (uint32_t) or (b) set
> the period in nanoseconds (int64_t); the period_frac part
> is used to handle frequencies which don't work out to
> a nice whole number of nanoseconds per cycle.
> 
> 2) I hear that SystemC uses "value plus a time unit", with
> the smallest unit being a picosecond. (I think SystemC
> also lets you specify the duty cycle, but we definitely
> don't want to get into that!)

The "value" is internally stored in a 64bits unsigned integer.

> 
> 3) QEMUTimers are basically just nanosecond timers
> 
> 4) The MAME emulator seems to work with periods of
> 96-bit attoseconds (represented internally by a
> 32-bit count of seconds plus a 64-bit count of
> attoseconds). One attosecond is 1e-18 seconds.
> 
> Does anybody else have experience with other modelling
> or emulator technology and how it represents clocks ?

5) In linux, a clock rate is an "unsigned long" representing Hz.

> 
> I feel we should at least be able to represent clocks
> with the same accuracy that ptimer has.

Then is a maybe a good idea to store the period and not the frequency in
clocks so that we don't loose anything when we switch from a clock to a
ptimer ?

Regarding the clock, I don't see any strong obstacle to switch
internally to a period based value.
The only things we have to choose is how to represent a disabled clock.
Since putting a "0" period to a ptimer will disable the timer in
ptimer_reload(). We can choose that (and it's a good value because we
can multiply or divide it, it stays the same).

We could use the same representation as a ptimer. But if we don't keep a
C number representation, then computation of frequencies/periods will be
complicated at best and error prone.

From that point of view, if we could stick to a 64bits integer (or
floating point number) it would be great. Can we use a sub nanosecond
unit that fit our needs ?

I did some test with a unit of 2^-32 of nanoseconds on 64bits (is that
the unit of the ptimer fractional part ?) and if I'm not mistaken
+ we have a frequency range from ~0.2Hz up to 10^18Hz
+ the resolution is decreasing with the frequency (but at 100Mhz we have
a ~2.3mHz resolution, at 1GHz it's ~0.23Hz and at 10GHz ~23Hz
resolution). We hit 1Hz resolution around 2GHz.

So it sounds to me we have largely enough resolution to model clocks in
the range of frequencies we will have to handle. What do you think ?

--
Damien

