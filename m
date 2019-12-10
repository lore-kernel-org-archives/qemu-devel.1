Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA25C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D4F207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBCDTLuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D4F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iehiM-0004GS-Td
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 10:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iehhT-0003dr-9j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iehhR-0001GN-TI
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:45:23 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iehhR-0001FD-Mc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:45:21 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so15858582otp.12
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BzYMi4o5tnM8+8TW8stcvngRLupsDB7APP25/5NOis8=;
 b=ZBCDTLuHsRqqPhpnw4ZnsfkALAysJLqfOnpMBc3TMKRYD6D1NyxSzRa5jCvEh7L+iF
 NTcF7Ca5X9bszyyN+jiD/YOS2ElDgIjzAWxZSLn6LLGnQjuHjPGJM8Z5z+7Y80WO+qc5
 KJ86U98SQSBQm5fxuXJiElNJOjpvZpQKCXRURRAXPuLvYCwxJWQtzatrv4SbO3hQFB3d
 3/qeOX2T0cjjO85pDILjRiIryKDVheA2ebR10xvGL+pq/z4Ud85QaYCQf62qJou/AOiH
 brk5EaJAKmJrm4vQHf1x+azvax3X1wegaq1YPieQDb19N9BLvkHmCFYNYGethOlLNCnP
 yapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BzYMi4o5tnM8+8TW8stcvngRLupsDB7APP25/5NOis8=;
 b=q1qI7Xj9p3er57iT7Ud9EMmacliPFBYIPaxLm/ttFM00FqUonELpLXAoYN1bH6jChp
 SZpfzU9SSKqEuYPCt/T64pKUoFx3X9lf8xrvCCZg9cmUM21Lma5oR0YqWFXOvphTBmv3
 ooWJQull025bx3LPm9GuKgdfXtvSuBObyy01ZA0Kr+2NClbIDueNQo0u2Wii+i89hh9n
 mHi3PzQFERHqpGY8UoVCvFi3oD5cu/lnRDIyGUJdo9hXLYCUVbKWf3RdKGxre7XND4TA
 xkWA5MMju3DFQcYkuTmITtJu2N8xN9QCGaL7X67x8LhRjFe4oKRGvbBg52X688PisyUx
 cGTg==
X-Gm-Message-State: APjAAAXSpdbYyAuq9hiOOD4dSda5wVcxlr0hywP4M+dpi16WRGx8uprL
 1EArRsQHfj+uEssufp4K6sgwhxbwkeJMJpyjM13C6w==
X-Google-Smtp-Source: APXvYqySfmyrxjXFPAv0TQJndI2bCGuPYwLb/lA4co49/ecx4y6IXbDUXIiyWa+65VdfYYCTM6v6c8pNaUGcNJlSOoo=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr25113617otm.221.1575992720459; 
 Tue, 10 Dec 2019 07:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
 <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
 <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
In-Reply-To: <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 15:45:09 +0000
Message-ID: <CAFEAcA_Y0bX4mg7PyTgcfKtZQkPw+DEibW6OjVRGyA29mC7TiQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Dec 2019 at 13:33, Andrew Jones <drjones@redhat.com> wrote:
> So the ins and outs of this particular timekeeping issue (to the best of
> my knowledge) is that x86 has implemented this behavior since
> 00f4d64ee76e ("kvmclock: clock should count only if vm is running"), which
> was committed over six years ago. Possibly x86 VM time would behave more
> like arm VM time if kvmclock was disabled, but that's not a recommended
> configuration.
>
> PPC got an equivalent patch to the x86 one in 2017, 42043e4f1241 ("spapr:
> clock should count only if vm is running"), but when stopping time during
> pause on spapr they actually *keep* 'date' and 'hwclock' in synch. I guess
> whatever clocksource 'hwclock' uses on spapr was already stopping when
> paused? For x86 those values diverge, and for arm without this series they
> stay the same but experience jumps, and with this series they diverge like
> x86. I don't see any way to disable the behaviour 42043e4f1241 introduces.
>
> s390x got what appears to be its equivalent patch last year 9bc9d3d1ae3b
> ("s390x/tod: Properly stop the KVM TOD while the guest is not running").
> The commit message doesn't state how hwclock and date values change /
> don't change, and I don't see any way to disable the behavior.
>
> MIPS has had this implemented since KVM support was introduced. No way
> to disable it that I know of.
>
> So why is this arm-specific? arm is just trying to catch up, but also
> offer a switch allowing the current behavior to be selected. If other
> architectures see value in the switch then they're free to adopt it too.
> After having done this git mining, it looks more and more like we should
> at least consider naming this feature 'kvm-no-adjvtime' and probably
> also change arm's default.

Thanks for pulling up the handling by other architectures.
I think I agree that we should change the arm default (ie
we should just call this a bug fix, since the old behaviour
seems unhelpful generally and is more random accident than
a deliberate choice), with a switch provided just in case
anybody had something depending on the old behaviour.

-- PMM

