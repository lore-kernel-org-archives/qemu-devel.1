Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D6C2BB55
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A1F2137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4qEZe30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A1F2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPMNe-0007GM-0f
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPMMu-0006Le-DN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPMMs-0007Lx-Rp
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:28:59 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:46940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPMMs-0007LN-MC
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 04:28:58 -0400
Received: by mail-ot1-x32c.google.com with SMTP id w12so768895otm.13
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I/efADmjzw60yEw0SBE5cKL/GtYdZCHhP03a1etZ4uo=;
 b=P4qEZe306FoG4VmKeeq3eCVssdF+WXVVq+RV69gbaPw0YZZ+nWlwZP9Y67Y5oaO3Hv
 0prtjnXDxxU7Cs8rHmuNPvhgBDsC8MfqibJgMkiBqFZtAiYnYYtWeTYyllX1/u/9ran6
 yv2pSdLiC5vno36o3nYu6dOvb8m7q9GViHO2jx7P2ly762pKux2aUbBYz/z5K4osZIBU
 xzUCpTGtpZmXd1vRPfKFotUA9yJSatUG/crC20FCTClbhg6eS6GmpixakFNJDTsr1Qdw
 ZNLupPuUvuSlvVEUdNpTOMzaa7eQgPcBaW3ZPWE4naETR8WYW3+lALXaPN+8Tzkv53hn
 FNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I/efADmjzw60yEw0SBE5cKL/GtYdZCHhP03a1etZ4uo=;
 b=S76ufwHi+znsaWg4ZewHUbdS6bxIweLpRXpOgYadY77paFPtgOfAB7MNRb+3Bw2Leo
 iQzjDb6yn5Y+UgF8IaU0Vdgns1Vevauhy0cmJUGqSIx0JHmbX+lv5ygrdKIogXkxOPPt
 oN9IX3DKDUY2QbFmVef+K9+xEQV0m6y3qPJ3K74FBLbtTuOUKYwe/yCrjpgsBqjxg7Bb
 ufwUarDAjRC7YQl36Iu0GghVxZPZ0B6ExcnvprsB7TjyR3IAvne65EXcIKzB8PMNQHjk
 5cO/PI14cGwiISX9zeds8v5VakCLHp+Hi8pZweUd1f7SHlMGM2cgyu1BLSlAx+XY7q0N
 ZJ0w==
X-Gm-Message-State: AGi0PuaIhCgrm5BqZXoovGxNHYJU2cdxOyDwA5DLzgdidMhKGlxqw6Mv
 rQQ4S5b/Lt8mwQv8NFhXY2AWEza54UavOIGJwSaj+c4Swwg=
X-Google-Smtp-Source: APiQypIx/TI0piDBj6PL3DLOws58j2o74fAm6b0975C9/rLb9dYCQQjmx+uUPgnt4OF47C4QdAYaC/ZPVAuf9XsP2Ss=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr1711331otb.135.1587112137647; 
 Fri, 17 Apr 2020 01:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200417050514.235060-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 09:28:46 +0100
Message-ID: <CAFEAcA8qLznGS2YCFxz7QYrhbociZsqzEcxQPdp1rUy4OnnnFQ@mail.gmail.com>
Subject: Re: [PULL 0/3] ppc-for-5.0 queue 20200417
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 06:05, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472:
>
>   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200417
>
> for you to fetch changes up to 5ed195065cc6895f61b9d59bfa0a0536ed5ed51e:
>
>   target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts (2020-04-17 10:39:03 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2020-04-17
>
> Here are a few late bugfixes for qemu-5.0 in the ppc target code.
> Unless some really nasty last minute bug shows up, I expect this to be
> the last ppc pull request for qemu-5.0.
>

We're past rc3 now, so I don't really want to do an rc4 unless we
absolutely critically need to. How important are these bug fixes?

thanks
-- PMM

