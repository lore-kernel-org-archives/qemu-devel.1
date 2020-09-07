Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E586C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA3A2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO6UInV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA3A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNhv-0000Pb-VP
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFNh5-00087M-GS
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:24:51 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:43720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFNh3-0002Kj-Qu
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:24:51 -0400
Received: by mail-ej1-x62d.google.com with SMTP id o8so6400105ejb.10
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=21fQHiNFtOo6sbqJCTuae+9V5Wy/XSRdOOW8gWIJZS4=;
 b=OO6UInV6BdLlik3cQlf0q0ZjXaJaScUttdIXZLRhRDGl2yOUdzrGAF4o4QGynFyWz8
 89xzFTQoKFLKg1QKYvmwNaC1zgdtjAc1bQ+1uhdk6FgrLSRM3j+GxA2evt5p7jpdYehH
 js9RMBTAU6/aef55oGSG3UHySgWHfTLR4s0Y/yWRLb6egNonFpLGf3tiCzGR5g7o1r5z
 9q3JCRsr7GSzhWAsnqFVYxRNpka/sqgGSntVH2jBMLoXSCVDCWXMylgPE6uLtJJnyuSF
 9QO1gVH6D4XqaxexP9Xn7I8JpH4bgDmShdqWuNhiw7X5RBK4+iggw4yuORMWPqA421mJ
 gACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=21fQHiNFtOo6sbqJCTuae+9V5Wy/XSRdOOW8gWIJZS4=;
 b=ju3AZdP+yWXibd/ak/l808UkE6BYiX7pR8j846XBk0b7oKwDNi8h5jPgabh4ir9LuG
 LM8A6pDsgIQCcj2mbR/LucHRfpFX+LupQOAD4Q2bNx57rafNQvKAroOWNyHHT7idVK2D
 1U2Qkh9TsxyCVoBVcmpifeMCKQYyc7rNBNRaip+Whu7fkf8c5xejGu2kFYwg3TMCyctr
 7Ol8awRLqyCjXKgx//OKf+HgebD4Ge/Dthrg2RogaKatp6jMLW1uB4ooM59ZgDSgsfC2
 R/QiNToZ5qlF0LAt5EzTM9HfJJPBxPOvk0QTnLi4iv/pXO1qbDptLjGqfSI+X9qW0tc9
 DnMQ==
X-Gm-Message-State: AOAM531Ofo56cWnFN0QFFzkWfKArBchYe+Qay0X0aV7y09XvSxTnaFa/
 ZQaoBYOKo6Pqfbm9mrLdhRUgttppY6Kiw92JSvUCsQ==
X-Google-Smtp-Source: ABdhPJyj2jwbA14Br5CNnkk2ZKU8YSbPi+jwLMBT7CQO8xaY3gIqZpxRZf49yQgMlwXWleSnu6XUqeV5Y2pOiR2RSSk=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr22043457ejb.85.1599510288088; 
 Mon, 07 Sep 2020 13:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200903160746.27491-1-deller@gmx.de>
 <CAFEAcA_9Dkj8dJAxLdhtN_6Xw+ThX0J-s0LkG1J2mnJdd+NLWA@mail.gmail.com>
 <c27d1e75-49cf-37a1-b46b-60a35909dc4b@gmx.de>
In-Reply-To: <c27d1e75-49cf-37a1-b46b-60a35909dc4b@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 21:24:37 +0100
Message-ID: <CAFEAcA9Q_areoERnyZCWEm5Xj90E77z+cYQ+Qu73UpxknYzW1A@mail.gmail.com>
Subject: Re: [PULL 00/10] hppa power button support, graphics updates and
 firmware fixes
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Sep 2020 at 20:12, Helge Deller <deller@gmx.de> wrote:
>
> On 07.09.20 20:29, Peter Maydell wrote:
> > On Thu, 3 Sep 2020 at 17:07, Helge Deller <deller@gmx.de> wrote:
> >>
> >> hppa power button support, graphics updates and firmware fixes
> >>
> >> The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3af90d:
> >>
> >>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' into staging (2020-08-27 13:48:12 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://github.com/hdeller/qemu-hppa.git tags/target-hppa-pull-request
> >
> > Hi; this is a git tag, but it is not a signed tag; we only
> > take merges with signed tags.
>
> Sorry, I missed that.
> Fixed it up and signed it now.
> Can you retry?

OK. (In general to ask for a retry you should just resend the
git request-pull cover letter, because that will be caught
by my mail filters, whereas an informal request for a retry
is more dependent on my happening to notice your email. But
I saw this one, so it's OK.)

thanks
-- PMM

