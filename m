Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CD5212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYuQ+2mY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CD5212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSi5V-0000bv-T3
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSi0g-00042n-RN; Wed, 14 Oct 2020 10:44:10 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:34244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSi0a-0007Fs-I0; Wed, 14 Oct 2020 10:44:10 -0400
Received: by mail-il1-x144.google.com with SMTP id p9so5460330ilr.1;
 Wed, 14 Oct 2020 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zQzPKq16yu+wQNP+5HVfVrbp88hfbes34W28y1fwrAo=;
 b=AYuQ+2mYdRPu4kBaT98NJpBbzyeGJGXyuSvjFBu64ETEJMduLeeTfWgZRyj9bM4lso
 O/xN3atcuL6aFI8j2y7TyxnfFFpplbgpUP/a7eZu67wHa7O4q33Xwho0j5pfMCeWTAol
 5heSCbkjE2Nu0TY2Dhm9Gqslan9EgeG7+RYv5TVg1Klz1OSmcH1Bv0753OEt0RoG6dux
 cMqO+YIADHkUB6ZO3zr+JgRBRG0fNAHQW4IObGpkdZ6zLro1XD/ypxy1geRFxqtqFwuM
 fs/bWXg2H0dnsNsJRlSVumyy0e3ke9mL+04QnQ9AoFkrFySjooFJDn9yfssI0O4Kh3LF
 BrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zQzPKq16yu+wQNP+5HVfVrbp88hfbes34W28y1fwrAo=;
 b=nlg/T+Fn+15x8YZCDkq4qYy+PEMat8I+qSoss1jgiGSaSIaM+xCRwG3eRxTWUWGKYx
 fonY3UIdEYD7M9hK3FZSU/b7DHy1n5rwP0mCjM0d6lpdJUZ6C9k+ldRuM/+exiHXQrAw
 gMptpLVdt2gSnBo8hja79+nwbDUDbWKD+tB1d+Z6zoScCr6RzMj2safgcylVh2NFTyjf
 9XPztappGmGXCiMjuaHRoYYQ2/bksxUnX1XclyDGY3DywTE63H+zvDtojzwpk6ZhgKIb
 bjg6xOGbD6eTo5Bu4rIoTvliChOTfKbjbgPjCtJ3XauoFGx8/EDAEAz97V/bd8vL5L2l
 UNSQ==
X-Gm-Message-State: AOAM530RJwOHwSSHJPNhky7RMR5D88ZATbwK/lxy5lMca5dyGqfITJPz
 QtFNSsdm1HWGh5iefdUBbOYXpXibq3Bxm85bSww=
X-Google-Smtp-Source: ABdhPJy14nkx7JsiFDQ4qV3sjDpsWq6d+rt2RpyMeeyyDhymrS2um+tsis//zKWzgPLW8WJAuKaHvtmJmtMoqzyNf00=
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr4357767ilt.177.1602686643126; 
 Wed, 14 Oct 2020 07:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201012153408.9747-1-peter.maydell@linaro.org>
 <20201012153408.9747-13-peter.maydell@linaro.org>
 <CAKmqyKO-bRg0WcoqXnt1oaKtgzKTdajwJ-U2YfZh=PzvP77xug@mail.gmail.com>
 <CAKmqyKNpkFmXD+FJHXy4MGL03pUkXgWQLz6qPETB0TQBORwkFQ@mail.gmail.com>
 <CAFEAcA_WqxjOFkSmhoNnJUax9u6O6+fk6S-shWWjYK91RBBv5w@mail.gmail.com>
In-Reply-To: <CAFEAcA_WqxjOFkSmhoNnJUax9u6O6+fk6S-shWWjYK91RBBv5w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 07:32:25 -0700
Message-ID: <CAKmqyKNdzaZksnYkO5jNTM1L85tA-GHxv4ZL-rr=0arZ+ZYKpQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] hw/arm/netduino2,
 netduinoplus2: Set system_clock_scale
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 5:39 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 14 Oct 2020 at 01:42, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 5:29 PM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Mon, Oct 12, 2020 at 8:45 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > The netduino2 and netduinoplus2 boards forgot to set the system_clock_scale
> > > > global, which meant that if guest code used the systick timer in "use
> > > > the processor clock" mode it would hang because time never advances.
> > > >
> > > > Set the global to match the documented CPU clock speed of these boards.
> > > > Judging by the data sheet this is slightly simplistic because the
> > > > SoC allows configuration of the SYSCLK source and frequency via the
> > > > RCC (reset and clock control) module, but we don't model that.
> > > >
> > > > Fixes: https://bugs.launchpad.net/qemu/+bug/1876187
> >
> > Thanks for fixing this Peter.
>
> This is already in master (commit e7e5a9595ab) -- this email is

I thought I saw that in the bug report, but I just assumed it was
pointing to a branch.

> one of a set of stale patchmails I sent out by mistake on Monday
> when I mangled a git send-email command. Sorry for the confusion.

Strange. No worries.

Alistair

>
> -- PMM

