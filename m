Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8663F2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e80z8CAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8663F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joBsu-0004cy-Nz
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joBrr-0003XA-SW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:19:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joBrp-0001Ul-BJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:19:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id i74so2999602oib.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=FUnPVV7VWiLILTvW+nIOsl/W5gW9qtiJbOvLsC8hotE=;
 b=e80z8CAoMX5N2NdyBz5hLlBOdP5fxoOib/KSsC2sPKtm8Qo/WOel814qweQhx48KbY
 msqy6nGkdnZdbcNumtiUYPxaRSGMaXFj9B3oDMhJq2dZ1rPmTY5w1sz+axGYdch+yAQm
 taXgsZlvBxBQlAjHwez2zLb9tGT66uxrA0a5DhTeYnlsWNOl1Ibh298DQVRFRp/XNkIP
 l7zJXQMa0gt3ZNiDrdQnhayRloLxuz+SnLOId6xDKWAU0elLNRcGGEHS20tUGjL1PIja
 eN1jMltxhbEzTxTsIjAGufBJpktnpYZv2pgoLrhRGfTvJD2SUUZ/6TulqzJNRu3FrsOi
 XjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=FUnPVV7VWiLILTvW+nIOsl/W5gW9qtiJbOvLsC8hotE=;
 b=MqsRo1B0c3Q32XMTthd7wv3N11sX6QRZh1suieKQElMf1r75ts4tiy5InvWQ2Ycl0U
 bP0Qp2cCILm7LpgRQfBMxGVbHZIqDTXyNwRA8ugVX4UouMqXFcoEFODgassdeDK+0dB2
 0I/nFFSTI0ayYNxMDIB+YS/oNWae6MbXSTbtyz67njGGPLGlqKcRGM4YwGcbt3nw+KKm
 ocDSf1Ls813n+l/g+lOyH2lvvWgBZLpfst+W3AkWN8dTtlz0SXDxPxRtF/ni854w6JZS
 afsmgAL/4OxPZJH42BIOdqTBii7R6uF/rz5wWGazdpHZllOiwSMQyWZOOV4QNRfqYLux
 oT3w==
X-Gm-Message-State: AOAM5318Czfum7Soctjw/mWSK8G2uq5lUI+HLbY7ZOv8wZRcjXBHgKaT
 b3VKyIqAHUNY5muPZXIcnbRmYftX7RiojqmzOaDvQzZP6D4=
X-Google-Smtp-Source: ABdhPJyvka1BRZHv9LZ8H6unj8uf/AkA4eA5dz9fvr7CpWLDwZi3OPSy5yeSL3GZcQPwQskDS9GZKlhp+greHHS8eo0=
X-Received: by 2002:aca:568c:: with SMTP id k134mr20136521oib.48.1593029970680; 
 Wed, 24 Jun 2020 13:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200623113904.28805-1-peter.maydell@linaro.org>
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jun 2020 21:19:19 +0100
Message-ID: <CAFEAcA-xNKiZogBBnA8nMJTe2Nh3mPV1r00=ZiuHJFD_oABv9g@mail.gmail.com>
Subject: Re: [PULL 00/42] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Tue, 23 Jun 2020 at 12:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 61fee7f45955cd0bf9b79be9fa9c7ebabb5e6a85:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing-20200622' into staging (2020-06-22 20:50:10 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200623
>
> for you to fetch changes up to 539533b85fbd269f777bed931de8ccae1dd837e9:
>
>   arm/virt: Add memory hot remove support (2020-06-23 11:39:48 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * util/oslib-posix : qemu_init_exec_dir implementation for Mac
>  * target/arm: Last parts of neon decodetree conversion
>  * hw/arm/virt: Add 5.0 HW compat props
>  * hw/watchdog/cmsdk-apb-watchdog: Add trace event for lock status
>  * mps2: Add CMSDK APB watchdog, FPGAIO block, S2I devices and I2C devices
>  * mps2: Add some unimplemented-device stubs for audio and GPIO
>  * mps2-tz: Use the ARM SBCon two-wire serial bus interface
>  * target/arm: Check supported KVM features globally (not per vCPU)
>  * tests/qtest/arm-cpu-features: Add feature setting tests
>  * arm/virt: Add memory hot remove support


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

