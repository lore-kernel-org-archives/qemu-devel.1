Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F027C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DF32076B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aj4r2lOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DF32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQT4Z-0002l9-KM
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQT3O-0001sY-1b
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:21:42 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQT3L-0003ya-C9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:21:41 -0400
Received: by mail-pl1-x643.google.com with SMTP id t18so2548841plo.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZSI31LrL2TgeNJlHPj3vYpZ6mJXqDCMv4smBok197eU=;
 b=aj4r2lOKfqNP/883LOQ6zONfOaPSg/8uPPCR/4eLBeiZfIYzc0QkiLQELthv4a9+PX
 zVEYhobdfL94zjer1IdvAUv+ENxUl0OmCSBubNrOgA9w21XDCPTGgzk9a2WI5nTDNpzc
 WPZY4KDXMSNjRrLfZAoTMaG+g5nUXTsIqIZMdPE2RCATdAdIlaLil1JslR8NC6+qycJA
 +Bb1oWHJlmaObxx405lQXyNe5RhA5Qvd0Wye4nsqwLBpo96V+/raRaW7HcRpYJ1NVLWU
 BQtMweTS2XHTJxg4MCOvw/PD6yo2ShJ0SzqF3tzsAHbWn/fCyT/nd8hhbljyDQh4aK1w
 WtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZSI31LrL2TgeNJlHPj3vYpZ6mJXqDCMv4smBok197eU=;
 b=hGHZkkghEIJHBsQVFgk5KlQgcrVjej7eFtBt8kuyLmTYdGxiLNgZi0k+pXhIjR/t3V
 usxZzn8E9TW0RqtoeTG6/p257O/sUVM34l/WnX/0VrU04hEKl70oP2tDXxv9gGpMrL0R
 ZCjmrJHnQyNRkbOj13aHw3RF8Rgib0vxg3+orO7NDEuCJEt7Y59RnjHZzGVx7qplh435
 BSoukaqdKSAHs4nQ3jrUrGWI6YlXD2RV6QDbQalA6NWqTgbYIxb7AddzcEs1wl3A0u41
 TZEUOTI3cm9AH9gQTR48RJVh9J5L8LIS/0sUHghdOHoM9EHqIJ16f/9KRAkFKo+BXEec
 Xqzg==
X-Gm-Message-State: AOAM532LTyE9ieZe+wdU8nLT9OKCEF3NAPOjOWbhR975Q4q0ME/oflXr
 iGdvkqzQy5O+KII50DaW8JRkuHGp0hHfV4wtKQjsng==
X-Google-Smtp-Source: ABdhPJw5fe0fUSHc2A4P9UzXO6PJPJC3a5+D8HpVDrZ7bZUjPNE/xI60LmfboOGyeUtOMjdvLUK40UL484Z8e5DXdI8=
X-Received: by 2002:a17:902:a60e:b029:d3:da14:3992 with SMTP id
 u14-20020a170902a60eb02900d3da143992mr6744995plq.37.1602152497631; Thu, 08
 Oct 2020 03:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201008024203.112303-1-shashi.mallela@linaro.org>
 <20201008024203.112303-2-shashi.mallela@linaro.org>
In-Reply-To: <20201008024203.112303-2-shashi.mallela@linaro.org>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 8 Oct 2020 13:21:26 +0300
Message-ID: <CAD8XO3ZRGqNbr1GM6jMAdhm=pPXXr6K7m_F0MKRDQMnrDw=yDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/watchdog: Implement SBSA watchdog device
To: Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, leif@nuviainc.com,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 05:43, Shashi Mallela <shashi.mallela@linaro.org> wrote:
>
> Generic watchdog device model has been implemented as per ARM BSAv0.9
>
> Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
> ---
>  hw/arm/Kconfig                      |   1 +
>  hw/watchdog/Kconfig                 |   4 +
>  hw/watchdog/meson.build             |   1 +
>  hw/watchdog/wdt_sbsa_gwdt.c         | 345 ++++++++++++++++++++++++++++
>  include/hw/watchdog/wdt_sbsa_gwdt.h |  70 ++++++
>  5 files changed, 421 insertions(+)
>  create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
>  create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f303c6bead25..6b97e64595d3 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -210,6 +210,7 @@ config SBSA_REF
>      select PL031 # RTC
>      select PL061 # GPIO
>      select USB_EHCI_SYSBUS
> +    select WDT_SBSA_GWDT
>
>  config SABRELITE
>      bool
> diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
> index 293209b291d6..ea9cadd66f22 100644
> --- a/hw/watchdog/Kconfig
> +++ b/hw/watchdog/Kconfig
> @@ -17,3 +17,7 @@ config WDT_DIAG288
>
>  config WDT_IMX2
>      bool
> +
> +config WDT_SBSA_GWDT
> +    bool
> +    default y if SBSA_REF
> diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
> index 9b8725e64288..a9a23307acfe 100644
> --- a/hw/watchdog/meson.build
> +++ b/hw/watchdog/meson.build
> @@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
>  softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
>  softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
>  softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
> +softmmu_ss.add(when: 'CONFIG_WDT_SBSA_GWDT', if_true: files('wdt_sbsa_gwdt.c'))
> diff --git a/hw/watchdog/wdt_sbsa_gwdt.c b/hw/watchdog/wdt_sbsa_gwdt.c
> new file mode 100644
> index 000000000000..c0906180449e
> --- /dev/null
> +++ b/hw/watchdog/wdt_sbsa_gwdt.c
> @@ -0,0 +1,345 @@
> +/*
> + * Generic watchdog device model for SBSA
> + *
> + * Copyright Linaro.org 2020
> + *
> + * Authors:
> + *  Shashi Mallela <shashi.mallela@linaro.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> + * option) any later version.  See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/watchdog.h"
> +#include "hw/watchdog/wdt_sbsa_gwdt.h"
> +#include "qemu/timer.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +static WatchdogTimerModel model = {
> +    .wdt_name = TYPE_WDT_SBSA_GWDT,
> +    .wdt_description = "sbsa_gwdt device for sbsa_ref platform",
> +};
> +
> +static const VMStateDescription vmstate_sbsa_gwdt = {
> +    .name = "vmstate_sbsa_gwdt",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_TIMER_PTR(timer, SBSA_GWDTState),
> +        VMSTATE_BOOL(enabled, SBSA_GWDTState),
> +        VMSTATE_BOOL(ws0, SBSA_GWDTState),
> +        VMSTATE_BOOL(ws1, SBSA_GWDTState),
> +        VMSTATE_UINT32(wrr, SBSA_GWDTState),
> +        VMSTATE_UINT32(wcs, SBSA_GWDTState),
> +        VMSTATE_UINT32(worl, SBSA_GWDTState),
> +        VMSTATE_UINT32(woru, SBSA_GWDTState),
> +        VMSTATE_UINT32(wcvl, SBSA_GWDTState),
> +        VMSTATE_UINT32(wcvu, SBSA_GWDTState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    uint32_t ret;
> +
> +    if (addr == SBSA_GWDT_WRR) {
> +        /* watch refresh read has no effect and returns 0 */
> +        ret = 0;
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame read :"
> +                        " 0x%x\n", (int)addr);
> +    }
> +    return ret;
> +}
> +
> +static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(opaque);
> +    uint32_t ret = 0;
> +
> +    switch (addr) {
> +    case SBSA_GWDT_WCS:
> +        ret = s->wcs;
> +        break;
> +    case SBSA_GWDT_WOR:
> +        ret = s->worl;
> +        break;
> +    case SBSA_GWDT_WORU:
> +         ret = s->woru;
> +         break;
> +    case SBSA_GWDT_WCV:
> +        ret = s->wcvl;
> +        break;
> +    case SBSA_GWDT_WCVU:
> +        ret = s->wcvu;
> +        break;
> +    case SBSA_GWDT_W_IIDR:
> +        ret = s->id;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame read :"
> +                        " 0x%x\n", (int)addr);
> +    }
> +    return ret;
> +}
> +
> +static void sbsa_gwdt_update_timer(SBSA_GWDTState *s)
> +{
> +    uint64_t timeout = 0;
> +
> +    if (s->enabled) {
> +        /*
> +         * Extract the upper 16 bits from woru & 32 bits from worl
> +         * registers to construct the 48 bit offset value
> +         */
> +        timeout = s->woru & SBSA_GWDT_WOR_MASK;
> +        timeout <<= 32;
> +        timeout |= s->worl;
> +        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, SBSA_TIMER_FREQ);

static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
{
    return (__int128_t)a * b / c;
}

#define NANOSECONDS_PER_SECOND 1000000000LL

Interesting why gcc does not warn on  64bit signed to 32bit unsigned
truncation here. Looks like it's too smart to understand
that value fits in 32 bits.

> +        timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +        /* store the current timeout value into compare registers */
> +        s->wcvu = timeout >> 32;
> +        s->wcvl = timeout;
> +
> +        if (!s->ws0) {
> +            timer_del(s->timer);
> +            timer_mod(s->ptimer, timeout);
> +        } else {
> +            timer_del(s->ptimer);
> +            timer_mod(s->timer, timeout);
> +        }
> +    } else {
> +        timer_del(s->ptimer);
> +        timer_del(s->timer);
> +    }
> +}
> +
> +static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
> +                             unsigned size) {
> +    SBSA_GWDTState *s = SBSA_GWDT(opaque);
> +
> +    if (offset == SBSA_GWDT_WRR) {
> +        s->wrr = data;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;
> +        s->ws0 = false;
> +        s->ws1 = false;
> +        sbsa_gwdt_update_timer(s);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame write :"
> +                        " 0x%x\n", (int)offset);
> +    }
> +}
> +
> +static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
> +                             unsigned size) {
> +    SBSA_GWDTState *s = SBSA_GWDT(opaque);
> +    bool enable;
> +
> +    switch (offset) {
> +    case SBSA_GWDT_WCS:
> +        enable = data & SBSA_GWDT_WCS_EN;
> +        if (enable) {
> +            s->wcs |= SBSA_GWDT_WCS_EN;
> +            s->enabled = true;
> +        } else {
> +            s->wcs &= ~SBSA_GWDT_WCS_EN;
> +            s->enabled = false;
> +        }
> +        s->ws0 = false;
> +        s->ws1 = false;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;
> +        sbsa_gwdt_update_timer(s);
> +        break;
> +
> +    case SBSA_GWDT_WOR:
> +        s->worl = data;
> +        s->ws0 = false;
> +        s->ws1 = false;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;
> +        /*
> +         * TODO:- setting woru to 0 and triggering update timer(below) is a
> +         * temporary workaround to handle current linux driver which is
> +         * based on earlier version of BSA specification.Once the linux
> +         * driver is updated to BSA v0.9 will remove these next 2 lines.
> +         */
> +        s->woru = 0;
> +        sbsa_gwdt_update_timer(s);
> +        break;
> +
> +    case SBSA_GWDT_WORU:
> +        s->woru = data;
> +        s->ws0 = false;
> +        s->ws1 = false;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;
> +        sbsa_gwdt_update_timer(s);
> +        break;
> +
> +    case SBSA_GWDT_WCV:
> +        s->wcvl = data;
> +        break;
> +
> +    case SBSA_GWDT_WCVU:
> +        s->wcvu = data;
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame write :"
> +                " 0x%x\n", (int)offset);
> +    }
> +    return;
> +}
> +
> +static void wdt_sbsa_gwdt_reset(DeviceState *dev)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(dev);
> +
> +    timer_del(s->ptimer);
> +    timer_del(s->timer);
> +
> +    s->enabled = false;
> +    s->ws0 = false;
> +    s->ws1 = false;
> +    s->wcs &= ~SBSA_GWDT_WCS_EN;
> +    s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +    s->wcs &= ~SBSA_GWDT_WCS_WS1;
> +    s->wcvl = 0;
> +    s->wcvu = 0;
> +    s->worl = 0;
> +    s->woru = 0;
> +    s->id = SBSA_GWDT_ID;
> +}
> +
> +static void sbsa_gwdt_reset(void *opaque)
> +{
> +    DeviceState *sbsa_gwdt = opaque;
> +
> +    wdt_sbsa_gwdt_reset(sbsa_gwdt);
> +}
> +
> +static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(opaque);
> +
> +    s->wcs |= SBSA_GWDT_WCS_WS0;
> +    s->ws0 = true;
> +    qemu_set_irq(s->irq, 1);
> +    sbsa_gwdt_update_timer(s);
> +}
> +
> +static void sbsa_gwdt_timer_sysreset(void *dev)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(dev);

empty line is missing

> +    s->wcs |= SBSA_GWDT_WCS_WS1;
> +    s->ws1 = true;
> +    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
> +    /*
> +     * Reset the watchdog only if the guest gets notified about
> +     * expiry. watchdog_perform_action() may temporarily relinquish
> +     * the BQL; reset before triggering the action to avoid races with
> +     * sbsa_gwdt instructions.
> +     */
> +    switch (get_watchdog_action()) {
> +    case WATCHDOG_ACTION_DEBUG:
> +    case WATCHDOG_ACTION_NONE:
> +    case WATCHDOG_ACTION_PAUSE:
> +        break;
> +    default:
> +        wdt_sbsa_gwdt_reset(dev);
> +    }
> +    watchdog_perform_action();
> +}
> +
> +static const MemoryRegionOps sbsa_gwdt_rops = {
> +    .read = sbsa_gwdt_rread,
> +    .write = sbsa_gwdt_rwrite,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .valid.unaligned = false,
> +};
> +
> +static const MemoryRegionOps sbsa_gwdt_ops = {
> +    .read = sbsa_gwdt_read,
> +    .write = sbsa_gwdt_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .valid.unaligned = false,
> +};
> +
> +static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->rmmio, OBJECT(dev),
> +                          &sbsa_gwdt_rops, s,
> +                          "sbsa_gwdt.refresh",
> +                          SBSA_GWDT_RMMIO_SIZE);
> +
> +    memory_region_init_io(&s->cmmio, OBJECT(dev),
> +                          &sbsa_gwdt_ops, s,
> +                          "sbsa_gwdt.control",
> +                          SBSA_GWDT_CMMIO_SIZE);
> +
> +    sysbus_init_mmio(sbd, &s->rmmio);
> +    sysbus_init_mmio(sbd, &s->cmmio);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    qemu_register_reset(sbsa_gwdt_reset, s);
> +
> +    s->ptimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
> +            dev);
> +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysreset,
> +                dev);
> +}
> +
> +static void wdt_sbsa_gwdt_unrealize(DeviceState *dev)
> +{
> +    SBSA_GWDTState *s = SBSA_GWDT(dev);
> +
> +    timer_del(s->ptimer);
> +    timer_free(s->ptimer);
> +
> +    timer_del(s->timer);
> +    timer_free(s->timer);
> +}
> +
> +static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = wdt_sbsa_gwdt_realize;
> +    dc->unrealize = wdt_sbsa_gwdt_unrealize;
> +    dc->reset = wdt_sbsa_gwdt_reset;
> +    dc->hotpluggable = false;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->vmsd = &vmstate_sbsa_gwdt;
> +}
> +
> +static const TypeInfo wdt_sbsa_gwdt_info = {
> +    .class_init = wdt_sbsa_gwdt_class_init,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .name  = TYPE_WDT_SBSA_GWDT,
> +    .instance_size  = sizeof(SBSA_GWDTState),
> +};
> +
> +static void wdt_sbsa_gwdt_register_types(void)
> +{
> +    watchdog_add_model(&model);
> +    type_register_static(&wdt_sbsa_gwdt_info);
> +}
> +
> +type_init(wdt_sbsa_gwdt_register_types)
> diff --git a/include/hw/watchdog/wdt_sbsa_gwdt.h b/include/hw/watchdog/wdt_sbsa_gwdt.h
> new file mode 100644
> index 000000000000..70ba7abb3ace
> --- /dev/null
> +++ b/include/hw/watchdog/wdt_sbsa_gwdt.h
> @@ -0,0 +1,70 @@
> +#ifndef WDT_SBSA_GWDT_H
> +#define WDT_SBSA_GWDT_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +
> +#define TYPE_WDT_SBSA_GWDT "sbsa_gwdt"
> +#define SBSA_GWDT(obj) \
> +    OBJECT_CHECK(SBSA_GWDTState, (obj), TYPE_WDT_SBSA_GWDT)
> +#define SBSA_GWDT_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(SBSA_GWDTClass, (klass), TYPE_WDT_SBSA_GWDT)
> +#define SBSA_GWDT_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(SBSA_GWDTClass, (obj), TYPE_WDT_SBSA_GWDT)
> +
> +/* SBSA Generic Watchdog register definitions */
> +/* refresh frame */
> +#define SBSA_GWDT_WRR       0x000
> +
> +/* control frame */
> +#define SBSA_GWDT_WCS       0x000
> +#define SBSA_GWDT_WOR       0x008
> +#define SBSA_GWDT_WORU      0x00C
> +#define SBSA_GWDT_WCV       0x010
> +#define SBSA_GWDT_WCVU      0x014
> +
> +/* Watchdog Interface Identification Register */
> +#define SBSA_GWDT_W_IIDR    0xFCC
> +
> +/* Watchdog Control and Status Register Bits */
> +#define SBSA_GWDT_WCS_EN    BIT(0)
> +#define SBSA_GWDT_WCS_WS0   BIT(1)
> +#define SBSA_GWDT_WCS_WS1   BIT(2)
> +
> +#define SBSA_GWDT_WOR_MASK  0x0000FFFF
> +
> +/* Watchdog Interface Identification Register definition*/
> +#define SBSA_GWDT_ID        0x1043B
> +
> +/* 2 Separate memory regions for each of refresh & control register frames */
> +#define SBSA_GWDT_RMMIO_SIZE 0x1000
> +#define SBSA_GWDT_CMMIO_SIZE 0x1000
> +
> +#define SBSA_TIMER_FREQ      62500000 /* Hz */
> +
> +typedef struct SBSA_GWDTState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion rmmio;
> +    MemoryRegion cmmio;
> +    qemu_irq irq;
> +
> +    QEMUTimer *ptimer, *timer;
> +
> +    uint32_t id;
> +    uint32_t wrr;
> +    uint32_t wcs;
> +    uint32_t worl;
> +    uint32_t woru;
> +    uint32_t wcvl;
> +    uint32_t wcvu;
> +    bool enabled;
> +    bool ws0, ws1;
> +
> +    /*< public >*/
> +} SBSA_GWDTState;
> +
> +#endif /* WDT_SBSA_GWDT_H */
> --
> 2.18.4
>
>

