Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A647C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDF7208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFE9xSDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDF7208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjDv-00088m-OZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLjBr-0006Nk-2f
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:34:51 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kLjBn-00033u-2d
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:34:50 -0400
Received: by mail-ej1-x644.google.com with SMTP id p15so1932449ejm.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MfA0UfvCoU8x/3RQ4KzGWWe8re+YSSdmTVtQWx3JYEY=;
 b=lFE9xSDEAZg0h2gG/QWRDxlx1QFaes0UiNGxVWFiepzjPGUyD4gYKA086LJxrBUrQA
 sfZDJjGNwImdnoxGMvLjFrcPiVmKxrc/vZpaG3xP2pTvWNEI7Wu+N7ue39DAqsgIQEfT
 JKhjl8CtrLs61cNH9CDzsNIQdCPjm+Z0n7DGaNUVeFTiay8Ei0ar9Yiwzw0lB/T7+5x7
 5X1gH0wnwR+JV500HJ5w86/+ZyD8SErbL4XWzlTcGm2BiOflt3eXUNpgef52JJEyu3n4
 aAlOl1+QxzaRIIpDMvdZOZPokgbqGVXaseJ+6Qar0zW2bzyf+98WseJGqu4oGKdkrXpP
 sG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MfA0UfvCoU8x/3RQ4KzGWWe8re+YSSdmTVtQWx3JYEY=;
 b=XDKpThTFzvA/9zz09FUbVBjV40a3EAHQ7JvrDvH7GWlZxiotsrfQBHgFgmvC00HRIj
 3wAtHhCsXM6TaxVX4H0MDOaZUL4GAd5eMSjlZZGzcefVNUErRgOjkIGEciPKAabyzXsq
 Vh2SgGXkxSTNhvUkQ3DFmDnibJPJu9oDhL5nWGlmc9Poa4WXiQe5BhSEDMh7NTKJAyD4
 aYLcjqVZI0InVDtb01/TYXtHMJrixIhBPAY9v3P0s6yMFmFeFJ9r5XWcDfrdzfkUY72e
 PfWNImd2I/PNwnr4DngWk2UICTC33tMcUCf8QXFXrHXxojPEIqwaxqFGrAVcvyp5xiNd
 kMrw==
X-Gm-Message-State: AOAM533DXHmlNn7rcusGdWXRcqL7adTCAaEofKN14f33dVorBs16Mb0y
 vO+RnQsxMa854jz3vns/NM1tOyD4O269wsOYpMQ=
X-Google-Smtp-Source: ABdhPJx9WAySCzuPhXVDhsxiiuPvtzuzGEl0C3o1DxkrEnzK8RwAPoKjvuxhWDOU06QjQImBaYHtBeJITxnzT8IukJk=
X-Received: by 2002:a17:906:4a07:: with SMTP id
 w7mr1611853eju.366.1601022885505; 
 Fri, 25 Sep 2020 01:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200923093800.9845-1-kele.hwang@gmail.com>
 <74c6f6d4-714a-4f8d-71fd-185cf3b35655@linaro.org>
In-Reply-To: <74c6f6d4-714a-4f8d-71fd-185cf3b35655@linaro.org>
From: Kele Huang <kele.hwang@gmail.com>
Date: Fri, 25 Sep 2020 16:34:34 +0800
Message-ID: <CA+FBGNfDgQVFGyfs7m+hjpmq=ezp_VpwZ0kVd25XXWF=u_Dywg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] accel/tcg: Fix computing of is_write for mips
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005e32b905b01f30d2"
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
Cc: Xu Zou <iwatchnima@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005e32b905b01f30d2
Content-Type: text/plain; charset="UTF-8"

Got it. Thank you again!
I have resend a brand new v3 patch.

On Thu, 24 Sep 2020 at 22:05, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/23/20 2:38 AM, Kele Huang wrote:
> > Detect mips store instructions in cpu_signal_handler for all MIPS
> > versions, and set is_write if encountering such store instructions.
> >
> > This fixed the error while dealing with self-modifed code for MIPS.
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
> >      greg_t pc = uc->uc_mcontext.pc;
> >      int is_write;
> >
> > -    /* XXX: compute is_write */
> >      is_write = 0;
> > +
> > +    /* Detect store by reading the instruction at the program counter.
> */
> > +    uint32_t insn = *(uint32_t *)pc;
> > +    switch(insn>>29) {
>
> This would be easier if you simply looked at the entire major opcode field,
> beginning at bit 26.
>
> > +    case 0x5:
> > +        switch((insn>>26) & 0x7) {
> > +        case 0x0: /* SB */
> > +        case 0x1: /* SH */
> > +        case 0x2: /* SWL */
> > +        case 0x3: /* SW */
> > +        case 0x4: /* SDL */
> > +        case 0x5: /* SDR */
> > +        case 0x6: /* SWR */
> > +            is_write = 1;
> > +        }
>
> So this becomes
>
>     case 050: /* SB */
>     case 051: /* SH */
>       ...
>
> I know there are some who don't like octal, but IMO MIPS and its 6 bit
> fields
> and 8x8 tables is a natural fit -- one can read the two octal digits right
> off
> of the table.
>
> Otherwise, perhaps you'd prefer binary constants like 0b101000.  But with
> these
> tables I find the mental bit-extract from hex to be tiresome.
>
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
> > +            is_write = 1;
>
> Similarly.
>
> > +        }
> > +        break;
> > +    }
> > +
> > +    /*
> > +     * Required in all versions of MIPS64 since MIPS64r1. Not available
> > +     * in MIPS32r1. Required by MIPS32r2 and subsequent versions of
> MIPS32.
> > +     */
> > +    switch ((insn >> 3) & 0x7) {
> > +    case 0x1:
> > +        switch (insn & 0x7) {
> > +        case 0x0: /* SWXC1 */
> > +        case 0x1: /* SDXC1 */
> > +            is_write = 1;
> > +        }
> > +        break;
> > +    }
>
> This switch is incorrectly placed.  It must be within the first switch,
> under
> major opcode 023 (COP1X).  And again, you should extract the entire 6-bit
> minor
> opcode all at once, not one octal digit at a time.
>
> > +#elif defined(__misp16) || defined(__mips_micromips)
> > +
> > +#error "Unsupported encoding"
>
> This is incorrectly placed, because we've already successfully entered the
> preceeding #elif defined(__mips__).  This needs to be
>
> #elif defined(__mips__)
> # if defined(__mips16) || defined(__mips_micromips)
> #  error
> # endif
>
> int cpu_signal_handler(int host_signum, void *pinfo,
>                        void *puc)
> {
>    ...
> }
>
> #elif defined(__riscv)
>
>
>
> r~
>

--0000000000005e32b905b01f30d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Got it. Thank you again!<br><div>I have resend a brand new=
 v3 patch.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, 24 Sep 2020 at 22:05, Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/2=
3/20 2:38 AM, Kele Huang wrote:<br>
&gt; Detect mips store instructions in cpu_signal_handler for all MIPS<br>
&gt; versions, and set is_write if encountering such store instructions.<br=
>
&gt; <br>
&gt; This fixed the error while dealing with self-modifed code for MIPS.<br=
>
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
<br>
This would be easier if you simply looked at the entire major opcode field,=
<br>
beginning at bit 26.<br>
<br>
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
<br>
So this becomes<br>
<br>
=C2=A0 =C2=A0 case 050: /* SB */<br>
=C2=A0 =C2=A0 case 051: /* SH */<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
<br>
I know there are some who don&#39;t like octal, but IMO MIPS and its 6 bit =
fields<br>
and 8x8 tables is a natural fit -- one can read the two octal digits right =
off<br>
of the table.<br>
<br>
Otherwise, perhaps you&#39;d prefer binary constants like 0b101000.=C2=A0 B=
ut with these<br>
tables I find the mental bit-extract from hex to be tiresome.<br>
<br>
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
<br>
Similarly.<br>
<br>
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
<br>
This switch is incorrectly placed.=C2=A0 It must be within the first switch=
, under<br>
major opcode 023 (COP1X).=C2=A0 And again, you should extract the entire 6-=
bit minor<br>
opcode all at once, not one octal digit at a time.<br>
<br>
&gt; +#elif defined(__misp16) || defined(__mips_micromips)<br>
&gt; +<br>
&gt; +#error &quot;Unsupported encoding&quot;<br>
<br>
This is incorrectly placed, because we&#39;ve already successfully entered =
the<br>
preceeding #elif defined(__mips__).=C2=A0 This needs to be<br>
<br>
#elif defined(__mips__)<br>
# if defined(__mips16) || defined(__mips_micromips)<br>
#=C2=A0 error<br>
# endif<br>
<br>
int cpu_signal_handler(int host_signum, void *pinfo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *puc)<br>
{<br>
=C2=A0 =C2=A0...<br>
}<br>
<br>
#elif defined(__riscv)<br>
<br>
<br>
<br>
r~<br>
</blockquote></div>

--0000000000005e32b905b01f30d2--

