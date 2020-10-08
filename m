Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF1C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F37721527
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4qyVJFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F37721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQaRM-0003DV-0c
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 14:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQaQX-0002j5-Kk
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:14:05 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:39795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQaQV-0006gM-OE
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:14:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id lw21so9451884ejb.6
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WiH6aljJP5gpqhzYGNvsmhrd3632yLdiaBU1X3zIY2s=;
 b=J4qyVJFQkJh1kDm153iDry+8aFKYin+I++BJdapdlvur65MDJCiY6OSuaWhY/A+Xs+
 TENcKfs5E9GpekX/uneV64/qmDMYGHpCuSE+sHJ3KYQa6VDwTM7oiuNeK9s6+op1z00O
 ZCGB3XJYCwTi0oxppULdyl8VvRHgxY7B6/8f5x64DBtXWb3sGEeSRW23+rlALHwUhCpj
 n8UHNlbcUHxJBMSZqWqjQKZrnPmIvA0/pN47O1mQ+MaZUTIsFBSGGBkvZqzpWJWbqJHp
 tasIJx9+jyQsyLi4yU6uFQZxvFyBWh0KuWCNX8vhwZBgqPgzIg7LOVytIppeiuDCCEAw
 mV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WiH6aljJP5gpqhzYGNvsmhrd3632yLdiaBU1X3zIY2s=;
 b=fJDxPappZAPfKO5hj8OwkcaVEcH/1itP25SwuRwAho2AjCqiZPLOzQVU/Y4RGMHurr
 FqiUv2UKm/tZESxafEaAKL8R9mDMssXC3jI/smVLgZY8biRVQj/xLD1dnZ6aeZkRynDo
 f6qJnGIx97tnfEW+xFyQoF/Ee/lUTnO5gYhwPk9nOlWZIiflLvHYs5oy2nT493I0nkHa
 zfC5lBND31UNzD4YX8fkUoY6TTGyGqT+3OSDjfeXwSTAV/chMbx3W+v/0hr05MqgXy/e
 4shRgwpI1yoRuQ0286XRm8yP9+xbqYnw23rjkSTN9Z3REfKmd6E6b0xHoziUgpZblcnq
 GX8Q==
X-Gm-Message-State: AOAM533M0tiBBVFDIDdvcq4BnHtwtwnYFaHxZh+Wsuz2nT4e3w0WnDBs
 dgj7ByulgUGy5bN+LEPeLCliqUTWXM5aSQcKDePdXA==
X-Google-Smtp-Source: ABdhPJzTRmhoQROPXKk7vf5X6JOxaGcDkCVPyBSGEVhsgamEcA5PUXxj4FhnbHMKSiZr5xeBacKlzvO3oPYYUN4DoeU=
X-Received: by 2002:a17:906:ad87:: with SMTP id
 la7mr9952290ejb.85.1602180841672; 
 Thu, 08 Oct 2020 11:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201008125659.49857-1-richard.henderson@linaro.org>
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 19:13:50 +0100
Message-ID: <CAFEAcA8-ebSKAuBEAthZsHa5Ht7U=mLYOVch1Y7ZJu2g4snKFw@mail.gmail.com>
Subject: Re: [PULL 00/11] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Thu, 8 Oct 2020 at 13:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 6eeea6725a70e6fcb5abba0764496bdab07ddfb3:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-10-06' into staging (2020-10-06 21:13:34 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20201008
>
> for you to fetch changes up to 62475e9d007d83db4d0a6ccebcda8914f392e9c9:
>
>   accel/tcg: Fix computing of is_write for MIPS (2020-10-08 05:57:32 -0500)
>
> ----------------------------------------------------------------
> Extend maximum gvec vector size
> Fix i386 avx2 dupi
> Fix mips host user-only write detection
> Misc cleanups.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

