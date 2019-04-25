Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34004C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1B22088F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1B22088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60131 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJh10-0007Vl-Oj
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:14:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgsR-0001jB-JP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJgsQ-0003gI-BG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:05:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJgsQ-0003f3-5C
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:05:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so126053wra.12
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0AD/xbd7NqYL/doMKzXbJIfwRggRArvPf5ZwIgSIHwg=;
	b=bxzUP95a40hVlcD1to433veZ0+z0Cl1bXKLN2GSVuFyoEWxx4vmkgSJq7EXkTORRdE
	MWf5VNWzQTU5T0xu7P7AF5puNma678iTihlaDRSZY5jwmTwo9oudUXh5A3Yrrm0qs9d8
	At1Bh7+rx2Z2edb9T8duAhcMxv5jNwEvp5Y3q+3VbmapQjUQipGLl1XA2M+moNGw8rLY
	RhX/qMRYYroVKh69diL3ZsNWx9x2ZYcucofcq31GWvDcILGBTnKFCdawBXkv0/cPPBz8
	dotXgZvO9+8IymlKfErIxlfZf/sHLWgofU1UuQkdm4a8bbpvshpj7frjX8Vd1+NdTpEj
	aJww==
X-Gm-Message-State: APjAAAWkorltMqqozbooJe+HdfA6L4Bn8EUi5J1uzIrZQoZR6+XbYWJG
	CwK6WcplwtOFEdm/ijwLJiJmVQ==
X-Google-Smtp-Source: APXvYqxTK9ZRZ8UmT3n2xcX+6AEzo/mvQoG/lsPjJY3XVUZCqHpi1hx5AE84jHreEJfqTTHaKbj18w==
X-Received: by 2002:adf:f310:: with SMTP id i16mr12807097wro.291.1556208332919;
	Thu, 25 Apr 2019 09:05:32 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	v14sm3027059wra.58.2019.04.25.09.05.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:05:31 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-9-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6e0098e3-72e5-cb46-d06c-75eed7116ad7@redhat.com>
Date: Thu, 25 Apr 2019 18:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-9-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 08/29] hw/arm: Express
 dependencies of musicpal with Kconfig
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
Message-ID: <20190425160529.cNizT3Baoe1sOHLg9ukxA2DLbKeeTLdxbDhPRW9ppdA@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  default-configs/arm-softmmu.mak | 6 +-----
>  hw/arm/Kconfig                  | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 7f94811ccb..0a4d293f8a 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -11,13 +11,13 @@ CONFIG_EXYNOS4=y
>  CONFIG_HIGHBANK=y
>  CONFIG_INTEGRATOR=y
>  CONFIG_FSL_IMX31=y
> +CONFIG_MUSICPAL=y
>  
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_MAX7310=y
> -CONFIG_WM8750=y
>  CONFIG_TWL92230=y
>  CONFIG_TSC2005=y
>  CONFIG_LM832X=y
> @@ -40,7 +40,6 @@ CONFIG_IMX_FEC=y
>  CONFIG_FTGMAC100=y
>  CONFIG_DS1338=y
>  CONFIG_PFLASH_CFI01=y
> -CONFIG_PFLASH_CFI02=y
>  CONFIG_MICRODRIVE=y
>  CONFIG_USB_MUSB=y
>  CONFIG_PLATFORM_BUS=y
> @@ -56,14 +55,12 @@ CONFIG_PL190=y
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
>  CONFIG_PXA2XX=y
> -CONFIG_BITBANG_I2C=y
>  CONFIG_FRAMEBUFFER=y
>  CONFIG_XILINX_SPIPS=y
>  CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_ARM11SCU=y
>  CONFIG_DIGIC=y
> -CONFIG_MARVELL_88W8618=y
>  CONFIG_OMAP=y
>  CONFIG_TSC210X=y
>  CONFIG_BLIZZARD=y
> @@ -137,7 +134,6 @@ CONFIG_XILINX_AXI=y
>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>  
>  CONFIG_STRONGARM=y
> -CONFIG_MUSICPAL=y
>  
>  # for realview and versatilepb
>  CONFIG_LSI_SCSI_PCI=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 9087b7d714..b9f3c3c232 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -46,7 +46,12 @@ config MAINSTONE
>  
>  config MUSICPAL
>      bool
> +    select BITBANG_I2C
> +    select MARVELL_88W8618
>      select PTIMER
> +    select PFLASH_CFI02
> +    select SERIAL
> +    select WM8750
>  
>  config NETDUINO2
>      bool
> 

