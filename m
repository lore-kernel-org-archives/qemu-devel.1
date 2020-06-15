Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC4720679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwruqVd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC4720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jks58-0003nU-VM
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jks2v-00019f-7L
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:33:17 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jks2t-0007Nr-JV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:33:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id a21so16423555oic.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZ4DmxB2zYoXRE8UM31nl96bQ+qlZsBO9u/kFs7xhcQ=;
 b=QwruqVd++V8021JI8adp85kG05ULMnrzmQhFE1WH+XPd3bNjhQrdQWp6dJv0wn0WIE
 Dfc1oUt/0qfaUgn7ebPdrUkwEXYF3YyOlC5KkC+KOhwJbDS0qsAILIXLvv+GylQfw6ij
 6wDboyA2rUotdluykXk73HTuT3oQv02JeSkN8euzMUQtIZJWcp1rtEeBoOZjaitwiFJv
 eOhl4FTZ4v/laaxdtNgW7XTTsGtBw2WBZ1QO8ED5P8qsZIBqq8aS8TRyZfbVlrkzcOhk
 CgCgTSeqOqOyK4oqHL59MTGvR2Yg/c6F4EaTCjEOkCacKBkSyPcocQiCqm4cmR2jcakr
 D24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZ4DmxB2zYoXRE8UM31nl96bQ+qlZsBO9u/kFs7xhcQ=;
 b=s0A+2oSSDeWLWwkgjd+uTWEIRfpvgPjIR2wONivwlzmpe+jMJKlyexUE7eFU6eLjck
 ZitqDjCnXO26ARKDPpCq8sA0CMl+77pg85j/cHduihp9O2pJtmv4KpBrZlQ3aECeQyZO
 Z7lfYPs34b1zFC1EP10P0DlHH3R9mdvGR8pL/cRvpJBIxNS+yHoY77iS289vObqaI6AK
 bFdBcJj0+uHgXVgDmyLJJWIeiLqcDgh2OgnnVlf+bvqYUT/Iwjcx4Ic5r5DppMRN0ZiE
 BaC6/3BUOz8IQvXDHN+Th29QaVR/h5x1zYSHD+ceVBvHCTLij0T2Bw5tzeVgcEewpcja
 6e5Q==
X-Gm-Message-State: AOAM533oyVpmnKwffSJP3nu0eB8TbBUdhgZ8cRnWDXZXUabnp4yyetOP
 3RZ/7BqkTOxxb/EDIcSUEdGMkg6iiGJhhr2tTONqbg==
X-Google-Smtp-Source: ABdhPJxPws0WUhck7/N1S+AEotpA+B+gjhLwOD5mulJfDsuCUGa2Lf2CwPqqFo36G8if043TiIN3vsA+pI0vLfpncXQ=
X-Received: by 2002:aca:568c:: with SMTP id k134mr150567oib.48.1592238794548; 
 Mon, 15 Jun 2020 09:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200615151449.19818-1-kraxel@redhat.com>
 <alpine.BSF.2.22.395.2006151822170.51837@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2006151822170.51837@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 17:33:03 +0100
Message-ID: <CAFEAcA_iTpaUsuhyJyaaNUzKTrELSPH0QfPdnH7bTYpKDA07uQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Vga 20200615 patches
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 17:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 15 Jun 2020, Gerd Hoffmann wrote:
> > The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
> >
> >  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
> >
> > are available in the Git repository at:
> >
> >  git://git.kraxel.org/qemu tags/vga-20200615-pull-request
> >
> > for you to fetch changes up to fca0b885417497a973c56e6d4e0d88f9f7a0e71b:
> >
> >  sm501: Optimise 1 pixel 2d ops (2020-06-15 10:52:53 +0200)
> >
> > ----------------------------------------------------------------
> > vga: sm501 fixes and optimizations.
> >
> > ----------------------------------------------------------------
> >
> > BALATON Zoltan (4):
> >  sm501: Fix bounds checks
> >  sm501: Drop unneded variable
> >  sm501: Ignore no-op blits
> >  sm501: Optimise 1 pixel 2d ops
> >
> > hw/display/sm501.c | 58 ++++++++++++++++++++++++++++++++++++++--------
> > 1 file changed, 48 insertions(+), 10 deletions(-)
>
> Seems you've crossed mails with Peter. He sent some review comments for
> these patches. Should I respin with those changes or you'll take this as
> it is and I should send followup patches?

I've dropped the pullreq from my to-process queue; if you could respin
the patchset that's probably the best thing I think.

thanks
-- PMM

