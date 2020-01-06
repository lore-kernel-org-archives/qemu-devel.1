Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DA120715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6sWHYGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DA120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWbI-0004aY-5P
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioWaK-0003ZH-JM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioWaJ-0005DL-D2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:54:36 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioWaH-0005Bw-HG
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:54:33 -0500
Received: by mail-oi1-x241.google.com with SMTP id k4so16500196oik.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GC99n407uU3G9+rw6NzIvANr8v7Ucn42d7NObB6fogM=;
 b=R6sWHYGT8ur7yFW5JQpBBQGmuxalPhrdopnZwJneIwAOokbMdB+I57DA1WyTw5ehKj
 KNG3xeTTRAtr5+56jNB7+Y3GUlP4haxORuXlUkB07SKtl/Pu1IR7aWvb9jA/6/0rC6Jx
 NjxDW9Bvqy9o9X8uMhn35xYNH7lZ147bu0CH1k/EV6F/4Qt82KXzf/tX/iFTUdiVGStN
 txX8wz4NDZ6YbnVLuLPCbge8jLxai6SqV2JN9n64892tq673iShQIE2NHrtDEA4o6XZ7
 8ekaU0/S8K6kiGKy/Av2Ps5WEdct+oBryb+8hMxOgKaFOpbn56Q0GTpMrsrMm4m085MA
 dvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GC99n407uU3G9+rw6NzIvANr8v7Ucn42d7NObB6fogM=;
 b=UKqggYV+s1RDnNVe+X6/S0+6XFhcRHwpJcoE71+G7fyF4gHeyuE88Yxr6B73U37IgN
 WbUu8bMmMYVDRo/1njo93WKm9viSWBsgbUnfj7cJoy8peMAZmw3YV2Z1XOgRewEcjVS8
 bZQLCvBp2oYaeiNBBaNb7dZ13dmciu39FxapA9Fxgwd8y89tS9EujYwhcq+YcHoVFAMe
 AJaOV47X3a9S7p4q5ucq0mTaohHfiU/nanoNIgFczSRxNGg9DN/YmU+/1oxmKW2T5/xw
 LqQdJSdpqOJjouqN4ItsXTdsDqZmhMxj3JWHWWjNosW/NCMoLH9AizWbmvj2Ru/2L6M0
 sRLw==
X-Gm-Message-State: APjAAAUqcEUoT+MNAul8aMLOm5D+Fb2atodk+3eRgoOfbIjblEwqPF/3
 GWPBuglReCkyNNF0R4wju2zZduYzFrQbU9USbwj0ew==
X-Google-Smtp-Source: APXvYqwFtD03ZCZpJD3LELEaRrYDYcDcf9YJN90+u9XmH1T68rXccWinbNfVbCHNztjrAHXNPMhuW41ahEZuz5I04t0=
X-Received: by 2002:aca:570d:: with SMTP id l13mr5776120oib.146.1578333272437; 
 Mon, 06 Jan 2020 09:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20191226175132.28116-1-martin@kaiser.cx>
In-Reply-To: <20191226175132.28116-1-martin@kaiser.cx>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 17:54:21 +0000
Message-ID: <CAFEAcA-JTxqGid8EW=Vu=xePrEVgxD9pZRNAg0BehFVhYKfebw@mail.gmail.com>
Subject: Re: [PATCH] i.MX: add an emulation for RNGC
To: Martin Kaiser <martin@kaiser.cx>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Dec 2019 at 17:52, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Add an emulation for the RNGC random number generator and the compatible
> RNGB variant. These peripherals are included (at least) in imx25 and
> imx35 chipsets.
>
> The emulation supports the initial self test, reseeding the prng and
> reading random numbers.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Thanks for this patch; it looks good to me -- the only
major missing item is a VMStateDescription, which should
be easy to add. (I haven't checked the actual device
functionality against a datasheet, but it all looks plausible.)
There were also a couple of minor nits which I've listed inline below.

> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ba898a5781..2b28f8c096 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -42,6 +42,7 @@ common-obj-$(CONFIG_IMX) += imx7_ccm.o
>  common-obj-$(CONFIG_IMX) += imx2_wdt.o
>  common-obj-$(CONFIG_IMX) += imx7_snvs.o
>  common-obj-$(CONFIG_IMX) += imx7_gpr.o
> +common-obj-$(CONFIG_IMX) += imx_rngc.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
>  common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
> diff --git a/hw/misc/imx_rngc.c b/hw/misc/imx_rngc.c
> new file mode 100644
> index 0000000000..f935ec46a6
> --- /dev/null
> +++ b/hw/misc/imx_rngc.c
> @@ -0,0 +1,262 @@
> +/*
> + * Freescale i.MX RNGC emulation
> + *
> + * Copyright (C) 2019 Martin Kaiser <martin@kaiser.cx>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * This driver provides the minimum functionality to initialize and seed
> + * an rngc and to read random numbers. The rngb that is found in imx25
> + * chipsets is also supported.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"

Do you really need main-loop.h ?

> +#include "qemu/module.h"
> +#include "qemu/log.h"
> +#include "qemu/guest-random.h"
> +#include "hw/irq.h"
> +#include "hw/misc/imx_rngc.h"

> +static void __imx_rngc_reset(IMXRNGCState *s)

Don't use __ prefixes for function names, please.

> +{
> +    s->op_self_test = OP_IDLE;
> +    s->op_seed = OP_IDLE;
> +    s->mask = 0;
> +    s->auto_seed = false;
> +}
> +
> +static void imx_rngc_write(void *opaque, hwaddr offset, uint64_t value,
> +                           unsigned size)
> +{
> +    IMXRNGCState *s = IMX_RNGC(opaque);
> +
> +    switch (offset) {
> +    case RNGC_COMMAND:
> +        if (value & RNGC_CMD_BIT_SW_RST) {
> +            __imx_rngc_reset(s);
> +        }
> +
> +        /*
> +         * For now, both CLR_ERR and CLR_INT clear the interrupt. We
> +         * don't report any erors yet.

"errors"

> +         */
> +        if (value & (RNGC_CMD_BIT_CLR_ERR | RNGC_CMD_BIT_CLR_INT)) {
> +            qemu_irq_lower(s->irq);
> +        }

> +static void imx_rngc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = imx_rngc_realize;
> +    dc->reset = imx_rngc_reset;
> +    dc->desc = "i.MX RNGC";

You need also to set dc->vmsd to a VMStateDescription
which describes the variable state of the device that
needs to be migrated.

> +}
> +
> +static const TypeInfo imx_rngc_info = {
> +    .name          = TYPE_IMX_RNGC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(IMXRNGCState),
> +    .class_init    = imx_rngc_class_init,
> +};
> +
> +static void imx_rngc_register_types(void)
> +{
> +    type_register_static(&imx_rngc_info);
> +}

thanks
-- PMM

