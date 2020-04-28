Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AD7C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A117A2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/2Yt90l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTL5C-0005Xv-Qg
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:55:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTL1V-0001QD-L8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKzu-00008Q-Fu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:51:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKKL-0004Xb-HM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:06:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id d15so21681673wrx.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X388wrm3JW6uJ8dysZxxz4pfx+azpLrcjf4AmQ77Enw=;
 b=g/2Yt90lHAHQC5IVT5fUrSW8Xh1gAq0Htn3mc/g6VhHT91xTeSA2b/2HSZ6pkhvfLk
 sl84qh4uq9j36jXLYjCFKYljElSh/MfzSbVPls3bM9kawTtEAwDMP4MkMfHi8tYfHo1y
 n4j7Pbzd7PtHwgHs9ygUxF5fLGHOvv7LWYFSksdLcI9MDVT2WH73oaS8HQzryvzvL+t+
 4HbVzvkR29yyYBDOIaP0g0A+kWcTjuljTQa6flHFZv//uAu/8gc0z66YXwRMPwK+qIlN
 dfhPO5K+cGSBituzwm4/AGFAdGDPzXjIiZ1exh6MYX1xWmBmhGWvHG2lhIWmOam4Lnga
 ufSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=X388wrm3JW6uJ8dysZxxz4pfx+azpLrcjf4AmQ77Enw=;
 b=XI2inb5TFtOpITRTSB4rQd4QT4Mo1Z/oD25BJ6/1Yu2dEgQnmObQrJPqCY8bRrTMJw
 vGIXrjmU8li4QbzAB0Wylv83r10299RYCb1Kq2SIgca4bCXufz9++tyJPt/huc63rcqx
 1orG5GexVN0OytitmOmw1Q1/7ezKyVoRFDF260Asw8uVo81o8C1K9NDhmqfv2fm5p26r
 vvLskFNZqQQ2kuUOKpZlmvLBz/6yyOJjg1V9+E6qwFWlJdznl0KYSi+STHQTHAygVbRY
 dF6/sOZ62hRifGC2vd6QAuiXPvEE9mSMKDGYXJiDOF71JkxVr07hO8PMJoIcPIn8j9KM
 tYdw==
X-Gm-Message-State: AGi0PuZGfB4jfd6QCg3IqpdO+O3NdZymILA9elEIf/ViFrm8u979HF32
 0rQv+oIcHNgj1mwNy3qxypw7WwMER/w=
X-Google-Smtp-Source: APiQypKyGhsppdcChpY3flmUTXLn9fBo1MpGeuUrAvFdEFVujo5q74NpIjemA4gz/N0kBGwAN+SR0Q==
X-Received: by 2002:adf:a309:: with SMTP id c9mr29629470wrb.97.1588057602876; 
 Tue, 28 Apr 2020 00:06:42 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id b66sm2099904wmh.12.2020.04.28.00.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:06:42 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] raspi: add BCM2835 SOC MPHI emulation
To: Paul Zimmerman <pauldzim@gmail.com>
References: <20200428022232.18875-1-pauldzim@gmail.com>
 <20200428022232.18875-2-pauldzim@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <b7d780c2-d79b-dc72-b277-60aab1cb9c7a@amsat.org>
Date: Tue, 28 Apr 2020 09:06:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428022232.18875-2-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paul,

On 4/28/20 4:22 AM, Paul Zimmerman wrote:
> Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)
> emulation. It is very basic, only providing the FIQ interrupt
> needed to allow the dwc-otg USB host controller driver in the
> Raspbian kernel to function.
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>  hw/arm/bcm2835_peripherals.c         |  17 +++
>  hw/misc/Makefile.objs                |   1 +
>  hw/misc/bcm2835_mphi.c               | 190 +++++++++++++++++++++++++++
>  include/hw/arm/bcm2835_peripherals.h |   2 +
>  include/hw/misc/bcm2835_mphi.h       |  48 +++++++
>  5 files changed, 258 insertions(+)
>  create mode 100644 hw/misc/bcm2835_mphi.c
>  create mode 100644 include/hw/misc/bcm2835_mphi.h
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index edcaa4916d..5e2c832d95 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -124,6 +124,10 @@ static void bcm2835_peripherals_init(Object *obj)
>      sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
>                            TYPE_BCM2835_GPIO);
>  
> +    /* Mphi */
> +    sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
> +                          TYPE_BCM2835_MPHI);
> +
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
>                                     OBJECT(&s->sdhci.sdbus), &error_abort);
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
> @@ -368,6 +372,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    /* Mphi */
> +    object_property_set_bool(OBJECT(&s->mphi), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->peri_mr, MPHI_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mphi), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mphi), 0,
> +        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
> +                               INTERRUPT_HOSTPORT));
> +
>      create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
>      create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
>      create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 68aae2eabb..91085cc21b 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -57,6 +57,7 @@ common-obj-$(CONFIG_OMAP) += omap_l4.o
>  common-obj-$(CONFIG_OMAP) += omap_sdrc.o
>  common-obj-$(CONFIG_OMAP) += omap_tap.o
>  common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
> +common-obj-$(CONFIG_RASPI) += bcm2835_mphi.o
>  common-obj-$(CONFIG_RASPI) += bcm2835_property.o
>  common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
>  common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
> diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
> new file mode 100644
> index 0000000000..66fc4a9cd3
> --- /dev/null
> +++ b/hw/misc/bcm2835_mphi.c
> @@ -0,0 +1,190 @@
> +/*
> + * BCM2835 SOC MPHI emulation
> + *
> + * Very basic emulation, only providing the FIQ interrupt needed to
> + * allow the dwc-otg USB host controller driver in the Raspbian kernel
> + * to function.
> + *
> + * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/misc/bcm2835_mphi.h"
> +#include "migration/vmstate.h"
> +#include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
> +
> +static inline void mphi_raise_irq(BCM2835MphiState *s)
> +{
> +    qemu_set_irq(s->irq, 1);
> +}
> +
> +static inline void mphi_lower_irq(BCM2835MphiState *s)
> +{
> +    qemu_set_irq(s->irq, 0);
> +}
> +
> +static uint64_t mphi_reg_read(void *ptr, hwaddr addr, unsigned size)
> +{
> +    BCM2835MphiState *s = ptr;
> +    uint32_t reg = s->regbase + addr;
> +    uint32_t val = 0;
> +
> +    switch (reg) {
> +    case 0x28:  /* outdda */
> +        val = s->outdda;
> +        break;
> +    case 0x2c:  /* outddb */
> +        val = s->outddb;
> +        break;
> +    case 0x4c:  /* ctrl */
> +        val = s->ctrl;
> +        val |= 1 << 17;
> +        break;
> +    case 0x50:  /* intstat */
> +        val = s->intstat;
> +        break;
> +    case 0x1f0: /* swirq_set */
> +        val = s->swirq_set;
> +        break;
> +    case 0x1f4: /* swirq_clr */
> +        val = s->swirq_clr;
> +        break;

I'm surprised this register is read.

> +    default:
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void mphi_reg_write(void *ptr, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    BCM2835MphiState *s = ptr;
> +    uint32_t reg = s->regbase + addr;
> +    int do_irq = 0;
> +
> +    val &= 0xffffffff;

Using '.impl.max_access_size = 4' (see below) this line is not necessary.

> +
> +    switch (reg) {
> +    case 0x28:  /* outdda */
> +        s->outdda = val;
> +        break;
> +    case 0x2c:  /* outddb */
> +        s->outddb = val;
> +        if (val & (1 << 29)) {
> +            do_irq = 1;
> +        }

Any idea what outdda/b means?

> +        break;
> +    case 0x4c:  /* ctrl */
> +        s->ctrl = val;
> +        if (val & (1 << 16)) {

Any idea what are bits 16/17 for?

> +            do_irq = -1;
> +        }

I suppose this register is INT_ENA (inverted?)

> +        break;
> +    case 0x50:  /* intstat */
> +        s->intstat = val;
> +        if (val & ((1 << 16) | (1 << 29))) {
> +            do_irq = -1;

I suppose writting INT_STAT acknowledges interrupts.

> +        }
> +        break;

Here ...

> +    case 0x1f0: /* swirq_set */
> +        s->swirq_set = val;
> +        do_irq = 1;
> +        break;
> +    case 0x1f4: /* swirq_clr */
> +        s->swirq_clr = val;
> +        do_irq = -1;
> +        break;

... we access the same register, 's->swirq'.

0x1f0 sets the bits:

  s->swirq = val;

0x1f4 clears the bits:

  s->swirq &= ~val;

Then you could simplify with qemu_set_irq(s->irq, ... && s->swirq);

> +    default:

Please log unimplemented accesses:

       qemu_log_mask(LOG_UNIMP, ...);

> +        break;

           return?

> +    }
> +
> +    if (do_irq > 0) {
> +        mphi_raise_irq(s);
> +    } else if (do_irq < 0) {
> +        mphi_lower_irq(s);
> +    }
> +}
> +
> +static const MemoryRegionOps mphi_mmio_ops = {
> +    .read = mphi_reg_read,
> +    .write = mphi_reg_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,

I don't know what are the valid bus access sizes, but per your
implementation you want:

       .impl.min_access_size = 4,
       .impl.max_access_size = 4,

> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void mphi_reset(DeviceState *dev)
> +{
> +}
> +
> +static void mphi_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    BCM2835MphiState *s = BCM2835_MPHI(dev);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void mphi_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    BCM2835MphiState *s = BCM2835_MPHI(obj);
> +
> +    s->regbase = 0;
> +    memory_region_init(&s->mem, obj, "mphi", MPHI_MMIO_SIZE);
> +    memory_region_init_io(&s->mem_reg, obj, &mphi_mmio_ops, s, "global", 0x200);
> +    memory_region_add_subregion(&s->mem, s->regbase, &s->mem_reg);

I'm not sure why you use a container. You can simplify using a single:

       memory_region_init_io(&s->iomem, obj, &mphi_mmio_ops, s, "mphi",
MPHI_MMIO_SIZE);

> +    sysbus_init_mmio(sbd, &s->mem);
> +}
> +
> +const VMStateDescription vmstate_mphi_state = {
> +    .name = "mphi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16(regbase, BCM2835MphiState),
> +        VMSTATE_UINT32(outdda, BCM2835MphiState),
> +        VMSTATE_UINT32(outddb, BCM2835MphiState),
> +        VMSTATE_UINT32(ctrl, BCM2835MphiState),
> +        VMSTATE_UINT32(intstat, BCM2835MphiState),
> +        VMSTATE_UINT32(swirq_set, BCM2835MphiState),
> +        VMSTATE_UINT32(swirq_clr, BCM2835MphiState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void mphi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = mphi_realize;
> +    dc->reset = mphi_reset;
> +    dc->vmsd = &vmstate_mphi_state;
> +}
> +
> +static const TypeInfo bcm2835_mphi_type_info = {
> +    .name          = TYPE_BCM2835_MPHI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BCM2835MphiState),
> +    .instance_init = mphi_init,
> +    .class_init    = mphi_class_init,
> +};
> +
> +static void bcm2835_mphi_register_types(void)
> +{
> +    type_register_static(&bcm2835_mphi_type_info);
> +}
> +
> +type_init(bcm2835_mphi_register_types)
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index 2e8655a7c2..7a7a8f6141 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -21,6 +21,7 @@
>  #include "hw/misc/bcm2835_property.h"
>  #include "hw/misc/bcm2835_rng.h"
>  #include "hw/misc/bcm2835_mbox.h"
> +#include "hw/misc/bcm2835_mphi.h"
>  #include "hw/misc/bcm2835_thermal.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/sd/bcm2835_sdhost.h"
> @@ -42,6 +43,7 @@ typedef struct BCM2835PeripheralState {
>      qemu_irq irq, fiq;
>  
>      BCM2835SystemTimerState systmr;
> +    BCM2835MphiState mphi;
>      UnimplementedDeviceState armtmr;
>      UnimplementedDeviceState cprman;
>      UnimplementedDeviceState a2w;
> diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
> new file mode 100644
> index 0000000000..6d070b04a5
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_mphi.h
> @@ -0,0 +1,48 @@
> +/*
> + * BCM2835 SOC MPHI state definitions
> + *
> + * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef HW_MISC_BCM2835_MPHI_H
> +#define HW_MISC_BCM2835_MPHI_H
> +
> +#include "hw/irq.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/dma.h"

sysemu/dma.h not used.

> +
> +#define MPHI_MMIO_SIZE      0x1000
> +
> +typedef struct BCM2835MphiState BCM2835MphiState;
> +
> +struct BCM2835MphiState {
> +    SysBusDevice parent_obj;
> +    qemu_irq irq;
> +    MemoryRegion mem;
> +    MemoryRegion mem_reg;
> +    uint16_t regbase;

You can remove regbase.

> +
> +    uint32_t outdda;
> +    uint32_t outddb;
> +    uint32_t ctrl;
> +    uint32_t intstat;
> +    uint32_t swirq_set;
> +    uint32_t swirq_clr;

As suggested previously, you can use a single 'swirq' register.

> +};
> +
> +#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
> +
> +#define BCM2835_MPHI(obj) \
> +    OBJECT_CHECK(BCM2835MphiState, (obj), TYPE_BCM2835_MPHI)
> +
> +#endif
> 

I made a lot of picky comments, mostly to simplify, but this patch is in
good shape otherwise (being aware we have no documentation on this
device). Maybe Peter/Gerd are OK to accept it as it (as it is your first
contribution).

Regards,

Phil.

