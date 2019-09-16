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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C776C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54920214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR9/yDBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54920214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yxi-0008P6-Gn
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9ytR-0004Ov-SJ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9ytQ-0004so-FD
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:50:45 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9ytQ-0004sN-7S; Mon, 16 Sep 2019 17:50:44 -0400
Received: by mail-lf1-x141.google.com with SMTP id w67so1176282lff.4;
 Mon, 16 Sep 2019 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YoJRfBU5zcC9rebBXB1WKzYqvS9INh8kMdNQatVJ5kY=;
 b=HR9/yDBVYf8KwlYsfzsZHBvEj/XTkxWeRwWUrT6hujgezLXRanYnveYYmz84IxYTNf
 uqLRNTtXw22jhCQY9cgpCToUkoXk19Ypne+Xg/TMTLXOYdGpGZ9xH92YasceoYbHPyeT
 Mgsdav4hVVW+Qkvy480ZLattlHnwvq/0eWp8t9MSx6ZCrRe/EinMxlc3CsGi8zz38kla
 2m0ywuCD+9R2o/bFuz6NVYy0GI1GzKP5ID0M3fZl654g4lIa75nWcSM8N3KoRZ/QQIp3
 fz7ira6gYDO08UGkfQ+Iy81hDlJy/Xi/zHaEv8brxcalDl5MSuZVkQFDVlLYbMMA3Neh
 HxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YoJRfBU5zcC9rebBXB1WKzYqvS9INh8kMdNQatVJ5kY=;
 b=XGn87vWUvh6QlCdptSOVKAQ42O60aRyWZmLEcY09XdyzXr9sB0moFnzXOpF5qf4hoL
 nJpZ6d7vYy7H6oRiyQRZalW8qD7M7anIh9/C5DHM2BKnH6mnXEonszHZ1bD8rzxX84T9
 z0TDGbjj8y+0W/46JQLbyjAXIby0R2xKhzrRxbPJ3fcg5pACI33l7+rRm+/5CliaefEM
 HUrj1JMqRue7L5glbqq30Sr5/nBd6YMdUoX6IDDqgK7uGM/g/TEJkHGV1SGSg2uo6Ox6
 dLB+jY5o02qWezG4mhOhc/z/TvahCmCsqG/sp8wD/q+xdoSFPSL4zmE4fsvugt6vw8/S
 vVQA==
X-Gm-Message-State: APjAAAWi/8D72RGwTwCM/WSfAQkr79Q7plhrEfgqxtOL/DiW8CZKjbHi
 cM9FfC4OUTq+TTRkzZeqUNOPt2Uh17Cq2YKzoGk=
X-Google-Smtp-Source: APXvYqw61Jf+aQSVBX5/swSVEBYPheP65uS9hs2E/VHzS0or0F/qHxxLRdDVvbaeFq4l3N8606k3m9m1k2QvL82F3rg=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr198168lfh.44.1568670643099;
 Mon, 16 Sep 2019 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-12-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-12-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:46:12 -0700
Message-ID: <CAKmqyKNg_wofzFTLakKsq3mUiiQ0rn-or8x4mFcQHk1WN5P7Qw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH 11/13] hw: Move Aspeed RTC from hw/timer/
 to hw/rtc/ subdirectory
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

On Mon, Sep 16, 2019 at 9:17 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Move RTC devices under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/rtc/Makefile.objs                   | 1 +
>  hw/{timer =3D> rtc}/aspeed_rtc.c         | 2 +-
>  hw/rtc/trace-events                    | 4 ++++
>  hw/timer/Makefile.objs                 | 2 +-
>  hw/timer/trace-events                  | 4 ----
>  include/hw/arm/aspeed_soc.h            | 2 +-
>  include/hw/{timer =3D> rtc}/aspeed_rtc.h | 3 ---
>  7 files changed, 8 insertions(+), 10 deletions(-)
>  rename hw/{timer =3D> rtc}/aspeed_rtc.c (99%)
>  rename include/hw/{timer =3D> rtc}/aspeed_rtc.h (92%)
>
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 3d4763fc26..8dc9fcd3a9 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -10,3 +10,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>  common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> +common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o
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
> @@ -13,3 +13,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x =
value 0x%08x"
>  pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl031_alarm_raised(void) "alarm raised"
>  pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> +
> +# aspeed-rtc.c
> +aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
> +aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 33191d74cb..83091770df 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -29,7 +29,7 @@ common-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
>  common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
>
>  common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
> -common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
> +common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
>
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 1459d07237..e18b87fc96 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -66,10 +66,6 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t dat=
a, unsigned size) "CMSDK A
>  cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size)=
 "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %=
u"
>  cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>
> -# hw/timer/aspeed-rtc.c
> -aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
> -aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
> -
>  # nrf51_timer.c
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read add=
r 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
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
> similarity index 92%
> rename from include/hw/timer/aspeed_rtc.h
> rename to include/hw/rtc/aspeed_rtc.h
> index 15ba42912b..156c8faee3 100644
> --- a/include/hw/timer/aspeed_rtc.h
> +++ b/include/hw/rtc/aspeed_rtc.h
> @@ -8,9 +8,6 @@
>  #ifndef ASPEED_RTC_H
>  #define ASPEED_RTC_H
>
> -#include <stdint.h>
> -
> -#include "hw/irq.h"
>  #include "hw/sysbus.h"
>
>  typedef struct AspeedRtcState {
> --
> 2.20.1
>
>

