Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC30C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0332068F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI8k1bnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0332068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3OvE-00045M-AL
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 15:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3OuW-0003Us-FT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:17:12 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:42078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3OuU-00053t-Cj
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:17:12 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id k4so4626409ooa.9
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8yfgoATuxZMwPlAf0RNN7saocTmnNYrbYTVrbc87Zr4=;
 b=nI8k1bnwX/t7qzR8UTyk/YBNG/CHxiB2euA4jxhkw595xqchVhpoEPo25JcLe2BX19
 oVWtPTC43iAlm2Kiu7TB0ztKYmVUP/kFSf5tnUqv0J3Q4lA+0oJQUaOneAm0YcPF7+6l
 onYQFHRf4Of4AKbUCAqMnlB/5nhPnmTOsiEmur3Df75eeUOfdwplOn8Z2JgLfrZs/68z
 NzshZjgGLZZRU/EA8qV1v0Wx/9R/aWe8CuTYjq7MSlNkngLuTgnxV3ujE9F5zYbb/bfX
 BvjVUL7MOPLAuZwQ7gtV5+QWEq4b0TYCiI9pfemorO0VDf8TnQaTKqXLzNtD1u1wFvEs
 DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8yfgoATuxZMwPlAf0RNN7saocTmnNYrbYTVrbc87Zr4=;
 b=USMt8iU5p7AqEG9sHCxRA/xKXqyVRIGXX5C7skDAqeY8aPnZGOeJi4U4n3QFX5X3Q5
 3fxfKa+3oc0GfRvL1zYl7BXxv6hHDZ21DONu9/d53xn2tEnYC3pZa+XixhyXH3IFL6Zk
 ITRl8EcVqA2BCAw5H9yXBFjcndOx5LK4YtlHwY0vA17kXx0We6qNfcFPRRUnpprk1K+Z
 q/SbsoOH0pq7dTjfglpmJ5X4zGJt/2tbdXPmIb4U7yEHaq8jbo0MOoOe+91lZDMkxCGb
 x6cjPZA7v/7QFM4112lcgrNifnE8Otyq1H4Ktto8LMckmMeJuGePMZ8okp7yTM55Ki2a
 Eozw==
X-Gm-Message-State: AOAM530cZFfzNJP6xQvlvmQHDbUbtOhNLaZ0ydtHU9lnbq9q2gWmyNB+
 NAA3tBAqjJmgFFMOMn0xbSJIgRh4FlZdHM9Co+Wy0Q==
X-Google-Smtp-Source: ABdhPJzEcrZOckd/yjLK/krpvvhnjfofcDM2u3g613LDcd/00SIWayI6ABZVTRjZF2Rs/kRkR9Fly136LL6o5+1/K+s=
X-Received: by 2002:a4a:4c44:: with SMTP id a65mr4315067oob.20.1596655028606; 
 Wed, 05 Aug 2020 12:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
 <2c5ed9d8-6d79-1b53-5588-8fb9efebf0fa@linaro.org> <87tuxhkpo2.fsf@linaro.org>
 <CAFEAcA8+acTg6KoBDW5-7FvnrW=vDMXohWfTAXtTFv6BDqyuRQ@mail.gmail.com>
 <a1e53e0c-fbab-a789-5f07-cfae99b6042a@linaro.org>
In-Reply-To: <a1e53e0c-fbab-a789-5f07-cfae99b6042a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 20:16:57 +0100
Message-ID: <CAFEAcA9v3QysnfUjbUwTYcVAxkRRwaLWSFOq_negxWR72m3E0A@mail.gmail.com>
Subject: Re: v8.1M cpu emulation and target-arm feature-identification strategy
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2c.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 18:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Older ones like XSCALE are obvious

Looking at the XScale manual we could actually implement
ARM_FEATURE_XSCALE as (cpu->midr & 0xffff0000 == 0x69050000)
[Vendor=intel, arch=ARMv5TE], and ARM_FEATURE_IWMMXT as
(cpu->midr & 0xffffe000 == 0x69054000) [Vendor=intel,
arch=ARMv5TE, Core Generation=2]... Doesn't really gain
us much, of course :-)

thanks
-- PMM

