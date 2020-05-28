Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF0820897
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNYM2VSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF0820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeJ0F-0000Hj-J2
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeIzb-00080C-RB
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:54:43 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:38477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeIza-00073U-Mp
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:54:43 -0400
Received: by mail-oi1-x229.google.com with SMTP id j145so78677oib.5
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=goXaG/h7gGmfLCxbryY70OrdD45tUJ/mIrBBmnwTFqI=;
 b=wNYM2VSf6L0BIrb61ZewUU4dmGEXYlrhRhDlzYpHyrohykglI8o/4V8zbmfo2+9fhQ
 AnE/RfJqB6nUzPG/0GQIs7DAbXNBY0fLHenSUomP0EALMTWoAJf0GBMFkyWVYpMx8XGq
 Q/QjxZLR4i4ORnAMUHwpCUVfgiHGYcKSOFAmt9irUvRJclgoXxQ2FgS2PQWj5yoM2EZe
 RlgCl6BhIFpsPKEJIEKWPjx+aQNzSLjayGK3JYLcMvdNCCI2sGoPm1nRNYsaJYzdJPKw
 PsCyNXvvcla/bGLX7NuBdPEyHC7Qbqo8Cm/LOA0nHc//7hgLF1wWA17tbrEntk7p4zKz
 r7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=goXaG/h7gGmfLCxbryY70OrdD45tUJ/mIrBBmnwTFqI=;
 b=YLSfvA0ZxKuvp/QOkZ50lg7pnqne7ptr54OI3jAWChGuBKrVxAUVSWZvtzK9xo84wZ
 Ca1WJVZ/bXFbLvhsKqaThqCbjZ/xJoJn1AjQMNDls3YEIrKowVJgLzdCNVSkkY4zSHyv
 6IMGGhwe1O1YB47kqcNijcE55bEZcZRCTpSV/lVG8Ujv6+zCIzULKXjDDg/yH2gYZ/TD
 Veq0/GwTFgTwokv/wpXu//EMBCUfeFSVD+HOIZt1CxdXCZJrPleHcFSyNiITQk9Yp2L0
 W6Bxjpp1AA2MtSAsf6f98mBxLG9Dn3m+2WRH1VEtYP4gEQzVFq0Qi7cDQSiT/UdcQiyJ
 XaRQ==
X-Gm-Message-State: AOAM532Q5hC+b5/Wh3Ql+sZcdNL0CLvM5fXH8yMR9p+SK+aYkxo/Qypd
 0wTHk/n1fwV5HSrV/xmxunmflaAcA2/UVq9e0lphzA==
X-Google-Smtp-Source: ABdhPJwF00/MhI2nbk0su8EED8QYqxV9ACsjapHvp/d/12HQ37IHfebM6OnrKYgb70uy8bmqRAtkN6TDf2vcbpLmCwY=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr2134386oih.146.1590674081143; 
 Thu, 28 May 2020 06:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200527145455.2550-1-alex.bennee@linaro.org>
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 14:54:30 +0100
Message-ID: <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
Subject: Re: [PULL 00/12] testing and plugin fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x229.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Wed, 27 May 2020 at 15:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac635=
10:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' in=
to staging (2020-05-26 14:05:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-tcg-plugins-27052=
0-1
>
> for you to fetch changes up to 919bfbf5d6569b63a374332292cf3d2355a6d6c3:
>
>   tests/tcg: add new threadcount test (2020-05-27 14:26:49 +0100)
>
> ----------------------------------------------------------------
> Testing and one plugin fix:
>
>   - support alternates for genisoimage to test/vm
>   - add clang++ to clang tests
>   - fix record/replay smoke test
>   - enable more softfloat tests
>   - better detection of hung gdb
>   - upgrade aarch64 tcg test x-compile to gcc-10
>   - fix plugin cpu_index clash vs threads

This makes the NetBSD tests/vm setup spit out a huge pile of extra warnings=
:
every link has something like:

ld: warning: libintl.so.1, needed by /usr/pkg/lib/libglib-2.0.so, may
conflict with libintl.so.8

or some variant like:
ld: warning: libintl.so.1, needed by /usr/pkg/lib/libcurl.so, may
conflict with libintl.so.8
ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may
conflict with libintl.so.8

thanks
-- PMM

