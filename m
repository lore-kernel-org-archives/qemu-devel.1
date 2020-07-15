Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B0C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1893B2071B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viSNvO9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvk5g-0000R5-DH
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 12:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvk4U-0007zn-2H
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:15:50 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29]:41851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvk4R-0007nB-A9
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:15:49 -0400
Received: by mail-oo1-xc29.google.com with SMTP id z23so571646ood.8
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wSAZiq3ioCi9YiLwv0ALmUMm3EvdBO2Nj87Q1j/QK/s=;
 b=viSNvO9WDx0pPMALFsdCdKmnTK00pHD/hKXClIT+Ysk+t49qHhYVRyHF4C900ZBq5G
 0fOlYs6xmYlpMoxLTSzR4LfqOXGO2GUcGyA2cOzFOMlFn3PkHQ3e2bl5bby5vO8mxDzq
 3Ey+wRLDx6uBS7Mwt3nxLWuWCMVnJGvR5q4X3DmQYk79CEx2p4XNJPLWgjIMRNvItUEu
 qGQxkUo7rDBeF2HjGRDMjQrQ3FVb4sgs1kupXyg4Q4RCLAK4H/L2SWu1weI30r+grcKy
 j2WQozvwC+pyVS+33jpl0E3tvqapehiSldwFj2/bI09Pi3Ex2PHqscytc97iaXaXqy3G
 2Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wSAZiq3ioCi9YiLwv0ALmUMm3EvdBO2Nj87Q1j/QK/s=;
 b=d9M97clwqSZL4C4yqJFqsy9ThLdbgWbIrWhlfFlBNiSt01MxwPPcwYTBppCu96LZQP
 bcHDoNlaiqLWoyX5KvTSVaBKh/Vho5rfoMYOXcDaGEH79NcT0R8mJM5mhhzGTgS5Q2fp
 RAUgPt8/rc6flFlrm8igyYsarkNgRvNphPco72of5IsWyGzxkRpPfg8/1YgH3FC8jgBc
 8ruZZ1bnF3TsBxEldLG1/IFab241k2s6pne14BWMjDaH369kiU+BRPwcOdpyBIByJfzW
 szrjHYeehSD1DdqQnvJG10USWUjcki+GCX7D3em+ADQ/pC/qiOLYL5q6mOohABnuxT3k
 DMtw==
X-Gm-Message-State: AOAM530ZPYo8oiS0ym3HtZXG7CVQOdklpin0qs2sCHy0V4JqyQ/E4h7T
 ztgP3qkM2V3NdKCfFRF04xOMJ606SyyUXQeYwCMiiw==
X-Google-Smtp-Source: ABdhPJwjur5+sMyUghwFiCTt+x3iC8kWGr4S3nTy7qFh90vGUs6/pHVvgtc76ii0mCrtWbhn2FnWdx+t2CSt1p/j0c4=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr10133572ooi.85.1594829745540; 
 Wed, 15 Jul 2020 09:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202051.13549-1-f4bug@amsat.org>
In-Reply-To: <20200714202051.13549-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 17:15:34 +0100
Message-ID: <CAFEAcA_AZr+tGyZ1Kj_hL=etCDhDAn4n-4Qx+Ay3YdmkQQOcuw@mail.gmail.com>
Subject: Re: [PULL 0/3] MIPS patches for 5.1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc29.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 21:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 1a53dfee92284d3016a579ef31d53367e84d9d=
d8:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-07-13' i=
nto staging (2020-07-14 13:52:10 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-next-20200714
>
> for you to fetch changes up to 15d983dee95edff1dc4c0bed71ce02fff877e766:
>
>   MAINTAINERS: Adjust MIPS maintainership (add Huacai Chen & Jiaxun Yang)=
 (2020-07-14 21:49:33 +0200)
>
> ----------------------------------------------------------------
> MIPS patches for 5.1
>
> - A pair of fixes,
> - Add Huacai Chen as MIPS KVM maintainer,
> - Add Jiaxun Yang as designated MIPS TCG reviewer.
>
> CI jobs results:
> . https://travis-ci.org/github/philmd/qemu/builds/708079271
> . https://gitlab.com/philmd/qemu/-/pipelines/166528104
> . https://cirrus-ci.com/build/6483996878045184
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

