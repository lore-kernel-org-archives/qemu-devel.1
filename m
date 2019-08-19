Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37580C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E5C206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnQ/197V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E5C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo1G-00058f-3e
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hzo0D-0004Tg-Cb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hzo0C-0000O5-6Y
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:11:41 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hzo0B-0000NP-Su; Mon, 19 Aug 2019 16:11:40 -0400
Received: by mail-lf1-x142.google.com with SMTP id j17so2324485lfp.3;
 Mon, 19 Aug 2019 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vz1QfNHZvV4l7jIAawaglagw5PWlIGcW8gQ+ud4/D50=;
 b=lnQ/197VkoJx2KGpOH7fpcQGB9E7gDeIlomPfNeRp6K6UQnPnjQYnhPtkoh9CWFs9z
 knLaO20VWAduOamo+UEhQgVEP+0QGuS3w9XMfrFi+2921Zp3lrcgWC/nAPpN2d7FkN/L
 U3g6Digh7G5h79ySh5X0S3g1HzBTr8EPWDQ3Y26PiHMlaRLncYwzhFRPik8ueax5f+kl
 xmmOaXyinY+7Q+pBAS63mYIJZXr84dyDNKQ4HECVhFuz3BNCRce8HwSLTjpjyGCaBkon
 CjIEvTEwZO1hbpaCYWiImHvN9Vnos6nSwh92bFYJuiXEVd1VKYeX7/XhGCWufcRYZG+8
 4cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vz1QfNHZvV4l7jIAawaglagw5PWlIGcW8gQ+ud4/D50=;
 b=Z5XtotDNz8yBStyDq+/zguRyAlGwVaxfb/g8jBm6n0v76bOqpEofunrYFWhzFpxNgv
 qT08FLr//QsMQto/pGNqXX1Ig+lg12XFSF69IqdcRLMPb4XnvX/Dyyrvhf+72xUidPKg
 kSJMsNlKUyVzOZi3zM3ZXZkTGttc0Wz1f+0gPleVY7XYmFDACzyF8r+PRnIDb5ZxThen
 NIosDavy6pbMy21ypwb09HIA1H9hnjhkOmi414hrZVF4U4GGbT7DP9cTxaK8ZtcbFVyo
 lfgzDnXBdaQzpO78Cz/JHn1Le0TQz1/GjV4zxp8ixvG0ggmCH+TyprBfjJGfomgmapDL
 fb+w==
X-Gm-Message-State: APjAAAXiKwxjs/eu/IZyAU0svY5a7iqL0P8RSS67/sz/QL/cLli0DEb7
 vf7z160dqiTl3CVPQWz7EKzFjVME5btgOB0UHxg=
X-Google-Smtp-Source: APXvYqy+mZfXQxiZdzQ/dRXbsP4e/8nkPJowQV80+QoT9Z/WB0B2zX3scAG6urEMeVGcKNPROWlmXifwAdj5U4k8nBQ=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr13061789lfy.141.1566245498446; 
 Mon, 19 Aug 2019 13:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190817101931.28386-1-thuth@redhat.com>
 <20190817101931.28386-5-thuth@redhat.com>
In-Reply-To: <20190817101931.28386-5-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2019 13:07:37 -0700
Message-ID: <CAKmqyKPY-JmZZmgYjbWgBggN+nE+uOgzBg8UE8_53ztO4+YsXg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 17, 2019 at 3:24 AM Thomas Huth <thuth@redhat.com> wrote:
>
> The "register" device is only used by certain machines. Let's add
> a proper config switch for it so that it only gets compiled when we
> really need it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.18.1
>
>

