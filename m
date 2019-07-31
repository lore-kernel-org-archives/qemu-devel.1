Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B1AC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D24A206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D24A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqwk-0007F9-QW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36653)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsquu-00068C-2g
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsqur-0002CT-Cs
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:53:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsqur-0002Bz-6x
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:53:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so67037934wrm.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yiBLy7z6HsCx9LJ7ADNULmN66hzimWLK/c6Ep7QUyZg=;
 b=t4I5CC5ytyZxLi9kELzAw0VK0XHwXAum/IPVfW2Dsk9kHgotS/NWdAoD1y2yA1xfq2
 YJjTzmr0aN8QOwyNSF+mEYWUcWrNhBAUc5Htqzq/CohnTuHkedf4HE7MjsVyZEDhTl9E
 ue7by0r3LbRW3+fVXNW0OBU0d8C39/1i9sIE9DnIJJqjt4MtSorECgYjmkzkFeny5azf
 qD0Xy/07Kbd3/IvBpQe8YiqXLeB33E5sBEo+SvEXKWcbtErkkEidfKc2vlk4EOuEMiW7
 nzrDujWg1j7IsSAwzSmzGRqqw5iRct3oC+5CSPnGU5OkkD/XU0jUdk4lNMc7PcRtp9FH
 ceBQ==
X-Gm-Message-State: APjAAAXi9t4GNAxiW/vTVVMiDPCG1r1YN1LumX9DCV6Lqm9e2Fd5JJI+
 h8zr1cp/GB1A4dhpYY14cM4wDQ==
X-Google-Smtp-Source: APXvYqxT+4gxP5AF0OudFf5PEpca65H7ArvB5zUmwr4JR9cY/MejPQK3frbl2djtCKGdTYAGrabl3g==
X-Received: by 2002:adf:db50:: with SMTP id
 f16mr126290818wrj.214.1564588404306; 
 Wed, 31 Jul 2019 08:53:24 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id b186sm50254602wmb.3.2019.07.31.08.53.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 08:53:23 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-7-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f5567abe-f46b-ab32-ef2a-0b5094e70496@redhat.com>
Date: Wed, 31 Jul 2019 17:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731075652.17053-7-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 6/8] hw/core: Add a config switch for
 the "split-irq" device
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
> The "split-irq" device is currently only used by machines that use
> CONFIG_ARMSSE. Let's add a proper CONFIG_SPLIT_IRQ switch for this
> so that it only gets compiled when we really need it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/Kconfig        | 3 +++
>  hw/core/Kconfig       | 3 +++
>  hw/core/Makefile.objs | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 849195c3f6..6e24c73b54 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -81,6 +81,7 @@ config MUSCA
>      select ARMSSE
>      select PL011
>      select PL031
> +    select SPLIT_IRQ
>  
>  config MUSICPAL
>      bool
> @@ -364,6 +365,7 @@ config MPS2
>      select OR_IRQ
>      select PL022    # Serial port
>      select PL080    # DMA controller
> +    select SPLIT_IRQ
>  
>  config FSL_IMX7
>      bool
> @@ -442,6 +444,7 @@ config ARMSSE
>      select IOTKIT_SYSCTL
>      select IOTKIT_SYSINFO
>      select OR_IRQ
> +    select SPLIT_IRQ
>      select TZ_MPC
>      select TZ_MSC
>      select TZ_PPC
> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> index 984143456a..fffb3d62b2 100644
> --- a/hw/core/Kconfig
> +++ b/hw/core/Kconfig
> @@ -15,3 +15,6 @@ config PLATFORM_BUS
>  
>  config REGISTER
>      bool
> +
> +config SPLIT_IRQ
> +    bool
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index ce337bd7c9..bb1afe422a 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -19,7 +19,7 @@ common-obj-$(CONFIG_FITLOADER) += loader-fit.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
>  common-obj-$(CONFIG_REGISTER) += register.o
>  common-obj-$(CONFIG_OR_IRQ) += or-irq.o
> -common-obj-$(CONFIG_SOFTMMU) += split-irq.o
> +common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
>  common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
>  common-obj-$(CONFIG_SOFTMMU) += null-machine.o
> 

