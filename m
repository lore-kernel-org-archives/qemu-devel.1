Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12FDC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7E3214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyjMBjcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7E3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yt7-0003c1-SV
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9ysB-0002xV-Bj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9ys9-0003ST-Vj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:49:27 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:40346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9ys9-0003R3-EC; Mon, 16 Sep 2019 17:49:25 -0400
Received: by mail-lf1-x143.google.com with SMTP id d17so1158305lfa.7;
 Mon, 16 Sep 2019 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NzxXs4o3NeHDe5JtjbvD9yEbrLpqukH5enerL1/zo5w=;
 b=eyjMBjcP5ghXs08FlCMsqr6C6p3U2DDldyHamNUnKfsIKQ25Wv6ajmiG5aHu85oESM
 2NwM4qQlxa6Kj+6QSSi6aDD9VYNBkL7FB+3Ps8XTTHqo1tJjsNVfiROoFbQte/A3V/G4
 qPIxNXkJm1Sr6drh24jgdv2wGoVc176VZSdfm2edlSAXxIX9NdoUEh0+tBYehp64PjP9
 hv619Befz2xJ1sS1vzWC6RhHPqsiJ+yotnubveuEL5ncPnkXx0HV0Y6cIblRM9ASuuNF
 ACclbLr08IiP7QMsqoES+ZvBGbcBwgsKEoUE8OR2CQpj1vrEn1Pt+MD1+a8DX6ZGlJpN
 dIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NzxXs4o3NeHDe5JtjbvD9yEbrLpqukH5enerL1/zo5w=;
 b=lNHwdzc/FsaNdvtb9DSXS+NDIoRkLKdw8qS3ADQTkpYvMtmy/oDD8P6Xjg1bdCOCIc
 aKOvWbeiNFoqbPVX3fEa9E3w+Esg/bj4SzI/HY7U1/kLSuwGFxkQf4LTxpbuCBNcArtW
 ZTFMWR881x7xDqE/ask+QyU7YQuzslDuS4IF7CMcgSAsR0JM4qTJxCABVzFJoBdtdUMe
 gX23hoodJBopnP6vHsBZT0gz3Kwv9HiE0d+i6+7sCYMjMWWbgyFIG7epwRNLcnfOsWYE
 6m9femTdqbRQAil+UMWYIiaeXHiW8NINgnwgWB8J/etW5/2k56zGCBaJlEpk7sFeaCG1
 l7hA==
X-Gm-Message-State: APjAAAWrWqBWwijIQ68uhdQtyvgWh+CqFcXQfv3b+kl8Q4MC5++20+Db
 5+bSwcl5l50uBpQt5Q5kkayqe/NbrI23ox8zBZY=
X-Google-Smtp-Source: APXvYqy1KUi/bzgrI/HXVT/CgLctEpEKC59vJABh3L7+QhK+qCo7V++xR8MdOsWerLBTyFmxsSuDGEeWP1LNPfsPD7Q=
X-Received: by 2002:a19:4912:: with SMTP id w18mr171914lfa.93.1568670563824;
 Mon, 16 Sep 2019 14:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-10-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-10-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:44:53 -0700
Message-ID: <CAKmqyKPtRbU5X-72+HfNNbaV46LOD6D+JLQoGiBROB+zJczNgA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 09/13] hw: Move Xilinx ZynqMP RTC from
 hw/timer/ to hw/rtc/ subdirectory
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 8:56 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Move RTC devices under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/rtc/Makefile.objs                        | 1 +
>  hw/rtc/trace-events                         | 3 +++
>  hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.c         | 2 +-
>  hw/timer/Makefile.objs                      | 1 -
>  hw/timer/trace-events                       | 3 ---
>  include/hw/arm/xlnx-zynqmp.h                | 2 +-
>  include/hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.h | 6 +++---
>  7 files changed, 9 insertions(+), 9 deletions(-)
>  rename hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.c (99%)
>  rename include/hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.h (95%)
>
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index b195863291..543a550a0f 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -6,5 +6,6 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
>  endif
>  common-obj-$(CONFIG_PL031) +=3D pl031.o
>  common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
> +common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index ac9e0e0fba..7f1945ad4c 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -4,6 +4,9 @@
>  sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
>  sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
>
> +# xlnx-zynqmp-rtc.c
> +xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
> +
>  # pl031.c
>  pl031_irq_state(int level) "irq state %d"
>  pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
> similarity index 99%
> rename from hw/timer/xlnx-zynqmp-rtc.c
> rename to hw/rtc/xlnx-zynqmp-rtc.c
> index 5692db98c2..f9f09b7296 100644
> --- a/hw/timer/xlnx-zynqmp-rtc.c
> +++ b/hw/rtc/xlnx-zynqmp-rtc.c
> @@ -36,7 +36,7 @@
>  #include "qemu/cutils.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -#include "hw/timer/xlnx-zynqmp-rtc.h"
> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "migration/vmstate.h"
>
>  #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 70b61b69c7..294465ef47 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -14,7 +14,6 @@ common-obj-$(CONFIG_IMX) +=3D imx_epit.o
>  common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
>  common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
> -common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>  common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
>
>  common-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index ce34b967db..1459d07237 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -70,9 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: r=
eset"
>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
>
> -# xlnx-zynqmp-rtc.c
> -xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
> -
>  # nrf51_timer.c
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read add=
r 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index d7483c3b42..53076fa29a 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -29,7 +29,7 @@
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/display/xlnx_dp.h"
>  #include "hw/intc/xlnx-zynqmp-ipi.h"
> -#include "hw/timer/xlnx-zynqmp-rtc.h"
> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "hw/cpu/cluster.h"
>  #include "target/arm/cpu.h"
>
> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-zyn=
qmp-rtc.h
> similarity index 95%
> rename from include/hw/timer/xlnx-zynqmp-rtc.h
> rename to include/hw/rtc/xlnx-zynqmp-rtc.h
> index 97e32322ed..6fa1cb2f43 100644
> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
> +++ b/include/hw/rtc/xlnx-zynqmp-rtc.h
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2017 Xilinx Inc.
>   *
> - * Written-by: Alistair Francis <alistair.francis@xilinx.com>
> + * Written-by: Alistair Francis

Why remove the email address?

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>   * of this software and associated documentation files (the "Software"),=
 to deal
> @@ -24,8 +24,8 @@
>   * THE SOFTWARE.
>   */
>
> -#ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
> -#define HW_TIMER_XLNX_ZYNQMP_RTC_H
> +#ifndef HW_RTC_XLNX_ZYNQMP_H
> +#define HW_RTC_XLNX_ZYNQMP_H
>
>  #include "hw/register.h"
>  #include "hw/sysbus.h"
> --
> 2.20.1
>
>

