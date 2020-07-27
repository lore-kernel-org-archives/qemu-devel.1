Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E167C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA31206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgBbOtqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA31206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05wu-0004Rx-4m
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k05w4-0003sY-Ni
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:25:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k05w3-0003D6-0Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:25:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id h1so12719610otq.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X1tUj9iOGSXwys1DTzj/R4q5ca6RREikxzkmG4NDDus=;
 b=fgBbOtqQnKkpzkufmeA1UxQ25Kz/I25KVzhJTCdZIM8LjcvuAbt4L1FaUx35BRQZeV
 GeiyJozfefS+YMvk7LvDhKR7NzjQl+H1sJAHClSLANtNfDybYIpBhBoxCWhGC5ys+6N8
 CwzoqSOHe4ewD+WXVI+UUnbmc669Q0QvZi1h7DMG1+b57Me1MeR41XolHJcRnLKLTJb+
 O7h+ej/hZ+sTmb8ELs4lwvaENhFYSlhT3FDbq+iaHvvsgtutf7BJYOSr1DRtGP5rued3
 th/nyc/dO50ZQr+nhx0iigwnV8Zt9hM+JffJyVlA71G6AkkcSufYqJLAJc5sd+cRnGB2
 xZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X1tUj9iOGSXwys1DTzj/R4q5ca6RREikxzkmG4NDDus=;
 b=ApyLts3d3V0tlQQSo/OgixfPC4PTbmliaMH42GA1Mg6SUE8swIG/bBHhj9I5677cU+
 ybovMFikSwoD9JxJvzLBZ1Glslu+M06HJrU/hCFJFnw+eCfRozGAXv/XevW0UnXxEH6M
 CW9yFJLqPPajuKcmOoYIshFqxHBhqLdwtt/7LHB4ZmhYCj9/nDIlMyKqhAk76XmPjBqn
 u0c5SP5OSMJ016iiKAneUNRXG9GumlzC3kd7JLl3XOzUnsghB8aDKkSeN4vl3p0Z0quT
 nAP3ev7CjKR1/u0dIJ2YBI0adm5oxsYwtVo2KFE1mEJnfwtdabKTuZCINC0S0z2kKUY6
 cTHQ==
X-Gm-Message-State: AOAM531nEPv08UEiERnmFSU7EGg4DAtkvFdHIXDB3DbYUDW+CROVDfwE
 PzPv8ZLaYxHiYjtBAHoyJmKG9BN45DLtlNb8gPrUkQ==
X-Google-Smtp-Source: ABdhPJxU6JT0Qe7s8ZbYKRttVEyYmd7+J9KG/F7Gf2B3wa4qZkF1/LNwPSChVEnMuWr//4XdoFKO2ZNIllplhRI0VMU=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr20925866ota.91.1595867105204; 
 Mon, 27 Jul 2020 09:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200727122357.31263-1-alex.bennee@linaro.org>
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 17:24:54 +0100
Message-ID: <CAFEAcA9n2L0YpwBWpSfSBC6gCNvwSLeKijzAAvq8rqssHBhtpA@mail.gmail.com>
Subject: Re: [PULL 00/16] various fixes for rc2 (semihosting, tcg, docker,
 tests/vm)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 194f8ca825854abef3aceca1ed7eb5a53b0875=
1f:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200725' into =
staging (2020-07-26 17:17:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-fixes-for-rc2-270720-1
>
> for you to fetch changes up to 4a70232b1d26b0d73e1bce60b2c3bdb7e4279d16:
>
>   tests/vm: add shutdown timeout in basevm.py (2020-07-27 09:41:58 +0100)
>
> ----------------------------------------------------------------
> Various fixes for rc2:
>
>   - get shippable working again
>   - semihosting bug fixes
>   - tweak tb-size handling for low memory machines
>   - i386 compound literal float fix
>   - linux-user MAP_FIXED->MAP_NOREPLACE on fallback
>   - docker binfmt_misc fixes
>   - linux-user nanosleep fix
>   - tests/vm drain console fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

