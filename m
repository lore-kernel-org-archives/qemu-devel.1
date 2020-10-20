Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5D5C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F09B22251
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDqQSmRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F09B22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsfY-0003XQ-NU
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUseO-0002Vm-1g
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:30:08 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUseL-0000B0-Ga
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:30:07 -0400
Received: by mail-ej1-x641.google.com with SMTP id qp15so3053870ejb.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CuQiRyoPDm+otjxwXXzLvtNayxR50ub6b6dD+Zf6W+I=;
 b=hDqQSmRLubSxMVd2zC7+WlZQkruokFgAHM2j3uddNYIshW0ESi6CTnogsa41vkGgQj
 mIBsJHqrQglc8a0cH8W6FPrRF9E2sy8MbQIHIiN4fh6PMexxpVYYIUbFhXUINQvpuCOJ
 u3FtWWsymYqk98GdSvG+2W5kG8q53rF9kmpKKnWAtlgRtF5Uol4furlclheanI880lFK
 rLmJNcWP6SVTFzQwAwrGExDtmSgo+hqrttqIJXeBTj3DJYV2jgxtpyVHmNoCEg0nbywY
 e4QRzq6PhhOE/tS1vFWgsjA6asuy+GOg4uJmuOl8HDkKSbL+Xe+A8ZJbDjxx76hvX202
 3V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CuQiRyoPDm+otjxwXXzLvtNayxR50ub6b6dD+Zf6W+I=;
 b=n7tHjaMAxp0ewWhVFLMl1oag1P1C6wZHbFAbrmuxPk8k9/zDxyJtP7dHk2tAl9T3+m
 oU/U1E4v8L2Fb+FEa9gnvhZ8VcANLBTIfoFyiZo2qGiy9ZHTKmQeU6AUXZYXUMM/CC0c
 cYkfB+H16aZCPhNxwU8ho0+mlCpNN6eDNg0C2lE7XTD8hE6sTkuleYMNyYTq59/50LRO
 C9TgIHKcwMLUk43vsLismIdEv9waPj6PMDAcM9Sk1GsjTXWC/6RAX13T0iXSd4GQj1t/
 Tt/s3W+gv4DzWWWZAkMkduZEhHMuyJsQb4wjkjhky7DR9rxrFexUT+eMjT/gE/yBRoAb
 cucg==
X-Gm-Message-State: AOAM531WQ9rU3QPQVbnLcSQI4yzoEtTAVAFsl2p8ob74kCAJZL/1p62K
 ij4c1Oqae2VrzOtisRnUc01wCngCLofBxF/Rgt43Hw==
X-Google-Smtp-Source: ABdhPJzSJ9hWQIENp8+bOGnRYXXz7fVTpG1BeZL8Ro546p++L2LqccA8nlpnRKJnjOcnx3/nF2SieSwOdWgEupZAKxk=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr3277571ejk.407.1603204202785; 
 Tue, 20 Oct 2020 07:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201015163459.32298-1-shashi.mallela@linaro.org>
 <20201015163459.32298-3-shashi.mallela@linaro.org>
In-Reply-To: <20201015163459.32298-3-shashi.mallela@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 15:29:51 +0100
Message-ID: <CAFEAcA9njqeYA=sy9aBjgpfto=UbLeYG_dHmxqy-D06rOR0o7Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
To: Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Leif Lindholm <leif@nuviainc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 17:35, Shashi Mallela <shashi.mallela@linaro.org> wrote:
>
> Included the newly implemented SBSA generic watchdog device model into
> SBSA platform
>
> Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 01863510d0f5..671859ec9711 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -30,6 +30,7 @@
>  #include "exec/hwaddr.h"
>  #include "kvm_arm.h"
>  #include "hw/arm/boot.h"
> +#include "hw/arm/fdt.h"
>  #include "hw/block/flash.h"
>  #include "hw/boards.h"
>  #include "hw/ide/internal.h"

This new #include is a leftover from a previous version of the
patchset and I think not needed ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

