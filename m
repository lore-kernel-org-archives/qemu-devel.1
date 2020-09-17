Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942DC43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 23:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FC02075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 23:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIndcRJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FC02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ2w8-0008PQ-Fx
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 19:03:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kJ2pN-0006Oi-9j
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 18:56:33 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kJ2p3-0003GO-H6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 18:56:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id l126so2171028pfd.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=QTcRwR1ABFsPtjZtCqrIza1ZzMq+J1Zo8suN5etIKv8=;
 b=LIndcRJOs1mH2H0S6wWs15jLrXWnz8LBtx5i8NdPbLrDG+XaQgp5b3OM5ouw74q4+s
 IJaalP+G1h2grqFMojFI8zMiTJbKtGmazFgLZ5tqbLEH81nLMZLdWHLqzdyOXVd48Tio
 g4Sr2YGtEOOkqfpky7CbYXuADfVQEH7LIaPbG+HuvhjKU+6FLcgwQfLYeQt8mJSb9bHV
 gDQrLGWxv+Va1WS3lGcPelPuTsL84NpC6VmMJOw7JmGGWkQxt7By3O+utz8xP0yTJSRw
 7sHrbPbWK94N+K7mVHOp9cWeGHDp8J0C1WoBBoBgsLZxIoRcrmTG+gDNgwtn7/QwnQ1A
 d5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=QTcRwR1ABFsPtjZtCqrIza1ZzMq+J1Zo8suN5etIKv8=;
 b=Pb6rOcQy8UDWooLrzZVCKqrshuW/lEWVXOAFVqwn8deLqqd6Fkriai1uI1qYLSJx23
 HXyGsFDqIav+8XGISgqudh99hgOhz6v56KrBrM4k4INinO/nVetCo1V6lgHkeVgPuvt1
 Ac5tPDIcBdCPGkyH4o2yXPnhC0mkbQZuCNYCNlD1ZsmiTgAOSWdFJUsKj8ekkmi5ctyV
 Z6Kn9+7ziEWiKWCBuqub4WIoRypjT7JG0xK9IY78+G/wJjsyWnKW6QAKHU3wKBkgWtpA
 A5lqYudm3c/AeNWqiL+f9xYgKBr0cTLpiYguqQrRPeSIXhN4SBviu6ODNyQw+qg8OFvf
 fcCQ==
X-Gm-Message-State: AOAM53014U6fq9Qe1o1bwTsztnld0vepbHabc6n57PWPhArQP1JOSufA
 olBqeHPS6oRCj8wknBJNOZX0eMXKZpnqX6Gm
X-Google-Smtp-Source: ABdhPJyDVM6fksJCNsEr3S+QQCi1RCIeTG88KJhnPPGlJpU+n0/CP0Ad5GUX0Ux25z3Kouc1hZBvZA==
X-Received: by 2002:a0c:ec87:: with SMTP id u7mr14187418qvo.50.1600379501553; 
 Thu, 17 Sep 2020 14:51:41 -0700 (PDT)
Received: from master ([2607:fea8:e2a0:e950::661])
 by smtp.gmail.com with ESMTPSA id f64sm757486qkj.124.2020.09.17.14.51.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Sep 2020 14:51:41 -0700 (PDT)
Date: Thu, 17 Sep 2020 17:51:33 -0400
From: Shashi Mallela <shashi.mallela@linaro.org>
To: Graeme Gregory <graeme@nuviainc.com>
Message-ID: <28E5F544-3707-420F-8082-70E07C331683@getmailspring.com>
In-Reply-To: <20200917213702.hrldjbvhaig6ooul@xora-sinquacker>
References: <20200917213702.hrldjbvhaig6ooul@xora-sinquacker>
Subject: Re: [EXTERNAL] [PATCH] hw/watchdog: Implement generic watchdog
 device model as per ARM BSAv0.9 hw/arm/sbsa-ref : Include SBSA watchdog
 device in sbsa-ref platform
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f63da65_4b80a9c7_2084"
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=shashi.mallela@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Cc: "=?utf-8?Q?peter.maydell=40linaro.org?=" <peter.maydell@linaro.org>,
 "=?utf-8?Q?leif=40nuviainc.com?=" <leif@nuviainc.com>,
 "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>,
 "=?utf-8?Q?qemu-arm=40nongnu.org?=" <qemu-arm@nongnu.org>,
 "=?utf-8?Q?rad=40semihalf.com?=" <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f63da65_4b80a9c7_2084
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Graeme,

In the generated patch file ,there is subject description (as below)before the "Signed-off-by: " line.Not sure why it doesn't show up in the mail.
Subject: [PATCH] hw/watchdog: Implement generic watchdog device model as per
ARM BSAv0.9 hw/arm/sbsa-ref : Include SBSA watchdog device in sbsa-ref
platform

I do not have link to updated ACPI tables.
Thanks
Shashi

Sent from Mailspring (https://link.getmailspring.com/link/28E5F544-3707-420F-8082-70E07C331683@getmailspring.com/0?redirect=https%3A%2F%2Fgetmailspring.com%2F&recipient=cWVtdS1kZXZlbEBub25nbnUub3Jn), the best free email app for work
On Sep 17 2020, at 5:37 pm, Graeme Gregory <graeme@nuviainc.com> wrote:
> Something still seems to have gone wrong with subject, and description
> of patch is missing? Missed blank line between 1st line and description?
>
> Do you have the link to updated ACPI tables for testing out of interest?
> On Thu, Sep 17, 2020 at 02:12:45PM -0400, Shashi Mallela wrote:
> > Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
> > ---
> > hw/arm/Kconfig | 1 +
> > hw/arm/sbsa-ref.c | 23 ++
> > hw/watchdog/Kconfig | 4 +
> > hw/watchdog/meson.build | 1 +
> > hw/watchdog/wdt_sbsa_gwdt.c | 343 ++++++++++++++++++++++++++++
> > include/hw/watchdog/wdt_sbsa_gwdt.h | 68 ++++++
> > 6 files changed, 440 insertions(+)
> > create mode 100644 hw/watchdog/wdt_sbsa_gwdt.c
> > create mode 100644 include/hw/watchdog/wdt_sbsa_gwdt.h
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index f303c6bead25..6b97e64595d3 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -210,6 +210,7 @@ config SBSA_REF
> > select PL031 # RTC
> > select PL061 # GPIO
> > select USB_EHCI_SYSBUS
> > + select WDT_SBSA_GWDT
> >
> > config SABRELITE
> > bool
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index ac68b4640d0d..652079a12e37 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -40,6 +40,7 @@
> > #include "hw/qdev-properties.h"
> > #include "hw/usb.h"
> > #include "hw/char/pl011.h"
> > +#include "hw/watchdog/wdt_sbsa_gwdt.h"
> > #include "net/net.h"
> > #include "qom/object.h"
> >
> > @@ -64,6 +65,9 @@ enum {
> > SBSA_GIC_DIST,
> > SBSA_GIC_REDIST,
> > SBSA_SECURE_EC,
> > + SBSA_GWDT,
> > + SBSA_GWDT_REFRESH,
> > + SBSA_GWDT_CONTROL,
> > SBSA_SMMU,
> > SBSA_UART,
> > SBSA_RTC,
> > @@ -111,6 +115,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
> > [SBSA_GIC_DIST] = { 0x40060000, 0x00010000 },
> > [SBSA_GIC_REDIST] = { 0x40080000, 0x04000000 },
> > [SBSA_SECURE_EC] = { 0x50000000, 0x00001000 },
> > + [SBSA_GWDT_REFRESH] = { 0x50010000, 0x00001000 },
> > + [SBSA_GWDT_CONTROL] = { 0x50011000, 0x00001000 },
> > [SBSA_UART] = { 0x60000000, 0x00001000 },
> > [SBSA_RTC] = { 0x60010000, 0x00001000 },
> > [SBSA_GPIO] = { 0x60020000, 0x00001000 },
> > @@ -140,6 +146,7 @@ static const int sbsa_ref_irqmap[] = {
> > [SBSA_SECURE_UART_MM] = 9,
> > [SBSA_AHCI] = 10,
> > [SBSA_EHCI] = 11,
> > + [SBSA_GWDT] = 12,
> > };
> >
> > static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> > @@ -454,6 +461,20 @@ static void create_rtc(const SBSAMachineState *sms)
> > sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
> > }
> >
> > +static void create_wdt(const SBSAMachineState *sms)
> > +{
> > + hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> > + hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> > + DeviceState *dev = qdev_new(TYPE_WDT_SBSA_GWDT);
> > + SysBusDevice *s = SYS_BUS_DEVICE(dev);
> > + int irq = sbsa_ref_irqmap[SBSA_GWDT];
> > +
> > + sysbus_realize_and_unref(s, &error_fatal);
> > + sysbus_mmio_map(s, 0, rbase);
> > + sysbus_mmio_map(s, 1, cbase);
> > + sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
> > +}
> > +
> > static DeviceState *gpio_key_dev;
> > static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
> > {
> > @@ -737,6 +758,8 @@ static void sbsa_ref_init(MachineState *machine)
> >
> > create_rtc(sms);
> >
> > + create_wdt(sms);
> > +
> > create_gpio(sms);
> >
> > create_ahci(sms);
> > diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
> > index 293209b291d6..94ac0d5b76b1 100644
> > --- a/hw/watchdog/Kconfig
> > +++ b/hw/watchdog/Kconfig
> > @@ -17,3 +17,7 @@ config WDT_DIAG288
> >
> > config WDT_IMX2
> > bool
> > +
> > +config WDT_SBSA_GWDT
> > + bool
> > + default y if SBSA_REF
> > \ No newline at end of file
> > diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
> > index 9b8725e64288..a9a23307acfe 100644
> > --- a/hw/watchdog/meson.build
> > +++ b/hw/watchdog/meson.build
> > @@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
> > softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
> > softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
> > softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
> > +softmmu_ss.add(when: 'CONFIG_WDT_SBSA_GWDT', if_true: files('wdt_sbsa_gwdt.c'))
> > diff --git a/hw/watchdog/wdt_sbsa_gwdt.c b/hw/watchdog/wdt_sbsa_gwdt.c
> > new file mode 100644
> > index 000000000000..eb3be0862cf1
> > --- /dev/null
> > +++ b/hw/watchdog/wdt_sbsa_gwdt.c
> > @@ -0,0 +1,343 @@
> > +/*
> > + * Generic watchdog device model for SBSA
> > + *
> > + * Copyright Linaro.org 2020
> > + *
> > + * Authors:
> > + * Shashi Mallela <shashi.mallela@linaro.org>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> > + * option) any later version. See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "sysemu/reset.h"
> > +#include "sysemu/watchdog.h"
> > +#include "hw/watchdog/wdt_sbsa_gwdt.h"
> > +#include "qemu/timer.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +
> > +static WatchdogTimerModel model = {
> > + .wdt_name = TYPE_WDT_SBSA_GWDT,
> > + .wdt_description = "sbsa_gwdt device for sbsa_ref platform",
> > +};
> > +
> > +static const VMStateDescription vmstate_sbsa_gwdt = {
> > + .name = "vmstate_sbsa_gwdt",
> > + .version_id = 1,
> > + .minimum_version_id = 1,
> > + .fields = (VMStateField[]) {
> > + VMSTATE_TIMER_PTR(timer, SBSA_GWDTState),
> > + VMSTATE_BOOL(enabled, SBSA_GWDTState),
> > + VMSTATE_BOOL(ws0, SBSA_GWDTState),
> > + VMSTATE_BOOL(ws1, SBSA_GWDTState),
> > + VMSTATE_UINT32(wrr, SBSA_GWDTState),
> > + VMSTATE_UINT32(wcs, SBSA_GWDTState),
> > + VMSTATE_UINT32(worl, SBSA_GWDTState),
> > + VMSTATE_UINT32(woru, SBSA_GWDTState),
> > + VMSTATE_UINT32(wcvl, SBSA_GWDTState),
> > + VMSTATE_UINT32(wcvu, SBSA_GWDTState),
> > + VMSTATE_END_OF_LIST()
> > + }
> > +};
> > +
> > +static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
> > +{
> > + uint32_t ret;
> > +
> > + if (addr == SBSA_GWDT_WRR) {
> > + /* watch refresh read has no effect and returns 0 */
> > + ret = 0;
> > + } else {
> > + fprintf(stderr, "bad address in refresh frame read : 0x%x\n",
> > + (int)addr);
>
> I suspect this and the other fprintf's should be using the
> qemu_log_mask(LOG_GUEST_ERROR, ... API
>
> Graeme
> > + }
> > + return ret;
> > +}
> > +
> > +static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
> > +{
> > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
> > + uint32_t ret = 0;
> > +
> > + switch (addr) {
> > + case SBSA_GWDT_WCS:
> > + ret = s->wcs;
> > + break;
> > + case SBSA_GWDT_WOR:
> > + ret = s->worl;
> > + break;
> > + case SBSA_GWDT_WORU:
> > + ret = s->woru;
> > + break;
> > + case SBSA_GWDT_WCV:
> > + ret = s->wcvl;
> > + break;
> > + case SBSA_GWDT_WCVU:
> > + ret = s->wcvu;
> > + break;
> > + case SBSA_GWDT_W_IIDR:
> > + ret = s->id;
> > + break;
> > + default:
> > + fprintf(stderr, "bad address in control frame read : 0x%x\n",
> > + (int)addr);
> > + }
> > + return ret;
> > +}
> > +
> > +static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, bool refresh,
> > + bool expired)
> > +{
> > + uint64_t timeout = 0;
> > +
> > + if (s->enabled) {
> > + if ((refresh) || (expired && !s->ws0)) {
> > + /*
> > + * Extract the upper 16 bits from woru & 32 bits from worl
> > + * registers to construct the 48 bit offset value
> > + */
> > + timeout = s->woru & SBSA_GWDT_WOR_MASK;
> > + timeout <<= 32;
> > + timeout |= s->worl;
> > + timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +
> > + /* store the current timeout value into compare registers */
> > + s->wcvu = timeout >> 32;
> > + s->wcvl = timeout;
> > + } else {
> > + timeout = s->wcvu;
> > + timeout <<= 32;
> > + timeout |= s->wcvl;
> > + }
> > +
> > + if (!s->ws0) {
> > + timer_del(s->timer);
> > + timer_mod(s->ptimer,
> > + timeout * NANOSECONDS_PER_SECOND);
> > + } else {
> > + timer_del(s->ptimer);
> > + timer_mod(s->timer,
> > + timeout * NANOSECONDS_PER_SECOND);
> > + }
> > + } else {
> > + timer_del(s->ptimer);
> > + timer_del(s->timer);
> > + }
> > +}
> > +
> > +static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
> > + unsigned size) {
> > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
> > +
> > + if (offset == SBSA_GWDT_WRR) {
> > + s->wrr = data;
> > + s->wcs &= ~SBSA_GWDT_WCS_WS0;
> > + s->wcs &= ~SBSA_GWDT_WCS_WS1;
> > + s->ws0 = false;
> > + s->ws1 = false;
> > + sbsa_gwdt_update_timer(s, true , false);
> > + } else {
> > + fprintf(stderr, "bad address in refresh frame write : 0x%x\n",
> > + (int)offset);
> > + }
> > +}
> > +
> > +static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
> > + unsigned size) {
> > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
> > + bool enable;
> > +
> > + switch (offset) {
> > + case SBSA_GWDT_WCS:
> > + enable = data & SBSA_GWDT_WCS_EN;
> > + if (enable) {
> > + s->wcs |= SBSA_GWDT_WCS_EN;
> > + s->enabled = true;
> > + } else {
> > + s->wcs &= ~SBSA_GWDT_WCS_EN;
> > + s->enabled = false;
> > + s->ws0 = false;
> > + s->ws1 = false;
> > + }
> > + sbsa_gwdt_update_timer(s, false, false);
> > + break;
> > +
> > + case SBSA_GWDT_WOR:
> > + s->worl = data;
> > + /*
> > + * TODO:- setting woru to 0 and triggering update timer(below) is a
> > + * temporary workaround to handle current linux driver which is
> > + * based on earlier version of BSA specification.Once the linux
> > + * driver is updated to BSA v0.9 will remove these next 2 lines.
> > + */
> > + s->woru = 0;
> > + sbsa_gwdt_update_timer(s, true , false);
> > + break;
> > +
> > + case SBSA_GWDT_WORU:
> > + s->woru = data;
> > + sbsa_gwdt_update_timer(s, true , false);
> > + break;
> > +
> > + case SBSA_GWDT_WCV:
> > + s->wcvl = data;
> > + break;
> > +
> > + case SBSA_GWDT_WCVU:
> > + s->wcvu = data;
> > + break;
> > +
> > + default:
> > + fprintf(stderr, "bad address in control frame write : 0x%x\n",
> > + (int)offset);
> > + }
> > + return;
> > +}
> > +
> > +static void wdt_sbsa_gwdt_reset(DeviceState *dev)
> > +{
> > + SBSA_GWDTState *s = SBSA_GWDT(dev);
> > +
> > + timer_del(s->ptimer);
> > + timer_del(s->timer);
> > +
> > + s->enabled = false;
> > + s->ws0 = false;
> > + s->ws1 = false;
> > + s->wcs &= ~SBSA_GWDT_WCS_EN;
> > + s->wcs &= ~SBSA_GWDT_WCS_WS0;
> > + s->wcs &= ~SBSA_GWDT_WCS_WS1;
> > + s->wcvl = 0;
> > + s->wcvu = 0;
> > + s->worl = 0;
> > + s->woru = 0;
> > + s->id = SBSA_GWDT_ID;
> > +}
> > +
> > +static void sbsa_gwdt_reset(void *opaque)
> > +{
> > + DeviceState *sbsa_gwdt = opaque;
> > +
> > + wdt_sbsa_gwdt_reset(sbsa_gwdt);
> > +}
> > +
> > +static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
> > +{
> > + SBSA_GWDTState *s = SBSA_GWDT(opaque);
> > +
> > + s->wcs |= SBSA_GWDT_WCS_WS0;
> > + s->ws0 = true;
> > + qemu_set_irq(s->irq, 1);
> > + sbsa_gwdt_update_timer(s, false, true);
> > +}
> > +
> > +static void sbsa_gwdt_timer_sysreset(void *dev)
> > +{
> > + SBSA_GWDTState *s = SBSA_GWDT(dev);
> > + s->wcs |= SBSA_GWDT_WCS_WS1;
> > + s->ws1 = true;
> > + qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
> > + /*
> > + * Reset the watchdog only if the guest gets notified about
> > + * expiry. watchdog_perform_action() may temporarily relinquish
> > + * the BQL; reset before triggering the action to avoid races with
> > + * sbsa_gwdt instructions.
> > + */
> > + switch (get_watchdog_action()) {
> > + case WATCHDOG_ACTION_DEBUG:
> > + case WATCHDOG_ACTION_NONE:
> > + case WATCHDOG_ACTION_PAUSE:
> > + break;
> > + default:
> > + wdt_sbsa_gwdt_reset(dev);
> > + }
> > + watchdog_perform_action();
> > +}
> > +
> > +static const MemoryRegionOps sbsa_gwdt_rops = {
> > + .read = sbsa_gwdt_rread,
> > + .write = sbsa_gwdt_rwrite,
> > + .endianness = DEVICE_LITTLE_ENDIAN,
> > + .valid.min_access_size = 4,
> > + .valid.max_access_size = 4,
> > + .valid.unaligned = false,
> > +};
> > +
> > +static const MemoryRegionOps sbsa_gwdt_ops = {
> > + .read = sbsa_gwdt_read,
> > + .write = sbsa_gwdt_write,
> > + .endianness = DEVICE_LITTLE_ENDIAN,
> > + .valid.min_access_size = 4,
> > + .valid.max_access_size = 4,
> > + .valid.unaligned = false,
> > +};
> > +
> > +static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
> > +{
> > + SBSA_GWDTState *s = SBSA_GWDT(dev);
> > + SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > +
> > + memory_region_init_io(&s->rmmio, OBJECT(dev),
> > + &sbsa_gwdt_rops, s,
> > + "sbsa_gwdt.refresh",
> > + SBSA_GWDT_RMMIO_SIZE);
> > +
> > + memory_region_init_io(&s->cmmio, OBJECT(dev),
> > + &sbsa_gwdt_ops, s,
> > + "sbsa_gwdt.control",
> > + SBSA_GWDT_CMMIO_SIZE);
> > +
> > + sysbus_init_mmio(sbd, &s->rmmio);
> > + sysbus_init_mmio(sbd, &s->cmmio);
> > +
> > + sysbus_init_irq(sbd, &s->irq);
> > +
> > + qemu_register_reset(sbsa_gwdt_reset, s);
> > +
> > + s->ptimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
> > + dev);
> > + s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysreset,
> > + dev);
> > +}
> > +
> > +static void wdt_sbsa_gwdt_unrealize(DeviceState *dev)
> > +{
> > + SBSA_GWDTState *s = SBSA_GWDT(dev);
> > +
> > + timer_del(s->ptimer);
> > + timer_free(s->ptimer);
> > +
> > + timer_del(s->timer);
> > + timer_free(s->timer);
> > +}
> > +
> > +static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, void *data)
> > +{
> > + DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > + dc->realize = wdt_sbsa_gwdt_realize;
> > + dc->unrealize = wdt_sbsa_gwdt_unrealize;
> > + dc->reset = wdt_sbsa_gwdt_reset;
> > + dc->hotpluggable = false;
> > + set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > + dc->vmsd = &vmstate_sbsa_gwdt;
> > +}
> > +
> > +static const TypeInfo wdt_sbsa_gwdt_info = {
> > + .class_init = wdt_sbsa_gwdt_class_init,
> > + .parent = TYPE_SYS_BUS_DEVICE,
> > + .name = TYPE_WDT_SBSA_GWDT,
> > + .instance_size = sizeof(SBSA_GWDTState),
> > +};
> > +
> > +static void wdt_sbsa_gwdt_register_types(void)
> > +{
> > + watchdog_add_model(&model);
> > + type_register_static(&wdt_sbsa_gwdt_info);
> > +}
> > +
> > +type_init(wdt_sbsa_gwdt_register_types)
> > diff --git a/include/hw/watchdog/wdt_sbsa_gwdt.h b/include/hw/watchdog/wdt_sbsa_gwdt.h
> > new file mode 100644
> > index 000000000000..8044646fa62d
> > --- /dev/null
> > +++ b/include/hw/watchdog/wdt_sbsa_gwdt.h
> > @@ -0,0 +1,68 @@
> > +#ifndef WDT_SBSA_GWDT_H
> > +#define WDT_SBSA_GWDT_H
> > +
> > +#include "qemu/bitops.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/irq.h"
> > +
> > +#define TYPE_WDT_SBSA_GWDT "sbsa_gwdt"
> > +#define SBSA_GWDT(obj) \
> > + OBJECT_CHECK(SBSA_GWDTState, (obj), TYPE_WDT_SBSA_GWDT)
> > +#define SBSA_GWDT_CLASS(klass) \
> > + OBJECT_CLASS_CHECK(SBSA_GWDTClass, (klass), TYPE_WDT_SBSA_GWDT)
> > +#define SBSA_GWDT_GET_CLASS(obj) \
> > + OBJECT_GET_CLASS(SBSA_GWDTClass, (obj), TYPE_WDT_SBSA_GWDT)
> > +
> > +/* SBSA Generic Watchdog register definitions */
> > +/* refresh frame */
> > +#define SBSA_GWDT_WRR 0x000
> > +
> > +/* control frame */
> > +#define SBSA_GWDT_WCS 0x000
> > +#define SBSA_GWDT_WOR 0x008
> > +#define SBSA_GWDT_WORU 0x00C
> > +#define SBSA_GWDT_WCV 0x010
> > +#define SBSA_GWDT_WCVU 0x014
> > +
> > +/* Watchdog Interface Identification Register */
> > +#define SBSA_GWDT_W_IIDR 0xFCC
> > +
> > +/* Watchdog Control and Status Register Bits */
> > +#define SBSA_GWDT_WCS_EN BIT(0)
> > +#define SBSA_GWDT_WCS_WS0 BIT(1)
> > +#define SBSA_GWDT_WCS_WS1 BIT(2)
> > +
> > +#define SBSA_GWDT_WOR_MASK 0x0000FFFF
> > +
> > +/* Watchdog Interface Identification Register definition*/
> > +#define SBSA_GWDT_ID 0x1043B
> > +
> > +/* 2 Separate memory regions for each of refresh & control register frames */
> > +#define SBSA_GWDT_RMMIO_SIZE 0x1000
> > +#define SBSA_GWDT_CMMIO_SIZE 0x1000
> > +
> > +typedef struct SBSA_GWDTState {
> > + /* <private> */
> > + SysBusDevice parent_obj;
> > +
> > + /*< public >*/
> > + MemoryRegion rmmio;
> > + MemoryRegion cmmio;
> > + qemu_irq irq;
> > +
> > + QEMUTimer *ptimer, *timer;
> > +
> > + uint32_t id;
> > + uint32_t wrr;
> > + uint32_t wcs;
> > + uint32_t worl;
> > + uint32_t woru;
> > + uint32_t wcvl;
> > + uint32_t wcvu;
> > + bool enabled;
> > + bool ws0, ws1;
> > +
> > + /*< public >*/
> > +} SBSA_GWDTState;
> > +
> > +#endif /* WDT_SBSA_GWDT_H */
> > --
> > 2.18.4
> >
> >
>


--5f63da65_4b80a9c7_2084
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Graeme,</div><br><div>In the generated patch file ,there is subje=
ct description (as below)before the =22Signed-off-by: =22 line.Not sure w=
hy it doesn't show up in the mail.</div><br><div><span style=3D=22color:=23=
f44e3b=22><strong>Subject: =5BPATCH=5D hw/watchdog: Implement generic wat=
chdog device model as per</strong></span></div><div><span style=3D=22colo=
r:=23f44e3b=22><strong>&nbsp;ARM BSAv0.9 hw/arm/sbsa-ref : Include SBSA w=
atchdog device in sbsa-ref</strong></span></div><div><span style=3D=22col=
or:=23f44e3b=22><strong>&nbsp;platform</strong></span></div><br><div>I do=
 not have link to updated ACPI tables.</div><br><div>Thanks</div><div>Sha=
shi</div><br><div><signature id=3D=22initial=22><div><div>Sent from <a hr=
ef=3D=22https://link.getmailspring.com/link/28E5=46544-3707-420=46-8082-7=
0E07C331683=40getmailspring.com/0=3Fredirect=3Dhttps%3A%2=46%2=46getmails=
pring.com%2=46&amp;recipient=3DcWVtdS1kZXZlbEBub25nbnUub3Jn=22>Mailspring=
</a>, the best free email app for work</div></div></signature></div><div =
class=3D=22gmail=5Fquote=5Fattribution=22>On Sep 17 2020, at 5:37 pm, Gra=
eme Gregory &lt;graeme=40nuviainc.com&gt; wrote:</div><blockquote><div><d=
iv>Something still seems to have gone wrong with subject, and description=
</div><div>of patch is missing=3F Missed blank line between 1st line and =
description=3F</div><br><div>Do you have the link to updated ACPI tables =
for testing out of interest=3F</div><br><div>On Thu, Sep 17, 2020 at 02:1=
2:45PM -0400, Shashi Mallela wrote:</div><div>&gt; Signed-off-by: Shashi =
Mallela &lt;shashi.mallela=40linaro.org&gt;</div><div>&gt; ---</div><div>=
&gt; hw/arm/Kconfig =7C 1 +</div><div>&gt; hw/arm/sbsa-ref.c =7C 23 ++</d=
iv><div>&gt; hw/watchdog/Kconfig =7C 4 +</div><div>&gt; hw/watchdog/meson=
.build =7C 1 +</div><div>&gt; hw/watchdog/wdt=5Fsbsa=5Fgwdt.c =7C 343 +++=
+++++++++++++++++++++++++</div><div>&gt; include/hw/watchdog/wdt=5Fsbsa=5F=
gwdt.h =7C 68 ++++++</div><div>&gt; 6 files changed, 440 insertions(+)</d=
iv><div>&gt; create mode 100644 hw/watchdog/wdt=5Fsbsa=5Fgwdt.c</div><div=
>&gt; create mode 100644 include/hw/watchdog/wdt=5Fsbsa=5Fgwdt.h</div><di=
v>&gt;</div><div>&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig</div><=
div>&gt; index f303c6bead25..6b97e64595d3 100644</div><div>&gt; --- a/hw/=
arm/Kconfig</div><div>&gt; +++ b/hw/arm/Kconfig</div><div>&gt; =40=40 -21=
0,6 +210,7 =40=40 config SBSA=5FRE=46</div><div>&gt; select PL031 =23 RTC=
</div><div>&gt; select PL061 =23 GPIO</div><div>&gt; select USB=5FEHCI=5F=
SYSBUS</div><div>&gt; + select WDT=5FSBSA=5FGWDT</div><div>&gt;</div><div=
>&gt; config SABRELITE</div><div>&gt; bool</div><div>&gt; diff --git a/hw=
/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c</div><div>&gt; index ac68b4640d0d..65=
2079a12e37 100644</div><div>&gt; --- a/hw/arm/sbsa-ref.c</div><div>&gt; +=
++ b/hw/arm/sbsa-ref.c</div><div>&gt; =40=40 -40,6 +40,7 =40=40</div><div=
>&gt; =23include =22hw/qdev-properties.h=22</div><div>&gt; =23include =22=
hw/usb.h=22</div><div>&gt; =23include =22hw/char/pl011.h=22</div><div>&gt=
; +=23include =22hw/watchdog/wdt=5Fsbsa=5Fgwdt.h=22</div><div>&gt; =23inc=
lude =22net/net.h=22</div><div>&gt; =23include =22qom/object.h=22</div><d=
iv>&gt;</div><div>&gt; =40=40 -64,6 +65,9 =40=40 enum =7B</div><div>&gt; =
SBSA=5FGIC=5FDIST,</div><div>&gt; SBSA=5FGIC=5FREDIST,</div><div>&gt; SBS=
A=5FSECURE=5FEC,</div><div>&gt; + SBSA=5FGWDT,</div><div>&gt; + SBSA=5FGW=
DT=5FRE=46RESH,</div><div>&gt; + SBSA=5FGWDT=5FCONTROL,</div><div>&gt; SB=
SA=5FSMMU,</div><div>&gt; SBSA=5FUART,</div><div>&gt; SBSA=5FRTC,</div><d=
iv>&gt; =40=40 -111,6 +115,8 =40=40 static const MemMapEntry sbsa=5Fref=5F=
memmap=5B=5D =3D =7B</div><div>&gt; =5BSBSA=5FGIC=5FDIST=5D =3D =7B 0x400=
60000, 0x00010000 =7D,</div><div>&gt; =5BSBSA=5FGIC=5FREDIST=5D =3D =7B 0=
x40080000, 0x04000000 =7D,</div><div>&gt; =5BSBSA=5FSECURE=5FEC=5D =3D =7B=
 0x50000000, 0x00001000 =7D,</div><div>&gt; + =5BSBSA=5FGWDT=5FRE=46RESH=5D=
 =3D =7B 0x50010000, 0x00001000 =7D,</div><div>&gt; + =5BSBSA=5FGWDT=5FCO=
NTROL=5D =3D =7B 0x50011000, 0x00001000 =7D,</div><div>&gt; =5BSBSA=5FUAR=
T=5D =3D =7B 0x60000000, 0x00001000 =7D,</div><div>&gt; =5BSBSA=5FRTC=5D =
=3D =7B 0x60010000, 0x00001000 =7D,</div><div>&gt; =5BSBSA=5FGPIO=5D =3D =
=7B 0x60020000, 0x00001000 =7D,</div><div>&gt; =40=40 -140,6 +146,7 =40=40=
 static const int sbsa=5Fref=5Firqmap=5B=5D =3D =7B</div><div>&gt; =5BSBS=
A=5FSECURE=5FUART=5FMM=5D =3D 9,</div><div>&gt; =5BSBSA=5FAHCI=5D =3D 10,=
</div><div>&gt; =5BSBSA=5FEHCI=5D =3D 11,</div><div>&gt; + =5BSBSA=5FGWDT=
=5D =3D 12,</div><div>&gt; =7D;</div><div>&gt;</div><div>&gt; static uint=
64=5Ft sbsa=5Fref=5Fcpu=5Fmp=5Faffinity(SBSAMachineState *sms, int idx)</=
div><div>&gt; =40=40 -454,6 +461,20 =40=40 static void create=5Frtc(const=
 SBSAMachineState *sms)</div><div>&gt; sysbus=5Fcreate=5Fsimple(=22pl031=22=
, base, qdev=5Fget=5Fgpio=5Fin(sms-&gt;gic, irq));</div><div>&gt; =7D</di=
v><div>&gt;</div><div>&gt; +static void create=5Fwdt(const SBSAMachineSta=
te *sms)</div><div>&gt; +=7B</div><div>&gt; + hwaddr rbase =3D sbsa=5Fref=
=5Fmemmap=5BSBSA=5FGWDT=5FRE=46RESH=5D.base;</div><div>&gt; + hwaddr cbas=
e =3D sbsa=5Fref=5Fmemmap=5BSBSA=5FGWDT=5FCONTROL=5D.base;</div><div>&gt;=
 + DeviceState *dev =3D qdev=5Fnew(TYPE=5FWDT=5FSBSA=5FGWDT);</div><div>&=
gt; + SysBusDevice *s =3D SYS=5FBUS=5FDEVICE(dev);</div><div>&gt; + int i=
rq =3D sbsa=5Fref=5Firqmap=5BSBSA=5FGWDT=5D;</div><div>&gt; +</div><div>&=
gt; + sysbus=5Frealize=5Fand=5Funref(s, &amp;error=5Ffatal);</div><div>&g=
t; + sysbus=5Fmmio=5Fmap(s, 0, rbase);</div><div>&gt; + sysbus=5Fmmio=5Fm=
ap(s, 1, cbase);</div><div>&gt; + sysbus=5Fconnect=5Firq(s, 0, qdev=5Fget=
=5Fgpio=5Fin(sms-&gt;gic, irq));</div><div>&gt; +=7D</div><div>&gt; +</di=
v><div>&gt; static DeviceState *gpio=5Fkey=5Fdev;</div><div>&gt; static v=
oid sbsa=5Fref=5Fpowerdown=5Freq(Notifier *n, void *opaque)</div><div>&gt=
; =7B</div><div>&gt; =40=40 -737,6 +758,8 =40=40 static void sbsa=5Fref=5F=
init(MachineState *machine)</div><div>&gt;</div><div>&gt; create=5Frtc(sm=
s);</div><div>&gt;</div><div>&gt; + create=5Fwdt(sms);</div><div>&gt; +</=
div><div>&gt; create=5Fgpio(sms);</div><div>&gt;</div><div>&gt; create=5F=
ahci(sms);</div><div>&gt; diff --git a/hw/watchdog/Kconfig b/hw/watchdog/=
Kconfig</div><div>&gt; index 293209b291d6..94ac0d5b76b1 100644</div><div>=
&gt; --- a/hw/watchdog/Kconfig</div><div>&gt; +++ b/hw/watchdog/Kconfig</=
div><div>&gt; =40=40 -17,3 +17,7 =40=40 config WDT=5FDIAG288</div><div>&g=
t;</div><div>&gt; config WDT=5FIMX2</div><div>&gt; bool</div><div>&gt; +<=
/div><div>&gt; +config WDT=5FSBSA=5FGWDT</div><div>&gt; + bool</div><div>=
&gt; + default y if SBSA=5FRE=46</div><div>&gt; =5C No newline at end of =
file</div><div>&gt; diff --git a/hw/watchdog/meson.build b/hw/watchdog/me=
son.build</div><div>&gt; index 9b8725e64288..a9a23307acfe 100644</div><di=
v>&gt; --- a/hw/watchdog/meson.build</div><div>&gt; +++ b/hw/watchdog/mes=
on.build</div><div>&gt; =40=40 -5,3 +5,4 =40=40 softmmu=5Fss.add(when: 'C=
ON=46IG=5FWDT=5FIB700', if=5Ftrue: files('wdt=5Fib700.c'))</div><div>&gt;=
 softmmu=5Fss.add(when: 'CON=46IG=5FWDT=5FDIAG288', if=5Ftrue: files('wdt=
=5Fdiag288.c'))</div><div>&gt; softmmu=5Fss.add(when: 'CON=46IG=5FASPEED=5F=
SOC', if=5Ftrue: files('wdt=5Faspeed.c'))</div><div>&gt; softmmu=5Fss.add=
(when: 'CON=46IG=5FWDT=5FIMX2', if=5Ftrue: files('wdt=5Fimx2.c'))</div><d=
iv>&gt; +softmmu=5Fss.add(when: 'CON=46IG=5FWDT=5FSBSA=5FGWDT', if=5Ftrue=
: files('wdt=5Fsbsa=5Fgwdt.c'))</div><div>&gt; diff --git a/hw/watchdog/w=
dt=5Fsbsa=5Fgwdt.c b/hw/watchdog/wdt=5Fsbsa=5Fgwdt.c</div><div>&gt; new f=
ile mode 100644</div><div>&gt; index 000000000000..eb3be0862cf1</div><div=
>&gt; --- /dev/null</div><div>&gt; +++ b/hw/watchdog/wdt=5Fsbsa=5Fgwdt.c<=
/div><div>&gt; =40=40 -0,0 +1,343 =40=40</div><div>&gt; +/*</div><div>&gt=
; + * Generic watchdog device model for SBSA</div><div>&gt; + *</div><div=
>&gt; + * Copyright Linaro.org 2020</div><div>&gt; + *</div><div>&gt; + *=
 Authors:</div><div>&gt; + * Shashi Mallela &lt;shashi.mallela=40linaro.o=
rg&gt;</div><div>&gt; + *</div><div>&gt; + * This work is licensed under =
the terms of the GNU GPL, version 2 or (at your</div><div>&gt; + * option=
) any later version. See the COPYING file in the top-level directory.</di=
v><div>&gt; + *</div><div>&gt; + */</div><div>&gt; +</div><div>&gt; +=23i=
nclude =22qemu/osdep.h=22</div><div>&gt; +=23include =22sysemu/reset.h=22=
</div><div>&gt; +=23include =22sysemu/watchdog.h=22</div><div>&gt; +=23in=
clude =22hw/watchdog/wdt=5Fsbsa=5Fgwdt.h=22</div><div>&gt; +=23include =22=
qemu/timer.h=22</div><div>&gt; +=23include =22migration/vmstate.h=22</div=
><div>&gt; +=23include =22qemu/log.h=22</div><div>&gt; +=23include =22qem=
u/module.h=22</div><div>&gt; +</div><div>&gt; +static WatchdogTimerModel =
model =3D =7B</div><div>&gt; + .wdt=5Fname =3D TYPE=5FWDT=5FSBSA=5FGWDT,<=
/div><div>&gt; + .wdt=5Fdescription =3D =22sbsa=5Fgwdt device for sbsa=5F=
ref platform=22,</div><div>&gt; +=7D;</div><div>&gt; +</div><div>&gt; +st=
atic const VMStateDescription vmstate=5Fsbsa=5Fgwdt =3D =7B</div><div>&gt=
; + .name =3D =22vmstate=5Fsbsa=5Fgwdt=22,</div><div>&gt; + .version=5Fid=
 =3D 1,</div><div>&gt; + .minimum=5Fversion=5Fid =3D 1,</div><div>&gt; + =
.fields =3D (VMState=46ield=5B=5D) =7B</div><div>&gt; + VMSTATE=5FTIMER=5F=
PTR(timer, SBSA=5FGWDTState),</div><div>&gt; + VMSTATE=5FBOOL(enabled, SB=
SA=5FGWDTState),</div><div>&gt; + VMSTATE=5FBOOL(ws0, SBSA=5FGWDTState),<=
/div><div>&gt; + VMSTATE=5FBOOL(ws1, SBSA=5FGWDTState),</div><div>&gt; + =
VMSTATE=5FUINT32(wrr, SBSA=5FGWDTState),</div><div>&gt; + VMSTATE=5FUINT3=
2(wcs, SBSA=5FGWDTState),</div><div>&gt; + VMSTATE=5FUINT32(worl, SBSA=5F=
GWDTState),</div><div>&gt; + VMSTATE=5FUINT32(woru, SBSA=5FGWDTState),</d=
iv><div>&gt; + VMSTATE=5FUINT32(wcvl, SBSA=5FGWDTState),</div><div>&gt; +=
 VMSTATE=5FUINT32(wcvu, SBSA=5FGWDTState),</div><div>&gt; + VMSTATE=5FEND=
=5FO=46=5FLIST()</div><div>&gt; + =7D</div><div>&gt; +=7D;</div><div>&gt;=
 +</div><div>&gt; +static uint64=5Ft sbsa=5Fgwdt=5Frread(void *opaque, hw=
addr addr, unsigned int size)</div><div>&gt; +=7B</div><div>&gt; + uint32=
=5Ft ret;</div><div>&gt; +</div><div>&gt; + if (addr =3D=3D SBSA=5FGWDT=5F=
WRR) =7B</div><div>&gt; + /* watch refresh read has no effect and returns=
 0 */</div><div>&gt; + ret =3D 0;</div><div>&gt; + =7D else =7B</div><div=
>&gt; + fprintf(stderr, =22bad address in refresh frame read : 0x%x=5Cn=22=
,</div><div>&gt; + (int)addr);</div><br><div>I suspect this and the other=
 fprintf's should be using the</div><div>qemu=5Flog=5Fmask(LOG=5FGUEST=5F=
ERROR, ... API</div><br><div>Graeme</div><br><div>&gt; + =7D</div><div>&g=
t; + return ret;</div><div>&gt; +=7D</div><div>&gt; +</div><div>&gt; +sta=
tic uint64=5Ft sbsa=5Fgwdt=5Fread(void *opaque, hwaddr addr, unsigned int=
 size)</div><div>&gt; +=7B</div><div>&gt; + SBSA=5FGWDTState *s =3D SBSA=5F=
GWDT(opaque);</div><div>&gt; + uint32=5Ft ret =3D 0;</div><div>&gt; +</di=
v><div>&gt; + switch (addr) =7B</div><div>&gt; + case SBSA=5FGWDT=5FWCS:<=
/div><div>&gt; + ret =3D s-&gt;wcs;</div><div>&gt; + break;</div><div>&gt=
; + case SBSA=5FGWDT=5FWOR:</div><div>&gt; + ret =3D s-&gt;worl;</div><di=
v>&gt; + break;</div><div>&gt; + case SBSA=5FGWDT=5FWORU:</div><div>&gt; =
+ ret =3D s-&gt;woru;</div><div>&gt; + break;</div><div>&gt; + case SBSA=5F=
GWDT=5FWCV:</div><div>&gt; + ret =3D s-&gt;wcvl;</div><div>&gt; + break;<=
/div><div>&gt; + case SBSA=5FGWDT=5FWCVU:</div><div>&gt; + ret =3D s-&gt;=
wcvu;</div><div>&gt; + break;</div><div>&gt; + case SBSA=5FGWDT=5FW=5FIID=
R:</div><div>&gt; + ret =3D s-&gt;id;</div><div>&gt; + break;</div><div>&=
gt; + default:</div><div>&gt; + fprintf(stderr, =22bad address in control=
 frame read : 0x%x=5Cn=22,</div><div>&gt; + (int)addr);</div><div>&gt; + =
=7D</div><div>&gt; + return ret;</div><div>&gt; +=7D</div><div>&gt; +</di=
v><div>&gt; +static void sbsa=5Fgwdt=5Fupdate=5Ftimer(SBSA=5FGWDTState *s=
, bool refresh,</div><div>&gt; + bool expired)</div><div>&gt; +=7B</div><=
div>&gt; + uint64=5Ft timeout =3D 0;</div><div>&gt; +</div><div>&gt; + if=
 (s-&gt;enabled) =7B</div><div>&gt; + if ((refresh) =7C=7C (expired &amp;=
&amp; =21s-&gt;ws0)) =7B</div><div>&gt; + /*</div><div>&gt; + * Extract t=
he upper 16 bits from woru &amp; 32 bits from worl</div><div>&gt; + * reg=
isters to construct the 48 bit offset value</div><div>&gt; + */</div><div=
>&gt; + timeout =3D s-&gt;woru &amp; SBSA=5FGWDT=5FWOR=5FMASK;</div><div>=
&gt; + timeout &lt;&lt;=3D 32;</div><div>&gt; + timeout =7C=3D s-&gt;worl=
;</div><div>&gt; + timeout +=3D qemu=5Fclock=5Fget=5Fns(QEMU=5FCLOCK=5FVI=
RTUAL);</div><div>&gt; +</div><div>&gt; + /* store the current timeout va=
lue into compare registers */</div><div>&gt; + s-&gt;wcvu =3D timeout &gt=
;&gt; 32;</div><div>&gt; + s-&gt;wcvl =3D timeout;</div><div>&gt; + =7D e=
lse =7B</div><div>&gt; + timeout =3D s-&gt;wcvu;</div><div>&gt; + timeout=
 &lt;&lt;=3D 32;</div><div>&gt; + timeout =7C=3D s-&gt;wcvl;</div><div>&g=
t; + =7D</div><div>&gt; +</div><div>&gt; + if (=21s-&gt;ws0) =7B</div><di=
v>&gt; + timer=5Fdel(s-&gt;timer);</div><div>&gt; + timer=5Fmod(s-&gt;pti=
mer,</div><div>&gt; + timeout * NANOSECONDS=5FPER=5FSECOND);</div><div>&g=
t; + =7D else =7B</div><div>&gt; + timer=5Fdel(s-&gt;ptimer);</div><div>&=
gt; + timer=5Fmod(s-&gt;timer,</div><div>&gt; + timeout * NANOSECONDS=5FP=
ER=5FSECOND);</div><div>&gt; + =7D</div><div>&gt; + =7D else =7B</div><di=
v>&gt; + timer=5Fdel(s-&gt;ptimer);</div><div>&gt; + timer=5Fdel(s-&gt;ti=
mer);</div><div>&gt; + =7D</div><div>&gt; +=7D</div><div>&gt; +</div><div=
>&gt; +static void sbsa=5Fgwdt=5Frwrite(void *opaque, hwaddr offset, uint=
64=5Ft data,</div><div>&gt; + unsigned size) =7B</div><div>&gt; + SBSA=5F=
GWDTState *s =3D SBSA=5FGWDT(opaque);</div><div>&gt; +</div><div>&gt; + i=
f (offset =3D=3D SBSA=5FGWDT=5FWRR) =7B</div><div>&gt; + s-&gt;wrr =3D da=
ta;</div><div>&gt; + s-&gt;wcs &amp;=3D =7ESBSA=5FGWDT=5FWCS=5FWS0;</div>=
<div>&gt; + s-&gt;wcs &amp;=3D =7ESBSA=5FGWDT=5FWCS=5FWS1;</div><div>&gt;=
 + s-&gt;ws0 =3D false;</div><div>&gt; + s-&gt;ws1 =3D false;</div><div>&=
gt; + sbsa=5Fgwdt=5Fupdate=5Ftimer(s, true , false);</div><div>&gt; + =7D=
 else =7B</div><div>&gt; + fprintf(stderr, =22bad address in refresh fram=
e write : 0x%x=5Cn=22,</div><div>&gt; + (int)offset);</div><div>&gt; + =7D=
</div><div>&gt; +=7D</div><div>&gt; +</div><div>&gt; +static void sbsa=5F=
gwdt=5Fwrite(void *opaque, hwaddr offset, uint64=5Ft data,</div><div>&gt;=
 + unsigned size) =7B</div><div>&gt; + SBSA=5FGWDTState *s =3D SBSA=5FGWD=
T(opaque);</div><div>&gt; + bool enable;</div><div>&gt; +</div><div>&gt; =
+ switch (offset) =7B</div><div>&gt; + case SBSA=5FGWDT=5FWCS:</div><div>=
&gt; + enable =3D data &amp; SBSA=5FGWDT=5FWCS=5FEN;</div><div>&gt; + if =
(enable) =7B</div><div>&gt; + s-&gt;wcs =7C=3D SBSA=5FGWDT=5FWCS=5FEN;</d=
iv><div>&gt; + s-&gt;enabled =3D true;</div><div>&gt; + =7D else =7B</div=
><div>&gt; + s-&gt;wcs &amp;=3D =7ESBSA=5FGWDT=5FWCS=5FEN;</div><div>&gt;=
 + s-&gt;enabled =3D false;</div><div>&gt; + s-&gt;ws0 =3D false;</div><d=
iv>&gt; + s-&gt;ws1 =3D false;</div><div>&gt; + =7D</div><div>&gt; + sbsa=
=5Fgwdt=5Fupdate=5Ftimer(s, false, false);</div><div>&gt; + break;</div><=
div>&gt; +</div><div>&gt; + case SBSA=5FGWDT=5FWOR:</div><div>&gt; + s-&g=
t;worl =3D data;</div><div>&gt; + /*</div><div>&gt; + * TODO:- setting wo=
ru to 0 and triggering update timer(below) is a</div><div>&gt; + * tempor=
ary workaround to handle current linux driver which is</div><div>&gt; + *=
 based on earlier version of BSA specification.Once the linux</div><div>&=
gt; + * driver is updated to BSA v0.9 will remove these next 2 lines.</di=
v><div>&gt; + */</div><div>&gt; + s-&gt;woru =3D 0;</div><div>&gt; + sbsa=
=5Fgwdt=5Fupdate=5Ftimer(s, true , false);</div><div>&gt; + break;</div><=
div>&gt; +</div><div>&gt; + case SBSA=5FGWDT=5FWORU:</div><div>&gt; + s-&=
gt;woru =3D data;</div><div>&gt; + sbsa=5Fgwdt=5Fupdate=5Ftimer(s, true ,=
 false);</div><div>&gt; + break;</div><div>&gt; +</div><div>&gt; + case S=
BSA=5FGWDT=5FWCV:</div><div>&gt; + s-&gt;wcvl =3D data;</div><div>&gt; + =
break;</div><div>&gt; +</div><div>&gt; + case SBSA=5FGWDT=5FWCVU:</div><d=
iv>&gt; + s-&gt;wcvu =3D data;</div><div>&gt; + break;</div><div>&gt; +</=
div><div>&gt; + default:</div><div>&gt; + fprintf(stderr, =22bad address =
in control frame write : 0x%x=5Cn=22,</div><div>&gt; + (int)offset);</div=
><div>&gt; + =7D</div><div>&gt; + return;</div><div>&gt; +=7D</div><div>&=
gt; +</div><div>&gt; +static void wdt=5Fsbsa=5Fgwdt=5Freset(DeviceState *=
dev)</div><div>&gt; +=7B</div><div>&gt; + SBSA=5FGWDTState *s =3D SBSA=5F=
GWDT(dev);</div><div>&gt; +</div><div>&gt; + timer=5Fdel(s-&gt;ptimer);</=
div><div>&gt; + timer=5Fdel(s-&gt;timer);</div><div>&gt; +</div><div>&gt;=
 + s-&gt;enabled =3D false;</div><div>&gt; + s-&gt;ws0 =3D false;</div><d=
iv>&gt; + s-&gt;ws1 =3D false;</div><div>&gt; + s-&gt;wcs &amp;=3D =7ESBS=
A=5FGWDT=5FWCS=5FEN;</div><div>&gt; + s-&gt;wcs &amp;=3D =7ESBSA=5FGWDT=5F=
WCS=5FWS0;</div><div>&gt; + s-&gt;wcs &amp;=3D =7ESBSA=5FGWDT=5FWCS=5FWS1=
;</div><div>&gt; + s-&gt;wcvl =3D 0;</div><div>&gt; + s-&gt;wcvu =3D 0;</=
div><div>&gt; + s-&gt;worl =3D 0;</div><div>&gt; + s-&gt;woru =3D 0;</div=
><div>&gt; + s-&gt;id =3D SBSA=5FGWDT=5FID;</div><div>&gt; +=7D</div><div=
>&gt; +</div><div>&gt; +static void sbsa=5Fgwdt=5Freset(void *opaque)</di=
v><div>&gt; +=7B</div><div>&gt; + DeviceState *sbsa=5Fgwdt =3D opaque;</d=
iv><div>&gt; +</div><div>&gt; + wdt=5Fsbsa=5Fgwdt=5Freset(sbsa=5Fgwdt);</=
div><div>&gt; +=7D</div><div>&gt; +</div><div>&gt; +static void sbsa=5Fgw=
dt=5Ftimer=5Fsysinterrupt(void *opaque)</div><div>&gt; +=7B</div><div>&gt=
; + SBSA=5FGWDTState *s =3D SBSA=5FGWDT(opaque);</div><div>&gt; +</div><d=
iv>&gt; + s-&gt;wcs =7C=3D SBSA=5FGWDT=5FWCS=5FWS0;</div><div>&gt; + s-&g=
t;ws0 =3D true;</div><div>&gt; + qemu=5Fset=5Firq(s-&gt;irq, 1);</div><di=
v>&gt; + sbsa=5Fgwdt=5Fupdate=5Ftimer(s, false, true);</div><div>&gt; +=7D=
</div><div>&gt; +</div><div>&gt; +static void sbsa=5Fgwdt=5Ftimer=5Fsysre=
set(void *dev)</div><div>&gt; +=7B</div><div>&gt; + SBSA=5FGWDTState *s =3D=
 SBSA=5FGWDT(dev);</div><div>&gt; + s-&gt;wcs =7C=3D SBSA=5FGWDT=5FWCS=5F=
WS1;</div><div>&gt; + s-&gt;ws1 =3D true;</div><div>&gt; + qemu=5Flog=5Fm=
ask(CPU=5FLOG=5FRESET, =22Watchdog timer expired.=5Cn=22);</div><div>&gt;=
 + /*</div><div>&gt; + * Reset the watchdog only if the guest gets notifi=
ed about</div><div>&gt; + * expiry. watchdog=5Fperform=5Faction() may tem=
porarily relinquish</div><div>&gt; + * the BQL; reset before triggering t=
he action to avoid races with</div><div>&gt; + * sbsa=5Fgwdt instructions=
.</div><div>&gt; + */</div><div>&gt; + switch (get=5Fwatchdog=5Faction())=
 =7B</div><div>&gt; + case WATCHDOG=5FACTION=5FDEBUG:</div><div>&gt; + ca=
se WATCHDOG=5FACTION=5FNONE:</div><div>&gt; + case WATCHDOG=5FACTION=5FPA=
USE:</div><div>&gt; + break;</div><div>&gt; + default:</div><div>&gt; + w=
dt=5Fsbsa=5Fgwdt=5Freset(dev);</div><div>&gt; + =7D</div><div>&gt; + watc=
hdog=5Fperform=5Faction();</div><div>&gt; +=7D</div><div>&gt; +</div><div=
>&gt; +static const MemoryRegionOps sbsa=5Fgwdt=5Frops =3D =7B</div><div>=
&gt; + .read =3D sbsa=5Fgwdt=5Frread,</div><div>&gt; + .write =3D sbsa=5F=
gwdt=5Frwrite,</div><div>&gt; + .endianness =3D DEVICE=5FLITTLE=5FENDIAN,=
</div><div>&gt; + .valid.min=5Faccess=5Fsize =3D 4,</div><div>&gt; + .val=
id.max=5Faccess=5Fsize =3D 4,</div><div>&gt; + .valid.unaligned =3D false=
,</div><div>&gt; +=7D;</div><div>&gt; +</div><div>&gt; +static const Memo=
ryRegionOps sbsa=5Fgwdt=5Fops =3D =7B</div><div>&gt; + .read =3D sbsa=5Fg=
wdt=5Fread,</div><div>&gt; + .write =3D sbsa=5Fgwdt=5Fwrite,</div><div>&g=
t; + .endianness =3D DEVICE=5FLITTLE=5FENDIAN,</div><div>&gt; + .valid.mi=
n=5Faccess=5Fsize =3D 4,</div><div>&gt; + .valid.max=5Faccess=5Fsize =3D =
4,</div><div>&gt; + .valid.unaligned =3D false,</div><div>&gt; +=7D;</div=
><div>&gt; +</div><div>&gt; +static void wdt=5Fsbsa=5Fgwdt=5Frealize(Devi=
ceState *dev, Error **errp)</div><div>&gt; +=7B</div><div>&gt; + SBSA=5FG=
WDTState *s =3D SBSA=5FGWDT(dev);</div><div>&gt; + SysBusDevice *sbd =3D =
SYS=5FBUS=5FDEVICE(dev);</div><div>&gt; +</div><div>&gt; + memory=5Fregio=
n=5Finit=5Fio(&amp;s-&gt;rmmio, OBJECT(dev),</div><div>&gt; + &amp;sbsa=5F=
gwdt=5Frops, s,</div><div>&gt; + =22sbsa=5Fgwdt.refresh=22,</div><div>&gt=
; + SBSA=5FGWDT=5FRMMIO=5FSIZE);</div><div>&gt; +</div><div>&gt; + memory=
=5Fregion=5Finit=5Fio(&amp;s-&gt;cmmio, OBJECT(dev),</div><div>&gt; + &am=
p;sbsa=5Fgwdt=5Fops, s,</div><div>&gt; + =22sbsa=5Fgwdt.control=22,</div>=
<div>&gt; + SBSA=5FGWDT=5FCMMIO=5FSIZE);</div><div>&gt; +</div><div>&gt; =
+ sysbus=5Finit=5Fmmio(sbd, &amp;s-&gt;rmmio);</div><div>&gt; + sysbus=5F=
init=5Fmmio(sbd, &amp;s-&gt;cmmio);</div><div>&gt; +</div><div>&gt; + sys=
bus=5Finit=5Firq(sbd, &amp;s-&gt;irq);</div><div>&gt; +</div><div>&gt; + =
qemu=5Fregister=5Freset(sbsa=5Fgwdt=5Freset, s);</div><div>&gt; +</div><d=
iv>&gt; + s-&gt;ptimer =3D timer=5Fnew=5Fns(QEMU=5FCLOCK=5FVIRTUAL, sbsa=5F=
gwdt=5Ftimer=5Fsysinterrupt,</div><div>&gt; + dev);</div><div>&gt; + s-&g=
t;timer =3D timer=5Fnew=5Fns(QEMU=5FCLOCK=5FVIRTUAL, sbsa=5Fgwdt=5Ftimer=5F=
sysreset,</div><div>&gt; + dev);</div><div>&gt; +=7D</div><div>&gt; +</di=
v><div>&gt; +static void wdt=5Fsbsa=5Fgwdt=5Funrealize(DeviceState *dev)<=
/div><div>&gt; +=7B</div><div>&gt; + SBSA=5FGWDTState *s =3D SBSA=5FGWDT(=
dev);</div><div>&gt; +</div><div>&gt; + timer=5Fdel(s-&gt;ptimer);</div><=
div>&gt; + timer=5Ffree(s-&gt;ptimer);</div><div>&gt; +</div><div>&gt; + =
timer=5Fdel(s-&gt;timer);</div><div>&gt; + timer=5Ffree(s-&gt;timer);</di=
v><div>&gt; +=7D</div><div>&gt; +</div><div>&gt; +static void wdt=5Fsbsa=5F=
gwdt=5Fclass=5Finit(ObjectClass *klass, void *data)</div><div>&gt; +=7B</=
div><div>&gt; + DeviceClass *dc =3D DEVICE=5FCLASS(klass);</div><div>&gt;=
 +</div><div>&gt; + dc-&gt;realize =3D wdt=5Fsbsa=5Fgwdt=5Frealize;</div>=
<div>&gt; + dc-&gt;unrealize =3D wdt=5Fsbsa=5Fgwdt=5Funrealize;</div><div=
>&gt; + dc-&gt;reset =3D wdt=5Fsbsa=5Fgwdt=5Freset;</div><div>&gt; + dc-&=
gt;hotpluggable =3D false;</div><div>&gt; + set=5Fbit(DEVICE=5FCATEGORY=5F=
MISC, dc-&gt;categories);</div><div>&gt; + dc-&gt;vmsd =3D &amp;vmstate=5F=
sbsa=5Fgwdt;</div><div>&gt; +=7D</div><div>&gt; +</div><div>&gt; +static =
const TypeInfo wdt=5Fsbsa=5Fgwdt=5Finfo =3D =7B</div><div>&gt; + .class=5F=
init =3D wdt=5Fsbsa=5Fgwdt=5Fclass=5Finit,</div><div>&gt; + .parent =3D T=
YPE=5FSYS=5FBUS=5FDEVICE,</div><div>&gt; + .name =3D TYPE=5FWDT=5FSBSA=5F=
GWDT,</div><div>&gt; + .instance=5Fsize =3D sizeof(SBSA=5FGWDTState),</di=
v><div>&gt; +=7D;</div><div>&gt; +</div><div>&gt; +static void wdt=5Fsbsa=
=5Fgwdt=5Fregister=5Ftypes(void)</div><div>&gt; +=7B</div><div>&gt; + wat=
chdog=5Fadd=5Fmodel(&amp;model);</div><div>&gt; + type=5Fregister=5Fstati=
c(&amp;wdt=5Fsbsa=5Fgwdt=5Finfo);</div><div>&gt; +=7D</div><div>&gt; +</d=
iv><div>&gt; +type=5Finit(wdt=5Fsbsa=5Fgwdt=5Fregister=5Ftypes)</div><div=
>&gt; diff --git a/include/hw/watchdog/wdt=5Fsbsa=5Fgwdt.h b/include/hw/w=
atchdog/wdt=5Fsbsa=5Fgwdt.h</div><div>&gt; new file mode 100644</div><div=
>&gt; index 000000000000..8044646fa62d</div><div>&gt; --- /dev/null</div>=
<div>&gt; +++ b/include/hw/watchdog/wdt=5Fsbsa=5Fgwdt.h</div><div>&gt; =40=
=40 -0,0 +1,68 =40=40</div><div>&gt; +=23ifndef WDT=5FSBSA=5FGWDT=5FH</di=
v><div>&gt; +=23define WDT=5FSBSA=5FGWDT=5FH</div><div>&gt; +</div><div>&=
gt; +=23include =22qemu/bitops.h=22</div><div>&gt; +=23include =22hw/sysb=
us.h=22</div><div>&gt; +=23include =22hw/irq.h=22</div><div>&gt; +</div><=
div>&gt; +=23define TYPE=5FWDT=5FSBSA=5FGWDT =22sbsa=5Fgwdt=22</div><div>=
&gt; +=23define SBSA=5FGWDT(obj) =5C</div><div>&gt; + OBJECT=5FCHECK(SBSA=
=5FGWDTState, (obj), TYPE=5FWDT=5FSBSA=5FGWDT)</div><div>&gt; +=23define =
SBSA=5FGWDT=5FCLASS(klass) =5C</div><div>&gt; + OBJECT=5FCLASS=5FCHECK(SB=
SA=5FGWDTClass, (klass), TYPE=5FWDT=5FSBSA=5FGWDT)</div><div>&gt; +=23def=
ine SBSA=5FGWDT=5FGET=5FCLASS(obj) =5C</div><div>&gt; + OBJECT=5FGET=5FCL=
ASS(SBSA=5FGWDTClass, (obj), TYPE=5FWDT=5FSBSA=5FGWDT)</div><div>&gt; +</=
div><div>&gt; +/* SBSA Generic Watchdog register definitions */</div><div=
>&gt; +/* refresh frame */</div><div>&gt; +=23define SBSA=5FGWDT=5FWRR 0x=
000</div><div>&gt; +</div><div>&gt; +/* control frame */</div><div>&gt; +=
=23define SBSA=5FGWDT=5FWCS 0x000</div><div>&gt; +=23define SBSA=5FGWDT=5F=
WOR 0x008</div><div>&gt; +=23define SBSA=5FGWDT=5FWORU 0x00C</div><div>&g=
t; +=23define SBSA=5FGWDT=5FWCV 0x010</div><div>&gt; +=23define SBSA=5FGW=
DT=5FWCVU 0x014</div><div>&gt; +</div><div>&gt; +/* Watchdog Interface Id=
entification Register */</div><div>&gt; +=23define SBSA=5FGWDT=5FW=5FIIDR=
 0x=46CC</div><div>&gt; +</div><div>&gt; +/* Watchdog Control and Status =
Register Bits */</div><div>&gt; +=23define SBSA=5FGWDT=5FWCS=5FEN BIT(0)<=
/div><div>&gt; +=23define SBSA=5FGWDT=5FWCS=5FWS0 BIT(1)</div><div>&gt; +=
=23define SBSA=5FGWDT=5FWCS=5FWS1 BIT(2)</div><div>&gt; +</div><div>&gt; =
+=23define SBSA=5FGWDT=5FWOR=5FMASK 0x0000=46=46=46=46</div><div>&gt; +</=
div><div>&gt; +/* Watchdog Interface Identification Register definition*/=
</div><div>&gt; +=23define SBSA=5FGWDT=5FID 0x1043B</div><div>&gt; +</div=
><div>&gt; +/* 2 Separate memory regions for each of refresh &amp; contro=
l register frames */</div><div>&gt; +=23define SBSA=5FGWDT=5FRMMIO=5FSIZE=
 0x1000</div><div>&gt; +=23define SBSA=5FGWDT=5FCMMIO=5FSIZE 0x1000</div>=
<div>&gt; +</div><div>&gt; +typedef struct SBSA=5FGWDTState =7B</div><div=
>&gt; + /* &lt;private&gt; */</div><div>&gt; + SysBusDevice parent=5Fobj;=
</div><div>&gt; +</div><div>&gt; + /*&lt; public &gt;*/</div><div>&gt; + =
MemoryRegion rmmio;</div><div>&gt; + MemoryRegion cmmio;</div><div>&gt; +=
 qemu=5Firq irq;</div><div>&gt; +</div><div>&gt; + QEMUTimer *ptimer, *ti=
mer;</div><div>&gt; +</div><div>&gt; + uint32=5Ft id;</div><div>&gt; + ui=
nt32=5Ft wrr;</div><div>&gt; + uint32=5Ft wcs;</div><div>&gt; + uint32=5F=
t worl;</div><div>&gt; + uint32=5Ft woru;</div><div>&gt; + uint32=5Ft wcv=
l;</div><div>&gt; + uint32=5Ft wcvu;</div><div>&gt; + bool enabled;</div>=
<div>&gt; + bool ws0, ws1;</div><div>&gt; +</div><div>&gt; + /*&lt; publi=
c &gt;*/</div><div>&gt; +=7D SBSA=5FGWDTState;</div><div>&gt; +</div><div=
>&gt; +=23endif /* WDT=5FSBSA=5FGWDT=5FH */</div><div>&gt; --</div><div>&=
gt; 2.18.4</div><div>&gt;</div><div>&gt;</div></div></blockquote><img cla=
ss=3D=22mailspring-open=22 alt=3D=22Sent from Mailspring=22 width=3D=220=22=
 height=3D=220=22 style=3D=22border:0; width:0; height:0;=22 src=3D=22htt=
ps://link.getmailspring.com/open/28E5=46544-3707-420=46-8082-70E07C331683=
=40getmailspring.com=3Fme=3D2a4b90d6&amp;recipient=3DcWVtdS1kZXZlbEBub25n=
bnUub3Jn=22>
--5f63da65_4b80a9c7_2084--


