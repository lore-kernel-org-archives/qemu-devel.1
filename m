Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B3C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AB223899
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVn3lFEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AB223899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMTK6-0000nu-7a
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 05:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kMTJN-0000Mj-Lb
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:49:41 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kMTJL-00079S-MD
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:49:41 -0400
Received: by mail-ej1-x644.google.com with SMTP id e23so4329846eja.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QS6HU+Loi65LnVllRH9pk8ErKXOvSHP/Hcb3gfn3R8w=;
 b=oVn3lFEJ00Q335yqXmlAPoa5V6MwhajjqnXQFqbThZFuk6ch+TUOqvsS+huZX7Hi7/
 B/CCeph091wa9gH7sFO7F3DklxYS2ZZeMO0hV3xHd8h9Zy0O2xdAZ32kGUrauFSkN2n+
 Tem/uJg6qXAYtNkl3LhdR24isFDXCWwx2YGVTrcn2ReeAwxSLB/C3a7iCQHRvM1yx1cG
 vjAnTaaiXldGJPdoQ2phI0eKSx4KANoq6AYz9HEJH6e2IXP4hTFvhk3SFrAKJYk95a+m
 P6Up+pr2Hx0B5bfjBkcdWt94Gc1VXCp1SoDvyvRSqqfxJM1vVgfYvXv7DFqscYwNTfRq
 zqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QS6HU+Loi65LnVllRH9pk8ErKXOvSHP/Hcb3gfn3R8w=;
 b=aZzcutFPrGfihRY+tNxfPkOo0cBothxBt0NaLA2FJ0ni/llc66B044jQsyOs7hr0HB
 kbV5ABrgEk01y4frX2LujpWGUF1I4Ic0jqP365juhxGc+3uJkEqjC7HpecNOTU1p9RkB
 Am+qYzcJ85OPa7REXgMPnlJ4guciSXvW8lMSpB+TjuCBS6QWh7KtHHCyiSxho7Ku2V54
 p8c4DgiOqzd1BxoBEWpqtT7a+Emb8U0CkrNUoItA5FNJ0RozRK4AOdDg8f9GK4efqiIV
 5Qv3i0UWP/1YaC8XCUXN9TrXAzf6zJ3B7wwHjT+eVsTG1WOqZwInujMHrAS9bIaRDjpa
 tYaQ==
X-Gm-Message-State: AOAM532aa7asC8dQ/uMMzmLQK4T49aFYYI5qpiJp2Rb8/s8GymPjAt0l
 oSlfBMsUgqsWX7gq/GPtYUdc0UXxjK8hpguZZgU=
X-Google-Smtp-Source: ABdhPJz1Wt4mfR7ZbRTyMBuq8aoovxN9hjVFouGhFjikpGv420IPDQzzLYBGdEh3DNTgfG2kR9KEp5OELrTjL382i/g=
X-Received: by 2002:a17:906:4c8b:: with SMTP id
 q11mr10174696eju.531.1601200178426; 
 Sun, 27 Sep 2020 02:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082033.8716-1-kele.hwang@gmail.com>
 <c716ca94-5600-5521-f0ef-cd0e7809f52a@amsat.org>
In-Reply-To: <c716ca94-5600-5521-f0ef-cd0e7809f52a@amsat.org>
From: Kele Huang <kele.hwang@gmail.com>
Date: Sun, 27 Sep 2020 17:49:24 +0800
Message-ID: <CA+FBGNepcP98zG2jzgivGHsgPDvMEmV5kNWVkvri6UFsOSyQTw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] accel/tcg: Fix computing of is_write for MIPS
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d9770d05b04877fa"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=kele.hwang@gmail.com; helo=mail-ej1-x644.google.com
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d9770d05b04877fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry about that, I only got maintainers by './scripts/get_maintainer.pl -f
accel/tcg/user-exec.c' and missed your advice about maintainers.
In another words, I thought I had Cc'ed the TCG MIPS maintainers. =F0=9F=98=
=85
And sorry to maintainers. =F0=9F=98=85

On Sun, 27 Sep 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
wrote:

> On 9/27/20 10:20 AM, Kele Huang wrote:
> > Detect all MIPS store instructions in cpu_signal_handler for all
> available
> > MIPS versions, and set is_write if encountering such store instructions=
.
> >
> > This fixed the error while dealing with self-modified code for MIPS.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> > Signed-off-by: Xu Zou <iwatchnima@gmail.com>
>
> I already Cc'ed the TCG MIPS maintainers twice for you,
> but you don't mind, so this time I won't insist.
>
> > ---
> >  accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> > index bb039eb32d..9ecda6c0d0 100644
> > --- a/accel/tcg/user-exec.c
> > +++ b/accel/tcg/user-exec.c
> > @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinf=
o,
> >
> >  #elif defined(__mips__)
> >
> > +#if defined(__misp16) || defined(__mips_micromips)
> > +#error "Unsupported encoding"
> > +#endif
> > +
> >  int cpu_signal_handler(int host_signum, void *pinfo,
> >                         void *puc)
> >  {
> > @@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void *pinf=
o,
> >      ucontext_t *uc =3D puc;
> >      greg_t pc =3D uc->uc_mcontext.pc;
> >      int is_write;
> > +    uint32_t insn;
> >
> > -    /* XXX: compute is_write */
> > +    /* Detect all store instructions at program counter. */
> >      is_write =3D 0;
> > +    insn =3D *(uint32_t *)pc;
> > +    switch((insn >> 26) & 077) {
> > +    case 050: /* SB */
> > +    case 051: /* SH */
> > +    case 052: /* SWL */
> > +    case 053: /* SW */
> > +    case 054: /* SDL */
> > +    case 055: /* SDR */
> > +    case 056: /* SWR */
> > +    case 070: /* SC */
> > +    case 071: /* SWC1 */
> > +    case 074: /* SCD */
> > +    case 075: /* SDC1 */
> > +    case 077: /* SD */
> > +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> > +    case 072: /* SWC2 */
> > +    case 076: /* SDC2 */
> > +#endif
> > +        is_write =3D 1;
> > +        break;
> > +    case 023: /* COP1X */
> > +        /* Required in all versions of MIPS64 since
> > +           MIPS64r1 and subsequent versions of MIPS32r2. */
> > +        switch (insn & 077) {
> > +        case 010: /* SWXC1 */
> > +        case 011: /* SDXC1 */
> > +        case 015: /* SDXC1 */
> > +            is_write =3D 1;
> > +        }
> > +        break;
> > +    }
> > +
> >      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
> >  }
> >
> >
>
>

--000000000000d9770d05b04877fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry about that, I only got maintainers by &#39;./scripts=
/<a href=3D"http://get_maintainer.pl">get_maintainer.pl</a> -f accel/tcg/us=
er-exec.c&#39; and missed your advice about maintainers.=C2=A0<div>In anoth=
er words, I thought I had Cc&#39;ed the TCG MIPS maintainers.=C2=A0=F0=9F=
=98=85</div><div>And sorry to maintainers.=C2=A0=F0=9F=98=85</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, 2=
7 Sep 2020 at 16:41, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bu=
g@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On 9/27/20 10:20 AM, Kele Huang wrote:<br>
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

--000000000000d9770d05b04877fa--

