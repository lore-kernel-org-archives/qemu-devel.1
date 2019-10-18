Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96CDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875D5222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHVDtRhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875D5222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTfm-00067k-O0
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLTcB-0002co-HU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLTcA-0003Ur-GY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:52:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLTcA-0003UP-Am
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:52:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id i16so5444917oie.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OLHBysFJS0lfg0J/jMlw+h6ruLzMa+L66uzwj8PuqEc=;
 b=uHVDtRhQxtvRL8dMMEJzV8XujeNWDVNp/Qe9STqVBZlcid7jSRKGBDqgSmWqdNxIHm
 NQsxMcTC5yd+PvVFqD+NKCrexbdvadRe32QZ5AAui3fJpXlXEIxTAHsTNdmSpO91oUVy
 6WpWs6uJyuJVwS0Mr5mim/u5p8qmafImRFWwtezJCYYjkVjYAj8bbsX8GB2bJbP1QRRz
 eMPwC1XRnX7+2naVzczoZ7qUJTlD71pTnwMRNUy9U7/jRd+q+vvv1QtFTax0umWNVnH8
 436yNSwRqGCH3zG62gQmyfjba2wtiCXnwcGCidM+NYZprNQT+xmG6JjYscyvEGTlBsel
 H8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OLHBysFJS0lfg0J/jMlw+h6ruLzMa+L66uzwj8PuqEc=;
 b=hzsoSDPvP/8cSx4N+z5ILT0s+lBPrxRKJ3peAdfAJVRCUi4tvKoDFjjbvsD9TdUNpr
 A05iERpDwDV1fW8z7xECGB8mLgMdASZvtzc0JvNwHuz8KqFmJyb1ae65qxEkOW2Asnyj
 rVT8m7cngshIXi2x39lsAsLargoy6o0ZPGc8XODqIhSEVaxf+Yc0LbnfM+GzphuNA6Zm
 l19BaGCNF3RaB0k7HDaruwyKXIDabNowWVrBNspleWNsmU1f/s5IjYMpZH0EDnJyYDu8
 DIG7WvNolUxAHBgwrf6fLTc+Ba32DEMeHdKzxDs4WdwnzHxEKDk3HwC75QHQJfOCTlhd
 2edQ==
X-Gm-Message-State: APjAAAX5IjQM1vSy8IK6Sn251KwOQbtWDMaLzhuwoPxCs6uWRJT8OsXg
 nM3EB1/yqQuSMbwB+WZwq49Xhjn01DQC4HcBcJmEig==
X-Google-Smtp-Source: APXvYqzGVKheXlX1myqlrFD8Yfj2jYxvRRu8eFny3WT7HCRMFmFQbcjw1AmK+qmrxNBeNsMvHKLotLwugfCVsE1GqYU=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr8462864oic.98.1571410345685; 
 Fri, 18 Oct 2019 07:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191017185110.539-1-richard.henderson@linaro.org>
 <20191017185110.539-20-richard.henderson@linaro.org>
 <CAFEAcA9oJ0P-g87caLKyT1mS2k7YhtNXAOhSgXuMy0bCGwX0WA@mail.gmail.com>
 <aa753ee9-40ce-d6c8-801f-eda74d76fd3d@linaro.org>
In-Reply-To: <aa753ee9-40ce-d6c8-801f-eda74d76fd3d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 15:52:14 +0100
Message-ID: <CAFEAcA--tmMXeFauHRAFeeLr+MXmQq4qcsoxpx1vOVM7ZuLoAQ@mail.gmail.com>
Subject: Re: [PATCH v7 19/20] target/arm: Rebuild hflags for M-profile.
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 15:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/18/19 5:25 AM, Peter Maydell wrote:
> > This seems fragile -- we have to remember to add in
> > a call to arm_rebuild_hflags() for every individual
> > case of a memory-mapped system register that we choose
> > to cache in tb flags. It doesn't seem consistent with
> > the choice for A-profile to rebuild hflags for pretty
> > much any sysreg write. Maybe it would be better to just
> > always rebuild hflags at the end of nvic_sysreg_write() ?
>
> I thought about that, but there were too many returns out of the middle.  I
> suppose a wrapper function would take care of that.

I hadn't noticed the early returns from nvic_sysreg_write().
You could just turn all the 'return MEMTX_OK's into a
goto exit_ok and have that do the update.

thanks
-- PMM

