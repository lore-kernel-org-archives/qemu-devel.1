Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE03C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7D021D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="teGcpHY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7D021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qo6-0001JU-U0
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8qnD-0000r0-Rr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8qnC-0006Vd-9a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:31:55 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8qnC-0006VK-3c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:31:54 -0500
Received: by mail-oi1-x242.google.com with SMTP id 2so424578oiz.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 11:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dp5kOOPOrerHLi+kb0FS+a8B4SqfEkMBaZMk7hxWMkw=;
 b=teGcpHY9gK/F1QLEDur5MvuYlFyN/zjoW3XsOUFJxeblZdzLeMC6qtz9Nf4XPt6708
 wPn+Tp9LR3Tz2fLzcNtlv1bGO1n/iHr0CeP661UAmiWPUwoYt0XAPpLsj2gaRLDMllKH
 l/meAElyusHTHJL6c2kKkZBA++s8lpoM3CvIVKz8Y/vsxcHmXWvh5s682VQE4FWaDC3a
 YyN6o/2YyC1PjuGu3p5+8aIaqiytJB39lth6Gqc68kwH2haM912LnNkaw3vRYu+UAYXY
 8sFkooPL7iArV6ZBFz2KFAh7q1KWCwn27mUTiowGKktlUKlGhjV2uONlz/BKGRaqQ7EY
 LhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dp5kOOPOrerHLi+kb0FS+a8B4SqfEkMBaZMk7hxWMkw=;
 b=bSyYYb2wjfDLOk3awJ7Dr1oMinWfAlBFfpfCmab+MbPnzt4zwJ4Ya8UWhFnUYX5t/O
 ea4lNxa6RvkDm0ouwtr5owfvlO2igabyg/Yr7MPopqWm7Rovg1MKXJgpeccvosOKzOZS
 YWCwGHiXMBxO2SCySr+81T8CkIs3BmybhDyzOxeZcDQley3aOreM/Q7fRphqWjXAYTYc
 WzTRMRDRviEDGPJGtB5yZr33lrT0m38HFzyBIOOBO3T51csC3X3B71sBJKPt+eckjSCR
 ELt9PNxcuVLwMpxJpuMhZ/1oSHmM47eFp0I153yVxjg8mY9cWwwQ4OI4xFOeE6f7w0az
 Q5+w==
X-Gm-Message-State: ANhLgQ3KLqZ+glYxQMI/2N1CxOfYW8nfcebFXwkJSPlpqe90t15rpcDR
 DMmg9GGF0QmsNGLulsVB6xiT0bXJuVVkR3eIxfDL1A==
X-Google-Smtp-Source: ADFU+vseDEu8w3P6xMDm8QSbNNavh1sk0xZp5LfX6yFzsfVK/iVXApuhdYnNd+CEqOotmlOVB6rlsY7LUI7g/P1Bfu8=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr7573oiy.170.1583177513038;
 Mon, 02 Mar 2020 11:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20200124232009.12928-1-richard.henderson@linaro.org>
 <20200124232009.12928-3-richard.henderson@linaro.org>
 <CAFEAcA_aA1jNkkgmdxLqUhSbAz7JL2chAU1+s475HSoqKQiukg@mail.gmail.com>
 <e0e3cf61-33ef-3b95-4a2b-2458cdcab296@gmx.de>
In-Reply-To: <e0e3cf61-33ef-3b95-4a2b-2458cdcab296@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 19:31:42 +0000
Message-ID: <CAFEAcA_80Hm-FX0-OWW3yJ2H1d=mqxt8tKsvP7LpDayQBXRtGw@mail.gmail.com>
Subject: Re: [PULL v3 02/11] hppa: Add support for LASI chip with i82596 NIC
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 19:23, Helge Deller <deller@gmx.de> wrote:
>
> On 17.02.20 18:56, Peter Maydell wrote:
> > On Fri, 24 Jan 2020 at 23:20, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> From: Helge Deller <deller@gmx.de>
> >>
> >> LASI is a built-in multi-I/O chip which supports serial, parallel,
> >> network (Intel i82596 Apricot), sound and other functionalities.
> >> LASI has been used in many HP PARISC machines.
> >> This patch adds the necessary parts to allow Linux and HP-UX to detect
> >> LASI and the network card.

> > So we could be reading off the end of the buffer.
> >
> > I don't know whether the buffer should be 4 bytes
> > larger to allow for the checksum, or if the len calculation
> > is wrong.
>
> I'm working on a bigger patch which will improve this driver.
> It still has some issues with the emulation in Linux and HP-UX.
> With the patch I will take try to fix those out-of-bounds
> accesses too.
> It will take some time though, until I will send the patch.

As this is a bug fix and in particular a fix for a buffer
overrun, I think it would be better if you could send a
patch that just fixes this. If you include it in a larger
general-improvements patch we'll probably just ask you to
split it out when we get to code-review of that patchset,
and doing it that way will mean we have the buggy code
in QEMU for longer.

thanks
-- PMM

