Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4734FC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C313722275
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlZsysPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C313722275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXYZT-0004zw-QN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 19:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXYYA-0004Rz-JU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 19:38:46 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXYY8-0005u3-1q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 19:38:46 -0400
Received: by mail-ej1-x642.google.com with SMTP id bn26so4653862ejb.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5kaHV0Pg1L9fG8vBTEC9pxRQfu8xlom6xDAxH6720ng=;
 b=WlZsysPHj16bwCqkztRcvGGc6jMIJw3MO65fLLvBLbCYh/Hk+EhPwscEdJh/eLXqXc
 3lYrfDXvfqKT/qM09Pnoxr/xqXW+32sVeHKAPu838TcO9YrUknggoip7paI+kpxi4AUj
 V/GyObWUoygT/G3PFA5iko6gpfokQyXypzZzMiPoAQNi/qNP1CTikx3IEMaJ0elcoYEb
 tshii2Jg58Gfnnts+gaFKv/+q5wkLDTsJjcsTG+T5T3YYFpAzln8mpshqDizQq9SwTIG
 spHq4XZ/xdqfH35O4KCPQWWDzo6XYYsHAoFHnJmKJRJHmvZHUbE6DkXRn5Ii664P5h6N
 8Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5kaHV0Pg1L9fG8vBTEC9pxRQfu8xlom6xDAxH6720ng=;
 b=dwckJ5ze9u6FxrUW8ElxlyXf7ccb+G4S/1C7FoAIlL6Mk2mFHAO8TOlfMY6vHWwNyV
 tPXvtUbOxvh3wZ3PehQh83pZIsfpQSYxrFv65ySD71SN7fUtfphlk/XeIb/qAROVGcUb
 ZuQ06qlmwM1uZawQuiIrZD9lwmu8EWevC/cD2GQ2pkU7zhlZQyOO9nyxjgxdTwlC0jkW
 cf9LAhnY8sn4/nuWA+usFbcZEYLrdtuZcmtyCfeNHHYAt2e605ID3teEjioKuJ6gv9/f
 VVemT/Xm9VfJSkj4J4Bz+B1WxYcHpSHAn/3a7Rr3YclstthJw2V4ObOqHfTgNzMkvdV5
 GYLA==
X-Gm-Message-State: AOAM531mTc1ET/DJGsfuhjXEyywh4w8EeR9FyGVZAxwRaHxjlELtiUWP
 CwQeNXxtducu4fU5FPnNTMGg2Z+IX6SX8EhypLLKSg==
X-Google-Smtp-Source: ABdhPJyzZLlzajYITpFAF3sp5wYGumCP2Hqh0Tb1qdy+EaXYWdqgp359J3YfctqxyaJV0ewSlBJ0RSI8XDTigJg+Xxc=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr4846557ejb.482.1603841921787; 
 Tue, 27 Oct 2020 16:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201026212853.92880-1-keithp@keithp.com>
 <20201026212853.92880-2-keithp@keithp.com>
 <CAFEAcA-0_WLMP1Y1sgcu7Ng+0w8Ovt9DVWzYU8ZA_FA2+bwcUw@mail.gmail.com>
 <87pn53e3ke.fsf@keithp.com>
In-Reply-To: <87pn53e3ke.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 23:38:30 +0000
Message-ID: <CAFEAcA8Sha5QYbO25dtzBZHoXUeiGVv8aojPFTMrst8nbVDAdg@mail.gmail.com>
Subject: Re: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm <qemu-arm@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 21:56, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> >> +specific_ss.add(when: 'CONFIG_TCG', if_true: files ('common-semi.c'))
> >
> > I think this adds this file to the compilation for all TCG targets;
> > you only want it for targets which have Arm-semihosting-ABI compatible
> > semihosting. (Various other targets either don't have semihosting
> > or have their own ABI.)
>
> Right. These should have been target-specific source sets so that the
> file was only added to those targets:
>
>         arm_ss.add(when: 'CONFIG_TCG', if_true: files ('common-semi.c'))
>         riscv_ss.add(files('common-semi.c'))
>
> This appears to work in my testing (building arm, risc-v and x86_64
> configs).

I'm not a kconfig expert but it might be preferable to have
a new CONFIG_ for arm-semihosting-ABI which the relevant
targets enable. Somebody else may be able to advise.

thanks
-- PMM

