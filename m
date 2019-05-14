Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B41C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC8820881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC8820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUtc-0006Jc-3k
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:42:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQUqx-0004Gg-MR
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQUmk-0006Zj-Lq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:35:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQUmk-0006ZH-Ex
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:35:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so10240092wrx.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 03:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TB0K9v3OzkgaK8Mzqtn7indwDU74Za3mEXU8p1hwlOk=;
	b=bhDUkvavc1BbG/hTkfI/1DzwQUNc6VwmVq3bZYDu5RY8bR+9Puo3Bbc2sxEhwSWkz7
	VLQpPoLJNaWbvnABgFCgCH4p9SbaqqfYOZeOJmaXHFJTahAFj4lPQOFA7E/+Pqb7Yz1C
	DxvHDSrsNMXMGXoB5ukgyKPoZkxS2qJTuH84WUv0TNO+siDBTy1wRsrXKNDjopZqW2ef
	wP6Mp0Cm4tF5vjwh15D6HYddVfb+KVkNSL/c7ZLAWWd9rpAe5G+sxET8Id29VPYQ8L4i
	pEyGvWgpULqSMszj1KD7rsggQUMw81noFqb/Tpr1EeX5r6WTOs1aEY9OUPyua/SgLmvF
	2mkg==
X-Gm-Message-State: APjAAAWiseoSqZ0QcPJ+W83HF8m37+ftkayYI7b4e0jGmzLCqNZxVJS5
	+k92XiQNKV+0RpuQ3TBZyS0fxMYC2+0=
X-Google-Smtp-Source: APXvYqzHMKCpcLSYgid18wNywltR4QlSaz86Dja5uQlxKCk1tnvSOcwssnY91fSgE91il0YU6hA5SA==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr3066716wrw.23.1557830149565;
	Tue, 14 May 2019 03:35:49 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h11sm13499699wrr.44.2019.05.14.03.35.48
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 03:35:49 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
References: <20190514100019.13263-1-thuth@redhat.com>
	<20190514100019.13263-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aabf08dd-0c9f-63dd-1c49-f31f6c150392@redhat.com>
Date: Tue, 14 May 2019 12:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514100019.13263-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/core: Add a config switch for the
 "or-irq" device
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
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 12:00 PM, Thomas Huth wrote:
> The "or-irq" device is only used by certain machines. Let's add
> a proper config switch for it so that it only gets compiled when we
> really need it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/Kconfig        | 2 ++
>  hw/core/Kconfig       | 3 +++
>  hw/core/Makefile.objs | 2 +-
>  hw/pci-host/Kconfig   | 3 ++-
>  4 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index af8cffde9c..0bb3bbe9d3 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -277,6 +277,7 @@ config RASPI
>  config STM32F205_SOC
>      bool
>      select ARM_V7M
> +    select OR_IRQ
>      select STM32F2XX_TIMER
>      select STM32F2XX_USART
>      select STM32F2XX_SYSCFG
> @@ -424,6 +425,7 @@ config ARMSSE
>      select IOTKIT_SECCTL
>      select IOTKIT_SYSCTL
>      select IOTKIT_SYSINFO
> +    select OR_IRQ
>      select TZ_MPC
>      select TZ_MSC
>      select TZ_PPC

You missed the MPS2* boards

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
> index d493a051ee..dd2c2ca812 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -17,7 +17,7 @@ common-obj-$(CONFIG_SOFTMMU) += loader.o
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

