Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B349C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EA22082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EA22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRKx5-000143-1u
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 14:17:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRKvt-0000fn-ER
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRKvq-0006HV-PH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:16:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRKvp-0006GY-UK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:16:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so4442404wrs.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xMrTMzOlKgxn3I62LlUVAWexg6HxDX7fHLvmab4aAVw=;
	b=TvIWdiulqzKCGaF2TNTThv12NZY916Cp2+kFsdEXwnlOlYVPu8z5atMUateuQ41u4z
	tcWnk19wkLlP83tKP2AiCcNpJcUmmJVjJoUBPlY7ZXLciQTYoWhCbUrtzzapQ/jAvvG8
	Er/bKfJ4HBNAtRMGd5dGJLYPR/Skzhd6rCiOQ6SNezsvqB5/PyaTGPzQUh5SkxnUSwXq
	rFjaKIo4P4Ae/8d3w8rp2T3MAIrQ1PsTGCeKUeqkdnhEGvxEYRO5Ej4tV942SaAxKY21
	j0KtfhS9947m4Xt8PfwGGBVG+XN9OMcqGqRKPOVXn8zcUJwfugBHGSY5ckDtDLLg+AF7
	TgCg==
X-Gm-Message-State: APjAAAX4rbZvBKpzYjt5CxlyVhz0QnbqgDWUEqKFRdaAotCbBJa/I0AU
	74Or3vsPpjaaiuL0XAIynhB3rgUKuA4=
X-Google-Smtp-Source: APXvYqwGxj7702YG0Sj5d1MjsSAxQEEZFQlbX5FQgOdIqGAiBfgdlps0VAwr/RNp5O2ihFUyur48bQ==
X-Received: by 2002:a5d:5501:: with SMTP id b1mr12284443wrv.222.1558030600598; 
	Thu, 16 May 2019 11:16:40 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	v17sm4136520wmc.30.2019.05.16.11.16.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 11:16:39 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190516163857.6430-1-peter.maydell@linaro.org>
	<20190516163857.6430-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f56bfa7c-4f77-3200-b3d7-c11d4e9b1558@redhat.com>
Date: Thu, 16 May 2019 20:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516163857.6430-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/3] arm: Rename hw/arm/arm.h to
 hw/arm/boot.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 6:38 PM, Peter Maydell wrote:
> The header file hw/arm/arm.h now includes only declarations
> relating to hw/arm/boot.c functionality. Rename it accordingly,
> and adjust its header comment.
> 
> The bulk of this commit was created via
>  perl -pi -e 's|hw/arm/arm.h|hw/arm/boot.h|' hw/arm/*.c include/hw/arm/*.h
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/allwinner-a10.h   | 2 +-
>  include/hw/arm/aspeed_soc.h      | 2 +-
>  include/hw/arm/bcm2836.h         | 2 +-
>  include/hw/arm/{arm.h => boot.h} | 8 ++++----
>  include/hw/arm/fsl-imx25.h       | 2 +-
>  include/hw/arm/fsl-imx31.h       | 2 +-
>  include/hw/arm/fsl-imx6.h        | 2 +-
>  include/hw/arm/fsl-imx6ul.h      | 2 +-
>  include/hw/arm/fsl-imx7.h        | 2 +-
>  include/hw/arm/virt.h            | 2 +-
>  include/hw/arm/xlnx-versal.h     | 2 +-
>  include/hw/arm/xlnx-zynqmp.h     | 2 +-
>  hw/arm/armsse.c                  | 2 +-
>  hw/arm/armv7m.c                  | 2 +-
>  hw/arm/aspeed.c                  | 2 +-
>  hw/arm/boot.c                    | 2 +-
>  hw/arm/collie.c                  | 2 +-
>  hw/arm/exynos4210.c              | 2 +-
>  hw/arm/exynos4_boards.c          | 2 +-
>  hw/arm/highbank.c                | 2 +-
>  hw/arm/integratorcp.c            | 2 +-
>  hw/arm/mainstone.c               | 2 +-
>  hw/arm/microbit.c                | 2 +-
>  hw/arm/mps2-tz.c                 | 2 +-
>  hw/arm/mps2.c                    | 2 +-
>  hw/arm/msf2-soc.c                | 2 +-
>  hw/arm/msf2-som.c                | 2 +-
>  hw/arm/musca.c                   | 2 +-
>  hw/arm/musicpal.c                | 2 +-
>  hw/arm/netduino2.c               | 2 +-
>  hw/arm/nrf51_soc.c               | 2 +-
>  hw/arm/nseries.c                 | 2 +-
>  hw/arm/omap1.c                   | 2 +-
>  hw/arm/omap2.c                   | 2 +-
>  hw/arm/omap_sx1.c                | 2 +-
>  hw/arm/palm.c                    | 2 +-
>  hw/arm/raspi.c                   | 2 +-
>  hw/arm/realview.c                | 2 +-
>  hw/arm/spitz.c                   | 2 +-
>  hw/arm/stellaris.c               | 2 +-
>  hw/arm/stm32f205_soc.c           | 2 +-
>  hw/arm/strongarm.c               | 2 +-
>  hw/arm/tosa.c                    | 2 +-
>  hw/arm/versatilepb.c             | 2 +-
>  hw/arm/vexpress.c                | 2 +-
>  hw/arm/virt.c                    | 2 +-
>  hw/arm/xilinx_zynq.c             | 2 +-
>  hw/arm/xlnx-versal.c             | 2 +-
>  hw/arm/z2.c                      | 2 +-
>  49 files changed, 52 insertions(+), 52 deletions(-)
>  rename include/hw/arm/{arm.h => boot.h} (98%)
> 
> diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
> index 389e128d0fc..6305b9c586f 100644
> --- a/include/hw/arm/allwinner-a10.h
> +++ b/include/hw/arm/allwinner-a10.h
> @@ -3,7 +3,7 @@
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "hw/char/serial.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/timer/allwinner-a10-pit.h"
>  #include "hw/intc/allwinner-a10-pic.h"
>  #include "hw/net/allwinner_emac.h"
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 11ec0179db5..24078fd1895 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -12,7 +12,7 @@
>  #ifndef ASPEED_SOC_H
>  #define ASPEED_SOC_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"

I guess we can drop this one...

>  #include "hw/intc/aspeed_vic.h"
>  #include "hw/misc/aspeed_scu.h"
>  #include "hw/misc/aspeed_sdmc.h"
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index 93248399ba0..1b04a0e7fe8 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -11,7 +11,7 @@
>  #ifndef BCM2836_H
>  #define BCM2836_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"

... this one too ...

>  #include "hw/arm/bcm2835_peripherals.h"
>  #include "hw/intc/bcm2836_control.h"
>  
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/boot.h
> similarity index 98%
> rename from include/hw/arm/arm.h
> rename to include/hw/arm/boot.h
> index ba3a9b41422..c48cc4c2bca 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/boot.h
> @@ -1,5 +1,5 @@
>  /*
> - * Misc ARM declarations
> + * ARM kernel loader.
>   *
>   * Copyright (c) 2006 CodeSourcery.
>   * Written by Paul Brook
> @@ -8,8 +8,8 @@
>   *
>   */
>  
> -#ifndef HW_ARM_H
> -#define HW_ARM_H
> +#ifndef HW_ARM_BOOT_H
> +#define HW_ARM_BOOT_H
>  
>  #include "exec/memory.h"
>  #include "target/arm/cpu-qom.h"
> @@ -167,4 +167,4 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
>                                              const struct arm_boot_info *info,
>                                              hwaddr mvbar_addr);
>  
> -#endif /* HW_ARM_H */
> +#endif /* HW_ARM_BOOT_H */
> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
> index 65a73714efe..3280ab1fb05 100644
> --- a/include/hw/arm/fsl-imx25.h
> +++ b/include/hw/arm/fsl-imx25.h
> @@ -17,7 +17,7 @@
>  #ifndef FSL_IMX25_H
>  #define FSL_IMX25_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/intc/imx_avic.h"
>  #include "hw/misc/imx25_ccm.h"
>  #include "hw/char/imx_serial.h"
> diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
> index d408abbba0d..e68a81efd75 100644
> --- a/include/hw/arm/fsl-imx31.h
> +++ b/include/hw/arm/fsl-imx31.h
> @@ -17,7 +17,7 @@
>  #ifndef FSL_IMX31_H
>  #define FSL_IMX31_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/intc/imx_avic.h"
>  #include "hw/misc/imx31_ccm.h"
>  #include "hw/char/imx_serial.h"
> diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
> index 06f8aaeda42..1265a55c3b0 100644
> --- a/include/hw/arm/fsl-imx6.h
> +++ b/include/hw/arm/fsl-imx6.h
> @@ -17,7 +17,7 @@
>  #ifndef FSL_IMX6_H
>  #define FSL_IMX6_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/misc/imx6_ccm.h"
>  #include "hw/misc/imx6_src.h"
> diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
> index 58972171943..9e94e98f8ee 100644
> --- a/include/hw/arm/fsl-imx6ul.h
> +++ b/include/hw/arm/fsl-imx6ul.h
> @@ -17,7 +17,7 @@
>  #ifndef FSL_IMX6UL_H
>  #define FSL_IMX6UL_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/cpu/a15mpcore.h"
>  #include "hw/misc/imx6ul_ccm.h"
>  #include "hw/misc/imx6_src.h"
> diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
> index d848262bfdd..4101f80251e 100644
> --- a/include/hw/arm/fsl-imx7.h
> +++ b/include/hw/arm/fsl-imx7.h
> @@ -19,7 +19,7 @@
>  #ifndef FSL_IMX7_H
>  #define FSL_IMX7_H
>  
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/cpu/a15mpcore.h"
>  #include "hw/intc/imx_gpcv2.h"
>  #include "hw/misc/imx7_ccm.h"
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 424070924ed..73005f05ae8 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -34,7 +34,7 @@
>  #include "exec/hwaddr.h"
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index ec7c859d08c..14405c1465d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -13,7 +13,7 @@
>  #define XLNX_VERSAL_H
>  
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/intc/arm_gicv3.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index 591515c7600..cd90b04310c 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -18,7 +18,7 @@
>  #ifndef XLNX_ZYNQMP_H
>  
>  #include "qemu-common.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/intc/arm_gic.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/char/cadence_uart.h"
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 76cc6905798..83b920334d5 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -17,7 +17,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/registerfields.h"
>  #include "hw/arm/armsse.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  
>  /* Format of the System Information block SYS_CONFIG register */
>  typedef enum SysConfigFormat {
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index c4b2a9a1f5c..029572258f0 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -13,7 +13,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 29d225ed140..415cff7a015 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -14,7 +14,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "exec/address-spaces.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index a830655e1af..7279185bd94 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -12,7 +12,7 @@
>  #include "qapi/error.h"
>  #include <libfdt.h>
>  #include "hw/hw.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/linux-boot-if.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
> index d12604c5739..3db3c560048 100644
> --- a/hw/arm/collie.c
> +++ b/hw/arm/collie.c
> @@ -14,7 +14,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
>  #include "strongarm.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/block/flash.h"
>  #include "exec/address-spaces.h"
>  #include "cpu.h"
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index af82e955421..0bf61134550 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -30,7 +30,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/loader.h"
>  #include "hw/arm/exynos4210.h"
>  #include "hw/sd/sdhci.h"
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index ea8100f65a8..71f0af3bdbb 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -29,7 +29,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/sysbus.h"
>  #include "net/net.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "exec/address-spaces.h"
>  #include "hw/arm/exynos4210.h"
>  #include "hw/net/lan9118.h"
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 96ccf18d863..a89a1d3a7c1 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -20,7 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/loader.h"
>  #include "net/net.h"
>  #include "sysemu/kvm.h"
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 0b6f24465e4..d18caab8bdd 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -13,7 +13,7 @@
>  #include "cpu.h"
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/misc/arm_integrator_debug.h"
>  #include "hw/net/smc91c111.h"
>  #include "net/net.h"
> diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
> index c1cec590379..cd1f904c6c9 100644
> --- a/hw/arm/mainstone.c
> +++ b/hw/arm/mainstone.c
> @@ -16,7 +16,7 @@
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/arm/pxa.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "net/net.h"
>  #include "hw/net/smc91c111.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index da67bf6d9d1..e9a891f7d37 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/boards.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index 7832408bb70..c167a5fa593 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -40,7 +40,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/armv7m.h"
>  #include "hw/or-irq.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 54b7395849f..b74f1378c90 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/armv7m.h"
>  #include "hw/or-irq.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 2702e90b453..92e2b418757 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -26,7 +26,7 @@
>  #include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"

... and this one too, it is not required.

>  #include "exec/address-spaces.h"
>  #include "hw/char/serial.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
> index 2432b5e9352..8c550a8bddc 100644
> --- a/hw/arm/msf2-som.c
> +++ b/hw/arm/msf2-som.c
> @@ -27,7 +27,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "exec/address-spaces.h"
>  #include "hw/arm/msf2-soc.h"
>  #include "cpu.h"
> diff --git a/hw/arm/musca.c b/hw/arm/musca.c
> index 23aff43f4bc..825d80e75a4 100644
> --- a/hw/arm/musca.c
> +++ b/hw/arm/musca.c
> @@ -24,7 +24,7 @@
>  #include "qapi/error.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/armsse.h"
>  #include "hw/boards.h"
>  #include "hw/char/pl011.h"
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 93ec3c5698f..5645997b56f 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -14,7 +14,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "net/net.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> index f936017d4a7..f57fc38f920 100644
> --- a/hw/arm/netduino2.c
> +++ b/hw/arm/netduino2.c
> @@ -27,7 +27,7 @@
>  #include "hw/boards.h"
>  #include "qemu/error-report.h"
>  #include "hw/arm/stm32f205_soc.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  
>  static void netduino2_init(MachineState *machine)
>  {
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 3e633d160ea..ce618edc7b3 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
>  #include "hw/misc/unimp.h"
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 303f7a31e1c..4a79f5c88b4 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -25,7 +25,7 @@
>  #include "qemu/bswap.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/omap.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/irq.h"
>  #include "ui/console.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 539d29ef9ce..28fbe275a88 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -24,7 +24,7 @@
>  #include "cpu.h"
>  #include "hw/boards.h"
>  #include "hw/hw.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/omap.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/soc_dma.h"
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index 446223906e4..23e72db79ef 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -26,7 +26,7 @@
>  #include "sysemu/qtest.h"
>  #include "hw/boards.h"
>  #include "hw/hw.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/omap.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/timer.h"
> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
> index 95a4fe7e7f0..cae78d0a368 100644
> --- a/hw/arm/omap_sx1.c
> +++ b/hw/arm/omap_sx1.c
> @@ -31,7 +31,7 @@
>  #include "ui/console.h"
>  #include "hw/arm/omap.h"
>  #include "hw/boards.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/qtest.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 139d27d1cc0..9eb9612bce9 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -25,7 +25,7 @@
>  #include "ui/console.h"
>  #include "hw/arm/omap.h"
>  #include "hw/boards.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/input/tsc2xxx.h"
>  #include "hw/loader.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index fe2bb511b98..2b5fe10e2f0 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -20,7 +20,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "sysemu/sysemu.h"
>  
>  #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
> index 05a244df255..d42a76e7a1c 100644
> --- a/hw/arm/realview.c
> +++ b/hw/arm/realview.c
> @@ -12,7 +12,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/primecell.h"
>  #include "hw/net/lan9118.h"
>  #include "hw/net/smc91c111.h"
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 22f5958b9da..723cf5d5929 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -14,7 +14,7 @@
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/arm/pxa.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/pcmcia.h"
>  #include "hw/i2c/i2c.h"
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 5059aedbaa2..499035f5c8f 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -11,7 +11,7 @@
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/ssi/ssi.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "qemu/timer.h"
>  #include "hw/i2c/i2c.h"
>  #include "net/net.h"
> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> index 980e5af13c5..a5b6f7bda2b 100644
> --- a/hw/arm/stm32f205_soc.c
> +++ b/hw/arm/stm32f205_soc.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "exec/address-spaces.h"
>  #include "hw/arm/stm32f205_soc.h"
>  
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 644a9c45b4e..a1ecbddaab9 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -33,7 +33,7 @@
>  #include "hw/sysbus.h"
>  #include "strongarm.h"
>  #include "qemu/error-report.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "chardev/char-fe.h"
>  #include "chardev/char-serial.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 9a1247797fe..7843d68d465 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -15,7 +15,7 @@
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "hw/arm/pxa.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/sharpsl.h"
>  #include "hw/pcmcia.h"
>  #include "hw/boards.h"
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index 25166e15171..f471fb70255 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -12,7 +12,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/net/smc91c111.h"
>  #include "net/net.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index d8634f3dd29..2b3b0c2334e 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -26,7 +26,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/primecell.h"
>  #include "hw/net/lan9118.h"
>  #include "hw/i2c/i2c.h"
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5331ab71e22..bf54f10b515 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -33,7 +33,7 @@
>  #include "qemu/option.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/arm/primecell.h"
>  #include "hw/arm/virt.h"
>  #include "hw/block/flash.h"
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index b3b82157597..198e3f97634 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -20,7 +20,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "net/net.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 5ee58c09be8..e8e4278eb3b 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -17,7 +17,7 @@
>  #include "net/net.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "kvm_arm.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/intc/arm_gicv3_common.h"
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index 1f906ef20bc..44aa748d39d 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -14,7 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "hw/arm/pxa.h"
> -#include "hw/arm/arm.h"
> +#include "hw/arm/boot.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/ssi/ssi.h"
>  #include "hw/boards.h"
> 

