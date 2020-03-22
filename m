Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38193C54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 11:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDAC206F8
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 11:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJrMv8FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDAC206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFybR-0007EW-0I
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 07:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFyaW-0006kA-SP
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 07:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFyaV-0000yf-Kt
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 07:16:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFyaV-0000yG-8q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 07:16:15 -0400
Received: by mail-oi1-x242.google.com with SMTP id q204so3878860oia.13
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2YEt0dJp+OwkGnPxQxrOnb5yGOxRthpigTNRsDem6Q0=;
 b=aJrMv8FE2Y9+S74HKjmMhkluVrgFSyqIOF9BRj0m6Ki4JdoMK1gxx5T5LECJvMY/Hu
 iePsDUodu6P1Wct3ZyZvALRXYtVr7wQgsYGutRtlBPaHsKfni28CpUcySWaPj5ef/xey
 eHriuC2eYdNOOTzogei7jr0hYvLHCHkeEMKH9Y+ePADEaOowPw2vbg/TrA3GMGJRi2Ep
 i1jsVD1FBw5hK1U4Ms2nHkhXT+NZiNcVW4IXpti5TGrz0oICGfQTu6KPitbSZIgnFqFU
 C+S3KqEeKskLJa7Qdx9jS4vQNN+CirKkaUSqoKQ5KEuC2vRfY1E2OQHReksErMa1v8+9
 GZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2YEt0dJp+OwkGnPxQxrOnb5yGOxRthpigTNRsDem6Q0=;
 b=qXtaVm5ZVgng3gP/byWBlEDf+FKcxEEMhcIf/MzUDoOuImxsZ+BLSDdRE31rW1U/Kz
 4UciFRjWdVNqbIpJAXYI+pXRCcnPnItG9BbpS7yWdr/V+hw046C1mhTLMSl+QaOXmAkl
 bl68Y/pDUmWv+PegcCsFixamiwOBKtvm9//KocC8anHZAu8SiIBCJBAR94WAa6PRnMIm
 FL/6Qpux08y6H92hlZ0yMM/OX9x7tvrfJFfVTyVPHluZxIt6zgF2oC8k31HPvTnL/Nrj
 6JHo9RruwfVHkIwUC1cSU9hT1CuhHl8kzpt1fAY6K11sEwg0Q0Fne+WYFrYh4GJQQ9x6
 khdA==
X-Gm-Message-State: ANhLgQ1+eu4uspmHYUQuqh9TzfcJRbYCgk/rqVUoSGScgV7ZRBbzMAcu
 8l3UryaCqWqf5gPBo46ewe+TWChv4mlw0a2Yari53A==
X-Google-Smtp-Source: ADFU+vsge5fDibTLIhwKNS9cb1HM30CrRYDxJQSFFEY9vMTRDMAzM22j1+sWEt5TGeKGAd6UdXDD8mKpA8vjTLjU4aU=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr2767041oih.146.1584875773800; 
 Sun, 22 Mar 2020 04:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200313083617.8326-1-kwolf@redhat.com>
In-Reply-To: <20200313083617.8326-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Mar 2020 11:16:02 +0000
Message-ID: <CAFEAcA80-00Rf4c1NYyONnQ+GBh7TTj6nXarQE5u2VJn3tNW2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] iotests: Fix intermittent 030 hang
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 08:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Peter ran into a 030 hang while testing a pull request. This turned out
> to be two bugs in the test suite at once: First was the test failing
> because a timeout was apparently too short, second was that the timeout
> would actually cause the test to hang instead of failing. This series
> should fix both.
>
> Kevin Wolf (3):
>   iotests.py: Enable faulthandler
>   python/qemu: Kill QEMU process if 'quit' doesn't work
>   iotests: Increase pause_wait() timeout
>
>  python/qemu/machine.py        | 1 +
>  tests/qemu-iotests/iotests.py | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied to master since I've been seeing this hang off-and-on.

thanks
-- PMM

