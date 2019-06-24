Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C8C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6586205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io3TZm1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6586205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfRFZ-0000KW-Nr
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49102)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfRCD-0007IH-3x
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfRCB-0003RC-Rn
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:47:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfRCB-0003Nl-Ga
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:47:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id p11so14443992wre.7
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=oMXoZmxOFgzw93w97L6Xcw2tqA7AQank+sf4SkPf0Hc=;
 b=io3TZm1K9uo4sNMeg1opFw6UFCkjDBkvZ6XD/D8uq4QzlWXuUCHr3DTbTykYtx6Wpf
 f5EtdXoG/N4kEDcIbLsal7+9f29EqPE75aCpGV+y0gzbpPyKKOFQ6VivYkkhCJh5YLlV
 CKCK6/bmkri/oQ0HELoEO/fln8g7orxptV9ozPfV/oHQ0EWpZXhL7T+F5OiAgbciW/3z
 6xXuScmRttBXIGnrmLCQOzmDhbOcGIwCUDaiwhCDAgfJt5szbD8wS7HHOFQ4S5zMfR+e
 ruBU4zHB4vz8+/tV3UfmA+6RZYXqiMWejgnADvYqx60svtVyethsyfnmpEwgrHQpFP+D
 +0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oMXoZmxOFgzw93w97L6Xcw2tqA7AQank+sf4SkPf0Hc=;
 b=XABZ3WRyG53HUWTNPpKRNFp4WP3guF/CovgneIVzeZSkjj0JxSh8gpRBvhxo/DNznA
 lG+3ScdD8hRcEWwTRQqvakhNAXESPyNJY9KWDYsjhV/Acjo2AfnggT1TonLBaoM+R3bY
 rx2QI4u0PTeBJt9V3zvxVtd388I4s/51c6Jmf4d+kAKWRu2EVzhRdlqIwxW1FxlWKnbK
 MDVDTLC1uqLp6rAlSif0WnTgBSATGdtzuOE0MHs2fS0oRtdCCvU4KBCLWM3h4OBVEqU4
 FJC/dnDgAcoAtbR0YR5zAOFYGof8jYvntp3YPfyjsVoY4bxDocR45hIvnPCG9a6ntisb
 i1eQ==
X-Gm-Message-State: APjAAAUwVLiNV9KqbiHGxLlJiVlUTM1dNEBXs9Jt0C7B0BAo9woatY7+
 T/q5hoNWLSNTMX9sW5x6IQ48rCykp00=
X-Google-Smtp-Source: APXvYqxNCgWXj5Gpj8gSxDTXeOOZ7UmLoBsWavC25RKvjEnw6FRoOeEyfivvHmIofvmcAZPYw7j32A==
X-Received: by 2002:adf:edcd:: with SMTP id v13mr32171644wro.210.1561391269732; 
 Mon, 24 Jun 2019 08:47:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w23sm11565925wmi.45.2019.06.24.08.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 08:47:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2C241FF87
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 16:47:48 +0100 (BST)
References: <228A20DABA3D9846AF1B64E31C217296010A5383@SHSMSX106.ccr.corp.intel.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <228A20DABA3D9846AF1B64E31C217296010A5383@SHSMSX106.ccr.corp.intel.com>
Date: Mon, 24 Jun 2019 16:47:48 +0100
Message-ID: <87lfxr0yu3.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] icount mode
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


Wu, Wentong <wentong.wu@intel.com> writes:

> Hi all,
>
> Recently I'm using Qemu TCG icount mode, from the code I found Qemu
> timers run at 1GHz, and for ArmV7M example, there will be conversion

Are you talking about:

  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */

because as far as I can tell that only affects the scaling factors
applied to PMU counters. The internal counters (CNTFRQ_EL0 and friends)
are hardwired to:

   /* Scale factor for generic timers, ie number of ns per tick.
    * This gives a 62.5MHz timer.
    */
   #define GTIMER_SCALE 16

but this only affects the nominal rate the counters expire at. Software
could attempt to reprogram it and the emulation will read-as-written but
it won't actually change anything. However this only affects the clocks
- it implies nothing about how fast the core may be executing. In fact
unless you are using icount we will just run as fast a possible.

> factor from qemu timer to SysTick frequency which will be calculated
> by NANOSECONDS_PER_SECOND / SYSCLK_FRQ.

You need to be a little more precise here. ARM systems vary in the
number of timer sources they have. The qemu timers are an internal
implementation detail for providing a way to track time. The value of
SYSCLK_FRQ varies depending on what board you have launched and mostly
seems to be used to calculate the additional timer values for various
peripherals.

> But the shift value also define the target cpu frequency(2^N ns /one
> instruction), and both frequencies will be used together to calculate
> the guest timer, so I think there is buggy because of the different
> frequency, can anyone give some explanation for this? Thanks a lot!

All icount does is peg the elapsed virtual time to the number of
instructions executed (the instruction count). This means whenever the
code requests:

  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)

Instead of returning the number of ns the guest has been running based
on elapsed host time it will return the number of instructions run
shifted by icount_shift. So with higher shift values each instruction
sees an increased amount of virtual time pass - the practical effect
will be you see less instructions executed between timer interrupts.

>
> Also can anyone give some hints about how to give the shift value when
> use icount TCG mode?

  $QEMU $QEMU_ARGS -icount N

or

  $QEMU $QEMU_ARGS -icount shift=3DN

What is your interest in icount? Is it purely for determinism?

--
Alex Benn=C3=A9e

