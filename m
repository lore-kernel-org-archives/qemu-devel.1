Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450CC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5910D247D4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvOQJL5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5910D247D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrgn-0006Tw-AV
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrg2-00061o-PJ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:04:10 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrg1-0005cL-59
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:04:10 -0400
Received: by mail-ed1-x542.google.com with SMTP id x1so821366eds.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OYSyN3jssG4zxhrN+s8V2mcRQ6v9sSBH3anL+eZPu4E=;
 b=vvOQJL5uOIeGHaxCAE/BgmyTqu+XriefqGLJ6kpBuKoIR6FKWrL5EFvg26Pz6SDIya
 ORH6s3HnFb+2ui5s8KTn/owMSicSozz3qi0DhsGSOWqql4CCMZ1fj2lZ7DGcCY8xPvo8
 hhTF9rzX4jhcI+aE2mVuKtxSRIxdyVnB6nPiD1HFBqS/eC29r6LIdcz7QMpMgTk1ODsG
 Lb9dn+PF1gyeBjM0H6w93TrfDDwSv60FyClAKRgzU4nO6YqJEDZZkSpiiv4K19gy9grJ
 AgskK1TbiHFbOfSJSDsko9LVVGkw0so030sZmwvfgOmNddHDcuavPUwC8RRAKPZDSIov
 uhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OYSyN3jssG4zxhrN+s8V2mcRQ6v9sSBH3anL+eZPu4E=;
 b=HZEnkBKU8QLWlFm6mWELU8EgsHE9W2CgvLYDAtsnfJy0X9w5BlyxoOiyzb7ZgVXztE
 diJYHw8OTXKCEuw9CIfujQ+f988zyZU2uMzo22G2hxrUeWfn1Q77xJR6m0VM++x/19Xh
 DRZAJIPgYzxhFcYEgdqPJucVE48BW8YocsFERy+K7AQ0StbOkqIMrY89juC9Tv5zGTKA
 xuhWGRw/LNHY5eXy8pSYhme/ZjgaSaNTLaAb/xWNmQcWbzhEA8goubXy+o6zNVHQ+Mw9
 mHPyZMh6AsWPCw4IRE27SpmHTIKsepTp+UYQAM0uKUhgGMDIkZM35QOlg14ovCg925sk
 hFfA==
X-Gm-Message-State: AOAM530i83LY7Nka4PxipShG2zKX4T8V88G3wdo7NP8xhojo5Dyz6xnL
 b1Hv1ZfQJIM64amQTFpVSVwTx3qpikIGiz6z0kxhSw==
X-Google-Smtp-Source: ABdhPJxoE4d+BKynpUeIP8hSV9hq4UXJc9XUfRtzRkH4FGojcKQUI8PgufdDFrpmDXZUxs09KduvfJJToGOo9xB7rEU=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr663940edb.52.1603915447314; 
 Wed, 28 Oct 2020 13:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201028032703.201526-1-richard.henderson@linaro.org>
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 20:03:56 +0000
Message-ID: <CAFEAcA9ZUeTXEgaNHDnN2SNEoV4RjA9RE-tSuKo1UUJ3ptSw_w@mail.gmail.com>
Subject: Re: [PATCH 00/11] target/arm: Fix neon reg offsets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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

On Wed, 28 Oct 2020 at 03:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Much of the existing usage of neon_reg_offset is broken for
> big-endian hosts, as it computes the offset of the first
> 32-bit unit, not the offset of the entire vector register.
>
> Fix this by separating out the different usages.  Make the
> whole thing look a bit more like the aarch64 code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll put this into target-arm.next since it's fixing a
bug on BE hosts.

thanks
-- PMM

