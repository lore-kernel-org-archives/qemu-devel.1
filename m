Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E1C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 21:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA19206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 21:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfbpVM+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA19206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkaY1-0001Z0-GX
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 17:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkaXP-0000zx-87
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 17:51:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkaXN-0005GN-9O
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 17:51:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so12758422wmj.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=TGW/23PRJFxA3LQe/MKOQu/0tTiFMmzfZbMBAQ4ARvI=;
 b=rfbpVM+ZHRCbqyMC4G1Z24EptZuP/3L31Pqm9JE+R1jqxYRtjp0wa9j1ILhP6EtPZu
 Cn4bMkW9WfE2aLXxB0c9x2+KT+crm6qXlM+9DebnSG7sgvqaxa5t6LMN0jf/Ju8zjmyb
 VD1VaonSjuWDxqZ1Qfgx20c9VPcCPFekzSBdEC33nEwoNyYAJ/wsCJjZQ2C0Il7DsO52
 OQ3LsEKSl5cfhrg/s+k/VGrMT5EmvUR2rYouRLBnMB0jAm8w9yQBJk0QfRQA0AjoyLGJ
 7Ife9zMe9YieVn5jAqLVyRETYKzlEz2pR9fU8HP9X0dggwdGzaPuN7eNhsRMNvMtBb//
 +TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=TGW/23PRJFxA3LQe/MKOQu/0tTiFMmzfZbMBAQ4ARvI=;
 b=ETu7K/mK2ZEHlGwU7C22T1RltoORb0OyI859L8jGyNJOyD90DrZ53axRKeh17GrnZJ
 fMMmeh3Th/4R/2nY9C5CJp3c54dYhNH1rRTs8jbg95hrPCr+pFCzA+CeWlKonbLuFoi0
 i+iHClQk0rIZBljXkNFeqVt+hMDFYsx+Jwe6CetQ1Vf58XoZfuwfMZf1lXzxX4Y8JWQA
 CauZfvSSAYT2NdA6lAQ0FefOizBL8CIZOSC3uTnAZ1GVw7qvIHH6P2n7vq18FP4eTgZX
 1150eUyvyNdk84Pz4iDDJNqS3KPaJMSXjD/z1DFu6dXMH9btyZQ5d0a0AY621i/EzF4e
 qgLg==
X-Gm-Message-State: AOAM530Yt8vdC+dt9FFaHmJ5WxvYMjSuRKaABWNCHYE0xVriSp0NUPac
 wATTIo3ImhB0S4CIfO1jsaTWIbLYOP+v7E001EQ=
X-Google-Smtp-Source: ABdhPJzSgTRY3K6jFegukaGLCF7mDAa3V4nD8X6Hv0nz2vFkgVwudZJtaO+ulC9bZ5MWnlkzYeLtHVY2UD0XwK3/Z5o=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr10358373wmg.50.1592171491162; 
 Sun, 14 Jun 2020 14:51:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Sun, 14 Jun 2020 14:51:30 -0700 (PDT)
In-Reply-To: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
References: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 14 Jun 2020 23:51:30 +0200
Message-ID: <CAHiYmc5haGPCxR4Nr-WmL_4PG48F+dqeJLzvVRHjcoBZKykr8Q@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Fix PageMask with variable page size
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="00000000000026fd7805a812504b"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000026fd7805a812504b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0, 14. =D1=98=D1=83=D0=BD 2020., Jiaxun =
Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> Our current code assumed the target page size is always 4k
> when handling PageMask and VPN2, however, variable page size
> was just added to mips target and that's nolonger true.
>
> So we refined this piece of code to handle any target page size.
> Also added Big Page support defined by MIPS64 Release2.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  target/mips/cp0_helper.c | 48 ++++++++++++++++++++++++++++++----------


Hi, Jiaxun.

Thanks for this contribution too.

When you change machine.c the way you did it, you need to bump the version.
Please see git log on machine.c for details.

Also, this patch covers logicaly related, but slightly different and, in
some cases almost independanr things, and should be split to two or more
logical units - in other words, patches.

Thanks,
Akeksandar


>  target/mips/cpu.h        |  3 ++-
>  target/mips/machine.c    |  2 +-
>  3 files changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index bbf12e4a97..7a134085f7 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -872,20 +872,44 @@ void helper_mtc0_memorymapid(CPUMIPSState *env,
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
> +    uint64_t mask;
> +    int maxmaskbits, maskbits;
> +
> +    if (env->insn_flags & ISA_MIPS32R6) {
> +        return;
>      }
> -}
>
> -void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> -{
> -    update_pagemask(env, arg1, &env->CP0_PageMask);
> +    /* Don't care MASKX as we don't support 1KB page */
> +#ifdef TARGET_MIPS64
> +    if (env->CP0_Config3 & CP0C3_BPG) {
> +        maxmaskbits =3D 47;
> +    } else {
> +        maxmaskbits =3D 16;
> +    }
> +#else
> +    maxmaskbits =3D 16;
> +#endif
> +    mask =3D extract64((uint64_t)arg1, CP0PM_MASK, maxmaskbits);
> +
> +    maskbits =3D find_first_zero_bit(&mask, 64);
> +
> +    /* Ensure no more set bit after first zero */
> +    if (mask >> maskbits) {
> +        goto invalid;
> +    }
> +    /* We don't support VTLB entry smaller than target page */
> +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
> +        goto invalid;
> +    }
> +    env->CP0_PageMask =3D mask << CP0PM_MASK;
> +
> +    return;
> +
> +invalid:
> +    maskbits =3D MIN(maxmaskbits, MAX(maskbits, TARGET_PAGE_BITS - 12));
> +    env->CP0_PageMask =3D ((1 << (maskbits + 1)) - 1) << CP0PM_MASK;
>  }
>
>  void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
> @@ -1111,7 +1135,7 @@ void helper_mthc0_saar(CPUMIPSState *env,
> target_ulong arg1)
>  void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
>  {
>      target_ulong old, val, mask;
> -    mask =3D (TARGET_PAGE_MASK << 1) | env->CP0_EntryHi_ASID_mask;
> +    mask =3D ~((1 << 14) - 1) | env->CP0_EntryHi_ASID_mask;
>      if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >=3D 2) {
>          mask |=3D 1 << CP0EnHi_EHINV;
>      }
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 0b3c987bb3..b69806792d 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -617,7 +617,8 @@ struct CPUMIPSState {
>  /*
>   * CP0 Register 5
>   */
> -    int32_t CP0_PageMask;
> +    target_ulong CP0_PageMask;
> +#define CP0PM_MASK 13
>      int32_t CP0_PageGrain_rw_bitmask;
>      int32_t CP0_PageGrain;
>  #define CP0PG_RIE 31
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 5b23e3e912..b30a75d46b 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -252,7 +252,7 @@ const VMStateDescription vmstate_mips_cpu =3D {
>          VMSTATE_UINT64(env.CP0_EntryLo1, MIPSCPU),
>          VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
>          VMSTATE_INT32(env.CP0_MemoryMapID, MIPSCPU),
> -        VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
> +        VMSTATE_UINTTL(env.CP0_PageMask, MIPSCPU),
>          VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
>          VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
>          VMSTATE_UINTTL(env.CP0_SegCtl1, MIPSCPU),
> --
> 2.27.0
>

--00000000000026fd7805a812504b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0, 14. =D1=98=D1=83=D0=BD 2020.,=
 Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.yang@fly=
goat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Our current code assumed th=
e target page size is always 4k<br>
when handling PageMask and VPN2, however, variable page size<br>
was just added to mips target and that&#39;s nolonger true.<br>
<br>
So we refined this piece of code to handle any target page size.<br>
Also added Big Page support defined by MIPS64 Release2.<br>
<br>
Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">j=
iaxun.yang@flygoat.com</a>&gt;<br>
---<br>
=C2=A0target/mips/cp0_helper.c | 48 ++++++++++++++++++++++++++++++<wbr>----=
------</blockquote><div><br></div><div>Hi, Jiaxun.</div><div><br></div><div=
>Thanks for this contribution too.</div><div><br></div><div>When you change=
 machine.c the way you did it, you need to bump the version. Please see git=
 log on machine.c for details.</div><div><br></div><div>Also, this patch co=
vers logicaly related, but slightly different and, in some cases almost ind=
ependanr things, and should be split to two or more logical units - in othe=
r words, patches.</div><div><br></div><div>Thanks,</div><div>Akeksandar</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0target/mips/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0target/mips/machine.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A03 files changed, 39 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c<br>
index bbf12e4a97..7a134085f7 100644<br>
--- a/target/mips/cp0_helper.c<br>
+++ b/target/mips/cp0_helper.c<br>
@@ -872,20 +872,44 @@ void helper_mtc0_memorymapid(<wbr>CPUMIPSState *env, =
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
+=C2=A0 =C2=A0 uint64_t mask;<br>
+=C2=A0 =C2=A0 int maxmaskbits, maskbits;<br>
+<br>
+=C2=A0 =C2=A0 if (env-&gt;insn_flags &amp; ISA_MIPS32R6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
<br>
-void helper_mtc0_pagemask(<wbr>CPUMIPSState *env, target_ulong arg1)<br>
-{<br>
-=C2=A0 =C2=A0 update_pagemask(env, arg1, &amp;env-&gt;CP0_PageMask);<br>
+=C2=A0 =C2=A0 /* Don&#39;t care MASKX as we don&#39;t support 1KB page */<=
br>
+#ifdef TARGET_MIPS64<br>
+=C2=A0 =C2=A0 if (env-&gt;CP0_Config3 &amp; CP0C3_BPG) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 maxmaskbits =3D 47;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 maxmaskbits =3D 16;<br>
+=C2=A0 =C2=A0 }<br>
+#else<br>
+=C2=A0 =C2=A0 maxmaskbits =3D 16;<br>
+#endif<br>
+=C2=A0 =C2=A0 mask =3D extract64((uint64_t)arg1, CP0PM_MASK, maxmaskbits);=
<br>
+<br>
+=C2=A0 =C2=A0 maskbits =3D find_first_zero_bit(&amp;mask, 64);<br>
+<br>
+=C2=A0 =C2=A0 /* Ensure no more set bit after first zero */<br>
+=C2=A0 =C2=A0 if (mask &gt;&gt; maskbits) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto invalid;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* We don&#39;t support VTLB entry smaller than target page =
*/<br>
+=C2=A0 =C2=A0 if ((maskbits + 12) &lt; TARGET_PAGE_BITS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto invalid;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 env-&gt;CP0_PageMask =3D mask &lt;&lt; CP0PM_MASK;<br>
+<br>
+=C2=A0 =C2=A0 return;<br>
+<br>
+invalid:<br>
+=C2=A0 =C2=A0 maskbits =3D MIN(maxmaskbits, MAX(maskbits, TARGET_PAGE_BITS=
 - 12));<br>
+=C2=A0 =C2=A0 env-&gt;CP0_PageMask =3D ((1 &lt;&lt; (maskbits + 1)) - 1) &=
lt;&lt; CP0PM_MASK;<br>
=C2=A0}<br>
<br>
=C2=A0void helper_mtc0_pagegrain(<wbr>CPUMIPSState *env, target_ulong arg1)=
<br>
@@ -1111,7 +1135,7 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulon=
g arg1)<br>
=C2=A0void helper_mtc0_entryhi(<wbr>CPUMIPSState *env, target_ulong arg1)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0target_ulong old, val, mask;<br>
-=C2=A0 =C2=A0 mask =3D (TARGET_PAGE_MASK &lt;&lt; 1) | env-&gt;CP0_EntryHi=
_ASID_mask;<br>
+=C2=A0 =C2=A0 mask =3D ~((1 &lt;&lt; 14) - 1) | env-&gt;CP0_EntryHi_ASID_m=
ask;<br>
=C2=A0 =C2=A0 =C2=A0if (((env-&gt;CP0_Config4 &gt;&gt; CP0C4_IE) &amp; 0x3)=
 &gt;=3D 2) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask |=3D 1 &lt;&lt; CP0EnHi_EHINV;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/target/mips/cpu.h b/target/mips/cpu.h<br>
index 0b3c987bb3..b69806792d 100644<br>
--- a/target/mips/cpu.h<br>
+++ b/target/mips/cpu.h<br>
@@ -617,7 +617,8 @@ struct CPUMIPSState {<br>
=C2=A0/*<br>
=C2=A0 * CP0 Register 5<br>
=C2=A0 */<br>
-=C2=A0 =C2=A0 int32_t CP0_PageMask;<br>
+=C2=A0 =C2=A0 target_ulong CP0_PageMask;<br>
+#define CP0PM_MASK 13<br>
=C2=A0 =C2=A0 =C2=A0int32_t CP0_PageGrain_rw_bitmask;<br>
=C2=A0 =C2=A0 =C2=A0int32_t CP0_PageGrain;<br>
=C2=A0#define CP0PG_RIE 31<br>
diff --git a/target/mips/machine.c b/target/mips/machine.c<br>
index 5b23e3e912..b30a75d46b 100644<br>
--- a/target/mips/machine.c<br>
+++ b/target/mips/machine.c<br>
@@ -252,7 +252,7 @@ const VMStateDescription vmstate_mips_cpu =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT64(env.CP0_<wbr>EntryLo1, MIP=
SCPU),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINTTL(env.CP0_<wbr>Context, MIPS=
CPU),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_INT32(env.CP0_<wbr>MemoryMapID, M=
IPSCPU),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(env.CP0_<wbr>PageMask, MIPSCPU),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINTTL(env.CP0_<wbr>PageMask, MIPSCPU)=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_INT32(env.CP0_<wbr>PageGrain, MIP=
SCPU),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINTTL(env.CP0_<wbr>SegCtl0, MIPS=
CPU),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINTTL(env.CP0_<wbr>SegCtl1, MIPS=
CPU),<br>
-- <br>
2.27.0<br>
</blockquote>

--00000000000026fd7805a812504b--

