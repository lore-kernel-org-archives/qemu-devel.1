Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34119C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F399D20820
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8gbgGgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F399D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5o2X-0004Yb-3e
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5o1X-00043E-BG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5o1V-0002Il-PP
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:25:50 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:41906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5o1U-0002CT-4x
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:25:49 -0400
Received: by mail-oi1-x233.google.com with SMTP id h4so1221097oih.8
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N4bs23/EuRH8x2dDVkKhoFkPcIiDTZOLhO8KZ3dTMCw=;
 b=f8gbgGgP8euhyAlGNr8TqdmNSRyS7yws+jpKh0SvG34un47BuTpjdmLHL0oY21+PBo
 NY3SPLOt9MU2946Q7gbgWgDbWi7xk5t6UNwCcHNfY8IqR1mBHpafEHZnh3+AwTltRIyW
 Paa/7qRUHZssvEumrlsCSAgiHT3lTJsbo9vsovZEVUH6/g1KP9h0Yxzv/sKmUwZyyMac
 v/HCi6PceotA0umbyTWe82jeettMamSJrOhST2g7xQ/hT9aewzDeUIET4b39kXyc1QPm
 e9GswvHC71DKF41cvxHHVY3OMyUU2vsg8gu/Ntx6niyFCsUWjFATas19DSE55ltoViML
 iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N4bs23/EuRH8x2dDVkKhoFkPcIiDTZOLhO8KZ3dTMCw=;
 b=cfpl0yo3rKr9hFdTKKvnaKjXolHr08iWNXIwp9/FgKR9BfB74k29ibcAMBDg4ekrt1
 9fXx2ZtIv1VU5bAnnR+jKuAryT9oojPD7H0qp3AaQpqJqbMG2jXY0XZQx1cIWNjObG1i
 XjtbcEfgKotWgvDQe+9RpexobkQxySNs2OyMYaLWnwu1kLHKCDcSiIDqHWD8veGvTST2
 /OPwYrFfoV6hgExGaJzHgZNGAVN14j825x7uC1lS11wDTVD09nlwHZ6vuK0gLYkHYvT9
 dJjYwDwQrxjkqPDRsTwqTeZq+lyFw5vzlW0vgT3xz/8DOHcf8hloxtJLKdhYDos31zE7
 8Y3A==
X-Gm-Message-State: APjAAAUu9glUEHyFNF6e+FZF6uYJ2ZuPHJsbuMbP60BE3qO2Kn3Lv9Ay
 YRfpej3Gj7Lx7su8JOBLwlycbAoXr+9TKMUTCghuWw==
X-Google-Smtp-Source: APXvYqzVgrbpCitgD5W3EFGMoKjSvJ83YlNvsVsFyxGhm/W7VUX/ulDF6oy95x5J1R8HSoRCP1Xm9ZigvYP3UFdO7ZI=
X-Received: by 2002:aca:4814:: with SMTP id v20mr1782990oia.98.1567675544423; 
 Thu, 05 Sep 2019 02:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190904204507.32457-1-richard.henderson@linaro.org>
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 10:25:32 +0100
Message-ID: <CAFEAcA8zGSA-Pdta5nuRtr4FSr35sEs-4oh3+ni2Be4NSiY8qg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 00/13] target/openrisc updates
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

On Wed, 4 Sep 2019 at 21:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit a8b5ad8e1faef0d1bb3e550530328e8ec76fe87c:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-09-04 17:22:34 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-or1k-20190904
>
> for you to fetch changes up to 9e3bab08d3e3f5808cc35a59af1912bfb6fe96fd:
>
>   target/openrisc: Update cpu "any" to v1.3 (2019-09-04 13:01:56 -0700)
>
> ----------------------------------------------------------------
> Updates for arch v1.3.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

