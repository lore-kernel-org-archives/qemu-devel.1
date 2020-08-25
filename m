Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854FBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E1720738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5vv8DGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E1720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYBQ-00073q-4m
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 08:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAYAo-0006Ne-UC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:35:35 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAYAl-0006nl-UC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:35:34 -0400
Received: by mail-ej1-x643.google.com with SMTP id oz20so11350580ejb.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8A737/DKrYh9uyX44xcwujC6YeU+OC0xxDzLI1ANFW0=;
 b=S5vv8DGtFwBS03ICqE0tEHu2hRoK3m/gELrFRePiSnEDauLQIVmv04uAxjoDWOq730
 S9jpYcZ2Dx4Qd+YMRu5XL0LfVhfPV7Xt3EGtAsg26iDgh2lG/oBj7jURtmdZVhLSbO0B
 FvVgGQZamN7ck+S7xFwvlKsyrhF4yzY2SEfRhVmmfk7voHJGaI1HxYwQ4WE+ESUnsDo7
 nfo4VzngueORoQ2ErbPUGOqNNqePBDishFUYQ7bV84MLLc5EmozsEpCqXdCQp8yQ/jcL
 Pc61w3ZSEA8y6oZkCQ3kU3SF+jRpg6Dzb2BAHPHgSYqrwl7rAzgaQuH9nURvMl5CLaHx
 +n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8A737/DKrYh9uyX44xcwujC6YeU+OC0xxDzLI1ANFW0=;
 b=SXVIo17fK/kNPAgyGgdKjL2AiVa8ThgsnaXOh83ApRmcfAt3Ge3ePlOpMyMywlYegv
 zGv39RO1+ZJEYx+yGI8smU4DfgWEax60/m5eVGmw1CawXM31d/rr7LsA98F6Tz2nCVyN
 k/zl2FFQkud5geQOpJJstpx0rymVp7JAnLxYYjnPJHjAtUw3iP0Ec6rgt8BwhiuFoBuL
 ikeOAcjLVvvnfFvPhyMEZITBvejNP18tNSAOsb/Y/IyJNkQcD9dyGR5GufdUBEM5NoSG
 4imKmOROP1kveQSUtzvVaJJjb7O28E3k3htZRSIu8q+uvNfmJW71kDCRvK8uBQaYtCQS
 /H0w==
X-Gm-Message-State: AOAM532UycPLVuw7E8mhUtlXQvyURPoxitkF2YurqVz1Vcg906Ak5SKS
 pzbUfSfCAYQ6k3FG0LA3LF4fpmqDRT1Q4qRQI9499Q==
X-Google-Smtp-Source: ABdhPJy9O3f1G/JlOAisG5F/m2zoBzsTWdbBFmfi+CqUEmjHJtK5KAHiatDDUChwfJfBXfsDYdY3+Z/4BWefSE5A9CA=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr696161ejg.250.1598358929313; 
 Tue, 25 Aug 2020 05:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-3-kuhn.chenqun@huawei.com>
In-Reply-To: <20200825112447.126308-3-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 13:35:17 +0100
Message-ID: <CAFEAcA-MJZp5RVvg=tM45kz+=pZ6t8gm-zdkLLzC9C59QVCoDw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] hw/arm/omap1:Remove redundant statement in
 omap_clkdsp_read()
To: Chen Qun <kuhn.chenqun@huawei.com>
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 12:26, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> Clang static code analyzer show warning:
> hw/arm/omap1.c:1760:15: warning: Value stored to 'cpu' during its
> initialization is never read
>     CPUState *cpu = CPU(s->cpu);
>               ^~~   ~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

