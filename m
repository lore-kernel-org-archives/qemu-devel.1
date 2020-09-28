Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8926C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E290020738
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6jqlCtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E290020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMoKr-0006DM-ND
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kMoJH-0005bU-1m
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:14:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kMoJD-0003MN-S5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 04:14:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id k10so169286wru.6
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4LuE+ZyTkVbmwN/lB5uxUEoH1IGN9UtxDvilvEtWJbs=;
 b=r6jqlCtP20DiXZdyNejLMfIPrX+czM1aUkKF3QVFSysqh1Wq5/O0BesaymmH4VV0YM
 8AD+iQ31gar5R4BrfLPsQr/Xzl9j0K/mQdC/IEB55BSijHVCn/+QC7sbDe9uypznJLGT
 vGmB2FGSc5jgpOL0W2j9GS6DBcsjvbxifFV22XtQh8IlKdFYZnFE6iWXrtUzH0n6cwJd
 KdOhL23OPzdI6eZpCB4NgQaE62ioXGxcZAwbjpitTGALqIFBTuc4zPZJBIdpEy/6cO0f
 i0BymxIe9Z5Eis5yNGhJfSMV5KUstCIteIqpeYNIwi+O9atVcsCKYflhIH3hQxixQA0/
 3DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4LuE+ZyTkVbmwN/lB5uxUEoH1IGN9UtxDvilvEtWJbs=;
 b=S6wHsfqwFq9J+HnwpHUNkLS43xTAw5Gb2XI4zTSxHQBgtHKsghjN4yUVn0tR75tbcV
 CEOdJbCMI61asxgIeWkscDlQ4NiM9/JSZyQvgTvIEJjIPP0hiVZ6cIN3KYUX69wPD2PR
 s8b+hBz5zE6MpTUR1QCye2BRgyK4Fpcw/YRNxJBUJ8D8SKGOD8yoRZh9SbtqJ7GlqAXz
 FuRMthBSD5jHDYbvoq8+gFFgT5Zlflah3XSvAlkcklI1aByYyf0faQffZ1SmzkOXsjvi
 ntSvFYczhtUi60AeWVa7KZNpvtKaAHyxRMW0GiI3+5BH+0cWJPEbPBIMdHCGFMskR/Ka
 dTxA==
X-Gm-Message-State: AOAM531AIexonOpZUcUjmiju+ipmsm8wlv1P6pcnW/504IgLCs3Oib5J
 7DYqLSARMVdbNzCMNRsEgHsewm6Y4XewpF//OVA=
X-Google-Smtp-Source: ABdhPJwEBO3Wo9prReZWVgwhoaZhNoVhNpcUxHumjVLSLsI2ZgI0K9KYkTVDs86sesUy75Bl2jCMehkSFJpezyXH4q0=
X-Received: by 2002:adf:fc4e:: with SMTP id e14mr258208wrs.329.1601280891867; 
 Mon, 28 Sep 2020 01:14:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7504:0:0:0:0:0 with HTTP; Mon, 28 Sep 2020 01:14:51
 -0700 (PDT)
In-Reply-To: <CA+FBGNepcP98zG2jzgivGHsgPDvMEmV5kNWVkvri6UFsOSyQTw@mail.gmail.com>
References: <20200927082033.8716-1-kele.hwang@gmail.com>
 <c716ca94-5600-5521-f0ef-cd0e7809f52a@amsat.org>
 <CA+FBGNepcP98zG2jzgivGHsgPDvMEmV5kNWVkvri6UFsOSyQTw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 28 Sep 2020 10:14:51 +0200
Message-ID: <CAHiYmc6n-Z2f4utqxT73TciRRmg3nSfrHhX4o4YayF59WAK1Gw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Kele Huang <kele.hwang@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bed64d05b05b4229"
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

--000000000000bed64d05b05b4229
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, September 27, 2020, Kele Huang <kele.hwang@gmail.com> wrote:

> Sorry about that, I only got maintainers by './scripts/get_maintainer.pl
> -f accel/tcg/user-exec.c' and missed your advice about maintainers.
> In another words, I thought I had Cc'ed the TCG MIPS maintainers. =F0=9F=
=98=85
> And sorry to maintainers. =F0=9F=98=85
>
>>
>>
This is fine, Kele. :)

The granularity of get_maintainer.py is at file level, so this is one of
the cases where you can use your own judgement and include more email
addresses, even though get_maintainer.py doesn't list them.
get_maintainer.py is good most of the time, but not always. But not a big
deal.

Thanks for the patch! :)

I expect Richard is going to include it in his next tcg queue.

Yours,
Aleksandar


> On Sun, 27 Sep 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
> wrote:
>
>> On 9/27/20 10:20 AM, Kele Huang wrote:
>> > Detect all MIPS store instructions in cpu_signal_handler for all
>> available
>> > MIPS versions, and set is_write if encountering such store instruction=
s.
>> >
>> > This fixed the error while dealing with self-modified code for MIPS.
>> >
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
>> > Signed-off-by: Xu Zou <iwatchnima@gmail.com>
>>
>> I already Cc'ed the TCG MIPS maintainers twice for you,
>> but you don't mind, so this time I won't insist.
>>
>> > ---
>> >  accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 38 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> > index bb039eb32d..9ecda6c0d0 100644
>> > --- a/accel/tcg/user-exec.c
>> > +++ b/accel/tcg/user-exec.c
>> > @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void
>> *pinfo,
>> >
>> >  #elif defined(__mips__)
>> >
>> > +#if defined(__misp16) || defined(__mips_micromips)
>> > +#error "Unsupported encoding"
>> > +#endif
>> > +
>> >  int cpu_signal_handler(int host_signum, void *pinfo,
>> >                         void *puc)
>> >  {
>> > @@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void
>> *pinfo,
>> >      ucontext_t *uc =3D puc;
>> >      greg_t pc =3D uc->uc_mcontext.pc;
>> >      int is_write;
>> > +    uint32_t insn;
>> >
>> > -    /* XXX: compute is_write */
>> > +    /* Detect all store instructions at program counter. */
>> >      is_write =3D 0;
>> > +    insn =3D *(uint32_t *)pc;
>> > +    switch((insn >> 26) & 077) {
>> > +    case 050: /* SB */
>> > +    case 051: /* SH */
>> > +    case 052: /* SWL */
>> > +    case 053: /* SW */
>> > +    case 054: /* SDL */
>> > +    case 055: /* SDR */
>> > +    case 056: /* SWR */
>> > +    case 070: /* SC */
>> > +    case 071: /* SWC1 */
>> > +    case 074: /* SCD */
>> > +    case 075: /* SDC1 */
>> > +    case 077: /* SD */
>> > +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
>> > +    case 072: /* SWC2 */
>> > +    case 076: /* SDC2 */
>> > +#endif
>> > +        is_write =3D 1;
>> > +        break;
>> > +    case 023: /* COP1X */
>> > +        /* Required in all versions of MIPS64 since
>> > +           MIPS64r1 and subsequent versions of MIPS32r2. */
>> > +        switch (insn & 077) {
>> > +        case 010: /* SWXC1 */
>> > +        case 011: /* SDXC1 */
>> > +        case 015: /* SDXC1 */
>> > +            is_write =3D 1;
>> > +        }
>> > +        break;
>> > +    }
>> > +
>> >      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>> >  }
>> >
>> >
>>
>>

--000000000000bed64d05b05b4229
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, September 27, 2020, Kele Huang &lt;<a href=3D"mailto:kel=
e.hwang@gmail.com">kele.hwang@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Sorry about that, I only got maintainers by =
&#39;./scripts/<a href=3D"http://get_maintainer.pl" target=3D"_blank">get_m=
aintainer.pl</a> -f accel/tcg/user-exec.c&#39; and missed your advice about=
 maintainers.=C2=A0<div>In another words, I thought I had Cc&#39;ed the TCG=
 MIPS maintainers.=C2=A0=F0=9F=98=85</div><div>And sorry to maintainers.=C2=
=A0=F0=9F=98=85</div></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote>=
</blockquote><div><br></div><div>This is fine, Kele. :)</div><div><br></div=
><div>The granularity of get_maintainer.py is at file level, so this is one=
 of the cases where you can use your own judgement and include more email a=
ddresses, even though get_maintainer.py doesn&#39;t list them. get_maintain=
er.py is good most of the time, but not always. But not a big deal.</div><d=
iv><br></div><div>Thanks for the patch! :)</div><div><br></div><div>I expec=
t Richard is going to include it in his next tcg queue.</div><div><br></div=
><div>Yours,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Sun, 27 Sep 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/27/20 10:=
20 AM, Kele Huang wrote:<br>
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
&gt;=C2=A0 accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++<wbr>++=
++++++-<br>
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

--000000000000bed64d05b05b4229--

