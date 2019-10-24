Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B781ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD0E20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD0E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNi4C-0000c2-M3
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhlQ-00055u-6z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhlO-0003ZC-UB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:23:12 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhlH-0003Xd-0P; Thu, 24 Oct 2019 14:23:03 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MdNse-1hoMw61rJQ-00ZNzB; Thu, 24 Oct 2019 20:22:34 +0200
Subject: Re: [PATCH v2 05/14] hw: Move M41T80 device from hw/timer/ to hw/rtc/
 subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-6-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a6585a5e-a799-3560-e8d0-ff9d90da5a6b@vivier.eu>
Date: Thu, 24 Oct 2019 20:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rCZ0gk4SLjdSQEZtjETCdA1tlPbZFpCrE9ttv61mMmrokOLqT0C
 VvqHSNASVvZbBIg9DcqDG591wM73DltYGIdS81WAH6qTFUbcR3qpIo4oanSbXugtio8Rh9P
 rhm0h3EgAb0s132hUhJRVqe/5R/zBBnHqBNrq/YnyNcoOxNNPNYjGmAZFqsOm2WJsJlH6PV
 o5+CDvM+wT44n+lXV9TsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yuYZIuBJP5Y=:vmUidam2hEcwL06veaBzWH
 oJJKnrqNcqGCYXhva6Jh9aM4L1joyo9szvJIkAc8jku1OXBvLONvZlF883qu+fBp6flYyujXN
 CMMvjpCGLMy6gf50o6NslVhtdVNXFXTURBn97ESJ3F3fwlUkC3B9teyY4txB56KY5go9tJwMB
 rlVGo976g8cKI/1XjezODT3VKwWAtGmYbsKduWVbib2SB+FpOxbwzIJtjRKi+IEofL8zA87Ou
 Nscu6waRDFXC6CxfeTQIoG3pdkUMtI+WC4WllAqRCQ7F94tARYUFhH3KYwh8FjBftPogAvbFz
 Okz2t/MmLsVCNQJjvsvkUK2TRZ6B7pmHq0zDGXmwA6Q8VuoPtfokuhZbvZfnTcgxeqCW8Biet
 3bB+2kI1PtwmtkP2wTNPNTAM7uFPuoLwi4N/j5LDfuHqrhbu0kmkgHxrts46bK2e2YT51GKLY
 hkaCqMwXskn/7F9NriHJpW+r0TEkqtv2eCOOTZVK8XNRHniz3LjsH/myWoT3kdFYTfyB3vn6k
 anxagJoLCiFGKVBuQwXS8WoN5pEbv+HfAbZJ4ovsvL8EeyBX41V2Rw56KRVw6VAuFXOA0mDw0
 5lOxkA2aRaqDVgwoSt3Gc6gzsL/XaQWKcnI7ymA6/CCCmgvE9HGDwBhJLAhNnYC2D7FwE1BGU
 aXGF9iEseCKq78HmfPdT2FcBtc1KYdp9+dYWw/R6kH0RtZ6b6QipHiPQsQFx3qAserLVUBqFB
 ASuXfSGIqscpWHk5PCtolyobNrsIr1PSRlVSAV0ydh8CvH5ym6ITaT6WjtWWi/k8+MVXNLdmW
 i/Xv2zdjwJ1mZ1mt8uQqkUvmzFsW3WI2gw3GrnDAW271nK10LB6w1anFsqc590Bna9x61YZY6
 KsdMZtLnRV20zvPG0fJ6axomGJmf3P8KuXC/TaS14=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
> The M41T80 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS                | 2 +-
>  hw/rtc/Kconfig             | 4 ++++
>  hw/rtc/Makefile.objs       | 1 +
>  hw/{timer => rtc}/m41t80.c | 0
>  hw/timer/Kconfig           | 4 ----
>  hw/timer/Makefile.objs     | 1 -
>  6 files changed, 6 insertions(+), 6 deletions(-)
>  rename hw/{timer => rtc}/m41t80.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d85424a33..0dfaa05d17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1113,7 +1113,7 @@ F: hw/ppc/sam460ex.c
>  F: hw/ppc/ppc440_pcix.c
>  F: hw/display/sm501*
>  F: hw/ide/sii3112.c
> -F: hw/timer/m41t80.c
> +F: hw/rtc/m41t80.c
>  F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 159c233517..434b20b2b1 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,3 +1,7 @@
> +config M41T80
> +    bool
> +    depends on I2C
> +
>  config M48T59
>      bool
>  
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index c87f81405e..89e8e48c64 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1,3 +1,4 @@
> +common-obj-$(CONFIG_M41T80) += m41t80.o
>  common-obj-$(CONFIG_M48T59) += m48t59.o
>  ifeq ($(CONFIG_ISA_BUS),y)
>  common-obj-$(CONFIG_M48T59) += m48t59-isa.o
> diff --git a/hw/timer/m41t80.c b/hw/rtc/m41t80.c
> similarity index 100%
> rename from hw/timer/m41t80.c
> rename to hw/rtc/m41t80.c
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index a57e9b59fc..a6b668b255 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -20,10 +20,6 @@ config HPET
>  config I8254
>      bool
>  
> -config M41T80
> -    bool
> -    depends on I2C
> -
>  config TWL92230
>      bool
>      depends on I2C
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index fe2d1fbc40..2fb12162a6 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -6,7 +6,6 @@ common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) += ds1338.o
>  common-obj-$(CONFIG_HPET) += hpet.o
>  common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
> -common-obj-$(CONFIG_M41T80) += m41t80.o
>  common-obj-$(CONFIG_PUV3) += puv3_ost.o
>  common-obj-$(CONFIG_TWL92230) += twl92230.o
>  common-obj-$(CONFIG_XILINX) += xilinx_timer.o
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

