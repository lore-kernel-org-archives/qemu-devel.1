Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C45C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0075722200
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtkOqN3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075722200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQdZi-00081J-Ah
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQdYL-00071u-T5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:34:21 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:42418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQdYK-00063X-5P
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:34:21 -0400
Received: by mail-ed1-x531.google.com with SMTP id v19so7309431edx.9
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=CJFZU7OvhEA0OFwOs3IlUoXTq0YNZ9MZeYgG+3QmGxk=;
 b=AtkOqN3Kqoa349Hkhv8aeBk5coJ6e+4MUo1ItCz6ynR7L0ii15f68datNWlR65sspK
 znJATl5BjJ+lKLElYFg9GGR4FUXEHRdug/iAjESa+QDRqaioXlx0rn9XxQefrJSkG+p3
 NWmAGy4k2JBf6xx6HNWLCBXXEfESdnCgbioMCxzSMC6PlOrB315w/sGaU9IamnA1CMcX
 FFH8kgG//C6KhLZ1wvhWYYFCFz9thn+bbQxlGCzq2SyI7qC6Qdauf+BVh7rd52kjYYIo
 oTGmT6bid0oCy+rtM39ZVbAR1PHU3R4t/+dN5Ln5vT+3Bl+eePIXl26BWKNL5ODCfMGE
 Rtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=CJFZU7OvhEA0OFwOs3IlUoXTq0YNZ9MZeYgG+3QmGxk=;
 b=Lvj0lURDIlj/XJA7imkLl3smS27ylJzbuALDZEfTy2LCxy98cASnGpEZzJg0mKV6h5
 Rb8qr9uAMVP7v3IOONOGqLGIN9Jz44ska1fV9RHcEy9k95VFVrKFQkvxtp9deglPASMD
 A51/ZN1koyCx41C6eOdq8HMq5BswhigWaCzAyhtdvisYo/t/MZxPcYp4pvpEa5aQ+vgH
 REQDuyoWuzaty7/O+6RpPpWAQZ2NqU6m0+7ksEpvxyY6O8AO91kvieYzXXqRJhMPMApR
 tNVL7IhQm+p2RYcAjzBUseTT4lAc3WchatBsvIW6z7Tr/ARmlYoJ93PQ8rbyW9AD/HYu
 CMGw==
X-Gm-Message-State: AOAM530EIbCD049qz1WIZp5cl+1ouREbs8TaRoumSqHXzgdCJk4LZUq4
 nqJMMMUlHvUIpbMy7dctPpGPNgWbAS6g+M1/TZluiaoTqUMsVw==
X-Google-Smtp-Source: ABdhPJzLv0JUnva9fzgjwQXyJBpibO66MJWVTN7lgRNE5u7ejiSZlOeWxVZlHqU7ZVbMOx1AaShFTQma9uJ10eeqZMM=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr10910050edq.146.1602192858532; 
 Thu, 08 Oct 2020 14:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201008204106.26629-1-peter.maydell@linaro.org>
In-Reply-To: <20201008204106.26629-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 22:34:07 +0100
Message-ID: <CAFEAcA8Vk8qO5RhmL_+3OoQr2RysarqBFgYcAsxSMg8qHEVLHg@mail.gmail.com>
Subject: Re: [PULL v2 00/12] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 8 Oct 2020 at 21:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: minor tweak to fix format string issue on Windows hosts...
>
>
> The following changes since commit 6eeea6725a70e6fcb5abba0764496bdab07ddfb3:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-10-06' into staging (2020-10-06 21:13:34 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201008-1
>
> for you to fetch changes up to d1b6b7017572e8d82f26eb827a1dba0e8cf3cae6:
>
>   target/arm: Make '-cpu max' have a 48-bit PA (2020-10-08 21:40:01 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
>  * hw/arm/fsl-imx25: Fix a typo
>  * hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
>  * hw/arm/sbsa-ref : allocate IRQs for SMMUv3
>  * hw/char/bcm2835_aux: Allow less than 32-bit accesses
>  * hw/arm/virt: Implement kvm-steal-time
>  * target/arm: Make '-cpu max' have a 48-bit PA


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

