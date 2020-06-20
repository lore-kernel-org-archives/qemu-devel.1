Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D6DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBBD2404C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEo/zJx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBBD2404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmhEV-0004rF-77
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 13:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmhDr-0004QV-1c
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:24:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmhDp-00048d-6M
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:24:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so12618873wrs.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=YIWaEgI6yOQO0vhzNVRXhB2fTmJIybWYiLq0GE0nQEc=;
 b=OEo/zJx5OHbKOQ7XEOGMJaLtrKefM2/i6vgAu/WCeZXbwszjRJgoLL7LWTYA/xGLcU
 Hh7dJKrM/tyazdh3TrKRBgq0ydRhB8wJflazaWvw4zrMdskKngSZr+orvKHBgyvdM7IP
 UdCsjEoctnrfwIglL/8JacdVq5ed4Wl7BpaIkGg2eD1FS1bIRdAQeAPEPjrUN5M7ay35
 mZQLxHzzr/awVwVJb1CmURCp1QkxglsHPDbwcIzB6yjScosDKmGXXfkoo6PqatZEwRSm
 UUR5t8wBgzQZxNpb/ka0SYNfb45/qJf98TStXueT3rWVyannuhptoOdIZkQaxSoJEJqW
 dujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=YIWaEgI6yOQO0vhzNVRXhB2fTmJIybWYiLq0GE0nQEc=;
 b=ElBnzbhsYiIsQTc/15RgtEmpuIDn/A47aL/qMhChDhEHCnk1DgKd2BRZqdH2ccqRS8
 T/LrzE2yWdARWvRVH/xGo7sBLGZmoVlj/htMOpwXbmEeDmeqJV9iwXNxHmEpXZCJAHmF
 0l25aeFInM9kTnDc5wwUBsrW7uRdlaHGWCTs2EguKpPzEfkCJDZdNjoCgt04ERAY3k7p
 Ig+z4zxvKD/8NDmO4kG8Mv9J+YHuBzQ0Qg+xGkMVkxm/lIBullKNktvypahxYDdHhlvz
 Ah2VD/ogA+jjb+rPUUE42dcCRt6Cf7oUzezPm96LUhT2+L/0Iu8rzJ8TKhFB6JtEAAXW
 zR0w==
X-Gm-Message-State: AOAM530Af51BYluszBIRsA714g1c7r1ne/ac19vXM3nuRLG3fxuxGbZQ
 iouMb4e+xJRIbiOzXd2oNhe/8Cg4InGk9c1Ivkw=
X-Google-Smtp-Source: ABdhPJzDZPPRb0cq8zwwQaYwz93WsdJ7s+K2OnzaSguHf12eqij2XwkMHE14SmPZ/KIeNRc9UnCRbDe585YHFteV6TY=
X-Received: by 2002:adf:f885:: with SMTP id u5mr9883986wrp.402.1592673843320; 
 Sat, 20 Jun 2020 10:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Sat, 20 Jun 2020 10:24:02 -0700 (PDT)
In-Reply-To: <20200616073053.2999026-1-jiaxun.yang@flygoat.com>
References: <20200616073053.2999026-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 20 Jun 2020 19:24:02 +0200
Message-ID: <CAHiYmc4t-rFqv6n+nyZFEghYsg9ob_mdEsp989ipE2ngV206oA@mail.gmail.com>
Subject: Re: [PATCH v2] target/mips: Fix PageMask with variable page size
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="000000000000ac9cb405a88746d4"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "chenhc@lemote.com" <chenhc@lemote.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ac9cb405a88746d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Jiaxun =
Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> Our current code assumed the target page size is always 4k
> when handling PageMask and VPN2, however, variable page size
> was just added to mips target and that's nolonger true.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Remove Big Page support from this patch
> ---
>  target/mips/cp0_helper.c | 41 ++++++++++++++++++++++++++++------------


Please do not use harcoded numbers, if possibe.

Yours,
Aleksandar



>  target/mips/cpu.h        |  1 +
>  2 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index bbf12e4a97..f6dc590315 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -872,20 +872,37 @@ void helper_mtc0_memorymapid(CPUMIPSState *env,
> target_ulong arg1)
>      }
>  }
>
> -void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t
> *pagemask)
> +void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
>  {
> -    uint64_t mask =3D arg1 >> (TARGET_PAGE_BITS + 1);
> -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 =3D=3D ~0) ||
> -        (mask =3D=3D 0x0000 || mask =3D=3D 0x0003 || mask =3D=3D 0x000F =
||
> -         mask =3D=3D 0x003F || mask =3D=3D 0x00FF || mask =3D=3D 0x03FF =
||
> -         mask =3D=3D 0x0FFF || mask =3D=3D 0x3FFF || mask =3D=3D 0xFFFF)=
) {
> -        env->CP0_PageMask =3D arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << =
1));
> +    unsigned long mask;
> +    int maskbits;
> +
> +    if (env->insn_flags & ISA_MIPS32R6) {
> +        return;
>      }
> -}
> +    /* Don't care MASKX as we don't support 1KB page */
> +    mask =3D extract32((uint32_t)arg1, CP0PM_MASK, 16);
> +    maskbits =3D find_first_zero_bit(&mask, 32);
>
> -void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> -{
> -    update_pagemask(env, arg1, &env->CP0_PageMask);
> +    /* Ensure no more set bit after first zero */
> +    if (mask >> maskbits) {
> +        goto invalid;
> +    }
> +    /* We don't support VTLB entry smaller than target page */
> +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
> +        goto invalid;
> +    }


12.


> +    env->CP0_PageMask =3D mask << CP0PM_MASK;
> +
> +    return;
> +
> +invalid:
> +    /*
> +     * When invalid, ensure the value is bigger tan or equel to


than or equal


> +     * the minimal but smaller than or equel to the maxium.


equal


> +     */
> +    maskbits =3D MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
> +    env->CP0_PageMask =3D ((1 << (16 + 1)) - 1) << CP0PM_MASK;


16, 12, 16 + 1 ?


>  }
>
>  void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
> @@ -1111,7 +1128,7 @@ void helper_mthc0_saar(CPUMIPSState *env,
> target_ulong arg1)
>  void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
>  {
>      target_ulong old, val, mask;
> -    mask =3D (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
> +    mask =3D ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;


14.


>      if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >=3D 2) {
>          mask |=3D 1 << CP0EnHi_EHINV;
>      }
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 7cf7f5239f..9c8bb23807 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -618,6 +618,7 @@ struct CPUMIPSState {
>   * CP0 Register 5
>   */
>      int32_t CP0_PageMask;
> +#define CP0PM_MASK 13
>      int32_t CP0_PageGrain_rw_bitmask;
>      int32_t CP0_PageGrain;
>  #define CP0PG_RIE 31
> --
> 2.27.0.rc2
>
>

--000000000000ac9cb405a88746d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020.,=
 Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.yang@fly=
goat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Our current code assumed th=
e target page size is always 4k<br>
when handling PageMask and VPN2, however, variable page size<br>
was just added to mips target and that&#39;s nolonger true.<br>
<br>
Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">j=
iaxun.yang@flygoat.com</a>&gt;<br>
---<br>
v2: Remove Big Page support from this patch<br>
---<br>
=C2=A0target/mips/cp0_helper.c | 41 ++++++++++++++++++++++++++++--<wbr>----=
------</blockquote><div><br></div><div>Please do not use harcoded numbers, =
if possibe.</div><div><br></div><div>Yours,</div><div>Aleksandar</div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A02 files changed, 30 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c<br>
index bbf12e4a97..f6dc590315 100644<br>
--- a/target/mips/cp0_helper.c<br>
+++ b/target/mips/cp0_helper.c<br>
@@ -872,20 +872,37 @@ void helper_mtc0_memorymapid(<wbr>CPUMIPSState *env, =
target_ulong arg1)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagema=
sk)<br>
+void helper_mtc0_pagemask(<wbr>CPUMIPSState *env, target_ulong arg1)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint64_t mask =3D arg1 &gt;&gt; (TARGET_PAGE_BITS + 1);<br>
-=C2=A0 =C2=A0 if (!(env-&gt;insn_flags &amp; ISA_MIPS32R6) || (arg1 =3D=3D=
 ~0) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 (mask =3D=3D 0x0000 || mask =3D=3D 0x0003 || m=
ask =3D=3D 0x000F ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D=3D 0x003F || mask =3D=3D 0x00FF=
 || mask =3D=3D 0x03FF ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D=3D 0x0FFF || mask =3D=3D 0x3FFF=
 || mask =3D=3D 0xFFFF)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_PageMask =3D arg1 &amp; (0x1FFFFFF=
F &amp; (TARGET_PAGE_MASK &lt;&lt; 1));<br>
+=C2=A0 =C2=A0 unsigned long mask;<br>
+=C2=A0 =C2=A0 int maskbits;<br>
+<br>
+=C2=A0 =C2=A0 if (env-&gt;insn_flags &amp; ISA_MIPS32R6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
+=C2=A0 =C2=A0 /* Don&#39;t care MASKX as we don&#39;t support 1KB page */<=
br>
+=C2=A0 =C2=A0 mask =3D extract32((uint32_t)arg1, CP0PM_MASK, 16);<br>
+=C2=A0 =C2=A0 maskbits =3D find_first_zero_bit(&amp;mask, 32);<br>
<br>
-void helper_mtc0_pagemask(<wbr>CPUMIPSState *env, target_ulong arg1)<br>
-{<br>
-=C2=A0 =C2=A0 update_pagemask(env, arg1, &amp;env-&gt;CP0_PageMask);<br>
+=C2=A0 =C2=A0 /* Ensure no more set bit after first zero */<br>
+=C2=A0 =C2=A0 if (mask &gt;&gt; maskbits) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto invalid;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* We don&#39;t support VTLB entry smaller than target page =
*/<br>
+=C2=A0 =C2=A0 if ((maskbits + 12) &lt; TARGET_PAGE_BITS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto invalid;<br>
+=C2=A0 =C2=A0 }</blockquote><div><br></div><div>12.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 env-&gt;CP0_PageMask =3D mask &lt;&lt; CP0PM_MASK;<br>
+<br>
+=C2=A0 =C2=A0 return;<br>
+<br>
+invalid:<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* When invalid, ensure the value is bigger tan or eque=
l to</blockquote><div><br></div><div>than or equal</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0* the minimal but smaller than or equel to the maxium.=
</blockquote><div><br></div><div>equal</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 maskbits =3D MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));<=
br>
+=C2=A0 =C2=A0 env-&gt;CP0_PageMask =3D ((1 &lt;&lt; (16 + 1)) - 1) &lt;&lt=
; CP0PM_MASK;</blockquote><div><br></div><div>16, 12, 16 + 1 ?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0void helper_mtc0_pagegrain(<wbr>CPUMIPSState *env, target_ulong arg1)=
<br>
@@ -1111,7 +1128,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulon=
g arg1)<br>
=C2=A0void helper_mtc0_entryhi(<wbr>CPUMIPSState *env, target_ulong arg1)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0target_ulong old, val, mask;<br>
-=C2=A0 =C2=A0 mask =3D (TARGET_PAGE_MASK &lt;&lt; 1) | env-&gt;CP0_EntryHi=
_ASID_mask;<br>
+=C2=A0 =C2=A0 mask =3D ~((1 &lt;&lt; 14) - 1) | env-&gt;CP0_EntryHi_ASID_m=
ask;</blockquote><div><br></div><div>14.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (((env-&gt;CP0_Config4 &gt;&gt; CP0C4_IE) &amp; 0x3)=
 &gt;=3D 2) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask |=3D 1 &lt;&lt; CP0EnHi_EHINV;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/target/mips/cpu.h b/target/mips/cpu.h<br>
index 7cf7f5239f..9c8bb23807 100644<br>
--- a/target/mips/cpu.h<br>
+++ b/target/mips/cpu.h<br>
@@ -618,6 +618,7 @@ struct CPUMIPSState {<br>
=C2=A0 * CP0 Register 5<br>
=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0int32_t CP0_PageMask;<br>
+#define CP0PM_MASK 13<br>
=C2=A0 =C2=A0 =C2=A0int32_t CP0_PageGrain_rw_bitmask;<br>
=C2=A0 =C2=A0 =C2=A0int32_t CP0_PageGrain;<br>
=C2=A0#define CP0PG_RIE 31<br>
-- <br>
2.27.0.rc2<br>
<br>
</blockquote>

--000000000000ac9cb405a88746d4--

