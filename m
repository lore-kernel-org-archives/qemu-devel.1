Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B2C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D261214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D261214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ujp-0006dn-ES
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i9uhz-0005NO-WA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i9uhu-0002e0-9z
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:22:39 -0400
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:54569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i9uhu-0002as-3B
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:22:34 -0400
Received: from player714.ha.ovh.net (unknown [10.109.143.145])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id E30071E10D2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 19:22:24 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 736D99CFA8A1;
 Mon, 16 Sep 2019 17:21:56 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-12-philmd@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <20ec7d30-a8da-9e11-acfc-b8d773a5527d@kaod.org>
Date: Mon, 16 Sep 2019 19:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916154847.28936-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 14181835229021702984
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.26
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
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/2019 17:48, Philippe Mathieu-Daud=C3=A9 wrote:
> Move RTC devices under the hw/rtc/ subdirectory.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I suppose the removal of the header files in "aspeed_rtc.h" is OK. =20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

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
>=20
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 3d4763fc26..8dc9fcd3a9 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -10,3 +10,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc=
.o
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
> =20
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
> @@ -13,3 +13,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08=
x value 0x%08x"
>  pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl031_alarm_raised(void) "alarm raised"
>  pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> +
> +# aspeed-rtc.c
> +aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " v=
alue 0x%08" PRIx64
> +aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 33191d74cb..83091770df 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -29,7 +29,7 @@ common-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
>  common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
> =20
>  common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
> -common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
> +common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
> =20
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 1459d07237..e18b87fc96 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -66,10 +66,6 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t d=
ata, unsigned size) "CMSDK A
>  cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned siz=
e) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " si=
ze %u"
>  cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
> =20
> -# hw/timer/aspeed-rtc.c
> -aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " v=
alue 0x%08" PRIx64
> -aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
> -
>  # nrf51_timer.c
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write=
 addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
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
> diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc.=
h
> similarity index 92%
> rename from include/hw/timer/aspeed_rtc.h
> rename to include/hw/rtc/aspeed_rtc.h
> index 15ba42912b..156c8faee3 100644
> --- a/include/hw/timer/aspeed_rtc.h
> +++ b/include/hw/rtc/aspeed_rtc.h
> @@ -8,9 +8,6 @@
>  #ifndef ASPEED_RTC_H
>  #define ASPEED_RTC_H
> =20
> -#include <stdint.h>
> -
> -#include "hw/irq.h"
>  #include "hw/sysbus.h"
> =20
>  typedef struct AspeedRtcState {
>=20


