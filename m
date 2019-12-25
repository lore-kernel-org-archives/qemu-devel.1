Return-Path: <SRS0=MlkC=2P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D8BC2D0DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 09:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1622072A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2019 09:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1622072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ik2dF-0006Ze-QC
	for qemu-devel@archiver.kernel.org; Wed, 25 Dec 2019 04:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1ik2cf-0006B4-Rd
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 04:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1ik2ce-00056n-Hb
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 04:06:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1ik2ce-00054v-BQ
 for qemu-devel@nongnu.org; Wed, 25 Dec 2019 04:06:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so21376439wrl.13
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2019 01:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pW7b7D0fin435TJppBBm+OfkLSxj//BCN4ydChX7Aro=;
 b=iZtP8SyYsUgk4O8w5l/i6qleoRh1NJ9sm7/JBSRm0O537srr/7Vm2e015I4Fcyq/Ql
 shHRXhfhwc6OtUQ/ZG0Ta1YhyzOBs/w86K7xjYcwfq5yJ9/1E5OwOPEHcbqoD49UlIHf
 hu4567pF8wMclGkcGxtKuCDUUKaij0q/Sgpw3F2FBwdC2Q+/bKeY8mBRh3F1h9bQZwrJ
 io8JH/giSu2/RMCjngN7xmiYdtvYcVFKM55gATuj8XFxxM0GJCCwADduxhYSPxMrzIKH
 eqTO0wAQ0ynlgTppYJ1fz7UhrIqDwE6cvRl+ONxUhzmYuwP0wMFVEMd1c/QBwC7fyZgy
 3Fmw==
X-Gm-Message-State: APjAAAVyryK6zbu/zhLMLvq0QR0TnSoyg/mlTkyccOHW/6FeL5GHKSoS
 V/Bto5ZjYZPB8GqHBtQNhDg=
X-Google-Smtp-Source: APXvYqzCfLrD6so1fUeLtZTKjCvMyP/aEV7rmgIG7j//M6X2jCLiG/HrBbsIiGkD1pBrAuxqN5cu0w==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr40376735wrw.233.1577264786879; 
 Wed, 25 Dec 2019 01:06:26 -0800 (PST)
Received: from thl530.speedport.ip
 (p200300C11F1176A377490045B03282AA.dip0.t-ipconnect.de.
 [2003:c1:1f11:76a3:7749:45:b032:82aa])
 by smtp.gmail.com with ESMTPSA id z18sm4995964wmf.21.2019.12.25.01.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Dec 2019 01:06:26 -0800 (PST)
Date: Wed, 25 Dec 2019 10:06:15 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/m68k: only change valid bits in CACR
Message-ID: <20191225100615.1b15bb25@thl530.speedport.ip>
In-Reply-To: <20191220172415.35838-1-laurent@vivier.eu>
References: <20191220172415.35838-1-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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

Am Fri, 20 Dec 2019 18:24:15 +0100
schrieb Laurent Vivier <laurent@vivier.eu>:

> This is used by netBSD (and MacOS ROM) to detect the MMU type
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: change accordingly to Thomas' comments
>       - Replace MMU feature id by a CPU feature id
>       - fix 68030 mask
>       - add 68060 mask
>       - only mask in m68k_movec_to() function
> 
>  target/m68k/cpu.c    | 27 +++++++++++++++++++++------
>  target/m68k/cpu.h    |  5 ++++-
>  target/m68k/helper.c | 10 +++++++++-
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index e6596de29c..f6a46bf2fb 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -114,11 +114,8 @@ static void m68000_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
>  
> -static void m68020_cpu_initfn(Object *obj)
> +static void m680x0_cpu_common(CPUM68KState *env)

Maybe add a comment in front of the function that this is for 68020 -
68040, so that it is clear that it is not used for 68000 and 68060 ?

>  {
> -    M68kCPU *cpu = M68K_CPU(obj);
> -    CPUM68KState *env = &cpu->env;
> -
>      m68k_set_feature(env, M68K_FEATURE_M68000);

In the long run, we should maybe rename that flag to M68K_FEATURE_M680X0
or M68K_FEATURE_M68K to be able to distinguish between plain 68000 and
generic 680x0 features ... but let's do that in a later patch...

>      m68k_set_feature(env, M68K_FEATURE_USP);
>      m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
> @@ -136,14 +133,31 @@ static void m68020_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
>      m68k_set_feature(env, M68K_FEATURE_MOVEP);
>  }
> -#define m68030_cpu_initfn m68020_cpu_initfn
> +
> +static void m68020_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m680x0_cpu_common(env);
> +    m68k_set_feature(env, M68K_FEATURE_M68020);
> +}
> +
> +static void m68030_cpu_initfn(Object *obj)
> +{
> +    M68kCPU *cpu = M68K_CPU(obj);
> +    CPUM68KState *env = &cpu->env;
> +
> +    m680x0_cpu_common(env);
> +    m68k_set_feature(env, M68K_FEATURE_M68030);
> +}
>  
>  static void m68040_cpu_initfn(Object *obj)
>  {
>      M68kCPU *cpu = M68K_CPU(obj);
>      CPUM68KState *env = &cpu->env;
>  
> -    m68020_cpu_initfn(obj);
> +    m680x0_cpu_common(env);
>      m68k_set_feature(env, M68K_FEATURE_M68040);
>  }
>  
> @@ -166,6 +180,7 @@ static void m68060_cpu_initfn(Object *obj)
>      m68k_set_feature(env, M68K_FEATURE_BKPT);
>      m68k_set_feature(env, M68K_FEATURE_RTD);
>      m68k_set_feature(env, M68K_FEATURE_CHK2);
> +    m68k_set_feature(env, M68K_FEATURE_M68060);
>  }
>  
>  static void m5208_cpu_initfn(Object *obj)
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 20de3c379a..11c71fa962 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -460,6 +460,10 @@ void do_m68k_semihosting(CPUM68KState *env, int
> nr); 
>  enum m68k_features {
>      M68K_FEATURE_M68000,
> +    M68K_FEATURE_M68020,
> +    M68K_FEATURE_M68030,
> +    M68K_FEATURE_M68040,
> +    M68K_FEATURE_M68060,
>      M68K_FEATURE_CF_ISA_A,
>      M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
>      M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+
> or C).  */ @@ -481,7 +485,6 @@ enum m68k_features {
>      M68K_FEATURE_BKPT,
>      M68K_FEATURE_RTD,
>      M68K_FEATURE_CHK2,
> -    M68K_FEATURE_M68040, /* instructions specific to MC68040 */
>      M68K_FEATURE_MOVEP,
>  };
>  
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index ae766a6cb0..4aa13b34ed 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -205,7 +205,15 @@ void HELPER(m68k_movec_to)(CPUM68KState *env,
> uint32_t reg, uint32_t val) return;
>      /* MC680[234]0 */
>      case M68K_CR_CACR:
> -        env->cacr = val;
> +        if (m68k_feature(env, M68K_FEATURE_M68020)) {
> +            env->cacr = val & 0x0000000f;
> +        } else if (m68k_feature(env, M68K_FEATURE_M68030)) {
> +            env->cacr = val & 0x00003f1f;
> +        } else if (m68k_feature(env, M68K_FEATURE_M68040)) {
> +            env->cacr = val & 0x80008000;
> +        } else if (m68k_feature(env, M68K_FEATURE_M68060)) {
> +            env->cacr = val & 0xf8e0e000;
> +        }
>          m68k_switch_sp(env);
>          return;
>      /* MC680[34]0 */

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


