Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B93C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CD120878
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CD120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgsJ-0001AW-SN
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:05:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgqV-00009v-3j
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgqT-0000lz-6J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:03:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJgqR-0000hV-Jn
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:03:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so224774wrp.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VtFwsE2vBK5FTGSVOx0mSHOnbfKt3X6MtftagcvAYgc=;
	b=XTmsHfdNlB0D/3qAqkqJdytLvCAKFJWelZH/llZ8ZT5Ng+YMi9DSERBzwIIlUcsmFz
	Fv6z89sfRcJBYzJknDLHuZb/b9u4kg08rMW5/icaQ0rW59bItrqbv0i8ruXWPoAXczZL
	mFPGcscrvETNhVLTaEt70BYyT+JNyN8XkSoPIewl/rkbo0qBL3LBrIzJsA1OCuAW4rHS
	2kdQyEg6dX13WMJlkEFcc1FEprB1aGcJC1Pgpvt720dnDnVJt1wsYNOiToU5reWRlfVz
	FhRblrxIvMVkUHtXIvrK7UWyKgnJWg4Wfa9RokZxTuwGfC94+JjWmMUuPVmqwNIxc+1Q
	dvgQ==
X-Gm-Message-State: APjAAAVQPlOLp/ns7QTiJZODLJqF+BSehHI5O2hMcktXk4xzakIZLlFp
	E0C9Fht/Db38YIwwyS6shBHxug==
X-Google-Smtp-Source: APXvYqxjv0NFw7gcXij+xyPyGdjW3fwk8Q6tPNsXIlYlF0aGTWiI0oYJkv1tyA6Src8YhdRoRpF6dA==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr25498071wru.125.1556208209761;
	Thu, 25 Apr 2019 09:03:29 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	u6sm41766585wrg.72.2019.04.25.09.03.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:03:29 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-13-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b0e5f10d-3a2e-0244-6f73-b7323b3cc95e@redhat.com>
Date: Thu, 25 Apr 2019 18:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-13-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 12/29] hw/arm: Express
 dependencies of the PXA2xx machines with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425160326.Mim254-7ZHAvUnYWPTPy1UCdEyEyU9FFCnEiHGPlYUY@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the PXA2xx machines (akita, borzoi,
> connex and verdex gumstix, tosa, mainstone, spitz, terrier and z2).
> This patch is based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 15 ++++--------
>  hw/arm/Kconfig                  | 42 +++++++++++++++++++++++++++++++++
>  hw/arm/Makefile.objs            |  5 +++-
>  3 files changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index df7d9421e0..f39a854f2e 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,22 +19,20 @@ CONFIG_STELLARIS=y
>  CONFIG_REALVIEW=y
>  CONFIG_VERSATILE=y
>  CONFIG_VEXPRESS=y
> +CONFIG_MAINSTONE=y
> +CONFIG_GUMSTIX=y
> +CONFIG_SPITZ=y
> +CONFIG_TOSA=y
> +CONFIG_Z2=y
>  
>  CONFIG_VGA=y
> -CONFIG_NAND=y
> -CONFIG_ECC=y
> -CONFIG_SERIAL=y
> -CONFIG_MAX7310=y
>  CONFIG_TMP421=y
>  CONFIG_PCA9552=y
> -CONFIG_ADS7846=y
> -CONFIG_MAX111X=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  CONFIG_FTGMAC100=y
>  CONFIG_DS1338=y
> -CONFIG_MICRODRIVE=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
> @@ -42,16 +40,13 @@ CONFIG_NETDUINO2=y
>  
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
> -CONFIG_PXA2XX=y
>  CONFIG_FRAMEBUFFER=y
>  CONFIG_XILINX_SPIPS=y
>  CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_DIGIC=y
> -CONFIG_MAINSTONE=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> -CONFIG_ZAURUS=y
>  CONFIG_ZYNQ=y
>  CONFIG_STM32F2XX_TIMER=y
>  CONFIG_STM32F2XX_USART=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b786cfc5bd..101de74260 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -48,6 +48,9 @@ config INTEGRATOR
>  
>  config MAINSTONE
>      bool
> +    select PXA2XX
> +    select PFLASH_CFI01
> +    select SMC91C111
>  
>  config MUSICPAL
>      bool
> @@ -85,6 +88,43 @@ config OMAP
>  
>  config PXA2XX
>      bool
> +    select FRAMEBUFFER
> +    select I2C
> +    select SERIAL
> +    select SD
> +    select SSI
> +    select USB_OHCI
> +
> +config GUMSTIX
> +    bool
> +    select PFLASH_CFI01
> +    select SMC91C111
> +    select PXA2XX
> +
> +config TOSA
> +    bool
> +    select ZAURUS  # scoop
> +    select MICRODRIVE
> +    select PXA2XX
> +
> +config SPITZ
> +    bool
> +    select ADS7846 # display
> +    select MAX111X # A/D converter
> +    select WM8750  # audio codec
> +    select MAX7310 # GPIO expander
> +    select ZAURUS  # scoop
> +    select NAND    # memory
> +    select ECC     # Error-correcting for NAND
> +    select MICRODRIVE
> +    select PXA2XX
> +
> +config Z2
> +    bool
> +    select PFLASH_CFI01
> +    select WM8750
> +    select PL011 # UART
> +    select PXA2XX
>  
>  config REALVIEW
>      bool
> @@ -217,6 +257,8 @@ config MSF2
>  
>  config ZAURUS
>      bool
> +    select NAND
> +    select ECC
>  
>  config A9MPCORE
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index bd0b45a799..00328d1b0b 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -11,7 +11,10 @@ obj-$(CONFIG_NETDUINO2) += netduino2.o
>  obj-$(CONFIG_NSERIES) += nseries.o
>  obj-$(CONFIG_SX1) += omap_sx1.o
>  obj-$(CONFIG_CHEETAH) += palm.o
> -obj-$(CONFIG_PXA2XX) += gumstix.o spitz.o tosa.o z2.o
> +obj-$(CONFIG_GUMSTIX) += gumstix.o
> +obj-$(CONFIG_SPITZ) += spitz.o
> +obj-$(CONFIG_TOSA) += tosa.o
> +obj-$(CONFIG_Z2) += z2.o
>  obj-$(CONFIG_REALVIEW) += realview.o
>  obj-$(CONFIG_STELLARIS) += stellaris.o
>  obj-$(CONFIG_STRONGARM) += collie.o
> 

