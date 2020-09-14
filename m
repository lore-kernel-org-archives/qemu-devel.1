Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C9EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 18:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E13521974
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbIweeul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E13521974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHt8J-0007c8-Vh
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 14:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHt7N-0007CQ-NX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 14:22:21 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHt7L-0005oO-Tl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 14:22:21 -0400
Received: by mail-ej1-x642.google.com with SMTP id u21so1363426eja.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=68ZKRipLBheNkEKGaKki5ThVFW/YUyrY5JOGx4uOmJA=;
 b=vbIweeulZi6+1Ix8T9IBtAi2JoCNOea+jvgZvHldUMRwK444XijpUDERwHxcfDnb6e
 L10P2c1QSM2f9v5vAAxc2uTTxWHHnQ2Gc+xAJf01ze++2O//JzGUE4Dtqp6XQAFYSwZx
 m4ULj6tPqDOKI6WDcbMrn5/x+U0ffFdTxEknfU0C/iDMBrWc5qvjBm/8tm1eEA8wGX1y
 ZuEwuq2neoBeq0GHxhbZLHHQ7d2flY6YH2Y42uYSrfLz6NVebxEAPq826K8kXoMQm1bp
 kR9lUZAKhipfSISX2ZCBn3YSPlh3GdvROonIsoZU2ap87O7jFlKA+7VMnNRgMV+JOEUV
 NKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=68ZKRipLBheNkEKGaKki5ThVFW/YUyrY5JOGx4uOmJA=;
 b=MRZtMgjY36ziQDXUwZx1YzO2jOednGKWJx/kPmc39MhlZsdTFZagNH9yK6AW9ePri+
 tqKqpaZEbLk7D4cN6J9/J5APx6srqlSuMRWbmkmhjsZgaKo7lqvO4aFtThr/cEWmG6AL
 lD/OLIassp83AtMV8JCDakX0DzgBPqraO6ac91mu6z5YHcVWIdBys7XU0KWj1dCtA66l
 fmZzYHVahAqtUzBu0BWO0yRfmisQ+36Y4rsewhWMkFjiwG3LaKG023CZfQGtJ0CVAXt0
 jhQQGxqYBvbJ8Xzsys/ybukimAeK1ojnf6c5B6qVXfhEvm9lQVEO6puMUaY6J61lhZeJ
 wmsQ==
X-Gm-Message-State: AOAM530YJGYfQrQvp69kgUFZ8tx5vGSROJhQJziI3ZT9NCPCkVFXm6Dz
 GUAw8GEo9n4CThp1TBXPP7ahdqPcWNMNMOC7cDn7+/YEVLo2EA==
X-Google-Smtp-Source: ABdhPJzXz61uql5wpDLQ013ZkS9xE2zODUJyC2VPyLEcEe6MkS8MCFx+PZhle4s5TNfIsLsJeK2ydwJXtAbp6/kuc6A=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr15333595ejb.382.1600107737855; 
 Mon, 14 Sep 2020 11:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200914150254.6489-1-peter.maydell@linaro.org>
In-Reply-To: <20200914150254.6489-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 19:22:06 +0100
Message-ID: <CAFEAcA--pCnNa+ccxZcjzvcdJj5AwQsv7xbc1tenj8aiaKN8Og@mail.gmail.com>
Subject: Re: [PULL v2 00/32] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 16:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> For some reason the xilinx can bus patches built in my local config
> but not in the merge-test ones; dropped those.
>
> -- PMM
>
> The following changes since commit a68694cd1f3e5448cca814ff39b871f9ebd71ed5:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200914' into staging (2020-09-14 12:18:58 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200914-1
>
> for you to fetch changes up to 4fe986dd4480308ecf07200cfbd3c3d494a0f639:
>
>   tests/acceptance: console boot tests for quanta-gsj (2020-09-14 14:24:59 +0100)
>
> ----------------------------------------------------------------
>  * hw/misc/a9scu: Do not allow invalid CPU count
>  * hw/misc/a9scu: Minor cleanups
>  * hw/timer/armv7m_systick: assert that board code set system_clock_scale
>  * decodetree: Improve identifier matching
>  * target/arm: Clean up neon fp insn size field decode
>  * target/arm: Remove KVM support for 32-bit Arm hosts
>  * hw/arm/mps2: New board models mps2-an386, mps2-an500
>  * Deprecate Unicore32 port
>  * Deprecate lm32 port
>  * target/arm: Count PMU events when MDCR.SPME is set
>  * hw/arm: versal-virt: Correct the tx/rx GEM clocks
>  * New Nuvoton iBMC board models npcm750-evb, quanta-gsj
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

