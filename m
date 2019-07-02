Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE31CC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8720820659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8720820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiF6L-0005pe-Se
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiF4r-0004ys-LD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiF4o-0001Fk-Hj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:27:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:48029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiF4m-0001DS-NR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:27:49 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MyK9U-1iTm7Z1sGi-00yhiL; Tue, 02 Jul 2019 11:27:45 +0200
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, qemu-devel@nongnu.org
References: <20190616142253.GA71203@localhost.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ec540065-92a9-0fe5-60e4-7800ad04071d@vivier.eu>
Date: Tue, 2 Jul 2019 11:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616142253.GA71203@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IVJEJ/sV3dnxuRmi/MjX9wzFLB5NvX9NO1mxDQxfbfMqQSBj5EQ
 D4ov3CkXks3HVOSGBDW7iZgQ/5GMVONdMHFvqSnj70I/YMNR4mynJViDgQEYLQAHo2putoP
 xZgX2lKCWVbK6cKY+juJFVv+tENYQniBvyoAfV3XAPV6Q3dxC3iV8Z7qALIdFIjf/Xnj1A3
 nggsFVZqGc7vb0kM44avg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cIq/deIEtGg=:iYV3Xmmz7/Te+fvAVWWIYC
 781lWRcG5QYeZY8oxp9A55IUr2ReqqP1tVbrnLPsFWw0lsQe8FE0J9ByWH/ZH4JUhaud3o9Be
 vUWJ5jrZW3aU/FqR8sxIBHMExtFpKSIJEVjYqMHL8zUt3WjlioD3RbWJ4qEkm2UglZVLD8uRl
 Cx6B4wvXKqtQUl3eBdSKvrkhEaLow6Ug7jnO+hiPQR07qX+E+MFycteNUEXt/tIkXuWxZRJ2y
 H9mcvmrCQa5rqez7/g0BoIRl//Y+CdVyYnwcqvQM45UmzplWw5021SPxxVcvewbvRSGqStmvm
 hiwb4KJJqeGcPNt7/WlX8zNn7QEgryoWK8s2ozIUEKmRGMrD9zPgTgfUkQaOGsF2orIIowqTe
 KR5BB4PkgruUhuM1/h4v5umRCNB4JkYBCLLMl12EqiR17ctGS0TPQaKgV2k1ThkgU9Ip1/u3e
 2Jqypc9VGBxwGaqoYak0830Ga+/EciaW3fdF7LDhrsPjdMpSuDZ1LkDt3K//SxI1iaeIf+ALI
 h+7G/jhkFcu7ml4PhbdCZLyWyOJimPVlnV6ATNcF0vDgyrdkZ/iLyLme3VxJlK/aa/a5JRcE+
 T5a57M6vNt5xTvu7m1gA/Vc+wyQv1VqXDrphmJTVDEXT3FHg1GPcoG/ogkwXrthYn/M1XXIw8
 Awn9WQdsySnPXVK/JYhZfXYfKcs0yf+9gPs32lZqWnK+0s9ktoedGP5/443xdyzIncPoEkv/y
 xFusUhFnE58lMiBa1eRXYe8K+XGHhcOs69YwwhRxfp5UxV1gEmT2AscX0m4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH 2/6] Cascade m68k_features by
 m680xx_cpu_initfn() to improve readability
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

Le 16/06/2019 à 16:22, Lucien Murray-Pitts a écrit :
> The m680XX_cpu_initfn functions have been rearranged to cascade starting from
> the base 68000, so that the 68010 then inherits from this, and so on until the
> 68060.
> 
> This makes it simpler to track features since in most cases the m68k were
> product enhancements on each other, with only a few instructions being retired.
> 
> Because each cpu class inherits the previous CPU class, then for example
> the 68020 also has the feature 68010, and 68000 and so on upto the 68060.
> 
> - Added 68010 cpu class, and moved correct features into 68000/68010.
> - Added m68k_unset_feature to allow removing a feature in the inheritence
> - Created real m68030_cpu_initfn to replace the macro define
>   for more obvious calling/future expansion
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
> ---
>  target/m68k/cpu.c | 58 +++++++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index cc770a8042..f3246d6e72 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -42,6 +42,11 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
>      env->features |= (1u << feature);
>  }
>  
> +static void m68k_unset_feature(CPUM68KState *env, int feature)
> +{
> +    env->features &= (-1u - (1u << feature));
> +}
> +
>  /* CPUClass::reset() */
>  static void m68k_cpu_reset(CPUState *s)
>  {
> @@ -119,6 +124,21 @@ static void m68000_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
> +
> +/*
> + * Adds BKPT, MOVE-from-SR *now priv instr, and MOVEC, MOVES, RTD
> + */
> +static void m68010_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m68000_cpu_initfn(obj);
> +    m68k_set_feature(env, M68K_FEATURE_RTD);
> +    m68k_set_feature(env, M68K_FEATURE_BKPT);
> +}
> +
> +
>  /*
>   * Adds BFCHG, BFCLR, BFEXTS, BFEXTU, BFFFO, BFINS, BFSET, BFTST, CAS, CAS2,
>   *      CHK2, CMP2, DIVSL, DIVUL, EXTB, PACK, TRAPcc, UNPK.
> @@ -130,9 +150,7 @@ static void m68020_cpu_initfn(Object *obj)
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68k_set_feature(env, M68K_FEATURE_M68000);
> -    m68k_set_feature(env, M68K_FEATURE_USP);
> -    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> +    m68010_cpu_initfn(obj);
>      m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
>      m68k_set_feature(env, M68K_FEATURE_BRAL);
>      m68k_set_feature(env, M68K_FEATURE_BCCL);
> @@ -142,10 +160,7 @@ static void m68020_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
>      m68k_set_feature(env, M68K_FEATURE_FPU);
>      m68k_set_feature(env, M68K_FEATURE_CAS);
> -    m68k_set_feature(env, M68K_FEATURE_BKPT);
> -    m68k_set_feature(env, M68K_FEATURE_RTD);
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
> -    m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
>  /*
> @@ -156,7 +171,14 @@ static void m68020_cpu_initfn(Object *obj)
>   * NOTES:
>   *  5. Not valid on MC68EC030
>   */
> -#define m68030_cpu_initfn m68020_cpu_initfn
> +static void m68030_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m68020_cpu_initfn(obj);
> +}
> +
>  
>  /*
>   * Adds: CINV, CPUSH
> @@ -180,7 +202,7 @@ static void m68040_cpu_initfn(Object *obj)
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68020_cpu_initfn(obj);
> +    m68030_cpu_initfn(obj);
>      m68k_set_feature(env, M68K_FEATURE_M68040);
>  }
>  
> @@ -200,20 +222,11 @@ static void m68060_cpu_initfn(Object *obj)
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68k_set_feature(env, M68K_FEATURE_M68000);
> -    m68k_set_feature(env, M68K_FEATURE_USP);
> -    m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> -    m68k_set_feature(env, M68K_FEATURE_BRAL);
> -    m68k_set_feature(env, M68K_FEATURE_BCCL);
> -    m68k_set_feature(env, M68K_FEATURE_BITFIELD);
> -    m68k_set_feature(env, M68K_FEATURE_EXT_FULL);
> -    m68k_set_feature(env, M68K_FEATURE_SCALED_INDEX);
> -    m68k_set_feature(env, M68K_FEATURE_LONG_MULDIV);
> -    m68k_set_feature(env, M68K_FEATURE_FPU);
> -    m68k_set_feature(env, M68K_FEATURE_CAS);
> -    m68k_set_feature(env, M68K_FEATURE_BKPT);
> -    m68k_set_feature(env, M68K_FEATURE_RTD);
> -    m68k_set_feature(env, M68K_FEATURE_CHK2);
> +    m68040_cpu_initfn(obj);
> +    m68k_unset_feature(env, M68K_FEATURE_MOVEP);
> +
> +    /* Implemented as a software feature */
> +    m68k_unset_feature(env, M68K_FEATURE_QUAD_MULDIV);
>  }
>  
>  static void m5208_cpu_initfn(Object *obj)
> @@ -350,6 +363,7 @@ static const TypeInfo m68k_cpus_type_infos[] = {
>          .class_init = m68k_cpu_class_init,
>      },
>      DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
> +    DEFINE_M68K_CPU_TYPE("m68010", m68010_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
>      DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

