Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E6C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECDC206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e32sqkmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECDC206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tmJ-0004NZ-0N
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5tgq-0008B0-Uv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5tgp-00015x-0T
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:28:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5tgo-00015G-S2
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:28:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id s28so2602286otd.4
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GO78lGxWojM+p6UTRnJZayuCpYSCPN28Le22gholJj4=;
 b=e32sqkmdybymWvfph30/YIjv3upHYrRMWCQcmwNtLB+X5wM3lS+ffajbI0Xf5QL/RK
 mPUGweP0lUGDzlZgMuC/B8km4GppGeyjeJk+WhgxgyGTXOsKeVUR/qoId4dO7nxgghw3
 n4zB93EN5fYt2+32LZ/dyRGkFqn0M4F3xUlaHjSfI9VQxyCWs3SvWpbWTMj7mEHEy43i
 IFg1a/Kj58s6Jp52AAymzCGlwlLYePqm8tYxIZg/PVglwgUau6T+GBM/o50khuBRdn4t
 Y+QTuvFNFS40beOMnlkZP1b7AhmmA+Puw1JNpmq5tS3p7/ySPEz4mDGs6ES6eJH7DKM1
 dM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GO78lGxWojM+p6UTRnJZayuCpYSCPN28Le22gholJj4=;
 b=CgC50hhdQxQQtq5DmTDiy2SfG6dKUl+GDXtQbOqOUeL5/PcjFH3nShx/QEAY5szpQq
 nU7s9tL6It1uuWvP/BGT/OrssVXZD3D5TbJ1zXEunBWrswmoLhZn3ImrwTmS34BIvByv
 vpfUOugjMqPwNlCloHvsQdaNVQXmQsEALIDYZvAsiEOZGLQsILeHDfkk8wQmYBFkiRNA
 +ncKjw2nSD37k93LVTItlPSPEUjp/ucBo8K2OtkzGdAhCD/owPG/6KE4UfpbXkBYnjox
 RA0trRCQhg1lGmrRKaykYhuTdXVCuHCx71cDOH6kcjw7nWvEdFQrPG16W49DA/WvZ2j5
 k+Hw==
X-Gm-Message-State: APjAAAU4mZQxDogt9dXrFRrYqiMP8HO7u1Os2z1sNHA1JIzvmio4fscl
 7tkGXulz/k43ZsH580/otqbdTJgtqvJOyviAmVFNjv7hgh0=
X-Google-Smtp-Source: APXvYqzqPEXWnA0d2c2qmX4gmdX7TdpEfer7JeNWxwNHbqUpsQW62DjDluAYE6OzVjcbnGpYW+JB8IS2sne9/43FUb4=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr3194864oti.91.1567697328591; 
 Thu, 05 Sep 2019 08:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190904193059.26202-1-richard.henderson@linaro.org>
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 16:28:37 +0100
Message-ID: <CAFEAcA-sqMSBmUKCaHHCVwPPk8j874Nm9k-PqjdC8oVhmgJ92A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 00/69] target/arm: Convert aa32 base isa
 to decodetree
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

On Wed, 4 Sep 2019 at 20:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This unifies the implementation of the actual instructions for
> a32, t32, and t16.
>
> The changes from v3 are minimal, mostly rebase conflicts.  There
> is one change for checkpatch warnings, in patch 34 in trans_RFE.
>
> There is one outstanding checkpatch warning, but it's in a minimal
> change to some existing code that is removed before the end of the
> patch set.
>
> All patches have reviews now.


Since this is all reviewed and it's big enough that it would
have been a target-arm pullreq all by itself, I've just
applied it directly to master.

thanks
-- PMM

