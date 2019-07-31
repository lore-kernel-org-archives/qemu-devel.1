Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE05C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E9120693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E9120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsn5g-0002GC-13
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsn5E-0001kP-CH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsn5D-0007yD-5B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:47:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsn5C-0007wi-UU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:47:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so1120556wmd.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R9J6plVPUd6c13V9HHPE90GzLTaBy1CZelJrNwUq+LM=;
 b=HYyYINZCaBDh8AO+4NSd0cdzw3D1srS23i44rE+td/Q5k+oGuo2TVNaNTkOOV5EbZQ
 iPMzfvbtxIQaGxyWpkIjUYpn9jQRWJXPfWRFqEilC/XrbpXmItf7CYFZVsYDy6xW7sW+
 DOoZ0MfNQmfPFkFgEErnjWO5JuD0gCe2uyA3wdhMVvcX9WYtk77XZ97NH1q+bNKjVWsn
 l4v/aPejJXFY4SmKk3eeYz4suqmjng8yDxwc6qItGpiXoH9r6DnWiBrWlumsz6+/hrWV
 uu0lsW30E6C1H/9Ab9P4EgPtDzoqg36EqkYG9sAuvq6K+wyelC5jj1v2Uji/0YaSTZsZ
 leWw==
X-Gm-Message-State: APjAAAV2OuNbMdFtz7gTGEecCtppRKCxvOxlsF+8YIIvR0h6028jkxNU
 /FfycFep0yQN5KQ7QRl3fCNx5Q==
X-Google-Smtp-Source: APXvYqyeaVOgzr9ao6tVRpzqSzbyIGXDm75x5yXUNl+wPo6xnOISleUPqWD9FQiZqUOD41hqKSBU/w==
X-Received: by 2002:a1c:a481:: with SMTP id
 n123mr103567968wme.123.1564573669815; 
 Wed, 31 Jul 2019 04:47:49 -0700 (PDT)
Received: from [192.168.43.238] (44.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.44])
 by smtp.gmail.com with ESMTPSA id o7sm55294774wmc.36.2019.07.31.04.47.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 04:47:49 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-8-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f2399005-cead-a147-37a5-600fda7eaea5@redhat.com>
Date: Wed, 31 Jul 2019 13:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731075652.17053-8-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 7/8] hw/misc: Add a config switch for
 the "unimplemented" device
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:56 AM, Thomas Huth wrote:
> The device is only used by some few boards. Let's use a proper Kconfig
> switch so that we only compile this code if we really need it.

I'd prefer having the UnimpDevice user-creatable and always present as a
core device...

Maybe this can be solved by using 'default y':

    config UNIMP
        bool
        default y

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/Kconfig        | 9 +++++++++
>  hw/microblaze/Kconfig | 1 +
>  hw/misc/Kconfig       | 3 +++
>  hw/misc/Makefile.objs | 2 +-
>  hw/sparc64/Kconfig    | 1 +
>  5 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 6e24c73b54..ab9e592d74 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -217,6 +217,7 @@ config STELLARIS
>      select SSI_SD
>      select STELLARIS_INPUT
>      select STELLARIS_ENET # ethernet
> +    select UNIMP
>  
>  config STRONGARM
>      bool
> @@ -283,6 +284,7 @@ config ALLWINNER_A10
>      select ALLWINNER_A10_PIC
>      select ALLWINNER_EMAC
>      select SERIAL
> +    select UNIMP
>  
>  config RASPI
>      bool
> @@ -320,6 +322,7 @@ config XLNX_VERSAL
>      select PL011
>      select CADENCE
>      select VIRTIO_MMIO
> +    select UNIMP
>  
>  config FSL_IMX25
>      bool
> @@ -355,6 +358,7 @@ config ASPEED_SOC
>      select SSI_M25P80
>      select TMP105
>      select TMP421
> +    select UNIMP
>  
>  config MPS2
>      bool
> @@ -378,6 +382,7 @@ config FSL_IMX7
>      select IMX_I2C
>      select PCI_EXPRESS_DESIGNWARE
>      select SDHCI
> +    select UNIMP
>  
>  config ARM_SMMUV3
>      bool
> @@ -389,6 +394,7 @@ config FSL_IMX6UL
>      select IMX_FEC
>      select IMX_I2C
>      select SDHCI
> +    select UNIMP
>  
>  config MICROBIT
>      bool
> @@ -398,6 +404,7 @@ config NRF51_SOC
>      bool
>      select I2C
>      select ARM_V7M
> +    select UNIMP
>  
>  config EMCRAFT_SF2
>      bool
> @@ -410,6 +417,7 @@ config MSF2
>      select PTIMER
>      select SERIAL
>      select SSI
> +    select UNIMP
>  
>  config ZAURUS
>      bool
> @@ -448,6 +456,7 @@ config ARMSSE
>      select TZ_MPC
>      select TZ_MSC
>      select TZ_PPC
> +    select UNIMP
>  
>  config ARMSSE_CPUID
>      bool
> diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
> index c4dc120973..e2697ced9c 100644
> --- a/hw/microblaze/Kconfig
> +++ b/hw/microblaze/Kconfig
> @@ -4,6 +4,7 @@ config PETALOGIX_S3ADSP1800
>      select XILINX
>      select XILINX_AXI
>      select XILINX_ETHLITE
> +    select UNIMP
>  
>  config PETALOGIX_ML605
>      bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 385e1b0cec..51754bb47c 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -117,4 +117,7 @@ config AUX
>      bool
>      select I2C
>  
> +config UNIMP
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index e9aab519a1..e4aad707fb 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
>  common-obj-$(CONFIG_EDU) += edu.o
>  common-obj-$(CONFIG_PCA9552) += pca9552.o
>  
> -common-obj-y += unimp.o
> +common-obj-$(CONFIG_UNIMP) += unimp.o
>  common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
>  
>  # ARM devices
> diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
> index d4d76a89be..f9f8b0f73a 100644
> --- a/hw/sparc64/Kconfig
> +++ b/hw/sparc64/Kconfig
> @@ -17,3 +17,4 @@ config NIAGARA
>      bool
>      select EMPTY_SLOT
>      select SUN4V_RTC
> +    select UNIMP
> 

