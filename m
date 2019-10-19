Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE3CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C13222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHUPO3j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C13222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLi8m-0007Cb-RF
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLi7q-0006Us-S0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLi7n-0008Bb-Er
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:22:06 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:40198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLi7g-00086G-E8; Sat, 19 Oct 2019 02:21:56 -0400
Received: by mail-ot1-x333.google.com with SMTP id y39so6817844ota.7;
 Fri, 18 Oct 2019 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=0813AOP8I8VmTZI2h2gaVj/isjTWg6yfp+CQwjdUR3Y=;
 b=EHUPO3j+qzYfI8fYQRYuAiTA7jQPVOBSUgNroembQXgD5TS7oGicmxdVtwWFI7LM7z
 nFwCtq5Ij5lyDUlsUXAWj0PTYoyr+78Upd+wcgJetwie3SwsQL2LXvk1UUY5qjyqaWxz
 dWGoul9PBC/5TMNmZ+2jTjEIKRFH+rn7XMm7AOX4k9EHI7plKzvnnRwwhVcETa09TTL1
 3L/ot8qx95LtGGfd79hs86u2pFBM3ShIPqmYT+jUOqV3quu5XeXfqmZpnfmpHghcLnw2
 7WK7e9JdRwWjEPFMt+sujPSPEXlFftHKErf2vuasFbdFcFoMpth1mZveWcqt+Xfcvvkk
 DLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=0813AOP8I8VmTZI2h2gaVj/isjTWg6yfp+CQwjdUR3Y=;
 b=I9WJgfqAkN7J+GD3BwGvItUlpvPqdxArdZSpFqABKb45O7ygmktHZC7Iw6cAQkF5Xa
 xhDkmLahMEqMpKnjhGagLjjp8OiMJRm88y3SzFomrpMc5SFgfSo98BLpOHwhKLtzELnU
 ski8iSMlsTNbFcaSq2aM8yCpRdtRfUwzM0kTonYCp06IytU5f1qbXmj8t0I++Wi3/9p0
 seQKtZzuPb8YpcUWAx7/SnR5iu5RPI91xwEiXTwJCeSfIMf+6HJK9BJzUTgenBFGJZ/B
 sUi+hAojEKIrgY9kpmOfdh8UCUlLczbPCoctEweOxZknSgmo8iFwEYgerZl2MQPco50S
 +ttQ==
X-Gm-Message-State: APjAAAVD5ytPg3hvIE44C907LYuqcBXff/yKfOeT2qElCgeLeDBKJYhm
 SGeTdqmNwpZFXKakJcXyjmiNXla7ljEiAVWb/b0=
X-Google-Smtp-Source: APXvYqxgetZRhYv2Uj7ewWelsiuke6MMWP4O7CSa0DhEpvSqXzgriY12VWONs+z23dZkrnMftv+TGwi13G4tBtf2jCI=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr10001506otl.64.1571466115146; 
 Fri, 18 Oct 2019 23:21:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 23:21:54
 -0700 (PDT)
In-Reply-To: <MN2PR04MB60610CF742179D43C1A5712B8D6F0@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20191015083459.76959-1-anup.patel@wdc.com>
 <20191015083459.76959-2-anup.patel@wdc.com>
 <CAL1e-=guhS+vf4v7Mg6byZWEpuFuGXX3td4+0=wv1ypPs5wAEw@mail.gmail.com>
 <MN2PR04MB60610CF742179D43C1A5712B8D6F0@MN2PR04MB6061.namprd04.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 08:21:54 +0200
Message-ID: <CAL1e-=jmrSnpfBZYbbWAh2TDELhm0ZQQUj45xCt7zFmGDoMQeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw: timer: Add Goldfish RTC device
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: multipart/alternative; boundary="00000000000091e95e05953d7798"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000091e95e05953d7798
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Anup Patel <Anup.Patel@wdc.com> wrote:

> Hi,
>
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Sent: Saturday, October 19, 2019 2:45 AM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Palmer Dabbelt <
> palmer@sifive.com>; Alistair Francis <Alistair.Francis@wdc.com>; Sagar
> Karandikar <sagark@eecs.berkeley.edu>; Bastian Koppelmann <
> kbastian@mail.uni-paderborn.de>; Atish Patra <Atish.Patra@wdc.com>;
> qemu-riscv@nongnu.org; qemu-devel@nongnu.org; Anup Patel <
> anup@brainfault.org>
> Subject: Re: [PATCH v3 1/2] hw: timer: Add Goldfish RTC device
>
> =C5=AB
>
> On Tuesday, October 15, 2019, Anup Patel <mailto:Anup.Patel@wdc.com>
> wrote:
> This patch adds model for Google Goldfish virtual platform RTC device.
>
> We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
> for providing real date-time to Guest Linux. The corresponding Linux
> driver for Goldfish RTC device is already available in upstream Linux.
>
> For now, VM migration support is available but untested for Goldfish RTC
> device. It will be hardened in-future when we implement VM migration for
> KVM RISC-V.
>
> Signed-off-by: Anup Patel <mailto:anup.patel@wdc.com>
> ---
>  hw/rtc/Kconfig                  |   3 +
>  hw/rtc/Makefile.objs            |   1 +
>  hw/rtc/goldfish_rtc.c           | 278 ++++++++++++++++++++++++++++++++
>  include/hw/timer/goldfish_rtc.h |  46 ++++++
>  4 files changed, 328 insertions(+)
>  create mode 100644 hw/rtc/goldfish_rtc.c
>  create mode 100644 include/hw/timer/goldfish_rtc.h
>
> Do you plan to add some other devices from Goldfish platform?
>
> [Anup] Nopes, we just needed a simple RTC device for RISC-V
> [Anup] virt machine hence this patch.
>
> [Anup] Most of the required devices are already there in
> [Anup] the VirtIO spec. The RTC device was missing in
> [Anup] VirtIO spec so instead of creating new virtual RTC
> [Anup] device we just re-use Goldfish RTC. This help us
> [Anup] re-use the Linux Goldfish RTC driver.
>
> Did you base your code on Android emulator code?
>
> [Anup] Nopes, the android emulator code seemed too simple
> [Anup] and lacking. In fact, the Linux Goldfish RTC driver does
> [Anup] much more.
>
> [Anup] Based on the documentation and Linux Goldfish RTC
> [Anup] driver, I wrote it from scratch.
>
>
Ok, that is great, nice work. I just wanted to doublecheck if we are OK
from the aspect of authorship. "Western Digital" in copyright preamble is
certainly fine in this case.

A.

[Anup] I first added Goldfish RTC emulator to Xvisor RISC-V
> [Anup] virt machine. Got it working over there and then
> [Anup] ported it to QEMU. For qemu emulation, I looked
> [Anup] at existing RTC emulators (such as PL031) for QEMU
> [Anup] API usage.
>
> Related to the previous question, are you sure the copyright line should
> go to Western Digital only?
>
> [Anup] I thought copyright will be of implementer hence I
> [Anup] put Western Digital only. The spec and Linux driver
> [Anup] can be written by totally different folks.
>
> Regards,
> Anup
>
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 45daa8d655..bafe6ac2c9 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -21,3 +21,6 @@ config MC146818RTC
>
>  config SUN4V_RTC
>      bool
> +
> +config GOLDFISH_RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 8dc9fcd3a9..aa208d0d10 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o
> +common-obj-$(CONFIG_GOLDFISH_RTC) +=3D goldfish_rtc.o
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> new file mode 100644
> index 0000000000..223616ed75
> --- /dev/null
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -0,0 +1,278 @@
> +/*
> + * Goldfish virtual platform RTC
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * For more details on Google Goldfish virtual platform refer:
> + * https://android.googlesource.com/platform/external/qemu/+/
> master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/timer/goldfish_rtc.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +
> +#define RTC_TIME_LOW            0x00
> +#define RTC_TIME_HIGH           0x04
> +#define RTC_ALARM_LOW           0x08
> +#define RTC_ALARM_HIGH          0x0c
> +#define RTC_IRQ_ENABLED         0x10
> +#define RTC_CLEAR_ALARM         0x14
> +#define RTC_ALARM_STATUS        0x18
> +#define RTC_CLEAR_INTERRUPT     0x1c
> +
> +static void goldfish_rtc_update(GoldfishRTCState *s)
> +{
> +    qemu_set_irq(s->irq, (s->irq_pending & s->irq_enabled) ? 1 : 0);
> +}
> +
> +static void goldfish_rtc_interrupt(void *opaque)
> +{
> +    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
> +
> +    s->alarm_running =3D 0;
> +    s->irq_pending =3D 1;
> +    goldfish_rtc_update(s);
> +}
> +
> +static uint64_t goldfish_rtc_get_count(GoldfishRTCState *s)
> +{
> +    return s->tick_offset + (uint64_t)qemu_clock_get_ns(rtc_clock);
> +}
> +
> +static void goldfish_rtc_clear_alarm(GoldfishRTCState *s)
> +{
> +    timer_del(s->timer);
> +    s->alarm_running =3D 0;
> +}
> +
> +static void goldfish_rtc_set_alarm(GoldfishRTCState *s)
> +{
> +    uint64_t ticks =3D goldfish_rtc_get_count(s);
> +    uint64_t event =3D s->alarm_next;
> +
> +    if (event <=3D ticks) {
> +        goldfish_rtc_clear_alarm(s);
> +        goldfish_rtc_interrupt(s);
> +    } else {
> +        int64_t now =3D qemu_clock_get_ns(rtc_clock);
> +        timer_mod(s->timer, now + (event - ticks));
> +        s->alarm_running =3D 1;
> +    }
> +}
> +
> +static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
> +                                  unsigned size)
> +{
> +    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
> +    uint64_t r;
> +
> +    switch (offset) {
> +    case RTC_TIME_LOW:
> +        r =3D goldfish_rtc_get_count(s) & 0xffffffff;
> +        break;
> +    case RTC_TIME_HIGH:
> +        r =3D goldfish_rtc_get_count(s) >> 32;
> +        break;
> +    case RTC_ALARM_LOW:
> +        r =3D s->alarm_next & 0xffffffff;
> +        break;
> +    case RTC_ALARM_HIGH:
> +        r =3D s->alarm_next >> 32;
> +        break;
> +    case RTC_IRQ_ENABLED:
> +        r =3D s->irq_enabled;
> +        break;
> +    case RTC_ALARM_STATUS:
> +        r =3D s->alarm_running;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "goldfish_rtc_read: Bad offset 0x%x\n",
> (int)offset);
> +        r =3D 0;
> +        break;
> +    }
> +
> +    return r;
> +}
> +
> +static void goldfish_rtc_write(void *opaque, hwaddr offset,
> +                               uint64_t value, unsigned size)
> +{
> +    uint64_t current_tick, new_tick;
> +    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
> +
> +    switch (offset) {
> +    case RTC_TIME_LOW:
> +        current_tick =3D goldfish_rtc_get_count(s);
> +        new_tick =3D current_tick & (0xffffffffULL << 32);
> +        new_tick |=3D value;
> +        s->tick_offset +=3D new_tick - current_tick;
> +        break;
> +    case RTC_TIME_HIGH:
> +        current_tick =3D goldfish_rtc_get_count(s);
> +        new_tick =3D current_tick & 0xffffffffULL;
> +        new_tick |=3D (value << 32);
> +        s->tick_offset +=3D new_tick - current_tick;
> +        break;
> +    case RTC_ALARM_LOW:
> +        s->alarm_next &=3D (0xffffffffULL << 32);
> +        s->alarm_next |=3D value;
> +        goldfish_rtc_set_alarm(s);
> +        break;
> +    case RTC_ALARM_HIGH:
> +        s->alarm_next &=3D 0xffffffffULL;
> +        s->alarm_next |=3D (value << 32);
> +        break;
> +    case RTC_IRQ_ENABLED:
> +        s->irq_enabled =3D (uint32_t)(value & 0x1);
> +        goldfish_rtc_update(s);
> +        break;
> +    case RTC_CLEAR_ALARM:
> +        goldfish_rtc_clear_alarm(s);
> +        break;
> +    case RTC_CLEAR_INTERRUPT:
> +        s->irq_pending =3D 0;
> +        goldfish_rtc_update(s);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "goldfish_rtc_write: Bad offset 0x%x\n",
> (int)offset);
> +        break;
> +    }
> +}
> +
> +static int goldfish_rtc_pre_save(void *opaque)
> +{
> +    uint64_t delta;
> +    GoldfishRTCState *s =3D opaque;
> +
> +    /*
> +     * We want to migrate this offset, which sounds straightforward.
> +     * Unfortunately, we cannot directly pass tick_offset because
> +     * rtc_clock on destinetion Host might not be same source Host.
> +     *
> +     * To tackle, this we pass tick_offset relative to vm_clock from
> +     * source Host and make it relative to rtc_clock at destinetion Host=
.
> +     */
> +    delta =3D qemu_clock_get_ns(rtc_clock) -
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset_vmstate =3D s->tick_offset + delta;
> +
> +    return 0;
> +}
> +
> +static int goldfish_rtc_post_load(void *opaque, int version_id)
> +{
> +    uint64_t delta;
> +    GoldfishRTCState *s =3D opaque;
> +
> +    /*
> +     * We extract tick_offset from tick_offset_vmstate by doing
> +     * reverse math compared to pre_save() function.
> +     */
> +    delta =3D qemu_clock_get_ns(rtc_clock) -
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset =3D s->tick_offset_vmstate - delta;
> +
> +    return 0;
> +}
> +
> +static const MemoryRegionOps goldfish_rtc_ops =3D {
> +    .read =3D goldfish_rtc_read,
> +    .write =3D goldfish_rtc_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4
> +    }
> +};
> +
> +static const VMStateDescription goldfish_rtc_vmstate =3D {
> +    .name =3D TYPE_GOLDFISH_RTC,
> +    .version_id =3D 1,
> +    .pre_save =3D goldfish_rtc_pre_save,
> +    .post_load =3D goldfish_rtc_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
> +        VMSTATE_UINT64(alarm_next, GoldfishRTCState),
> +        VMSTATE_UINT32(alarm_running, GoldfishRTCState),
> +        VMSTATE_UINT32(irq_pending, GoldfishRTCState),
> +        VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void goldfish_rtc_reset(DeviceState *dev)
> +{
> +    GoldfishRTCState *s =3D GOLDFISH_RTC(dev);
> +    struct tm tm;
> +
> +    timer_del(s->timer);
> +
> +    qemu_get_timedate(&tm, 0);
> +    s->tick_offset =3D mktimegm(&tm);
> +    s->tick_offset *=3D NANOSECONDS_PER_SECOND;
> +    s->tick_offset -=3D qemu_clock_get_ns(rtc_clock);
> +    s->tick_offset_vmstate =3D 0;
> +    s->alarm_next =3D 0;
> +    s->alarm_running =3D 0;
> +    s->irq_pending =3D 0;
> +    s->irq_enabled =3D 0;
> +}
> +
> +static void goldfish_rtc_realize(DeviceState *d, Error **errp)
> +{
> +    SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
> +    GoldfishRTCState *s =3D GOLDFISH_RTC(d);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
> +                          "goldfish_rtc", 0x1000);
> +    sysbus_init_mmio(dev, &s->iomem);
> +
> +    sysbus_init_irq(dev, &s->irq);
> +
> +    s->timer =3D timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
> +}
> +
> +static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D goldfish_rtc_realize;
> +    dc->reset =3D goldfish_rtc_reset;
> +    dc->vmsd =3D &goldfish_rtc_vmstate;
> +}
> +
> +static const TypeInfo goldfish_rtc_info =3D {
> +    .name          =3D TYPE_GOLDFISH_RTC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(GoldfishRTCState),
> +    .class_init    =3D goldfish_rtc_class_init,
> +};
> +
> +static void goldfish_rtc_register_types(void)
> +{
> +    type_register_static(&goldfish_rtc_info);
> +}
> +
> +type_init(goldfish_rtc_register_types)
> diff --git a/include/hw/timer/goldfish_rtc.h b/include/hw/timer/goldfish_
> rtc.h
> new file mode 100644
> index 0000000000..dfb6d70b86
> --- /dev/null
> +++ b/include/hw/timer/goldfish_rtc.h
> @@ -0,0 +1,46 @@
> +/*
> + * Goldfish virtual platform RTC
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * For more details on Google Goldfish virtual platform refer:
> + * https://android.googlesource.com/platform/external/qemu/+/
> master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_TIMER_GOLDFISH_RTC_H
> +#define HW_TIMER_GOLDFISH_RTC_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_GOLDFISH_RTC "goldfish_rtc"
> +#define GOLDFISH_RTC(obj) \
> +OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
> +
> +typedef struct GoldfishRTCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    QEMUTimer *timer;
> +    qemu_irq irq;
> +
> +    uint64_t tick_offset;
> +    uint64_t tick_offset_vmstate;
> +    uint64_t alarm_next;
> +    uint32_t alarm_running;
> +    uint32_t irq_pending;
> +    uint32_t irq_enabled;
> +} GoldfishRTCState;
> +
> +#endif
> --
> 2.17.1
>
>

--00000000000091e95e05953d7798
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Anup Patel &lt;<a href=3D"mailto:Anu=
p.Patel@wdc.com">Anup.Patel@wdc.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Hi,<br>
<br>
From: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com=
">aleksandar.m.mail@gmail.com</a>&gt; <br>
Sent: Saturday, October 19, 2019 2:45 AM<br>
To: Anup Patel &lt;<a href=3D"mailto:Anup.Patel@wdc.com">Anup.Patel@wdc.com=
</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.may=
dell@linaro.org</a>&gt;; Palmer Dabbelt &lt;<a href=3D"mailto:palmer@sifive=
.com">palmer@sifive.com</a>&gt;; Alistair Francis &lt;<a href=3D"mailto:Ali=
stair.Francis@wdc.com">Alistair.Francis@wdc.com</a>&gt;; Sagar Karandikar &=
lt;<a href=3D"mailto:sagark@eecs.berkeley.edu">sagark@eecs.berkeley.edu</a>=
&gt;; Bastian Koppelmann &lt;<a href=3D"mailto:kbastian@mail.uni-paderborn.=
de">kbastian@mail.uni-paderborn.de</a>&gt;; Atish Patra &lt;<a href=3D"mail=
to:Atish.Patra@wdc.com">Atish.Patra@wdc.com</a>&gt;; <a href=3D"mailto:qemu=
-riscv@nongnu.org">qemu-riscv@nongnu.org</a>; <a href=3D"mailto:qemu-devel@=
nongnu.org">qemu-devel@nongnu.org</a>; Anup Patel &lt;<a href=3D"mailto:anu=
p@brainfault.org">anup@brainfault.org</a>&gt;<br>
Subject: Re: [PATCH v3 1/2] hw: timer: Add Goldfish RTC device<br>
<br>
=C5=AB<br>
<br>
On Tuesday, October 15, 2019, Anup Patel &lt;mailto:<a href=3D"mailto:Anup.=
Patel@wdc.com">Anup.Patel@wdc.com</a>&gt; wrote:<br>
This patch adds model for Google Goldfish virtual platform RTC device.<br>
<br>
We will be adding Goldfish RTC device to the QEMU RISC-V virt machine<br>
for providing real date-time to Guest Linux. The corresponding Linux<br>
driver for Goldfish RTC device is already available in upstream Linux.<br>
<br>
For now, VM migration support is available but untested for Goldfish RTC<br=
>
device. It will be hardened in-future when we implement VM migration for<br=
>
KVM RISC-V.<br>
<br>
Signed-off-by: Anup Patel &lt;mailto:<a href=3D"mailto:anup.patel@wdc.com">=
anup.patel@wdc.com</a>&gt;<br>
---<br>
=C2=A0hw/rtc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/rtc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A01 +<br>
=C2=A0hw/rtc/goldfish_rtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 278 +=
+++++++++++++++++++++++++++++<wbr>++<br>
=C2=A0include/hw/timer/goldfish_<wbr>rtc.h |=C2=A0 46 ++++++<br>
=C2=A04 files changed, 328 insertions(+)<br>
=C2=A0create mode 100644 hw/rtc/goldfish_rtc.c<br>
=C2=A0create mode 100644 include/hw/timer/goldfish_rtc.<wbr>h<br>
<br>
Do you plan to add some other devices from Goldfish platform?<br>
<br>
[Anup] Nopes, we just needed a simple RTC device for RISC-V<br>
[Anup] virt machine hence this patch. <br>
<br>
[Anup] Most of the required devices are already there in<br>
[Anup] the VirtIO spec. The RTC device was missing in<br>
[Anup] VirtIO spec so instead of creating new virtual RTC<br>
[Anup] device we just re-use Goldfish RTC. This help us<br>
[Anup] re-use the Linux Goldfish RTC driver.<br>
<br>
Did you base your code on Android emulator code?<br>
<br>
[Anup] Nopes, the android emulator code seemed too simple<br>
[Anup] and lacking. In fact, the Linux Goldfish RTC driver does<br>
[Anup] much more.<br>
<br>
[Anup] Based on the documentation and Linux Goldfish RTC<br>
[Anup] driver, I wrote it from scratch.<br>
<br></blockquote><div><br></div><div>Ok, that is great, nice work. I just w=
anted to doublecheck if we are OK from the aspect of authorship. &quot;West=
ern Digital&quot; in copyright preamble is certainly fine in this case.</di=
v><div><br></div><div>A.</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
[Anup] I first added Goldfish RTC emulator to Xvisor RISC-V<br>
[Anup] virt machine. Got it working over there and then<br>
[Anup] ported it to QEMU. For qemu emulation, I looked<br>
[Anup] at existing RTC emulators (such as PL031) for QEMU<br>
[Anup] API usage.<br>
<br>
Related to the previous question, are you sure the copyright line should go=
 to Western Digital only?<br>
<br>
[Anup] I thought copyright will be of implementer hence I<br>
[Anup] put Western Digital only. The spec and Linux driver<br>
[Anup] can be written by totally different folks.<br>
<br>
Regards,<br>
Anup<br>
=C2=A0<br>
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig<br>
index 45daa8d655..bafe6ac2c9 100644<br>
--- a/hw/rtc/Kconfig<br>
+++ b/hw/rtc/Kconfig<br>
@@ -21,3 +21,6 @@ config MC146818RTC<br>
<br>
=C2=A0config SUN4V_RTC<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
+<br>
+config GOLDFISH_RTC<br>
+=C2=A0 =C2=A0 bool<br>
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs<br>
index 8dc9fcd3a9..aa208d0d10 100644<br>
--- a/hw/rtc/Makefile.objs<br>
+++ b/hw/rtc/Makefile.objs<br>
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o<br>
=C2=A0obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o<br>
=C2=A0common-obj-$(CONFIG_SUN4V_<wbr>RTC) +=3D sun4v-rtc.o<br>
=C2=A0common-obj-$(CONFIG_ASPEED_<wbr>SOC) +=3D aspeed_rtc.o<br>
+common-obj-$(CONFIG_GOLDFISH_<wbr>RTC) +=3D goldfish_rtc.o<br>
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c<br>
new file mode 100644<br>
index 0000000000..223616ed75<br>
--- /dev/null<br>
+++ b/hw/rtc/goldfish_rtc.c<br>
@@ -0,0 +1,278 @@<br>
+/*<br>
+ * Goldfish virtual platform RTC<br>
+ *<br>
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.<br>
+ *<br>
+ * For more details on Google Goldfish virtual platform refer:<br>
+ * <a href=3D"https://android.googlesource.com/platform/external/qemu/+/ma=
ster/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT" target=3D"_blank">https://android.=
googlesource.<wbr>com/platform/external/qemu/+/<wbr>master/docs/GOLDFISH-VI=
RTUAL-<wbr>HARDWARE.TXT</a><br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;hw/timer/goldfish_rtc.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;qemu/timer.h&quot;<br>
+#include &quot;sysemu/sysemu.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+<br>
+#define RTC_TIME_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>
+#define RTC_TIME_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x04<br>
+#define RTC_ALARM_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
+#define RTC_ALARM_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0c<br>
+#define RTC_IRQ_ENABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
+#define RTC_CLEAR_ALARM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14<br>
+#define RTC_ALARM_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>
+#define RTC_CLEAR_INTERRUPT=C2=A0 =C2=A0 =C2=A00x1c<br>
+<br>
+static void goldfish_rtc_update(<wbr>GoldfishRTCState *s)<br>
+{<br>
+=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, (s-&gt;irq_pending &amp; s-&gt;irq_e=
nabled) ? 1 : 0);<br>
+}<br>
+<br>
+static void goldfish_rtc_interrupt(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;alarm_running =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;irq_pending =3D 1;<br>
+=C2=A0 =C2=A0 goldfish_rtc_update(s);<br>
+}<br>
+<br>
+static uint64_t goldfish_rtc_get_count(<wbr>GoldfishRTCState *s)<br>
+{<br>
+=C2=A0 =C2=A0 return s-&gt;tick_offset + (uint64_t)qemu_clock_get_ns(<wbr>=
rtc_clock);<br>
+}<br>
+<br>
+static void goldfish_rtc_clear_alarm(<wbr>GoldfishRTCState *s)<br>
+{<br>
+=C2=A0 =C2=A0 timer_del(s-&gt;timer);<br>
+=C2=A0 =C2=A0 s-&gt;alarm_running =3D 0;<br>
+}<br>
+<br>
+static void goldfish_rtc_set_alarm(<wbr>GoldfishRTCState *s)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t ticks =3D goldfish_rtc_get_count(s);<br>
+=C2=A0 =C2=A0 uint64_t event =3D s-&gt;alarm_next;<br>
+<br>
+=C2=A0 =C2=A0 if (event &lt;=3D ticks) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goldfish_rtc_clear_alarm(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goldfish_rtc_interrupt(s);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t now =3D qemu_clock_get_ns(rtc_clock);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(s-&gt;timer, now + (event - ticks));=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;alarm_running =3D 1;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;<br>
+=C2=A0 =C2=A0 uint64_t r;<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case RTC_TIME_LOW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D goldfish_rtc_get_count(s) &amp; 0xffffff=
ff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_TIME_HIGH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D goldfish_rtc_get_count(s) &gt;&gt; 32;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_ALARM_LOW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D s-&gt;alarm_next &amp; 0xffffffff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_ALARM_HIGH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D s-&gt;alarm_next &gt;&gt; 32;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_IRQ_ENABLED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D s-&gt;irq_enabled;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_ALARM_STATUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D s-&gt;alarm_running;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;goldfish_rtc_read: Bad offset 0x%x\n&quot;, (int)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return r;<br>
+}<br>
+<br>
+static void goldfish_rtc_write(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t current_tick, new_tick;<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case RTC_TIME_LOW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 current_tick =3D goldfish_rtc_get_count(s);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_tick =3D current_tick &amp; (0xffffffffULL=
 &lt;&lt; 32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_tick |=3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tick_offset +=3D new_tick - current_tick=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_TIME_HIGH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 current_tick =3D goldfish_rtc_get_count(s);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_tick =3D current_tick &amp; 0xffffffffULL;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_tick |=3D (value &lt;&lt; 32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tick_offset +=3D new_tick - current_tick=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_ALARM_LOW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;alarm_next &amp;=3D (0xffffffffULL &lt;&=
lt; 32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;alarm_next |=3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goldfish_rtc_set_alarm(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_ALARM_HIGH:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;alarm_next &amp;=3D 0xffffffffULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;alarm_next |=3D (value &lt;&lt; 32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_IRQ_ENABLED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_enabled =3D (uint32_t)(value &amp; 0=
x1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goldfish_rtc_update(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_CLEAR_ALARM:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goldfish_rtc_clear_alarm(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case RTC_CLEAR_INTERRUPT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq_pending =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goldfish_rtc_update(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;goldfish_rtc_write: Bad offset 0x%x\n&quot;, (int)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static int goldfish_rtc_pre_save(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t delta;<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We want to migrate this offset, which sounds straigh=
tforward.<br>
+=C2=A0 =C2=A0 =C2=A0* Unfortunately, we cannot directly pass tick_offset b=
ecause<br>
+=C2=A0 =C2=A0 =C2=A0* rtc_clock on destinetion Host might not be same sour=
ce Host.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* To tackle, this we pass tick_offset relative to vm_c=
lock from<br>
+=C2=A0 =C2=A0 =C2=A0* source Host and make it relative to rtc_clock at des=
tinetion Host.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 delta =3D qemu_clock_get_ns(rtc_clock) -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_<wb=
r>VIRTUAL);<br>
+=C2=A0 =C2=A0 s-&gt;tick_offset_vmstate =3D s-&gt;tick_offset + delta;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int goldfish_rtc_post_load(void *opaque, int version_id)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t delta;<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We extract tick_offset from tick_offset_vmstate by d=
oing<br>
+=C2=A0 =C2=A0 =C2=A0* reverse math compared to pre_save() function.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 delta =3D qemu_clock_get_ns(rtc_clock) -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_<wb=
r>VIRTUAL);<br>
+=C2=A0 =C2=A0 s-&gt;tick_offset =3D s-&gt;tick_offset_vmstate - delta;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static const MemoryRegionOps goldfish_rtc_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D goldfish_rtc_read,<br>
+=C2=A0 =C2=A0 .write =3D goldfish_rtc_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
+=C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static const VMStateDescription goldfish_rtc_vmstate =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_GOLDFISH_RTC,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .pre_save =3D goldfish_rtc_pre_save,<br>
+=C2=A0 =C2=A0 .post_load =3D goldfish_rtc_post_load,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(tick_offset_<wbr>vmstate, Goldf=
ishRTCState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(alarm_next, GoldfishRTCState),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(alarm_running, GoldfishRTCState=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(irq_pending, GoldfishRTCState),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(irq_enabled, GoldfishRTCState),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static void goldfish_rtc_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D GOLDFISH_RTC(dev);<br>
+=C2=A0 =C2=A0 struct tm tm;<br>
+<br>
+=C2=A0 =C2=A0 timer_del(s-&gt;timer);<br>
+<br>
+=C2=A0 =C2=A0 qemu_get_timedate(&amp;tm, 0);<br>
+=C2=A0 =C2=A0 s-&gt;tick_offset =3D mktimegm(&amp;tm);<br>
+=C2=A0 =C2=A0 s-&gt;tick_offset *=3D NANOSECONDS_PER_SECOND;<br>
+=C2=A0 =C2=A0 s-&gt;tick_offset -=3D qemu_clock_get_ns(rtc_clock);<br>
+=C2=A0 =C2=A0 s-&gt;tick_offset_vmstate =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;alarm_next =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;alarm_running =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;irq_pending =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;irq_enabled =3D 0;<br>
+}<br>
+<br>
+static void goldfish_rtc_realize(<wbr>DeviceState *d, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice *dev =3D SYS_BUS_DEVICE(d);<br>
+=C2=A0 =C2=A0 GoldfishRTCState *s =3D GOLDFISH_RTC(d);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;<wbr>iomem, OBJECT(s), &amp=
;goldfish_rtc_ops, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;goldfish_rtc&quot;, 0x1000);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(dev, &amp;s-&gt;iomem);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_init_irq(dev, &amp;s-&gt;irq);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;timer =3D timer_new_ns(rtc_clock, goldfish_rtc_interru=
pt, s);<br>
+}<br>
+<br>
+static void goldfish_rtc_class_init(<wbr>ObjectClass *klass, void *data)<b=
r>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D goldfish_rtc_realize;<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D goldfish_rtc_reset;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;goldfish_rtc_vmstate;<br>
+}<br>
+<br>
+static const TypeInfo goldfish_rtc_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_GOLDFISH_RT=
C,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(GoldfishRTCState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D goldfish_rtc_class_init,<br>
+};<br>
+<br>
+static void goldfish_rtc_register_types(<wbr>void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;<wbr>goldfish_rtc_info);<br>
+}<br>
+<br>
+type_init(goldfish_rtc_<wbr>register_types)<br>
diff --git a/include/hw/timer/goldfish_<wbr>rtc.h b/include/hw/timer/goldfi=
sh_<wbr>rtc.h<br>
new file mode 100644<br>
index 0000000000..dfb6d70b86<br>
--- /dev/null<br>
+++ b/include/hw/timer/goldfish_<wbr>rtc.h<br>
@@ -0,0 +1,46 @@<br>
+/*<br>
+ * Goldfish virtual platform RTC<br>
+ *<br>
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.<br>
+ *<br>
+ * For more details on Google Goldfish virtual platform refer:<br>
+ * <a href=3D"https://android.googlesource.com/platform/external/qemu/+/ma=
ster/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT" target=3D"_blank">https://android.=
googlesource.<wbr>com/platform/external/qemu/+/<wbr>master/docs/GOLDFISH-VI=
RTUAL-<wbr>HARDWARE.TXT</a><br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wbr>.<br>
+ */<br>
+<br>
+#ifndef HW_TIMER_GOLDFISH_RTC_H<br>
+#define HW_TIMER_GOLDFISH_RTC_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+<br>
+#define TYPE_GOLDFISH_RTC &quot;goldfish_rtc&quot;<br>
+#define GOLDFISH_RTC(obj) \<br>
+OBJECT_CHECK(<wbr>GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)<br>
+<br>
+typedef struct GoldfishRTCState {<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 MemoryRegion iomem;<br>
+=C2=A0 =C2=A0 QEMUTimer *timer;<br>
+=C2=A0 =C2=A0 qemu_irq irq;<br>
+<br>
+=C2=A0 =C2=A0 uint64_t tick_offset;<br>
+=C2=A0 =C2=A0 uint64_t tick_offset_vmstate;<br>
+=C2=A0 =C2=A0 uint64_t alarm_next;<br>
+=C2=A0 =C2=A0 uint32_t alarm_running;<br>
+=C2=A0 =C2=A0 uint32_t irq_pending;<br>
+=C2=A0 =C2=A0 uint32_t irq_enabled;<br>
+} GoldfishRTCState;<br>
+<br>
+#endif<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--00000000000091e95e05953d7798--

