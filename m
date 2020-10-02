Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABBC4727F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636EE206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOMUS5RG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636EE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGLb-0000zR-Cx
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kOGKe-0000Wv-PW
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:22:24 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kOGKc-0001c7-Kj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:22:24 -0400
Received: by mail-ej1-x643.google.com with SMTP id q13so749499ejo.9
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hlBkZeS2GeqV6DUNF12EnUVYxQgsppP4s5e404sHF+g=;
 b=LOMUS5RGfj8w8+puQcm3JdVqZj16P/x3ORmxBlmvhBlZ4iL06XZFLs2CSxTFEWDiT5
 T2fuR7TkXyHIGrLxja3hJeaMrRx0izF8XfL9N8rDK4eaFjYQGckkQpExr6AcUtckGIfn
 dNinhF0kPH89gOxlhkAC4FMJjfolszw92Bzd2IqLIcYAhVXIhr4Hm1MtXdhEAagMNjpk
 Qf+qEtxYvjU3Kdl/BG5OJuTidn6EZ56xTzAHYjv/ZYL1xqpmcPnjRmLO4MOUJtFhk/kF
 qrHB974Xsp8nxQnItvmF78Zrha86l841jVPmDRqn3bgk/JqgwWO14LybHe+m0U52tgAq
 FBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hlBkZeS2GeqV6DUNF12EnUVYxQgsppP4s5e404sHF+g=;
 b=CTOVVhsFyZJOfrJA8pGTIco076YDyfyiCucVigyjN6i8IpRU0iAD3CDJQOwZ8YCnzq
 MLftu5UTwIkLxx901O5Bg7fVLjDaQf78GWFFQSQAdDDYqsGT/C6SQlO89qO9Ml0HBRp7
 I7QGI0nS1MUXZceAEC9GLY9lJGc1TAwol7B2XF9GBXVNw9+rzmJdHAazyz9IZKDprsLO
 weaPGksP9vH5rSVP1Vtn/Az/syvJ+40mAd1J98qfQFnInVlkCyW8y0k0czuuwwqSqxK8
 aE+0KjNKUKEjumhUjS6BbTVI8kpmciytTnAqvgfs/rxR9pkJOx3jSfaiZ4c+zZ12NhcR
 qsTQ==
X-Gm-Message-State: AOAM5339H/akLO+5PusKBFigrroXlIZCTzIeOcnlFCud0fwJp3MMBQnG
 drmNcaI3oeL9sfO6FXJrPb4Li/xYEBnqAC8mQ/8=
X-Google-Smtp-Source: ABdhPJx0J22IfN2CJ5vssAk8HMZ22RFbk+9uXtgewkrM9strk9LaHhiE8fOVB3K8zgE1R2QwtU1w6El9tP2tGp9DB5Q=
X-Received: by 2002:a17:906:7fcc:: with SMTP id
 r12mr1130614ejs.360.1601626938863; 
 Fri, 02 Oct 2020 01:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082033.8716-1-kele.hwang@gmail.com>
 <c716ca94-5600-5521-f0ef-cd0e7809f52a@amsat.org>
 <CA+FBGNepcP98zG2jzgivGHsgPDvMEmV5kNWVkvri6UFsOSyQTw@mail.gmail.com>
 <CAHiYmc6n-Z2f4utqxT73TciRRmg3nSfrHhX4o4YayF59WAK1Gw@mail.gmail.com>
 <CA+FBGNe6XOD=-F0MLF2zfu72D3e8amTRk-=YUAumf3mtMJg9Ng@mail.gmail.com>
In-Reply-To: <CA+FBGNe6XOD=-F0MLF2zfu72D3e8amTRk-=YUAumf3mtMJg9Ng@mail.gmail.com>
From: Kele Huang <kele.hwang@gmail.com>
Date: Fri, 2 Oct 2020 16:22:07 +0800
Message-ID: <CA+FBGNfA2NWhYf9VNGGjYyzsF_J53NAnz5eiGSp+oHQD5-4cug@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c0f4b405b0abd474"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=kele.hwang@gmail.com; helo=mail-ej1-x643.google.com
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
 Xu Zou <iwatchnima@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c0f4b405b0abd474
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> +        case 015: /* SDXC1 */

I just found a comment mistake about SUXC1,  and I have rectified it and
resent a new patch.

On Tue, 29 Sep 2020 at 09:59, Kele Huang <kele.hwang@gmail.com> wrote:

> Thank you so much!
>
>
> On Mon, 28 Sep 2020 at 16:14, Aleksandar Markovic <
> aleksandar.qemu.devel@gmail.com> wrote:
>
>>
>>
>> On Sunday, September 27, 2020, Kele Huang <kele.hwang@gmail.com> wrote:
>>
>>> Sorry about that, I only got maintainers by './scripts/get_maintainer.p=
l
>>> -f accel/tcg/user-exec.c' and missed your advice about maintainers.
>>> In another words, I thought I had Cc'ed the TCG MIPS maintainers. =F0=
=9F=98=85
>>> And sorry to maintainers. =F0=9F=98=85
>>>
>>>>
>>>>
>> This is fine, Kele. :)
>>
>> The granularity of get_maintainer.py is at file level, so this is one of
>> the cases where you can use your own judgement and include more email
>> addresses, even though get_maintainer.py doesn't list them.
>> get_maintainer.py is good most of the time, but not always. But not a bi=
g
>> deal.
>>
>> Thanks for the patch! :)
>>
>> I expect Richard is going to include it in his next tcg queue.
>>
>> Yours,
>> Aleksandar
>>
>>
>>> On Sun, 27 Sep 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
>>> wrote:
>>>
>>>> On 9/27/20 10:20 AM, Kele Huang wrote:
>>>> > Detect all MIPS store instructions in cpu_signal_handler for all
>>>> available
>>>> > MIPS versions, and set is_write if encountering such store
>>>> instructions.
>>>> >
>>>> > This fixed the error while dealing with self-modified code for MIPS.
>>>> >
>>>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
>>>> > Signed-off-by: Xu Zou <iwatchnima@gmail.com>
>>>>
>>>> I already Cc'ed the TCG MIPS maintainers twice for you,
>>>> but you don't mind, so this time I won't insist.
>>>>
>>>> > ---
>>>> >  accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>>> >  1 file changed, 38 insertions(+), 1 deletion(-)
>>>> >
>>>> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>>>> > index bb039eb32d..9ecda6c0d0 100644
>>>> > --- a/accel/tcg/user-exec.c
>>>> > +++ b/accel/tcg/user-exec.c
>>>> > @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void
>>>> *pinfo,
>>>> >
>>>> >  #elif defined(__mips__)
>>>> >
>>>> > +#if defined(__misp16) || defined(__mips_micromips)
>>>> > +#error "Unsupported encoding"
>>>> > +#endif
>>>> > +
>>>> >  int cpu_signal_handler(int host_signum, void *pinfo,
>>>> >                         void *puc)
>>>> >  {
>>>> > @@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void
>>>> *pinfo,
>>>> >      ucontext_t *uc =3D puc;
>>>> >      greg_t pc =3D uc->uc_mcontext.pc;
>>>> >      int is_write;
>>>> > +    uint32_t insn;
>>>> >
>>>> > -    /* XXX: compute is_write */
>>>> > +    /* Detect all store instructions at program counter. */
>>>> >      is_write =3D 0;
>>>> > +    insn =3D *(uint32_t *)pc;
>>>> > +    switch((insn >> 26) & 077) {
>>>> > +    case 050: /* SB */
>>>> > +    case 051: /* SH */
>>>> > +    case 052: /* SWL */
>>>> > +    case 053: /* SW */
>>>> > +    case 054: /* SDL */
>>>> > +    case 055: /* SDR */
>>>> > +    case 056: /* SWR */
>>>> > +    case 070: /* SC */
>>>> > +    case 071: /* SWC1 */
>>>> > +    case 074: /* SCD */
>>>> > +    case 075: /* SDC1 */
>>>> > +    case 077: /* SD */
>>>> > +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
>>>> > +    case 072: /* SWC2 */
>>>> > +    case 076: /* SDC2 */
>>>> > +#endif
>>>> > +        is_write =3D 1;
>>>> > +        break;
>>>> > +    case 023: /* COP1X */
>>>> > +        /* Required in all versions of MIPS64 since
>>>> > +           MIPS64r1 and subsequent versions of MIPS32r2. */
>>>> > +        switch (insn & 077) {
>>>> > +        case 010: /* SWXC1 */
>>>> > +        case 011: /* SDXC1 */
>>>> > +        case 015: /* SDXC1 */
>>>> > +            is_write =3D 1;
>>>> > +        }
>>>> > +        break;
>>>> > +    }
>>>> > +
>>>> >      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>>>> >  }
>>>> >
>>>> >
>>>>
>>>>

--000000000000c0f4b405b0abd474
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 015: /* SDXC1 =
*/<br></div><div><br></div>I just found a comment mistake about SUXC1,=C2=
=A0 and I have rectified it and resent a new patch.</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 29 Sep 2020 at 0=
9:59, Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.com">kele.hwang@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr">Thank you so much!<div><br></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 28 Sep 2020=
 at 16:14, Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@=
gmail.com" target=3D"_blank">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Sund=
ay, September 27, 2020, Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.c=
om" target=3D"_blank">kele.hwang@gmail.com</a>&gt; wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Sorry about that, I on=
ly got maintainers by &#39;./scripts/<a href=3D"http://get_maintainer.pl" t=
arget=3D"_blank">get_maintainer.pl</a> -f accel/tcg/user-exec.c&#39; and mi=
ssed your advice about maintainers.=C2=A0<div>In another words, I thought I=
 had Cc&#39;ed the TCG MIPS maintainers.=C2=A0=F0=9F=98=85</div><div>And so=
rry to maintainers.=C2=A0=F0=9F=98=85</div></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><br></blockquote></blockquote><div><br></div><div>T=
his is fine, Kele. :)</div><div><br></div><div>The granularity of get_maint=
ainer.py is at file level, so this is one of the cases where you can use yo=
ur own judgement and include more email addresses, even though get_maintain=
er.py doesn&#39;t list them. get_maintainer.py is good most of the time, bu=
t not always. But not a big deal.</div><div><br></div><div>Thanks for the p=
atch! :)</div><div><br></div><div>I expect Richard is going to include it i=
n his next tcg queue.</div><div><br></div><div>Yours,</div><div>Aleksandar<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 27 Se=
p 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@am=
sat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On 9/27/20 10:20 AM, Kele Huang w=
rote:<br>
&gt; Detect all MIPS store instructions in cpu_signal_handler for all avail=
able<br>
&gt; MIPS versions, and set is_write if encountering such store instruction=
s.<br>
&gt; <br>
&gt; This fixed the error while dealing with self-modified code for MIPS.<b=
r>
&gt; <br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.com" =
target=3D"_blank">kele.hwang@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Xu Zou &lt;<a href=3D"mailto:iwatchnima@gmail.com" targ=
et=3D"_blank">iwatchnima@gmail.com</a>&gt;<br>
<br>
I already Cc&#39;ed the TCG MIPS maintainers twice for you,<br>
but you don&#39;t mind, so this time I won&#39;t insist.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 accel/tcg/user-exec.c | 39 +++++++++++++++++++++++++++++++++++++=
+-<br>
&gt;=C2=A0 1 file changed, 38 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c<br>
&gt; index bb039eb32d..9ecda6c0d0 100644<br>
&gt; --- a/accel/tcg/user-exec.c<br>
&gt; +++ b/accel/tcg/user-exec.c<br>
&gt; @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pin=
fo,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #elif defined(__mips__)<br>
&gt;=C2=A0 <br>
&gt; +#if defined(__misp16) || defined(__mips_micromips)<br>
&gt; +#error &quot;Unsupported encoding&quot;<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 int cpu_signal_handler(int host_signum, void *pinfo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0void *puc)<br>
&gt;=C2=A0 {<br>
&gt; @@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void *pin=
fo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ucontext_t *uc =3D puc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 greg_t pc =3D uc-&gt;uc_mcontext.pc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int is_write;<br>
&gt; +=C2=A0 =C2=A0 uint32_t insn;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 /* XXX: compute is_write */<br>
&gt; +=C2=A0 =C2=A0 /* Detect all store instructions at program counter. */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is_write =3D 0;<br>
&gt; +=C2=A0 =C2=A0 insn =3D *(uint32_t *)pc;<br>
&gt; +=C2=A0 =C2=A0 switch((insn &gt;&gt; 26) &amp; 077) {<br>
&gt; +=C2=A0 =C2=A0 case 050: /* SB */<br>
&gt; +=C2=A0 =C2=A0 case 051: /* SH */<br>
&gt; +=C2=A0 =C2=A0 case 052: /* SWL */<br>
&gt; +=C2=A0 =C2=A0 case 053: /* SW */<br>
&gt; +=C2=A0 =C2=A0 case 054: /* SDL */<br>
&gt; +=C2=A0 =C2=A0 case 055: /* SDR */<br>
&gt; +=C2=A0 =C2=A0 case 056: /* SWR */<br>
&gt; +=C2=A0 =C2=A0 case 070: /* SC */<br>
&gt; +=C2=A0 =C2=A0 case 071: /* SWC1 */<br>
&gt; +=C2=A0 =C2=A0 case 074: /* SCD */<br>
&gt; +=C2=A0 =C2=A0 case 075: /* SDC1 */<br>
&gt; +=C2=A0 =C2=A0 case 077: /* SD */<br>
&gt; +#if !defined(__mips_isa_rev) || __mips_isa_rev &lt; 6<br>
&gt; +=C2=A0 =C2=A0 case 072: /* SWC2 */<br>
&gt; +=C2=A0 =C2=A0 case 076: /* SDC2 */<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 023: /* COP1X */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Required in all versions of MIPS64 sin=
ce <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS64r1 and subsequent vers=
ions of MIPS32r2. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (insn &amp; 077) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 010: /* SWXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 011: /* SDXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 015: /* SDXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return handle_cpu_signal(pc, info, is_write, &amp;=
uc-&gt;uc_sigmask);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; <br>
<br>
</blockquote></div>
</blockquote>
</blockquote></div>
</blockquote></div>

--000000000000c0f4b405b0abd474--

