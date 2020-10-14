Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4546A20848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doG+Nmg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4546A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSg5f-0001Ry-52
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSg4S-0000g8-RX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:39:56 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:45572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kSg4Q-00074O-55
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:39:56 -0400
Received: by mail-ej1-x642.google.com with SMTP id dt13so4561673ejb.12
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Tikf6X+wx5WDdPE8qGQIsJ1PjPO9vo57cY7mn/bJS0=;
 b=doG+Nmg3I+PLqB/wxooowpDYV2m9bBtSEU9F9VyTjT0105enGw1wQC01lq4pgzHk+Q
 HfA4iENbX0pGThVBUnJd80aniDJ1siAj+G2bp7vBpv6bc/fDS3sq+nBIC6NrIBV2eDAJ
 HgJX5QpQOKsw5vZDa2zoclG7y3IPIZmoP2AIhDt0Oo0X8OGPzMvkiP6GomKix6Wt4xCW
 mS9R31R7VVGWyoG5F9GKHpwf2Q5qGqfoJiORBxbnnm03dHCTN3dQDp21F0vzQFIVAp6R
 JbVIfhbfBab6GT2ejPO7Nl/Y81Dm9puZ5D44M8vFqmPtnYiy7rlHSwt2cdtei7UTIN/2
 u0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Tikf6X+wx5WDdPE8qGQIsJ1PjPO9vo57cY7mn/bJS0=;
 b=DFBMkwOt61DcoK9CUuAKzzMwsKfcG+zGMUeDQOesKmPt/cErW+ZuaZU/r3Suh83XYX
 DBX7nDjn2kjjW6lA23EeL6cMSdPL9WQexck3NGJgwzRmdoOMwhCp+do0mF1r45Wl29Oz
 uQ6WM0ZWyd1V1KEQfMtSLU/p2cOoDtsOSN+UPrXgviw/d+PkFviI5ZihBdGW/Z6GvQ6n
 MAOh4NsWYYL8Wn/7tjG+Dswi8TscypZ7o7z+WLgHVXteabauAQ/KGbhNLEBI2e8LpPlW
 YGAymwdiSHVJyIiwbSQECdsqQeMONjUy4Z2ax014IrDS6NWA3dd3Ml+0BtwbEVva4ccC
 tLvA==
X-Gm-Message-State: AOAM530R1LgAos0p7/NxygJ1QzmBXIw9wVoTbvO9oS+lOJPCwmBT0P8G
 4kheZmN2XMWdXKSV8vMqt4taI9aZE4AgfPjH50SzbQ==
X-Google-Smtp-Source: ABdhPJxMbNu0PfVnnf758kOpLKoWtOqM3PFUTcpJmqNQxM2qD+xAT7WFC/teU4qfoBRulEiazqaUq8KzT8T4ggEfaDY=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr5139718ejb.4.1602679189139; 
 Wed, 14 Oct 2020 05:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201012153408.9747-1-peter.maydell@linaro.org>
 <20201012153408.9747-13-peter.maydell@linaro.org>
 <CAKmqyKO-bRg0WcoqXnt1oaKtgzKTdajwJ-U2YfZh=PzvP77xug@mail.gmail.com>
 <CAKmqyKNpkFmXD+FJHXy4MGL03pUkXgWQLz6qPETB0TQBORwkFQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNpkFmXD+FJHXy4MGL03pUkXgWQLz6qPETB0TQBORwkFQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Oct 2020 13:39:37 +0100
Message-ID: <CAFEAcA_WqxjOFkSmhoNnJUax9u6O6+fk6S-shWWjYK91RBBv5w@mail.gmail.com>
Subject: Re: [PATCH for-5.1] hw/arm/netduino2,
 netduinoplus2: Set system_clock_scale
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 14 Oct 2020 at 01:42, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Oct 13, 2020 at 5:29 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Mon, Oct 12, 2020 at 8:45 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > The netduino2 and netduinoplus2 boards forgot to set the system_clock_scale
> > > global, which meant that if guest code used the systick timer in "use
> > > the processor clock" mode it would hang because time never advances.
> > >
> > > Set the global to match the documented CPU clock speed of these boards.
> > > Judging by the data sheet this is slightly simplistic because the
> > > SoC allows configuration of the SYSCLK source and frequency via the
> > > RCC (reset and clock control) module, but we don't model that.
> > >
> > > Fixes: https://bugs.launchpad.net/qemu/+bug/1876187
>
> Thanks for fixing this Peter.

This is already in master (commit e7e5a9595ab) -- this email is
one of a set of stale patchmails I sent out by mistake on Monday
when I mangled a git send-email command. Sorry for the confusion.

-- PMM

