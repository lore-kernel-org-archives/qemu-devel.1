Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3EEC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 04:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0150C2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 04:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0150C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDLbL-00018p-Uo
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 00:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDLaY-0000eV-PF
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDLaT-0002at-5T
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:41:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDLaS-0002YB-KU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:41:05 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F182820260
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 04:41:01 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so466294wmh.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 21:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MBnXfODgmCJWMPx8h+TMLX9rZII1R9xkatPC/0XlcDI=;
 b=fFl/ppQRB7P9sqF7qXjFQtl9JLpaxNXZwOYvVBJBb+NOLp9IaaUh3R9b+L1A2cblgC
 NVH4QF1G3ZjiGIZsZlBZwUVWU5+k58Ul99kokvJl0i0IDY6n9tdbIApPLFPcm8ghs7OU
 K1MpmHbA2trl0R5rv9o1Rvv/vGK2Wx27hIa8OVQsN1dSCWsRvFCAQxoNEFt9my9RfA7B
 MF0adrNeG+L4+8CaEWnXuxL8wYtnrO+SfyAlAvmkiDCEcxf1eo5XVm9eSS3KTU+PPCIL
 VR8BcqJKXox66SbPw0Xt91OsTM7YDQzYBdzHOvkX2mtibGjDaDMpM/LbiRGlCiSEZFPx
 E7xg==
X-Gm-Message-State: APjAAAUmJV3O53Xdk+3B9XQZasZ4qag8JK6ytcNu6nB9dPmMYHeIzHWE
 0BZgY/8ohxOCpZ03spF9xe5bK+inzgxI3KCM06TcYsccEooSYzMME7uojAt64Yd/oGeMiNR+BEt
 sLA3AiD3bTu7pO2U=
X-Received: by 2002:a05:6000:10c2:: with SMTP id
 b2mr1109187wrx.45.1569472860396; 
 Wed, 25 Sep 2019 21:41:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzwYvQ0ab3GnOjoafi3rzG2oJrfV5g9Gd0ysHHTxL6jzizunVt7DYER8DUq3zOGbf8sqnw4g==
X-Received: by 2002:a05:6000:10c2:: with SMTP id
 b2mr1109176wrx.45.1569472860200; 
 Wed, 25 Sep 2019 21:41:00 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v8sm1022367wra.79.2019.09.25.21.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 21:40:59 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] target/i386: drop the duplicated definition of
 cpuid AVX512_VBMI macro
To: Tao Xu <tao3.xu@intel.com>, ehabkost@redhat.com, sgarzare@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
References: <20190926021055.6970-1-tao3.xu@intel.com>
 <20190926021055.6970-3-tao3.xu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d99ffd9e-c07a-2e71-b19a-ff5958995991@redhat.com>
Date: Thu, 26 Sep 2019 06:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190926021055.6970-3-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 4:10 AM, Tao Xu wrote:
> Drop the duplicated definition of cpuid AVX512_VBMI macro and rename
> it as CPUID_7_0_ECX_AVX512_VBMI. Rename CPUID_7_0_ECX_VBMI2 as
> CPUID_7_0_ECX_AVX512_VBMI2.
>=20
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  target/i386/cpu.c           | 8 ++++----
>  target/i386/cpu.h           | 5 ++---
>  target/i386/hvf/x86_cpuid.c | 2 +-
>  3 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9e0bac31e8..71034aeb5a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2412,8 +2412,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_A=
DX |
>              CPUID_7_0_EBX_SMAP,
>          .features[FEAT_7_0_ECX] =3D
> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PK=
U |
> -            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0=
_ECX_PKU |
> +            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
>              CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
>              CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
>              CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
> @@ -2470,8 +2470,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>              CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>          .features[FEAT_7_0_ECX] =3D
> -            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PK=
U |
> -            CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
> +            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0=
_ECX_PKU |
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
> =20
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
> @@ -89,7 +89,7 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint3=
2_t idx,
>                  ebx &=3D ~CPUID_7_0_EBX_INVPCID;
>              }
> =20
> -            ecx &=3D CPUID_7_0_ECX_AVX512BMI | CPUID_7_0_ECX_AVX512_VP=
OPCNTDQ;
> +            ecx &=3D CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_=
VPOPCNTDQ;
>              edx &=3D CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX51=
2_4FMAPS;
>          } else {
>              ebx =3D 0;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

