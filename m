Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF1221D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1pLAd9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF1221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDvN-0007MF-Hs
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihDuM-0006QV-8O
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihDuK-0007oQ-T3
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:33:05 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:37948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihDuK-0007nq-Mh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:33:04 -0500
Received: by mail-ot1-x333.google.com with SMTP id h20so13984732otn.5
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CAH/lBQOHXEp1k+7eqqHPRpJfDJZl90Ge59od3Nu+Os=;
 b=A1pLAd9wgaf07u83ouErxEQv8XPkxCgzvkVJTByM6UedsdCjXywz7v7nl+HjY9mfAr
 4UIRlXEvLaCrIgfNR9NSn5qtkZZw7AddfgXHxXp5PAaopcYzn/u5cOJ2Ue+T52W6h7Du
 m2i6bPtMk/QSt3zVDYscEnrgbgAK2/VWtxfTo4GuRRRuPJKZlfdMk1fYXrM6EtMVyKpb
 tf0jBONS7Bim/F8Q7DhUWenSz9Ax9FmztkOA9FAQhbESbvk9An/PVi007N4HlBbKrZTE
 4Sa+Zy/2iKe997iVPPa7WUOccBaS6piHvVoAzcuJPq6703iviiCnkAHAkWQkhj2QkUmC
 2WOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CAH/lBQOHXEp1k+7eqqHPRpJfDJZl90Ge59od3Nu+Os=;
 b=LoNiBgchDLP/oDFBXTtMBRZnsaNa8L370uaYtQ/aWIQz4XPnT29PmcsbnMlU1j1weP
 7OEg6KNE1JxKg0IgaNSU4RSG+JnCjCKzK50Y2bnZiP7b1A1Ex+LAaO4DXnNnKp1e5rSR
 +LXHw8GyOz0HkMLfRW2NClqTsk+MDcagtzShChBa5v5k4+EjGqPkKB9RpNpvQteFSMZs
 lTrlspf3M5IVkUcBPA3rJJzpUkGwlxV2OUz0lYM1+ToGZ4M4AAiFlnaFAOsCwhs/EoG5
 IKY5TrCjppv+RUYOIYash8nYNZehJ2LhwejLRwtRe4zWb6KoGf4ODJY3MKL61vDVsS29
 twhg==
X-Gm-Message-State: APjAAAUb97fBvyoi9g0BJwXCZ/TAppQhRygCjHvMyq7tvao/3KW6ebEK
 QxEAtpxjl40D3ppSAOFgZdgUGlw3osBNpeyJLmIS8sJc
X-Google-Smtp-Source: APXvYqxrQX5PKLrxeNphbg6o83rZGm4J/azP+/B9Un6kjeGg/KgMMQeNrl0l5lRJuUNdju7bKkkBhAdyj49vg4/rGf0=
X-Received: by 2002:a9d:4d8a:: with SMTP id u10mr39091043otk.232.1576593183684; 
 Tue, 17 Dec 2019 06:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 14:32:52 +0000
Message-ID: <CAFEAcA_ZXNpZ7JhYGZKtuNH+W5gRZMTYA-7C9sPONegetwq4Kw@mail.gmail.com>
Subject: Re: [PULL 00/88] ppc-for-5.0 queue 20191217
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 04:43, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166304:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-2019' into staging (2019-12-16 14:07:56 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20191217
>
> for you to fetch changes up to a363e9ed8731f45674260932a340a0d81c4b0a6f:
>
>   pseries: Update SLOF firmware image (2019-12-17 11:40:23 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-12-17
>
> This is the first pull request for the qemu-5.0 branch.  It has a lot
> of accumulated changes, including:
>
>     * SLOF update to support boot using the IOMMU (will become
>       necessary for secure guests)
>
>     * Clean ups to pnv handling of chip models
>
>     * A number of extensions to the powernv machine model
>
>     * TCG extensions to allow powernv emulated systems to run KVM guests
>
>     * Outline support for POWER10 chips in powernv
>
>     * Cleanups to the ibm,client-architecture-support feature negotiation path
>
>     * XIVE reworks to better handle the powernv machine
>
>     * Improvements to not waste interrupt queues and other semi-scarce
>       resources when using XIVE under KVM
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

