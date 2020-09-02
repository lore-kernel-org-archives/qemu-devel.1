Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CEA20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3DfBcD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CEA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSL9-0003xu-4v
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDSJT-0002bJ-VH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:56:32 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:35140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDSJS-0006i9-31
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:56:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id a26so6518680ejc.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TWuuyNJEPdWgZVQHUW0W9PJcGJCL85OrMbndK73xZiE=;
 b=n3DfBcD24wH3K3/4eck8VsXEcV7yJvkhaWBXy+YThGS2SfdXmuy6addjcj+OharHTD
 yjexKH73absiKohv8iqHRbbkQAtqXBUWEj56Le8lo7UFEP6CTi1+F2acNujk6pRSr5Xz
 oyhL0X7uhXvEqbBJPBmMpoGnaYmlgWI8qfZ3q5zB/DpKnZJsUy1VY61NIqu+jQGn7ALT
 p3BGA71fCwiq+GIxYBJNIPo26tgn/0Ta5aHoWLX1GgZoXPO2Rvy2OaUKtI1ezH5oCrzn
 unnIa4DFrdHXqpij6r4qsUQGkc6jtFKa22QTaXfY/UOyTVIVWzuu2xasIxFtqQ+okFkP
 5VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TWuuyNJEPdWgZVQHUW0W9PJcGJCL85OrMbndK73xZiE=;
 b=hZPp1Os2lHly8ZU12R59IbJKRRh4iAO6zGuytdj8ROFa04ZVnkB44QrRwmPx3G1Zkn
 BbrHY+JUXoEEYK30UGdKpctEni9t+z7q+BEckW1VU3hRX0hqjW8yMShavpjxsyqSIvOI
 KOYM8eSeP4/Ww9ovFH+qAAYfbk3PKFLjKwVtuX+O7wnjbbbKKIySUBXOG4fU+MfzY5Ld
 4xj6NesK5CM4/MjwNHq0GQgKxrl+CBA2Ox+x52nkdMrtfJDcuF8ni8bbTxOw494NeGGR
 Ig0ILO5zJCclmx5807K8Gri/G4Ds7nrzDs17CgUdVr4fdhMUWhkeD5DRGVIVwVFGyLiF
 80Mw==
X-Gm-Message-State: AOAM530T/vryeF57jWRFJQkroIzgZsQys+5pmFuhJbAYhYOHNRvsvPco
 iM3swyUNoHoU/hcN5LKYc4BLQxLp2HBYuI6BkhNJ+CBvqKaUiQ==
X-Google-Smtp-Source: ABdhPJxBkKSGv5xf7DP0pO3k7tSCYiyXkfevn4Mg5RUY1x+tMTGZthUqx9ndS3CpMC66rlA7z3YjaNrjJeTvqt1/dJg=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr6525504ejn.56.1599051388534; 
 Wed, 02 Sep 2020 05:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200901152050.255165-1-thuth@redhat.com>
In-Reply-To: <20200901152050.255165-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 13:56:16 +0100
Message-ID: <CAFEAcA-RpQHgafHGvgBE_w2xZjJ4abWKNWXO3VO9yXwD5V=vNA@mail.gmail.com>
Subject: Re: [PULL 0/8] Cirrus-CI improvements, and other CI-related fixes,
 m68k
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: Ed Maste <emaste@freebsd.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 at 16:21, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-01
>
> for you to fetch changes up to df496fb0532758cffb5ad4075b4e60a43c723492:
>
>   hw/m68k: QOMify the mcf5206 system integration module (2020-09-01 17:09:17 +0200)
>
> ----------------------------------------------------------------
> - Cirrus-CI improvements and fixes (compile with -Werror & fix for 1h problem)
> - Two build system fixes to fix some failures the CI
> - One m68k QOMification patch
> ----------------------------------------------------------------

Hi -- this has a conflict in pc-bios/keymaps/meson.build (probably
a clash with Paolo's series I just merged). Could you rebase and
resend, please?

thanks
-- PMM

