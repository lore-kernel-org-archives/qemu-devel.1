Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCEFC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9A921871
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIXhx5WA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9A921871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higXH-0004TG-HA
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1higVn-0003pm-CM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1higVm-0000Mo-9C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:45:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1higVh-0000AL-7e
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:45:28 -0400
Received: by mail-oi1-x243.google.com with SMTP id w79so2268614oif.10
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2/XGZvCPj7K96o7rOY0bGH9oK+Uknf6IZgXh3Qfk9WY=;
 b=rIXhx5WA7MHcPT4hY5+mg5HspTF775At5sD88jIfIwcFIXsqgl8eLxhSS5Plw7HTH6
 /1sHRJYJRyf+BtKbY0xMtDEfbUBQRPhAIg9NnYUV18CK/+Ol9APAWSW/TaRRbhfd+UEj
 sWkHvMuVAFMG28NX++8UrhDEiJNNl9VsQixgaoomvWVO88F+Oyimn36pwH3CURqtsLFV
 ZweDmuhDOhQvPBu56QF0j51GbuD6QfGUybCpcAvFZgnxZDU8o1LdyNVb75m1nmltfy5k
 iRUHEd338J/o21MAT2u7qt9vXsD7ptgcm0fAjR/ka/q4xGw+SqGJf3ljYRIiofzl2ElM
 K0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2/XGZvCPj7K96o7rOY0bGH9oK+Uknf6IZgXh3Qfk9WY=;
 b=TXSMT0IOFAFz7wcHrX3oATphG06Ovcah34aALi7cyjdLW0f5aEZ6CGrjrhalEMVvPi
 c+vhIiTtqSKdByYO25QqC05rLHGpWr5tiMbtQT8sm1Ei8B1PjEihfPbat9Y1Fk6pO6Uv
 tryAWs1PMG3TUKlLojizvv8+/zny7NVDsfgQHooNAm4vXCYFhsGkACzGdwuXQj51dXqY
 xkLR4y0jCGDim6jug8Fq3bmdDG0alNLXPK82vP7ONXP6FXEzn2X6w6EyEAd/+NDL4/gi
 ugqVKbLVHQYfR5HctDl2ToeEYpOmLjMgiOO8sVrBgZfrTZb8+QUmzIZAun+rkgQvkgBG
 4v7g==
X-Gm-Message-State: APjAAAWihpEJcpCt+tuL1uqu3Q725GhrO0cGmpN8NmCOGvdOFUerEcDV
 TWQmOcJmL0dvjaUigAQWvnhDPVjfCo9eabK6rsW40aHK0YWpfA==
X-Google-Smtp-Source: APXvYqx//7rzWKljqJKbLEEs7YbT5pI9JtaLHniKm3GTLwqT/w1X2wZWeCF9dQhtNBV3s74OCMBPf54MlEahUg3Dxd0=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr6874606oie.48.1562165117371; 
 Wed, 03 Jul 2019 07:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190702123713.14396-1-laurent@vivier.eu>
In-Reply-To: <20190702123713.14396-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 15:45:06 +0100
Message-ID: <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 13:39, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to 7c955080d40ccc7952a0479bc160f2b048c0af53:
>
>   docs/devel/testing: Fix typo in dockerfile path (2019-07-02 10:12:32 +0200)
>
> ----------------------------------------------------------------
> Fix typo, fix sys_cache_info() on FreeBSD/powerpc,
> change virtio-rng default to urandom
>
> ----------------------------------------------------------------

Hi; this makes 'make check' fail on OSX:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
tests/test-char -m=quick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name="test-char"
Assertion failed: ((isize & (isize - 1)) == 0), function
init_cache_info, file
/Users/pm215/src/qemu-for-merges/util/cacheinfo.c, line 179.

I guess this is the sys_cache_info change.

thanks
-- PMM

