Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF3C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FC82089E
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FC82089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsn3B-0000JZ-Hq
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsn2W-000845-H0
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsn2V-0006kk-Hi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:45:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsn2V-0006jL-BP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:45:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so49165401wmc.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZCaA4BNdzs6Zemush7cWGpSj7+umpxQOt0vBi6zJ7s=;
 b=fZudfaSsiNeJTrhIM2ABuhOsY8tbxUA03JgXpVAgz9WGJb0CWJNyEsPpQj3V3YdlDV
 5LchHm1YoJI6IRU0W6VyWKrB+r8dp68XfIz4WTf+4UT1WHAxpGQXD41JoavFmOWow2m8
 ECx0Wt3RFUFIBykG2VOdQe+5BIGbJD53v5XqBJfptuMTkuqDsArgayR+9mhNXxyUjAkl
 NIxDxl7OncMKhNPA1XOcQ8bKHBmaDWr6VBZ4fiwELVjV1kNVRuoa4W5jV4BoerM15HE1
 V0GJ8fYbyPyUzHAUU47JhjKZre0ED0O8Q2nM47bLCBP0aSnRjDIQuX8gcP3kv7ZqLjIn
 vv3Q==
X-Gm-Message-State: APjAAAXMbL0RMyfFx5zwMRlxgut9dvdKUlY/UL5p6G4dout/E/Liftdb
 ol8LW6FBZDWUshrhZCl++tBhyw==
X-Google-Smtp-Source: APXvYqxVr1KeKBl9fDZ0hdeY1sFCgnP0B7WQQ+zbv1o/Br4N3gFYVXsVxmbBcagGPd2K5OEwEB4VuQ==
X-Received: by 2002:a7b:cf0b:: with SMTP id
 l11mr116705487wmg.143.1564573502176; 
 Wed, 31 Jul 2019 04:45:02 -0700 (PDT)
Received: from [192.168.43.238] (44.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.44])
 by smtp.gmail.com with ESMTPSA id t140sm2457250wmt.0.2019.07.31.04.45.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 04:45:01 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b3696656-201d-9777-0b73-b6903949d61f@redhat.com>
Date: Wed, 31 Jul 2019 13:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731075652.17053-5-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 4/8] hw/core: Add a config switch for
 the "register" device
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:56 AM, Thomas Huth wrote:
> The "register" device is only used by certain machines. Let's add
> a proper config switch for it so that it only gets compiled when we
> really need it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/Kconfig            | 1 +
>  hw/core/Kconfig       | 3 +++
>  hw/core/Makefile.objs | 2 +-
>  hw/dma/Kconfig        | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/Kconfig b/hw/Kconfig
> index dbae1c0852..b45db3c813 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -76,3 +76,4 @@ config XILINX_AXI
>  
>  config XLNX_ZYNQMP
>      bool
> +    select REGISTER
> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> index c2a1ae8122..d11920fcb3 100644
> --- a/hw/core/Kconfig
> +++ b/hw/core/Kconfig
> @@ -9,3 +9,6 @@ config FITLOADER
>  
>  config PLATFORM_BUS
>      bool
> +
> +config REGISTER

What about naming it REGISTER_ARRAY or REGISTER_BLOCK?

The API is:

    RegisterInfoArray *register_init_block32(...);

Cc'ing Alistair for better name ideas :)

> +    bool
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index f8481d959f..d6cfb2a81b 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -17,7 +17,7 @@ common-obj-$(CONFIG_SOFTMMU) += machine.o
>  common-obj-$(CONFIG_SOFTMMU) += loader.o
>  common-obj-$(CONFIG_FITLOADER) += loader-fit.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
> -common-obj-$(CONFIG_SOFTMMU) += register.o
> +common-obj-$(CONFIG_REGISTER) += register.o
>  common-obj-$(CONFIG_SOFTMMU) += or-irq.o
>  common-obj-$(CONFIG_SOFTMMU) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index 751dec5426..5c61b67bc0 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -16,6 +16,7 @@ config I8257
>  
>  config ZYNQ_DEVCFG
>      bool
> +    select REGISTER
>  
>  config STP2000
>      bool
> 

