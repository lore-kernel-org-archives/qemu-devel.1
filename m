Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810EC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978CC2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978CC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJh8m-0006P5-2R
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:22:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh0d-0007MB-Gs
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh0c-0007Eo-I1
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:14:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJh0c-0007CY-CM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:14:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so189620wrx.9
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=XRVpDPjBZmvBUFFN8JJzxRXHwosnKacJS2q315hBj8U=;
	b=cOZDNZycaR1RaB/vZTo17j1iFAwDH/PZNT5zKkSRbYAEvBjM88d80PX4PQ+xNrm09S
	h8VebwaTjGsP3gIdobmFpAFjus6wjfV3grPG18sv6Mux/mBLDqZhdGjaw4lqpe7F4uJV
	lmSE+tRlYJTwPAJvHgcYQj/2epjo5XmytJ/L/4qsIbEO1/Tcibvg8uRs6vZBUCXHNgEC
	kp/CFNAiib9+gu1zCboPsMK10/5AnQm1ydIq3BUX1iDYNzHv4QHY9FwYcmuew+HLYWUy
	v/YJdvkh88cqf82HfLlv3hGqlreFR1m1AFP7Z8WgUQtL/IR6iF+p8ic/N0HFpye80mJ8
	C8Dw==
X-Gm-Message-State: APjAAAVlbAX2rZh9TSRVlWhDenKQJfaI1hAQMqVNUdFXG7v1T0QCRn2y
	CofDxwsjIUHWtMpWJ009b7CqEg==
X-Google-Smtp-Source: APXvYqzJ9Jg6meoIlnDu+knPE4bOE/WCCIyb7RyYry2SlSOqjA63jFL18kuCq2z3rOEa8pPfAbWVgA==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr4840548wrs.265.1556208841063; 
	Thu, 25 Apr 2019 09:14:01 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122])
	by smtp.gmail.com with ESMTPSA id q3sm575941wre.31.2019.04.25.09.13.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:14:00 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-25-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4fcfff75-aa44-e1cc-2e14-38faba3a3e47@redhat.com>
Date: Thu, 25 Apr 2019 18:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-25-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 24/29] hw/arm: Express
 dependencies for remaining IMX boards with Kconfig
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
Message-ID: <20190425161358.fsqw-sVnBN4zMJ9bGEjSakumYspSUjrdboSY8_R_uaY@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> IMX25, IMX7 and IMX6UL were still missing the Kconfig dependencies.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak |  2 --
>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 1455d083d8..6dc388c43e 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -37,7 +37,6 @@ CONFIG_SABRELITE=y
>  CONFIG_EMCRAFT_SF2=y
>  
>  CONFIG_VGA=y
> -CONFIG_IMX_FEC=y
>  
>  CONFIG_NRF51_SOC=y
>  
> @@ -49,4 +48,3 @@ CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> -CONFIG_PCI_EXPRESS_DESIGNWARE=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f5cd63860d..58439c492a 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -283,6 +283,10 @@ config XLNX_VERSAL
>  
>  config FSL_IMX25
>      bool
> +    select IMX
> +    select IMX_FEC
> +    select IMX_I2C
> +    select DS1338
>  
>  config FSL_IMX31
>      bool
> @@ -296,6 +300,7 @@ config FSL_IMX6
>      select A9MPCORE
>      select IMX
>      select IMX_I2C
> +    select SDHCI
>  
>  config ASPEED_SOC
>      bool
> @@ -321,12 +326,26 @@ config MPS2
>  
>  config FSL_IMX7
>      bool
> +    imply PCI_DEVICES
> +    imply TEST_DEVICES
> +    select A15MPCORE
> +    select PCI
> +    select IMX
> +    select IMX_FEC
> +    select IMX_I2C
> +    select PCI_EXPRESS_DESIGNWARE
> +    select SDHCI
>  
>  config ARM_SMMUV3
>      bool
>  
>  config FSL_IMX6UL
>      bool
> +    select A15MPCORE
> +    select IMX
> +    select IMX_FEC
> +    select IMX_I2C
> +    select SDHCI
>  
>  config NRF51_SOC
>      bool
> 

