Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63858C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3752190D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDdkxL5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3752190D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZeO-0005je-Bu
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41406)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpZeB-0005JF-Tl
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpZeA-0005Is-PK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:50:39 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpZeA-0005HZ-IO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:50:38 -0400
Received: by mail-oi1-x241.google.com with SMTP id l12so29788765oil.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=LC89guX+QAKyQOxKoo42dYimgmCIYIt+/7EsVAt0uIk=;
 b=EDdkxL5P9HZRhai494Y0ETHPUINImKbHc8Ze5HmdaSoGQYdr9DSyL7hind3TAIdJZh
 cOXvmIYefowwriyCA92UkE91vg4KnONL41zFmeKJ1eq4IKjoZbq+rpH9YN+Jm72tiOSC
 rgMFKZnF8Vr5mkp0AMSyyx4hUPSmZj3IzlEoxF1JC8rmZsH/kIBfsbto1oKPnCBZ7BCm
 kGWYK/Ro43izJ98pcWuJAaN1je9ZC7fYAII/mmHFw4Zub8QaFAdXsfuinVBal7/gkG+x
 p67XCO5Dklf/JEh6Ux+0JM/wFNO5G3OpZxqrcPZOAJd4tvViEq96oWonYcP14caqgPdJ
 PJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=LC89guX+QAKyQOxKoo42dYimgmCIYIt+/7EsVAt0uIk=;
 b=Us0O49yR9xlDFF+J1Ei6F7aoPu4GYnj/Wyb1xUJBBlGU+8ROCHGD0rKBxM5tiT3F2G
 crkFB8exJcT1/1PEsu3pH162NT6Lj3K1Dl46MI8y6AWDnwrgB2b3phfdW9n491/uvZBq
 G2fSpQJBAl4AXh/t9vsIsPhji6sRyfpy1sEKcr4lJAbkTx5uclvv5ZmIvC4wQgRwLSMm
 p1kxRJh5XJQEUFKtaYjLE2VBbqvnEJO2I5FCFgOeipG7g3wOcmzT5px/vG+6soIY+1Ze
 Gfo0AkBcm/uQoRsrM2RB0PF9njuOtVFeyS3fmwASQUv7Gtx1Di6bBzXDFK0MMlaTawIq
 B32A==
X-Gm-Message-State: APjAAAX7N9f0+axjomerPGEVXEusaJflMv+4fvJ8m5oq+pM2LmaCJixt
 41U9rr2C5Drxhj8h1mkuAGsnHKt+UAUadtVNN0MitSi0BdU=
X-Google-Smtp-Source: APXvYqxnGE23Sy3fuCyA3LyDhhsC1Ncn+cuYBEL8Yb4mCxouCsM2geYJ87hWZiFR+H7A4a8iJGpURkEUFNygCNDHhuU=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr31342392oib.146.1563807037521; 
 Mon, 22 Jul 2019 07:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190722131427.2669-1-peter.maydell@linaro.org>
In-Reply-To: <20190722131427.2669-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 15:50:26 +0100
Message-ID: <CAFEAcA-_Y6uCWpF03mwT=qd2XxyYBqy2-tW-o5uDYpNKaWLvsQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/5] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 at 14:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue for rc2. This has 3 Arm related bug fixes,
> and a couple of non-arm patches which don't have an obviously
> better route into the tree.
>
> thanks
> -- PMM
>
> The following changes since commit b9e02bb3f98174209dbd5c96858e65a31723221b:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-07-19' into staging (2019-07-22 10:11:28 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190722
>
> for you to fetch changes up to ddb45afbfbc639365d6c934e4e29f6de5e5e2a0e:
>
>   contrib/elf2dmp: Build download.o with CURL_CFLAGS (2019-07-22 14:07:39 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: Add missing break statement for Hypervisor Trap Exception
>    (fixes handling of SMC insn taken to AArch32 Hyp mode via HCR.TSC)
>  * hw/arm/fsl-imx6ul.c: Remove dead SMP-related code
>  * target/arm: Limit ID register assertions to TCG
>  * configure: Clarify URL to source downloads
>  * contrib/elf2dmp: Build download.o with CURL_CFLAGS
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

