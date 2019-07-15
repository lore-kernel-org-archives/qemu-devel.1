Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EBA2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFvH9upI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EBA2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxTE-0008UE-2l
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmxSw-0007gU-0o
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmxSu-00017x-SW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:40:13 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmxSu-00017Z-Ku
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:40:12 -0400
Received: by mail-oi1-x22e.google.com with SMTP id w79so12133724oif.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4YGDqLsmMKdUQArxKpRRGLZaE9n3+/IHr1VYYybjd8M=;
 b=lFvH9upIRMo9ZtT3IpTLuZmOf7wSXjZ1+WxE7jyePnwce1HkAaDlvb6XS/GbVuyXfM
 21Kd07QO9NdjgOOf4IggdrdKTcfqmEEASTiLNMgZ2sGJQQpziYlI+SgqH2ZwHI7osr8e
 d7iGVb+w1ahuyb0WWEUUjre9BOgsDAK5AniN7j3ZD5LTVrBkkuCaNI0/QeoE4gUjHeVJ
 09wMuEn0s1eQAHn3MZXwj8l4ajl/mdUfUaXImhGDF2VsqGV7devmeuCJxKH458lQASph
 XtWHJHkdBcqRsHemIm4k0meuTxiiF79QIZ+oK6VL4zRMAFqG86KLZwa3v9CBNMtzE7FP
 fwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4YGDqLsmMKdUQArxKpRRGLZaE9n3+/IHr1VYYybjd8M=;
 b=iR/ODFdHV+kKcQst1EfDKSn+cP5gBwAP57EXpGcDEkCiNj6Qh1dNCR/MOrJEXOWhPq
 fJ9IiXpJRAF4gCKCiPbIYLkQo2cK7wELEmYT7Ukhr4ULhD3in7HbiQIBywA7Pf9hdc/v
 vfBMvhU6pnueSxqTMuTMGyTzyWAQQf+lG0SEYf2/2tDGQI0aFrCR8B1nAZ9eYqKOKlhB
 2V+HdiFxR9V78C4Xp+Kch9cKKnfqMuOI3Mhp6GW8wmd+NO95WzSZaZHKU6P0xQcS90Xi
 1CLYUIAPb6Y/WHVJQmvTgwJhHe+97dw5rF9BfwBpoH93Ctcz2juT9bEpM6vSyWQP4pBM
 NpKA==
X-Gm-Message-State: APjAAAXtz2oVgmnhj+GAN6InFKVDtrk/ahIfeNTep29QjFST3Y3IZtsz
 rl9s2PXTPZQ2GRHPSmoyqGW/XMkXDpdVYX810sFrOg==
X-Google-Smtp-Source: APXvYqz+Cjx4auC4g9+yk2TgiZQGoVbwsT+caTdpqywXlzS0vM2O3W9XKj+i8lfAaBO2AVygZHLXUlweMYRuAjem7fY=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr12213300oij.98.1563183611543; 
 Mon, 15 Jul 2019 02:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190714111249.13859-1-richard.henderson@linaro.org>
In-Reply-To: <20190714111249.13859-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 10:40:00 +0100
Message-ID: <CAFEAcA_m2w6hOunDzWp5VxKs9sag=LMfZ2Lg81Ypvpy9LiiWFw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL for-4.1 0/7] tcg patch queue
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

On Sun, 14 Jul 2019 at 12:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
>
> The following changes since commit 1316b1ddc8a05e418c8134243f8bff8cccbbccb1:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-07-12 15:38:22 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190714
>
> for you to fetch changes up to 52ba13f042714c4086416973fb88e2465e0888a1:
>
>   tcg: Release mmap_lock on translation fault (2019-07-14 12:19:01 +0200)
>
> ----------------------------------------------------------------
> Fixes for 3 tcg bugs
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

