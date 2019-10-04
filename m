Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60013C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FCB215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FCB215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKkB-0002wB-TV
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGK3d-0006Us-UA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGK3c-0006UV-Ca
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGK3c-0006Td-2d
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:39:28 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A0C5C05AA61
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:39:27 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id h6so2449668wrh.6
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vobup07TQuXLeqn05FwJTaNe75SF0hv7bXAlkzWugoo=;
 b=dB4pEVyT3BgiKTcVV8ib3LEaBZOdjTRkE08fPnCbQyKh32InC0V+gHFnKj8FOlMTrB
 H4rXzX/CEyqKlt6uUwmMptx4BNiQJNtTM/uTIG7m8h3l9mzjDxvqxFfBmEYnzkzaGfDa
 cahwCdz+32KqQ7V5sKyloJBJeoaHknyExxVH7eVqwWqQZesqem8qiigurxxGv6AFn12p
 OyRF56i2AGqmORAIgOyaK3PWapDgWsY77BJ6lFljlLjKRmQbUr2qRb4SWdtOeXVng91K
 vKUXISxc5YSUJq7S73l23YqeX1cv2AANlUh82bM2/Qz7SuRpm2mLefbM4dIt2xxRwLKM
 WBIQ==
X-Gm-Message-State: APjAAAU8T+1i1VjPfwm2yDTNbzHHGx798QqrSkv46aSF0VAfO8u5xEay
 R5cvBcc5YzBNzabmaA/2LBPQYyuwNQFsy/nizMRV53SkpSup5OKi8ePDqSMvnLnzBjpprOjg3E3
 xwWG6mDrRG+nmkjk=
X-Received: by 2002:adf:f190:: with SMTP id h16mr10632608wro.357.1570181965636; 
 Fri, 04 Oct 2019 02:39:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYWT/dfes/NtTQdFvC8QqD3Rl2gG5vYJDShl0N8YaDB/wrxIBKkpcmnQzMbtdVkAlQ/CL2gw==
X-Received: by 2002:adf:f190:: with SMTP id h16mr10632588wro.357.1570181965387; 
 Fri, 04 Oct 2019 02:39:25 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t83sm8660182wmt.18.2019.10.04.02.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 02:39:24 -0700 (PDT)
Subject: Re: [PATCH] exynos4210_gic: Suppress gcc9 format-truncation warnings
To: David Gibson <david@gibson.dropbear.id.au>, i.mitsyanko@gmail.com,
 peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>
References: <20191004025509.3012-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8a33744a-9ac5-4359-62d0-ccd9c9c43676@redhat.com>
Date: Fri, 4 Oct 2019 11:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004025509.3012-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 4:55 AM, David Gibson wrote:
> exynos4210_gic_realize() prints the number of cpus into some temporary
> buffers, but it only allows 3 bytes space for it.  That's plenty - I'm
> pretty sure that existing machines will only ever set this value to 2
> (EXYNOS4210_NCPUS).  But the compiler can't really be expected to figure
> that out.
> 
> Some[*] gcc9 versions therefore emit -Wformat-truncation warnings.  Fix
> that by allowing more space in the temporary buffers - these are on stack
> very briefly before being essentially strdup()ed inside the memory region
> code, so there's not much cost to doing so.
> 
> [*] The bizarre thing here, is that I've long gotten these warnings
> compiling in a 32-bit x86 container as host - Fedora 30 with
> gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal x86_64 host
> - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/intc/exynos4210_gic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
> index a1b699b6ba..2e5e47f9ec 100644
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -290,8 +290,8 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>       const char cpu_prefix[] = "exynos4210-gic-alias_cpu";
>       const char dist_prefix[] = "exynos4210-gic-alias_dist";
> -    char cpu_alias_name[sizeof(cpu_prefix) + 3];
> -    char dist_alias_name[sizeof(cpu_prefix) + 3];
> +    char cpu_alias_name[sizeof(cpu_prefix) + 10];
> +    char dist_alias_name[sizeof(cpu_prefix) + 10];

Hmm magic again... So GCC provides a new warning with no helpful 
definitions about how to clean this :(

We already have:
#define UUID_FMT_LEN 36

What about adding/using UINT32_FMT_LEN?

>       SysBusDevice *gicbusdev;
>       uint32_t i;
>   
> 

