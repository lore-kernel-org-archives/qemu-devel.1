Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8B1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA6322248
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc4IOQMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA6322248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5KU-0007M6-Et
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT56b-0001XT-FX; Thu, 15 Oct 2020 11:23:49 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT56Z-0006C7-DH; Thu, 15 Oct 2020 11:23:49 -0400
Received: by mail-lf1-x141.google.com with SMTP id z2so4095392lfr.1;
 Thu, 15 Oct 2020 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MjmRxsYsZV+CxF0doRzJsUlupGPZ2roXnKdXoCeHHeg=;
 b=oc4IOQMJrte1/sUAJ1As7ubZi+js8C7Bi47Z/Gl5xbkc1uzPCdApybheG0lB2y5a+u
 NVl7xnHfb17B8/r9cb9o2uVFq4eXCMVcAdhhVV45lJP3KB/l77sTz8Y3nyKOP7nCZAsf
 jYnDY8EFCw6Z7kD36Qn11+4qow23p67cS9XvBBDl6C0Gm0SlGe/poe/LV6eHOb2C4kLA
 gJ2/EkGy7x9/zuvDgRyuwXK7o3QZgn8dG+uBRZm+rJdOiO6j3+GOcUn4KI0vM8bhbqQz
 rsftxVH7NKn5mZ+EDXVvg6sbSxwg0ezJRBde2ZboDjdGYN/qU5/qhxPnTYxR5QcBMm4V
 mqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MjmRxsYsZV+CxF0doRzJsUlupGPZ2roXnKdXoCeHHeg=;
 b=Nq7ZBwXorjSsoS9++pIy3pn2VlINU0Elbhio2b167Dsu1WKmIZGBXyyqvg40ITqlvR
 SltlgtfsPFzWh8PrWAhQKAc2dIWN7r5MyufgjUPlH5onj6QyjF65bBDwnZCKUnlK/Nt/
 w46pNjExiBg6/cwax5MR4dd4gOgYt+omnd7KjDClAqe3hukPriI4D8LZhVo0dCNhWr2D
 uQVEoe3/caUs+p52o7MrWbOlqXwu4zzAuk7af7PM+qMWzGeJksX8b+NLYtX3Y+BMyEUE
 L0Q9/46owj5jewjcPEOv3rW+rQl8e85SW8zCTOlzt2+Aw+H3MAmTQEHLvy8tG+ZnKMqg
 xY0g==
X-Gm-Message-State: AOAM530JRwOjt/U7VFwP1l6aneKc4heHxYfahVkr4bWZWy0nJYQ+22qj
 HYFwyfFg8/sVZArwacDmAYlLUO9RducS2Y+HxcU=
X-Google-Smtp-Source: ABdhPJyJZ74qFrQZ0thg3RH9k706UAOebBr2AqwsME/PSUC51dQCabeKKo3b3ZeQAh+3wdYwj2DSVFpj7hplbF1dN/E=
X-Received: by 2002:a19:cc8f:: with SMTP id c137mr1278001lfg.476.1602775425237; 
 Thu, 15 Oct 2020 08:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
 <20201014170159.26932-5-space.monkey.delivers@gmail.com>
 <b13721d7-241a-3d81-fa8d-5d7cc0e780b7@linaro.org>
 <CAFukJ-DM1WJ1H6_FvSbgC8TpHmxjZFCMhSOopnfCF5mey9JaCQ@mail.gmail.com>
In-Reply-To: <CAFukJ-DM1WJ1H6_FvSbgC8TpHmxjZFCMhSOopnfCF5mey9JaCQ@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Thu, 15 Oct 2020 18:23:33 +0300
Message-ID: <CAFukJ-B4FRFO0RrNz=JWcT4-uQvLGjYNZmm3rz8Z+kUk=hhvFg@mail.gmail.com>
Subject: Re: [PATCH 4/5] [RISCV_PM] Add address masking functions required for
 RISC-V Pointer Masking extension
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e046e205b1b73b74"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "space.monkey.delivers@gmail.com" <space.monkey.delivers@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Anatoly Parshintsev <kupokupokupopo@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e046e205b1b73b74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've sent new v2 patches where, I hope, I managed to address all the
comments and suggestions that were provided.
Thanks!

=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 23:10, Alexey Batu=
ro <baturo.alexey@gmail.com>:

> > I suggest adding a stub version of this function to patch 5, and then
> swap patch 4 and patch 5.
> Thanks, will do.
>
> >This bakes in values from ENV without adding any way to verify that thos=
e
> values are still current.
> If I correctly get your idea, you're talking about the situation, when
> DisasContext was initialized with some values, which at some point got
> changed, so this could lead to incorrect address masking. I tried to hand=
le
> this situation by dropping the translation cache in case different values
> are written in any of the PM CSRs, which I assumed would lead to refillin=
g
> the DIsasContext structure.
> This is obviously not the best way to do it, since it may lead to
> performance degradation in some cases, so let me process your suggestion
> and try to implement it.
>
> Thanks!
>
> =D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 22:19, Richard H=
enderson <
> richard.henderson@linaro.org>:
>
>> On 10/14/20 10:01 AM, Alexey Baturo wrote:
>> > +static TCGv_i64 apply_pointer_masking(DisasContext *s, TCGv_i64 addr)
>> > +{
>> > +    gen_pm_adjust_address(s, addr, addr);
>> > +    return addr;
>> > +}
>>
>> This function is unused in this patch, which means the series as a whole
>> is
>> non-bisectable.
>>
>> Rather than merge the two, I suggest adding a stub version of this
>> function to
>> patch 5, and then swap patch 4 and patch 5.  So you will add uses of
>> apply_pointer_masking without actually implementing it yet.  Which shoul=
d
>> be fine.
>>
>> > @@ -800,8 +836,36 @@ static void riscv_tr_init_disas_context
>> >      } else {
>> >          ctx->virt_enabled =3D false;
>> >      }
>> > +    if (riscv_has_ext(env, RVJ)) {
>> > +        switch (env->priv) {
>> > +        case PRV_U:
>> > +            ctx->pm_enabled =3D get_field(env->mmte, UMTE_U_PM_ENABLE=
);
>> > +            ctx->pm_mask =3D env->upmmask;
>> > +            ctx->pm_base =3D env->upmbase;
>> > +            break;
>> > +        case PRV_S:
>> > +            ctx->pm_enabled =3D get_field(env->mmte, SMTE_S_PM_ENABLE=
);
>> > +            ctx->pm_mask =3D env->spmmask;
>> > +            ctx->pm_base =3D env->spmbase;
>> > +            break;
>> > +        case PRV_M:
>> > +            ctx->pm_enabled =3D get_field(env->mmte, MMTE_M_PM_ENABLE=
);
>> > +            ctx->pm_mask =3D env->mpmmask;
>>
>> You can't read env like this.
>>
>> This bakes in values from ENV without adding any way to verify that thos=
e
>> values are still current.
>>
>> The one thing that you must bake into the generated code is the state of
>> PM_ENABLE.  Anything else would penalize normal risc-v emulation.
>>
>> You do that in cpu_get_tb_cpu_state().  Allocate one bit to hold
>> the current state of the flag.  E.g.
>>
>> FIELD(TB_FLAGS, PM_ENABLED, 9, 1)
>>
>> then fill it in from the correct mmte bit for priv (which itself is
>> encoded by
>> cpu_mmu_index()).
>>
>> Except for special cases, the mask and base variables cannot be placed
>> into
>> TB_FLAGS.  For now, I think it's best to ignore the special cases and
>> implement
>> them all as tcg globals.  Which means that we do *not* bake in a
>> particular
>> value, but instead read the value from env at runtime.
>>
>> So, in riscv_translate_init, you create new globals for each of the mask
>> and
>> base.  In riscv_tr_init_disas_context you examine priv (via mmu_index) a=
nd
>> assign one pair of the globals to DisasContext, so that you don't have t=
o
>> keep
>> looking them up.
>>
>> Then you have
>>
>> static void gen_pm_adjust_address(DisasContext *s,
>>                                   TCGv_i64 dst,
>>                                   TCGv_i64 src)
>> {
>>     if (s->pm_enabled =3D=3D 0) {
>>         /* Load unmodified address */
>>         tcg_gen_mov_i64(dst, src);
>>     } else {
>>         tcg_gen_andc_i64(dst, src, s->pm_mask);
>>         tcg_gen_or_i64(dst, dst, s->pm_base);
>>     }
>> }
>>
>>
>> r~
>>
>

--000000000000e046e205b1b73b74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi folks,<div><br></div><div>I&#39;ve=C2=A0sent new v2 pat=
ches where, I hope, I managed to address all the comments and suggestions t=
hat were provided.</div><div>Thanks!</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=
=82. 2020 =D0=B3. =D0=B2 23:10, Alexey Baturo &lt;<a href=3D"mailto:baturo.=
alexey@gmail.com">baturo.alexey@gmail.com</a>&gt;:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">&gt; I suggest adding a=
 stub version of this function to patch 5, and then swap patch 4 and patch =
5.<div>Thanks, will do.</div><div><br></div><div>&gt;This bakes in values f=
rom ENV without adding any way to verify that those values are still curren=
t.</div><div>If I correctly get your idea, you&#39;re talking about the sit=
uation, when DisasContext was initialized with some values, which at some p=
oint got changed, so this could lead to incorrect address masking. I tried =
to handle this situation by dropping the translation cache in case differen=
t values are written in any of the PM CSRs, which I assumed would lead to r=
efilling the DIsasContext structure.</div><div>This is obviously not the be=
st way to do it, since it may lead to performance degradation in some cases=
, so let me process your suggestion and try to implement it.</div><div><br>=
</div><div>Thanks!</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">=D1=81=D1=80, 14 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =
=D0=B2 22:19, Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lin=
aro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 10/14/20 10:01 AM, Alex=
ey Baturo wrote:<br>
&gt; +static TCGv_i64 apply_pointer_masking(DisasContext *s, TCGv_i64 addr)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 gen_pm_adjust_address(s, addr, addr);<br>
&gt; +=C2=A0 =C2=A0 return addr;<br>
&gt; +}<br>
<br>
This function is unused in this patch, which means the series as a whole is=
<br>
non-bisectable.<br>
<br>
Rather than merge the two, I suggest adding a stub version of this function=
 to<br>
patch 5, and then swap patch 4 and patch 5.=C2=A0 So you will add uses of<b=
r>
apply_pointer_masking without actually implementing it yet.=C2=A0 Which sho=
uld be fine.<br>
<br>
&gt; @@ -800,8 +836,36 @@ static void riscv_tr_init_disas_context<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;virt_enabled =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (riscv_has_ext(env, RVJ)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (env-&gt;priv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PRV_U:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_enabled =3D get_=
field(env-&gt;mmte, UMTE_U_PM_ENABLE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_mask =3D env-&gt=
;upmmask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_base =3D env-&gt=
;upmbase;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PRV_S:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_enabled =3D get_=
field(env-&gt;mmte, SMTE_S_PM_ENABLE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_mask =3D env-&gt=
;spmmask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_base =3D env-&gt=
;spmbase;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PRV_M:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_enabled =3D get_=
field(env-&gt;mmte, MMTE_M_PM_ENABLE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;pm_mask =3D env-&gt=
;mpmmask;<br>
<br>
You can&#39;t read env like this.<br>
<br>
This bakes in values from ENV without adding any way to verify that those<b=
r>
values are still current.<br>
<br>
The one thing that you must bake into the generated code is the state of<br=
>
PM_ENABLE.=C2=A0 Anything else would penalize normal risc-v emulation.<br>
<br>
You do that in cpu_get_tb_cpu_state().=C2=A0 Allocate one bit to hold<br>
the current state of the flag.=C2=A0 E.g.<br>
<br>
FIELD(TB_FLAGS, PM_ENABLED, 9, 1)<br>
<br>
then fill it in from the correct mmte bit for priv (which itself is encoded=
 by<br>
cpu_mmu_index()).<br>
<br>
Except for special cases, the mask and base variables cannot be placed into=
<br>
TB_FLAGS.=C2=A0 For now, I think it&#39;s best to ignore the special cases =
and implement<br>
them all as tcg globals.=C2=A0 Which means that we do *not* bake in a parti=
cular<br>
value, but instead read the value from env at runtime.<br>
<br>
So, in riscv_translate_init, you create new globals for each of the mask an=
d<br>
base.=C2=A0 In riscv_tr_init_disas_context you examine priv (via mmu_index)=
 and<br>
assign one pair of the globals to DisasContext, so that you don&#39;t have =
to keep<br>
looking them up.<br>
<br>
Then you have<br>
<br>
static void gen_pm_adjust_address(DisasContext *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i64 dst,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_i64 src)<br>
{<br>
=C2=A0 =C2=A0 if (s-&gt;pm_enabled =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Load unmodified address */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_i64(dst, src);<br>
=C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_andc_i64(dst, src, s-&gt;pm_mask);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_or_i64(dst, dst, s-&gt;pm_base);<br>
=C2=A0 =C2=A0 }<br>
}<br>
<br>
<br>
r~<br>
</blockquote></div>
</blockquote></div>

--000000000000e046e205b1b73b74--

