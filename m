Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C965C2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APrjY/jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C965C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMdkO-0007dy-1o
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 15:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iMdjZ-0007Cb-LJ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iMdjY-0007Bm-68
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:52:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1iMdjX-0007AE-Rh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 15:52:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id t16so10224494wrr.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L8JyvHPMyMhokVDTc8Pc971XAPX78Th+iT+yI4+u0UY=;
 b=APrjY/jSckFYKLgpAX/7sJUP1WMpbrV1cTOjIVLwWFRriqn+UB7xnrivIEdKaUR4ax
 uA72TabmxaWe/edxMyyI1/wP6BxNsIpsAcCbeXUXOsti0mS3D/XYUhJJ7Cexze5HhO5t
 FjVontdhT2ObBctqG6Opgf/I+iGZU535YEcBpo/77PJmQ60PZo5kiMmBiuBej2inOLpB
 PiIsEJa+X0jP/XK7PUMkAJGaXTAUS5DS2TJAI8utjYMhDvEtAISzgCAlO0ii5lDe99qa
 b6uWFsP8DPQRP0e3zFilGb9pN5qKfXoVbtfIE50XDA73baCX2Lf3/0OqUYiUOvNuUx/z
 Z2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L8JyvHPMyMhokVDTc8Pc971XAPX78Th+iT+yI4+u0UY=;
 b=a4qi/imRqwlg0fgyRun4vVMGROV+ieG7GJf922jGBIoOgH+sn7PeRyrcpGExiXYBzm
 qfomPQFhJgktl+WPwlzyXPI+ac5CaSZOCDT4ZrhA2t8RP2CBlzEr7SSbbMPCeQlwwq3g
 GT4XE6jvihHgjw4BvXrF0Ng7zbHqAQe74BMUKF06poIBYn8nc5niBLsAKBLhwGwGSCF4
 oXKdKVlFPjggLT/rSDfoIO2JkQ0j0dIdD1ocn89yQw6lHrECvYjGOJ/RYNMWfnPOzffQ
 ug+RKz634FLycS89fGKTObKWTQ7zHBcZMU3VgGY7CeLXSU8cnPeBLjJ0+zKh399mFSEv
 DhHA==
X-Gm-Message-State: APjAAAXBIg/zA1t+bbPqYWKSkPkN4KowdAqsEbOdm0/el0X9EZ3JUKm8
 6eGWZ+IDw/v6QeD4H8UKC4G5vgZtSqZF3PTTkjdifQ==
X-Google-Smtp-Source: APXvYqwcugT//qnqufmXFYv7mzW6pXLJFnsI9RIJJUQFrtvIRLaGeVUrR5fl8Axh/4r7ZFcA/B5qxBZnIVYs8fJOW4o=
X-Received: by 2002:adf:9f08:: with SMTP id l8mr20361667wrf.325.1571687568411; 
 Mon, 21 Oct 2019 12:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
 <5dc0737a-f1b0-24aa-015a-1806a6d61e69@redhat.com>
In-Reply-To: <5dc0737a-f1b0-24aa-015a-1806a6d61e69@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Oct 2019 21:52:42 +0200
Message-ID: <CAKv+Gu-QkvyLoJ6jW7eMm48hKKO9pf6r53m6Qi1cvCDt9WJx5g@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Graf <agraf@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 19:57, Laszlo Ersek <lersek@redhat.com> wrote:
>
> (+Ard, Alex)
>
> On 10/21/19 17:52, Richard Henderson wrote:
> > On 10/21/19 7:58 AM, Peter Maydell wrote:
> >> Since 2008 the tcg/LICENSE file has not changed: it claims that
> >> everything under tcg/ is BSD-licensed.
> >>
> >> This is not true and hasn't been true for years: in 2013 we
> >> accepted the tcg/aarch64 target code under a GPLv2-or-later
> >> license statement. We don't really consider the tcg
> >> subdirectory to be a distinct part of QEMU anyway.
> >>
> >> Remove the LICENSE file, since claiming false information
> >> about the license of the code is confusing, and update
> >> the main project LICENSE file also to be clearer about
> >> the license used by TCG.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> This patch takes the simple approach of just documenting
> >> the de-facto current reality; does anybody want to argue
> >> for something else? Other possibilities I guess would be
> >> specifically documenting tcg/aarch64 as an accidental
> >> exception to the general licensing rule for tcg/, or even
> >> trying to get it relicensed.
> >>
> >> Does having tcg/ be BSD-licensed gain the project anything?
> >> From my point of view I don't really see it as a cleanly
> >> separable module of code -- it's quite tightly integrated
> >> with the rest of QEMU, including code in accel/tcg which
> >> is variously GPL or LGPL.
> >
> > I think this is the best solution.  I've never been convinced that TCG can
> > usefully be extracted and reused for something else.
>
> Side comment:
>
> Ard and Alex extracted TCG to run x86 PCIe UEFI option ROMs on aarch64
> hardware.
>
> https://github.com/ardbiesheuvel/X86EmulatorPkg
> https://kvmforum2017.sched.com/event/Bo0S/qemu-in-uefi-alexander-graf-suse
> https://www.youtube.com/watch?v=uxvAH1Q4Mx0
>
> If I remember correctly, they specifically picked a git commit hash that
> was still purely BSD licensed.
>
> FWIW,
> <https://github.com/ardbiesheuvel/X86EmulatorPkg/blob/master/LICENSE> is
> not any BSD license, so I'm almost surely out of date on that aspect;
> just wanted to confirm that TCG has been usefully extracted.
>

This commit has the background info
https://github.com/ardbiesheuvel/X86EmulatorPkg/commit/552c44d2cbc778f3e53d6d3985a8787c7df99733

