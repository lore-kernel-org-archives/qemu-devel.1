Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59796C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED54205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED54205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhI7-0006z5-DZ
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzh4j-0007zN-OT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzh4i-0005dA-A7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzh4h-0005cX-V5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:47:52 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8A3E2A09D4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 12:47:50 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k8so4089625wrx.19
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3EWK1hCVDvHhz9MwDgrsGJYt0HwG2P0wxgxsXsAI48=;
 b=gBOxQsN/ljVXiVgqdVR8wecicWl6xaQHPTYFoHa1jtvitcELS6jH6oAU/OqrMTMc5o
 o8F6CXGv7qR1fkZ9I4oD5t2InmAKWHdXuYYqp9GLMuVrkCGrVwOF9ehyxGOOElnrBjzc
 PVNHoED+92GXOqiUk6svyOPXt4VQgClZxMUVuDHxd8/fsMc10tUkDcNNUhx44Zc7Srko
 JLaZgZ6iKzeGi4+x3+W5hD0l/7lyeZfWh0ptXyqObj3kdHzJANBeyLLPlC0XMgoELRlj
 +1RtRM4u2ZMRd0vh8/nVkSK3yuwseZRriRYjjbwNGI9i0PKV+OJidHcGEUb4gIyTQYcV
 xxOg==
X-Gm-Message-State: APjAAAW20rGluRkCz/maFBLjEjtz4LbazfP/jxPUNKXpD3q6v9TmDMAk
 5fN7QSsJvv924Sv0LD6p/E5eW6a2n6mxVnZAHLEBW78WJcR+dDlHfY5PxEMIlUKWLXQ3wZCb9C9
 oyuoz+eCX2RUMsRo=
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr21517309wmf.92.1566218869714; 
 Mon, 19 Aug 2019 05:47:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8FdSlf2QruAqhP1Hyg7IV+B3y0ulfeZJTPL+NvrDPL+ahYkqyQHw3usMvgjYh2o8irXoYQg==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr21517236wmf.92.1566218868899; 
 Mon, 19 Aug 2019 05:47:48 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id j20sm35269873wre.65.2019.08.19.05.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 05:47:48 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190817101931.28386-1-thuth@redhat.com>
 <20190817101931.28386-8-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <68d2669d-9a67-f197-939b-dc038f0118ba@redhat.com>
Date: Mon, 19 Aug 2019 14:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190817101931.28386-8-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/8] hw/misc: Add a config switch for
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

On 8/17/19 12:19 PM, Thomas Huth wrote:
> The device is only used by some few boards. Let's use a proper Kconfig
> switch so that we only compile this code if we really need it.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  hw/arm/Kconfig        | 11 +++++++++++
>  hw/microblaze/Kconfig |  1 +
>  hw/misc/Kconfig       |  3 +++
>  hw/misc/Makefile.objs |  2 +-
>  hw/sparc64/Kconfig    |  1 +
>  5 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 6e24c73b54..76a2a6bcbf 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -82,6 +82,7 @@ config MUSCA
>      select PL011
>      select PL031
>      select SPLIT_IRQ
> +    select UNIMP
> =20
>  config MUSICPAL
>      bool
> @@ -217,6 +218,7 @@ config STELLARIS
>      select SSI_SD
>      select STELLARIS_INPUT
>      select STELLARIS_ENET # ethernet
> +    select UNIMP
> =20
>  config STRONGARM
>      bool
> @@ -283,6 +285,7 @@ config ALLWINNER_A10
>      select ALLWINNER_A10_PIC
>      select ALLWINNER_EMAC
>      select SERIAL
> +    select UNIMP
> =20
>  config RASPI
>      bool
> @@ -320,6 +323,7 @@ config XLNX_VERSAL
>      select PL011
>      select CADENCE
>      select VIRTIO_MMIO
> +    select UNIMP
> =20
>  config FSL_IMX25
>      bool
> @@ -355,6 +359,7 @@ config ASPEED_SOC
>      select SSI_M25P80
>      select TMP105
>      select TMP421
> +    select UNIMP
> =20
>  config MPS2
>      bool
> @@ -366,6 +371,7 @@ config MPS2
>      select PL022    # Serial port
>      select PL080    # DMA controller
>      select SPLIT_IRQ
> +    select UNIMP
> =20
>  config FSL_IMX7
>      bool
> @@ -378,6 +384,7 @@ config FSL_IMX7
>      select IMX_I2C
>      select PCI_EXPRESS_DESIGNWARE
>      select SDHCI
> +    select UNIMP
> =20
>  config ARM_SMMUV3
>      bool
> @@ -389,6 +396,7 @@ config FSL_IMX6UL
>      select IMX_FEC
>      select IMX_I2C
>      select SDHCI
> +    select UNIMP
> =20
>  config MICROBIT
>      bool
> @@ -398,6 +406,7 @@ config NRF51_SOC
>      bool
>      select I2C
>      select ARM_V7M
> +    select UNIMP
> =20
>  config EMCRAFT_SF2
>      bool
> @@ -410,6 +419,7 @@ config MSF2
>      select PTIMER
>      select SERIAL
>      select SSI
> +    select UNIMP
> =20
>  config ZAURUS
>      bool
> @@ -448,6 +458,7 @@ config ARMSSE
>      select TZ_MPC
>      select TZ_MSC
>      select TZ_PPC
> +    select UNIMP
> =20
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
> =20
>  config PETALOGIX_ML605
>      bool
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 385e1b0cec..51754bb47c 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -117,4 +117,7 @@ config AUX
>      bool
>      select I2C
> =20
> +config UNIMP
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index e9aab519a1..e4aad707fb 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
>  common-obj-$(CONFIG_EDU) +=3D edu.o
>  common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
> =20
> -common-obj-y +=3D unimp.o
> +common-obj-$(CONFIG_UNIMP) +=3D unimp.o
>  common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
> =20
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
>=20

