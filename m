Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D6AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE3320774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktxpdJ9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE3320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN4xK-00047i-Nd
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kN4vr-0003E5-Ir
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 21:59:55 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kN4vp-0002NG-B9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 21:59:55 -0400
Received: by mail-ed1-x541.google.com with SMTP id a12so4551814eds.13
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 18:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=su1omVI0rf9nDgdSbo65zcrHph/aEvmKUwAandNypms=;
 b=ktxpdJ9ebUqe/DOQdMV+YmMMkw5rMACel62A3owyTSvxxzEcrQj2HKEfBb6XPWnuZq
 Pyfc139A4Wj16Cspi9ky/oSZY8O7LHcSeZAw2FmnCmsct8Hh7MD+DRNu48cJsbAVAwBH
 7jYAnSjiqwgRRbpI/kAQbmNPSI3MtXwb5bFikEDf5FVT8jyxMsyK0/RRhBWiXsfsl1lg
 zWy9IK4rTMOXYWaiZR01XVKQZ0bXyzSQkl3QO+iXeueUtEAdw/2zxQ1DGcgFG4/MoTeO
 JclalEMNPLx7IfyVOUalaCMHjHrtGroc4zb6j8+jNNIL3udG3u9weN5pCxkNcNzDMgK7
 aUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=su1omVI0rf9nDgdSbo65zcrHph/aEvmKUwAandNypms=;
 b=kLGU3a/q9HrAsmq+EpP5QLJawp0hCIB7X87bd3oFqOLFma0WIjPVMn5BjZt0vqWPF0
 vc13oJvdvwnUXYMYLuZcNxn1KKpuVsV1QsRaUVOFpM0hEtsfu5mf3oW63HpqahMWjboa
 IccCbCdsbDVN0OfzyePYCoeC6I2JDUXgIHyeczoyjIFewtY9iNXJZsdCFJ4mmL4sRAWw
 QmedeLCI2k1z+ERqq5uUwDzXwmFqtusJdt2sf7zpvVfmeOsPfET0Aqhv5bYZcS9A9qES
 NHIRkxqkeXiRx1mGkAqa5NpFLoCNp+rzHGb6yQj8F3Ilbc/5ny6WnmafardET5ZbUDhj
 PsdA==
X-Gm-Message-State: AOAM531VbiC6+iJ7jYbvN7q84whUScY1wrNeuKLRg2pFtX0fEZjCFwN8
 ldJU33fZ3U/WRxDCUn5mmSG1B+3+30l+6PHryVk=
X-Google-Smtp-Source: ABdhPJyiPuRSKA9krTZmGhqMUYq7dv9Ko+fcrvNLi+3SvC4qVOedQ5GWDR8VMW6KntB/4TySBUqHnD5XkeCvBwHoU/A=
X-Received: by 2002:a50:fd19:: with SMTP id i25mr891431eds.142.1601344788009; 
 Mon, 28 Sep 2020 18:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082033.8716-1-kele.hwang@gmail.com>
 <c716ca94-5600-5521-f0ef-cd0e7809f52a@amsat.org>
 <CA+FBGNepcP98zG2jzgivGHsgPDvMEmV5kNWVkvri6UFsOSyQTw@mail.gmail.com>
 <CAHiYmc6n-Z2f4utqxT73TciRRmg3nSfrHhX4o4YayF59WAK1Gw@mail.gmail.com>
In-Reply-To: <CAHiYmc6n-Z2f4utqxT73TciRRmg3nSfrHhX4o4YayF59WAK1Gw@mail.gmail.com>
From: Kele Huang <kele.hwang@gmail.com>
Date: Tue, 29 Sep 2020 09:59:36 +0800
Message-ID: <CA+FBGNe6XOD=-F0MLF2zfu72D3e8amTRk-=YUAumf3mtMJg9Ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000040945405b06a2314"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=kele.hwang@gmail.com; helo=mail-ed1-x541.google.com
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000040945405b06a2314
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much!


On Mon, 28 Sep 2020 at 16:14, Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

>
>
> On Sunday, September 27, 2020, Kele Huang <kele.hwang@gmail.com> wrote:
>
>> Sorry about that, I only got maintainers by './scripts/get_maintainer.pl
>> -f accel/tcg/user-exec.c' and missed your advice about maintainers.
>> In another words, I thought I had Cc'ed the TCG MIPS maintainers. =F0=9F=
=98=85
>> And sorry to maintainers. =F0=9F=98=85
>>
>>>
>>>
> This is fine, Kele. :)
>
> The granularity of get_maintainer.py is at file level, so this is one of
> the cases where you can use your own judgement and include more email
> addresses, even though get_maintainer.py doesn't list them.
> get_maintainer.py is good most of the time, but not always. But not a big
> deal.
>
> Thanks for the patch! :)
>
> I expect Richard is going to include it in his next tcg queue.
>
> Yours,
> Aleksandar
>
>
>> On Sun, 27 Sep 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
>> wrote:
>>
>>> On 9/27/20 10:20 AM, Kele Huang wrote:
>>> > Detect all MIPS store instructions in cpu_signal_handler for all
>>> available
>>> > MIPS versions, and set is_write if encountering such store
>>> instructions.
>>> >
>>> > This fixed the error while dealing with self-modified code for MIPS.
>>> >
>>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
>>> > Signed-off-by: Xu Zou <iwatchnima@gmail.com>
>>>
>>> I already Cc'ed the TCG MIPS maintainers twice for you,
>>> but you don't mind, so this time I won't insist.
>>>
>>> > ---
>>> >  accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>> >  1 file changed, 38 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>>> > index bb039eb32d..9ecda6c0d0 100644
>>> > --- a/accel/tcg/user-exec.c
>>> > +++ b/accel/tcg/user-exec.c
>>> > @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void
>>> *pinfo,
>>> >
>>> >  #elif defined(__mips__)
>>> >
>>> > +#if defined(__misp16) || defined(__mips_micromips)
>>> > +#error "Unsupported encoding"
>>> > +#endif
>>> > +
>>> >  int cpu_signal_handler(int host_signum, void *pinfo,
>>> >                         void *puc)
>>> >  {
>>> > @@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void
>>> *pinfo,
>>> >      ucontext_t *uc =3D puc;
>>> >      greg_t pc =3D uc->uc_mcontext.pc;
>>> >      int is_write;
>>> > +    uint32_t insn;
>>> >
>>> > -    /* XXX: compute is_write */
>>> > +    /* Detect all store instructions at program counter. */
>>> >      is_write =3D 0;
>>> > +    insn =3D *(uint32_t *)pc;
>>> > +    switch((insn >> 26) & 077) {
>>> > +    case 050: /* SB */
>>> > +    case 051: /* SH */
>>> > +    case 052: /* SWL */
>>> > +    case 053: /* SW */
>>> > +    case 054: /* SDL */
>>> > +    case 055: /* SDR */
>>> > +    case 056: /* SWR */
>>> > +    case 070: /* SC */
>>> > +    case 071: /* SWC1 */
>>> > +    case 074: /* SCD */
>>> > +    case 075: /* SDC1 */
>>> > +    case 077: /* SD */
>>> > +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
>>> > +    case 072: /* SWC2 */
>>> > +    case 076: /* SDC2 */
>>> > +#endif
>>> > +        is_write =3D 1;
>>> > +        break;
>>> > +    case 023: /* COP1X */
>>> > +        /* Required in all versions of MIPS64 since
>>> > +           MIPS64r1 and subsequent versions of MIPS32r2. */
>>> > +        switch (insn & 077) {
>>> > +        case 010: /* SWXC1 */
>>> > +        case 011: /* SDXC1 */
>>> > +        case 015: /* SDXC1 */
>>> > +            is_write =3D 1;
>>> > +        }
>>> > +        break;
>>> > +    }
>>> > +
>>> >      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>>> >  }
>>> >
>>> >
>>>
>>>

--00000000000040945405b06a2314
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you so much!<div><br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 28 Sep 2020 at 16=
:14, Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.=
com">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br><br>On Sunday, September 27, 2020, =
Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.com" target=3D"_blank">ke=
le.hwang@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr">Sorry about that, I only got maintainers by &#=
39;./scripts/<a href=3D"http://get_maintainer.pl" target=3D"_blank">get_mai=
ntainer.pl</a> -f accel/tcg/user-exec.c&#39; and missed your advice about m=
aintainers.=C2=A0<div>In another words, I thought I had Cc&#39;ed the TCG M=
IPS maintainers.=C2=A0=F0=9F=98=85</div><div>And sorry to maintainers.=C2=
=A0=F0=9F=98=85</div></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br></blockquote></blockquote><div><br></div><div>This is fine, Kele. :)<=
/div><div><br></div><div>The granularity of get_maintainer.py is at file le=
vel, so this is one of the cases where you can use your own judgement and i=
nclude more email addresses, even though get_maintainer.py doesn&#39;t list=
 them. get_maintainer.py is good most of the time, but not always. But not =
a big deal.</div><div><br></div><div>Thanks for the patch! :)</div><div><br=
></div><div>I expect Richard is going to include it in his next tcg queue.<=
/div><div><br></div><div>Yours,</div><div>Aleksandar</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 27 Sep 2020 at 16:41, Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_bl=
ank">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 9/27/20 10:20 AM, Kele Huang wrote:<br>
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

--00000000000040945405b06a2314--

