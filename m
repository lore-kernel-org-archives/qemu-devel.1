Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E031BC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2CF208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E24QdBvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2CF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxRl-0008A6-Pm
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhwX7-0005ym-AC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhwX6-0002Pl-2d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:39:49 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:39965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhwX4-0002Jn-5j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:39:47 -0400
Received: by mail-oi1-x236.google.com with SMTP id w196so9960104oie.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PDmWidKrvD/y2fTMkxiBv9aI9NB2AMPqoDgWClnvVbs=;
 b=E24QdBvP97h+i+g9QQ8/1sFAi7O00cikDZZjny+lY4tSFO3wQqNUKuQs5Qf58ZnPff
 mbzcX/AjADoMRPRWQLxl5OkskPxDP5qayRbBa8+fKdtPNJunfLC2Kd83nOqTtC+ZLUdz
 PIKDKkYEQQZgU0qqj6u7A59BSvfKUCYiS4pN9aQRxmUOEa/Nta0qA5PZrFBSt3JHux/D
 46xNb45fIRkwU40Om6pdIC8PDxWvC+LX3mWfOUOG4/jp+08LBBEBqQYTMUrz1Phe/a6j
 QGuLX4ts9uW7ka6wtzGgnM65WaTRls8NDgsAYQBd26/BwlBzELYk322JPxwlHQe1G00g
 24ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PDmWidKrvD/y2fTMkxiBv9aI9NB2AMPqoDgWClnvVbs=;
 b=dMLRmdsK28wdQN7gIT10t9i2aRfT45AMLuoAhOTcplt3gPy2wKd/3L+u5wPEDenwC+
 4BoNsak+l0ohRuYgRS+RUA67e/SvfIcQXAAUydNxg4/DAY5HSu8eF7M6vV2xOtlgqow4
 HDyJ75SojffzBkQuNyPXMObh8v5DJqJdhTqaAH4W5Kodq6fdV/hSh1miZeaoYEwWUUzZ
 7MRvte4/MlPyd/oPtRdLkHsAwttfP6aYF+i9B35VNNE4Enouywlb9xr4846qA4faMRjM
 6YLfSlbdhqcDgigYIK05+Nzw0Zv4HRU9fCuCzFRsgJO7ZvE1KEMg1n8SfNg/2sMptM0T
 NzHw==
X-Gm-Message-State: APjAAAUn7YQHh3vfx1QD3Z//1dIg/dDyUZ81A75mtNWQAuL0ofTvSxDc
 loa/mJDxEeSb2SP1BnZJNJEEi07k6qxlP1DCsHxsxQ==
X-Google-Smtp-Source: APXvYqwf1ggTVidcu/P2XV10IR7eKEpKptUSOBLi7XlFowNl/4ilOHmmEyBz/tL0p/F0zyE/GYXE4d5WP5vbJUIVUGs=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr6977039oic.170.1561988377831; 
 Mon, 01 Jul 2019 06:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190625130658.24895-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190625130658.24895-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 14:39:27 +0100
Message-ID: <CAFEAcA8NW5LkEzEWab=aWF3L96WHzPETk34qz=D85vtRBHtz1g@mail.gmail.com>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 0/5] tricore queue
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

On Tue, 25 Jun 2019 at 14:07, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20190625
>
> for you to fetch changes up to 8317ea0607a2d01b3cb6329aef1b8c8ca00471e1:
>
>   tricore: add QSEED instruction (2019-06-25 15:02:07 +0200)
>
> ----------------------------------------------------------------
> * Add FTOIZ/UTOF/QSEED insns
> * Fix sync of hflags and swapped args of RRPW_INSERT
>
> ----------------------------------------------------------------
> Andreas Konopik (1):
>       tricore: add QSEED instruction
>
> David Brenken (3):
>       tricore: add FTOIZ instruction
>       tricore: add UTOF instruction
>       tricore: fix RRPW_INSERT instruction
>
> Georg Hofstetter (1):
>       tricore: sync ctx.hflags with tb->flags


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

