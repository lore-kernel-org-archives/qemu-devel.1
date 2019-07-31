Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26518C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AA0206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AA0206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqyF-0008Qo-45
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsqvq-0006yT-4g
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsqvo-0002md-8D
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:54:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsqvm-0002kT-Nv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:54:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so61346953wms.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dqTQPKdQpkPSJiu+poW2tkVf2734swbxwoe9aDlozWw=;
 b=V0Q7R46857Dfsl8oO4AvjMGha9bBL8Ws3qr0oWpnfK4C40tjaw3IM6RV4AIYtBwmUR
 XZIFWRU1DjKN2dVz/Wvzke2jZbRmubQhKWqkG5zeVWLUCit0W5qv/LQnbIDalJzEkTLt
 T9lfJfmTIFdjnKZ0n8rpojLrcF8tlZGfpmnWSJ4mf/Ho4+ZjkAPotDeY8nlTvtoQR/lj
 9F6D9dmjiCNTQYjoXyysy5eDfXe0ucy42vxqGPsRSaFGbpBjCAn1WbwOp3VqvayamQOq
 eSUk8Fs7tKrp/zYpyZA9k3/QYiq/CzQzvVyKAv626Z4O0qrsjZgh4AMqmmX5GPTymkY2
 3kCw==
X-Gm-Message-State: APjAAAXmW0vBKdZUrjym68YAc/eHI/wU8KR89Cd6Wer+WxvxONBHKT3B
 qIb0q01iv6LeZYiZg2xvNikPIA==
X-Google-Smtp-Source: APXvYqzaWEEp1w2CPYIlrSeMBFCc9syn2lfGKUN1r0raE+p+LRV8y1XbkWSdMT6v4mS4Ir3+voLGLQ==
X-Received: by 2002:a05:600c:254b:: with SMTP id
 e11mr103976662wma.171.1564588459754; 
 Wed, 31 Jul 2019 08:54:19 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id k17sm90598087wrq.83.2019.07.31.08.54.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 08:54:19 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-9-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3a635a29-1bcb-04ac-14b1-b0c9981850d4@redhat.com>
Date: Wed, 31 Jul 2019 17:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731075652.17053-9-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 8/8] hw/core: Add a config switch for
 the generic loader device
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
> The generic loader device is completely optional. Let's add a proper
> config switch for it so that people can disable it if they don't need
> it and want to create a minimalistic QEMU binary.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/core/Kconfig       | 4 ++++
>  hw/core/Makefile.objs | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
> index fffb3d62b2..fdf03514d7 100644
> --- a/hw/core/Kconfig
> +++ b/hw/core/Kconfig
> @@ -7,6 +7,10 @@ config PTIMER
>  config FITLOADER
>      bool
>  
> +config GENERIC_LOADER
> +    bool
> +    default y
> +
>  config OR_IRQ
>      bool
>  
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index bb1afe422a..b49f880a0c 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -21,7 +21,7 @@ common-obj-$(CONFIG_REGISTER) += register.o
>  common-obj-$(CONFIG_OR_IRQ) += or-irq.o
>  common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
>  common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
> -common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
> +common-obj-$(CONFIG_GENERIC_LOADER) += generic-loader.o
>  common-obj-$(CONFIG_SOFTMMU) += null-machine.o
>  
>  obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
> 

