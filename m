Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792DC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A679120797
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0IvNfT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A679120797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7ed-00018w-Ig
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT7cy-0007rF-8I; Thu, 15 Oct 2020 14:05:25 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT7cu-0002FT-DU; Thu, 15 Oct 2020 14:05:23 -0400
Received: by mail-lf1-x142.google.com with SMTP id z2so4679328lfr.1;
 Thu, 15 Oct 2020 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k1nJNbSrnqeOw9hcHEmIKjQZzKhuJHjQoFM2/ZVwZ0Y=;
 b=d0IvNfT9bSh1WIGzBrGz0GqMGiHSjO3bbCmUNQ0uJXMrDTDds3aSiUrrPkIxSMmm6x
 oKYctD/B9UWaaz7XNy4ZVy8x7WNThG0UlrE09JYvqwiMQameVeKg48Mrhqo99cZGsCHc
 t7PnW5efB3MojS763QjGmgMWFY+6D0354yzrE3I+13JRFFADmCOIEQhcrNV6x3NCoDXQ
 DJ5KByzOK4sLsBjeG2dQQYkT+zJLnNeYdZbDiyUY3Cp87mz2kHHxj2zIrDlDUeAgubWn
 Q1CaMjlRnhARkw8GK/HBF3UyEeKDpW9PJWjLlUHVc1XLGXVsej8wXIQIV74fAsSm/cGl
 SARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k1nJNbSrnqeOw9hcHEmIKjQZzKhuJHjQoFM2/ZVwZ0Y=;
 b=Het4IxCBokblbZIOHAvT2e2ZZaA2Kc6H6V3xqtHfuid1M4nvs3Lj70A/nyzks4ztMY
 n7EmI8gNfyGy2/4EFeSZdjvQeSFgGYodpce3mGMChlTYH1XIfVQFb1OgyIF4cNCveHTI
 Q0DLu7KLmuaybWK/b2j48Bfexvcw0dmiS4JLdcOQ+bk+KTn5lb0KZdLFtkytd8Ogs50X
 3xjnKVYtrxuCRnwXEBualsnlGOggJKP/ZohsHARLLUv/cjvxTp3iNmOnG9GUnJ5092U1
 qKMqT8Gm1c7kTeI8+m0MFOGOuXtQnuJp9F1z78dDDdwBH7CuGxgGTiLP15WIuhv2W5Vr
 zMwA==
X-Gm-Message-State: AOAM531LR08p5jQ3+iW1eojXWrWopvSAs/SLyr9h4/ogBaBqul94T5gU
 FYAq5irVec7uwKBENQLJRv3jDZQHMrqzdUU7xIU=
X-Google-Smtp-Source: ABdhPJwcneVjIzN2tqSSfM3BS35aXjbooRN3loHUsmR/pv4n4LIdiIxsXtSiH6Lo4xnH7Zpe8+dV3wPgRD2PgG26OR8=
X-Received: by 2002:a05:6512:3b6:: with SMTP id
 v22mr1389102lfp.536.1602785117471; 
 Thu, 15 Oct 2020 11:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-2-space.monkey.delivers@gmail.com>
 <d39e0c59-3b04-6401-aaac-8e202fb5036a@linaro.org>
 <CAFukJ-BwbtRyCYFW3+v4f8xmri3+Yk5ayhgZYen-6fj1xjmD9g@mail.gmail.com>
In-Reply-To: <CAFukJ-BwbtRyCYFW3+v4f8xmri3+Yk5ayhgZYen-6fj1xjmD9g@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Thu, 15 Oct 2020 21:05:06 +0300
Message-ID: <CAFukJ-AYk6VjC=8h83+Y==XbTwXODP34_JMzndW6_taD2uu4+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] [RISCV_PM] Support CSRs required for RISC-V PM
 extension except for ones in hypervisor mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009409c305b1b97d8d"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x142.google.com
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
 Dave Smith <kupokupokupopo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009409c305b1b97d8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Surely you don't need MMTE_MASK here because you used it when writing.
> That said, don't you also need to mask vs the current priv level?
> while surely it's a security bug for lower priv code to read anything
related to a higher priv
Now I think I get what you've meant:
The spec states that for lower priv level you get WPRI fields that contain
bits for higher priv levels.
Applying those masks while reading CSRs on the one hand solves this
security breach, but on the other - violates the spec. Let me raise this
question at the upcoming J WG meeting.
Meanwhile, do you think applying **MTE *masks while reading CSR values is a
good solution for now?

Thanks again!

=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 20:28, Alexey Batu=
ro <baturo.alexey@gmail.com>:

> Richard, again thanks for the review!
>
> > This is a bit clumsy.  I suggest
> Sure, will fix.
>
> > If you try to read this on current hardware, without J, then you get an
> exception not zero.
> If I get the spec right, the idea is to read 0 from PM CSRs even if this
> extension is not present.
>
> >I would have expected this check would actually go into the csr predicat=
e
> function.
> If I understand your proposal correctly, in this case I'd have to
> introduce 3 new functions for S/M/U PM CSRs as a predicate. I'm okay with
> that if you suggest so
>
> >Surely you don't need MMTE_MASK here because you used it when writing.
> >That said, don't you also need to mask vs the current priv level?
> I suppose that applying these masks helps to prepare the correct value fo=
r
> the given priv level. So if I understand correctly if you're in *M-mode*
> and try to read *UMTE*, you'll get only *U.Enable* and *U.Current*, while
> if you'd try to read *SMTE*, you'll also get *XS* bits, *S.Enable* and
> *S.Current*.
>
> > it's a security bug for lower priv code to read anything related to a
> higher priv.
> Could you please elaborate a bit more here? I don't see how this scenario
> is valid: in *U-mode *you're supposed to be able to read only *U* *regist=
ers,
> while *M*/*S *mode could allow *U-mode *to write to its *U** registers.
> As for *S-mode*, I believe it's allowed to write to any *U** registers
> and it's available to write to *S** registers if *S.Current* is set.
>
> > Do not crash qemu because the guest is doing silly things
> Sure, you're right. Will fix.
>
> >Raise an exception if you like, and perhaps qemu_log_mask with
> LOG_GUEST_ERROR
> I think raising exception here might be too much, but logging the error i=
s
> a great idea, thanks!
>
> Thanks!
>
> =D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 19:48, Richard H=
enderson <
> richard.henderson@linaro.org>:
>
>> On 10/15/20 8:21 AM, Alexey Baturo wrote:
>> > +/* Functions to access Pointer Masking feature registers
>> > + * We have to check if current priv lvl could modify
>> > + * csr in given mode
>> > + */
>> > +static int check_pm_current_disabled(CPURISCVState *env, int csrno)
>> > +{
>> > +    /* m-mode is always allowed to modify registers, so allow */
>> > +    if (env->priv =3D=3D PRV_M) {
>> > +        return 0;
>> > +    }
>> > +    int csr_priv =3D get_field(csrno, 0xC00);
>> > +    /* If priv lvls differ that means we're accessing csr from higher
>> priv lvl, so allow */
>> > +    if (env->priv !=3D csr_priv) {
>> > +        return 0;
>> > +    }
>> > +    int cur_bit_pos =3D (env->priv =3D=3D PRV_U) ? U_PM_CURRENT :
>> > +                      (env->priv =3D=3D PRV_S) ? S_PM_CURRENT : -1;
>> > +    assert(cur_bit_pos !=3D -1);
>>
>> This is a bit clumsy.  I suggest
>>
>>     int cur_bit_pos;
>>     switch (env->priv) {
>>     case PRV_M:
>>         return 0;
>>     case PRV_S:
>>         cur_bit_pos =3D S_PM_CURRENT;
>>         break;
>>     case PRV_U:
>>         cur_bit_pos =3D U_PM_CURRENT;
>>         break;
>>     default:
>>         g_assert_not_reached();
>>     }
>>
>> > +static int read_mmte(CPURISCVState *env, int csrno, target_ulong *val=
)
>> > +{
>> > +#if !defined(CONFIG_USER_ONLY)
>> > +    if (!riscv_has_ext(env, RVJ)) {
>> > +        *val =3D 0;
>> > +        return 0;
>> > +    }
>> > +#endif
>>
>> This ifdef is wrong.  CONFIG_USER_ONLY doesn't have anything to do with
>> what
>> features the cpu supports.  Nor can it be correct.  If you try to read
>> this on
>> current hardware, without J, then you get an exception not zero.
>>
>> I would have expected this check would actually go into the csr predicat=
e
>> function.
>>
>> > +    *val =3D env->mmte & MMTE_MASK;
>>
>> Surely you don't need MMTE_MASK here because you used it when writing.
>>
>> That said, don't you also need to mask vs the current priv level?  There=
's
>> language in your doc that says "XS bits are available in..." and "PM bit=
s
>> are
>> available in...".
>>
>> I'll also note that it says "by default only higher priv code can set th=
e
>> value
>> for PM bits", while surely it's a security bug for lower priv code to re=
ad
>> anything related to a higher priv.
>>
>>
>> > +    target_ulong wpri_val =3D val & SMTE_MASK;
>> > +    assert(val =3D=3D wpri_val);
>>
>> Incorrect assert.  This value is under guest control.  Do not crash qemu
>> because the guest is doing silly things.  Raise an exception if you like=
,
>> and
>> perhaps qemu_log_mask with LOG_GUEST_ERROR.
>>
>> > +    if (check_pm_current_disabled(env, csrno))
>> > +        return 0;
>>
>> Missing braces.
>>
>>
>> r~
>>
>

--0000000000009409c305b1b97d8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;

Surely you don&#39;t need MMTE_MASK here because you used it when writing.<=
div>&gt; That said, don&#39;t you also need to mask vs the current priv lev=
el?</div><div>&gt; while surely it&#39;s a security bug for lower priv code=
 to read anything related to a higher priv</div><div>Now I think I get what=
 you&#39;ve meant:</div><div>The spec states that for lower priv level you =
get WPRI fields that contain bits for higher priv levels.</div><div>Applyin=
g those masks while reading CSRs on the one hand solves this security breac=
h, but on the other - violates the spec. Let me raise this question at the =
upcoming J WG meeting.</div><div>Meanwhile, do you think applying <b>*MTE <=
/b>masks while reading CSR values is a good solution for now?</div><div><br=
></div><div>Thanks again!</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =
=D0=B3. =D0=B2 20:28, Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gma=
il.com">baturo.alexey@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr">Richard, again thanks for the rev=
iew!<div><br></div><div>&gt; This is a bit clumsy.=C2=A0 I suggest</div><di=
v>Sure, will fix.</div><div><br></div><div>&gt; If you try to read this on =
current hardware, without J, then you get an exception not zero.</div><div>=
If I get the spec right, the idea is to read 0 from PM CSRs even if this ex=
tension is not present.</div><div><br></div><div>&gt;I would have expected =
this check would actually go into the csr predicate function.</div><div>If =
I understand your=C2=A0proposal correctly, in this case I&#39;d have to int=
roduce 3 new functions for S/M/U PM CSRs as a predicate. I&#39;m okay with =
that if you suggest so</div><div><br></div><div>&gt;Surely you don&#39;t ne=
ed MMTE_MASK here because you used it when writing.</div><div>&gt;That said=
, don&#39;t you also need to mask vs the current priv level?<br></div><div>=
I suppose that applying these masks helps to prepare the correct value for =
the given priv level. So if I understand correctly if you&#39;re in <b>M-mo=
de</b> and try to read <b>UMTE</b>, you&#39;ll get only <b>U.Enable</b> and=
 <b>U.Current</b>, while if you&#39;d try to read <b>SMTE</b>, you&#39;ll a=
lso get <b>XS</b> bits, <b>S.Enable</b> and <b>S.Current</b>.</div><div><br=
></div><div>&gt; it&#39;s a security bug for lower priv code to read anythi=
ng related to a higher priv.</div><div>Could you please elaborate a bit mor=
e here? I don&#39;t see how this scenario is valid: in <b>U-mode </b>you&#3=
9;re supposed to be able to read only <b>U* </b>registers, while <b>M</b>/<=
b>S </b>mode could allow <b>U-mode </b>to write to its <b>U*</b> registers.=
</div><div>As for <b>S-mode</b>, I believe it&#39;s allowed to write to any=
 <b>U*</b> registers and it&#39;s available to write to <b>S*</b> registers=
 if <b>S.Current</b> is set.</div><div><br></div><div>&gt; Do not crash qem=
u because the guest is doing silly things</div><div>Sure, you&#39;re right.=
 Will fix.</div><div><br></div><div>&gt;Raise an exception if you like, and=
 perhaps qemu_log_mask with LOG_GUEST_ERROR</div><div>I think raising excep=
tion here might be too much, but logging the error is a great idea, thanks!=
</div><div><br></div><div>Thanks!</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82.=
 2020 =D0=B3. =D0=B2 19:48, Richard Henderson &lt;<a href=3D"mailto:richard=
.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&g=
t;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/15/20 =
8:21 AM, Alexey Baturo wrote:<br>
&gt; +/* Functions to access Pointer Masking feature registers <br>
&gt; + * We have to check if current priv lvl could modify<br>
&gt; + * csr in given mode<br>
&gt; + */<br>
&gt; +static int check_pm_current_disabled(CPURISCVState *env, int csrno)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* m-mode is always allowed to modify registers, so all=
ow */<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;priv =3D=3D PRV_M) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 int csr_priv =3D get_field(csrno, 0xC00);<br>
&gt; +=C2=A0 =C2=A0 /* If priv lvls differ that means we&#39;re accessing c=
sr from higher priv lvl, so allow */<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;priv !=3D csr_priv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 int cur_bit_pos =3D (env-&gt;priv =3D=3D PRV_U) ? U_PM_=
CURRENT :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (env-&gt;priv =3D=3D PRV_S) ? S_PM_CURRENT : -1;<br>
&gt; +=C2=A0 =C2=A0 assert(cur_bit_pos !=3D -1);<br>
<br>
This is a bit clumsy.=C2=A0 I suggest<br>
<br>
=C2=A0 =C2=A0 int cur_bit_pos;<br>
=C2=A0 =C2=A0 switch (env-&gt;priv) {<br>
=C2=A0 =C2=A0 case PRV_M:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 case PRV_S:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_bit_pos =3D S_PM_CURRENT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 case PRV_U:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_bit_pos =3D U_PM_CURRENT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
=C2=A0 =C2=A0 }<br>
<br>
&gt; +static int read_mmte(CPURISCVState *env, int csrno, target_ulong *val=
)<br>
&gt; +{<br>
&gt; +#if !defined(CONFIG_USER_ONLY)<br>
&gt; +=C2=A0 =C2=A0 if (!riscv_has_ext(env, RVJ)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
<br>
This ifdef is wrong.=C2=A0 CONFIG_USER_ONLY doesn&#39;t have anything to do=
 with what<br>
features the cpu supports.=C2=A0 Nor can it be correct.=C2=A0 If you try to=
 read this on<br>
current hardware, without J, then you get an exception not zero.<br>
<br>
I would have expected this check would actually go into the csr predicate f=
unction.<br>
<br>
&gt; +=C2=A0 =C2=A0 *val =3D env-&gt;mmte &amp; MMTE_MASK;<br>
<br>
Surely you don&#39;t need MMTE_MASK here because you used it when writing.<=
br>
<br>
That said, don&#39;t you also need to mask vs the current priv level?=C2=A0=
 There&#39;s<br>
language in your doc that says &quot;XS bits are available in...&quot; and =
&quot;PM bits are<br>
available in...&quot;.<br>
<br>
I&#39;ll also note that it says &quot;by default only higher priv code can =
set the value<br>
for PM bits&quot;, while surely it&#39;s a security bug for lower priv code=
 to read<br>
anything related to a higher priv.<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 target_ulong wpri_val =3D val &amp; SMTE_MASK;<br>
&gt; +=C2=A0 =C2=A0 assert(val =3D=3D wpri_val);<br>
<br>
Incorrect assert.=C2=A0 This value is under guest control.=C2=A0 Do not cra=
sh qemu<br>
because the guest is doing silly things.=C2=A0 Raise an exception if you li=
ke, and<br>
perhaps qemu_log_mask with LOG_GUEST_ERROR.<br>
<br>
&gt; +=C2=A0 =C2=A0 if (check_pm_current_disabled(env, csrno))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
Missing braces.<br>
<br>
<br>
r~<br>
</blockquote></div>
</blockquote></div>

--0000000000009409c305b1b97d8d--

