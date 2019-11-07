Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84151C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC92206BA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FElj92Ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC92206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSlMS-0005hh-G4
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSlLe-0005Fo-06
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSlLc-0001x8-HK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:13:29 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSlLc-0001un-BA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:13:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id n16so2658022oig.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qEhjtjy5t6O41gEr1p6zsuHCeSucLkdmeIso2BDQGMA=;
 b=FElj92MaecfBK7K4ay0CMa312u9uc0oVzZU5kVc5T+SXAiVTq0H4853PfyMtBsW3yM
 dcf1HT8+7wlqha0DHHT+0T+VRu8Xf/fd/dg14GwFu3//T2GoR8p4ToucBagnVvr4NaYI
 X9HTCC0idt0k5uTaBXZWIkREK0qbTXw88DdDYXTnZcirxZPc1vsMzYnpfAuA2ui3eUJX
 4iGz9/UyJs/pbpHnHBsahmJ1rLsG8dt46yMMk2J+yGmVmzqboTvNDuQiz2C4K0lDTa+8
 CmbgenJOKQ5x4JBI1LDv9jA7VMsByEfLrlkEz6HX405mhbL6L7oBzF88nrAoL7n/y2x2
 rQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qEhjtjy5t6O41gEr1p6zsuHCeSucLkdmeIso2BDQGMA=;
 b=RMqzqBQWmqEqmvdGu44dpPO1899/F3B7xKJ1Qrvngsdb06FFL2yZwd9pqT4h5GgQ9h
 xrA26Ff3LetFI00qLIN7Y9RrnksEKLhrFQ727Fbj33Id2jXVqvzLPkTxMNqrRlEi3R0X
 yK5keYVai+l4Zm3MJiltmt2I1VSIIu3XLP5GYYmAMTnulqqz+34y2ZmAjztZw0dXEWLs
 Dd0UszODWLFd8eVlCGPv6W5T6Z+Q7W+QrtOKcJV8v9X69PNLudv22ml6HNT4EfLQaq44
 jN2luaBwEfn/rEVfmeggCB2k/eRd5fo0A7fbYzzgMjqWoT9sFPgUyNa/4qOY9AyIJyE2
 JH2A==
X-Gm-Message-State: APjAAAUb145yLB9oNs7/JjI2JHtNg+igWzpk2mhcEkOgIqofuiIWL5se
 DJ3GGT6PtKtnKKGP819AU08BABgl5DkYWsdcRxQ+qg==
X-Google-Smtp-Source: APXvYqy180F0bMYKlA2pYludhO5VpNaPO8STPXkRZdI3Dtr3gHjboWyUFb1DJD6qY8OPjiIiDd4U99pnx00k6plGENQ=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr4229905oia.146.1573146807315; 
 Thu, 07 Nov 2019 09:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20191106162406.27030-1-laurent@vivier.eu>
In-Reply-To: <20191106162406.27030-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 17:13:16 +0000
Message-ID: <CAFEAcA8DAXpqZ2H9h1YEm5Ue88_CBiuNLzZjQ4V-cqeAb4mUzg@mail.gmail.com>
Subject: Re: [PULL v3 0/3] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 16:26, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a54=
08:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2=
-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to df59feb197cda31a8b807c13bf509259db9e018f:
>
>   global: Squash 'the the' (2019-11-06 17:19:40 +0100)
>
> ----------------------------------------------------------------
> Trivial fixes (20191105-v3)
>
> v3: remove disas/libvixl/vixl/invalset.h changes
> v2: remove patch from Greg that has lines with more than 80 columns
>
> ----------------------------------------------------------------
>
> Dr. David Alan Gilbert (1):
>   global: Squash 'the the'
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers
>   hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

