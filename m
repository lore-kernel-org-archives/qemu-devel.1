Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DD4C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E1420679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E1420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfMz-0003tK-Cy
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:29:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfM4-0003Jy-Jr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfM3-0007u6-Kc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:28:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJfM3-0007tI-Do
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:28:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so30576228wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MPUAfE7XwR1+GwI9oqV+NsnrsOy6QGZjxP7WEADatpA=;
	b=i6JleUUInxt64fvSUEveGZCAT/MmTu2iaG8s6YLKPOw9H0OhzqW5x/7u8jh15a5bX8
	ae8Ar6LHYFfyrklS2OtTo1ZVPQ5JxXZJCXgNqbZoeSkTYzX5E4pVERA8kXRE2aQY8MTw
	zcWWCHMK7M7S0ii7/G0yqFw2O57RebeEy7Zcuw42I4NlZqHgGouIvd0e34wYH7PjSMB5
	qDrqgzYeTz+8tIyvgHKEP+HU1GPEhjiN4NQ76HzFc9I9bM3euZ2IvnqrlL/LdeI1NXsC
	Nwxq2VIoAj7BkoDkychQvGkEL6/nI5bY3hkAUCo7V7my/4bmMkYgavlFleW036SlCSpy
	0Nog==
X-Gm-Message-State: APjAAAXdV+jWg9bpWM8xg/8mqQgID+nvz6lULbQfQ+6IXi20vrnLDGCi
	FMtyT1JGVBiIRe06uoaOC/1tJQ==
X-Google-Smtp-Source: APXvYqyT4F53jRcc/ctIhBFON2VbAZeLFawQNh5Z81PWdAZNSgU2gZzUvo0U69KZ1a7U508mayzTDA==
X-Received: by 2002:adf:ce0b:: with SMTP id p11mr22654467wrn.196.1556202482288;
	Thu, 25 Apr 2019 07:28:02 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	u6sm41394267wrg.72.2019.04.25.07.27.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 07:28:01 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-8-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <472cdca7-a01f-632f-bbac-633db846c605@redhat.com>
Date: Thu, 25 Apr 2019 16:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-8-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 07/29] hw/arm: Express
 dependencies of the fsl-imx31 machine with Kconfig
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
Message-ID: <20190425142758.ec5lbDI6kbMBG6SWI-y7zrw1wgBLZjaUl3akrjOmB0A@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the fsl-imx31 / kzm machine.
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 3 +--
>  hw/arm/Kconfig                  | 4 ++++
>  hw/misc/Kconfig                 | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6195b75f48..7f94811ccb 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -10,6 +10,7 @@ CONFIG_PCI_TESTDEV=y
>  CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
> +CONFIG_FSL_IMX31=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
> @@ -68,7 +69,6 @@ CONFIG_TSC210X=y
>  CONFIG_BLIZZARD=y
>  CONFIG_ONENAND=y
>  CONFIG_TUSB6010=y
> -CONFIG_IMX=y
>  CONFIG_MAINSTONE=y
>  CONFIG_MPS2=y
>  CONFIG_MUSCA=y
> @@ -115,7 +115,6 @@ CONFIG_ALLWINNER_A10_PIC=y
>  CONFIG_ALLWINNER_A10=y
>  
>  CONFIG_FSL_IMX6=y
> -CONFIG_FSL_IMX31=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index ad3b1f9b40..9087b7d714 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -98,6 +98,10 @@ config FSL_IMX25
>  
>  config FSL_IMX31
>      bool
> +    select SERIAL
> +    select IMX
> +    select IMX_I2C
> +    select LAN9118

Similarly to my comment on patch 6 of this series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  config FSL_IMX6
>      bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 5f67d0d6d9..385e1b0cec 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -76,6 +76,8 @@ config ECCMEMCTL
>  config IMX
>      bool
>      select PTIMER
> +    select SSI
> +    select USB_EHCI_SYSBUS
>  
>  config STM32F2XX_SYSCFG
>      bool
> 

