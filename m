Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9E2225E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdiKzjMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9E2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT74o-00039e-D6
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT73I-0002bg-4b; Thu, 15 Oct 2020 13:28:32 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT73F-0006UL-T6; Thu, 15 Oct 2020 13:28:31 -0400
Received: by mail-lf1-x142.google.com with SMTP id j30so4536708lfp.4;
 Thu, 15 Oct 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=azzKx/I1sn4+o2/ylwKwIHPz62amIXDIL1tHdh2NJLQ=;
 b=HdiKzjMVExOoE5irncanagKAomzesTK1phTOddlvF8aKX4j6peeywro938Jtul5GGI
 xV20xc1VIp+4WCbNyL9RYSGzNHIyXJUKbWQ2tzfi7zFDB4FO6DuVWDd7Y21KvZZMDUCL
 A9BqiwigxjFNA1jE521G3ywkEiOLDUOpELlJpzJdamiUiqbwPfE3VVE1Qrar9Cjp0+JN
 5Fx76ghYd1/q0LrsNqdgNKr/Kson8ssZg/zwR63QjtAX5yTKxKqNBw54PhGTfsTDh9sz
 BREkgE8YPz8uVX4kfed9oP0Wt2p1O9bBE+ZcHXC4zf/O/Sw0L41+DYslRSclpxNzu4Xd
 TeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=azzKx/I1sn4+o2/ylwKwIHPz62amIXDIL1tHdh2NJLQ=;
 b=kLFOSszuk9K9MKVR040Hi9OGAGdybx7LQ5n10rLHEV/rSGaN3+5zU9A62tCKY0Q/yg
 jje2zi3O89HdW0vlzJ9DEDyq4Z03gDZLoQUxs4fj600MRoqA3Omy5T7jP4tmOpxRMghM
 GPi+bYbEjny1ap2bFZM//J/foVCHImbW21GhD6O1aUZSTq44EV0uP3uWMon8aX4kPyDG
 2SJnlOBp24yPDnp7qJgCA3k4rQWfqibfqmKb1zziIgKVDWC2s5IzFT+054XVGfcCWIIR
 A+GiXIno3UtQJfRbkCfuXjrChXZR+VBPh7QHddvoZEVgr7jYWmh5GsvMY7bIby4Jlyzk
 HS5A==
X-Gm-Message-State: AOAM5305KmACt12WaxVBqgrMSyaIslW/s4GpugfkqDZ/8t0VA+jUmG0v
 ohPezUekn5kb3bJhIlkDeYzTFyjEpA1w+O9eJqM=
X-Google-Smtp-Source: ABdhPJz6k1x5DxXLQYpongZpeT9S3mJCYjdu5Bk5UhKaZENDiul9SNSy+synTtBqweex2u6GczYoyJfExyGhYMN3qhw=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr1354908lfl.219.1602782906998; 
 Thu, 15 Oct 2020 10:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-2-space.monkey.delivers@gmail.com>
 <d39e0c59-3b04-6401-aaac-8e202fb5036a@linaro.org>
In-Reply-To: <d39e0c59-3b04-6401-aaac-8e202fb5036a@linaro.org>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Thu, 15 Oct 2020 20:28:15 +0300
Message-ID: <CAFukJ-BwbtRyCYFW3+v4f8xmri3+Yk5ayhgZYen-6fj1xjmD9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] [RISCV_PM] Support CSRs required for RISC-V PM
 extension except for ones in hypervisor mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d2e60b05b1b8f966"
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

--000000000000d2e60b05b1b8f966
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard, again thanks for the review!

> This is a bit clumsy.  I suggest
Sure, will fix.

> If you try to read this on current hardware, without J, then you get an
exception not zero.
If I get the spec right, the idea is to read 0 from PM CSRs even if this
extension is not present.

>I would have expected this check would actually go into the csr predicate
function.
If I understand your proposal correctly, in this case I'd have to introduce
3 new functions for S/M/U PM CSRs as a predicate. I'm okay with that if you
suggest so

>Surely you don't need MMTE_MASK here because you used it when writing.
>That said, don't you also need to mask vs the current priv level?
I suppose that applying these masks helps to prepare the correct value for
the given priv level. So if I understand correctly if you're in *M-mode*
and try to read *UMTE*, you'll get only *U.Enable* and *U.Current*, while
if you'd try to read *SMTE*, you'll also get *XS* bits, *S.Enable* and
*S.Current*.

> it's a security bug for lower priv code to read anything related to a
higher priv.
Could you please elaborate a bit more here? I don't see how this scenario
is valid: in *U-mode *you're supposed to be able to read only *U* *register=
s,
while *M*/*S *mode could allow *U-mode *to write to its *U** registers.
As for *S-mode*, I believe it's allowed to write to any *U** registers and
it's available to write to *S** registers if *S.Current* is set.

> Do not crash qemu because the guest is doing silly things
Sure, you're right. Will fix.

>Raise an exception if you like, and perhaps qemu_log_mask with
LOG_GUEST_ERROR
I think raising exception here might be too much, but logging the error is
a great idea, thanks!

Thanks!

=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 19:48, Richard Hen=
derson <richard.henderson@linaro.org
>:

> On 10/15/20 8:21 AM, Alexey Baturo wrote:
> > +/* Functions to access Pointer Masking feature registers
> > + * We have to check if current priv lvl could modify
> > + * csr in given mode
> > + */
> > +static int check_pm_current_disabled(CPURISCVState *env, int csrno)
> > +{
> > +    /* m-mode is always allowed to modify registers, so allow */
> > +    if (env->priv =3D=3D PRV_M) {
> > +        return 0;
> > +    }
> > +    int csr_priv =3D get_field(csrno, 0xC00);
> > +    /* If priv lvls differ that means we're accessing csr from higher
> priv lvl, so allow */
> > +    if (env->priv !=3D csr_priv) {
> > +        return 0;
> > +    }
> > +    int cur_bit_pos =3D (env->priv =3D=3D PRV_U) ? U_PM_CURRENT :
> > +                      (env->priv =3D=3D PRV_S) ? S_PM_CURRENT : -1;
> > +    assert(cur_bit_pos !=3D -1);
>
> This is a bit clumsy.  I suggest
>
>     int cur_bit_pos;
>     switch (env->priv) {
>     case PRV_M:
>         return 0;
>     case PRV_S:
>         cur_bit_pos =3D S_PM_CURRENT;
>         break;
>     case PRV_U:
>         cur_bit_pos =3D U_PM_CURRENT;
>         break;
>     default:
>         g_assert_not_reached();
>     }
>
> > +static int read_mmte(CPURISCVState *env, int csrno, target_ulong *val)
> > +{
> > +#if !defined(CONFIG_USER_ONLY)
> > +    if (!riscv_has_ext(env, RVJ)) {
> > +        *val =3D 0;
> > +        return 0;
> > +    }
> > +#endif
>
> This ifdef is wrong.  CONFIG_USER_ONLY doesn't have anything to do with
> what
> features the cpu supports.  Nor can it be correct.  If you try to read
> this on
> current hardware, without J, then you get an exception not zero.
>
> I would have expected this check would actually go into the csr predicate
> function.
>
> > +    *val =3D env->mmte & MMTE_MASK;
>
> Surely you don't need MMTE_MASK here because you used it when writing.
>
> That said, don't you also need to mask vs the current priv level?  There'=
s
> language in your doc that says "XS bits are available in..." and "PM bits
> are
> available in...".
>
> I'll also note that it says "by default only higher priv code can set the
> value
> for PM bits", while surely it's a security bug for lower priv code to rea=
d
> anything related to a higher priv.
>
>
> > +    target_ulong wpri_val =3D val & SMTE_MASK;
> > +    assert(val =3D=3D wpri_val);
>
> Incorrect assert.  This value is under guest control.  Do not crash qemu
> because the guest is doing silly things.  Raise an exception if you like,
> and
> perhaps qemu_log_mask with LOG_GUEST_ERROR.
>
> > +    if (check_pm_current_disabled(env, csrno))
> > +        return 0;
>
> Missing braces.
>
>
> r~
>

--000000000000d2e60b05b1b8f966
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Richard, again thanks for the review!<div><br></div><div>&=
gt; This is a bit clumsy.=C2=A0 I suggest</div><div>Sure, will fix.</div><d=
iv><br></div><div>&gt; If you try to read this on current hardware, without=
 J, then you get an exception not zero.</div><div>If I get the spec right, =
the idea is to read 0 from PM CSRs even if this extension is not present.</=
div><div><br></div><div>&gt;I would have expected this check would actually=
 go into the csr predicate function.</div><div>If I understand your=C2=A0pr=
oposal correctly, in this case I&#39;d have to introduce 3 new functions fo=
r S/M/U PM CSRs as a predicate. I&#39;m okay with that if you suggest so</d=
iv><div><br></div><div>&gt;Surely you don&#39;t need MMTE_MASK here because=
 you used it when writing.</div><div>&gt;That said, don&#39;t you also need=
 to mask vs the current priv level?<br></div><div>I suppose that applying t=
hese masks helps to prepare the correct value for the given priv level. So =
if I understand correctly if you&#39;re in <b>M-mode</b> and try to read <b=
>UMTE</b>, you&#39;ll get only <b>U.Enable</b> and <b>U.Current</b>, while =
if you&#39;d try to read <b>SMTE</b>, you&#39;ll also get <b>XS</b> bits, <=
b>S.Enable</b> and <b>S.Current</b>.</div><div><br></div><div>&gt; it&#39;s=
 a security bug for lower priv code to read anything related to a higher pr=
iv.</div><div>Could you please elaborate a bit more here? I don&#39;t see h=
ow this scenario is valid: in <b>U-mode </b>you&#39;re supposed to be able =
to read only <b>U* </b>registers, while <b>M</b>/<b>S </b>mode could allow =
<b>U-mode </b>to write to its <b>U*</b> registers.</div><div>As for <b>S-mo=
de</b>, I believe it&#39;s allowed to write to any <b>U*</b> registers and =
it&#39;s available to write to <b>S*</b> registers if <b>S.Current</b> is s=
et.</div><div><br></div><div>&gt; Do not crash qemu because the guest is do=
ing silly things</div><div>Sure, you&#39;re right. Will fix.</div><div><br>=
</div><div>&gt;Raise an exception if you like, and perhaps qemu_log_mask wi=
th LOG_GUEST_ERROR</div><div>I think raising exception here might be too mu=
ch, but logging the error is a great idea, thanks!</div><div><br></div><div=
>Thanks!</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">=D1=87=D1=82, 15 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 19=
:48, Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">=
richard.henderson@linaro.org</a>&gt;:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 10/15/20 8:21 AM, Alexey Baturo wrote:<br>
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

--000000000000d2e60b05b1b8f966--

