Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36139C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 09:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FE020753
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 09:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YadvlSq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FE020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFa82-0002Yn-Vj
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 05:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFa7S-000293-BM
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 05:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFa7Q-0007qz-Pk
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 05:08:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFa7Q-0007qe-Gz
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 05:08:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id z15so10246235wrl.1
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yzGYzDezlwsPC1rJx1SiBbtWRszYnbud0ejrYCLfrU8=;
 b=YadvlSq4tIuxdn5LU8NvUMDHXAtwK1Y0FaKHgu/qXr6hlcMMjZEP3JYDBl7rzk2zCy
 AmsVlYKpdJsRfStECKmOK0nd3m/GGqqpMTNLpUqtWzFahFCcqi+cCuhWYPUHy9SwDn4x
 bFXwghIaW45eDG3jVkwi2sx07KcBaI3QLGsXJTEfy9fMOXksa+7zdA3QpUVqTuwt85ac
 iiYco4/x8RhK8tr7kpB1W5+yVv/l0iKsISTZ1mnI/0EisKvziT8gitBZBtAB/a4Lx74w
 Ip9Z7UiWSR4CTMuJbWxEzp5+DH4dzAo3d4THnEualtz8k5P6+wROr9JT//sqP7OeVrwZ
 npGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yzGYzDezlwsPC1rJx1SiBbtWRszYnbud0ejrYCLfrU8=;
 b=s0MeAGUPFYBURnd9OlTZDAC7rRc20wQGeljWUhJoTfvFzao1W9zCfWPSr2RCsEsYEP
 JrxpcI6ofc7+QwK6bwQqcKYcZkXRd25gUvo8MSqGd4HyHGz5KFJEX1CbvLaJ68VehRND
 6Gm8ht3hnRlNsRw0i1MMqP6M9V5SNd/VTs0GZbssP2s2YakV1lVgsrGCaZLgbhNlbKHf
 whl/T+q7TUW+b3jkT0+U277N18xL4uluV3jHI0agfkfWVi0ifUwDPzMCcHPmHIquoog1
 QzcVsdhYrzuBe8wKAu+5+hmaBTYQ5uKHWxJYpr9cjRYviS2qg61dNUhqxREhHfMRcTKr
 go1w==
X-Gm-Message-State: ANhLgQ3+bi/25T34P903Vj7y7Jg1fYeHdc+jlfY3YQIWY242HQcoaU6B
 tQa1QDbB/bJN9brZOywWcdzNcsjKVTUsAHHSv4s=
X-Google-Smtp-Source: ADFU+vv5vwCLZ6q+8+npD+270m+I8qi4MoC/kCFbfsbtmim5XgZUadmjjhdSclOSXHJ5MqQ0Yd7t2Khs/sSTmIQUgqI=
X-Received: by 2002:adf:ba47:: with SMTP id t7mr15399720wrg.147.1584781714525; 
 Sat, 21 Mar 2020 02:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200321045621.2139953-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200321045621.2139953-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 21 Mar 2020 10:08:19 +0100
Message-ID: <CAHiYmc4g2TChxsmOO-SYAVAu2pULBv2mMNsYu5Czm=rk2Y-Ahg@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Fix loongson multimedia condition
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="00000000000024116405a159bf4d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000024116405a159bf4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

5:58 AM Sub, 21.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Loongson multimedia condition instructions were previously implemented as
> write 0 to rd due to lack of documentation. So I just confirmed with
Loongson
> about their encoding and implemented them correctly.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Thanks, Jiaxun!

I feel relieved that this "mistery" is about to be solved. This patch
actually deals with a long-standing known bug, and, on that basis, it is
eligible to be integrated into QEMU 5.0 after soft-freeze.

I'll take a closer look at the details and their possible improvements in
next few days. But, again, in general, I salute this patch.

Yours,
Aleksansdar

>  target/mips/translate.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d745bd2803..43be8d27b5 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5529,6 +5529,8 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>  {
>      uint32_t opc, shift_max;
>      TCGv_i64 t0, t1;
> +    TCGCond cond;
> +    TCGLabel *lab;
>
>      opc =3D MASK_LMI(ctx->opcode);
>      switch (opc) {
> @@ -5816,7 +5818,7 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>      case OPC_DADD_CP2:
>          {
>              TCGv_i64 t2 =3D tcg_temp_new_i64();
> -            TCGLabel *lab =3D gen_new_label();
> +            lab =3D gen_new_label();
>
>              tcg_gen_mov_i64(t2, t0);
>              tcg_gen_add_i64(t0, t1, t2);
> @@ -5837,7 +5839,7 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>      case OPC_DSUB_CP2:
>          {
>              TCGv_i64 t2 =3D tcg_temp_new_i64();
> -            TCGLabel *lab =3D gen_new_label();
> +            lab =3D gen_new_label();
>
>              tcg_gen_mov_i64(t2, t0);
>              tcg_gen_sub_i64(t0, t1, t2);
> @@ -5862,14 +5864,39 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>
>      case OPC_SEQU_CP2:
>      case OPC_SEQ_CP2:
> +        cond =3D TCG_COND_EQ;
> +        goto do_cc_cond;
> +        break;
> +
>      case OPC_SLTU_CP2:
> +        cond =3D TCG_COND_LTU;
> +        goto do_cc_cond;
> +        break;
> +
>      case OPC_SLT_CP2:
> +        cond =3D TCG_COND_LT;
> +        goto do_cc_cond;
> +        break;
> +
>      case OPC_SLEU_CP2:
> +        cond =3D TCG_COND_LEU;
> +        goto do_cc_cond;
> +        break;
> +
>      case OPC_SLE_CP2:
> -        /*
> -         * ??? Document is unclear: Set FCC[CC].  Does that mean the
> -         * FD field is the CC field?
> -         */
> +        cond =3D TCG_COND_LE;
> +    do_cc_cond:
> +        {
> +            int cc =3D (ctx->opcode >> 8) & 0x7;
> +            lab =3D gen_new_label();
> +            tcg_gen_ori_i32(fpu_fcr31, fpu_fcr31, 1 << get_fp_bit(cc));
> +            tcg_gen_brcond_i64(cond, t0, t1, lab);
> +            tcg_gen_xori_i32(fpu_fcr31, fpu_fcr31, 1 << get_fp_bit(cc));
> +            gen_set_label(lab);
> +        }
> +        goto no_rd;
> +        break;
> +
>      default:
>          MIPS_INVAL("loongson_cp2");
>          generate_exception_end(ctx, EXCP_RI);
> @@ -5878,6 +5905,7 @@ static void gen_loongson_multimedia(DisasContext
*ctx, int rd, int rs, int rt)
>
>      gen_store_fpr64(ctx, t0, rd);
>
> +no_rd:
>      tcg_temp_free_i64(t0);
>      tcg_temp_free_i64(t1);
>  }
> --
> 2.26.0.rc2
>
>
>

--00000000000024116405a159bf4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">5:58 AM Sub, 21.03.2020. Jiaxun Yang &lt;<a href=3D"mailto:j=
iaxun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Loongson multimedia condition instructions were previously implemented=
 as<br>
&gt; write 0 to rd due to lack of documentation. So I just confirmed with L=
oongson<br>
&gt; about their encoding and implemented them correctly.<br>
&gt;<br>
&gt; Signed-off-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.c=
om">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; ---</p>
<p dir=3D"ltr">Thanks, Jiaxun!</p>
<p dir=3D"ltr">I feel relieved that this &quot;mistery&quot; is about to be=
 solved. This patch actually deals with a long-standing known bug, and, on =
that basis, it is eligible to be integrated into QEMU 5.0 after soft-freeze=
.</p>
<p dir=3D"ltr">I&#39;ll take a closer look at the details and their possibl=
e improvements in next few days. But, again, in general, I salute this patc=
h.</p>
<p dir=3D"ltr">Yours,<br>
Aleksansdar<br></p>
<p dir=3D"ltr">&gt; =C2=A0target/mips/translate.c | 40 ++++++++++++++++++++=
++++++++++++++------<br>
&gt; =C2=A01 file changed, 34 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/mips/translate.c b/target/mips/translate.c<br>
&gt; index d745bd2803..43be8d27b5 100644<br>
&gt; --- a/target/mips/translate.c<br>
&gt; +++ b/target/mips/translate.c<br>
&gt; @@ -5529,6 +5529,8 @@ static void gen_loongson_multimedia(DisasContext=
 *ctx, int rd, int rs, int rt)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0uint32_t opc, shift_max;<br>
&gt; =C2=A0 =C2=A0 =C2=A0TCGv_i64 t0, t1;<br>
&gt; +=C2=A0 =C2=A0 TCGCond cond;<br>
&gt; +=C2=A0 =C2=A0 TCGLabel *lab;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0opc =3D MASK_LMI(ctx-&gt;opcode);<br>
&gt; =C2=A0 =C2=A0 =C2=A0switch (opc) {<br>
&gt; @@ -5816,7 +5818,7 @@ static void gen_loongson_multimedia(DisasContext=
 *ctx, int rd, int rs, int rt)<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_DADD_CP2:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 t2 =3D tcg_te=
mp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGLabel *lab =3D gen_new_l=
abel();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lab =3D gen_new_label();<br=
>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i64(t2, t0=
);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_add_i64(t0, t1=
, t2);<br>
&gt; @@ -5837,7 +5839,7 @@ static void gen_loongson_multimedia(DisasContext=
 *ctx, int rd, int rs, int rt)<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_DSUB_CP2:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i64 t2 =3D tcg_te=
mp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGLabel *lab =3D gen_new_l=
abel();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lab =3D gen_new_label();<br=
>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_i64(t2, t0=
);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_sub_i64(t0, t1=
, t2);<br>
&gt; @@ -5862,14 +5864,39 @@ static void gen_loongson_multimedia(DisasConte=
xt *ctx, int rd, int rs, int rt)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SEQU_CP2:<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SEQ_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_EQ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLTU_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LTU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLT_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLEU_CP2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LEU;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_cc_cond;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0case OPC_SLE_CP2:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ??? Document is unclear: Set FCC[=
CC].=C2=A0 Does that mean the<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* FD field is the CC field?<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_LE;<br>
&gt; +=C2=A0 =C2=A0 do_cc_cond:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cc =3D (ctx-&gt;opcode =
&gt;&gt; 8) &amp; 0x7;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lab =3D gen_new_label();<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_ori_i32(fpu_fcr31, =
fpu_fcr31, 1 &lt;&lt; get_fp_bit(cc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_brcond_i64(cond, t0=
, t1, lab);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_xori_i32(fpu_fcr31,=
 fpu_fcr31, 1 &lt;&lt; get_fp_bit(cc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_set_label(lab);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto no_rd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_INVAL(&quot;loongson_cp2&quot;)=
;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generate_exception_end(ctx, EXCP_RI)=
;<br>
&gt; @@ -5878,6 +5905,7 @@ static void gen_loongson_multimedia(DisasContext=
 *ctx, int rd, int rs, int rt)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0gen_store_fpr64(ctx, t0, rd);<br>
&gt;<br>
&gt; +no_rd:<br>
&gt; =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t1);<br>
&gt; =C2=A0}<br>
&gt; -- <br>
&gt; 2.26.0.rc2<br>
&gt;<br>
&gt;<br>
&gt;<br>
</p>

--00000000000024116405a159bf4d--

