Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31CCC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEDA20673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLKclUSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEDA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPxk-00065d-Ka
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPwn-0005Gq-5D
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPwl-00017e-KF
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:08:16 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCPwl-00017T-Br
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:08:15 -0400
Received: by mail-ot1-x342.google.com with SMTP id g13so12393947otp.8
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ERJUb+dbN/w4nneNwABGCqg5RdaLapiiDr2Pd0CIAVo=;
 b=dLKclUSA7hiKLiYWQI837sCtal4CaDnjvEiG6bQl8q8bKGKEDNzb3wq5asxhyOoYJr
 SsCFrsI7HfyaTJeDGI2AVzjfeNjp1WYYX0/aSsbMIGqPCMFDaACfeAwpGaQvs1lEEgtg
 4uZUg0gu+YKTCru3eTXAXgLfhu2OHmau0yy5TqrkUW2t3oHQEjQB3tGYVBQpPq3gVTM+
 IT0lNdHTev48yBTTsfbivY/C2QwmAN5h9mIQiKRvDyhsggYRZbBTokto5aDHfHKMxNvi
 aD56wpnx6NkGd1bZ9qS6ctkNURwdRCKLxQEUrTKOkgj8lIXea/V4Ib33fa5/LL84HxrA
 E4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ERJUb+dbN/w4nneNwABGCqg5RdaLapiiDr2Pd0CIAVo=;
 b=icuzi7c0HVqagzJfvrybeflE/03vvJE+EZtsSNngu0xMach3BJumbnLCBUc9Pa6rfw
 19Ix8LIShoOF7VkTbGNuGw6bug9S20c2MHB3rmtV5YjzsrE+PNQutUB3V7iXLMBJ/fFP
 k2gEVoRCc5rPCFfXWw+3YHegtGJpgzHamNJucDmRXaut5ZENopUikz0nJL1L4BxEP4ZX
 8CnzSVeGBc2mPOqPoFPUiUI8bWZ/Za24wegJkvuHor4TvZ8vwO6pARvWeN+X0I6bcRFz
 Jbt3t2i0bRvgIecjWvPNymgTvSlTFCD67p/o3rqfH441lMmqY3pxH5VX8vy5zsjtBu8v
 e9IA==
X-Gm-Message-State: APjAAAX6bX4w3GXuQXbJkVBuzM6UvS68U3y9HS3fmTc5fTXqx2Z7SB4h
 6A5PFaV87XU3aEW08km/on+vTkcPmsqA9BWJAM87ng==
X-Google-Smtp-Source: APXvYqzkgscNcANa0dhKPYkKjpu5uMzvpO26xVxTV8iXtSTKGg70OjpqWAMM9Hrx1tDlhmgaUPdGoTqO7BlKMKQ1Zk4=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr219175ote.97.1569251294474;
 Mon, 23 Sep 2019 08:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190921101703.17935-1-philmd@redhat.com>
 <CAFEAcA8RfAPuV9LfL3c01KU+sCtAcWkHsLR7e-4QNJVcniq7Cg@mail.gmail.com>
 <ec6ddb30-6ae4-a3fb-e97c-58758df65650@redhat.com>
In-Reply-To: <ec6ddb30-6ae4-a3fb-e97c-58758df65650@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 16:08:03 +0100
Message-ID: <CAFEAcA8+3KjJ61n_U-eM4ydPTNQpok2VRMpwQecYMGhGxcf9tw@mail.gmail.com>
Subject: Re: [PATCH] hw/ptimer: Assert next_event is newer than last_event
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Osipenko <digetx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 15:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 9/23/19 4:40 PM, Peter Maydell wrote:
> > On Sat, 21 Sep 2019 at 11:17, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >>
> >> If the period is too big, the 'delta * period' product result
> >> might overflow, resulting in a negative number, then the
> >> next_event ends before the last_event. This is buggy, as there
> >> is no forward progress. Assert this can not happen.

> > Can this only happen if a QEMU timer model using the ptimer
> > code has a bug, or is it guest-triggerable for some of our
> > timer models?
>
> I hit this running a raspi4 guest, I had incorrectly initialized a clock
> using the core cpu frequency, while I had to use the APB one (in my
> case, core_cpu_freq / 2). The guest use a high value to configure a slow
> timer, which in my buggy case made QEMU hang in hard way to debug.
>
> So yes, it seems guest-triggerable if the implementation is broken.
> Using assert() is OK for broken implementation, right?

Yeah, if this can only happen if QEMU code is broken then
an assert is OK. I was just trying to find out what the
cause was, since "this is buggy" isn't specific about where
the bug is.

> Or should we audit all ptimer calls?

I don't think we specifically need an audit. We could perhaps
expand the comment by the assert to specifically say that if
the calculation of the next event overflowed then this indicates
a bug in the QEMU device model using the ptimer API, so if
somebody else runs into the assert they have a hint about
what to look at. (An overflowed next_event indicates a time
incredibly far in the future, given that it's a nanosecond
time in an int64_t.)

The other approach I thought of would be to make the ptimer
code handle this sort of after-the-end-of-QEMU-universe time
by saturating next_event to INT64_MAX rather than letting it
overflow and wrap. Unfortunately while this would be fine for
the 'timer event' part of the code, it would break
ptimer_get_count() which calculates the current counter
value by looking at the difference between the current
time and the time of the next event (fixable but only with
a bunch of messing about to treat a next_event of INT64_MAX
as equivalent to the counter being disabled and tracking
the counter value in s->delta). So an assert is the
best thing I think.

thanks
-- PMM

