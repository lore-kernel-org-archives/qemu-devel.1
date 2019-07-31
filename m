Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E4C206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E4C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqtt-0005KM-Op
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsqsF-0004jG-SE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsqsE-0000qh-Q6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:50:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsqsE-0000qG-JZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:50:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so67027843wrm.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ey6ptsh6teX0ACw8yW/3Dt/gvHiAvQLFfYgGGVxBZUY=;
 b=KAFjbc1ew24BFdbF81Q6u4dNdA7hp66EKFbkGrerk+8f7quG9rQFbOQm6UqcBhJEl+
 S4kPVn9ZF6BraOM5c+gxWxCtdGU7Z6vJIKHA6q0Y6STbGwuFCm5po2WYpA6tLdqfQzpu
 hCCxxLZ3OxdgjrW8fI5aNqf4MfKiesE2iWToyzgm5wkorL1dGE7pL2+951zljsKGZxpJ
 K4GUM1y7oUST97YFDzV3Zdio/vjHCxCLN4G261m9b3RdvvPkZxD8+N2Qdz0R21Kw+jYs
 vMXiwqbnPt6S/bTSQT1HIP6iFS9p/xF8X68LABjJGx7pixrKuKYAw764NCDKwZ1kM3Yj
 4RWQ==
X-Gm-Message-State: APjAAAXQvHwqvyxxo7I6zmPAHQ9LMP9g4nVNTBwrrCcdnthQhfrxpVtH
 A6uhBR5Db7hcbQBZT4KbaBJTIw==
X-Google-Smtp-Source: APXvYqwdOX1pfndIqyAW91NUxQkyQ6d38HTY0qyusMg9vN4TjySFXX9FsGXMoOw4dy5NEYYvnmuaHg==
X-Received: by 2002:a05:6000:112:: with SMTP id
 o18mr55608911wrx.153.1564588241585; 
 Wed, 31 Jul 2019 08:50:41 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id y16sm70473886wrw.33.2019.07.31.08.50.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 08:50:40 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4e534a91-4775-a58e-11b8-1fc776128f1f@redhat.com>
Date: Wed, 31 Jul 2019 17:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731075652.17053-6-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 5/8] hw/core: Add a config switch for
 the "or-irq" device
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
> The "or-irq" device is only used by certain machines. Let's add
> a proper config switch for it so that it only gets compiled when we
> really need it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/Kconfig        | 3 +++
>  hw/core/Kconfig       | 3 +++
>  hw/core/Makefile.objs | 2 +-
>  hw/pci-host/Kconfig   | 3 ++-
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index ab65ecd216..849195c3f6 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -292,6 +292,7 @@ config RASPI
>  config STM32F205_SOC
>      bool
>      select ARM_V7M
> +    select OR_IRQ
>      select STM32F2XX_TIMER
>      select STM32F2XX_USART
>      select STM32F2XX_SYSCFG
> @@ -360,6 +361,7 @@ config MPS2
>      select LAN9118
>      select MPS2_FPGAIO
>      select MPS2_SCC
> +    select OR_IRQ
>      select PL022    # Serial port
>      select PL080    # DMA controller
>  
> @@ -439,6 +441,7 @@ config ARMSSE
>      select IOTKIT_SECCTL
>      select IOTKIT_SYSCTL
>      select IOTKIT_SYSINFO
> +    select OR_IRQ
>      select TZ_MPC
>      select TZ_MSC
>      select TZ_PPC
> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> index d11920fcb3..984143456a 100644
> --- a/hw/core/Kconfig
> +++ b/hw/core/Kconfig
> @@ -7,6 +7,9 @@ config PTIMER
>  config FITLOADER
>      bool
>  
> +config OR_IRQ
> +    bool
> +
>  config PLATFORM_BUS
>      bool
>  
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index d6cfb2a81b..ce337bd7c9 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -18,7 +18,7 @@ common-obj-$(CONFIG_SOFTMMU) += loader.o
>  common-obj-$(CONFIG_FITLOADER) += loader-fit.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
>  common-obj-$(CONFIG_REGISTER) += register.o
> -common-obj-$(CONFIG_SOFTMMU) += or-irq.o
> +common-obj-$(CONFIG_OR_IRQ) += or-irq.o
>  common-obj-$(CONFIG_SOFTMMU) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
>  common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 8c16d96b3f..1edc1a31d4 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -2,8 +2,9 @@ config PAM
>      bool
>  
>  config PREP_PCI
> -    select PCI
>      bool
> +    select PCI
> +    select OR_IRQ
>  
>  config GRACKLE_PCI
>      select PCI
> 

