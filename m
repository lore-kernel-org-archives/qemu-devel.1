Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12247C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF14B22314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvTyS2cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF14B22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWpk-0007GW-1e
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itWp0-0006RZ-Bk
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itWoz-0002BA-8S
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:10:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itWoz-0002AS-2M
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:10:25 -0500
Received: by mail-oi1-x243.google.com with SMTP id 18so28437384oin.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8z0f483G/o+tJzzynyt5Nymb9+diyELwl+bePXpneG0=;
 b=FvTyS2cFxSkhJl7UivJvyVGn/38I8h+Bln+2V5SSEFc9Kt8/lfLtpGoDedKfr9RWAa
 IoaFDalc88TA9PqLjptYw+0H0mnk/0eC6hXmtfhAV9tybO/A4hIfyPuWe+gVBUyraYnG
 MOo3Fmoj2zjVC6BXMij01Yi24saxvmb/HLL0flqmh3x5JlKzqajYLgB2KP1uzZxzj30O
 4NPsh03klwTVuPgvVfCodwYePQPg3BrVxs59ICmOLC0rRLLbfr2oGyQO+dFpSHaMnJym
 sElDvZPm/G6Qp2HUIr5ZFhfysUAWGQK3aTF/Uag4zVhy1F1aehm1jfkkokx0rrd8GjLK
 ZJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8z0f483G/o+tJzzynyt5Nymb9+diyELwl+bePXpneG0=;
 b=NhpkYZBU29SkBydxz0ysn79x8cAfAt/FJn5MUwynQGXhgc5cM7ppkLsvW0eI29u1al
 W+WNroCW2e/6U75vjs/E0TinDqbXldq0DQoaR/lYEo8gDkP2PDGU+7bvoG0wPYONxAM0
 gd3BNwRwBpCnKZNbwqqDbgzfutT5yLhHhmJebgqGgOUCjz+rwUrF1Df2sfgy8WijsskI
 1yIPElBub7MK4EkaKnAev8VJsiEAFvgBlIPwca6ZRwl9MjY5DVlGk9GSiK13iFP3nNE8
 oMwSgU4GUS3ThIWA4FLIwX7cntiXkAEj4AOHNjkNBiqNyQstG1v5FB6ZV1VvL2sM5M1B
 MFoA==
X-Gm-Message-State: APjAAAVTmmafMpJ4JSXGfr4xrucqPW/299mXNm3YWFJcsX7JMtIDm0/e
 5FRnlZbIhFoohDYgf2Zmakjo+g202MSFIeliT4hURg==
X-Google-Smtp-Source: APXvYqwJsfQ2mw2AtxsEVNo6BOHBFFICSwMNHTAtNOSQ2DnCkDB/AYhgXrmpMcG/Lh9AUlAXf/m8gm9JmSn5HnFMPnc=
X-Received: by 2002:aca:d78b:: with SMTP id
 o133mr12950584oig.163.1579525824021; 
 Mon, 20 Jan 2020 05:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20200116230809.19078-1-richard.henderson@linaro.org>
 <20200116230809.19078-3-richard.henderson@linaro.org>
In-Reply-To: <20200116230809.19078-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 13:10:13 +0000
Message-ID: <CAFEAcA_PMJTDkn5C1Ym46yXsunhddHPAbMyQ=EMpAu8i7wNQhQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] tests/tcg/aarch64: Fix compilation parameters for
 pauth-%
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: vincent.dehors@smile.fr,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 at 23:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Hiding the required architecture within asm() is not correct.
> Add it to the cflags of the (cross-) compiler.

This commit message implies that we're just moving the architecture
specification from the asm statements to the cflags, but the
patch also changes the requested value from v8.4-a to v8.3-a.

I plan to tweak the commit message to be a bit clearer:

We were incorrectly requiring ARMv8.4 support for the pauth
tests, but Pointer Authentication is an ARMv8.3 extension.
Further, hiding the required architecture within asm() is
not correct.

Correct the architecture version requested, and specify it
in the cflags of the (cross-) compiler rather than in the asm.


thanks
-- PMM

