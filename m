Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922B720833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8j0zi42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922B720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadJq-0004tP-Oa
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iacwS-00058P-3M
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iacwL-0005Kt-Gx
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:51:55 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iacwL-0005ES-8O
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:51:53 -0500
Received: by mail-oi1-x242.google.com with SMTP id o12so25536234oic.9
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F573XsxzX5sf/nxyxfqM8N2v84gU2Xd4IPR9VlS2F48=;
 b=l8j0zi42iC+kaUMBQEKmsKX+XYLVXAmYdWnEzYB4l4dwVvffkTkV4S/5cew5jdbvWh
 HlokksfnDIgDi8lrnGAR6RqrAvT3MGK8jsc9/zwXdOtlLYAgWP4fW1cgM9ZYzqQQ/D8M
 lfGR7UsXEA8UeDlzvWO0J/g0mbbXpC7PbJ6p5BO89t7yHnjA8y1dgsGysBUuiGW4MXvt
 IEjx00VOZQrQZJtgGTsby4HpLZQkoVfxXPeSCwgHj4pzhhxgQf1fG0HRE2g542zyKAKd
 adzvWMjVSqxJucEFQBcmE9EmM04JpexeFW5b4Ow+5U0MOv/kVU/DnTiV5XryJ+CoQ6dv
 6t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F573XsxzX5sf/nxyxfqM8N2v84gU2Xd4IPR9VlS2F48=;
 b=G5HMDQfyoE6Zd93Hc16F/Wy4TL46bW05FTW03lU/5cmsrjzlmqiEk9aUjD2VO5SRuZ
 iX5kHbrQ6rowraoQqsFML4h0NzrteTvQ33yKy1okiylD8G7gPn9Fg1uPcZ8HC+IQfLZL
 NExeRA98jSuwH1xIRNzgddkmfkhbPJNPr1mEffrv3YbeHtzdhV6RuRN76t8mhYrO4kGF
 F/Wge65FIPo5bsEWylxIC6PcifVYzwuotDw5NAqEruF87BL+f0bn5BQb7WONFqaVEap8
 yvD7mKtHYoYZIQpzyEiAyQbQhmuFEcmbKTQmdzORhwuApjOZVa8wT90qH0SxNWBB9lRw
 VwmA==
X-Gm-Message-State: APjAAAXs2vonBvj/rYua5X2uYiIPEoatI2p+0cV8ybSa5EqfqFTPJkqM
 XILOMIwV6djZELOOSf1LNvKOL/pVsDKVQS2DQi+8PQ==
X-Google-Smtp-Source: APXvYqwXBm+2V83stX0WqwadtUKNURHmmj6F1Djs+8HjBqNtwmHx2/fTKPXWzRLjT/kVekGe9wvhCH2MTvK3O6x+Ohg=
X-Received: by 2002:aca:3182:: with SMTP id x124mr1100650oix.170.1575021111512; 
 Fri, 29 Nov 2019 01:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20191128161718.24361-1-maz@kernel.org>
 <20191128161718.24361-4-maz@kernel.org>
 <20191129082806.GF29312@toto> <3a53b096bd101f9627d4c61ecfd742de@www.loen.fr>
 <20191129094557.GB25295@toto>
In-Reply-To: <20191129094557.GB25295@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 09:51:40 +0000
Message-ID: <CAFEAcA_HM5hCpY=cC9KLy3sFDFydhLNCEmtOhBCr+aQkBKwXhw@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 09:45, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> IIRC, the current EL was always known at translation time but I've
> not been tracking recent changes.

Yes, it's known at translate time, in dc->current_el.
(The code is structured to make it difficult to accidentally
use info that's not known at translate-time: most translate.c
code only has access to the DisasContext struct, and that
struct only has info that is safe to use.)

We need to know the EL at translate time anyway because we
need to generate the right kind of guest load/store, where
the code generated is different for different ELs (they
get looked up in different TLBs because the access
permissions can differ).

thanks
-- PMM

