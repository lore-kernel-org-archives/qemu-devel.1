Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E6C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766662087E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+QJ+YdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766662087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVQw-0007xw-4T
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVPr-0006U4-CO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:30:07 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVPo-00014Z-7B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:30:07 -0400
Received: by mail-ed1-x544.google.com with SMTP id w1so5737534edv.11
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NFC39zceG2i5PizwvZ93zNijf5+W6zdm3h74OVX7MHw=;
 b=u+QJ+YdXWOzUPGLjBli0nwiLKVuv471nujgNi/3R6oF3X6zsMN0E3wsg75seRCVAuJ
 JNTvntIE1UJOcldV+vP4tAmdR4YuG9X9O4dCa4jeXNh+DzfvUAT/D29r+tvNzkpOxo6u
 Sgov0uQD/mFtATUnQlarNkCeeRmr9VSQHvYplgEV1uBnR7DL4yzu7LTaGEJN/ERZ+4cK
 SbYwKI5QGBevA+jI8sVHtmWswVk+1Y5DLGRjhjyomj72R4v6nUIsFH27ROmlUnWRmOc2
 PmJ2rki2L/MMr8q+Wi/hCLJ/jXeOecjx+uf3bfCg5yL7veNuBSbzqikNrV8FLX9AAkRv
 EQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NFC39zceG2i5PizwvZ93zNijf5+W6zdm3h74OVX7MHw=;
 b=gxO2jfPehQeiYrUKZxjqX0qTWnreXZucWVeGO8d+e8JcqFYIr65HpeHDdvlnaeMZUD
 FaUxtJwNH2VPrrKCutatIJivpI085asghcWEown39lxqERcO79+B8CsEKXnDM2tkFrGH
 /fUw7u4QUwsTYCgPy5vH2xbde0WFDzzO7fIRqSC+87d+2F5CJLPBDxNi4UrHYC5hB3Wn
 TXNfAKvhv9R+MJbLR2TAIzjBQEfS7pL5Ve4ByOIh9ddM3d0M/rAQE4UFOHwoe/gHH4NS
 ZHYygpAIw8GDU3PdVYN4LOfteFlKoRFoju4kUvCFTuxxmJAsPHnzq8qzICbfKiDfxO7I
 fi5g==
X-Gm-Message-State: AOAM531d8IQa2ecJZXvqq57366j51Phfcs5morIvHiCGs0m5dkkL+NmA
 VPSo/H2cvYRzTPV4+D80ZW2E8yoR24E53o47ILV2/w==
X-Google-Smtp-Source: ABdhPJx6FCWljKrUairC2DLeWPCw2fKw1oLldfsils4Y62/uuplvIwLeKUS5j6F4jcxjXcsCdgijcJKRuYI+Tm2U0so=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr2639196edr.44.1604068201154; 
 Fri, 30 Oct 2020 07:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <5F9BE993.4050406@huawei.com>
In-Reply-To: <5F9BE993.4050406@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:29:49 +0000
Message-ID: <CAFEAcA8hpb2UVd3PSY4XuEpKYeu1Am1+41DQ=gN48xbAv281TQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/omap_lcdc: Fix potential NULL pointer
 dereference
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 10:23, AlexChen <alex.chen@huawei.com> wrote:
>
> In omap_lcd_interrupts(), the pointer omap_lcd is dereferenced before
> being check if it is valid, which may lead to NULL pointer dereference.
> So move the assignment to surface after checking that the omap_lcd is valid.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> ---
>  hw/display/omap_lcdc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

