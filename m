Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE63C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0289F20700
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0289F20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEK3-0007su-Jr
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFEHz-0006Pv-Bh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFEHx-0004uf-5X
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFEHw-0004u4-Hn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:17:44 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C0C92A09A1
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 09:17:43 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so1138217wmk.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3m+wOPB/Fkr6AYXJ+FLLgauwXMN+ekeAdaB8/8pXDp8=;
 b=pVHgOofi3SBf8Bb2R9MDStqK6ft6X9YIUa4poQT5q4SZm4anxooXwD0sP6EyMDjGj8
 XdVmTjCO0Y9LRSBVp6rmUQvLDjO2h1PPiqcIpOeTF5Zws/nRWZS3syAdmsnyuT3siHg4
 8nHEQsvTGbU1m1pA1hsWR/Id6m/ECIhPuI0p2EOpIQEERicXBd8vv5+XKQKy4tfJ0KJp
 Fmr3qDWqrV7VtdnLiFcz9o97jrpfuofPLbWDzVQad+gqbEsCnMABM25rHwuG4FJ9iING
 Be1N4ZVff9jXjYhn0HkHv/5Pb9mmVlXoFPs7h/lkKcmpalwGmLPMr6VF5DP8Rdecc0Im
 PBTA==
X-Gm-Message-State: APjAAAX1t6AL3QAmqCuq91nUvzT26faAqidZNkyxG3pWKVEABnNRKu6u
 hroAsOSacWslVKFPTUeK+nDg/fohqhyE+oREj7+fmFQ7QMxdzKxRhBrSut54rnQz9npzOVt0AfJ
 e5SkaStfyH4Ux8bc=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr2938097wmo.114.1569921461727; 
 Tue, 01 Oct 2019 02:17:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkcqWlJS7X/0FaFvdZuG9LZwHalBKRMfrHPzNttEc2gjLy9181xgM51CNQIOtFuaWqEh0D0w==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr2938078wmo.114.1569921461447; 
 Tue, 01 Oct 2019 02:17:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id z3sm1859334wmi.30.2019.10.01.02.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:17:40 -0700 (PDT)
Subject: Re: [PATCH] hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for
 isa-superio.c
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20190930150436.18162-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bddb6717-e1cd-3a0f-cdb3-3862efc407ee@redhat.com>
Date: Tue, 1 Oct 2019 11:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930150436.18162-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/19 17:04, Thomas Huth wrote:
> Currently, isa-superio.c is always compiled as soon as CONFIG_ISA_BUS
> is enabled. But there are also machines that have an ISA BUS without
> any of the superio chips attached to it, so we should not compile
> isa-superio.c in case we only compile a QEMU for such a machine.
> Thus add a proper CONFIG_ISA_SUPERIO switch so that this file only gets
> compiled when we really, really need it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/isa/Kconfig       | 10 +++++++---
>  hw/isa/Makefile.objs |  2 +-
>  hw/mips/Kconfig      |  1 +
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 6db0d7970c..98a289957e 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -13,9 +13,13 @@ config I82378
>      select MC146818RTC
>      select PCSPK
>  
> -config PC87312
> +config ISA_SUPERIO
>      bool
>      select ISA_BUS
> +
> +config PC87312
> +    bool
> +    select ISA_SUPERIO
>      select I8259
>      select I8254
>      select I8257
> @@ -34,14 +38,14 @@ config PIIX4
>  
>  config VT82C686
>      bool
> -    select ISA_BUS
> +    select ISA_SUPERIO
>      select ACPI_SMBUS
>      select SERIAL_ISA
>      select FDC
>  
>  config SMC37C669
>      bool
> -    select ISA_BUS
> +    select ISA_SUPERIO
>      select SERIAL_ISA
>      select PARALLEL
>      select FDC
> diff --git a/hw/isa/Makefile.objs b/hw/isa/Makefile.objs
> index 9e106df186..ff97485504 100644
> --- a/hw/isa/Makefile.objs
> +++ b/hw/isa/Makefile.objs
> @@ -1,5 +1,5 @@
>  common-obj-$(CONFIG_ISA_BUS) += isa-bus.o
> -common-obj-$(CONFIG_ISA_BUS) += isa-superio.o
> +common-obj-$(CONFIG_ISA_SUPERIO) += isa-superio.o
>  common-obj-$(CONFIG_APM) += apm.o
>  common-obj-$(CONFIG_I82378) += i82378.o
>  common-obj-$(CONFIG_PC87312) += pc87312.o
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 62aa01b29e..2c2adbc42a 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -13,6 +13,7 @@ config R4K
>  
>  config MALTA
>      bool
> +    select ISA_SUPERIO
>  
>  config MIPSSIM
>      bool
> 

Queued, thanks.

Paolo

