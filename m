Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7003C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEC02070E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+8icLtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEC02070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNxs-0001tC-VS
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnNx7-0001D5-CA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:01:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnNx5-00038Z-F6
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:01:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id a137so15880813oii.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7TNMxvsyp+zko4sTHRW353FqJ7cUi5SXHt47yEcbiRU=;
 b=q+8icLtMinEDN1IR4NQrNfjMQgPkhINSJ5OjVk8zxhSFxbNvGLNYiauMUzL0LziArM
 33rY/UBNXniZo0oc2kYO6gnlEkzRotF0pzNpZkX8SsCtWtkCd7mvW/Mu4/q1VB/EDZ/i
 nRRhtBIBrnr0CqDinK5/+Qz5dHjdPh5zRSKMTqZmb/afEd1WBgzlmKt5noo0MCSpf+IA
 tkmpj3z5o5oYTWBmXsB4C9JgOOO5go78JWerOiQz3oXSqZXHnIu7slozFPbf6v0cPnBO
 zlSqHUP9vXx3rxVW3pF1ki6K3Mz3ggnu0ubcaOHp0EYGSOqwlXOfIKGnbp3IZU2yVeOi
 Nmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7TNMxvsyp+zko4sTHRW353FqJ7cUi5SXHt47yEcbiRU=;
 b=rcCmh+TmtW2OIVBt9i4wLWlja8T7xRt8XHSpojsja13P9cQ/aWQ8yrEXV6wWv6M7WH
 1s7fusvytq8F0WyDrbeG2EiAqVKyifyndhhkgRJ3gkPdv57T6uXqNRjpbHyfnu4RpLPO
 hWcgRYUSlVTIEebFWWoGcNNVaMgOm6snZyu4zmHqygFA5rB9x6FhFTunD657XRshPRxR
 buALxiKfQRm4mRXS4AN4RP+EXVeO5rM521A/H8qCe+ZZ/r6lmNvU4SWogL5+fXkIoYw9
 vt0LjRFafLkmuo/gYnPCIsG+k67cJTbzru5sjU17IEqOBXNhLfaZskybzOBkjsqNaVoD
 wWLw==
X-Gm-Message-State: AOAM530/0PIbFbMA2N++goLB0N82uXjuOQaMmkLMiC4KCa8nDjJLtGYS
 vKNpVx2PNYCmoogT3BnQh/0zMrmBepMDC1B+EmFtgg==
X-Google-Smtp-Source: ABdhPJxUfaFuh32aBwij93I0PozQCM71ClL3SF5hIGx2SGg20ibyvpq4pjvnzVMmqZCEn4kISs8HgNyGJmMdwAv4URU=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr12744281oia.163.1592838097948; 
 Mon, 22 Jun 2020 08:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 16:01:27 +0100
Message-ID: <CAFEAcA9qV69TTTQ88q7WRmTV10c2h6FZvEr2AAJoVcNy78e30A@mail.gmail.com>
Subject: Re: [PULL v2 00/32] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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

On Fri, 19 Jun 2020 at 18:07, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 4d285821c5055ed68a6f6b7693fd11a06a1aa426:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200618' into staging (2020-06-19 11:44:03 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200619-3
>
> for you to fetch changes up to 3eaea6eb4e534f7b87c6eca808149bb671976800:
>
>   hw/riscv: sifive_u: Add a dummy DDR memory controller device (2020-06-19 08:25:27 -0700)
>
> ----------------------------------------------------------------
> This is a range of patches for RISC-V.
>
> Some key points are:
>  - Generalise the CPU init functions
>  - Support the SiFive revB machine
>  - Improvements to the Hypervisor implementation and error checking
>  - Connect some OpenTitan devices
>  - Changes to the sifive_u machine to support U-boot
>
> v2:
>  - Fix missing realise assert
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

