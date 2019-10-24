Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD608CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B292220659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B292220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNiAx-0004ia-SR
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhv2-0004lW-Qw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhv0-0006Wt-9O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:33:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37023)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhur-0006TN-RB; Thu, 24 Oct 2019 14:32:58 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOAFl-1iclvY0gi9-00OaIN; Thu, 24 Oct 2019 20:32:37 +0200
Subject: Re: [PATCH v2 11/14] hw: Move Aspeed RTC from hw/timer/ to hw/rtc/
 subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-12-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1ecac6c1-b778-0fff-669b-0b340e6a9a27@vivier.eu>
Date: Thu, 24 Oct 2019 20:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y8pj1M03ww/yRTIRFgMq+k/ytz3sn7QmztpzPQyEAX25QsstFUV
 Qik+5fuMfJVLJtG7ZPwL4lBLhmVZgm3NmDzru8R3tIY76QglClFSu8J82mHznIrnpNVeOmd
 b0Ydx7r7/RNSnjZ2qw/FlbXWEaXDq07mgK5Sm6dDk58hpswJC4uR9BvemQoDoYwOCg0mYS3
 eZRrMUOErkWMZaM9jU7aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4o8UcCQJBs0=:xv8ew00Yy+/gp8gbvN1svg
 J2HBgU02VTGioVFOdbM80FpHXXboRC7CDcnZoadszKuwxmqYAV+atWiBQTP21cRlozm2Igs9K
 ZJKAAyqYRVhE+wCrfAVfPxVNrCjCdJIt93GFy8eE36z+8DHx6XhH+4Y0+ge40UWDTZoM2U2wU
 lyRFVg2dqN1DpPZkefGq/jGpJQm9Vk0Cd09qf2UymyVp7gb1q3zXBsbfiwGdVMTpHioAnY3H9
 6yULrq+M+UyZJweh/mFHH2fW/GCNXb623gAh3hOMy8KN+fhlx6o3e0tH+A+beA/s+6BpHB76M
 j72oQSl7WVyJbo1lz8J9fID7CSyCNrRT3gBAGd+9YUyjPsr56mEc4N0l4eODOo5aMxwuu7O1k
 dCYPvJIHAQ8x4vcowdR6FByu+u9TaGqqqrrvCvEjaR2rwlaHVWHswIp2IRsicO0ocN8yaMrm0
 66kSnFZvJh5q/bTXKzZEix7SbT/43VwWdzI7h7IhhDRL1KdafcNr0E3bKM+8AYMVAlNnKgvqS
 ZX6APWBETK/IAZjdsSFRACnpGISglSu+dV1p+IqaBhc9rwO8WX42GD+dNsYmDaPpedOQw/d50
 r4UvmozNzuZ7o+jmJki66ns1vGd6ZNm0rdYDCbhcYIPGkHpivvs7G8Sx8AlbOzvzyW0WBpFhd
 56iyorK6WaLvxkiPxuomlWFNa+S2cvTqa9spIr+ZW+QIHZq7xZxtCm7yi32CraYehY31QyDDy
 k9TMGZJsiPbOerMWvaY6tb90UOcDgIH2TDWdltz62lLDdGO4J5GA6h8ZK+KM5KMsMknxpeeXF
 2w6wiQfJx+2F+bpNGncYVC1r5YquQamxElEN3pM4ZAFqtm3xBupXxsWoz7CCx1hVhzjtds5y1
 fH6UPSlJgtLc7EtlN8+1IEHsfxP8x0XEF3z3Ihpoo=
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

Le 04/10/2019 à 01:04, Philippe Mathieu-Daudé a écrit :
> Move RTC devices under the hw/rtc/ subdirectory.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/rtc/Makefile.objs                   | 1 +
>  hw/{timer => rtc}/aspeed_rtc.c         | 2 +-
>  hw/rtc/trace-events                    | 4 ++++
>  hw/timer/Makefile.objs                 | 2 +-
>  hw/timer/trace-events                  | 4 ----
>  include/hw/arm/aspeed_soc.h            | 2 +-
>  include/hw/{timer => rtc}/aspeed_rtc.h | 6 +++---
>  7 files changed, 11 insertions(+), 10 deletions(-)
>  rename hw/{timer => rtc}/aspeed_rtc.c (99%)
>  rename include/hw/{timer => rtc}/aspeed_rtc.h (84%)
> 
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 3d4763fc26..8dc9fcd3a9 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -10,3 +10,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
>  common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
> +common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
> diff --git a/hw/timer/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
> similarity index 99%
> rename from hw/timer/aspeed_rtc.c
> rename to hw/rtc/aspeed_rtc.c
> index 5313017353..3ca1183558 100644
> --- a/hw/timer/aspeed_rtc.c
> +++ b/hw/rtc/aspeed_rtc.c
> @@ -8,7 +8,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "hw/timer/aspeed_rtc.h"
> +#include "hw/rtc/aspeed_rtc.h"
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/timer.h"
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index 7f1945ad4c..d6749f4616 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -13,3 +13,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl031_alarm_raised(void) "alarm raised"
>  pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> +
> +# aspeed-rtc.c
> +aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> +aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 33191d74cb..83091770df 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -29,7 +29,7 @@ common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
>  common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>  
>  common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
> -common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
> +common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>  
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 1459d07237..e18b87fc96 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -66,10 +66,6 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
>  cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>  
> -# hw/timer/aspeed-rtc.c
> -aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> -aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> -
>  # nrf51_timer.c
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index ab5052b12c..5a443006ed 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -17,7 +17,7 @@
>  #include "hw/misc/aspeed_sdmc.h"
>  #include "hw/misc/aspeed_xdma.h"
>  #include "hw/timer/aspeed_timer.h"
> -#include "hw/timer/aspeed_rtc.h"
> +#include "hw/rtc/aspeed_rtc.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/watchdog/wdt_aspeed.h"
> diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc.h
> similarity index 84%
> rename from include/hw/timer/aspeed_rtc.h
> rename to include/hw/rtc/aspeed_rtc.h
> index 15ba42912b..3fde854ad9 100644
> --- a/include/hw/timer/aspeed_rtc.h
> +++ b/include/hw/rtc/aspeed_rtc.h
> @@ -5,8 +5,8 @@
>   * Copyright 2019 IBM Corp
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -#ifndef ASPEED_RTC_H
> -#define ASPEED_RTC_H
> +#ifndef HW_RTC_ASPEED_RTC_H
> +#define HW_RTC_ASPEED_RTC_H
>  
>  #include <stdint.h>
>  
> @@ -27,4 +27,4 @@ typedef struct AspeedRtcState {
>  #define TYPE_ASPEED_RTC "aspeed.rtc"
>  #define ASPEED_RTC(obj) OBJECT_CHECK(AspeedRtcState, (obj), TYPE_ASPEED_RTC)
>  
> -#endif /* ASPEED_RTC_H */
> +#endif /* HW_RTC_ASPEED_RTC_H */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

