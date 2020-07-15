Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC72E2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrqUfeOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC72E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlnn-0007Lr-WB
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvln9-0006wW-VT
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:06:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvln6-0007IA-V3
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:06:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id t198so2914264oie.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RSmhfJyS3oh8m62Pe7NvTSdQp7/Psl126Q1GVWw0EaI=;
 b=FrqUfeOtukzCAXdXLEOmF1HL45PrDlZrt/5UnnMoECwqCuCg2vusHTTz2yKKLuBC2D
 yM8YnLfKSy95QRQinIwEZp2Zqll3/iguPiZIuRr5Tkmd6XvOhYu1FVF7e9d3VE4cgyHS
 r9KhvDRxmaZ53aqGQmnGZdS2zv/ITaXPqfJb76YrAYm/wJJuo30VnZUcHIha1UJd4b/e
 GHaIM3D0xbCXR18iCkmvTcfyXx/+o9RaXYlEakj80gOAKpVXJf9Jiu+rzMBodjsQ9Y70
 m4nL+zkO2FZzJKq1tmOCDS2bPdyg6gHVRhiqy6DEKUKBxQNPjemXVKRaIrQeLMFbLjk/
 BMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RSmhfJyS3oh8m62Pe7NvTSdQp7/Psl126Q1GVWw0EaI=;
 b=ol7VeDRxjEF2tHoYviOHUPd+HkJfBXWFNocoGPkB/3Aii4MvGr4aWI+zg0w42OF9V5
 sqK+QFLBqVivAi1Pd8anf41QYeHYmFLAaN76KTNjHq6HNZhrGVAWP11blEhF4syD6A7M
 GXIMS690nTIbljgx7lCgz/hujw37TIXmyOOombnALU9l/++ldalb84mar67XzwREylwj
 5QiwBh8M0S1fl64/5BIz3AxNCnJHosgw32u5LDPTvLKnravluDN3MR3IaO03tMOg55h1
 NwqGryvxH1D0Zd/sV3KHGfrk9Dx7mTS2s8fP/CCo6UwhhzAMFgXamvG/sZq/WKr098HF
 6o3g==
X-Gm-Message-State: AOAM531/zmk2B9WPcE1uC2kV4Iq+MC33lWYHpTt2UIzOgAHzGWP1dT7e
 ulG2NntgzxObKoC6uZUUaMK/c3Sl6z0YeVRHEkF7KQ==
X-Google-Smtp-Source: ABdhPJwq2FjEnV1SkbUqbTWOGTpKoGq967Ei56QuIH44wLa1bMVXZ/Ixe+OHL7Wro3H12Xig8oKQZZ+cvR4Qoa6DhPk=
X-Received: by 2002:aca:1706:: with SMTP id j6mr766994oii.146.1594836357995;
 Wed, 15 Jul 2020 11:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200715111455.19237-1-alex.bennee@linaro.org>
In-Reply-To: <20200715111455.19237-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 19:05:46 +0100
Message-ID: <CAFEAcA_cCE++ij3cdhmSGi5Zs1jQNVNwSN3enRMXt+BxJ_dF2w@mail.gmail.com>
Subject: Re: [PULL v3 0/9] final misc fixes for 5.1-rc0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Wed, 15 Jul 2020 at 12:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Sorry about that, dropped configure patch, added Travis ppc64abi32
> patch.
>
> ---
>
> The following changes since commit c920fdba39480989cb5f1af3cc63acccef021b=
54:
>
>   Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-07-13-t=
ag' into staging (2020-07-14 21:21:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-150720-3
>
> for you to fetch changes up to 0571d280d057b851e3bb3ea7c350b86c950aea6e:
>
>   .travis.yml: skip ppc64abi32-linux-user with plugins (2020-07-15 11:57:=
17 +0100)
>
> ----------------------------------------------------------------
> Final fixes for 5.1-rc0
>
>   - minor documentation nit
>   - docker.py bootstrap fixes
>   - tweak containers.yml wildcards
>   - fix float16 nan detection
>   - conditional use of -Wpsabi
>   - fix missing iotlb data for plugins
>   - proper locking for helper based bb count
>   - drop ppc64abi32 from the plugin check-tcg test

I did a recreate-build-tree, then built current master, then
applied this pullreq and it succeeded as an incremental build,
so I think your diagnosis of stuff left over from the attempt
to build the first rev of the pullreq must be right.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

