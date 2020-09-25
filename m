Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB4CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932D020936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mZ+j769W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932D020936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjUv-0002kp-GL
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kLjS1-0000WS-Rw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:51:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kLjRy-0005QX-SS
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:51:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id m12so1637705otr.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lP7HkTJ1fEklefPn1oVTVU5gYffPKkekB62yKkupCys=;
 b=mZ+j769W9T5bjN+Yk+j6dge9lwOb/IWei9E51eHrlasv4VIajo7lYFEwP5kQpPEB/z
 6O5tSKsNyl1D3Ri3/6DvkcxjRf85JNBzbgt3ZFOY1nLYzDcmjak3yS1m5qryrKJGyCEm
 VKknP6OwZZoZWImM0RPIU+MO3VWvL0Q5um/dOkccDr2g+pWtFyHGjmSx+GyzzarFj0h6
 sBbWbmmWVwPhY7727vY4v7lbro+DRpel/37fGDz3CiFcOum5bNkhyQSQ5f471Lki1awU
 bK6PdR15HQG4v7wJ1PjWXE7m25ZxaRH+9ca2MVNIsKRTs71MT/IYxu7b7yuD/db7sMHt
 jXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lP7HkTJ1fEklefPn1oVTVU5gYffPKkekB62yKkupCys=;
 b=gL/T0m67Mn/5xg7USt/1CDLx+lhkkre6nVWFmvjnCIXJN8NJ3KLd5882QIDBwyl0/n
 sEGuDNJGzIqINzCNq+lbhR5oA/CzQwJ6yYzA+X++kTtJ3BTYJx6vQbVHmZXyBU/3BlrR
 OUQZS+RhLJ7dDTgU/WWJs8UunZaJ9FTHA6WNk4oQx6llrnDgiYO120U2+ZFfU7jaTOD3
 qGE21T6Tx6C1SCZehShdi8cYMhoiC+gKQYOQBJ8WbjfxjxhTwqAzpsCDi/HBW44dARBa
 bDT3KrBJ6mYMexN943ozPG2S2n1JcETV3PU7bD2gZyYLvuoUfzLfwkpxPCWsCBo1YZgZ
 x6+g==
X-Gm-Message-State: AOAM533pJ0yHh3/2m9AVRfJ6Orbu21Xs3gADTrCIdhst3t/vTOMm5jrH
 VmbbCdLwMY3xuNd4333IgcNmLHtD+v79dKh0LH5EwxwzR4dJqQ==
X-Google-Smtp-Source: ABdhPJzASo7cnCLPwlil7wWyTpNZjKsO0dtE0c0NGZv6z5SYsABDha3rz2u9Uu7jb3oVRny8BWAfXIPRGlJZK7NOoZE=
X-Received: by 2002:a05:6830:454:: with SMTP id
 d20mr2290773otc.139.1601023889261; 
 Fri, 25 Sep 2020 01:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-18-frank.chang@sifive.com>
In-Reply-To: <20200817084955.28793-18-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 25 Sep 2020 16:51:18 +0800
Message-ID: <CAE_xrPj_fb1NER3a68O1dwzM70wvmb+8+NyDo_9z=POCjYTvQw@mail.gmail.com>
Subject: Re: [RFC v4 17/70] target/riscv: rvv-1.0: configure instructions
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000032572405b01f6cd9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000032572405b01f6cd9
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 17, 2020 at 4:50 PM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 12 ++++++++----
>  target/riscv/vector_helper.c            | 14 +++++++++++++-
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c
> b/target/riscv/insn_trans/trans_rvv.inc.c
> index 4b8ae5470c3..4efe323920b 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -98,8 +98,10 @@ static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl
> *a)
>      s2 = tcg_temp_new();
>      dst = tcg_temp_new();
>
> -    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> -    if (a->rs1 == 0) {
> +    if (a->rd == 0 && a->rs1 == 0) {
> +        s1 = tcg_temp_new();
> +        tcg_gen_mov_tl(s1, cpu_vl);
> +    } else if (a->rs1 == 0) {
>          /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
>          s1 = tcg_const_tl(RV_VLEN_MAX);
>      } else {
> @@ -131,8 +133,10 @@ static bool trans_vsetvli(DisasContext *ctx,
> arg_vsetvli *a)
>      s2 = tcg_const_tl(a->zimm);
>      dst = tcg_temp_new();
>
> -    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> -    if (a->rs1 == 0) {
> +    if (a->rd == 0 && a->rs1 == 0) {
> +        s1 = tcg_temp_new();
> +        tcg_gen_mov_tl(s1, cpu_vl);
> +    } else if (a->rs1 == 0) {
>          /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
>          s1 = tcg_const_tl(RV_VLEN_MAX);
>       } else {
>          s1 = tcg_temp_new();
>          gen_get_gpr(s1, a->rs1);
>       }
>       gen_helper_vsetvl(dst, cpu_env, s1, s2);
>       gen_set_gpr(a->rd, dst);
>       gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
>

trans_vsetvli() uses gen_goto_tb() to save the computation in the link to
the next TB.
I know there was a discussion about this back in RVV v0.7.1:
https://patchew.org/QEMU/20200103033347.20909-1-zhiwei_liu@c-sky.com/20200103033347.20909-5-zhiwei_liu@c-sky.com/

However, we had encountered an issue that looked like it was caused by the
linked TB.
The code snippet which cause the issue is:

00000000000104a8 <loop>: 104a8: 0122ffd7 vsetvli t6,t0,e32,m4,tu,mu,d1
104ac: 02036407 vle32.v v8,(t1) 104b0: 028a0a57 vadd.vv v20,v8,v20 104b4:
41f282b3 sub t0,t0,t6 104b8: 002f9893 slli a7,t6,0x2 104bc: 9346 add
t1,t1,a7 104be: fe0295e3 bnez t0,104a8 <loop> 104c2: 012f7057 vsetvli
zero,t5,e32,m4,tu,mu,d1
.....

If $t0 is given with the value, e.g. 68.
<loop> is expected to process 32 elements in each iteration.
That's it, the env->vl after vsetvli at 0x104a8 in each iteration would be:
1st iteration: 32 (remaining elements to be processed: 68 - 32 = 36)
2nd iteration: 32 (remaining elements to be processed: 36 - 32 = 4)
3rd iteration: 4 (remaining elements to be processed: 4 - 4 = 0, will leave
<loop> after 0x104be)

vadd.vv at 0x104b0 is implemented with gvec for acceleration:

if (a->vm && s->vl_eq_vlmax) {
    gvec_fn(s->sew, vreg_ofs(s, a->rd),
            vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
            MAXSZ(s), MAXSZ(s));
} else {
    uint32_t data = 0;

    data = FIELD_DP32(data, VDATA, VM, a->vm);
    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
    tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                       vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
                       cpu_env, 0, s->vlen / 8, data, fn);
}

gvec function is used when a->vm and s->vl_eq_vlmax are both true.
However, s->vl_eq_vlmax, for the above case, is only true in 1st and 2nd
iterations.
In third iteration, env->vl is 4 which is not equal to vlmax = 32.
But as the TB where vadd.vv resides are already linked with vsetvli's TB,
it won't be retranslated and still use the same gvec function in the third
iteration.
The total elemented being proceeded would be: 32 + 32 + 32 = 96, instead of
68.

I'm wondering under such conditions, is it still correct to use
gen_goto_tb() here?
Or we should use lookup_and_goto_ptr() as in trans_vsetvl() to not link the
TBs.

P.S. We also notice that this issue won't happen when debugging with GDB
because
use_goto_tb() in gen_goto_tb() will return false when GDB is connected and
lookup_and_goto_ptr() will be called instead.

Frank Chang


>       ctx->base.is_jmp = DISAS_NORETURN;
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 7b4b1151b97..430b25d16c2 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -31,12 +31,24 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env,
> target_ulong s1,
>  {
>      int vlmax, vl;
>      RISCVCPU *cpu = env_archcpu(env);
> +    uint64_t lmul = FIELD_EX64(s2, VTYPE, VLMUL);
>      uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
>      uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
>      bool vill = FIELD_EX64(s2, VTYPE, VILL);
>      target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
>
> -    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
> +    if (lmul & 4) {
> +        /* Fractional LMUL. */
> +        if (lmul == 4 ||
> +            cpu->cfg.elen >> (8 - lmul) < sew) {
> +            vill = true;
> +        }
> +    }
> +
> +    if ((sew > cpu->cfg.elen)
> +        || vill
> +        || (ediv != 0)
> +        || (reserved != 0)) {
>          /* only set vill bit. */
>          env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
>          env->vl = 0;
> --
> 2.17.1
>
>

--00000000000032572405b01f6cd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Aug 17, 2020 at 4:50 PM &lt;<a hr=
ef=3D"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<=
br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" =
target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
<br>
Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/riscv/insn_trans/trans_rvv.inc.c | 12 ++++++++----<br>
=C2=A0target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 14 +++++++++++++-<br>
=C2=A02 files changed, 21 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_tr=
ans/trans_rvv.inc.c<br>
index 4b8ae5470c3..4efe323920b 100644<br>
--- a/target/riscv/insn_trans/trans_rvv.inc.c<br>
+++ b/target/riscv/insn_trans/trans_rvv.inc.c<br>
@@ -98,8 +98,10 @@ static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *=
a)<br>
=C2=A0 =C2=A0 =C2=A0s2 =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0dst =3D tcg_temp_new();<br>
<br>
-=C2=A0 =C2=A0 /* Using x0 as the rs1 register specifier, encodes an infini=
te AVL */<br>
-=C2=A0 =C2=A0 if (a-&gt;rs1 =3D=3D 0) {<br>
+=C2=A0 =C2=A0 if (a-&gt;rd =3D=3D 0 &amp;&amp; a-&gt;rs1 =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s1 =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(s1, cpu_vl);<br>
+=C2=A0 =C2=A0 } else if (a-&gt;rs1 =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* As the mask is at least one bit, RV_VL=
EN_MAX is &gt;=3D VLMAX */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s1 =3D tcg_const_tl(RV_VLEN_MAX);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -131,8 +133,10 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetv=
li *a)<br>
=C2=A0 =C2=A0 =C2=A0s2 =3D tcg_const_tl(a-&gt;zimm);<br>
=C2=A0 =C2=A0 =C2=A0dst =3D tcg_temp_new();<br>
<br>
-=C2=A0 =C2=A0 /* Using x0 as the rs1 register specifier, encodes an infini=
te AVL */<br>
-=C2=A0 =C2=A0 if (a-&gt;rs1 =3D=3D 0) {<br>
+=C2=A0 =C2=A0 if (a-&gt;rd =3D=3D 0 &amp;&amp; a-&gt;rs1 =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s1 =3D tcg_temp_new();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(s1, cpu_vl);<br>
+=C2=A0 =C2=A0 } else if (a-&gt;rs1 =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* As the mask is at least one bit, RV_VL=
EN_MAX is &gt;=3D VLMAX */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s1 =3D tcg_const_tl(RV_VLEN_MAX);<br>=C2=
=A0 =C2=A0 =C2=A0 } else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s1 =3D tcg_=
temp_new();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_get_gpr(s1, a-&gt;rs1)=
;<br>=C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 gen_helper_vsetvl(dst, =
cpu_env, s1, s2);<br>=C2=A0 =C2=A0 =C2=A0 gen_set_gpr(a-&gt;rd, dst);<br>=
=C2=A0 =C2=A0 =C2=A0 gen_goto_tb(ctx, 0, ctx-&gt;pc_succ_insn);<br></blockq=
uote><div><br></div><div>trans_vsetvli() uses gen_goto_tb() to save the com=
putation in the link to the next TB.</div><div>I know there was a discussio=
n about this back in RVV v0.7.1:</div><div><a href=3D"https://patchew.org/Q=
EMU/20200103033347.20909-1-zhiwei_liu@c-sky.com/20200103033347.20909-5-zhiw=
ei_liu@c-sky.com/">https://patchew.org/QEMU/20200103033347.20909-1-zhiwei_l=
iu@c-sky.com/20200103033347.20909-5-zhiwei_liu@c-sky.com/</a><br></div><div=
><br></div><div>However, we had encountered an issue that looked like it wa=
s caused by the linked TB.</div><div>The code snippet which cause the issue=
 is:</div><div><br></div><div><span style=3D"color:rgb(23,43,77);font-famil=
y:monospace;font-size:12px;white-space:pre;background-color:rgb(244,245,247=
)">00000000000104a8 &lt;loop&gt;:
   104a8:       0122ffd7                vsetvli t6,t0,e32,m4,tu,mu,d1
   104ac:       02036407                vle32.v v8,(t1)
   104b0:       028a0a57                vadd.vv v20,v8,v20
   104b4:       41f282b3                sub     t0,t0,t6
   104b8:       002f9893                slli    a7,t6,0x2
   104bc:       9346                    add     t1,t1,a7
   104be:       fe0295e3                bnez    t0,104a8 &lt;loop&gt;
   104c2:       012f7057                vsetvli zero,t5,e32,m4,tu,mu,d1</sp=
an><br></div><div><span style=3D"color:rgb(23,43,77);font-family:monospace;=
font-size:12px;white-space:pre;background-color:rgb(244,245,247)">.....</sp=
an></div><div><br></div><div>If $t0 is given with the value, e.g. 68.</div>=
<div>&lt;loop&gt; is expected to process 32 elements in each iteration.</di=
v><div>That&#39;s it, the env-&gt;vl after vsetvli at 0x104a8 in each itera=
tion would be:</div><div>1st iteration: 32 (remaining elements to be proces=
sed: 68 - 32 =3D 36)</div><div>2nd iteration: 32 (remaining elements to be =
processed: 36 - 32 =3D 4)</div><div>3rd iteration: 4=C2=A0(remaining elemen=
ts to be processed: 4 - 4 =3D 0, will leave &lt;loop&gt; after 0x104be)</di=
v><div><br></div><div>vadd.vv at 0x104b0 is implemented with gvec for accel=
eration:</div><div><br></div><div>if (a-&gt;vm &amp;&amp; s-&gt;vl_eq_vlmax=
) {<br>=C2=A0 =C2=A0 gvec_fn(s-&gt;sew, vreg_ofs(s, a-&gt;rd),<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vreg_ofs(s, a-&gt;rs2), vreg_ofs(s, a-&g=
t;rs1),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAXSZ(s), MAXSZ(s));<b=
r>} else {<br>=C2=A0 =C2=A0 uint32_t data =3D 0;<br><br>=C2=A0 =C2=A0 data =
=3D FIELD_DP32(data, VDATA, VM, a-&gt;vm);<br>=C2=A0 =C2=A0 data =3D FIELD_=
DP32(data, VDATA, LMUL, s-&gt;lmul);<br>=C2=A0 =C2=A0 tcg_gen_gvec_4_ptr(vr=
eg_ofs(s, a-&gt;rd), vreg_ofs(s, 0),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vreg_ofs(s, a-&gt;rs1), vre=
g_ofs(s, a-&gt;rs2),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_env, 0, s-&gt;vlen / 8, data, fn);<br=
>}<br></div><div><br></div><div>gvec function is used when a-&gt;vm and s-&=
gt;vl_eq_vlmax are both true.</div><div>However, s-&gt;vl_eq_vlmax, for the=
 above case, is only true in 1st and 2nd iterations.</div><div>In third ite=
ration, env-&gt;vl is 4 which is not equal to vlmax =3D 32.</div><div>But a=
s the TB where vadd.vv resides are already linked with vsetvli&#39;s TB,<br=
></div><div>it won&#39;t be retranslated and still use the same gvec functi=
on in the third iteration.</div><div>The total elemented being proceeded wo=
uld be: 32=C2=A0+ 32=C2=A0+ 32 =3D 96, instead of 68.</div><div><br></div><=
div>I&#39;m wondering under such conditions, is it still correct to use gen=
_goto_tb() here?</div><div>Or we should use lookup_and_goto_ptr() as in tra=
ns_vsetvl() to not link the TBs.</div><div><br></div><div>P.S. We also noti=
ce that this issue won&#39;t happen when debugging with GDB because</div><d=
iv>use_goto_tb() in=C2=A0gen_goto_tb() will return false when GDB is connec=
ted and</div><div>lookup_and_goto_ptr() will be called instead.<br></div><d=
iv><br></div><div>Frank Chang</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">=C2=A0 =C2=A0 =C2=A0 ctx-&gt;base.is_jmp =3D DIS=
AS_NORETURN;<br>
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c<br=
>
index 7b4b1151b97..430b25d16c2 100644<br>
--- a/target/riscv/vector_helper.c<br>
+++ b/target/riscv/vector_helper.c<br>
@@ -31,12 +31,24 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_=
ulong s1,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int vlmax, vl;<br>
=C2=A0 =C2=A0 =C2=A0RISCVCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 uint64_t lmul =3D FIELD_EX64(s2, VTYPE, VLMUL);<br>
=C2=A0 =C2=A0 =C2=A0uint16_t sew =3D 8 &lt;&lt; FIELD_EX64(s2, VTYPE, VSEW)=
;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t ediv =3D FIELD_EX64(s2, VTYPE, VEDIV);<br>
=C2=A0 =C2=A0 =C2=A0bool vill =3D FIELD_EX64(s2, VTYPE, VILL);<br>
=C2=A0 =C2=A0 =C2=A0target_ulong reserved =3D FIELD_EX64(s2, VTYPE, RESERVE=
D);<br>
<br>
-=C2=A0 =C2=A0 if ((sew &gt; cpu-&gt;cfg.elen) || vill || (ediv !=3D 0) || =
(reserved !=3D 0)) {<br>
+=C2=A0 =C2=A0 if (lmul &amp; 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fractional LMUL. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lmul =3D=3D 4 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;cfg.elen &gt;&gt; (8 - l=
mul) &lt; sew) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vill =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if ((sew &gt; cpu-&gt;cfg.elen)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || vill<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (ediv !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || (reserved !=3D 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* only set vill bit. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;vtype =3D FIELD_DP64(0, VTYPE, VI=
LL, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;vl =3D 0;<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div></div>

--00000000000032572405b01f6cd9--

