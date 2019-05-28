Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B97C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 11:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21C52081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 11:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9qqxPK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21C52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVaF0-0006M6-0L
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 07:26:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVaEG-0005xR-Ew
	for qemu-devel@nongnu.org; Tue, 28 May 2019 07:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVaEE-0003qU-Cr
	for qemu-devel@nongnu.org; Tue, 28 May 2019 07:25:16 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVaEE-0003np-77
	for qemu-devel@nongnu.org; Tue, 28 May 2019 07:25:14 -0400
Received: by mail-oi1-x22f.google.com with SMTP id r136so13951245oie.7
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SoBCmq6KJRDdwJy2NVFbtI5+rDtxojn1N5JjLeHUq8Q=;
	b=E9qqxPK1KT41tmg/S8/dkIb6FmdRjHETZuVGugy5XyNTcl1k++3BgXfBn7RBgfzFD3
	7SVwWlCHQVhhXXs4YDjzwoKGaMI4/1aw5cIkTebGjYkgEcrMHhagJhwgwVsYiMnvBecZ
	VMGlMsup6sXxfTwmIwNAktFWLkc0M5O07qyQPedpGcEGmdkSguqvYjGHrW/gUAsranrw
	6pn/I2xuMveVWEdIJBTt+FNLBiC5itXKnd5rRr1xv8tkCG3vPSc/b0BGPu7zvTVjWcC7
	lx5dY0aA4KfC/sSAwBGsBYmADys6Wgbuo6mKQr/snz789vdtDSpYrO2zLH8iKE2GG+4m
	8syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SoBCmq6KJRDdwJy2NVFbtI5+rDtxojn1N5JjLeHUq8Q=;
	b=OSgZnEB0fcjmZwD2MNkAXXZ4a6I8Q9IKNjayDCAJk2iogL654HNooFYcBpYszoQCSZ
	WQl5MNzAzjEO/T6gm7fDeJo5oPgm4OzoEn38yolsL/D2KRP0artKFFeLFtdeay6t5dyX
	amCkrIGj3MeYFlzfOl4e/tuZMTolWUv/2zL/pgAMuGcywGPi7JofZhuQCarOJDOJ0Zrh
	1WbB7EaqypO7QStADSG8PWUiM+s6umEKr5LCfV4Td5BK9xs1SRndyt8wfLXwpWo8AgSR
	NASv7TmRFz+bn8DNZn4PrM3qjTJL9TmJwold6uU9q5hdCoRvESz5FVArxyx9zll2FV6p
	HeOw==
X-Gm-Message-State: APjAAAVQclK3ygSkJr5F6bXlEh5lpZ0ZyBo4Ood0phigZdYfzdgk2nTH
	3/ZTvJk0z4UeRBAwUiS5LD/ly3EwS/EXb1cQVQdGYw==
X-Google-Smtp-Source: APXvYqw2R4XN/hqLW8HXB6RxJzGaPdWf8ri8hiSm4I5S6baQA2Ii4sJZ0p1tqpYNc02fmPYg30/SDOTq/YP5fd2rrJU=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2388915oib.170.1559042713221; 
	Tue, 28 May 2019 04:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190526010948.3923-1-palmer@sifive.com>
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 12:25:01 +0100
Message-ID: <CAFEAcA95yeJg6qFY_ES=N-YzF=L88hAZgUhc=ashibnhAMekhA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for the 4.1 Soft Freeze,
 Part 1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 26 May 2019 at 02:10, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit a7b21f6762a2d6ec08106d8a7ccb11829914523f:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-pull-request' into staging (2019-05-24 12:47:49 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.1-sf0
>
> for you to fetch changes up to 1e0d985fa9136a563168a3da66f3d17820404ee2:
>
>   target/riscv: Only flush TLB if SATP.ASID changes (2019-05-24 12:09:25 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 4.1 Soft Freeze, Part 1


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

PS: softfreeze isn't for another month or so.

-- PMM

