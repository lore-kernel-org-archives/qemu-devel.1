Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A9DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F61206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFs2wYcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F61206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Hy1-0006A9-T4
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k6Hwu-0005LX-Gn
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:27:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k6Hwn-0007vs-Lo
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 14:27:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so5874617wmi.5
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=NTo5s8/bQNYwOvsdljRPNYiVuCiAITHLTNRNXq2djb4=;
 b=XFs2wYcnilKdgTXBpdnFxGPm3QsLPHoZBPKBiQETSfK293CunIzuRAuJ9uC1Ymd4A3
 orsjifRvI5D87CLnBNFIdOnhxdToz/LAP++/GPSwNl25Z1IEq4XlAMu4pxfjaMfHTOdn
 duiUOq7G90vO6Cj6JLexqQc8BcIxA8GiEoz9UaxXLCELR8ypuK/dNQ0t2kpNLL7ePCWm
 KJyQaAKTQmJxs84gjRREDv73CjHX3bKZ41JILYIH3ybDCHq7aOyk+YO63u28JQkL+XOU
 9RaX8nNRNsycfM0OP7NJCSPMfg/i5BWAFPYXh0ll1b/mPsclZXO2L8mcebNp1rh8YG+X
 GLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=NTo5s8/bQNYwOvsdljRPNYiVuCiAITHLTNRNXq2djb4=;
 b=BJxmN4railmW0Bfu+d50V1K3sNHEUbm91dUXGWDAJLQHNkyUR/XxLDVz0Iha0C/b9R
 G4VHHQrFJXFMFYCwSAUN5U4S8f7wSXY32dp/ESoO6rBHi7jf+yMoV6VbvvbUFn4Vrt8Q
 jGVm+lR03Dkz+SF7W23hMLnotUVWv2iQ641MD/Dy5PPofCTww0ixaBvFp9NAE/5k+XPP
 MRcGl6Ke4bYO/yS5Y51HgapyCOi1LJu7WEDI+Fejbfm+YaSPnI2lru0mY6ZHpI3Zxbzp
 XjblmQ8rXzNZF7UqXqZfa9xQ6s96TKHlE36MVyg7K6IvrvV27SvOWSsTdGENBqQBRo5l
 cCcQ==
X-Gm-Message-State: AOAM533jsweNuam8+B0HTM9cUo2FgtJotmaC/ucDr9ukGU30XPvgRBsW
 VOSLkJq9qmTtSdK25CwRNhmJnotdpquUz//J8IA=
X-Google-Smtp-Source: ABdhPJxGGYY3KdLwUyDlvUMySAbTRbN6jioc6Cm2DDwux5fTLoVNvU/iNx5gqX4MnH6Kc1PD5fLg/PINPo35hmdpBxk=
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr5936842wmf.168.1597343246674; 
 Thu, 13 Aug 2020 11:27:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1bca:0:0:0:0:0 with HTTP; Thu, 13 Aug 2020 11:27:26
 -0700 (PDT)
In-Reply-To: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
References: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 13 Aug 2020 20:27:26 +0200
Message-ID: <CAHiYmc45WM45Ug2jam0NGuFqGSMV6JpV5ZR5C=oji_RuZQBYiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/mips: Coding style update to fix checkpatch
 errors
To: Kaige Li <likaige@loongson.cn>
Content-Type: multipart/alternative; boundary="000000000000cd70dc05acc67449"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd70dc05acc67449
Content-Type: text/plain; charset="UTF-8"

On Thursday, August 13, 2020, Kaige Li <likaige@loongson.cn> wrote:

> This will help ensure that style guidelines are being maintained during
> subsequent changes.
>
> Signed-off-by: Kaige Li <likaige@loongson.cn>
> ---


Agreed.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  target/mips/translate_init.inc.c | 61 ++++++++++++++++++++----------
> ----------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/target/mips/translate_init.inc.c
> b/target/mips/translate_init.inc.c
> index 637cacc..0740819 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -53,8 +53,7 @@
>
>  /***********************************************************
> ******************/
>  /* MIPS CPU definitions */
> -const mips_def_t mips_defs[] =
> -{
> +const mips_def_t mips_defs[] = {
>      {
>          .name = "4Kc",
>          .CP0_PRid = 0x00018000,
> @@ -766,8 +765,8 @@ const mips_def_t mips_defs[] =
>          .name = "Loongson-2E",
>          .CP0_PRid = 0x6302,
>          /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.
> */
> -        .CP0_Config0 = (0x1<<17) | (0x1<<16) | (0x1<<11) | (0x1<<8) |
> -                       (0x1<<5) | (0x1<<4) | (0x1<<1),
> +        .CP0_Config0 = (0x1 << 17) | (0x1 << 16) | (0x1 << 11) | (0x1 <<
> 8) |
> +                       (0x1 << 5) | (0x1 << 4) | (0x1 << 1),
>          /* Note: Config1 is only used internally,
>             Loongson-2E has only Config0.  */
>          .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
> @@ -786,8 +785,8 @@ const mips_def_t mips_defs[] =
>          .name = "Loongson-2F",
>          .CP0_PRid = 0x6303,
>          /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.
> */
> -        .CP0_Config0 = (0x1<<17) | (0x1<<16) | (0x1<<11) | (0x1<<8) |
> -                       (0x1<<5) | (0x1<<4) | (0x1<<1),
> +        .CP0_Config0 = (0x1 << 17) | (0x1 << 16) | (0x1 << 11) | (0x1 <<
> 8) |
> +                       (0x1 << 5) | (0x1 << 4) | (0x1 << 1),
>          /* Note: Config1 is only used internally,
>             Loongson-2F has only Config0.  */
>          .CP0_Config1 = (1 << CP0C1_FP) | (47 << CP0C1_MMU),
> @@ -932,19 +931,19 @@ void mips_cpu_list(void)
>  }
>
>  #ifndef CONFIG_USER_ONLY
> -static void no_mmu_init (CPUMIPSState *env, const mips_def_t *def)
> +static void no_mmu_init(CPUMIPSState *env, const mips_def_t *def)
>  {
>      env->tlb->nb_tlb = 1;
>      env->tlb->map_address = &no_mmu_map_address;
>  }
>
> -static void fixed_mmu_init (CPUMIPSState *env, const mips_def_t *def)
> +static void fixed_mmu_init(CPUMIPSState *env, const mips_def_t *def)
>  {
>      env->tlb->nb_tlb = 1;
>      env->tlb->map_address = &fixed_mmu_map_address;
>  }
>
> -static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
> +static void r4k_mmu_init(CPUMIPSState *env, const mips_def_t *def)
>  {
>      env->tlb->nb_tlb = 1 + ((def->CP0_Config1 >> CP0C1_MMU) & 63);
>      env->tlb->map_address = &r4k_map_address;
> @@ -956,40 +955,41 @@ static void r4k_mmu_init (CPUMIPSState *env, const
> mips_def_t *def)
>      env->tlb->helper_tlbinvf = r4k_helper_tlbinvf;
>  }
>
> -static void mmu_init (CPUMIPSState *env, const mips_def_t *def)
> +static void mmu_init(CPUMIPSState *env, const mips_def_t *def)
>  {
>      env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
>
>      switch (def->mmu_type) {
> -        case MMU_TYPE_NONE:
> -            no_mmu_init(env, def);
> -            break;
> -        case MMU_TYPE_R4000:
> -            r4k_mmu_init(env, def);
> -            break;
> -        case MMU_TYPE_FMT:
> -            fixed_mmu_init(env, def);
> -            break;
> -        case MMU_TYPE_R3000:
> -        case MMU_TYPE_R6000:
> -        case MMU_TYPE_R8000:
> -        default:
> -            cpu_abort(env_cpu(env), "MMU type not supported\n");
> +    case MMU_TYPE_NONE:
> +        no_mmu_init(env, def);
> +        break;
> +    case MMU_TYPE_R4000:
> +        r4k_mmu_init(env, def);
> +        break;
> +    case MMU_TYPE_FMT:
> +        fixed_mmu_init(env, def);
> +        break;
> +    case MMU_TYPE_R3000:
> +    case MMU_TYPE_R6000:
> +    case MMU_TYPE_R8000:
> +    default:
> +        cpu_abort(env_cpu(env), "MMU type not supported\n");
>      }
>  }
>  #endif /* CONFIG_USER_ONLY */
>
> -static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
> +static void fpu_init(CPUMIPSState *env, const mips_def_t *def)
>  {
>      int i;
>
> -    for (i = 0; i < MIPS_FPU_MAX; i++)
> +    for (i = 0; i < MIPS_FPU_MAX; i++) {
>          env->fpus[i].fcr0 = def->CP1_fcr0;
> +    }
>
>      memcpy(&env->active_fpu, &env->fpus[0], sizeof(env->active_fpu));
>  }
>
> -static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
> +static void mvp_init(CPUMIPSState *env, const mips_def_t *def)
>  {
>      env->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
>
> @@ -999,9 +999,10 @@ static void mvp_init (CPUMIPSState *env, const
> mips_def_t *def)
>         implemented, 5 TCs implemented. */
>      env->mvp->CP0_MVPConf0 = (1U << CP0MVPC0_M) | (1 << CP0MVPC0_TLBS) |
>                               (0 << CP0MVPC0_GS) | (1 << CP0MVPC0_PCP) |
> -// TODO: actually do 2 VPEs.
> -//                             (1 << CP0MVPC0_TCA) | (0x1 <<
> CP0MVPC0_PVPE) |
> -//                             (0x04 << CP0MVPC0_PTC);
> +/* TODO: actually do 2 VPEs.
> + *                            (1 << CP0MVPC0_TCA) | (0x1 <<
> CP0MVPC0_PVPE) |
> + *                            (0x04 << CP0MVPC0_PTC);
> + */
>                               (1 << CP0MVPC0_TCA) | (0x0 << CP0MVPC0_PVPE)
> |
>                               (0x00 << CP0MVPC0_PTC);
>  #if !defined(CONFIG_USER_ONLY)
> --
> 2.1.0
>
>

--000000000000cd70dc05acc67449
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, August 13, 2020, Kaige Li &lt;<a href=3D"mailto:likaig=
e@loongson.cn">likaige@loongson.cn</a>&gt; wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">This will help ensure that style guidelines are being maintained d=
uring<br>
subsequent changes.<br>
<br>
Signed-off-by: Kaige Li &lt;<a href=3D"mailto:likaige@loongson.cn">likaige@=
loongson.cn</a>&gt;<br>
---</blockquote><div><br></div><div>Agreed.</div><div><br></div><div><span =
style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"=
>Reviewed-by: Aleksandar Markovic &lt;</span><a href=3D"mailto:aleksandar.q=
emu.devel@gmail.com" style=3D"font-size:14px;line-height:22.1200008392334px=
">aleksandar.qemu.devel@gmail.<wbr>com</a><span style=3D"color:rgb(34,34,34=
);font-size:14px;line-height:22.1200008392334px">&gt;</span><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
=C2=A0target/mips/translate_init.<wbr>inc.c | 61 ++++++++++++++++++++------=
----<wbr>----------<br>
=C2=A01 file changed, 31 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/target/mips/translate_init.<wbr>inc.c b/target/mips/translate_=
init.<wbr>inc.c<br>
index 637cacc..0740819 100644<br>
--- a/target/mips/translate_init.<wbr>inc.c<br>
+++ b/target/mips/translate_init.<wbr>inc.c<br>
@@ -53,8 +53,7 @@<br>
<br>
=C2=A0/*****************************<wbr>******************************<wbr=
>******************/<br>
=C2=A0/* MIPS CPU definitions */<br>
-const mips_def_t mips_defs[] =3D<br>
-{<br>
+const mips_def_t mips_defs[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;4Kc&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_PRid =3D 0x00018000,<br>
@@ -766,8 +765,8 @@ const mips_def_t mips_defs[] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;Loongson-2E&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_PRid =3D 0x6302,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 64KB I-cache and d-cache. 4 way with 3=
2 bit cache line size.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .CP0_Config0 =3D (0x1&lt;&lt;17) | (0x1&lt;&lt=
;16) | (0x1&lt;&lt;11) | (0x1&lt;&lt;8) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(0x1&lt;&lt;5) | (0x1&lt;&lt;4) | (0x1&lt;&lt;1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .CP0_Config0 =3D (0x1 &lt;&lt; 17) | (0x1 &lt;=
&lt; 16) | (0x1 &lt;&lt; 11) | (0x1 &lt;&lt; 8) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(0x1 &lt;&lt; 5) | (0x1 &lt;&lt; 4) | (0x1 &lt;&lt; 1),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Note: Config1 is only used internally,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Loongson-2E has only Config0.=C2=
=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_Config1 =3D (1 &lt;&lt; CP0C1_FP) | =
(47 &lt;&lt; CP0C1_MMU),<br>
@@ -786,8 +785,8 @@ const mips_def_t mips_defs[] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;Loongson-2F&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_PRid =3D 0x6303,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 64KB I-cache and d-cache. 4 way with 3=
2 bit cache line size.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .CP0_Config0 =3D (0x1&lt;&lt;17) | (0x1&lt;&lt=
;16) | (0x1&lt;&lt;11) | (0x1&lt;&lt;8) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(0x1&lt;&lt;5) | (0x1&lt;&lt;4) | (0x1&lt;&lt;1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .CP0_Config0 =3D (0x1 &lt;&lt; 17) | (0x1 &lt;=
&lt; 16) | (0x1 &lt;&lt; 11) | (0x1 &lt;&lt; 8) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(0x1 &lt;&lt; 5) | (0x1 &lt;&lt; 4) | (0x1 &lt;&lt; 1),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Note: Config1 is only used internally,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Loongson-2F has only Config0.=C2=
=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_Config1 =3D (1 &lt;&lt; CP0C1_FP) | =
(47 &lt;&lt; CP0C1_MMU),<br>
@@ -932,19 +931,19 @@ void mips_cpu_list(void)<br>
=C2=A0}<br>
<br>
=C2=A0#ifndef CONFIG_USER_ONLY<br>
-static void no_mmu_init (CPUMIPSState *env, const mips_def_t *def)<br>
+static void no_mmu_init(CPUMIPSState *env, const mips_def_t *def)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;nb_tlb =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;map_address =3D &amp;no_mmu_map_address=
;<br>
=C2=A0}<br>
<br>
-static void fixed_mmu_init (CPUMIPSState *env, const mips_def_t *def)<br>
+static void fixed_mmu_init(CPUMIPSState *env, const mips_def_t *def)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;nb_tlb =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;map_address =3D &amp;fixed_mmu_map_addr=
ess;<br>
=C2=A0}<br>
<br>
-static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)<br>
+static void r4k_mmu_init(CPUMIPSState *env, const mips_def_t *def)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;nb_tlb =3D 1 + ((def-&gt;CP0_Config1 &g=
t;&gt; CP0C1_MMU) &amp; 63);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;map_address =3D &amp;r4k_map_address;<b=
r>
@@ -956,40 +955,41 @@ static void r4k_mmu_init (CPUMIPSState *env, const mi=
ps_def_t *def)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb-&gt;helper_tlbinvf =3D r4k_helper_tlbinvf;<=
br>
=C2=A0}<br>
<br>
-static void mmu_init (CPUMIPSState *env, const mips_def_t *def)<br>
+static void mmu_init(CPUMIPSState *env, const mips_def_t *def)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;tlb =3D g_malloc0(sizeof(<wbr>CPUMIPSTLBContext=
));<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (def-&gt;mmu_type) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MMU_TYPE_NONE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_mmu_init(env, def);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MMU_TYPE_R4000:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r4k_mmu_init(env, def);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MMU_TYPE_FMT:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fixed_mmu_init(env, def);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MMU_TYPE_R3000:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MMU_TYPE_R6000:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MMU_TYPE_R8000:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(env_cpu(env), &quot;MM=
U type not supported\n&quot;);<br>
+=C2=A0 =C2=A0 case MMU_TYPE_NONE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 no_mmu_init(env, def);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case MMU_TYPE_R4000:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r4k_mmu_init(env, def);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case MMU_TYPE_FMT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fixed_mmu_init(env, def);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case MMU_TYPE_R3000:<br>
+=C2=A0 =C2=A0 case MMU_TYPE_R6000:<br>
+=C2=A0 =C2=A0 case MMU_TYPE_R8000:<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(env_cpu(env), &quot;MMU type not sup=
ported\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_USER_ONLY */<br>
<br>
-static void fpu_init (CPUMIPSState *env, const mips_def_t *def)<br>
+static void fpu_init(CPUMIPSState *env, const mips_def_t *def)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; MIPS_FPU_MAX; i++)<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; MIPS_FPU_MAX; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fpus[i].fcr0 =3D def-&gt;CP1_fcr0=
;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0memcpy(&amp;env-&gt;active_fpu, &amp;env-&gt;fpus[0], s=
izeof(env-&gt;active_fpu));<br>
=C2=A0}<br>
<br>
-static void mvp_init (CPUMIPSState *env, const mips_def_t *def)<br>
+static void mvp_init(CPUMIPSState *env, const mips_def_t *def)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;mvp =3D g_malloc0(sizeof(<wbr>CPUMIPSMVPContext=
));<br>
<br>
@@ -999,9 +999,10 @@ static void mvp_init (CPUMIPSState *env, const mips_de=
f_t *def)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 implemented, 5 TCs implemented. */<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;mvp-&gt;CP0_MVPConf0 =3D (1U &lt;&lt; CP0MVPC0_=
M) | (1 &lt;&lt; CP0MVPC0_TLBS) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0 &lt;&lt; CP0MVPC0_GS) | (1 &lt;&lt; CP0M=
VPC0_PCP) |<br>
-// TODO: actually do 2 VPEs.<br>
-//=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; CP0MVPC0_TCA) | (0x1 &lt;&lt;=
 CP0MVPC0_PVPE) |<br>
-//=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x04 &lt;&lt; CP0MVPC0_PTC);<br>
+/* TODO: actually do 2 VPEs.<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; CP0MVPC0_TCA) | (0x1 &lt;&lt; CP0MV=
PC0_PVPE) |<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x04 &lt;&lt; CP0MVPC0_PTC);<br>
+ */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; CP0MVPC0_TCA) | (0x0 &lt;&lt; C=
P0MVPC0_PVPE) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00 &lt;&lt; CP0MVPC0_PTC);<br>
=C2=A0#if !defined(CONFIG_USER_ONLY)<br>
-- <br>
2.1.0<br>
<br>
</blockquote>

--000000000000cd70dc05acc67449--

