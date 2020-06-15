Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB05C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4ABE20663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zm9jnbkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4ABE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jksNf-0002S4-1L
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jksN6-0001zS-AX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:54:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jksN4-00044l-CT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:54:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id c194so16511964oig.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RhTc02SUPXCIhBoDXKpaH4nvryx0HQr1bm7mVp4QOpM=;
 b=zm9jnbkp8IotzeH6faum2UUN9EM0GwYN128gZ1X5htNgQzvN2XobfmlwXtCEKk3FAY
 Sai5Rn6ZIT+kp3HWYxIkof+w4yxQJ9EuN65HZFUnsu4BbFlVDic0VnJ4z2GeWoGG7rpA
 jL4GhljxnNcJxy4Bp71vw1gl6HcZaYFHPgwPVZk7ltsACfBKXT8huq6XJ93mwUZWWqxh
 genwQFJ1NrvAKA+bllH1DqRqX5/19WNEls32Nl5mOW9HMzsyzs/2pLVZse+BqUukIpYX
 LOyCY3UIZAA750nzWhSJgVGC5jfiuOyr/pJxW1ZtTr4M60ByvBhaxAJpS8xpkRtd4Yc/
 5vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RhTc02SUPXCIhBoDXKpaH4nvryx0HQr1bm7mVp4QOpM=;
 b=rmC9lkDV32bXMOT1b6UZK7CjQtLK7vOM5GLaXPh7+LqvbM4tPmGfmJC/Doxzkc4NGY
 auW0WILZe5Sivp5KcAFnDsviQCdsQZqcj05SCkth4pXkFLEhtjfc9RtKnPdOggjx+Ass
 gEyEKXx7aTqeJieNqbxtXPBmcbuNmmcqDJ84EvSkebqNERSfDq/l9HH7o0eP0uhmj0J+
 Qlb5uTScywvlSR5Lt1PLpkmySTSdLnnFCe/gb1pee+CKtyN1Yio1DQvY/BalhEjYzPBd
 PEibyFN1WRlwXj63qQRde6qD03TZQjSgbxtW60Wuv/RCveqW3+5eFkTaX3V9ZgJkTPFh
 uVIQ==
X-Gm-Message-State: AOAM531+F4SIyvugVAuXaYD44c1ANWNU5RaJqNa7llJ3aSMwKtsTf3ya
 pe3FSamDMuT2CuNenzjMcEVvx2yXuBEpsOQSjgBcyA==
X-Google-Smtp-Source: ABdhPJz5Ds/o798EISRwOKvDCeGFyBeJTX7M0kDaYcSeS2gtJ7vZlyLGuFZK7tbC+Zz/XC6PnmMHu4Y9fczwGhUOGH4=
X-Received: by 2002:aca:568c:: with SMTP id k134mr221207oib.48.1592240045268; 
 Mon, 15 Jun 2020 09:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591471056.git.balaton@eik.bme.hu>
 <acb431de2d9c7a497d54a548dfc7592eb2b9fe1c.1591471056.git.balaton@eik.bme.hu>
 <CAFEAcA_WemGUp0YTitXvChsFPzZjOts04zTp2-aPgmFxTC5NXA@mail.gmail.com>
 <alpine.BSF.2.22.395.2006151832190.51837@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2006151832190.51837@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 17:53:54 +0100
Message-ID: <CAFEAcA8ktxFzcj61GydqarczXWh_gkzJ4aa5ZFKqs6s2BCQaPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] sm501: Fix bounds checks
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 17:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 15 Jun 2020, Peter Maydell wrote:
> > The calculations for sb/se/db/de all have a term which
> > multiplies by (width + pitch), which makes me suspect
> > they also need a similar fix ?
>
> Maybe. I'll have to check again. Actually is there a simpler way to check
> if two rectangles overlap when they are given with base, x, y, w, h, pitch
> where base is the first byte of the screen, pitch is length of one line
> and x,y is coordinates of top left corner and w,h is dimensions of the
> rect. Now that I think about it we also need to take into accounf the
> bytes per pixel value (1 << format) because base is given in bytes while
> others are in pixels so these formulae likely need some fixes. Pixman has
> some functions for these but those assume common base so to use those we
> would need to bring the two rectangles to common base which I could not
> find out how to do. Probably this is really simple for someone who already
> did a lot of these before.

I think the thing that makes it particularly awkward is that
the source and dest can have different pitches. That means it's
not a simple "do two rectangles overlap" test because the dest
area might not be a rectangle at all when looked at from the
POV of the source.

Do guests usually set src and dst pitch identical? If so it
might be worth having a more accurate rectangle-overlap test
for the common case and a looser check for the hard-to-handle
case.

I might have a think about this and draw some diagrams tomorrow :-)

thanks
-- PMM

