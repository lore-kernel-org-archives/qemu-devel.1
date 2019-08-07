Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA6AC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14768222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14768222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIag-0003vk-Ao
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvIaI-0003U7-Ly
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvIaH-0004vS-DS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:50:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvIaH-0004v0-7e
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:50:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so413585wrj.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VNFyDQRtvsyTvrQyA2h/h0OY18sccEnBH1UboFw78Lc=;
 b=KSr2rP8xhfm8J4xyGDdYtzXWog8dLLSf3T/nZEf539MJIjR2iyRMRWWpXWT+hJbQhG
 4LXMfKQVDtFp1NwTtewQub3rNmc0pKMrqmJYghUJolN9Yk6DtPPPLuipNfmycEEHslpg
 zHf0fPt9jgePLbuIF0eGmw3F5/m7Du25cS+346qBCuwShaPYrd31GWu5Q7fN8XRdZUdC
 qfF56uJGz8mPeAg/4PHKXTBZMONQ0uahCWen5af3B+XSw15pD8DP+XZd7iR5yLrRQkuY
 SbVvH3T8BXLMRwsO004LxN2gHIJejHOAhjdBF94qZHjNkHlk5TUDZQ6ob/c2aIqy1iYL
 vWsw==
X-Gm-Message-State: APjAAAVofwnuB+Y3NZRNia4tBwvQAVb5Tc5cjkHoguozgv4pYLWY7jBs
 UTKcdUNfPZYqLODdo6gL4jgWNA==
X-Google-Smtp-Source: APXvYqx5SMgiNEiLLtrI39cT82qpaW+LM0L0oqIbtAoTmN/v6T7KMD1g5GMQFUuquD9fFW6Ys2GwBQ==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr9151425wrr.5.1565171416277;
 Wed, 07 Aug 2019 02:50:16 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id u6sm87281815wml.9.2019.08.07.02.50.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 02:50:15 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-4-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e74c8dae-9270-9f07-e6df-637c13530d60@redhat.com>
Date: Wed, 7 Aug 2019 11:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565163924-18621-4-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 03/28] riscv: Add a sifive_cpu.h to
 include both E and U cpu type defines
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 9:44 AM, Bin Meng wrote:
> Group SiFive E and U cpu type defines into one header file.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Changes in v2: None
> 
>  include/hw/riscv/sifive_cpu.h | 31 +++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_e.h   |  7 +------
>  include/hw/riscv/sifive_u.h   |  7 +------
>  3 files changed, 33 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/riscv/sifive_cpu.h
> 
> diff --git a/include/hw/riscv/sifive_cpu.h b/include/hw/riscv/sifive_cpu.h
> new file mode 100644
> index 0000000..1367996
> --- /dev/null
> +++ b/include/hw/riscv/sifive_cpu.h
> @@ -0,0 +1,31 @@
> +/*
> + * SiFive CPU types
> + *
> + * Copyright (c) 2017 SiFive, Inc.
> + * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_SIFIVE_CPU_H
> +#define HW_SIFIVE_CPU_H
> +
> +#if defined(TARGET_RISCV32)
> +#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
> +#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
> +#elif defined(TARGET_RISCV64)
> +#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
> +#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
> +#endif
> +
> +#endif /* HW_SIFIVE_CPU_H */
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index d175b24..e17cdfd 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -19,6 +19,7 @@
>  #ifndef HW_SIFIVE_E_H
>  #define HW_SIFIVE_E_H
>  
> +#include "hw/riscv/sifive_cpu.h"
>  #include "hw/riscv/sifive_gpio.h"
>  
>  #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
> @@ -83,10 +84,4 @@ enum {
>  #define SIFIVE_E_PLIC_CONTEXT_BASE 0x200000
>  #define SIFIVE_E_PLIC_CONTEXT_STRIDE 0x1000
>  
> -#if defined(TARGET_RISCV32)
> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E31
> -#elif defined(TARGET_RISCV64)
> -#define SIFIVE_E_CPU TYPE_RISCV_CPU_SIFIVE_E51
> -#endif
> -
>  #endif
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 892f0ee..4abc621 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -20,6 +20,7 @@
>  #define HW_SIFIVE_U_H
>  
>  #include "hw/net/cadence_gem.h"
> +#include "hw/riscv/sifive_cpu.h"
>  
>  #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
>  #define RISCV_U_SOC(obj) \
> @@ -77,10 +78,4 @@ enum {
>  #define SIFIVE_U_PLIC_CONTEXT_BASE 0x200000
>  #define SIFIVE_U_PLIC_CONTEXT_STRIDE 0x1000
>  
> -#if defined(TARGET_RISCV32)
> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U34
> -#elif defined(TARGET_RISCV64)
> -#define SIFIVE_U_CPU TYPE_RISCV_CPU_SIFIVE_U54
> -#endif
> -
>  #endif
> 

