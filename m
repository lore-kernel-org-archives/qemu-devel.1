Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AAEC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78E22070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChGYvfnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78E22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYcG-0003bz-Nk
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:52:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYbV-0003Al-Ht
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYbS-0001MO-LK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:51:56 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYbQ-0001Iw-Ix
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:51:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id t184so4384651oie.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sQt+fj6KHnpK2BGyUUR37djHra0zd+acXHDKdlWYLPo=;
	b=ChGYvfnMo/0+eJKLcH62vYxcZNmSFWChPgWM4x893HYqvEH/wTBzQpcyBlFTn/Nc4F
	ReKQk+4IFoRfbZD7n3JmCI+j37o72+p/pQSk0Xo734HDw9YcIjsQPhI6aL5Wh12Gt6+0
	sNqtHBQg6O4XBsy5HIX9lhJipy/XegjKZPG4o7aLRTnXQwtJrs0iV/k+HrqIc/ER9h6G
	FUfkWeSV6YnSNgykSN8AY1F8BKsF4FukXyXw5VWSJyTf2ZFWRMI9+an9B2jZ24vIE6+4
	hfq6y8qfHm/rJewU3XBBcApAjLj/BamCHZKfyVhOgs75H2vRuwSQSS2VdwA1tyJZplEb
	t/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sQt+fj6KHnpK2BGyUUR37djHra0zd+acXHDKdlWYLPo=;
	b=AQtWrpk1S8gWkDL0U19cWdy48Vh7IfrU0k3ZXtJipRjHtcZXnqF+ieegv3MIxvKrFY
	FKS12Ge98hYz98pmBF5awvb1B2zQPAHIVBDqgZttJt52I5GNj6M6CEWH6ctxy77mijUg
	PKPHHIOY7H3+2GaFgp0OisQatth1jryoWYa8ti482TOKpeWKk3tEulOGiSwVoFEs6VkZ
	H1ay/74DTdDyeOowDkyM80SGZCXQSGQ+eYefefz6+T0BfeQrYHuOn1IIsrn+7v4MPRl5
	CXYy70PT5cup9xl6BhcN9ZhW4wG+Aj+O8N/S0TAVN8ZeI5wTYwdbr2XRFN9EmxZakoe0
	ZM8A==
X-Gm-Message-State: APjAAAUC7Y1xnPNp/kmvjynI75GqTk4FSIP32kChCK/sVsxgTH6mh78Y
	w8t4b5QN56SUFGz21mHnqxePZR8DiYShj/JerR2QqQ==
X-Google-Smtp-Source: APXvYqyVHH83wUR3hGS6MI3A8zYvnsLZSpL3uWu145J/d835pC48LKfiuIn1xPQFC+DZXt3r3NN+G3qSHq/rnFV/hX4=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr6286410oif.98.1556891510247; 
	Fri, 03 May 2019 06:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556774049.git.alistair@alistair23.me>
	<PSXP216MB0277F0C5EFED03D58540BD70DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0277F0C5EFED03D58540BD70DD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:51:39 +0100
Message-ID:
 <CAFEAcA9gxWQ4Lr8-DS7ExdZuDF8xHSCY7AmkHKEs1uCTVmA+Ow@mail.gmail.com>
To: Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 4/5] hw/arm: Add the STM32F4xx SoC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503135139.NdWdovGgapQSi0i9ngUFlDZF1MvRSeaTK3sXfq_w5Eg@z>

On Thu, 2 May 2019 at 06:41, Alistair Francis <alistair@alistair23.me> wrote:
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  MAINTAINERS                     |   8 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Kconfig                  |   3 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/stm32f405_soc.c          | 306 ++++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f405_soc.h  |  74 ++++++++
>  6 files changed, 393 insertions(+)
>  create mode 100644 hw/arm/stm32f405_soc.c
>  create mode 100644 include/hw/arm/stm32f405_soc.h
>

> +static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    STM32F405State *s = STM32F405_SOC(dev_soc);
> +    DeviceState *dev, *armv7m;
> +    SysBusDevice *busdev;
> +    Error *err = NULL;
> +    int i;
> +
> +    s->system_memory = get_system_memory();
> +    s->sram = g_new(MemoryRegion, 1);
> +    s->flash = g_new(MemoryRegion, 1);
> +    s->flash_alias = g_new(MemoryRegion, 1);

What I meant by my comment on v1 was that rather than doing
g_new() here you can just have the STM32F405State struct
have
 MemoryRegion sram;
 MemoryRegion flash;
etc

and then instead of
  memory_region_init_ram(s->flash, ...)
you use
  memory_region_init_ram(&s->flash, ...)
etc

which avoids doing separate memory allocations (which would
need to be freed if you then do an error-exit from the
realize function, I think).

And you don't need to have an s->system_memory -- that
can just be a local variable, because it's just caching
the pointer to the global system memory MemoryRegion.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

