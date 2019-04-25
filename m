Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C4C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146252084F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146252084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfJ4-00010p-4Q
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:24:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfIB-0000Yn-Kw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfIA-0004PK-Jn
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:24:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJfIA-0004Ny-Dk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:24:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so9622016wmk.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=o9qYZ+xKjARwGj9xJtPZr6yjVKvTFK44iOwXMsFiPv0=;
	b=rJKyGWo2Smri1b/xpNNL3Ka8nNcw/VhO9xHP7am5EeuZgGfc2euvEJ93t3M36aedTW
	XPVuaW4aetTzEPFoF76Rc+WNNYsZnEgY6ShiiGg3qFTn7H3EIpbu0cJVbTjuD4Uzt1jB
	tisirQ496Xyrn7xAE8JEvdEZkeo6avYqAn3uAwSgIePiG2IHo4iAiOOT+3W4U3CdInXj
	J1IMOGn6126OkdtBLF69Pvea4F5iV/RcsBXCHYeuQyUNr7FHcUD+bDjn61nY5aVLG/NC
	hHLXXOnfvS8ZRLw+uBykJ6MQeT+xlesuOHZGPEJop2XYOgKJRh1/uWieYV4zCNGkqvcK
	u1mg==
X-Gm-Message-State: APjAAAU5NWHIoBip6WrWZC2WxyA8I59tNASq8jbDmBmvAgOCZg1E6Ur3
	PvADUf4v1pGzRtR4oQa4nCXE2A==
X-Google-Smtp-Source: APXvYqwd9RuVVN7vjPVbK4R53eo3Th4RoXsJxndeY0TWJM69j0SqaD2rd44M3repb96LGxJl3BgSrw==
X-Received: by 2002:a1c:7610:: with SMTP id r16mr3573859wmc.21.1556202241157; 
	Thu, 25 Apr 2019 07:24:01 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122])
	by smtp.gmail.com with ESMTPSA id y4sm2483703wrt.34.2019.04.25.07.23.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 07:24:00 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <356b0ed3-31c3-b210-f98e-c0df97e48fa1@redhat.com>
Date: Thu, 25 Apr 2019 16:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-5-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 04/29] hw/arm: Express
 dependencies of the exynos machines with Kconfig
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
Message-ID: <20190425142358.Mw2jIlg1X89C0e4cg128x2S_1rsdirSRqm_S3Ysxfsk@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Add Kconfig dependencies for the Exynos-related boards (nuri and
> smdkc210).
> This patch is slightly based on earlier work by Ákos Kovács (i.e.
> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 17 ++++++-----------
>  hw/arm/Kconfig                  | 10 ++++++++++
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 613d19a06d..2a11e76cc7 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -1,8 +1,14 @@
>  # Default configuration for arm-softmmu
>  
> +# TODO: ARM_V7M is currently always required - make this more flexible!
> +CONFIG_ARM_V7M=y
> +
>  CONFIG_PCI=y
>  CONFIG_PCI_DEVICES=y
>  CONFIG_PCI_TESTDEV=y
> +
> +CONFIG_EXYNOS4=y
> +
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
> @@ -26,7 +32,6 @@ CONFIG_ADS7846=y
>  CONFIG_MAX111X=y
>  CONFIG_SSI_SD=y
>  CONFIG_SSI_M25P80=y
> -CONFIG_LAN9118=y
>  CONFIG_SMC91C111=y
>  CONFIG_ALLWINNER_EMAC=y
>  CONFIG_IMX_FEC=y
> @@ -36,21 +41,15 @@ CONFIG_PFLASH_CFI01=y
>  CONFIG_PFLASH_CFI02=y
>  CONFIG_MICRODRIVE=y
>  CONFIG_USB_MUSB=y
> -CONFIG_USB_EHCI_SYSBUS=y
>  CONFIG_PLATFORM_BUS=y
>  CONFIG_VIRTIO_MMIO=y
>  
>  CONFIG_ARM11MPCORE=y
> -CONFIG_A9MPCORE=y
>  CONFIG_A15MPCORE=y
>  
> -CONFIG_ARM_V7M=y
>  CONFIG_NETDUINO2=y
>  
> -CONFIG_ARM_GIC=y
>  CONFIG_ARM_TIMER=y
> -CONFIG_ARM_MPTIMER=y
> -CONFIG_A9_GTIMER=y
>  CONFIG_PL011=y
>  CONFIG_PL022=y
>  CONFIG_PL031=y
> @@ -61,11 +60,9 @@ CONFIG_PL080=y
>  CONFIG_PL110=y
>  CONFIG_PL181=y
>  CONFIG_PL190=y
> -CONFIG_PL310=y
>  CONFIG_PL330=y
>  CONFIG_CADENCE=y
>  CONFIG_XGMAC=y
> -CONFIG_EXYNOS4=y
>  CONFIG_PXA2XX=y
>  CONFIG_BITBANG_I2C=y
>  CONFIG_FRAMEBUFFER=y
> @@ -73,7 +70,6 @@ CONFIG_XILINX_SPIPS=y
>  CONFIG_ZYNQ_DEVCFG=y
>  
>  CONFIG_ARM11SCU=y
> -CONFIG_A9SCU=y
>  CONFIG_DIGIC=y
>  CONFIG_MARVELL_88W8618=y
>  CONFIG_OMAP=y
> @@ -123,7 +119,6 @@ CONFIG_VERSATILE_I2C=y
>  CONFIG_PCI_EXPRESS=y
>  CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
>  
> -CONFIG_SDHCI=y
>  CONFIG_INTEGRATOR=y
>  CONFIG_INTEGRATOR_DEBUG=y
>  
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d298fbdc89..acd07b2add 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -8,7 +8,13 @@ config DIGIC
>  
>  config EXYNOS4
>      bool
> +    select A9MPCORE
> +    select I2C
> +    select LAN9118
> +    select PL310 # cache controller
>      select PTIMER
> +    select SDHCI
> +    select USB_EHCI_SYSBUS

Same comment here, you disable selectors that are required by other
machines (That would fail to build if disable EXYNOS4).

Since you add them to each machine later,
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  config HIGHBANK
>      bool
> @@ -104,6 +110,10 @@ config ZAURUS
>  
>  config A9MPCORE
>      bool
> +    select A9_GTIMER
> +    select A9SCU       # snoop control unit
> +    select ARM_GIC
> +    select ARM_MPTIMER
>  
>  config A15MPCORE
>      bool
> 

