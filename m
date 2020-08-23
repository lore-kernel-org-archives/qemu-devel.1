Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D8C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 13:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5805E2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rRvsiwsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5805E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9qSo-0004ne-Iy
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 09:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9qSH-0004HV-Nr
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 09:54:41 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:43037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9qSF-0000NR-5k
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 09:54:41 -0400
Received: by mail-ej1-x629.google.com with SMTP id m22so8573857eje.10
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pS2uYcoh5JOvhCPq1cfMXlW1IlVsFYcndkWIDgm/cwQ=;
 b=rRvsiwsT9X4vU1vmBZXT30vnvlT6mX4riz5fGsTasluE3QTzfSzO+gga40o0OfDoGw
 K8wPnhxjowJpZQepHcyWlDtz0m9XGw/l5B6hjxYQ5XZGmZ2aPF0KwkSzvYa/PfdhzWC6
 bSGwY+OBuK/V5K9D5hROOMVyr44s3/M0IIZvjsKP65CL80GKCKWDW8ZQtu12z7N5mNTr
 lHm9sd2Gt3CAZbfOSZ3IgcXCAyCnrbgSFIg48ralobvAV7sfuMj+cwWSl/AtRTilCAJI
 i/YAV4SPQSlm6en6h3LySP9f9nsYwY47FHTGnu+Y/H/RYd6z3Z8r9m/oCdY62Ay0m4an
 74hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pS2uYcoh5JOvhCPq1cfMXlW1IlVsFYcndkWIDgm/cwQ=;
 b=IiFiNyvGS3vM/nYhXbGM9ug478I6KFRWk23xri1lk2rqM3pbG0nSFd43RQD9qyDkVy
 chfo8zogUfGSBYAYrL+1s0YZJ9VWoX9LxCKUeZA9cgi52fcM9JsCJZ1Ych1H3CY9b4jz
 lVtN77fQBGeFxe6Z3+htBHVrxkqCj3EY1BPBcfOZTAKA3tWx6SBNPm53fRNaszXPBJB9
 /Stmdy90zLUVk1uvDkPHivnxYAG7slcsVo6QQfBh8zkyEr5sd+aYDteGN/slMOeNKt0p
 XuyRcHjOxA7gPwBtZPaluW4eubN49arZH/oVxI24PoJhwUN0RLrsH6XV+/eAOrx/60II
 2dtg==
X-Gm-Message-State: AOAM531VnLwK/PApqm+CBAQR/4JeOfH0SXD4CsAWSN6n1i9LImtscrf/
 g6zCa5Z/BcXHjnX/muxb/CNTkxmM9AJwuD12hm+9fQ==
X-Google-Smtp-Source: ABdhPJy+3BYYxdF8Aq3GTEZrowifRvaKGXCH6dJ4oHx127YGt6UQPwoOupYKvrU8HlL2zCWqo8YYDNoE1iDYcX5DTqg=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr1522819ejr.482.1598190877586; 
 Sun, 23 Aug 2020 06:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 14:54:26 +0100
Message-ID: <CAFEAcA_=qV+B17Z=XZhaPK_dvhBOkGutNmCHYEP4xTYKnzukZw@mail.gmail.com>
Subject: Re: [PULL 00/40] ppc-for-5.2 queue 20200818
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 at 05:19, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200818
>
> for you to fetch changes up to 3110f0ee19ccdb50adff3dfa1321039f69efddcd:
>
>   spapr/xive: Use xive_source_esb_len() (2020-08-14 13:35:45 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-08-18
>
> Here's my first pull request for qemu-5.2, which has quite a few
> accumulated things.  Highlights are:
>
>  * Preliminary support for POWER10 (Power ISA 3.1) instruction emulation
>  * Add documentation on the (very confusing) pseries NUMA configuration
>  * Fix some bugs handling edge cases with XICS, XIVE and kernel_irqchip
>  * Fix icount for a number of POWER registers
>  * Many cleanups to error handling in XIVE code
>  * Validate size of -prom-env data

Hi -- it looks like you've updated the tag but I haven't seen
a new cover letter. Do you want me to apply it?

thanks
-- PMM

