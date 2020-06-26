Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9782B2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3J6QXkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9782B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jojth-0002wf-TE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jojt2-0002Q2-8u
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:39:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jojsz-0001bh-P2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:39:04 -0400
Received: by mail-ot1-x343.google.com with SMTP id 64so7903873oti.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 01:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aDuYo2EkjliuBpm8C4Ix6MoXdbPblOzQha1faW5jl/8=;
 b=g3J6QXkdwi0EwnTS4hyInYwAbkyTQRtYTNrpez0mxfpBINWMg9BxUPNi0HuiSzfiH4
 TQnnFfptS2JrtWYmnGcr2kE7JDTMnbaIUzCEpcOw1Bijd4RJ30IP2tPtGW3hJJ9VuKbR
 jUy5B+zu6+5sHaBNW4vuNZW8dUWk3WirTXH5dk3I2U0zM6GSWlUlOxUMth8mg8WnhhIP
 7MCYmeaXXsPjjiNmoKZsiT6se0FJG5Fo2IJ8DQ6wRSArs5FWJ8O3fGjXa+2ADJ8NEesS
 itk8jG9F1MDwXSLJ0MEWrYRhLepy1jTeTTrd4HSelK5GSumMcQdMwEIbtG6n+viU3HR3
 1qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aDuYo2EkjliuBpm8C4Ix6MoXdbPblOzQha1faW5jl/8=;
 b=quNIvY9X2UUt5RX3UZF8wJf8lhcHLGCy2xV8dTja9eOi4Qk68GNiE7yL0JNVpM44XC
 HjDm8wnrd65p6xeqmy4ILPSyUuUUMb2Cbvul0s4P/7jOmx90IhTCoM8Fs28h2lNProGz
 FhuhUvs+LCmdDBmvM1HDJiUCLfsrFhnRBKOPUR8+Ynwlcbg4egd8RLwflGIaiNCRnc3r
 zSRmSBdYYrHDgZ76bqulmUOf1lj9TpvaKcwAN/1Z3VojJ0YXznt1e8d/wspZPFAwVYIC
 Ta/zycldP1qTI3qDNc7kmJoX48d9x+zbO35+EVe0G4hjh0UUAnz1/A6v8cr5yt5RgQ3m
 wDoA==
X-Gm-Message-State: AOAM530T5Axlf0L1IBRGI0o17uz0qhj5kzuPkKFn92qo6iw1HR0wts4+
 ADN8VgqupZ5a1sqyMn7bUz2nfaZxc7zgMmkvhAhl0JORuN4=
X-Google-Smtp-Source: ABdhPJx4KEl1A3AYFDZjrwxh3SSdUNrVo29vw8NVZB3kcK19E06WtxmHFQekloa8fikR0RULHb7/msS/zn4KbkNkBKM=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr1527643oth.135.1593160740404; 
 Fri, 26 Jun 2020 01:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200625230740.549114-1-keithp@keithp.com>
In-Reply-To: <20200625230740.549114-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 09:38:49 +0100
Message-ID: <CAFEAcA9ut5CVAgRTP-_BK3WpiDSmitFowZMe549TvgSAjj+Kfg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add 'virtm' hardware
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 00:07, Keith Packard <keithp@keithp.com> wrote:
>
> 'virtm' is a hardware target that is designed to be used for compiler
> and library testing on Cortex-M processors. It supports all cortex-m
> processors and includes sufficient memory to run even large test
> cases.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>

So, I'm really dubious about adding more "virtual"
not-real-hardware boards. We have "virt" because we
absolutely have to have it for KVM purposes; but otherwise
"emulate real hardware" gives us a concrete specification
of what we're trying to do and tends to lead us into fewer
messy swamps than making up virtual platforms does.

For instance, this board model claims to handle the M33
but makes no attempt to set up any of the TrustZone
related components like the IDAU, so it isn't really
a useful platform for that CPU. You also enable bitband,
which is maybe plausible for Cortex-M3/M4 but not for the
others. This is the kind of area where having a real
hardware system to check against means we make the
right choices about what does or doesn't need to be
present.

thanks
-- PMM

