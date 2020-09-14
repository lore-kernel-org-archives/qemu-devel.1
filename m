Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85A820732
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAjDkflS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85A820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxAV-0002LP-KK
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 18:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHx9U-0001uW-QM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 18:40:48 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:46151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHx9R-00047N-Px
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 18:40:48 -0400
Received: by mail-ej1-x643.google.com with SMTP id z23so2161739ejr.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O/2e9hILLquDY/vf6zAoasgy7+Dqn8zRzQpwlQE6unE=;
 b=PAjDkflSMsTxxzzS69KyUDCIzckwEj1AV8LZ+zUY2SbJlEcE8XtZleklC7+3trWd3C
 aGT0ITP9P0IuUNcyOh1541/C+8il/xKNLDaDqNsRP9qG+7uJegALlLiiSIZSS/1rHdGt
 yEKS8RsdvLWwXsI9ku2Hnix6EdyXh8wxmcHwF2w3BgL2N9A2D9cfGuX540PMJlUgz9Io
 4lKym4sO2GYUt4jC2V2AsvcUxlu+c3Y8TrA/f1vKvR2Sn1ljPzd+Qn6rouXsCdLeFLBs
 FJ4f2cCb0+M7HcE3ycHZ/us/CN3OQqAekBANsiV4CsSoqaxAzmfkIXz92nesNCppcUzY
 +KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O/2e9hILLquDY/vf6zAoasgy7+Dqn8zRzQpwlQE6unE=;
 b=DHKx9Ip/mb+tq/JoAcpFerDyblgrz0GsgYjJMG7u7cPxmxLsOyA6eX8A+RGtpHGXXS
 ieAqWYgysEXBkSfsyN+FhRKjXoie5c1HBGGiG0fbLh1kPlOLOwHkYP192aEZkNRH4Va9
 5QOJewPElNjpuXlgCrkZJuYFc1n/SVqvr1Kx+QTDCspVsZkSyIcbHrGBDIvXBYk3EWF1
 jdjFooeMd4To2zhlHQjcJ+/7Uud87MlYWfm27I6QBdyswRtFcvWQ2UmUzAXGVMhF7OUS
 ifhsW18TBQn0Mmd9iyjYQJ1vll/KUWVJprPCdbWjxIe47spEKnnRLWQCIM9X8GiVqzhe
 RZmw==
X-Gm-Message-State: AOAM530iWExLou17JIWLs8qkfE2xEu0uk6sHEJPLjpbLLLILg/oOL1UM
 IogMhccdGfVSMaWcK546UM8VMhahHVspD8VR9Z1JBQ==
X-Google-Smtp-Source: ABdhPJzZCuIa2RTy6EupiLTD8Ry/O4qRT1UzyLMVc0PV/UdjgxuQNoDCjb0CiHn9PXDgG4mTkmfyDo5RbBBQ3mwYrfw=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr16524183ejk.407.1600123241548; 
 Mon, 14 Sep 2020 15:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200914195821.GA571133@localhost.localdomain>
In-Reply-To: <20200914195821.GA571133@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 23:40:30 +0100
Message-ID: <CAFEAcA_122rB0NQMnfjRdxBBrMUiFSfgFUZqhbCNzu757aqx7w@mail.gmail.com>
Subject: Re: question regarding vexpress and aarch64 secure boot
To: Thomas Meyer <thomas@m3y3r.de>
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

On Mon, 14 Sep 2020 at 20:59, Thomas Meyer <thomas@m3y3r.de> wrote:
> When trying to boot an linux kernel with
>
> qemu-system-aarch64 -s -S -kernel /path/to/kernel -append
> "console=ttyAMA0 loglevel=9 nokaslr" -dtb /path/to/dtb -M vexpress-a15 -cpu cortex-a53 -nographic

This is trying to boot the vexpress-a15 board, which uses a Cortex-A15,
with a Cortex-A53, which is a different CPU and not compatible
with it at all (in particular it is 64 bits).

Unfortunately a lot of our boards don't really sanity check user
arguments; it would be more userfriendly in this case to simply
forbid anything other than '-cpu cortex-a15' (which is the default
anyway).

The general rule of thumb for arm board models is: don't try
to specify the CPU for anything except the 'virt' board,
just use the default. Almost all of them are models of
specific bits of hardware which did not have pluggable CPUs
and which won't work if you try to use a different CPU type.

> I do hit the assertion:
> qemu-system-aarch64: /builddir/build/BUILD/qemu-4.2.1/hw/arm/boot.c:742: do_cpu_reset: Assertion `!info->secure_boot' failed.

This assert fires because the board says "I always boot kernels
in secure state" but the bootloader code knows that AArch64
CPUs don't boot kernels in secure state. The contradiction is
because you've tried to use a 64-bit CPU on this 32-bit-only board.

> So I did try to boot with "-machine secure=off" which makes the kernel
> boot (at least a bit...), but it also seems to drop EL3 support in vexpress.c:
>
>         if (!secure) {
>             object_property_set_bool(cpuobj, "has_el3", false, NULL);
>         }
>
> which triggers arm/cpu.c:
>
>     if (!cpu->has_el3) {
>         /* If the has_el3 CPU property is disabled then we need to disable the
>          * feature.
>          */
>         unset_feature(env, ARM_FEATURE_EL3);

That part is all expected: saying "secure=off" is saying "I don't
want EL3/TrustZone", so we give your guest code a CPU without it,
and then your guest falls over because it assumed it was present.

If you want a board type for AArch64 work, we recommend "virt".

thanks
-- PMM

