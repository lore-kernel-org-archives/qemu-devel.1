Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF20C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF07D2225A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtGGq0Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF07D2225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT55W-0007qq-W5
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kT54G-0006Wf-LC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:21:24 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kT54E-0005yN-GU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:21:24 -0400
Received: by mail-pl1-x643.google.com with SMTP id h2so1775152pll.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iCISf2StKejdRMvAE6JnWGeHvYzQyJimMoUGMeKPh/w=;
 b=FtGGq0Y0IxBuICU8RzUSCi3iVLbI3kehn7WqjPKMMSRRxqLKJYMpoEBfkZRhTjIrOX
 HIVBD972JHlfKL0lAOmYMuQRPLdzg6twKLyrOylDv5XJcbkEJH11XaBDy1N7rreRV0ud
 Sdvpvkrnw4ZRNBB2CGq3b0fmaIyZ5EJBW/AU74pxw/zc1FctamuIHWhw2guktjsO4D6s
 Kys5pMMLy9ZjpABQoG6ITqf0Lg7DXTF9Y14nR0HbyuE5V9qC/wGpHTaRlqSvUC0danDM
 OknV8qVCkkOWp7XQZx5b53rnTRviYB5FnKB5uJFE0GEzmqTwG3KaQiEF6lN/0ebQ0LTx
 S37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iCISf2StKejdRMvAE6JnWGeHvYzQyJimMoUGMeKPh/w=;
 b=AV4OsTqcnJc7j/ZIwt+uFi7qgKYDeOMG7uV/f4RCo3RuZeXaL6G/mdGnjnDL/lXzSb
 IAWgIueL7gjk/ZeK5sJabJP+siYDyFm9E51n6LWuEGUpoMnA0M2YSSQYtPWbhXnMCS3Q
 5lcm1ni82htp7kK0oP8wtt6XoCqWIdn1qyWymorC/0gDCxzDCbNSTurnYutp+JukPrPD
 W7iiUsu0FdaLU6C3c49ZKFHuiMyZ6AmxBLmJe3337iSUNuA8TJTb31D1pkbJyjrIaUOi
 hW59eQ8WbZ+De8oTPJ4yRjGo5mjQi0xSpFJXDsD0S7E/nmeFS0a1oGAg3qiJHr2J8Uac
 QSAg==
X-Gm-Message-State: AOAM532XoVS5gT0XXzPO7sKEpZYbECsjmcv4NptQgsTN75yxp7MtCsIj
 RdhkW9vVP644+Lq0ykXB0xS0R8GO4FbWRXP4IQYD0w==
X-Google-Smtp-Source: ABdhPJz4+7pY1IxYexeCMHsZnGxvw+kuGlgcBmHLXOfB+3cxQk+HGq204Ed7mUB7Ue6Hd3Y+FTM+fFM7OM5KE42x0iM=
X-Received: by 2002:a17:90a:c58f:: with SMTP id
 l15mr4684512pjt.93.1602775280474; 
 Thu, 15 Oct 2020 08:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201013151631.30678-1-shashi.mallela@linaro.org>
 <20201013151631.30678-3-shashi.mallela@linaro.org>
 <20201014093119.inq2ut2srps2zfme@xora-monster>
 <CAC15JE2hMrzpWWF-bS-fshoYx+BPehwxqJi-7uMUXSOj+Uh3GQ@mail.gmail.com>
 <20201015141044.loa6x4sv5552pe72@xora-monster>
In-Reply-To: <20201015141044.loa6x4sv5552pe72@xora-monster>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 15 Oct 2020 18:21:09 +0300
Message-ID: <CAD8XO3Yb+GwC75k-OXenAkrXf=x6=ru6C0juzCsT+FQV3iPadw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
To: Graeme Gregory <graeme@nuviainc.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shashi Mallela <shashi.mallela@linaro.org>,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Leif Lindholm <leif@nuviainc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 at 17:12, Graeme Gregory <graeme@nuviainc.com> wrote:
>
> On Wed, Oct 14, 2020 at 01:04:43PM -0400, Shashi Mallela wrote:
> > This was added as a placeholder for the virt requirement suggested by Maxim
> > earlier.Agreed that this fdt otherwise has no significance for sbsa-ref
> > platform nor is being used by ACPI table created for wdt.
> >
> > -Shashi
> >
> > On Wed, 14 Oct 2020 at 05:31, Graeme Gregory <[1]graeme@nuviainc.com> wrote:
> >
> >     On Tue, Oct 13, 2020 at 11:16:31AM -0400, Shashi Mallela wrote:
> >     > Included the newly implemented SBSA generic watchdog device model into
> >     > SBSA platform
> >     >
> >     > Signed-off-by: Shashi Mallela <[2]shashi.mallela@linaro.org>
> >     > ---
> >     >  hw/arm/sbsa-ref.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
> >     >  1 file changed, 50 insertions(+)
> >     >
> >     > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> >     > index 9c3a893bedfd..97ed41607119 100644
> >     > --- a/hw/arm/sbsa-ref.c
> >     > +++ b/hw/arm/sbsa-ref.c
> >     > @@ -30,6 +30,7 @@
> >     >  #include "exec/hwaddr.h"
> >     >  #include "kvm_arm.h"
> >     >  #include "hw/arm/boot.h"
> >     > +#include "hw/arm/fdt.h"
> >     >  #include "hw/block/flash.h"
> >     >  #include "hw/boards.h"
> >     >  #include "hw/ide/internal.h"
> >     > @@ -40,6 +41,7 @@
> >     >  #include "hw/qdev-properties.h"
> >     >  #include "hw/usb.h"
> >     >  #include "hw/char/pl011.h"
> >     > +#include "hw/watchdog/wdt_sbsa_gwdt.h"
> >     >  #include "net/net.h"
> >     >  #include "qom/object.h"
> >     >
> >     > @@ -64,6 +66,9 @@ enum {
> >     >      SBSA_GIC_DIST,
> >     >      SBSA_GIC_REDIST,
> >     >      SBSA_SECURE_EC,
> >     > +    SBSA_GWDT,
> >     > +    SBSA_GWDT_REFRESH,
> >     > +    SBSA_GWDT_CONTROL,
> >     >      SBSA_SMMU,
> >     >      SBSA_UART,
> >     >      SBSA_RTC,
> >     > @@ -104,6 +109,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
> >     >      [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
> >     >      [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
> >     >      [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
> >     > +    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
> >     > +    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
> >     >      [SBSA_UART] =               { 0x60000000, 0x00001000 },
> >     >      [SBSA_RTC] =                { 0x60010000, 0x00001000 },
> >     >      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> >     > @@ -133,6 +140,8 @@ static const int sbsa_ref_irqmap[] = {
> >     >      [SBSA_SECURE_UART_MM] = 9,
> >     >      [SBSA_AHCI] = 10,
> >     >      [SBSA_EHCI] = 11,
> >     > +    [SBSA_SMMU] = 12, /* ... to 15 */
> >     > +    [SBSA_GWDT] = 16,
> >     >  };
>
> I guess your patch was not based on master here? You should make sure
> you are rebased to the latest version before sending.
>
> >     >
> >     >  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> >     > @@ -141,6 +150,30 @@ static uint64_t sbsa_ref_cpu_mp_affinity
> >     (SBSAMachineState *sms, int idx)
> >     >      return arm_cpu_mp_affinity(idx, clustersz);
> >     >  }
> >     >
> >     > +static void create_wdt_fdt(SBSAMachineState *sms)
> >     > +{
> >     > +    char *nodename;
> >     > +    const char compat[] = "arm,sbsa-gwdt";
> >     > +
> >     > +    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> >     > +    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> >     > +    int irq = sbsa_ref_irqmap[SBSA_GWDT];
> >     > +
> >     > +    nodename = g_strdup_printf("/watchdog@%" PRIx64, rbase);
> >     > +    qemu_fdt_add_subnode(sms->fdt, nodename);
> >     > +
> >     > +    qemu_fdt_setprop(sms->fdt, nodename, "compatible",
> >     > +                             compat, sizeof(compat));
> >     > +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> >     > +                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE,
> >     > +                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE);
> >     > +    qemu_fdt_setprop_cells(sms->fdt, nodename, "interrupts",
> >     > +                                GIC_FDT_IRQ_TYPE_PPI, irq,
> >     > +                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> >     > +    qemu_fdt_setprop_cell(sms->fdt, nodename, "timeout-sec", 30);
> >     > +    g_free(nodename);
> >     > +}
> >     > +
> >
> >     Is this actually used anywhere? I ask because SBSA-ref is not a FDT
> >     booting machine and only uses FDT to transfer some dynamic info to
> >     arm-tf/edk2 and is not a full description tree. Your ACPI patch in
> >     edk2 certainly does not use this info.
> >
>

Greame, if sbsa-ref does not support non edk2 boot, i.e.
arm-tf/optee/uboot-uefi, then it's better to remove here and we can
add later for the virt machine.

> From your reply above I would propose this hunk and the call below are
> removed. If its needed to virt thats a seperate discussion which I think
> was already happening in another thread.
>
Yep, agree.

Maxim.

> FOSS style is for inline replies not top posting FYI
>
> Graeme
>
> >     Graeme
> >
> >
> >     >  /*
> >     >   * Firmware on this machine only uses ACPI table to load OS, these
> >     limited
> >     >   * device tree nodes are just to let firmware know the info which varies
> >     from
> >     > @@ -219,6 +252,7 @@ static void create_fdt(SBSAMachineState *sms)
> >     >
> >     >          g_free(nodename);
> >     >      }
> >     > +    create_wdt_fdt(sms);
> >     >  }
> >     >
> >     >  #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
> >     > @@ -447,6 +481,20 @@ static void create_rtc(const SBSAMachineState *sms)
> >     >      sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic,
> >     irq));
> >     >  }
> >     >
> >     > +static void create_wdt(const SBSAMachineState *sms)
> >     > +{
> >     > +    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> >     > +    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> >     > +    DeviceState *dev = qdev_new(TYPE_WDT_SBSA_GWDT);
> >     > +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> >     > +    int irq = sbsa_ref_irqmap[SBSA_GWDT];
> >     > +
> >     > +    sysbus_realize_and_unref(s, &error_fatal);
> >     > +    sysbus_mmio_map(s, 0, rbase);
> >     > +    sysbus_mmio_map(s, 1, cbase);
> >     > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
> >     > +}
> >     > +
> >     >  static DeviceState *gpio_key_dev;
> >     >  static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
> >     >  {
> >     > @@ -730,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
> >     >
> >     >      create_rtc(sms);
> >     >
> >     > +    create_wdt(sms);
> >     > +
> >     >      create_gpio(sms);
> >     >
> >     >      create_ahci(sms);
> >     > --
> >     > 2.18.4
> >     >
> >     >
> >
> >
> > References:
> >
> > [1] mailto:graeme@nuviainc.com
> > [2] mailto:shashi.mallela@linaro.org
>

