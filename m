Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E07206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtRc2Yqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E07206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXCH-0008Sd-ST
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joX9F-00052j-2U; Thu, 25 Jun 2020 15:02:57 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joX9D-0005V9-AT; Thu, 25 Jun 2020 15:02:56 -0400
Received: by mail-io1-xd44.google.com with SMTP id f23so7264534iof.6;
 Thu, 25 Jun 2020 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d/A/l6vg+RhDpqLSHIO/nKjT2AsX6yvVGRtu53DWYpI=;
 b=XtRc2YqmCqZx8CiQKQY2TUtpTe+GMTvqkZWVR1a5V2cZvUyJYt8rLfUYAf8QuMGChC
 Y+4Mf/XURIVE1ZheyNXbh6EJu/GkTvfxzEH9kzNuGJgExhqcIWqmukL2Jbn6XiSNq2mi
 L2YHOtuBNhEmIOpXnIXe0HYSupTkDliPavhU3m/NjraT9aD9hCTZmKMnVfH2B8yycYg8
 W1lQVQ0BeJvcD4oxWfYy9gWvQzXMr1DrVpQUHT7KMyRWnn4x+3HlB/wUxB5QwMF+wwbb
 VJNXB8rLynkzhnIH2tHJx3sZpTFMWTRzA9hhR60muFjFeKDceQmF5JujGapJiFbCn+V3
 JPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d/A/l6vg+RhDpqLSHIO/nKjT2AsX6yvVGRtu53DWYpI=;
 b=Thlwt50XL5wsuzWYsmn2jCI1o1T77irbdQ/bISQpZnlkPBzdZ2EP3plTuTU2bpzt3w
 7Z9JkPun+TOlI6D70hvcczdyvChvz8ATf2jmXAIs0Qh/oAQb7U6GXBN9b7wY5wKlpVdV
 6XHzatUMlAQtJjyZWU0jl8/GVetrhN7GcLJC+Dak5xKB6IRrZs3KefLbHJGcFDL/h/6/
 w1+k6ZIoOrUUbaI+KFJVs/NRnrIENBjpgTJWcZsssZ3QjLGhh6a98HVQENsggoGgydeO
 WbRI+/jPywB1P7mJNTlgkm+ATDSgPJqx6moJL3bmX+BycDjBkXgXTPCHhUn3nW+KmfKD
 CGIw==
X-Gm-Message-State: AOAM533h0YDBkgttZ/Rzv0f5dqDvjDqh62bK2W5zVZ/3dzy6gLaWGa4O
 mSYg35Zfv+sWFUEwShvK/yAcSIygM9jU+dNq/FxINiSh
X-Google-Smtp-Source: ABdhPJzSKzQoZOWGXiSCtUlw7GlhVsCgiDX11MrOghtm84L+Yo3CtEPUa+4VPtzzj/8RHbprKv0Gp+MM469/ysEzpRM=
X-Received: by 2002:a6b:6412:: with SMTP id t18mr19541953iog.175.1593111773664; 
 Thu, 25 Jun 2020 12:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
 <1592954616-65393-3-git-send-email-fnu.vikram@xilinx.com>
In-Reply-To: <1592954616-65393-3-git-send-email-fnu.vikram@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jun 2020 11:53:17 -0700
Message-ID: <CAKmqyKM0z4dhEYgZ7e8o56BfMPw_bQzSYyOW-8hRP1XH1_j9TQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 francisco.iglesias@xilinx.com, "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 4:25 PM Vikram Garhwal <fnu.vikram@xilinx.com> wrote:
>
> Connect CAN0 and CAN1 on the ZynqMP.
>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-zynqmp.c         | 28 ++++++++++++++++++++++++++++
>  include/hw/arm/xlnx-zynqmp.h |  4 ++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 1de9d4a..3f93524 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -81,6 +81,14 @@ static const int uart_intr[XLNX_ZYNQMP_NUM_UARTS] = {
>      21, 22,
>  };
>
> +static const uint64_t can_addr[XLNX_ZYNQMP_NUM_CAN] = {
> +    0xFF060000, 0xFF070000,
> +};
> +
> +static const int can_intr[XLNX_ZYNQMP_NUM_CAN] = {
> +    23, 24,
> +};
> +
>  static const uint64_t sdhci_addr[XLNX_ZYNQMP_NUM_SDHCI] = {
>      0xFF160000, 0xFF170000,
>  };
> @@ -247,6 +255,11 @@ static void xlnx_zynqmp_init(Object *obj)
>                                  TYPE_CADENCE_UART);
>      }
>
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_initialize_child(obj, "can[*]", &s->can[i],
> +                              TYPE_XLNX_ZYNQMP_CAN);
> +    }
> +
>      object_initialize_child(obj, "sata", &s->sata, TYPE_SYSBUS_AHCI);
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> @@ -492,6 +505,21 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>                             gic_spi[uart_intr[i]]);
>      }
>
> +    for (i = 0; i < XLNX_ZYNQMP_NUM_CAN; i++) {
> +        object_property_set_int(OBJECT(&s->can[i]), i, "ctrl-idx",
> +                                &error_abort);
> +        object_property_set_int(OBJECT(&s->can[i]), XLNX_ZYNQMP_CAN_REF_CLK,
> +                                "ext_clk_freq", &error_abort);
> +        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, can_addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
> +                           gic_spi[can_intr[i]]);
> +    }
> +
>      object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
>                              &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err);
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 53076fa..dcb88e0 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -22,6 +22,7 @@
>  #include "hw/intc/arm_gic.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/char/cadence_uart.h"
> +#include "hw/net/xlnx-zynqmp-can.h"
>  #include "hw/ide/ahci.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/ssi/xilinx_spips.h"
> @@ -41,6 +42,8 @@
>  #define XLNX_ZYNQMP_NUM_RPU_CPUS 2
>  #define XLNX_ZYNQMP_NUM_GEMS 4
>  #define XLNX_ZYNQMP_NUM_UARTS 2
> +#define XLNX_ZYNQMP_NUM_CAN 2
> +#define XLNX_ZYNQMP_CAN_REF_CLK (24 * 1000 * 1000)
>  #define XLNX_ZYNQMP_NUM_SDHCI 2
>  #define XLNX_ZYNQMP_NUM_SPIS 2
>  #define XLNX_ZYNQMP_NUM_GDMA_CH 8
> @@ -92,6 +95,7 @@ typedef struct XlnxZynqMPState {
>
>      CadenceGEMState gem[XLNX_ZYNQMP_NUM_GEMS];
>      CadenceUARTState uart[XLNX_ZYNQMP_NUM_UARTS];
> +    XlnxZynqMPCANState can[XLNX_ZYNQMP_NUM_CAN];
>      SysbusAHCIState sata;
>      SDHCIState sdhci[XLNX_ZYNQMP_NUM_SDHCI];
>      XilinxSPIPS spi[XLNX_ZYNQMP_NUM_SPIS];
> --
> 2.7.4
>
>

