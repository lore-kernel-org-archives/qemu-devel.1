Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9E2208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dna8KVku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E2208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEdx-0003rq-RV
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEax-0000pM-K5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEav-00048H-NP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZEav-00041M-I5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:45 -0400
Received: by mail-oi1-x244.google.com with SMTP id v186so1373665oie.5
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=qoKy7Saj12BIUDx2o/P3rez8CKgTVRuN+CfgSrIfYdE=;
 b=Dna8KVku8xmLsApVdhbe+Ub3kTu3xvW6AXgeRay+YowUYX64rsF426DQUsYLSV3keW
 l6qbAINawVG2qEAcClU41+OrV6WwzayQTY8nFlLc4NGhXoenpkGiJib1jgJ3xpd9kLc9
 fZIClwZgVpk8LumdXldrCQz19lPrrRz7Z9qUnhdx1v3uCmEKsoaBJgAk5LlnSrSwgrr3
 ymBLEBH8YHTMii9mpTcRDJty5NXlgXSIBBlLapvHtaPxKxkOALhF4XBO4DBZNZPOf23M
 IQLWfxzD3q15sn1LQ7f8EqmhpBlsRm8jszIRbrdlsJrEsm2DiqS6KNhGE7zHq0931EGc
 64Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=qoKy7Saj12BIUDx2o/P3rez8CKgTVRuN+CfgSrIfYdE=;
 b=jBHRCtlrTo6YSyraxZ+z+1sfxI64mZ1uVgU99B85VFsbxGw1/zq0ShOVxkMPqBdOTB
 YFE/4eEWwSHL7SgQTTcw9wGNk+nG81qal5bYU/mvrLS/Q5Yp7PwbmQDRgL1hcDarViDP
 Xg3ZYc8r1to6s8+xUi95IGTiZm3MIZZ2ed5JgX6UDvF4trQZ1gFiGaEqiDa+Bnm8RAjV
 c/RSqFBBBVkTAHdMCcETR5p6qixGNSBaOSUYEG0BG0PQi8VIPtSX2kGemtu8c0bh4u5q
 uWTjGep2LR7qGPZ3DrPNEVjQRRLw+gebROO1m9LPYal1ZnRY9/Hu/NyFKg4oB1Lh5PLD
 7A2Q==
X-Gm-Message-State: APjAAAXc/3YmDfcP4CjLQxH1JOyIQw53+sfR8uI/gia9cYJ0VXXro9G3
 RPQFCcbMf3iqMTq2sfrPG69kqN7xXNMsFkAyhCc9ZNHY0RA=
X-Google-Smtp-Source: APXvYqxgit95QDdrkZKFf+Ip41P3rb8CnqTQnCiCYtTjqvQlCG3cuYAoRScBOxzvGnYeQg7syXiLCcxeENhzTysFSkg=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
 d17mr3674213oic.170.1559912862814; 
 Fri, 07 Jun 2019 06:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190517174046.11146-1-peter.maydell@linaro.org>
In-Reply-To: <20190517174046.11146-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 14:07:31 +0100
Message-ID: <CAFEAcA9G7ssOOg5ZtuGebsCh_Qs7dEk6k7RUiLAu9zhoOAvnKQ@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 0/4] Disable FPU/DSP for CPU0 on musca-a
 and mps2-an521
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Fri, 17 May 2019 at 18:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The SSE-200 hardware has configurable integration settings which
> determine whether its two CPUs have the FPU and DSP:
>  * CPU0_FPU (default 0)
>  * CPU0_DSP (default 0)
>  * CPU1_FPU (default 1)
>  * CPU1_DSP (default 1)
>
> Similarly, the IoTKit has settings for its single CPU:
>  * CPU0_FPU (default 1)
>  * CPU0_DSP (default 1)
>
> Of our four boards that use either the IoTKit or the SSE-200:
>  * mps2-an505, mps2-an521 and musca-a use the default settings
>  * musca-b1 enables FPU and DSP on both CPUs
>
> Currently QEMU models all these boards using CPUs with
> both FPU and DSP enabled. This means that we are incorrect
> for mps2-an521 and musca-a, which should not have FPU or DSP
> on CPU0.
>
> This patchset fixes this (fairly minor) inaccuracy by
> implementing properties on the CPU to disable the relevant
> CPU features and then wiring them up through the armv7m
> object and the ARMSSE SoC container object, so that our
> IotKit and SSE200 models behave by default the same way as
> the hardware default does, and our Musca-B1 board model
> forces the FPU/DSP to be present on CPU, as the hardware does.
>
> The 'neon' property is not strictly required for the M-profile
> issues described above, but I implemented it on the CPU
> object because disable-neon and disable-vfp interact
> for A-profile CPUs.
>
> thanks
> -- PMM
>
> Peter Maydell (4):
>   target/arm: Allow VFP and Neon to be disabled via a CPU property
>   target/arm: Allow M-profile CPUs to disable the DSP extension via CPU
>     property
>   hw/arm/armv7m: Forward "vfp" and "dsp" properties to CPU
>   hw/arm: Correctly disable FPU/DSP for some ARMSSE-based boards
>
>  include/hw/arm/armsse.h |   7 ++
>  include/hw/arm/armv7m.h |   4 +
>  target/arm/cpu.h        |   6 ++
>  hw/arm/armsse.c         |  58 ++++++++++---
>  hw/arm/armv7m.c         |  18 ++++
>  hw/arm/musca.c          |   8 ++
>  target/arm/cpu.c        | 179 ++++++++++++++++++++++++++++++++++++++--
>  7 files changed, 262 insertions(+), 18 deletions(-)
>
> --
> 2.20.1

