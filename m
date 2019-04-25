Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A38C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B92E20651
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJh61-00049J-3c
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:19:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh49-0002e2-N4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh48-0001v5-MB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJh48-0001tk-FP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:17:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id r6so249352wrm.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9qW7zLFfth7jP3Wy/j83eS64gALbJ+VrjdxLUYXJRCM=;
	b=abDxZdw+n0FtUUMtO09NTPGBGmj5DDYxgXuoDF0UepF6BdWr4gwLmVFSDf3iXg4yV2
	ZnGiY2NhFHCZkpEQcxqeJ/bIwaIfCYqdUiCWKu6KLCpo0cEpDO7fTAWbvcqXBFgfjtAx
	+HmY+WcVJRHex17CQtSHdxVtK2rS3geZXtWd0BNLZNmt67wCUaXiOv5a8ogTnv0z+/Sw
	D+ImMSso+IR/Eq4DtKfD2e13zJtFFofSCibbQRAR4ZrWLv0xVPOldbS0RXynDY50vrgG
	S6VFFwbgxLKLu6LrQkc26Ey+a2rMt1ENObFgV/XIeiud9RIglr3oa7eI3GXfJOZZchv1
	Oh4Q==
X-Gm-Message-State: APjAAAX1rSBuh1N/XGZAVW3efSMoXVaqScDC8TQWe3bQ0Uncd1dLE9en
	2auQLZbYEj1lx8xJ8UJDeyiFBA==
X-Google-Smtp-Source: APXvYqzEkG91qkPC/ghozJ0ybpuvSltjZxqlRUcetwGAzsRjgrV9Dk664WUMr4Pvn4ZddrGMPgF64g==
X-Received: by 2002:adf:f68c:: with SMTP id v12mr10211271wrp.40.1556209058552; 
	Thu, 25 Apr 2019 09:17:38 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	o4sm28868699wmo.20.2019.04.25.09.17.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:17:38 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-14-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0dc4aa08-a0be-ab33-a717-7b8e488e63fc@redhat.com>
Date: Thu, 25 Apr 2019 18:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-14-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 13/29] hw/arm: Express
 dependencies of xilinx-zynq with Kconfig
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
Message-ID: <20190425161736.C09-7SVcjSxpG7UbXCZzqvNbV7GniPSbq48KnX3I8fk@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the xilinx-zynq-a9 board.
> This patch is based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index f39a854f2e..af78e7c892 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,6 +19,7 @@ CONFIG_STELLARIS=y
>  CONFIG_REALVIEW=y
>  CONFIG_VERSATILE=y
>  CONFIG_VEXPRESS=y
> +CONFIG_ZYNQ=y
>  CONFIG_MAINSTONE=y
>  CONFIG_GUMSTIX=y
>  CONFIG_SPITZ=y
> @@ -38,16 +39,11 @@ CONFIG_VIRTIO_MMIO=y
>  
>  CONFIG_NETDUINO2=y
>  
> -CONFIG_PL330=y
> -CONFIG_CADENCE=y
>  CONFIG_FRAMEBUFFER=y
> -CONFIG_XILINX_SPIPS=y
> -CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_DIGIC=y
>  CONFIG_MPS2=y
>  CONFIG_RASPI=y
> -CONFIG_ZYNQ=y
>  CONFIG_STM32F2XX_TIMER=y
>  CONFIG_STM32F2XX_USART=y
>  CONFIG_STM32F2XX_SYSCFG=y
> @@ -100,7 +96,6 @@ CONFIG_SMBUS_EEPROM=y
>  CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
> -CONFIG_XILINX_AXI=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>  
>  CONFIG_STRONGARM=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 101de74260..785e383411 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -201,6 +201,18 @@ config VEXPRESS
>  
>  config ZYNQ
>      bool
> +    select A9MPCORE
> +    select CADENCE # UART
> +    select PFLASH_CFI02
> +    select PL330
> +    select SDHCI
> +    select SSI_M25P80
> +    select USB_EHCI_SYSBUS
> +    select XILINX # UART
> +    select XILINX_AXI
> +    select XILINX_SPI
> +    select XILINX_SPIPS
> +    select ZYNQ_DEVCFG
>  
>  config ARM_V7M
>      bool
> 

