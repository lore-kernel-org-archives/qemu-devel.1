Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E3721906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E3721906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNi0w-0000lh-AB
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhrE-0006zp-DT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhrC-00055J-Ry
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:29:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35591)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhrC-000559-J2; Thu, 24 Oct 2019 14:29:10 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mwfn8-1i4GJp0IN0-00y8rv; Thu, 24 Oct 2019 20:28:39 +0200
Subject: Re: [PATCH v2 09/14] hw: Move Xilinx ZynqMP RTC from hw/timer/ to
 hw/rtc/ subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-10-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bc3e0ca3-b27e-5aab-2ccc-405738984d10@vivier.eu>
Date: Thu, 24 Oct 2019 20:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bq7Fupdr8AAYDtF1cwbkxvjscRpOik20xQbT/TOGcAMI21nLj0O
 GH8O4fTH1qRMV65MoCzqF/QRjG+AHMYnpZqMP0gyiRjRx6gMZ7iuYm4kLjwPxYiJ8CTMEnG
 J6t69sdwNDrNmttjR1z35Q4sP0VgC1K3l+CUVZ7ZeestXE3Vp89+fh6/K5xMwlKZQajAgO6
 pdxUlJw7ADfzHy/UlHznQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kaE7kVtHIpE=:WNOu72aZmpGUuqlHnK+1KA
 i8BftJ84chPN/Fylqb95w1BbbY+y/Z2FBiO2yrGsH7AIjcICSyhTW78h0FtzmhGowsiJ8huoB
 0z7ioZlNDBiv0bP+L4dcPfYo2wv9weup9gcUc0EZ6SZ3zJlGSFeU6VJ/IX3OMLI45NrhuMo5V
 t+QeCAH1gMHYT+YCd0KOEA4R1nOAhZ6+3xmfhqNzLFi/X+XJ0e259qKEGwfV2DA+EOrebeZVD
 aTyajHJod0bPZ2tLcESjxS90/lzs2m7SlvtJG8FLb/4UxmbxUu5p3ReDCJUVwW0vBpbsxYqfq
 n/N9lcYXKJOk5OXlvq2stPFjjJHjcpyb/EOXwDu2w+z8iQIfjUd2JW7bnBa0QkzUMgnzX3kky
 4tzy4LmkDiZbGc1DmhzOGR3l7NuuJPYtW4tRSd1sKvX2BIi92yMcOQUMtPz7+ej+/qhAVZSXr
 YbiArFOwkluvPQGub3RBxh/T9d7RoJNXWLNw0zDKOW0YJ6XC55JUSMcT4n/fKTvQGblPsapOa
 +whZK+SZjOzgck228m7Dp+o+MolEgE7aa057ky5cnZDi+TvIn9U6yBmvGLBylz0zTX0NGQqc9
 a2Hk0ANNgaNgGEpY7iQobC00Zbv2s8FYuRCnclTkCXV57+7a5V2i5CEVn1sFUd/7oz09332XT
 AOPnlI6i/O0Vtr5orIaLlh9Y5118GNJxAicea5emnHaiqK8rYjpkdi8oToijt17ElGqCHKH1S
 jR6neB5FIlMQoZETG4OnFmbGzsvY3KMLzULVmbJS8CBikOtmPx8SJ/w8xL4PXCLiElBb1yuNr
 nAJfR/GPMKk8WNElWGuVGpLq5mOu2z5Tncn9KIfHi1+LDyYX7kn9KyTv1243cC7lAew/y9Klw
 uitPEtj+90P11vkSGfbpMuyQL6RWy6in/aN/J2j40=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/10/2019 à 01:03, Philippe Mathieu-Daudé a écrit :
> Move RTC devices under the hw/rtc/ subdirectory.
> 
> Remove Alistair outdated email address (see commit c22e580c2ad).
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/rtc/Makefile.objs                        | 1 +
>  hw/rtc/trace-events                         | 3 +++
>  hw/{timer => rtc}/xlnx-zynqmp-rtc.c         | 2 +-
>  hw/timer/Makefile.objs                      | 1 -
>  hw/timer/trace-events                       | 3 ---
>  include/hw/arm/xlnx-zynqmp.h                | 2 +-
>  include/hw/{timer => rtc}/xlnx-zynqmp-rtc.h | 6 +++---
>  7 files changed, 9 insertions(+), 9 deletions(-)
>  rename hw/{timer => rtc}/xlnx-zynqmp-rtc.c (99%)
>  rename include/hw/{timer => rtc}/xlnx-zynqmp-rtc.h (95%)
> 
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index b195863291..543a550a0f 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -6,5 +6,6 @@ common-obj-$(CONFIG_M48T59) += m48t59-isa.o
>  endif
>  common-obj-$(CONFIG_PL031) += pl031.o
>  common-obj-$(CONFIG_TWL92230) += twl92230.o
> +common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index ac9e0e0fba..7f1945ad4c 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -4,6 +4,9 @@
>  sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
>  sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
>  
> +# xlnx-zynqmp-rtc.c
> +xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
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
> @@ -14,7 +14,6 @@ common-obj-$(CONFIG_IMX) += imx_epit.o
>  common-obj-$(CONFIG_IMX) += imx_gpt.o
>  common-obj-$(CONFIG_LM32) += lm32_timer.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
> -common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
>  common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
>  
>  common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index ce34b967db..1459d07237 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -70,9 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>  
> -# xlnx-zynqmp-rtc.c
> -xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
> -
>  # nrf51_timer.c
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
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
> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-zynqmp-rtc.h
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
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
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
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

