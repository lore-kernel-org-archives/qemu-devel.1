Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20521C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E687920872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E687920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2uC-000283-TW
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iD2sd-0000Sm-A3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iD2sc-00057l-3K
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:42:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iD2sb-00057T-Rb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:42:34 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C45E67FDEC
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:42:32 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j3so1974692wrn.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 01:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q0NMEaBrTLFUww5yG+SWlzfbpeu85QESFklvE7oBCyk=;
 b=N7je9sMy06rfc5/2Qo8DXCW38N6Dia6er4moIT33q6GI7x8dn5izwZYIrqd9vQTRp2
 nHAE09ux0rQqWfJ5C+pRlmlPnKggdwH7QmWcMgMhja4jhxUZlzeeP7Fza9qkXa6LymUi
 38qKePf7CmJUeNPvpVHw4ZYZagnXKXUepbd/zh6WWVl/cbjIhU/T6YxodYwerrrblJ4S
 cjYu0eLWNWjo4eSUcAk0MMBjB5QFQRU4KrzyVdsm+0nWUfBpbhX0xRVH5pTCpZwrJS0+
 AQa1G8cU6q3x1CmC4EZuZglaBm2nPT2pguQgcnPf3T9nl62VkS1vHD4c+jN7uekyW1n4
 9L8A==
X-Gm-Message-State: APjAAAX8VJFAvsXeGJj6gDrtobdmjSUOa8HqvX5YPAYGWiXP4w8Ydqj6
 F9hFTLrVsiGYbrvtjoJMrnmc/g8fbn7USGFQPqPNyl8bQqdogXH1yZvnUeNOYj7M3hmPItYRyjT
 VxFA3lMVZy7Q0I4s=
X-Received: by 2002:adf:fa10:: with SMTP id m16mr7857501wrr.322.1569400951505; 
 Wed, 25 Sep 2019 01:42:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNj7+KA0kPXIhSSHCi/xsEY1hZ4md1cByAOHpYeD5gqA2b198gP62sHdscXuESoiwT6XuGbQ==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr7857470wrr.322.1569400951246; 
 Wed, 25 Sep 2019 01:42:31 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id a6sm5222141wrr.85.2019.09.25.01.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 01:42:30 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:42:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v4 2/2] target/i386: drop the duplicated definition of
 cpuid AVX512_VBMI marco
Message-ID: <20190925084228.sew5mtwdlwmwe4ju@steredhat>
References: <20190924010209.27149-1-tao3.xu@intel.com>
 <20190924010209.27149-3-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924010209.27149-3-tao3.xu@intel.com>
User-Agent: NeoMutt/20180716
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Tao,

Typo in the commit title and message? s/marco/macro?

On Tue, Sep 24, 2019 at 09:02:09AM +0800, Tao Xu wrote:
> Drop the duplicated definition of cpuid AVX512_VBMI and marco and
I'm not native speaker but I'd remove some 'and'      ^ this

> rename it as CPUID_7_0_ECX_AVX512_VBMI. And rename CPUID_7_0_ECX_VBMI2
                                          ^ this

> as CPUID_7_0_ECX_AVX512_VBMI2.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  target/i386/cpu.c           | 8 ++++----
>  target/i386/cpu.h           | 5 ++---
>  target/i386/hvf/x86_cpuid.c | 2 +-
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 

The rest LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9e0bac31e8..71034aeb5a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2412,8 +2412,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
>              CPUID_7_0_EBX_SMAP,
>          .features[FEAT_7_0_ECX] =
> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> -            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
>              CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>              CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
> @@ -2470,8 +2470,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>              CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>          .features[FEAT_7_0_ECX] =
> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> -            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
>              CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>              CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index fa4c4cad79..8e090acd74 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EBX_AVX512VL          (1U << 31)
>  
>  /* AVX-512 Vector Byte Manipulation Instruction */
> -#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
> -#define CPUID_7_0_ECX_VBMI              (1U << 1)
> +#define CPUID_7_0_ECX_AVX512_VBMI       (1U << 1)
>  /* User-Mode Instruction Prevention */
>  #define CPUID_7_0_ECX_UMIP              (1U << 2)
>  /* Protection Keys for User-mode Pages */
> @@ -704,7 +703,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  /* OS Enable Protection Keys */
>  #define CPUID_7_0_ECX_OSPKE             (1U << 4)
>  /* Additional AVX-512 Vector Byte Manipulation Instruction */
> -#define CPUID_7_0_ECX_VBMI2             (1U << 6)
> +#define CPUID_7_0_ECX_AVX512_VBMI2      (1U << 6)
>  /* Galois Field New Instructions */
>  #define CPUID_7_0_ECX_GFNI              (1U << 8)
>  /* Vector AES Instructions */
> diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
> index 4d957fe896..16762b6eb4 100644
> --- a/target/i386/hvf/x86_cpuid.c
> +++ b/target/i386/hvf/x86_cpuid.c
> @@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>                  ebx &= ~CPUID_7_0_EBX_INVPCID;
>              }
>  
> -            ecx &= CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
> +            ecx &= CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ;
>              edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
>          } else {
>              ebx = 0;
> -- 
> 2.20.1
> 

-- 

