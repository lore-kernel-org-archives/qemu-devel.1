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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819CC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2F5206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvCejE/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2F5206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yf1-00059o-5l
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9ybI-0002PG-Fk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9ybG-0005Jh-G4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:32:00 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9ybG-0005J0-6q; Mon, 16 Sep 2019 17:31:58 -0400
Received: by mail-lj1-x242.google.com with SMTP id v24so1386338ljj.3;
 Mon, 16 Sep 2019 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZXzw5LMlyWRU9v9VwKPopFpn5OHw7FaTjj6xXjG9ahw=;
 b=kvCejE/BTtHlOR77RFIxk6096OIrmR0cG1YC3YHd4tfxN0CrVXVsVQePn0wpEbSFCh
 X3l67dqPVgnypx7EbSa8x9lw+6XMUIiAYvL3Jx+ZgxhHw4pzwDuX8/OTNic+7/gLgr+4
 snazezd48uljzHYjB8wW88g3F3ce8uGYEJ4qpiO/dJSvyNjTEOYBXNqQOEC+aWST51Rg
 Io80bYC9Q52cQYTIfs6OOFnESk2bk3B7reup4NzNgUHePaME3DyZR/VoxWVm08slNqYW
 ht20N+z+J1JrsYf2B+a2Sz22nA1yp1JUMEPE6kGix/qlXikh9YaaLjCS2zqSb6zB/DMK
 DURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZXzw5LMlyWRU9v9VwKPopFpn5OHw7FaTjj6xXjG9ahw=;
 b=NppzlttrtLPUMUObAvoAOrsrZlquIKOZBjukdNSZ89LyKUoufWT2gsjj5To0nTX3iO
 fR/j2uPzLyP6KegaZUzHH33q9EFRmH7LTXzLyGQclIEg9hFT0w13asm5wX2zFBOw7BRd
 1rxZ6tgVA85BWmxcwUeBfW0qwLDfOT9UAKjL/gqzsuh9QLkpIQtO70VQuEVgUS6iSZ0/
 vymgNqkhwJcd362gkcYFFleuZzzd0WcX8B7O1stNw8jKdw89SNiDJ9JFLsOzI767+YnA
 thVgoNTpelZXTa1eKjWQjVcx/yQWg/B8GFEA7cRMfWtzfmH42pFi5+IRNDKCcgZNOFii
 Mz4A==
X-Gm-Message-State: APjAAAWMha2Sv93L6NnzZboAiAXjBl8rBxWfN76UpOBJ3d1HW9VTU334
 IjXqfVos04/GGTH0/dDAiCDanbQGbDOVAjRUUTs=
X-Google-Smtp-Source: APXvYqzVn+JXEh5vE/b6fGaO5J6+NyKv2+K2kB8/9pkQEWAejuwtdbnKLeWNdULu/06WI2hhloqwd1xGAOUZhA3F4eo=
X-Received: by 2002:a2e:91d9:: with SMTP id u25mr3432ljg.85.1568669516227;
 Mon, 16 Sep 2019 14:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-7-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-7-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:27:25 -0700
Message-ID: <CAKmqyKO5ww_Q3-XHKG8GwLHvS=crhfy-PDJpDWm_xgwEMYVDJQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 06/13] hw: Move sun4v hypervisor RTC from
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

On Mon, Sep 16, 2019 at 9:30 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Move RTC devices under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                   |  4 ++--
>  hw/rtc/Kconfig                |  3 +++
>  hw/rtc/Makefile.objs          |  1 +
>  hw/{timer =3D> rtc}/sun4v-rtc.c |  2 +-
>  hw/rtc/trace-events           |  4 ++++
>  hw/sparc64/niagara.c          |  2 +-
>  hw/timer/Kconfig              |  3 ---
>  hw/timer/Makefile.objs        |  1 -
>  hw/timer/trace-events         |  4 ----
>  include/hw/rtc/sun4v-rtc.h    | 19 +++++++++++++++++++
>  include/hw/timer/sun4v-rtc.h  |  1 -
>  11 files changed, 31 insertions(+), 13 deletions(-)
>  rename hw/{timer =3D> rtc}/sun4v-rtc.c (98%)
>  create mode 100644 include/hw/rtc/sun4v-rtc.h
>  delete mode 100644 include/hw/timer/sun4v-rtc.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd68b2383a..fb9a1ed075 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1165,8 +1165,8 @@ Sun4v
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
>  F: hw/sparc64/niagara.c
> -F: hw/timer/sun4v-rtc.c
> -F: include/hw/timer/sun4v-rtc.h
> +F: hw/rtc/sun4v-rtc.c
> +F: include/hw/rtc/sun4v-rtc.h
>
>  Leon3
>  M: Fabien Chouteau <chouteau@adacore.com>
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 434b20b2b1..cc7fead764 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -10,3 +10,6 @@ config PL031
>
>  config MC146818RTC
>      bool
> +
> +config SUN4V_RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 89e8e48c64..4621b37bc2 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -5,3 +5,4 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
>  endif
>  common-obj-$(CONFIG_PL031) +=3D pl031.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
> +common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> diff --git a/hw/timer/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> similarity index 98%
> rename from hw/timer/sun4v-rtc.c
> rename to hw/rtc/sun4v-rtc.c
> index 54272a822f..ada01b5774 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -13,7 +13,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> -#include "hw/timer/sun4v-rtc.h"
> +#include "hw/rtc/sun4v-rtc.h"
>  #include "trace.h"
>
>
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index 54c94ac557..ac9e0e0fba 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -1,5 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
> +# sun4v-rtc.c
> +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
> +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> +
>  # pl031.c
>  pl031_irq_state(int level) "irq state %d"
>  pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 167143bffe..dfa0817eae 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -30,7 +30,7 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/loader.h"
>  #include "hw/sparc/sparc64.h"
> -#include "hw/timer/sun4v-rtc.h"
> +#include "hw/rtc/sun4v-rtc.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index a6b668b255..b04c928136 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -35,9 +35,6 @@ config ALLWINNER_A10_PIT
>  config STM32F2XX_TIMER
>      bool
>
> -config SUN4V_RTC
> -    bool
> -
>  config CMSDK_APB_TIMER
>      bool
>      select PTIMER
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 2fb12162a6..034bd30255 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -35,7 +35,6 @@ common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a=
10-pit.o
>  common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
>
> -common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
>  common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 6936fe8573..ce34b967db 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -70,10 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: =
reset"
>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
>
> -# sun4v-rtc.c
> -sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
> -sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> -
>  # xlnx-zynqmp-rtc.c
>  xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>
> diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
> new file mode 100644
> index 0000000000..fd868f6ed2
> --- /dev/null
> +++ b/include/hw/rtc/sun4v-rtc.h
> @@ -0,0 +1,19 @@
> +/*
> + * QEMU sun4v Real Time Clock device
> + *
> + * The sun4v_rtc device (sun4v tod clock)
> + *
> + * Copyright (c) 2016 Artyom Tarasenko
> + *
> + * This code is licensed under the GNU GPL v3 or (at your option) any la=
ter
> + * version.
> + */
> +
> +#ifndef HW_RTC_SUN4V
> +#define HW_RTC_SUN4V
> +
> +#include "exec/hwaddr.h"
> +
> +void sun4v_rtc_init(hwaddr addr);
> +
> +#endif
> diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
> deleted file mode 100644
> index 407278f918..0000000000
> --- a/include/hw/timer/sun4v-rtc.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -void sun4v_rtc_init(hwaddr addr);
> --
> 2.20.1
>
>

