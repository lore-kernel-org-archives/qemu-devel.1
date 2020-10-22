Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E115FC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA74B21707
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gipor9Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA74B21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVczz-0001P6-9R
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVczA-0000nF-S0
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:58:40 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kVcz7-0000hF-UJ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:58:40 -0400
Received: by mail-qt1-x842.google.com with SMTP id h19so1425545qtq.4
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:mime-version
 :content-transfer-encoding;
 bh=oyCTo2y4/JQNPo8GuNKg459uXEO7WofQaokeDdbQbxU=;
 b=Gipor9BnAQMHD6xrcE1hGVPGv/7DFJFXHhp81B2svXGzfnh7FxXw0Ss0ktr5EA4bdR
 o9t4pV+8fQ3fQ7BGfHo+b6/RKwY+yypIuOzpNKDP/jVUb5C0SDF+KeZR1g67IsDGpzll
 3l546aCZ+deN9o8+0TxqpZvz5vLaGIZnJ3m6KtqH60GsvzyiRfVVCC/vU2/fXhbgKq7/
 x2B21uG1VO9is/hAI9cIjHK7e/EQzR5N3Eyh0qraRDnaAPZu57Z/Dbjo+9Jpi8I3QP5/
 Qf2dwkdVmAPq5x8Kei20TaK3yOobjXaBVK+3h/zVzPwKhvmNzrzKvC/FcmcRhNQd2/qL
 ba+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :mime-version:content-transfer-encoding;
 bh=oyCTo2y4/JQNPo8GuNKg459uXEO7WofQaokeDdbQbxU=;
 b=OP7tiaBN/PLOpXDWcaI1W50s1ArZK0ZMtSVXojF7r5VunFVDawlGBGPHVhag+0uKki
 Cg+v4DMqmVoIDgHYVrsLQ6YochbYgdfC+f6rQFe8I/WZIwlb4rXZjj8mbriGekfCo3Tm
 usr+idEZvt9YJvGSmHXrRGS53pyznTePlGa+q4xC8I2BvuzHhRlDtvApdSwhLXd1ZseU
 EdfeI4zYnWMW15IevQ/rtFkeIItH26nXgFPd/ESQzj+PYhinqj2ikskhy6eWx0hUqNAT
 MmdAwHbydH9PahT6Zt0I3GzsbGG8M3yIZ7sodA+87JQIfylPrqxgSRGUU1nI76O2TCg6
 55dA==
X-Gm-Message-State: AOAM532XL2vWadOKeL2qIKA9FVRRVunhYbywlLy8NwLEbbLcQYm/Vc6d
 I9nmqZV/TFdI/qR5vieRiW46llSy+GInx3ei
X-Google-Smtp-Source: ABdhPJzQNtWrWeq/U+1ztycVJJJLFK6IK+CVEr4xmkyFR84CkiCYTIt7u3l3psbQCzlIu0aI48zIzw==
X-Received: by 2002:ac8:5141:: with SMTP id h1mr2555588qtn.139.1603382315229; 
 Thu, 22 Oct 2020 08:58:35 -0700 (PDT)
Received: from localhost.localdomain
 (stsvon1503w-lp130-06-174-91-97-36.dsl.bell.ca. [174.91.97.36])
 by smtp.gmail.com with ESMTPSA id k3sm1226425qtj.84.2020.10.22.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 08:58:34 -0700 (PDT)
Message-ID: <581f003b5c57586d00dcf5fe90ce40a87c04ecc4.camel@linaro.org>
Subject: Re: [PATCH v6 1/2] hw/watchdog: Implement SBSA watchdog device
From: shashi.mallela@linaro.org
To: peter.maydell@linaro.org
Date: Thu, 22 Oct 2020 11:58:33 -0400
In-Reply-To: <CAFEAcA_FjpV-SeO8t=DSgk8S5MCasi6iF-uzpUuEdx8eY9564A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qt1-x842.google.com
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 17:35, Shashi Mallela <shashi.mall...@linaro.org
> wrote:
>
> Generic watchdog device model has been implemented as per ARM BSAv0.9


Hmm, so the patch title, filenames, etc, refer to the SBSA,
which is the Server Base System Architecture spec. Is the BSA
a different spec ? We should be consistent with our terminology
and clear about what spec we're implementing.

(I've used the SBSA v6.0 as reference in the review comments below.)

Shashi,The implementation is based on SBSA v6.0, i will change the
commit message accordingly

> Signed-off-by: Shashi Mallela <shashi.mall...@linaro.org>
> ---
>  hw/arm/Kconfig                      |   1 +
>  hw/watchdog/Kconfig                 |   4 +
>  hw/watchdog/meson.build             |   1 +
>  hw/watchdog/wdt_sbsa_gwdt.c         | 346
++++++++++++++++++++++++++++

This filename is rather redundant as it says "watchdog" three
times. hw/watchdog/sbsa_gwdt.c will do (similarly the .h file).

Shashi,Done

>  include/hw/watchdog/wdt_sbsa_gwdt.h |  70 ++++++
>  5 files changed, 422 insertions(+)
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

I don't think you need the "default" line here. The board
config "select"s the device, so if the user enables the board
they'll get the device, which is all you need.

Shashi,Done

> diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
> index 9b8725e64288..a9a23307acfe 100644
> --- a/hw/watchdog/meson.build
> +++ b/hw/watchdog/meson.build
> @@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: 
> files('wdt_ib700.c'))
>  softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true:
files('wdt_diag288.c'))
>  softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
files('wdt_aspeed.c'))
>  softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true:
files('wdt_imx2.c'))
> +softmmu_ss.add(when: 'CONFIG_WDT_SBSA_GWDT', if_true: 
> files('wdt_sbsa_gwdt.c'))
> diff --git a/hw/watchdog/wdt_sbsa_gwdt.c
b/hw/watchdog/wdt_sbsa_gwdt.c
> new file mode 100644
> index 000000000000..1c2fe04db7c7
> --- /dev/null
> +++ b/hw/watchdog/wdt_sbsa_gwdt.c
> @@ -0,0 +1,346 @@
> +/*
> + * Generic watchdog device model for SBSA
> + *
> + * Copyright Linaro.org 2020
> + *
> + * Authors:
> + *  Shashi Mallela <shashi.mall...@linaro.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
or (at 
> your
> + * option) any later version.  See the COPYING file in the top-
level 
> directory.
> + *
> + */

This is a good place for a comment which gives the title and
a URL for the specification the device is based on.

It would also be helpful to say what revision of the watchdog
we implement (the SBSA 6.0 spec says there is a "revision 0"
and also a "revision 1"; looks like we're revision 1 ?)

Shashi, Added a comment at the top of the file indicating the SBSA 6.0
spec and revision 1

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

Other wdt_description strings use the human-facing name
of the device, so something like
  "Generic SBSA-compliant watchdog device"
seems a better match to the others.
(The board name is 'sbsa-ref' with a hyphen, by the way.)

Shashi,Done

> +};
> +
> +static const VMStateDescription vmstate_sbsa_gwdt = {
> +    .name = "vmstate_sbsa_gwdt",

You can drop the 'vmstate_' prefix. Just "sbsa-gwdt" will do.

Shashi,Done

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

This is missing 'ptimer' (but see below for a review comment
where I recommend dropping 'ptimer' entirely).

Shashi, Removed ptimer usage as in the other comment

> +    }
> +};
> +
> +static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned
int size)
> +{
> +    uint32_t ret = 0;
> +
> +    if (addr == SBSA_GWDT_WRR) {
> +        /* watch refresh read has no effect and returns 0 */
> +        ret = 0;
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame
read :"
> +                        " 0x%x\n", (int)addr);
> +    }

The spec says that reading from 0xfcc is valid in both the
refresh and the control frame (returning the same ID value in
both cases).

Shashi, Added 0xfcc ID value read for refresh frame offset as well

> +    return ret;
> +}
> +
> +static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned
int size)
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
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame
read :"
> +                        " 0x%x\n", (int)addr);
> +    }
> +    return ret;
> +}
> +
> +static void sbsa_gwdt_update_timer(SBSA_GWDTState *s)
> +{
> +    uint64_t timeout = 0;

The spec talks about "explicit refresh" and "timeout refresh"
events. Is this function implementing both of those ?
If so, a function name indicating that would be helpful
to the reader. If it's only implementing part of the refresh
semantics then an explanatory comment would help.

Shashi, Have updated this function signature to include an enum type
(to indicate EXPLICIT_REFRESH & TIMEOUT_REFRESH ) as additional
parameter (below)
"static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType
rtype)"
and the caller does "sbsa_gwdt_update_timer(s, TIMEOUT_REFRESH)".

> +
> +    if (s->enabled) {
> +        /*
> +         * Extract the upper 16 bits from woru & 32 bits from worl
> +         * registers to construct the 48 bit offset value
> +         */
> +        timeout = s->woru & SBSA_GWDT_WOR_MASK;
> +        timeout <<= 32;
> +        timeout |= s->worl;
> +        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND,
SBSA_TIMER_FREQ);
> +        timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +        /* store the current timeout value into compare registers */
> +        s->wcvu = timeout >> 32;
> +        s->wcvl = timeout;

The spec says that for an SBSA level 2 or higher system, the
compare value shouldn't be updated for a timeout-refresh when
WS0 is asserted (and for SBSA level 0 or 1 the level 2 behaviour
is permitted as an IMPDEF option).

Shashi, The qemu sbsa-ref platform code is based for levels 2 or
higher.Hence,have now added logic to not update compare value for
timeout-refresh.

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

Here you have two timers, "timer" and "ptimer", which are set up
so that you always have exactly one running. It would be simpler
to have a single timer, and then decide what you're doing on
expiry by looking at the device state in its callback function.

Shashi, Done.Removed ptimer and adapted code for single timer usage

> +    }
> +}
> +
> +static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t
data,
> +                             unsigned size) {
> +    SBSA_GWDTState *s = SBSA_GWDT(opaque);
> +
> +    if (offset == SBSA_GWDT_WRR) {
> +        s->wrr = data;

There is no code path which allows the guest to read s->wrr
and nothing in the device model does anything with it,
so there is no need to have it be state at all. That is,
a write to WRR is a trigger for behaviour, but no state
is stored.

Shashi, removed wrr from state

> +        s->wcs &= ~SBSA_GWDT_WCS_WS0;
> +        s->wcs &= ~SBSA_GWDT_WCS_WS1;
> +        s->ws0 = false;
> +        s->ws1 = false;
> +        sbsa_gwdt_update_timer(s);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame
write :"
> +                        " 0x%x\n", (int)offset);
> +    }
> +}
> +
> +static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t
data,
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

You are storing state duplicated in two places here. You can either:
 * store the state of bits like the WS0, WS1, Enable as bits inside
   an s->wcs register value -- in this case reads and writes are
   easy, and if you want to test for "is device enabled" you do
   it with a logical operation on s->wcs; there would be no
   separate ws0/ws1/enabled fields in the state struct
 * or you can store them as separate boolean fields, in which case
   you don't need an s->wcs at all. Instead in the read function
   you assemble the value the guest reads from the ws0/ws1/enable
   booleans
Which one is preferable depends on the device and whether there's
a lot of code that often tests the various bits. You can pick
either option, but don't do both at once the way this code is.

Similarly, you have a choice of whether you prefer to
hold the WCV and WOR values in the state struct as a
pair of uint32_t (trivial to read/write, need to reassemble
into the full value whenever you want to operate on it)
or as a single uint64_t (easier for the device to operate
on, register reads/writes become extract64/deposit64 operations).

Shashi, Done,removed bool flags like ws0,ws1,enabled from state and
made use of s->wcs with relevant bit fields for all accesses

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
> +         * TODO:- setting woru to 0 and triggering update
timer(below) is a
> +         * temporary workaround to handle current linux driver which
is
> +         * based on earlier version of BSA specification.Once the
linux
> +         * driver is updated to BSA v0.9 will remove these next 2
lines.
> +         */

No workarounds for buggy Linux guest drivers, please. Once they
get into the code base they are almost impossible to ever
get out again. You can either:
1) just implement the newer version of the specification,
   and fix the guest drivers
2) if you must have a system that works with older guests,
   then implement *both* older and newer specs, using a
   QOM property on the device to select which one. You'd
   need to implement the details of the older version of
   the spec completely, not just "this is the one thing that
   the Linux driver happens to care about". You'd also need
   a machine property on the sbsa-ref board so the user could
   select whether they wanted the old or new watchdog device.

I'd recommend option 1, really.

Shashi, Done.implemented option 1

> +        s->woru = 0;
> +        sbsa_gwdt_update_timer(s);
> +        break;
> +
> +    case SBSA_GWDT_WORU:
> +        s->woru = data;

This and WCVU have the top 16 bits RAZ/WI, so you should
mask out the top half of 'data' so the guest can't write
an over-large value.

Shashi, The top 16 bits only applies to WORU(of the total 48 bits for
WOR).Will mask the top half of data as you suggested.                
But,WCV is 64 bits overall (with upper 32 bits in WCVU & lower 32 bits
in WCV).Hence there is no need to mask 16 bits for WCVU since it is not
applicable.

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
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame
write :"
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

Why do you have two reset functions which do the same thing ?

Shashi, Done.Removed 1 of the reset function

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
> +
> +    s->wcs |= SBSA_GWDT_WCS_WS1;
> +    s->ws1 = true;
> +    qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
> +    /*
> +     * Reset the watchdog only if the guest gets notified about
> +     * expiry. watchdog_perform_action() may temporarily relinquish
> +     * the BQL; reset before triggering the action to avoid races
with
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

No new code should call qemu_register_reset(). You can
provide a reset function via dc->reset in your DeviceClass,
and in fact you have.

Shashi, Done.Removed qemu_register_reset() call

> +
> +    s->ptimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, 
> sbsa_gwdt_timer_sysinterrupt,
> +            dev);
> +    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
sbsa_gwdt_timer_sysreset,
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

This device isn't hot-pluggable, so this unrealize method
is unreachable code, I think.

Shashi, Done.Removed unrealize

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
> diff --git a/include/hw/watchdog/wdt_sbsa_gwdt.h 
> b/include/hw/watchdog/wdt_sbsa_gwdt.h
> new file mode 100644
> index 000000000000..70ba7abb3ace
> --- /dev/null
> +++ b/include/hw/watchdog/wdt_sbsa_gwdt.h
> @@ -0,0 +1,70 @@

New files, including .h files, should start with a
copyright-and-license comment.

Shashi, Done

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

Missing space before '*/'

Shashi, Done

> +#define SBSA_GWDT_ID        0x1043B

Bits [11:0] in this field are a JEP106 code for the company
that implemented the device. Who are we claiming to be here ?

Shashi,have added JEP106 code considering "ARM" as the company(since
this is an ARM SBSA and Linaro doesnt have its own code)

> +
> +/* 2 Separate memory regions for each of refresh & control register
frames */
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

What's this extra 'public' comment for ?

Shashi, Done.Removed

> +} SBSA_GWDTState;
> +
> +#endif /* WDT_SBSA_GWDT_H */
> --
> 2.18.4
>


