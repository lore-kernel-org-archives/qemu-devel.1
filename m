Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F3C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB68205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0PY2evD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB68205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8liY-0002HF-U0
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lgJ-0000xr-Hp
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8lgI-0001I6-KH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:32:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8lgI-0001HR-Bk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:32:10 -0400
Received: by mail-oi1-x241.google.com with SMTP id a127so2455374oii.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y7trqVJrmkywyB5GZi7yefpvZK4PlUMzNX3LVdRb2vU=;
 b=n0PY2evDPmM7Rp+rbGw3civXogwcVfP6zCrzWPflZjb4FsbZrPlvpwFGf2lsXU61dH
 7tUatyFj3nTW+tnciDjfKlBuqwIUjYux64XTtwsXw1zor6KBG2+u9Vh60f46ezSwba60
 cBOPs3d8+KdVIh8s1YVVTlDcULqLiWkCehsDZ7HlbMvC5ST5xVHpRYwpqLr+dW6AiqlJ
 xGqx2QfUDx00EO6fz9PXNKD7HBBzkbYHGVyhadCc5KarL2SGOppDyxMXiHYSivrlrPWw
 5/1MMVCDUrTDEDZmAQUcgNHo1oaVU/aYVY4XqLAZRrg99UYnJ04Bw6PtYMpz2/PxtUxd
 Wg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y7trqVJrmkywyB5GZi7yefpvZK4PlUMzNX3LVdRb2vU=;
 b=HtMpjLS0UIarxc8FiZ/TNniSF0JUcrrcZhe8lREPm90pRYMmY5Ld7RRZCfFAT/YK9U
 2nIKKPrPqleIMKJxrpeWS4O5HcU+UQcdTerBWX7VWf4uXa2sMdwUKuT1blubAjzTLVZQ
 jxc3KWJR2QJ5iOcusuRG6r3PyYE2txdGzyHlFXPvvnKWdyI5/9IMxi+gYy4CyIypknxh
 D2vvaKbCqRaJF5bkLNpDyzjKqluaYMV9SAjCfap4gBu/iDCXOajDmaC0GjI0okA7WsQY
 1jfgjfM8hTBxqfxjwVNApgoxuk0JTXhjLYvh2IDUoGzuJ+jEMEEDNbHHoNuBBy+SwaUe
 WyZg==
X-Gm-Message-State: APjAAAW9SSAtNtWp7vVO6QwhHaVGxhEiw1nrC7XruKErNLpRjA+BMDym
 mdJIhSyvfh1Rs0bniHNedCKJRUClh7z8pKxp/hDJxg==
X-Google-Smtp-Source: APXvYqyZHOCDoFSlU3MrtHG9XVV7t6SnTiFaA2Q91nDOiN3DbdT/zLj8rEOXIYWnyiCZL2wSQYVWAMFJ8RInJX3xnvc=
X-Received: by 2002:aca:281a:: with SMTP id 26mr2326684oix.163.1568381529533; 
 Fri, 13 Sep 2019 06:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190911164959.11003-1-alex.bennee@linaro.org>
 <20190911164959.11003-3-alex.bennee@linaro.org>
 <CAFEAcA8NsdpEMOH1MFDta0LUswyqSDHCgtOh6g5k3+EU0FVuHA@mail.gmail.com>
 <875zlwz5o1.fsf@linaro.org>
In-Reply-To: <875zlwz5o1.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 14:31:58 +0100
Message-ID: <CAFEAcA-6BmxkFND4nZBFs70nVPEFzSFrE6RMQ1O3ftqozYYoBA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v5 2/5] target/arm: handle M-profile
 semihosting at translate time
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Sep 2019 at 14:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > This is still disabling semihosting for the linux-user-mode
> > build for M-profile, isn't it ?
>
> Sure - as rth suggested. But m-profile doesn't run Linux so why would we
> support it in linux-user?

(a) Linux does support Cortex-M, since it has no-mmu uCLinux style
support these days
(b) gcc test case binaries, which tend to get run on linux-user
even though in theory they're not actually Linux binaries

thanks
-- PMM

