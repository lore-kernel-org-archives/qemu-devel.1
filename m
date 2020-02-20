Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B7BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8164F206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbLpLed/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8164F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nGG-0002Ei-Kr
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nFC-0001Lt-Vu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nFB-0005NV-L7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:56:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4nFB-0005Mr-Ej
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:56:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so3899280oth.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6/qaW5FhSSy22a1eq657fqQZKhtniwywOQUUl7vYYwg=;
 b=GbLpLed/sYr6s6grwE43khGlNq7oTqxVMP9PE9Y5vuNLvM4u2zBXZhUJApw3gk2kQC
 1BGjcrSYH6N6bazg5SWMGYeZxxCOzYl2g4wZr8x2Rp/TQvdsfBcGJyfpFl8A1DeQcRRq
 ZWt27R9Ffxg5tH4vrJ9yCRGeDCMo9D3aBKaq3Z2GAaZBmEpXPvPvm5G++HZdi/xnuM5s
 gNOTzCkjkiPfVGNrHJ5SP1pkCU91J1aD9zgze7Ptsm4dmBU7tliMk1cLM0Qfaa4CJZuL
 oi1IvTK3pdLZ81imyFVhK+4SkxjS+v3zsv1bAX0z8CiKAT+o8IDB4TMWhByPkQCLAAkD
 1VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6/qaW5FhSSy22a1eq657fqQZKhtniwywOQUUl7vYYwg=;
 b=CHAJfr9xl8Ao+xLqrQUE+loc3N1AQfyYzNqO6zWjVTVZ4QSVmGH+tFLfqeBT+67H98
 ev/A0RW3yLwS59/q/VpqeJZTBgZsV4oW8o6PTAJBrrrC2Zvqf6lLI8FMdP2UmnVtPeNQ
 l8uZT9tlJ3MiOcBN90L0rKwJy1kyP0Yi/uuUbYEeR82A1ODJ0kVPrSbavf1fIsWEQJ+5
 xFfXc6JesXXpo4D/X+gXqqXxQrfQheF3MBvsi58Ff1fckdY6aTdnBmRCGDAxpBj5+B2n
 sEvZiYAhil3otstgziYbLaQUPelALSrP5+0QCFmuwJMXO1M95FJjQBTTXgZzAkRL2OFc
 TPAQ==
X-Gm-Message-State: APjAAAWNokG2fO7JR9wltiWNFcNjN936sGcvgMeaF+1xRgzHgpvjJfhv
 D4L3ACWQVXiSeV430IAoLAlBCXL2rDIwyNKYRL8fuUIZ
X-Google-Smtp-Source: APXvYqybnEmdFf7yroCXFeAsFScLANFmfz3zoeODV5liVx7hJ/djco4Ujk9ffetnwRtipfKw+lN4m/OHmq845o7XC0I=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr24119120otd.91.1582210560070; 
 Thu, 20 Feb 2020 06:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20200216214232.4230-1-richard.henderson@linaro.org>
In-Reply-To: <20200216214232.4230-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 14:55:49 +0000
Message-ID: <CAFEAcA9DZjwazY4rVwpzWGF3ONAQBGyqNdMjBBczK0C1dB+kKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] target/arm vector improvements
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Feb 2020 at 21:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v2:
>
> * Rename function arguments as requested by ajb.
> * Minor optimization in helper_gvec_pmul_b.
>
> Original blurb:
>
> The first patch has been seen before.
>
>   https://patchwork.ozlabs.org/patch/1115039/
>
> It had a bug and I didn't fix it right away and then forgot.
> Fixed now; I had mixed up the operand ordering for aarch32.
>
> The next 3 are something that I noticed while doing other stuff.
>
> In particular, pmull is used heavily during https transfers.
> While cloning a repository, the old code peaks at 27% of the
> total runtime, as measured by perf top.  The new code does
> not quite reach 3% repeating the same clone.
>
> In addition, the new helper functions are in the form that
> will be required for the implementation of SVE2.



Applied to target-arm.next, thanks.

-- PMM

