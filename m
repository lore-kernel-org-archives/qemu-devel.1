Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DACCC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95DB2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMNdrV0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95DB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMBF-0005lr-Ut
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnMB4-0005Kl-QU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnMB3-0002f5-Q3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:03:26 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnMB3-0002eN-Hu
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:03:25 -0400
Received: by mail-oi1-x242.google.com with SMTP id e189so15276253oib.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pCWF4v/1dA/wDNEO5wxQndFGXyCOUX98TC7G/Qbwnqk=;
 b=DMNdrV0+5tFsoj/eE4IF06VMr7KdH0ZjXSmx48768gE+u+HAxhxYh193LHG+oYG3fS
 frLCqc4CIT2NjMhNfZWRv5VN3b68hglHRWwir6vb2LAEPE0oUMG5p3fW5Z6HI4NxtzkZ
 Z82i+dTsYNrRqIro+rQ5+hOU/fxerwTPVcjiKY2cah41joDJQTmRNPHL/i8AzP7z4tdY
 mGAxumyMOv3vIo5pYlRBxiHLGuE2KZMHyUNdxZhNMtp7Vebalal62UrVmxzX2hib6Zvk
 4IAbo6ZW2ZUiM7ygKxJjdksb3oilNDbBSixjiJEGRgkT+FLRw6Hg+zkHTW7dLQaprpl8
 jh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pCWF4v/1dA/wDNEO5wxQndFGXyCOUX98TC7G/Qbwnqk=;
 b=YcSXaYkd2ztFbN65LI8B+Uyszh/Gztql4MqRwOTSuqxSOIctIMUImO3CsLp1ptiR7p
 Qou1WN5ThG4jP4Wi6GZzskKWs04ak0GK10J3pZaPk6oMWRPcieGbO34Sk0xDI3u1kEvX
 wsGk0wZB7sMHZwm3x78fkgeG7MAWYECfuVafkOy3IdR2UmV8ELvmqiNk+/RgFAhWcwhU
 sscU3KY152+amPvuIuR0nykVyJ6M3xWEYJikMdwaxAEkkFnP9Lr4MeMxaw67WlNAwRQ3
 gr7pvHGiWm2u4ukIwxr60iSXdoM6v9QKLPtqd60/2I6LcgT0zG+WTHf2vSJU1fagsRQq
 GF7w==
X-Gm-Message-State: APjAAAVbqSc9bYF3sVJOwmJaTJ+DuPAAHE3HT5yCHXrws5H44qd0hAjb
 vKH2HHREtnaL9YptaeoDZpLa3vX5kLFydL54ZD9tKg==
X-Google-Smtp-Source: APXvYqxqY1Iwn8PD2CnURF904BAI940czFD4TQf2yzUHCSGR6dl8vp/j0g0SXs1EaIQ9MSaxY8t35EK+XdtRN13U1ls=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr14771668oib.146.1563278604593; 
 Tue, 16 Jul 2019 05:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
In-Reply-To: <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 13:03:13 +0100
Message-ID: <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 13:33, Laszlo Ersek <lersek@redhat.com> wrote:
> On 11/02/18 18:16, Peter Maydell wrote:
> > @@ -829,7 +840,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
> >           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
> >           * Security Extensions is ARM_FEATURE_EL3.
> >           */
> > -        assert(cpu_isar_feature(arm_div, cpu));
> > +        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
>
> The assertion above fails on my AArch64 host (APM Mustang A3). Meaning
> that my host CPU supports AArch32, but lacks "arm_div".

Hi; I just realized we left this assertion-failure bug report
unaddressed, so I had a look at it.

I tried to repro on my Mustang, but this works for me.
A CPU with AArch32 but without the Arm-mode division instructions
would be non-compliant (and very obviously so if tested), so
I suspect the actual problem is not with the hardware but with
the kernel not correctly reporting the ID registers to QEMU.
What kernel version are you using?

> Better yet: can we rework the code to emit a warning, rather than
> aborting QEMU? Assertions are not the best tool IMHO for catching
> unusual (or slightly non-conformant / early) hardware.)

The intention of the assertion really is to catch QEMU bugs
where we got the ID register values wrong in our emulated
CPUs. Perhaps we should relax all these assertions to only
testing if we're using TCG, not KVM ?

thanks
-- PMM

