Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08BAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8969E20734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxJEXhqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8969E20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl99m-0008Ac-PY
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl98l-0007Xz-LJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:48:27 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:46895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl98j-0004HA-Jr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:48:27 -0400
Received: by mail-oi1-x229.google.com with SMTP id 25so18773762oiy.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0j7R8Bqbhr6WO9OOGLSY7wJp4LhCt90++kURb3t6abI=;
 b=AxJEXhqKHnMtIpuidbdqAfsJYpvxsPnl4XeI4tgXMPhyeAsZDrFQieT8TkzN/KGNGp
 GMB7h33EDcjdV0MtOPuDgXFDDEEgus0b/iybzi85H8uZ8AHIqStR+/eWQReoGAPGvzjH
 bACFQD/ndvsVwccfT5f0FtC/XEorZ5W2QsnenK7aGCYtdVgMJ9WBuDXa3hXaKL1VaaOf
 bC/KlOqiQemcnMeqJKp2hH/0wV46nFmukDga1xbxn7/UfLvFQ/oU1BN7/QOEfy4WgHFt
 SbezIDruz9f2cqAnSpHcWv4GvOABMAR5SRur5/AcmWAjxf6pEwp3nuLu5/Yv79lFPOLO
 N45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0j7R8Bqbhr6WO9OOGLSY7wJp4LhCt90++kURb3t6abI=;
 b=k2DYPNFFXlSnBq4OrEQk+JZ7q2k7BrR66m7T+Ik/AQ6EMuCuUcBYR/hDSCXoyVPFyw
 iB5LfGKxGgMzDXmdCj6zefVVG/bKDTnA2p5LVzIEE7VKPI7i/fpkDB+SI+r1P+DyzUgH
 VAHFQwwsoHr5Fusi0a5uIDJubDZcqEVmqawUxfkwuEig2Nc24wnBgZjWgwfr1gqzIn5e
 4C0kfrci/aMe4xZqfG3w9fIysLd3hyjhsJXXlY+w2k8ergrp6i+1/rL0BoR1q18vSH5K
 gi5eLOw1AP9fV5F7MYhq6XoFr7OivCaRZBrVZkYXRxVmQfvhqtyFsUxkO1DL4xg471tP
 W2Tw==
X-Gm-Message-State: AOAM531uolUeqssCOOauecMn7yT58yhPiy56wcqqv/NQw5e5i458ZREv
 v7GOq7U+KYPfC/8cjNZdCeoeMlCa2iarqm2T8q5Hyg==
X-Google-Smtp-Source: ABdhPJwwl0GHO+s9Y5/PlJkxt84XVIKz/Q4kmUwhcimlStkZby6qA5MZVZH2jNY/KWAdqoW8723NQhATcyyqX/xrmms=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2642600oib.48.1592304501273; 
 Tue, 16 Jun 2020 03:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:48:10 +0100
Message-ID: <CAFEAcA96K0ZXqdpReFaNFqBhhbdBP85sjZOn9S=gt94mG7o1fw@mail.gmail.com>
Subject: Re: [PULL v2 00/18] MIPS + misc queue for June 15th, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x229.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 at 20:29, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jun-15-2020
>
> for you to fetch changes up to 250bc43a406f7d46e319abe87c19548d4f027828:
>
>   translations: Add Swedish language (2020-06-15 20:51:10 +0200)
>
> ----------------------------------------------------------------
>
> MIPS + misc queue for June 15th, 2020
>
>   Highlights:
>
>     This pull request, just exceptionally, contains two non-MIPS patches:
>
>       - adjust sh4 maintainership
>       - add Swedish translations
>
>     The rest are MIPS patches:
>
>       - refactor emulation of a number of MSA instructions
>       - activate Loongson-related insn_flags
>
>     Notes:
>
>       - one checkpatch warning is benign
>       - some of make check iotest-qcow2 tests fail on my system, both before
>         and after applying the patches from this pull request


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

