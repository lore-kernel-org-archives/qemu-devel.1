Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36F1C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCF821920
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOr5x2Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCF821920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFH00-0004cW-O2
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 08:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFGz8-0003zC-BD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFGz6-0006pY-T0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:10:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFGz6-0006ob-MD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:10:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id s22so11286833otr.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7XMla8wVv4CHj589tbcKWaGLUnci5E8cocJdaCWNxj0=;
 b=qOr5x2FmElgo2hfnaWCgzHdMeJHRp+2q0SLkk+cntMqcpv9mQzd0kfAWgUovb3D4bx
 87eDXyW84uBd6eLKEv2LWwrLfismcy+DlHrbeg2aasHXuUaSG/n6DG9xdWQP2oa7i4zl
 PKVXPRmwhg1fvxIPgdbmL3v8HTR+bWfF3vVot/EHtBoN8w3UG4L4AcCpDyrJ1SBnp9sP
 8Vnp+XckSl6C6N3yHC0WkzHJe2Orl7eoczJCK+UHWfY/5xwTYaHr6yhCY5jmMc/GCPvb
 uhHNcd+mInLDQ2Acx27/DGVLqvgv1XBf3v+EgFo8YglIZ1T4AhNkV3MaTUJlBBNV3w4Z
 QeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7XMla8wVv4CHj589tbcKWaGLUnci5E8cocJdaCWNxj0=;
 b=GCFXuOZY8T7e07P3eIHieqJodH8YeIgAAQMxDlAbzYfXG9/Bh9HtgYSCmFHhAyq8ka
 BhDRj7nF4xNfdlkK0pbPm/A3PcDgKQEJWIIdp9MfwLyfSXotSvKE4V/PeMlI43MkfTM2
 CUu9fA+hqfxNNKHqyUiffX2dhcjzzgopvCTdDyUsUQPy2gg+8SIFu/uh8UHMfykU09sf
 /Uehq705BGIU+SU+i29Xdo8k1tYuvywoJ9BcKBy0M8UQNq8n+G3UpEOeGYEsDVmS3Udn
 dXgTdhv6C/I33P8bav3sVMbW4x7xuW3plmdYDVF3Ka1aRXtKyCLsDJBPywpnN9j3Pwbu
 3JHg==
X-Gm-Message-State: APjAAAXzF8K1ZWP0g6qzuhKvlV5tlbFSNVBLO3ivuo5UzJEcPu8ZPUQp
 TVmgcE6aPj/oIQR+A8V6jDIw+a2w/RptHPslxuRH0A==
X-Google-Smtp-Source: APXvYqzJfQLpp1k7JyVZ2sK65oKrcyj/yrF5ttI8Ai45kjp4VCRJ/uKjGhbDJC2WVXzjZePt+CJrGXhNrgGRJ6vlFnA=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr4512476ote.97.1569931827350; 
 Tue, 01 Oct 2019 05:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
 <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
In-Reply-To: <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 13:10:14 +0100
Message-ID: <CAFEAcA938u8GEkPwQpii74RQO4N3A6_+4Q3e7SMOMLKYLEr8Yg@mail.gmail.com>
Subject: Re: Lockup with --accel tcg,thread=single
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Doug Gale <doug16k@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 18:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 30/09/19 17:37, Peter Maydell wrote:
> > Side note -- this use of run_on_cpu() means that we now drop
> > the iothread lock within memory_region_snapshot_and_clear_dirty(),
> > which we didn't before. This means that a vCPU thread can now
> > get in and execute an access to the device registers of
> > hw/display/vga.c, updating its state in a way I suspect that the
> > device model code is not expecting... So maybe the right answer
> > here should be to come up with a fix for the race that 9458a9a1
> > addresses that doesn't require us to drop the iothread lock in
> > memory_region_snapshot_and_clear_dirty() ? Alternatively we need
> > to audit the callers and flag in the documentation that this
> > function has the unexpected side effect of briefly dropping the
> > iothread lock.
>
> Yes, this is intended.  There shouldn't be side effects other than
> possibly a one-frame flash for all callers.

This seems quite tricky to audit to me -- for instance is the code
in vga_draw_graphic() really designed for and expecting to cope with
races where information it reads from s->foo after the call to
memory_region_snapshot_and_clear_dirty() might have been updated
by the guest and not be consistent with the information it read
from s->bar before the call and cached in a local variable?
I think most people write device code assuming that while execution
is within a function in the device model the device won't have to
deal with possible reentrancy where another thread comes in and
alters the device state underfoot.

thanks
-- PMM

