Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4001AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977F72098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOnJ52/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977F72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuv4-0003HQ-CC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUumc-0002kZ-RY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:46:46 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUuma-0002e2-RA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:46:46 -0400
Received: by mail-ed1-x541.google.com with SMTP id x1so2574307eds.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8VUKOvb7t27OBfri8uZVhBBoeOO/8pALQKsOrPy4vgw=;
 b=gOnJ52/BiHGzYZP/OKhud8mcUkd0BsHYkR3weeD9rfsFadABPfwxLh8FtzCtw+qIoz
 K5BDTmGPPaEMrTq7zlDv9KL3mDVL75VX6ZcfVost3Ta/FpqUd1FZKJi1JTCFBpoCCC4d
 XSuV0yFFBfo1g8jsYEYGEv7IFpH3c1ikPTKzDpD9jqCWwLemhUsul/IJLxLQUspSU1LH
 E+nCTlM9djqaN47/b1nyGaygAe6OmeiqVWJru/aul4LnXX1aLVgjXG2DXTL+UmYcH6s5
 aEpubdajwy/82ArC8QSYTXtlRKF1GwnQCqXQZKuSIHC6FSK5CYu0F5krHtlTh0JKjCqq
 VmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8VUKOvb7t27OBfri8uZVhBBoeOO/8pALQKsOrPy4vgw=;
 b=nkY8fO5Bz0ckaq7lGLC+wStF2MgY9vdfYNdpa4oeOYBX/5pN2xDX2wfr2/svbuelGi
 UCVp3/PiCaHjQWiM/IQWwaUmsfpWNmEJW+SPjJqUo2g0XEsC1aF22T5R+9cZq5dbtAXf
 e4VybYwvo7SEOJz0k09HRnPRppnd06PDbbRc1tl0pCRplC+E9vlNP57j2eUJDyQKNz+j
 0VqhRbY0pj4P4FW/QfVLOIWgFH0fRXqbGh+3p7406mr+/SicKejAt3brQ2xzlSonfVe9
 EM5Adf0JdQP6otT6i9WH3eWDvFRlTvqTpsRSABi51h7u//iisMGXITxNAjn2JrywYA9q
 fO0w==
X-Gm-Message-State: AOAM5320btTVbcQq6H7ieCJr19Q54GaLWYHggaT6tfPW8LRCqc9AX7D7
 MUXr1+ARShNo/6NRjifMVYl3zhWiGZ7eIGewIxW6+w==
X-Google-Smtp-Source: ABdhPJxgrxUOPc+5ml/mYWX896mtT2n35E25wEM4YYyWjDeb2J+9T5YHr+CIY/9QqTh3ggcd6Z8t696VZMIjMX5s+fU=
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr3620836edq.251.1603212402978; 
 Tue, 20 Oct 2020 09:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-10-peter.maydell@linaro.org>
 <f295c99f-0405-1c26-6f58-12abdec8bd3d@amsat.org>
 <9fc9b0cf-4919-40b5-0430-cfac6fd7bbef@amsat.org>
In-Reply-To: <9fc9b0cf-4919-40b5-0430-cfac6fd7bbef@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 17:46:30 +0100
Message-ID: <CAFEAcA-pZ_=FvPC7TtzhcfM3rdgL8c_VOyDHo5ycBb5ezUPufw@mail.gmail.com>
Subject: Re: [PULL 09/31] hw/core/clock: introduce clock object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 17:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 10/17/20 1:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Damien, Peter,
> >
> >> +/*
> >> + * macro helpers to convert to hertz / nanosecond
> >> + */
> >> +#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000ll=
u))
> >> +#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000ll=
u))
> >> +#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) !=3D 0) ? CLOCK_SECOND / (hz)=
 :
> >> 0u)
> >
> > I'm having Floating Point Exception using a frequency of 1GHz.
> >
> > Using frequency >=3D1GHz we have CLOCK_PERIOD_FROM_HZ(hz) > 0x100000000=
.
> >
> > Then CLOCK_PERIOD_TO_NS(0x100000000) =3D 0.
> >
> > So for frequency >=3D1GHz clock_get_ns() returns 0.
>
> So Peter suggested on IRC to rewrite the code consuming this API
> to avoid reaching this limit :)
>
> Still some assert would help other developers triggering the same
> issue to quicker figure how to bypass the problem.

The fundamental problem here is that if you have a 2GHz
clock then it is just not possible to have an API which
says "give me the period of this clock in nanoseconds
as an integer".

Even for clocks which have lower frequencies, there is
still a rounding/accuracy problem when converting to
a nanoseconds count. I think these macros and the
functions that wrap them are in retrospect a mistake,
and we should replace them with other APIs that allow
calculations which can avoid the rounding problem
(eg if what you need is "how many nanoseconds is it
until 5000 ticks have expired" we would need an API
for that, rather than trying to calculate it as
5000 * nanoseconds_per_tick).

It looks like currently the only uses of CLOCK_PERIOD_TO_NS()
and clock_get_ns() are:
 * some tracepoints in the clock code itself
 * mips_cp0_period_set(), which does:
    env->cp0_count_ns =3D cpu->cp0_count_rate
                        * clock_get_ns(MIPS_CPU(cpu)->clock);
   so I think it is trying to calculate "nanoseconds for
   X ticks of the clock".

CLOCK_PERIOD_TO_HZ() and clock_get_hz() are used by:
 * the qdev_print() code that prints a human-readable
   description of the clock
 * hw/char/cadence_uart.c and hw/char/ibex_uart.c code
   that calculates a baud rate given the input clock

CLOCK_PERIOD_FROM_HZ and CLOCK_PERIOD_FROM_NS are
used only in the clock_update*() and clock_set*()
functions. I think those should all be OK, because
they're just setting the period of the clock (possibly
propagating it to connected clocks), and we can
assume the caller uses whatever unit they naturally
have available as the accurate way to set the clock.

So that suggests to me that we should look at designing
APIs for:
 * "give me the time in nanoseconds for X ticks of this clock"
 * "give me a human-readable string describing this clock"
   for the qdev_print() monitor output

and we should adjust the clock_set and clock_update tracepoints
to trace the raw period values (perhaps with an extra
"approx %"PRIu64" ns" for the benefit of humans reading traces).
Then we can delete CLOCK_PERIOD_TO_NS() and clock_get_ns().

Not sure about what the UART code should be doing. Given
that it's basically calculating baud rates it does eventually
want to get a frequency in hz but maybe we should arrange
for the frequency-division part to happen before we
convert from clock-period to hz rather than after.

thanks
-- PMM

