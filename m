Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE33C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF538206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fw5fwTWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF538206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgc1-0000YA-RD
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAgRB-0007F6-At
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:25:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:33395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAgR9-0004ff-Ej
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:25:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id w14so12031435eds.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IdoAv0ugNd7WnoD6TxtD6MpZqzqpCPds/f/CWSJyVxs=;
 b=Fw5fwTWP7d8wki9jb1Jl8LmZHXzfHnvKga8kU4kFQdVtFzwpnIgu3a5VrnVjWoiMMi
 +aEJygVyJOMT1tn+/i6AlJsDr8difO8ygPXFrx2WVmqCewr1NbC9fOxazcmwI4ASwt7B
 BinjPe7ex8w33U+8okij5PJhbu+vKvxuDfZfJM2AzTZtdkplQeCV+kcgqORd0/VAJXpf
 wh4s2OJr6UneKSqMHQR9dRDKs5Z5ROb73YEHKX4VTQ93j7znAsCLTS3hi00C+f9x4JBq
 EhFfFr9sTLUNatmI2D8nukWxTULWb24NIfvhTNu/r0Ne5yiYYrj89jjflIuSq+8io9zP
 vGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IdoAv0ugNd7WnoD6TxtD6MpZqzqpCPds/f/CWSJyVxs=;
 b=pLh3h1lwd+WUtYYiKUplBVxUzIym3ozBd9EsRenYtfbY3I4IP2X3eqLZzp/HAy/GMn
 vfJ03/oeVSIVDglSwo/4pDcS83m5DrOptQJDDeD5bXZmdEPlCI+dzJLlAtGEcMPofTMv
 Pj/jFglSKEBCu2jEOOr5kKJJRskSsgM3mgvDNHyM37HifzyQ+3auL1tvMkDQCdJ0BfJr
 P3f/pLieFUgxNV+gNXn1cel+Ky0ex9ulW6mNB2uYIXntN+FVX721zqP/6+tTgSWtM+mW
 o5lGJbROQ9oyDvUP6TuOVkNmkqNO/KY8Pq2WxqRDs9fErewt2h1U+Iuvl9ontRzecYj7
 2NXA==
X-Gm-Message-State: AOAM530meKdBnrzRYboJ7BAea6Qgr5qMsFEDFHBi+3rXq2MzEKR4xVSL
 QSc71NPVLnEG9z3EqcirICuISdWf/1TzD2iLtxEUcA==
X-Google-Smtp-Source: ABdhPJxf61u5+bwV8pD1ip+G4nQdhILt8Td2K4X7I5HALQGtHcM/6kMCAFlYq1QVSCgaI31gsbPZXekKmrru5l6VgCE=
X-Received: by 2002:aa7:ca0c:: with SMTP id y12mr11925732eds.251.1598390697867; 
 Tue, 25 Aug 2020 14:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 22:24:47 +0100
Message-ID: <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 20:01, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 7774e403f2ac58b3e87bfe8d2f77676501ba893e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200825-pull-request' into staging (2020-08-25 10:54:51 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200825
>
> for you to fetch changes up to e39a8320b088dd5efc9ebaafe387e52b3d962665:
>
>   target/riscv: Support the Virtual Instruction fault (2020-08-25 09:11:36 -0700)
>
> ----------------------------------------------------------------
> This pull request first adds support for multi-socket NUMA RISC-V
> machines. The Spike and Virt machines both support NUMA sockets.
>
> This PR also updates the current experimental Hypervisor support to the
> v0.6.1 spec.
>
> ----------------------------------------------------------------

The hypervisor related patches don't seem to have any
reviewed-by tags, which seems a shame for a fairly significant
chunk of work. Is there really nobody who can review them
for you ?

thanks
-- PMM

