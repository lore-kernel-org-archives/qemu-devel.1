Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE43C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4122084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EICslbd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4122084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctqq-0008FO-4o
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hctlD-0004A8-U3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hctlC-0008Fg-Js
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:31 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hctlC-00087s-Bs
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:30 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 107so9707844otj.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=kJ4AJOsWXogDPyWOdZdu1NfTEK8bEB5HqXL7reTMCfE=;
 b=EICslbd8uqXZH4AelwwrrcvJyOzRHCDydELqiFsqSCiIfsr+HDDFwzrEbErRwxg478
 aUwShNbT8uqZKxTwX2eTbw82D6vNqKM4gyea5KuebJNr5V/q6a1mQTJEZVfqA86T5z/R
 Czd1N/E9QINyyq3KLNeAVkxA+kyC83/N4SkOw2S/w8y916bXesxei5CN1tXX6iKmUof8
 5pqfPAaO63Hs38036K3xiy9FtX8VDdvdL0sm1tz/zYrhzlbov+JsfyvZ/I9F3BMHASnD
 21va7qK9vTiB6htgnm1tjrkeCLAfCvnrTvjY+FuAfk3SvxXxrVVvJQc6ikW1LG7TDqgg
 AeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=kJ4AJOsWXogDPyWOdZdu1NfTEK8bEB5HqXL7reTMCfE=;
 b=HXwVR5fzuQfWx6n8v9TpMA6EvhekJs52i339a8AK5ZKrwN/pOflsLp+O5AqIQrAKDy
 jICzINimnQLxa9JxyQEQ0pocaYqAROq+sPp4BDAdZIfCVr/RNsocumdT/GnPmew+PZAH
 gf64b3mAhGsCx4cwka5tgud43zOSCoYQ170DY6SxvDCloL8EXJXpKLuSaIwCLpUv7Ern
 rtZbtcYgJejxhuHSD0/9+7n7dFVmCK9TGmoMQ4aZAMlVlCVJjcISFTLAPxYzMNuClkNG
 50ujmQ0+O32fhat8lG7+ONsMlL5Qb0A/EqalmB0bXd0Km+E1XHkml4WJe8URyJJvKSJ2
 VYNg==
X-Gm-Message-State: APjAAAV2mrOBzT2FIBq/mP2McOuf1Cl6i2IuRnHIbA7g1XjjCTYYi8cB
 1nzPZOl3B711BgQYcRiGflpTphYvDQnfA5MiJQU3Y3hPWJc=
X-Google-Smtp-Source: APXvYqx6vP5OcOU8321d+WvUjGfY9TbwaWrtQsaeeZYgKDkOO3MrNB4OjuOzdDBDrFM0aYiX2VSmB24c3/1KwOW9JEI=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20869061otk.232.1560786079767; 
 Mon, 17 Jun 2019 08:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190617143412.5734-1-peter.maydell@linaro.org>
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2019 16:41:08 +0100
Message-ID: <CAFEAcA_tsABB1HGA20xmMA_XBdyxaHcSYV3D1-yaRdCAzUw4-w@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 00/24] target-arm queue
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

On Mon, 17 Jun 2019 at 15:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Latest arm queue, half minor code cleanups and half minor
> bug fixes.
>
> -- PMM
>
> The following changes since commit 5d0e5694470d2952b4f257bc985cac8c89b4fd92:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-06-17 11:55:14 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190617
>
> for you to fetch changes up to 1120827fa182f0e76226df7ffe7a86598d1df54f:
>
>   target/arm: Only implement doubles if the FPU supports them (2019-06-17 15:15:06 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * support large kernel images in bootloader (by avoiding
>    putting the initrd over the top of them)
>  * correctly disable FPU/DSP in the CPU for the mps2-an521, musca-a boards
>  * arm_gicv3: Fix decoding of ID register range
>  * arm_gicv3: GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
>  * some code cleanups following on from the VFP decodetree conversion
>  * Only implement doubles if the FPU supports them
>    (so we now correctly model Cortex-M4, -M33 as single precision only)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

