Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61267C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294AE20706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghh9HAwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294AE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9kR-0008S1-9H
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iY9jb-00082r-G5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iY9ja-0005hY-5B
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:16:31 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iY9jZ-0005h9-Ud
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:16:30 -0500
Received: by mail-ot1-x342.google.com with SMTP id r24so6234806otk.12
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hSDtyz6U5sp6XnbyBvxRlErxfq464IncjSnLonINQOo=;
 b=ghh9HAwfcrbjJ57AnLua6yovW2OH9d8vzL+r8uggsG5Qhy3z5DXIamPcCZ0ZbF+VWE
 dPqgPNu3g5yradl75Qvt86Be4lAh/FpECAbFRnaJvjtOtEnmTZVws25w5ehk1PI9PM5p
 n3GsyIwlYh7Y+McOPKT2EK1Rz7zzDV7pCGmvGGxiBVmzf0bARvjfAzpMpUGedeeb4Un5
 exF8ALqDzFYqbiYmT0d5HTehmMha3VYfe9bjwV4SVV+gUVmFWuAft5W8gl2R+pdTVoCz
 qGkOzQdl9s5wVq5dpMPLUHKhAd+ZTyZ1oi1q2+/Y8sgQbHcv5lQ92uquofY9IBWUynoY
 D0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hSDtyz6U5sp6XnbyBvxRlErxfq464IncjSnLonINQOo=;
 b=bPsgcfXFbQ/Lau2joKOi2aUrATvCHf/XJsWUWpiSNeJvL9D2hYGeCRGkqfzQuBIWAg
 omekDj3yRBsNMXhQz+ZF/Noyq5bC1nlrJjXeZWMVGZWTRKZ2HFcaXeMrRcOAU8cygG+4
 4cbc/Aoys8/7TbkTUlsoC8h3niHfGdAmQCnrIqpJ08kyp0uJf0cpuFvaaJUoU6syWTGb
 kfcZ6tqV2YF/zFcvEE0L5ZCXAurRhcH5y3ilk8YBwLFGmm0oxJwcQLirOAp85lL43wMe
 PxqOADSxc+ojFA9KhU/oahcQDnihcTduoVrkZWek0HzTwPyTmacICsztsqRhv0IOeBzp
 ffdw==
X-Gm-Message-State: APjAAAX/UfXJhV380rX696DVxNZdYQk9wuYEK015KRh9eMou0deiEoOB
 ojaSNgcxqmBGYzN9npMpIen1mlIR9miq4tkwaxITYwUF5Mg=
X-Google-Smtp-Source: APXvYqy6zwY6XaY6JDzb+P/uBIHKkFBqLazMlaiiQUPfnuu82nb8cWOMt/d6ZOiFPdTqN8Yx2kqDfuP2HUSJ4HjgCuU=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr10334795otq.221.1574432188957; 
 Fri, 22 Nov 2019 06:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20191122135833.28953-1-maz@kernel.org>
In-Reply-To: <20191122135833.28953-1-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Nov 2019 14:16:18 +0000
Message-ID: <CAFEAcA-aRwc9bogn-QbT-q5FzkqieYmQOZMr6H=kK5ixMGANMg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 at 13:59, Marc Zyngier <maz@kernel.org> wrote:
>
> The ARMv8 ARM states when executing at EL2, EL3 or Secure EL1,
> ISR_EL1 shows the pending status of the physical IRQ, FIQ, or
> SError interrupts.
>
> Unfortunately, QEMU's implementation only considers the HCR_EL2
> bits, and ignores the current exception level. This means a hypervisor
> trying to look at its own interrupt state actually sees the guest
> state, which is unexpected and breaks KVM as of Linux 5.3.
>
> Instead, check for the running EL and return the physical bits
> if not running in a virtualized context.
>
> Fixes: 636540e9c40b
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Congratulations on your first QEMU patch :-)

I've applied this to target-arm.next and will get it into
rc3 ("fixes running newer kernels" seems like an rc-ish
kind of bug).

RTH: vaguely wondering if this might be related to the
bug you ran into trying to test your VHE emulation
patchset...

thanks
-- PMM

