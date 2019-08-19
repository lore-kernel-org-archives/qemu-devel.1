Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4294BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F5E2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F5E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgGU-0006RI-VO
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzgF4-0005aj-EC
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzgF3-0002q6-7p
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:54:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzgF2-0002pa-Vf
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:54:29 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF0787BDAC
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:54:27 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k8so4021189wrx.19
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yT9pnnsNKM3WWnqQ1PySWCBSbslqsS2LkflPYolqajU=;
 b=EmpJiE89tF5HODPCECaAT2e3XeZUCLTDNenygyNe9KB7LQAJ9qv5cUf8vw4LRlUc8U
 QI9LrbimtoCCS4qAahA78uqANEfg88MZ0AoD3oyiaP6VtgbmbUEik3nbSmopm7LPwB06
 VIa1yMGn5BG6sUqq8E95zuJeRXhPrkoynQ9ca99/UXfGg7ZL/hBcHCykXIvv4NoQqXRp
 m+trq8AU5lqO0fsTFFeN0S+GvgNxsQL2jgLgNr45gmyUXyqYFvgXMC4mwLXXh5/3q2hP
 u389WIL9w+OE1et/W7DGj8dU9+T5dh03rGUvNMT6mfivoBjW0HEuwHA++wMWdWGMprZl
 BnKg==
X-Gm-Message-State: APjAAAXpw1rLe8L265kq4hUvvp+oQyNDcEtOJ0IzOKy99CeRv1E1FQg1
 SyELCSYwsOWbmKIsJhFPjmnu+vKktliZWUG7iyxZ8FpHp4fqH81w9yxYal6VtzQWCtYk6tBgY64
 tbBJwCawjKj2QQ3E=
X-Received: by 2002:adf:f404:: with SMTP id g4mr26159865wro.290.1566215666657; 
 Mon, 19 Aug 2019 04:54:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlQdEeACZKSynERkiH6g8b5SQr5H6ovRNC7BbWFbCMxmb9J3rxo+ArhLPdrD/jhX/5SdX6Xg==
X-Received: by 2002:adf:f404:: with SMTP id g4mr26159850wro.290.1566215666501; 
 Mon, 19 Aug 2019 04:54:26 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u129sm17140742wmb.12.2019.08.19.04.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 04:54:25 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190817101931.28386-1-thuth@redhat.com>
 <20190817101931.28386-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4b760d05-7d18-f7b8-cf2f-d7ed855baf7c@redhat.com>
Date: Mon, 19 Aug 2019 13:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190817101931.28386-5-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/8] hw/core: Add a config switch for
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/19 12:19 PM, Thomas Huth wrote:
> The "register" device is only used by certain machines. Let's add
> a proper config switch for it so that it only gets compiled when we
> really need it.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/Kconfig            | 1 +
>  hw/core/Kconfig       | 3 +++
>  hw/core/Makefile.objs | 2 +-
>  hw/dma/Kconfig        | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/Kconfig b/hw/Kconfig
> index dbae1c0852..b45db3c813 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -76,3 +76,4 @@ config XILINX_AXI
> =20
>  config XLNX_ZYNQMP
>      bool
> +    select REGISTER

I still find REGISTER confusing, and prefer Alistair's suggestion:
REGISTER_API.

Since this patch is valid:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> index c2a1ae8122..d11920fcb3 100644
> --- a/hw/core/Kconfig
> +++ b/hw/core/Kconfig
> @@ -9,3 +9,6 @@ config FITLOADER
> =20
>  config PLATFORM_BUS
>      bool
> +
> +config REGISTER
> +    bool
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index f8481d959f..d6cfb2a81b 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -17,7 +17,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
>  common-obj-$(CONFIG_FITLOADER) +=3D loader-fit.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
> -common-obj-$(CONFIG_SOFTMMU) +=3D register.o
> +common-obj-$(CONFIG_REGISTER) +=3D register.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index 751dec5426..5c61b67bc0 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -16,6 +16,7 @@ config I8257
> =20
>  config ZYNQ_DEVCFG
>      bool
> +    select REGISTER
> =20
>  config STP2000
>      bool
>=20

