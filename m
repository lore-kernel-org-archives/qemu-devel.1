Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C74C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10C6208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUxuJcQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10C6208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPKk-0002se-WE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOy7-0006xB-9b
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:55:19 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33]:35167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOy5-00063h-6u
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:55:18 -0400
Received: by mail-oo1-xc33.google.com with SMTP id k47so2803373ool.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/6gKTk137gRLb5Eljv62S2iyFc40Y+7gIQnhyahHPTU=;
 b=tUxuJcQUktpxVd0SPTlPSx7LMrCDiotSknXX0WgoQHt4bwynmQ267ufSKnPxkNO5Ar
 x6bKuBj9waHVHH5/b7QQsmYwso+Dz/pMYY6fYlVDfPc/JEx+5u0It1p3GWAVuFfBlYiN
 Xw29asqZ2F2/GEdPVAOVin0ClnjGNhAkauw4lvjEj1ggzwWtmZFQjm8Y6xCQchPOG8Xz
 wX03cdVOh/ItlDetpxbMIBUoTLvsWMAebz3faoYMPgUrK4BieHng2RnfMitMLB0/zh8J
 7uaowWBV7B69Jc4vqmPdkoibCifHznC0FYN//ZTfYRsqE8JqWkShVqpu3qLNexVAq3sL
 lYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/6gKTk137gRLb5Eljv62S2iyFc40Y+7gIQnhyahHPTU=;
 b=DLgkHSFCxh6mu42SArCV8gLAap/A6R1jJOAaSY3Ag26zd+5rT8u27KSI8CXmfmvIQ7
 wdgYDPi7q0cK5KZIhLnLZkEtMcx81lB98JR8Dz06VsuqPEcvKFX6WikhXgZ2R5CDJHLB
 TwkQhYAUUXmId2v3lS67r/hM83jvQ6wBMOZJ8AUNOFA8cKh0XEOFRb0o7+v81/ZxGWMK
 DRiCeES1x2T33Et+YrMA9e/mHIBlwwZNQ1GdrTA/yxC6AyxxtN7Ok9wCvwBYAOHF8gIx
 d0L4WCBCwfRLg8kUQQBvnmG2ay5OUKX+DNkWG9iXNLZmd49VbJm31HsZDJjWB3eSLPvx
 SGbQ==
X-Gm-Message-State: AOAM532BrZdC3XcVW7zw0MaePR9yZEB/+BwDnZq/roWG++Qv5nsFBrAm
 +g1hLzeCSx9yf9f4GOq4JzshYKPhH1KaeWyHgE5kxA==
X-Google-Smtp-Source: ABdhPJxbioSNL9C4dfbQWDNnmG/AQCeqpiR7oht+YHWlR0o5Sy6HP4ehiN0D1ki48HXaYbCIZdXS+6d8hG+kZlWRunU=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr9974648ooi.85.1593795315882; 
 Fri, 03 Jul 2020 09:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200702162354.928528-1-alistair.francis@wdc.com>
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 17:55:05 +0100
Message-ID: <CAFEAcA_c2cnQhLqOsJdj+7zxX+Ynz_L_jFWhxbCu7Y1Wr4Bnrw@mail.gmail.com>
Subject: Re: [PULL v2 00/64] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 17:33, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 64f0ad8ad8e13257e7c912df470d46784b55c3fd:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-02' into staging (2020-07-02 15:54:09 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200702-1
>
> for you to fetch changes up to 6bf91617f47c74efc99ef48236765d9677c0898e:
>
>   target/riscv: configure and turn on vector extension from command line (2020-07-02 09:19:34 -0700)
>
> ----------------------------------------------------------------
> This PR contains two patches to improve PLIC support in QEMU.
>
> It also contains one patch that fixes CLINT accesses for RISC-V. This
> fixes a regression for most RISC-V boards.
>
> The rest of the PR is adding support for the v0.7.1 RISC-V vector
> extensions. This is experimental support as the vector extensions are
> still in a draft state.
>
> This is a v2 pull request that has fixed the building on big endian
> machines failure.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

