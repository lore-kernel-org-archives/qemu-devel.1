Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C69EC04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728042177B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4U5ODXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728042177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQSFf-0004DC-2w
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQSF1-0003XV-0k
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:29:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQSEy-0005dS-V7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:29:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id k8so3517860pfk.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gXySFSe7BSV2hdffHRu4SpO23sw3sc9BbkqTBcwuMpY=;
 b=S4U5ODXPTyk+DSjwKf3ZyvbHlgExxz3TTWEkDgUbFLFF4AoeOY3MICuqmyIZIRAfJm
 OzZiLUVA9Ci8QlG9hyqwz79Uxz2DML9xhveTWJK9Lwdqv2HtkbUDtDsdVACS4vt/kJCS
 RazTcQc8SMhumNqLoURR1ZPI2tKAF+eQgoXpjZljLeb90sk4B18tjzTDptcgBDHhPRlo
 7tmWjIPoOPMm2poa2PJPxl/ruJs21BcbR7P7KVBNLraDuZuhKJN+alvClr+p8A7Cx+1d
 bJ2fxjYNNpIHJZJOIXG8+FGmTy42i40KiiFKWQxoTS7rPk2Wc3nCUvYcTx8PzlzVtI43
 SMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gXySFSe7BSV2hdffHRu4SpO23sw3sc9BbkqTBcwuMpY=;
 b=Y6oJjTVZmPA8cdSE82biz+eGVDJbx+c+AC41BVKMx1Cfjmtqai+IL5i9tmdXnftIx2
 91YzV4WPtGcchIY7txM6TgWxzRzICze9wwbKyNxY9Ql+uvzYKSWVygB42FWyfFaWHxYN
 AyLG2oJ6Yfr53AzR3Xx8h9R/hYiw89NKvPnSxQCvpRFHjVgpAez3nTLdkZTVGV1MWXXc
 ++JosxdYCcpKv2Z39tWOwPvOzUY9EMNO95DpXvtRLIxHjuP3dwfZXe3uTcdIEvco4HLC
 h4kVCOKi6KWEu57Dus1IIgsWxethv19u4/6EfAedd3+qhe1lVK11HnpQHLJEFrCOr9WN
 j7nw==
X-Gm-Message-State: AOAM531BEao2wKBF5wTdJBZl86/i6mPJVfTtRgJZVyUTBaWwlQMfk2s2
 /Z7H0/9a/Wuj/G2e/21z/fx3jVM+zG0S8XexQLuaKQ==
X-Google-Smtp-Source: ABdhPJygrjW4Ubfuov/sJRRXpaL3YxAyOwI+wViQKp97QNGa1mUpVfczpAwwBu0Z1NjFvpTiUVrxscywIib9PE5CXEc=
X-Received: by 2002:a62:6408:0:b029:154:dde2:a5eb with SMTP id
 y8-20020a6264080000b0290154dde2a5ebmr7142859pfb.30.1602149374690; Thu, 08 Oct
 2020 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201008024203.112303-1-shashi.mallela@linaro.org>
 <20201008024203.112303-3-shashi.mallela@linaro.org>
In-Reply-To: <20201008024203.112303-3-shashi.mallela@linaro.org>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 8 Oct 2020 12:29:23 +0300
Message-ID: <CAD8XO3bdJZBqcpvH+8X6U_FXjj3DTmK=doWk=JTyWaAwLpEt3Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] hw/arm/sbsa-ref: add SBSA watchdog device
To: Shashi Mallela <shashi.mallela@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, leif@nuviainc.com,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi.

one small note below in this email.

On Thu, 8 Oct 2020 at 05:43, Shashi Mallela <shashi.mallela@linaro.org> wrote:
>
> Included the newly implemented SBSA generic watchdog device model into
> SBSA platform
>
> Signed-off-by: Shashi Mallela <shashi.mallela@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9c3a893bedfd..1e6ef124924c 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -40,6 +40,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/usb.h"
>  #include "hw/char/pl011.h"
> +#include "hw/watchdog/wdt_sbsa_gwdt.h"
>  #include "net/net.h"
>  #include "qom/object.h"
>
> @@ -64,6 +65,9 @@ enum {
>      SBSA_GIC_DIST,
>      SBSA_GIC_REDIST,
>      SBSA_SECURE_EC,
> +    SBSA_GWDT,
> +    SBSA_GWDT_REFRESH,
> +    SBSA_GWDT_CONTROL,
>      SBSA_SMMU,
>      SBSA_UART,
>      SBSA_RTC,
> @@ -104,6 +108,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
>      [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
>      [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
> +    [SBSA_GWDT_REFRESH] =       { 0x50010000, 0x00001000 },
> +    [SBSA_GWDT_CONTROL] =       { 0x50011000, 0x00001000 },
>      [SBSA_UART] =               { 0x60000000, 0x00001000 },
>      [SBSA_RTC] =                { 0x60010000, 0x00001000 },
>      [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
> @@ -133,6 +139,7 @@ static const int sbsa_ref_irqmap[] = {
>      [SBSA_SECURE_UART_MM] = 9,
>      [SBSA_AHCI] = 10,
>      [SBSA_EHCI] = 11,
> +    [SBSA_GWDT] = 12,
>  };
>
>  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> @@ -141,6 +148,26 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
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
> +
> +    nodename = g_strdup_printf("/watchdog@%" PRIx64, rbase);
> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> +
> +    qemu_fdt_setprop(sms->fdt, nodename, "compatible",
> +                             compat, sizeof(compat));
> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> +                                 2, rbase, 2, SBSA_GWDT_RMMIO_SIZE,
> +                                 2, cbase, 2, SBSA_GWDT_CMMIO_SIZE);

You can also add "interrupts" here if you implemented irq in the driver.

BR,
Maxim.

> +    qemu_fdt_setprop_cell(sms->fdt, nodename, "timeout-sec", 30);
> +    g_free(nodename);
> +}
> +
>  /*
>   * Firmware on this machine only uses ACPI table to load OS, these limited
>   * device tree nodes are just to let firmware know the info which varies from
> @@ -219,6 +246,7 @@ static void create_fdt(SBSAMachineState *sms)
>
>          g_free(nodename);
>      }
> +    create_wdt_fdt(sms);
>  }
>
>  #define SBSA_FLASH_SECTOR_SIZE (256 * KiB)
> @@ -447,6 +475,20 @@ static void create_rtc(const SBSAMachineState *sms)
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
> @@ -730,6 +772,8 @@ static void sbsa_ref_init(MachineState *machine)
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

