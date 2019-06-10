Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BE4C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DFF20820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfjCP1EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DFF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMmD-0004pV-ET
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56569)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haMho-0002tH-PX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haMhn-0006ks-Ns
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:59:32 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:44815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haMhn-0006kI-HU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:59:31 -0400
Received: by mail-ot1-x330.google.com with SMTP id b7so8750589otl.11
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vYp89AbnzsDTymMdYdQhrc0ansjyxxSfgP3xmadWfY0=;
 b=lfjCP1ENCfCyDuBNo387HfEXswY12uSZs9SEbpIU171HkJK5yfeJzLjBMZGK3LNuk8
 dZCGFwAZK54kgGX+oP4IbUnC37C/10NZqPb3tMEcr2DhA/tiNLmZkxWM1A/eD9v7lOIA
 0Ov1gmQ4ujMslkKFTBeW3gBXzqzhPij1MJVoJEbYZynrp2SLkzIoF1Sg5wX6Uye9UE8y
 fUr2floMjvtUBfn3WAj/lS1SIcCY8ln7duINZ9yqUQ9ePAjgOiszdxFf4cEDhml3axbI
 3/8tDc7UMOTS04Cko8XVCr9TPSPxfxEjCOKieTSCkDpFpNfLXLLIg5EuIAUFQBjNQSuv
 O6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vYp89AbnzsDTymMdYdQhrc0ansjyxxSfgP3xmadWfY0=;
 b=HCAVc55CdM6cnrP373OLdSiedDjZaoe4aN31x5G1Wbyl0IlmFc6GsK8wYLFDTS5iuQ
 KXE3kvd1/CtEezFcnfkoYWGIbVNmNtMPK0vZ2sBDFUBIYJTp5xQY6cnDPuDFQRkJG4DK
 X6a8bNKa9PLUAbFba/tNg22xmUerpF3nMGKKq01gGjL1O2bCqS1AtFD/UN0VfqWGzIvD
 0Y9VXhTX+eJeudUMxvwNo4fOH8bN6FRRb0h7TwYGbZYKxN4t2Y2xg15Zgy0Lqf3JQADq
 E3OFmryMQF4rnWK3MicSpQgO6mRLBxxG65DrhiPp+/dVN2xUn3XTERkD+zDRi3RRAUE4
 5FUg==
X-Gm-Message-State: APjAAAWNzhAoTqBPFJ1oTPP9w5/GjaJ6Wim8yFGiF47+g+nNOYL3BCOX
 CA3+DcNGNEBzhdmU/xXuBzIcGW3eWtOrGNRRYoWMsA==
X-Google-Smtp-Source: APXvYqxeKovD3kMPhafgt02ycJtVZaABru/FR5Hyf5Bb/2xd6jLtgNSScAkf4gfYlw9dtS8aH3ztS3Roio/ExSgmGl0=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr29992624oti.221.1560182370575; 
 Mon, 10 Jun 2019 08:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190610145859.9665-1-richard.henderson@linaro.org>
In-Reply-To: <20190610145859.9665-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 16:59:19 +0100
Message-ID: <CAFEAcA_HkhKVoP2bu4L-7aZvKjLu32_30b24WqwC=4g0hmL6SA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL v2 00/39] tcg: Move softmmu tlb into
 CPUNegativeOffsetState
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

On Mon, 10 Jun 2019 at 15:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> V2 should fix a typo affecting OpenBSD.
>
>
> r~
>
> The following changes since commit 19735c837ae2056b4651720290eda59498eca65a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190607-pull-request' into staging (2019-06-10 11:53:19 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190610
>
> for you to fetch changes up to 43b3952dea0f763ceeaa2f119c473b5cc6d29c90:
>
>   tcg/arm: Remove mostly unreachable tlb special case (2019-06-10 07:03:42 -0700)
>
> ----------------------------------------------------------------
> Move softmmu tlb into CPUNegativeOffsetState
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

