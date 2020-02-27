Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F6C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC01124697
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1U1EiHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC01124697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I3n-0006K8-4L
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7I2y-0005o4-5m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7I2x-0005aM-5T
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:13:44 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7I2w-0005Za-Vc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:13:43 -0500
Received: by mail-oi1-x244.google.com with SMTP id r16so1400111oie.6
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LabFdtw+4yWQwHjyMs+KlbDhcQlBiBmnVkMXIHpPAYI=;
 b=i1U1EiHVg3JosQKfVcQ6zT+v6aGYQCi4ePXTXGqowcYbah7tjaeK73eTWIJKsslRSW
 1prUo4herF8drM3tgOEswU7/rG4kJOFbGL8cDvzsX0YTIy4a1WdJOP9OTJnrX6LpYDrU
 SC8pTs9JYs//SMKd08L+GD5lrqbRiiT9GyrwESM9UhNA+za/PXAEGDtJcWd5TnilvUBC
 tQ8rO5aijpSvLhwau+CUAH1mMj3HxuEiYGgh3a5+h6Z05qQltTSAKe/FYiyzmzpv+Lii
 WBPhMTT7U+8k2F6ffKDEJdZV7u97+rmA7rY51rjx/zzdc4Z7BzyFBiUzqdDFBjPzbuVc
 U/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LabFdtw+4yWQwHjyMs+KlbDhcQlBiBmnVkMXIHpPAYI=;
 b=W/lqm5qjQWut8lIMqQn9n4ENUV5nDyWwSQaK/PgRRFUSO6MNOfkCaqdRSIFfYshW35
 lAcT08e4tPV5Ank+Pd5VOoItbGTQUkss4SBeLWXiUFWJ3bbAUhBbZwjow58LWJU6olin
 L5sDlY1uockAw5shKJ7Ew4Lprqb4SoTpi+2vGiK1iHukNMjMm6Q5Eg96+vY2bu8VUhrf
 FlibDkRSqAyhbIOQshrYqYGCZUIypKvisLe1OnaymgRJm6j6kTChp+YhdX35t1b/KRst
 u5hbpqv1ZhPiy3j0xFxYPcDE4sHhb0rLmAnOJjypmzdG6RiimHrmVuhIt8b4iI89gTdh
 XjYg==
X-Gm-Message-State: APjAAAUjjxqlYxFegGBfDpYyCKpSPKTxOQNaO9b2iV7SPZlHVz35c3Zt
 DzeiE2qR0i+sTp7qm1cWnKBCvmrRS4YzWfjEZMjTVA==
X-Google-Smtp-Source: APXvYqyRYrGQ9YCxXcT/ah56tRupUJs0onUPklxD07Rjpi10H3j3IN+r99x+WIFNm5RBUmShdflpLZqWOoPYsNwjISM=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3153650oiy.170.1582805622130; 
 Thu, 27 Feb 2020 04:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20200227112617.66044-1-root@stephanos.io>
 <20200227112617.66044-2-root@stephanos.io>
In-Reply-To: <20200227112617.66044-2-root@stephanos.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 12:13:31 +0000
Message-ID: <CAFEAcA9qbndHqoW1oaUAKMZY5hNYjP+mMt-K_WqoT9Z=Q=ct7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
To: Stephanos Ioannidis <root@stephanos.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 11:27, Stephanos Ioannidis <root@stephanos.io> wrote:
>
> The ARMv7-M CPU reset handler, which loads the initial SP and PC
> register values from the vector table, is currently executed before
> the ROM reset handler (rom_reset), and this causes the devices that
> alias low memory region (e.g. STM32F405 that aliases the flash memory
> located at 0x8000000 to 0x0) to load an invalid reset vector of 0 when
> the kernel image is linked to be loaded at the high memory address.
>
> For instance, it is norm for the STM32F405 firmware ELF image to have
> the text and rodata sections linked at 0x8000000, as this facilitates
> proper image loading by the firmware burning utility, and the processor
> can execute in place from the high flash memory address region as well.
>
> In order to resolve this issue, this commit downgrades the ARMCPU reset
> handler invocation priority level to -1 such that it is always executed
> after the ROM reset handler, which has a priority level of 0.


I think we should be able to do this with the new 3-phase
reset API : the rom loader reset should happen in phase 2,
and the Arm CPU should only load the new PC and SP in
phase 3. It's on my todo list to write some code for this
to see if this theory works out.

I'd prefer it if we do it that way, or alternatively find
out for certain that that approach does not work, before
we add a reset-priority concept to the reset APIs.

(In particular, this use of qemu_register_reset to arrange for
the CPU to be reset should ideally go away in favour of having
the CPU reset handled by the SoC which owns the CPU, so it's
not a good long-term way to look at trying to fix ordering issues.)

thanks
-- PMM

