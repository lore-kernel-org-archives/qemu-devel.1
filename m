Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F7DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF9023772
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmmW08ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF9023772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOjF-00046L-KP
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLO4a-0005ms-6x
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:01:56 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:41892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLO4X-0002Ta-QE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:01:55 -0400
Received: by mail-ej1-x644.google.com with SMTP id lo4so3604405ejb.8
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=cp0a7EI7vYUuf2cCjOUKWoU5wMo2vFRTH49WaDkjhro=;
 b=LmmW08ZLSRFexvsjHCma9KOCWaN+OyIMmZOPfxQvazgjZTSWNY5QO6lQ8guRTyn6tS
 6g9vvtxyYEryXFPG1CDADDXcur3r4GrHc52rgWACun1dUuMLNUi3O+qcb1Ky7okUGK2i
 mX262oQx7SlBE/pwwUWAhFpLORi9IvkpP3VvfuwpNASY/gxv579MTQg9DM7Yhoxp0aED
 793TwO3LZyQzLhsxk5av+kuawp6QxYKaaCBB/jtdv1P+GFTg6c7/Eyvj/l+m24SajDA9
 VBmTtvJyAD7FCmd96yW7h34UQxhwClJFkpb/fgkUHxXysphlBLR3LQTIozaBUczGyigK
 f6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=cp0a7EI7vYUuf2cCjOUKWoU5wMo2vFRTH49WaDkjhro=;
 b=l+2eWZuqvETG099lWNChlkmj8zhRwzgL0OnfIT5eSSia5N3xCCPTbrJlpTVsjLmcio
 ZPpWqDWFeb2fbiR55/L1xGy/JYQtBZ9gK5LRFi/fifWwxtginwIRDV9PnBoCFyeXV3Sj
 hofbOWZLHHosCr+szgTmJftFncebZjT9duoWJNz4BacWjk3TyMSnpdoCxQrWV28/IaJE
 lz1IhTDjCkYAB0345EUXd6tQva0Tyk8gwOTuobZa8aDhx11LLYfSmTnCrAc+y9Xv0bm+
 gmyZyZ9+2TKx53tQP1lWYMLHLnRnvIRaokrM/OQLrtwF2dEKydEysGxaWX12ztUFBLGX
 Lq4w==
X-Gm-Message-State: AOAM531njjFXz0Xu57nQ0C4VDgXnA6LqYUXftK7utowuC1JGy1QkTMBO
 ebHPrSZ/Wuf+riWAC5eEQ2WOiNi1BZLR0nii0N4=
X-Google-Smtp-Source: ABdhPJwkRKq62FJk51bU+2zZ50b6g3F6uAW7LdgCMxaKwd6eTDHxSLyD3bXZ0+TAZGM58wYSjCD7e1sfly9USZP0UcU=
X-Received: by 2002:a17:907:374:: with SMTP id
 rs20mr151156ejb.135.1600941711677; 
 Thu, 24 Sep 2020 03:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200923093800.9845-1-kele.hwang@gmail.com>
 <25889d77-4de0-6f5a-2b60-ab3e474e7c50@amsat.org>
In-Reply-To: <25889d77-4de0-6f5a-2b60-ab3e474e7c50@amsat.org>
From: Kele Huang <kele.hwang@gmail.com>
Date: Thu, 24 Sep 2020 18:01:40 +0800
Message-ID: <CA+FBGNcDKUH=_QMstO6+XDvzUMDwQaEGVxfBEUSG-=hHO0nVrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] accel/tcg: Fix computing of is_write for mips
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000007de7105b00c4a2d"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000007de7105b00c4a2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry about my misunderstanding of your guidelines.
What is more, I have resend a new v2 patch as a new top-level thread and CC
to TCG MIPS maintainers and Richard.

On Wed, 23 Sep 2020 at 19:08, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
wrote:

> Cc'ing the TCG MIPS maintainers, and also
> Cc'ing Richard who made a comment in v1.
>
> On 9/23/20 11:38 AM, Kele Huang wrote:
> > Detect mips store instructions in cpu_signal_handler for all MIPS
> > versions, and set is_write if encountering such store instructions.
> >
> > This fixed the error while dealing with self-modifed code for MIPS.
>
> Quoting Eric Blake:
>
> "It's better to post a v2 as a new top-level thread rather
> than buried in-reply-to the v1 thread; among other things,
> burying a reply can cause automated patch tooling to miss
> the updated series."
>
> >
> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> > Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> > ---
> >  accel/tcg/user-exec.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> > index bb039eb32d..18784516e5 100644
> > --- a/accel/tcg/user-exec.c
> > +++ b/accel/tcg/user-exec.c
> > @@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum, void
> *pinfo,
> >      greg_t pc =3D uc->uc_mcontext.pc;
> >      int is_write;
> >
> > -    /* XXX: compute is_write */
> >      is_write =3D 0;
> > +
> > +    /* Detect store by reading the instruction at the program counter.
> */
> > +    uint32_t insn =3D *(uint32_t *)pc;
> > +    switch(insn>>29) {
> > +    case 0x5:
> > +        switch((insn>>26) & 0x7) {
> > +        case 0x0: /* SB */
> > +        case 0x1: /* SH */
> > +        case 0x2: /* SWL */
> > +        case 0x3: /* SW */
> > +        case 0x4: /* SDL */
> > +        case 0x5: /* SDR */
> > +        case 0x6: /* SWR */
> > +            is_write =3D 1;
> > +        }
> > +        break;
> > +    case 0x7:
> > +        switch((insn>>26) & 0x7) {
> > +        case 0x0: /* SC */
> > +        case 0x1: /* SWC1 */
> > +        case 0x4: /* SCD */
> > +        case 0x5: /* SDC1 */
> > +        case 0x7: /* SD */
> > +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> > +        case 0x2: /* SWC2 */
> > +        case 0x6: /* SDC2 */
> > +#endif
> > +            is_write =3D 1;
> > +        }
> > +        break;
> > +    }
> > +
> > +    /*
> > +     * Required in all versions of MIPS64 since MIPS64r1. Not availabl=
e
> > +     * in MIPS32r1. Required by MIPS32r2 and subsequent versions of
> MIPS32.
> > +     */
> > +    switch ((insn >> 3) & 0x7) {
> > +    case 0x1:
> > +        switch (insn & 0x7) {
> > +        case 0x0: /* SWXC1 */
> > +        case 0x1: /* SDXC1 */
> > +            is_write =3D 1;
> > +        }
> > +        break;
> > +    }
> > +
> >      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
> >  }
> >
> > +#elif defined(__misp16) || defined(__mips_micromips)
> > +
> > +#error "Unsupported encoding"
> > +
> >  #elif defined(__riscv)
> >
> >  int cpu_signal_handler(int host_signum, void *pinfo,
> >
>
>

--00000000000007de7105b00c4a2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry about my misunderstanding of your guidelines.<div>Wh=
at is more, I have resend a new v2 patch as a new top-level thread and CC t=
o TCG MIPS maintainers and Richard.</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 23 Sep 2020 at 19:08, Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Cc&#39;ing the TCG MIPS maintainers, and also<br>
Cc&#39;ing Richard who made a comment in v1.<br>
<br>
On 9/23/20 11:38 AM, Kele Huang wrote:<br>
&gt; Detect mips store instructions in cpu_signal_handler for all MIPS<br>
&gt; versions, and set is_write if encountering such store instructions.<br=
>
&gt; <br>
&gt; This fixed the error while dealing with self-modifed code for MIPS.<br=
>
<br>
Quoting Eric Blake:<br>
<br>
&quot;It&#39;s better to post a v2 as a new top-level thread rather<br>
than buried in-reply-to the v1 thread; among other things,<br>
burying a reply can cause automated patch tooling to miss<br>
the updated series.&quot;<br>
<br>
&gt; <br>
&gt; Signed-off-by: Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.com" =
target=3D"_blank">kele.hwang@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Xu Zou &lt;<a href=3D"mailto:iwatchnima@gmail.com" targ=
et=3D"_blank">iwatchnima@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 accel/tcg/user-exec.c | 51 +++++++++++++++++++++++++++++++++++++=
+++++-<br>
&gt;=C2=A0 1 file changed, 50 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c<br>
&gt; index bb039eb32d..18784516e5 100644<br>
&gt; --- a/accel/tcg/user-exec.c<br>
&gt; +++ b/accel/tcg/user-exec.c<br>
&gt; @@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum, void *pi=
nfo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 greg_t pc =3D uc-&gt;uc_mcontext.pc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int is_write;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 /* XXX: compute is_write */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is_write =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Detect store by reading the instruction at the progr=
am counter. */<br>
&gt; +=C2=A0 =C2=A0 uint32_t insn =3D *(uint32_t *)pc;<br>
&gt; +=C2=A0 =C2=A0 switch(insn&gt;&gt;29) {<br>
&gt; +=C2=A0 =C2=A0 case 0x5:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch((insn&gt;&gt;26) &amp; 0x7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x0: /* SB */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x1: /* SH */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x2: /* SWL */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x3: /* SW */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x4: /* SDL */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x5: /* SDR */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x6: /* SWR */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x7:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch((insn&gt;&gt;26) &amp; 0x7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x0: /* SC */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x1: /* SWC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x4: /* SCD */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x5: /* SDC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x7: /* SD */<br>
&gt; +#if !defined(__mips_isa_rev) || __mips_isa_rev &lt; 6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x2: /* SWC2 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x6: /* SDC2 */<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Required in all versions of MIPS64 since MIPS64=
r1. Not available<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* in MIPS32r1. Required by MIPS32r2 and subsequen=
t versions of MIPS32.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 switch ((insn &gt;&gt; 3) &amp; 0x7) {<br>
&gt; +=C2=A0 =C2=A0 case 0x1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (insn &amp; 0x7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x0: /* SWXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x1: /* SDXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return handle_cpu_signal(pc, info, is_write, &amp;=
uc-&gt;uc_sigmask);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#elif defined(__misp16) || defined(__mips_micromips)<br>
&gt; +<br>
&gt; +#error &quot;Unsupported encoding&quot;<br>
&gt; +<br>
&gt;=C2=A0 #elif defined(__riscv)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int cpu_signal_handler(int host_signum, void *pinfo,<br>
&gt; <br>
<br>
</blockquote></div>

--00000000000007de7105b00c4a2d--

