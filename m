Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2636EC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E3220878
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjJhUljs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E3220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3bM-0003de-HR
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO3Zw-0002v1-Qk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:45:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:39035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO3Zu-00064D-V1
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:45:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id g3so2413409edu.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=b/wGWHj82FGBxnjojZ98jqHRBg7+CY58eCzYFVkshS8=;
 b=JjJhUljsELFnjxh1XyOSG5oukz7D2mEoYqXQcZjd2iEo7H1ggzcw4EO0nX+vb8usvC
 xs0UHU/Dp6/nB8669rDgc41boRBeJ55GmZqcd9+qIKdVmKtQRSx9MuHNuPtkgIGbFkbb
 DFhtTonUP/cawpBPIm/fmkOB63vLLsPwahPwDzmpqpidOaMltqXgpuhkLB+RQq12TxN5
 AEtSNi6A4Ir3WW0Bwp9il/wgAOshKDr06dZgbSCxaAKYEmQp2PPcbOBi23FrSFnqimjC
 yrRUC0C/sRa3MCn2qa/u+HfxU4H3iSNyUG44mBJsqpJxDbNhKAAR1/I6cPQnkoLTJGoV
 vdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=b/wGWHj82FGBxnjojZ98jqHRBg7+CY58eCzYFVkshS8=;
 b=cZMbpQ4zx8K3l3MJP9G9gc5PD7tIpLA1cv+ouSvxonJ/sRk3mvASxFHwspxN/Ye87c
 Zy02gvUOuky6OFUJJwvSTBmnEU1p1R+/RTNhWiVeEd7KCH27+3RnRPYWS9P/5wCgGNvT
 GxGHJoM2w60LhuQV0sFiw5d4v+6NGs98XLCLIUCEiqNfx8ZcuBgPRD4Q6PWGyzfv1BPQ
 e6SySsgngf/4Zz0ssRSW7KEhpFVtRAZ1L5PoPAKSynwkxOEp/SVf7S30lNtKPadM1IKh
 K5hFD/J1ubVIByw7tTmFdLrvKbEWsjg3J1NRCsJpZmx7EjnDN8xq2lpb2bKb+TIroBgB
 iZ/w==
X-Gm-Message-State: AOAM531MTQeLyXiwHNhdiIUdYfRgE78lVCQSDmNYQUJd7EcPWXvtdWf1
 Bn8cmTXTv5DiV8heENeVJC7BhAU3fIdXXKJRJkd2IHWOPq4CDw==
X-Google-Smtp-Source: ABdhPJwHotPBbQzxzkEQnY6P9cAyfCB59+S0LyTqDwhb9XPy1Tq5eV4Iyl17II5s8L8CIEWT+cOnQ4+UepNmDzCxzWU=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr9902287edl.204.1601577916602; 
 Thu, 01 Oct 2020 11:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201001144759.5964-1-peter.maydell@linaro.org>
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 19:45:05 +0100
Message-ID: <CAFEAcA_vcLOkoUHL0k-aUdf2DZaofnHLnTDPstexQoS1bB7Xdw@mail.gmail.com>
Subject: Re: [PULL 00/18] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 15:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Nothing very exciting this time around...
>
> -- PMM
>
> The following changes since commit 37a712a0f969ca2df7f01182409a6c4825cebfb5:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-01 12:23:19 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201001
>
> for you to fetch changes up to cdfaa57dcb53ba012439765a1462247dfda8595d:
>
>   hw/arm/raspi: Remove use of the 'version' value in the board code (2020-10-01 15:31:01 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Make isar_feature_aa32_fp16_arith() handle M-profile
>  * Fix SVE splice
>  * Fix SVE LDR/STR
>  * Remove ignore_memory_transaction_failures on the raspi2
>  * raspi: Various cleanup/refactoring


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

