Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC9C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145B720675
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 21:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145B720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJlvQ-0005B3-0F
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 17:29:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJltm-00041q-DB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJltl-0003Wt-8d
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJltl-0003W9-2l
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:27:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so1054499wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LkJ+XgrWnD9dcym4HXEVmE1TWQDjG9kFGM3z5GAHDHw=;
	b=amgCAA1wxhA39FIYliV6nPFEuzT8Tl/rywIG3rTlaGG7JeG6JgRP9wiGpV5BEDtbri
	Ik4azoRG37C6zcdsBmyOjzPwJtO9urgb51zcLnHQLwSsz9F/KJXpD/A+uEeTPWPDxkC8
	/kkcCqMUttm3Ci769c2U35eHZ1CHOsh0Q1qa/OkfxvQp3Y0ot7T1zC8NWhvouwJhfrKK
	ENzNxWdhFQELmucG/fdsMc+dn6nW4rN8Y2l+Qv/o/QUIZCIZzEnnVqxu5iy4Ij5mXTqf
	PYI2xWIOKJJ2My358NdmUIVi7li/FgxKrA7h8AV7pqKf8Ykf/XorB7/VIGK5O6z6SnKV
	+1eA==
X-Gm-Message-State: APjAAAULAkm1ruFZUf6Ijqa91GHZoVDsmJKxXhxPA/RMMW4bO39zGwxg
	T1dzUR39I/w+Vu2oAFzrDUH0JA==
X-Google-Smtp-Source: APXvYqz5YtjSgBOiR/d4mYrgq7zU+QCoKogRJ2mz3XYT854jITH8CUHB5B9g8RHlgk4qc0skZi2nAA==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr5297191wmh.0.1556227635754;
	Thu, 25 Apr 2019 14:27:15 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	y125sm34656351wmc.39.2019.04.25.14.27.12
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 14:27:14 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-18-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bc0f2e77-2f6d-bfea-6aef-4ef2f1ce5066@redhat.com>
Date: Thu, 25 Apr 2019 23:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-18-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 17/29] hw/arm: Express
 dependencies of netduino / stm32f2xx with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Peter Chubb <peter.chubb@nicta.com.au>,
	Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425212712.Kp3Ef4CF2uBnsb1iQ-47SG48QHs9ks7lbc2R-MKKvZg@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Netduino only depends on the stm32f205 SoC which in turn depends on
> its components.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 9 +--------
>  hw/arm/Kconfig                  | 7 +++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index f440a2b1cd..c86a9f5427 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -28,25 +28,18 @@ CONFIG_TOSA=y
>  CONFIG_Z2=y
>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
> +CONFIG_NETDUINO2=y
>  
>  CONFIG_VGA=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
>  
> -CONFIG_NETDUINO2=y
> -
>  CONFIG_FRAMEBUFFER=y
>  
>  CONFIG_DIGIC=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> -CONFIG_STM32F2XX_TIMER=y
> -CONFIG_STM32F2XX_USART=y
> -CONFIG_STM32F2XX_SYSCFG=y
> -CONFIG_STM32F2XX_ADC=y
> -CONFIG_STM32F2XX_SPI=y
> -CONFIG_STM32F205_SOC=y
>  CONFIG_NRF51_SOC=y
>  
>  CONFIG_CMSDK_APB_TIMER=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4d0febf644..49306d6419 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -81,6 +81,7 @@ config MUSICPAL
>  
>  config NETDUINO2
>      bool
> +    select STM32F205_SOC
>  
>  config NSERIES
>      bool
> @@ -250,6 +251,12 @@ config RASPI
>  
>  config STM32F205_SOC
>      bool
> +    select ARM_V7M
> +    select STM32F2XX_TIMER
> +    select STM32F2XX_USART
> +    select STM32F2XX_SYSCFG
> +    select STM32F2XX_ADC
> +    select STM32F2XX_SPI
>  
>  config XLNX_ZYNQMP_ARM
>      bool
> 

