Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C1C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9378420818
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqp4+i1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDdb-0005Op-ND
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUDcP-0004rA-8Y
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUDcN-0006xR-Rl
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:36:48 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:45968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUDcN-0006xF-LR
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:36:47 -0500
Received: by mail-oi1-x22e.google.com with SMTP id 14so6206544oir.12
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6jF/2iHRFMxG11xRFjdm5PHGE0fh1dJYo/Hy0BuOMPg=;
 b=eqp4+i1g94pHHda7ryPXJ0xSGrRqQu4uu/PWX3Dp6IEipGkv96CdFLtTAr8WbIkWOI
 W6QFG/raeRhGcBrOi4VUDeMnRw6bicTW9eBdwm18gEtCA9u7Z/zN1ZVs61LY0xZtbvyE
 dgkjoL3g2Rug1uiaCZwSsyy5P8TtY47uewDBW2xuOf/6dtoTstTvEhjzPkDT34Xw9faR
 0rCWU3IBYlRFrkY3zRfu0Zdzrsht26gt8P2LqpprvgFaSOTP0A5s66f2n/K2xkFSbyEE
 oF9VuQzdNYihhqrTqAeraZLG0mFfxJn1PAZU2PwE6yEwbYaVgeDkkL7qZ2IHo39kj/sQ
 rfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6jF/2iHRFMxG11xRFjdm5PHGE0fh1dJYo/Hy0BuOMPg=;
 b=LVnI+DAwxNeSRi3PD3LkXcW7n/O9HTAXllifrGKYhDWOf6uLxV1gwYPxJtOg1Oo+7X
 Qk6J262hziuMWHcPLRYKkX8q/h3uQ+NYa61vs/vt/UCIGOMWSZz2WrreeTNG2w0Aab61
 LyqO4nWp4hfBGXKxTFUzAND2NwaVK/TmGu1zl5DbbNs+3/gFHp4e+FfqWgh6A/prVzha
 h2Rv+2JRQgQC6J75vyBycAtBRFbyyQlyxHwVmOy+Z0brnjtSiswrSfoMbawdSs8mmKf3
 DPttpJLCPf+WwbzPLvKnABQPmbKh8fDqYVvvEx9+kSarO+oVo2zaEI4HSYVTdJJpuf0G
 yt6Q==
X-Gm-Message-State: APjAAAWPu5uCuRSQqTcEhwSMQ5ykiW2j3UR7R57t4Iol032tRP2wA/pJ
 n7EZvtcrDK4Y+qWo+42qkHE/dCDZJSxhj+jOMcWFYA==
X-Google-Smtp-Source: APXvYqxANiAoSzKn5bG3keGFnZX8YcJANUTmMd8W6xBBvf1SK1PD/2xcq9Xo+wjkHanT4eIiUti6BEg7jr3HBdSlr9A=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr129962oia.146.1573493806392; 
 Mon, 11 Nov 2019 09:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20191111155551.13885-1-richard.henderson@linaro.org>
In-Reply-To: <20191111155551.13885-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 17:36:35 +0000
Message-ID: <CAFEAcA-pJcB_1WgQA1y3wE+QkyLiqBaS=o1Rsg7-ynz6Au3jJg@mail.gmail.com>
Subject: Re: [PULL 0/4] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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

On Mon, 11 Nov 2019 at 15:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 654efcb511d394c1d3f5292c28503d1d19e5b1d3:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-branch-pull-request' into staging (2019-11-11 09:23:46 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20191111
>
> for you to fetch changes up to cb974c95df0e1c9e73a37facd3e13894bd3eedc2:
>
>   tcg/LICENSE: Remove out of date claim about TCG subdirectory licensing (2019-11-11 15:11:21 +0100)
>
> ----------------------------------------------------------------
> Remove no-longer-true statement that TCG is BSD-licensed
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

