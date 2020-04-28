Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF342C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E13A206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG+7lRQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E13A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUaA-0001zN-NQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTUYd-0000Gf-KB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTUX1-0004ZE-ER
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:02:11 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTUX1-0004Xr-0y; Tue, 28 Apr 2020 14:00:31 -0400
Received: by mail-il1-x144.google.com with SMTP id b18so21446211ilf.2;
 Tue, 28 Apr 2020 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eTGHaiQaTrtcvvEPtiVdKxZQewm9tPmt1wD8ZN2vLg4=;
 b=HG+7lRQDgbYRGUiVe+Gapzexmkpt9H8s7rnSFgwm6uuD9m3w/XBTDUUkGcH1L3DTKj
 tVgkytD4sGHavanfi9G9qBcumqSECfWaM9/LklS2uf0kGeJE+OKp1er3LpUd0DAW2h24
 sTarT6cpC4bC7p6UsnrdWSlE5dzDkvHmFCHx32MTZ3MhHu1tghRto/jbJRHcNxMHsLJb
 ofL3myEWpRRxfwR78/EMOm7FZBYQuZbnMpX0BLykEk8xSYB8soelmXw2zVfGhlvQ/Icz
 kx45qwe3SR2Qrc+GilgV/QpY4RSEtFGspUMxUqhkxibZoNOBXlntj5XqBuXdNTOIdiVt
 heiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eTGHaiQaTrtcvvEPtiVdKxZQewm9tPmt1wD8ZN2vLg4=;
 b=bCOKVy9ddQxZXakgtgxGq8FlvexwiMk0qT320xmV1Ok4UX4rHFWbqkMhS66poDq1fi
 BKkeSTWr7dGGyrgoDQ5MuRNL6HrZpptenW2Di36J8zVl2i6EEsYFFfnjxlvwg2p2GpFJ
 eELNXoX/egvDgJ1K2SXZu+06NBgFwcJGgfXxRkRh5VuyM6fCBrxLc5c98oJocwwGFhpN
 FSi0GkoMu8UTldpoVssvYqRH0yQZyS9ahEwICQpDbSLLooFnTtoeMCyxIfea56e+8q0K
 iPsjRVFixNfF8TBqBCA7jQGV86/GDpwJaIJ4crxoroIMWlnp+FacRxGktPcxBRIN284e
 V6CQ==
X-Gm-Message-State: AGi0PuY+R4JZnJlth+Krb8qiK+Y7pZ/tek0kdOgBhWrL3s6JeSNWfzaU
 rG+nUPCH/zV5elMWymoTXGNuyM8B8/O+padV8ko=
X-Google-Smtp-Source: APiQypLDJauFuGh3HO9eZF7AQsBmdQ/fTJiuuMfE+o1poo4COk2m44o7bfEijtkpkVrnfPWyIbyJX4aX6JGoWTnw9Ms=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr28452479ili.267.1588096829152; 
 Tue, 28 Apr 2020 11:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-10-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-10-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2020 10:51:49 -0700
Message-ID: <CAKmqyKMJRu2f_tdRTiB6eyTvULZ-MVR40NaT59pc40GUcLzF2g@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] hw/arm: versal: Add support for the RTC
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:23 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> hw/arm: versal: Add support for the RTC.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal.c         | 21 +++++++++++++++++++++
>  include/hw/arm/xlnx-versal.h |  8 ++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index e263bdf77a..321171bcce 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -240,6 +240,26 @@ static void versal_create_sds(Versal *s, qemu_irq *pic)
>      }
>  }
>
> +static void versal_create_rtc(Versal *s, qemu_irq *pic)
> +{
> +    SysBusDevice *sbd;
> +    MemoryRegion *mr;
> +
> +    sysbus_init_child_obj(OBJECT(s), "rtc", &s->pmc.rtc, sizeof(s->pmc.rtc),
> +                          TYPE_XLNX_ZYNQMP_RTC);
> +    sbd = SYS_BUS_DEVICE(&s->pmc.rtc);
> +    qdev_init_nofail(DEVICE(sbd));
> +
> +    mr = sysbus_mmio_get_region(sbd, 0);
> +    memory_region_add_subregion(&s->mr_ps, MM_PMC_RTC, mr);
> +
> +    /*
> +     * TODO: Connect the ALARM and SECONDS interrupts once our RTC model
> +     * supports them.
> +     */
> +    sysbus_connect_irq(sbd, 1, pic[VERSAL_RTC_APB_ERR_IRQ]);
> +}
> +
>  /* This takes the board allocated linear DDR memory and creates aliases
>   * for each split DDR range/aperture on the Versal address map.
>   */
> @@ -323,6 +343,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> +    versal_create_rtc(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index e11693e29d..9c9f47ba9d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -19,6 +19,7 @@
>  #include "hw/char/pl011.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -65,6 +66,8 @@ typedef struct Versal {
>          struct {
>              SDHCIState sd[XLNX_VERSAL_NR_SDS];
>          } iou;
> +
> +        XlnxZynqMPRTC rtc;
>      } pmc;
>
>      struct {
> @@ -89,7 +92,10 @@ typedef struct Versal {
>  #define VERSAL_GEM1_IRQ_0          58
>  #define VERSAL_GEM1_WAKE_IRQ_0     59
>  #define VERSAL_ADMA_IRQ_0          60
> +#define VERSAL_RTC_APB_ERR_IRQ     121
>  #define VERSAL_SD0_IRQ_0           126
> +#define VERSAL_RTC_ALARM_IRQ       142
> +#define VERSAL_RTC_SECONDS_IRQ     143
>
>  /* Architecturally reserved IRQs suitable for virtualization.  */
>  #define VERSAL_RSVD_IRQ_FIRST 111
> @@ -143,4 +149,6 @@ typedef struct Versal {
>  #define MM_PMC_SD0_SIZE             0x10000
>  #define MM_PMC_CRP                  0xf1260000U
>  #define MM_PMC_CRP_SIZE             0x10000
> +#define MM_PMC_RTC                  0xf12a0000
> +#define MM_PMC_RTC_SIZE             0x10000
>  #endif
> --
> 2.20.1
>
>

