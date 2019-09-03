Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA105C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AB5217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o63xXl4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AB5217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54Dm-0002GZ-Ql
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i54CN-0001DS-1B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i54CL-00047m-Np
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:29:58 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i54CL-00046T-Ih
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:29:57 -0400
Received: by mail-oi1-x241.google.com with SMTP id l2so12182891oil.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=35gUwPiCbqr3w52IQk5/eO65UJg93NKnZPYG1t/cNHw=;
 b=o63xXl4/nuDpsRUyVXxke/qjYchpwqTar2e/MzJaTOCZXDlkEFe43v9YUNkE5mTKVh
 iv2FOLpX9QzBEDueh/bfyt7ccHF8AzxYf3hgsMiTMI5mDnjlhxcyGH65Jwb5qefv1TAs
 LVPxKeTyDyARAXHKwGszT86U0t2GZr0s7Hy4tZzn50MXX4dPA8Dpt14k11qBwr6FTkFm
 BkcINRvK7IDdvFKwyuOZhbQhlj2fSWu/P88FMnugF25/qvX2GaXqp3DS9y7RFTPMITMC
 rgSPD8webzUHgnQVJCsHVeiD6hgopUrDdyFbkjfMXI8FjQCvGkSdJGjVicBp3VWuI9UY
 FgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=35gUwPiCbqr3w52IQk5/eO65UJg93NKnZPYG1t/cNHw=;
 b=WJkydOeiMEQ2FzBM66kOEjFK7ss2862hDruf+45Yxoh8chFT1jMXF8T2XmKqMh12WF
 MUMa5j/zDTUD9m31wcQ8xDaGR49KSwFuQUc6eU+0swafPgoLs2J77p90aM46kGHVWRwD
 4gQcGuSObBwUbisGXoKSYoSrYTEH+q9l/H9FmcXLjib0aUf15uncJUUc9JVcPjavYSIZ
 Ttm1Uuwh3YyUJeSkiDzf11/8wc7JFolZjJilLsni6u+ZdT35WWCUJX1CTK2HAEos33by
 4230THXzLg0WoJ6BaBDjMTRQ1TBYYkMBYDUl1RW/Bu45RT2tsNf2sFk9iGMQqGey7WFa
 IsQQ==
X-Gm-Message-State: APjAAAUeh8tQvs7sf3LQKUBChWPVDXWEg8tWzCqi5WpkxDptNoYflPfI
 rfGKAcMDa8N3pN3p0QTw3dMqildwaCMMvzSV5kjFeg==
X-Google-Smtp-Source: APXvYqxYjZh14QI9YRbV2fwKEcElTwUxtm/F9sa+BjnA3tWTvj68pJ5rXYq+0IVt0pSDgxCBeiqZHTLSw9V6YGwr6fs=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr13513879oih.170.1567499394582; 
 Tue, 03 Sep 2019 01:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190827160554.30995-1-eric.auger@redhat.com>
 <20190827160554.30995-3-eric.auger@redhat.com>
 <29520007-f3fd-ed8d-f52b-2839f991556a@huawei.com>
 <0dd3bc89-8f91-0f8e-8908-18712240a115@redhat.com>
In-Reply-To: <0dd3bc89-8f91-0f8e-8908-18712240a115@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 09:29:43 +0100
Message-ID: <CAFEAcA8u3Qe9zx=4QxW_Bb8a=JQ7kUmiAO5H-cwAU4i3R+Nf8w@mail.gmail.com>
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [RFC 2/3] intc/arm_gic: Support PPI injection for
 more than 256 vpus
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 at 08:58, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Zenghui,
>
> On 8/29/19 4:53 AM, Zenghui Yu wrote:
> > For confirmation, should we also adjust the vcpu_index in
> > arm_cpu_kvm_set_irq(), just like above?
>
> I am not familiar with this path. in arm_cpu_initfn(), there is a
> comment saying "VIRQ and VFIQ are unused with KVM but we add them to
> maintain the same interface as non-KVM CPUs." So I don't know when that
> code gets executed.

That comment is saying that all KVM guest CPUs are
EL1-only (since we don't handle nested virt), and therefore
they logically don't have an inbound VIRQ or VFIQ line.
But we provide the qemu_irqs for them anyway, so that
board code doesn't have to have tedious conditionals
saying "if this CPU has EL2 then wire up VIRQ and VFIQ
to the GIC". If you ever try to actually assert the VIRQ
or VFIQ lines you will hit the g_assert_not_reached() in
arm_cpu_kvm_set_irq().

thanks
-- PMM

