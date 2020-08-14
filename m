Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4097C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB49820768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YSFuylZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB49820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Pn2-0000wZ-W2
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 22:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k6PmI-0008Uw-Hu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:49:10 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k6PmF-0006k2-Cv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:49:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id c4so6477436otf.12
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uFQKdubY/ms3j4228z9fO7enTa4ep01JZX/g8u5ZeNA=;
 b=YSFuylZ6C7o0d3dLKw8j4H+sqZ5R6j63MZfK9dBerkX0yv/8Ev0lSn4PDjaTkRWaJ4
 shfmOzpJHwy4u8jfhYeRH6KebUSkvLFoouvhsLoqzbj6/J72hOdlYcWXcHEAfYoC6G7F
 29nghGaUrg6dtQyE33uc+ofbcaeHJYi+SHUc3bEUdjbSqU7UDnQWPZeb2bOn2EXeHCwk
 k4w91v3ak/ojLyp65NBsDPUEcBl9G/ek1hvKQv2Dq2SNlW2qS1GMMg+rDqkfDeUQnFDm
 8ezZ7YXCylsPQL7H3zWuXGZE1VZd7YxdSgXWyaqF38RfMHDVaKIrfDgS/p6+t0AGSxyE
 Cixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uFQKdubY/ms3j4228z9fO7enTa4ep01JZX/g8u5ZeNA=;
 b=bssJf7ozSXPhhnrJK1TR3R8ZaJBMjYlHGeM4kOfjLX/g4lOU8oQlMDEX6Pzg5zRk6v
 OVncZIcZHnGQiTrYzNkZAIGxMAn1t2CySXRCtB6XNJ6Ls9Kwade7uGE8hUswVJ+IhQQp
 CFVdQ5jx6Yy01DiDgtAWkVfH763uYKLv24zXevaWo//LSlrrnpx2emRBl2LFDvVRqNK6
 JEFRcU4/piALa/hxa8TjIl02wKYoc0VfYy81IhHKn1VIQlqctK20hpFj+H72xSsYgR4A
 9Kfh93TYFYpJZOGZOEV5TpxGPQ0ymmz3Ztp7GbNV/RB020tvRMxg9eFx1OpXNWX6/sNI
 0PUg==
X-Gm-Message-State: AOAM531waLna+zIbdJAJk39S45D2sLUN8O74S8UHEjYn4CKA7PWpX39p
 /Q9tpOV7W2CqS+iZ/JbqPzmcA6oiLM1RhNl3USNL1Q==
X-Google-Smtp-Source: ABdhPJwt5WlWNkpU9HT+sZ0yQsG+RzlDv6BusUoiHzfRn9gXIgvpy6f1hB0UBNtFA0+1XjeDx8an9M6YmD2+nXwFyqw=
X-Received: by 2002:a9d:630c:: with SMTP id q12mr483005otk.175.1597373345597; 
 Thu, 13 Aug 2020 19:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-27-frank.chang@sifive.com>
 <90f01984-54a4-2a56-c52f-d1f4332b39d4@linaro.org>
In-Reply-To: <90f01984-54a4-2a56-c52f-d1f4332b39d4@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 14 Aug 2020 10:48:54 +0800
Message-ID: <CAE_xrPiJRRV3FYtfve6LMOF6LNEYGfhmi9CiabxqUBEew9igLg@mail.gmail.com>
Subject: Re: [RFC v3 26/71] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d6a1d705accd76b9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d6a1d705accd76b9
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 7, 2020 at 8:04 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> > +static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz, bool
> is_ldst)
> >  {
> > -    return simd_maxsz(desc) << vext_lmul(desc);
> > +    /*
> > +     * As simd_desc support at most 256 bytes, the max vlen is 256 bits.
> > +     * so vlen in bytes (vlenb) is encoded as maxsz.
> > +     */
> > +    uint32_t vlenb = simd_maxsz(desc);
> > +
> > +    if (is_ldst) {
> > +        /*
> > +         * Vector load/store instructions have the EEW encoded
> > +         * directly in the instructions. The maximum vector size is
> > +         * calculated with EMUL rather than LMUL.
> > +         */
> > +        uint32_t eew = ctzl(esz);
> > +        uint32_t sew = vext_sew(desc);
> > +        uint32_t lmul = vext_lmul(desc);
> > +        int32_t emul = eew - sew + lmul;
> > +        uint32_t emul_r = emul < 0 ? 0 : emul;
> > +        return 1 << (ctzl(vlenb) + emul_r - ctzl(esz));
>
> As I said before, the is_ldst instructions should put the EEW and EMUL
> values
> into the SEW and LMUL desc fields, so that this does not need to be

special-cased at all.
>

I add a vext_get_emul() helper function in trans_rvv.inc.c:

> static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)
> {
>     int8_t lmul = sextract32(s->lmul, 0, 3);
>     int8_t emul = ctzl(eew) - (s->sew + 3) + lmul;  // may remove ctzl()
if eew is already log2(eew)
>     return emul < 0 ? 0 : emul;
> }

and pass emul as LMUL field in VDATA so that it can be
reused in vector_helper.c: vext_max_elems():

> uint8_t emul = vext_get_emul(s, eew);
> data = FIELD_DP32(data, VDATA, LMUL, emul);

I also remove the passing SEW field in VDATA codes as I think SEW
might not be required in the updated vext_max_elems() (see below).


>
> > +        /* Return VLMAX */
> > +        return 1 << (ctzl(vlenb) + vext_lmul(desc) - ctzl(esz));
>
> This is overly complicated.
>
> (1) 1 << ctzl(vlenb) == vlenb.
> (2) I'm not sure why esz is not already a log2 number.
>

esz is passed from e.g. GEN_VEXT_LD_STRIDE() macro:

> #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)        \
> void HELPER(NAME)(void *vd, void * v0, target_ulong base,           \
>                   target_ulong stride, CPURISCVState *env,
      \
>                   uint32_t desc)
                         \
> {
                                   \
>     uint32_t vm = vext_vm(desc);
                \
>     vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,     \
>                      sizeof(ETYPE), GETPC(), MMU_DATA_LOAD);            \
> }
>
> GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)

which is calculated by sizeof(ETYPE), so the results would be: 1, 2, 4, 8.
and vext_max_elems() is called by e.g. vext_ldst_stride():

> uint32_t max_elems = vext_max_elems(desc, esz);

I can add another parameter to the macro and pass the hard-coded log2(esz)
number
if it's the better way instead of using ctzl().
Or if there's another approach to get the log2(esz) number more elegantly?


>
> This ought to look more like
>
>   int scale = lmul - esz;
>   return (scale < 0
>           ? vlenb >> -scale
>           : vlenb << scale);
>
>
Thanks for the detailed point outs.
I manage to change the codes to below as your suggestion.

> static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz)
> {
>     /*
>      * As simd_desc support at most 256 bytes, the max vlen is 256 bits.
>      * so vlen in bytes (vlenb) is encoded as maxsz.
>      */
>     uint32_t vlenb = simd_maxsz(desc);
>
>     /* Return VLMAX */
>     int scale = vext_lmul(desc) - ctzl(esz);  // may remove ctzl() if esz
is already log2(esz)
>     return scale < 0 ? vlenb >> -scale : vlenb << scale;
> }


>
> r~
>

Thanks for the review.
Frank Chang

--000000000000d6a1d705accd76b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Aug 7, 2020 at 8:04 AM Richard He=
nderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henders=
on@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 8/6/20 3:46 AM, <a href=3D"mailt=
o:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wrot=
e:<br>
&gt; +static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz, bo=
ol is_ldst)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 return simd_maxsz(desc) &lt;&lt; vext_lmul(desc);<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* As simd_desc support at most 256 bytes, the max=
 vlen is 256 bits.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* so vlen in bytes (vlenb) is encoded as maxsz.<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 uint32_t vlenb =3D simd_maxsz(desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (is_ldst) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Vector load/store instructions ha=
ve the EEW encoded<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* directly in the instructions. The=
 maximum vector size is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* calculated with EMUL rather than =
LMUL.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t eew =3D ctzl(esz);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t sew =3D vext_sew(desc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t lmul =3D vext_lmul(desc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t emul =3D eew - sew + lmul;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t emul_r =3D emul &lt; 0 ? 0 : emu=
l;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1 &lt;&lt; (ctzl(vlenb) + emul_r -=
 ctzl(esz));<br>
<br>
As I said before, the is_ldst instructions should put the EEW and EMUL valu=
es<br>
into the SEW and LMUL desc fields, so that this does not need to be=C2=A0</=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
special-cased at all.<br></blockquote><div><br></div><div><div>I add a=C2=
=A0vext_get_emul() helper function in trans_rvv.inc.c:</div><div><br></div>=
<div>&gt; static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)<br>&gt=
; {<br>&gt; =C2=A0 =C2=A0 int8_t lmul =3D sextract32(s-&gt;lmul, 0, 3);<br>=
&gt; =C2=A0 =C2=A0 int8_t emul =3D ctzl(eew) - (s-&gt;sew + 3) + lmul;=C2=
=A0 // may remove ctzl() if eew is already log2(eew)<br>&gt; =C2=A0 =C2=A0 =
return emul &lt; 0 ? 0 : emul;<br>&gt; }<br></div><div><br></div><div>and p=
ass emul as LMUL field in VDATA  so that it can be</div><div>reused in vect=
or_helper.c:=C2=A0vext_max_elems():</div></div><div><br></div><div>&gt; uin=
t8_t emul =3D vext_get_emul(s, eew);</div>&gt; data =3D FIELD_DP32(data, VD=
ATA, LMUL, emul);</div><div class=3D"gmail_quote"><br></div><div class=3D"g=
mail_quote">I also remove the passing SEW field in VDATA codes as I think S=
EW</div><div class=3D"gmail_quote">might not be required in the updated=C2=
=A0vext_max_elems() (see below).</div><div class=3D"gmail_quote"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Return VLMAX */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1 &lt;&lt; (ctzl(vlenb) + vext_lmu=
l(desc) - ctzl(esz));<br>
<br>
This is overly complicated.<br>
<br>
(1) 1 &lt;&lt; ctzl(vlenb) =3D=3D vlenb.<br>
(2) I&#39;m not sure why esz is not already a log2 number.<br></blockquote>=
<div><br></div><div>esz is passed from e.g.=C2=A0GEN_VEXT_LD_STRIDE() macro=
:</div><div><br></div><div>&gt; #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOA=
D_FN)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; void HELPER(NAME)(void *vd, void=
 * v0, target_ulong base,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulon=
g stride, CPURISCVState *env,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t desc)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>&gt; {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>&gt; =C2=A0 =C2=A0 uint32_t vm =3D vext_vm(desc);=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>&gt; =C2=A0 =C2=A0 vext_=
ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN,=C2=A0 =C2=A0 =C2=
=A0\<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sizeof(ETYPE), GETPC(), MMU_DATA_LOAD); =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>&gt; }<br></div><div>&gt;</div><div>&gt;=C2=A0GEN_=
VEXT_LD_STRIDE(vlse8_v, =C2=A0int8_t, =C2=A0lde_b)</div><div><br></div><div=
>which is calculated by sizeof(ETYPE), so the results would be: 1, 2, 4, 8.=
</div><div>and vext_max_elems() is called by e.g. vext_ldst_stride():</div>=
<div><br></div><div>&gt; uint32_t max_elems =3D vext_max_elems(desc, esz);<=
br></div><div><br></div><div></div><div>I can add another parameter to the =
macro and pass the hard-coded log2(esz) number</div><div>if it&#39;s the be=
tter way instead of using=C2=A0ctzl().</div><div>Or if there&#39;s another =
approach to get the log2(esz) number more elegantly?</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
This ought to look more like<br>
<br>
=C2=A0 int scale =3D lmul - esz;<br>
=C2=A0 return (scale &lt; 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? vlenb &gt;&gt; -scale<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : vlenb &lt;&lt; scale);<br>
<br></blockquote><div>=C2=A0</div><div><div>Thanks for the detailed point o=
uts.</div><div>I manage to change the codes to below as your suggestion.</d=
iv><div><br></div>&gt; static inline uint32_t vext_max_elems(uint32_t desc,=
 uint32_t esz)<br>&gt; {<br>&gt; =C2=A0 =C2=A0 /*<br>&gt; =C2=A0 =C2=A0 =C2=
=A0* As simd_desc support at most 256 bytes, the max vlen is 256 bits.<br>&=
gt; =C2=A0 =C2=A0 =C2=A0* so vlen in bytes (vlenb) is encoded as maxsz.<br>=
&gt; =C2=A0 =C2=A0 =C2=A0*/<br>&gt; =C2=A0 =C2=A0 uint32_t vlenb =3D simd_m=
axsz(desc);<br>&gt; <br>&gt; =C2=A0 =C2=A0 /* Return VLMAX */<br>&gt; =C2=
=A0 =C2=A0 int scale =3D vext_lmul(desc) - ctzl(esz);=C2=A0 // may remove c=
tzl() if esz is already log2(esz)<br>&gt; =C2=A0 =C2=A0 return scale &lt; 0=
 ? vlenb &gt;&gt; -scale : vlenb &lt;&lt; scale;<br>&gt; }<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br></blockquote><div><br></div><div>Thanks for the review.</div>Frank Ch=
ang</div></div>

--000000000000d6a1d705accd76b9--

