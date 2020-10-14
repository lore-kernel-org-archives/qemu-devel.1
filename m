Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E9EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266092073A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="DpuUsGht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266092073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSd9i-0000YL-Uo
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 05:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kSd87-0008Tq-Nj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:31:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kSd81-00085C-HP
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:31:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id b8so2975223wrn.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iVNybYYjAFma1CCT9N+GtFmqmQ/b8Tql4MoHG1zC5wU=;
 b=DpuUsGht6WRqNCHD+8Kll5deIcVne6XezFAT4MoYI9pkqhL9MaUk4LY/drfNyK0W9P
 Yp3Bp4XOD6vcabPqhVtszGCMwjel2oI9VipOCAfQMMluYLCSXfAVx3pulhxeUvchV8s0
 Ib+bdlsqXfabenxG0l5mcmQJ3/8nUuQoEL9bENMEEd81iMZukXUFxBn8KlqiYUxOs2hT
 lMPqvXwoQ+gLjtF/rzk7FKL7YbDhX8mvKN53+rCNTSssSZK+GiBd6lwi/yLOlJD//N+t
 T4pHBUjjaO0b3SxaQ5YAXYxn8gx0Ny8QjJ+P6LTQS4dvU9dJYDccpIqNImc4T13vF1Z9
 UPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iVNybYYjAFma1CCT9N+GtFmqmQ/b8Tql4MoHG1zC5wU=;
 b=i+PngLpQHrQ9nPFOx2rKP1LY8FsCJIgw9ZOheGlIn3+eLCAQWbem6lylFoF++j8ZZ5
 kixIzLH5OISBb52anMzw1crs2g32sHP+WPVHKdac1iGRzEa1++0qLRmAfy2KUmu8RyWn
 0xJPDg6oRDNtdOUoYdSqC2v7fExVyZ6porAZ/4WQXGRvUOB/l9Bnjx+mpxm00moaPZlD
 HKDQ0W40sJH/lA22zeeK3e681EmFYg6e8cxNoTkENYX7zxX35r4yBVCYrQ+YZuXKi9N7
 YKNlqvqPTFc6mlTO8XxIsrE3sb3wnnrBSBLQfLdLGz3oIIn/LMBl4PzcJnqtBQHw91Mc
 kiKg==
X-Gm-Message-State: AOAM532IG9LaZsq7uaRSAOhgUhJfkvsyHg89DwgVlrPoHHxAqnkp4z3c
 wzWpauMonVlF5RaAt3OhDHHMDA==
X-Google-Smtp-Source: ABdhPJwhlyuX0xTn5XKoDOZ+3zbxzBstKvAbV6XKbTruI/+RtnvJwRR5TCPd8ZxmmKaOgHEirGt9cQ==
X-Received: by 2002:a5d:5612:: with SMTP id l18mr4421150wrv.7.1602667882292;
 Wed, 14 Oct 2020 02:31:22 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id c14sm3931975wrv.12.2020.10.14.02.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 02:31:21 -0700 (PDT)
Date: Wed, 14 Oct 2020 10:31:19 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Shashi Mallela <shashi.mallela@linaro.org>
Subject: Re: [PATCH v5 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
Message-ID: <20201014093119.inq2ut2srps2zfme@xora-monster>
References: <20201013151631.30678-1-shashi.mallela@linaro.org>
 <20201013151631.30678-3-shashi.mallela@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013151631.30678-3-shashi.mallela@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 11:16:31AM -0400, Shashi Mallela wrote:
> Included the newly implemented SBSA generic watchdog device model into
> SBSA platform
> 
> Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9c3a893bedfd..97ed41607119 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -30,6 +30,7 @@
>  #include "exec/hwaddr.h"
>  #include "kvm_arm.h"
>  #include "hw/arm/boot.h"
> +#include "hw/arm/fdt.h"
>  #include "hw/block/flash.h"
>  #include "hw/boards.h"
>  #include "hw/ide/internal.h"
> @@ -40,6 +41,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/usb.h"
>  #include "hw/char/pl011.h"
> +#include "hw/watchdog/wdt_sbsa_gwdt.h"
>  #include "net/net.h"
>  #include "qom/object.h"
>  
> @@ -64,6 +66,9 @@ enum {
>      SBSA_GIC_DIST,
>      SBSA_GIC_REDIST,
>      SBSA_SECURE_EC,
> +    SBSA_GWDT,
> +    SBSA_GWDT_REFRESH,
> +    SBSA_GWDT_CONTROL,
>      SBSA_SMMU,
>      SBSA_UART,
>      SBSA_RTC,
> @@ -104,6 +109,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
>      [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
>      [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
> +    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
> +    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
>      [SBSA_UART] =               { 0x60000000, 0x00001000 },
>      [SBSA_RTC] =                { 0x60010000, 0x00001000 },
>      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> @@ -133,6 +140,8 @@ static const int sbsa_ref_irqmap[] = {
>      [SBSA_SECURE_UART_MM] = 9,
>      [SBSA_AHCI] = 10,
>      [SBSA_EHCI] = 11,
> +    [SBSA_SMMU] = 12, /* ... to 15 */
> +    [SBSA_GWDT] = 16,
>  };
>  
>  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> @@ -141,6 +150,30 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
>      return arm_cpu_mp_affinity(idx, clustersz);
>  }
>  
> +static void create_wdt_fdt(SBSAMachineState *sms)
> +{
> +    char *nodename;
> +    const char compat[] = "arm,sbsa-gwdt";
> +
> +    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> +    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> +    int irq = sbsa_ref_irqmap[SBSA_GWDT];
> +
> +    nodename = g_strdup_printf("/watchdog@%" PRIx64, rbase);
> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> +
> +    qemu_fdt_setprop(sms->fdt, nodename, "compatible",
> +                             compat, sizeof(compat));
> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE,
> +                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE);
> +    qemu_fdt_setprop_cells(sms->fdt, nodename, "interrupts",
> +                                GIC_FDT_IRQ_TYPE_PPI, irq,
> +                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop_cell(sms->fdt, nodename, "timeout-sec", 30);
> +    g_free(nodename);
> +}
> +

Is this actually used anywhere? I ask because SBSA-ref is not a FDT
booting machine and only uses FDT to transfer some dynamic info to
arm-tf/edk2 and is not a full description tree. Your ACPI patch in
edk2 certainly does not use this info.

Graeme


>  /*
>   * Firmware on this machine only uses ACPI table to load OS, these limited
>   * device tree nodes are just to let firmware know the info which varies from
> @@ -219,6 +252,7 @@ static void create_fdt(SBSAMachineState *sms)
>  
>          g_free(nodename);
>      }
> +    create_wdt_fdt(sms);
>  }
>  
>  #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
> @@ -447,6 +481,20 @@ static void create_rtc(const SBSAMachineState *sms)
>      sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
>  }
>  
> +static void create_wdt(const SBSAMachineState *sms)
> +{
> +    hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
> +    hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
> +    DeviceState *dev = qdev_new(TYPE_WDT_SBSA_GWDT);
> +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +    int irq = sbsa_ref_irqmap[SBSA_GWDT];
> +
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, rbase);
> +    sysbus_mmio_map(s, 1, cbase);
> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
> +}
> +
>  static DeviceState *gpio_key_dev;
>  static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
>  {
> @@ -730,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
>  
>      create_rtc(sms);
>  
> +    create_wdt(sms);
> +
>      create_gpio(sms);
>  
>      create_ahci(sms);
> -- 
> 2.18.4
> 
> 

