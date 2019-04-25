Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0DC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE142088F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE142088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhDM-0001Vj-Dd
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:27:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhBr-0000M6-Bb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJhBp-0001YU-Fo
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:25:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJhBn-0001Wo-FT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:25:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id r6so280968wrm.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Ko/ee3WLvavlv69QBSoiYXdGoVO571KZqC0f3Po9JKI=;
	b=YoU47xjqvmnS23GVPbaiMeCuXcbxKzb5Q3Bc8eRkXc0dbzExPBPSng436H95d1nRJ+
	pfSTmveXw2AQCApRsmvw9o4V7q6520cg0XPajbZk5enbemMGfc0lltpIOtA4Ej6kOGq2
	yNWuxJKBClcQCeDHJ9k1J0FY3OHdKl86TLNt2ZXvp1mAVQrWenG5nXg/MZw9Q1EpkPeU
	qnaudEX8M9xcbYxJ4mP0W1CnURX/hR+07Ahpq3pU8Pvd9d6J1bc6eyLBFaN5n661zBCC
	IzWQ7iHlCDzyX0UXZGy2MATSbRffW12ucdlS9ySr1mQ6aCkLjg5AYLIpQCNVBL6Jr48t
	+HxQ==
X-Gm-Message-State: APjAAAUU00NJl8AaY5HVSAN7iz1gqR4UrbFaggZhH1Y88AMqFO5ohIGz
	RXUMsFVw6r2Pz3VNlBwOxVIWzQ==
X-Google-Smtp-Source: APXvYqzebhtnLExSJ0VPtPMYSJXWUG5EV3pgdcgB2fjPabbV+FEYQ+PD9W9/QdzorHiPKUmw4idLQw==
X-Received: by 2002:a05:6000:cc:: with SMTP id
	q12mr15767393wrx.251.1556209533803; 
	Thu, 25 Apr 2019 09:25:33 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	h131sm29200171wmh.1.2019.04.25.09.25.31
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:25:32 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-16-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c7599e97-8ccb-d7fa-93de-1001490ff243@redhat.com>
Date: Thu, 25 Apr 2019 18:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-16-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 15/29] hw/arm: Express
 dependencies of the aspeed boards with Kconfig
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
Message-ID: <20190425162530.ZL2Ji8r7LD9s12pHEXLgXFYkSaTRthSri67sLGfLZ9c@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Dependencies have been determined by looking at hw/arm/aspeed.c
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  7 +------
>  hw/arm/Kconfig                  | 10 ++++++++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 25e8f717ac..2580584281 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -26,15 +26,12 @@ CONFIG_SPITZ=y
>  CONFIG_TOSA=y
>  CONFIG_Z2=y
>  CONFIG_COLLIE=y
> +CONFIG_ASPEED_SOC=y
>  
>  CONFIG_VGA=y
> -CONFIG_TMP421=y
> -CONFIG_PCA9552=y
>  CONFIG_SSI_M25P80=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
> -CONFIG_FTGMAC100=y
> -CONFIG_DS1338=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
> @@ -92,8 +89,6 @@ CONFIG_I82801B11=y
>  CONFIG_ACPI=y
>  CONFIG_ARM_VIRT=y
>  CONFIG_SMBIOS=y
> -CONFIG_ASPEED_SOC=y
> -CONFIG_SMBUS_EEPROM=y
>  CONFIG_GPIO_KEY=y
>  CONFIG_MSF2=y
>  CONFIG_FW_CFG_DMA=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 325133c129..abeaa54d88 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -254,6 +254,16 @@ config FSL_IMX6
>  
>  config ASPEED_SOC
>      bool
> +    select DS1338
> +    select FTGMAC100
> +    select I2C
> +    select PCA9552
> +    select SERIAL
> +    select SMBUS_EEPROM
> +    select SSI
> +    select SSI_M25P80
> +    select TMP105
> +    select TMP421
>  
>  config MPS2
>      bool
> 

