Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C81C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167D020754
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NreGa9cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167D020754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5k8-0002ye-PK
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY5jO-0002Yz-Go
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:04:35 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY5jK-0005nz-4O
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:04:33 -0400
Received: by mail-ej1-x643.google.com with SMTP id w27so3252487ejb.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MPNcObTazh98BLCtafuzpMxINuEC+EGYZwZc/hmJOQs=;
 b=NreGa9cjDpsHZOL2opI9I+uldWzNMolQw4GXeiCy6Ybx5WFcYFF+gbAmcGrn6Ne922
 0b03XmHluyu8EgZDtAW1sW15V5OwW9MjHNscILgVTvuJYK8ixDi8VOkgaTOKqCX4Vrgh
 Qy1vbH/gBY2irF76qIPTAK2j4h8VGExut6lt5+LitU8Mg4i3sVun8GPI+/BjIThETyOV
 D10bImMXX66GX306ujqk+iRDxKD/y+b84YDS5cO26gAfZ8ReDk2PqHWsb+wo4pMN0iR7
 Gy3wlON6vA25R92/VTEDMM7hyvq1DNOosrw9z9hwWi0omOd0AgXXjhChmchSJELiI0Df
 dwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MPNcObTazh98BLCtafuzpMxINuEC+EGYZwZc/hmJOQs=;
 b=Uhsi6rjODAghSy7SK3V1befIFA6QWKh0DO84K+xPQ7ep9vOox4NCHQj6hT5+oLrItd
 IjsnmkYUOcOxe/XLSFcycGkdo5QIInWRyvPZcaIORquupWmQHjVH/rWMjnehBuNd4T5U
 5b6srrlGOFKv2AZ3EoTGKmtjgW5A862KefvfEHXQWh7eWHetNp4634e/vslOt4ccn1dh
 IxMdF2wmBuW3Lje8LhhZ79V74CFaPOWu7OHxdOUZ3mUdhl5oKskw8src9ObdxrVwQFps
 uMj9vT23PIekKLn7oU9Hr/dQicqCVtE0shwhaI3UYy8F/RLqA2wL0c8kgzWfORqsXAlk
 MspQ==
X-Gm-Message-State: AOAM533LwzXdd/5K36BoXzwKnYXf5mcJCUcUBQl2xKZ3EUDZFZZm6qs4
 V60TT+wmXNtsAOTBDKCRw2f5psQ+Vi1hx30Q02bYeQ==
X-Google-Smtp-Source: ABdhPJz6QePRbfjJRGzgN8xuJkR6iD2UKKnwygj8CXSWHOMeHFjQfiZdCzcfyz6mVkUIDRPmKaf46kQJ1QX0DkfvRMc=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr3520800ejc.4.1603969468447; 
 Thu, 29 Oct 2020 04:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201028032703.201526-1-richard.henderson@linaro.org>
 <CAFEAcA9ZUeTXEgaNHDnN2SNEoV4RjA9RE-tSuKo1UUJ3ptSw_w@mail.gmail.com>
In-Reply-To: <CAFEAcA9ZUeTXEgaNHDnN2SNEoV4RjA9RE-tSuKo1UUJ3ptSw_w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 11:04:17 +0000
Message-ID: <CAFEAcA9Jw23_3styd9RivZy04GCdmrPNw1y8zHM5Z+G5wOYCTg@mail.gmail.com>
Subject: Re: [PATCH 00/11] target/arm: Fix neon reg offsets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 20:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 28 Oct 2020 at 03:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Much of the existing usage of neon_reg_offset is broken for
> > big-endian hosts, as it computes the offset of the first
> > 32-bit unit, not the offset of the entire vector register.
> >
> > Fix this by separating out the different usages.  Make the
> > whole thing look a bit more like the aarch64 code.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> I'll put this into target-arm.next since it's fixing a
> bug on BE hosts.

I'm now assuming you'll send out a v2 with the VTRN/VREV
missing-tcg-free bugs fixed.

thanks
-- PMM

