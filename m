Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6216BC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31758223A1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBOtMHWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31758223A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptw9-0004Vf-B7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hptvy-00044r-Nf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hptvx-0002ZY-HA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:30:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hptvx-0002Yw-9K
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:30:21 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so5358845otl.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 05:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W7uBXEfK6ARp4sMsNPa1XXXwnZGZ4gLJ45QXd0vwzVo=;
 b=mBOtMHWn5QxKIVF2nfFIijQKNms+zB46okakzUitGyBcZP/zY9z1cCgfy8RiUX+JD6
 LgW3P39NuWEe8VYyI+CC5gMzfUl081l2NPvPdZooe72r8xGblQmVjhwWyLs1OtGAYCXC
 hNnfbNtWKFEb7A9SWCxduRBiyjd/eWboxkI+WsATLOitoVIn6N21MiQVs9NauybquyqH
 pphbFXiqbZ/P/fSb/MXpear9cBuqkgiFHdQ9r5+Alo69PBIPaOR0PyPlYv14kyssSeIb
 r/3fdayS3IsA/Y0Ybxb3KiJ3aIJBIOmmmnVU9hA92ocGh/Pq5QHuX2txUUXULVcaTIe8
 cDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W7uBXEfK6ARp4sMsNPa1XXXwnZGZ4gLJ45QXd0vwzVo=;
 b=Kfrk5fDrElx2nlReEkxryGjRcUsbDBrVivJE+vXfiWtiP8Y77Mz/wt/tFCCXz9x7FQ
 881cR0YMjGHmOQ/p1D5kp+PZgtKVItoid77m76cpO4L1W/cry8T/997aced9LqYZVznM
 D2OB2gicYiDL6WOZMteFnsfyDjIqYMrdT2sTSExGc3HzMn980YYwcWPsXIi5PvKfOq/x
 LwJFT7hiCkXme7NTAHAR/V3RX0WB6z+tsNwSa8v0erjm0fJ9FJNi6Zb/izlmLm9dbpvz
 RP75iv4GImw78jtREgsbb+QzMDwey6YcYpGL/0pjh6ynRAXSGfroxCsmxIJqlUmhVKnj
 9PhA==
X-Gm-Message-State: APjAAAWxEBQJjVqQHX2kH/Ovwj7mMzswuySuwkG/qfGrV0HM6vW5GGST
 4D7wkltAwQ506NnwYPrvROaXo1p2gqgjYSZstE63+g==
X-Google-Smtp-Source: APXvYqwtKog+6vUcb5g1leeTKIBNCM0lC++9WOCfXsD2fm0vgfLXSpnOtUTAHNqbNhRvHUOWrq56mgspWSSHCkEimfM=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr20052613oti.91.1563885020214; 
 Tue, 23 Jul 2019 05:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <1563877107-5486-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1563877107-5486-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 13:30:09 +0100
Message-ID: <CAFEAcA94D0E9HkQ2-UiqPX6x3M2pCKJdtxUtQND=N+X6b52DGg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/2] MIPS queue for July 23rd, 2019
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 11:18, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu-2 tags/mips-queue-jul-23-2019
>
> for you to fetch changes up to 51229582583a4b64e93f2655153d905e4d8583d2:
>
>   target/mips: Fix emulation of MSA pack instructions on big endian hosts (2019-07-22 19:33:09 +0200)
>
> ----------------------------------------------------------------
> MIPS queue for July 23rd, 2019
>
> Highlights:
>
>   - a '/* fall thourgh */' patch
>   - fix for MSA pack emulation on big endian hosts
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

