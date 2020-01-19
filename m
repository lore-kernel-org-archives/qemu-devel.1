Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF773C33CAF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7304420679
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSJfac7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7304420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itFrD-0001zN-6A
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 14:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itFpP-0000lM-6d
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itFpO-0000l7-8l
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:01:43 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itFpO-0000jR-56
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 14:01:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so26795353otd.9
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aDi1N7Df12D76PLV6rwita/JJfO9QOIBjG3NPUf7ABU=;
 b=oSJfac7pZwc1VOhHwbk9sKWYPvwS7PbAy7Um1A4jPHIX2W7q3x0lzqzj7/QIE1Zy5A
 vPpZ4+mfN+LLlNvmAQHmbHb1HTMhEkpZpkzpmz9QIyfsTBX6pLZkZNblXHGYCqCEQ/2V
 YJuzOTim5ZzSZ8MHOwwk+wOaFPLfSgre7gHfWs6UPJYFfZoO8psnk0RrkwjvaJZiG6yW
 Lbh5g+LJsQCCBWygle8GDUp5lYtk+yJZCslOvbjueNz5A0dyfhzA3x8CPqBdaYRpfQMl
 EjyguEF/TvHXnf4nfbJAI51v7P08gmysr+MjWH/L5LYkT6l7gPIU4ImZdUoE68BKIlCY
 jTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aDi1N7Df12D76PLV6rwita/JJfO9QOIBjG3NPUf7ABU=;
 b=VTsiHPxbqLw6Ou1mdUhUM1U5jfDFGHutB1FYdDk7YUg4dj798UjFBeWe9nMMMVuKxh
 hDFU5P+YFuoHozXYVES4HKD8I+oX/Ato5uBm0NjIg8B3tLDwSVYAAvYtUZA6AWrfnTEV
 vx1WQm0376sr4uWMucjKGM6EA0c3nskKj5Qn9C/1+paytIgf3KFCjHP62BzfjB4q+F3r
 saSKhbGVbmFIuv1laWSolFCi/zVEPMOXMdZbsrAtbv6yTGGtU7mNTEl1skIJ6W6zblrV
 hVhbwsPgs2qThv5B/w4Upezt//tCc2esZE+BOhav6u22AaU/T+RbNIwxCpxL/GLnZI69
 5OXw==
X-Gm-Message-State: APjAAAVw4WjHARwWv4ECNmDdPJ0iSx6hWT9NPoPcZsd8XIaM00qSSk5P
 6Pg7gL1wIpAY64iIDwe2MJXNhqOvuALq++SJZE8FZg==
X-Google-Smtp-Source: APXvYqzeIrh9NDocICFn4jcRqCbNnBALYdnlHpJXY96WsA4ar6fyjS+AXJTvuh3MJ6ugpfyPZUcYZ5QV+HuReBJhZbY=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr12712126otq.97.1579460500310; 
 Sun, 19 Jan 2020 11:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
 <20200117182939.GC13396@roeck-us.net>
 <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
 <7a9967c6-a370-9137-10fd-095113dd9852@roeck-us.net>
 <CAFEAcA99CgreMMeTH+nmnY+6OU2xY3A-db6MfBuU8i_MCA+y3w@mail.gmail.com>
 <97dafdcd-3f4d-5cc3-efab-b07f373765d5@roeck-us.net>
In-Reply-To: <97dafdcd-3f4d-5cc3-efab-b07f373765d5@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Jan 2020 19:01:29 +0000
Message-ID: <CAFEAcA-9Q7kyJLGcz=kX+mgpL=8Hkt4hM2so1rG98t-ViBS+PQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 Jan 2020 at 01:52, Guenter Roeck <linux@roeck-us.net> wrote:
> I'd rather try to fix it all if I am at it; otherwise it feels kind
> of incomplete. Would you be ok with addressing this separately after
> the current patch series is accepted ?

Absolutely, if you'd like to clean up the code please feel free.
I agree that a separate patchset is probably the best way to go.
(Do you mean by that that you'd like me to take your v2 as-is?)

thanks
-- PMM

