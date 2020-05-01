Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E9CC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030212166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csXjXs89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030212166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUb9J-0008Bh-3k
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fintelia@gmail.com>)
 id 1jUb82-0006Vh-9n
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1jUb81-0008U3-KQ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:43233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fintelia@gmail.com>)
 id 1jUb7z-0008NQ-68; Fri, 01 May 2020 15:15:15 -0400
Received: by mail-lf1-x144.google.com with SMTP id 188so4608415lfa.10;
 Fri, 01 May 2020 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LYYG92cKXWRRdl6FS0Vnbmu0dttY95JWQ9/RSNjFx8Y=;
 b=csXjXs89ng6BkbHUq4BHcAxs2eqGYs5t70ze8/Rsi67YHSXTiq5vCJe1ZLAdrW45Ti
 eUXIIYyCCwJq7dRjlhbAGYLttTNAyFKcpc09/sZyODZgWNhrHOMD14AwAWzmXC+rWEQA
 luv2KM0FUX3FOJXeiGMp6rfOsobuIVpZD6D02PHXyu1xgSEVQg4oJnnQYbst5JsAkbFj
 HjAOF8YXM1KzmRELfXWe6amC77hsR68H8d2cZhvKnC5KH57HzYRzRinKAjt9oGaCeObn
 wQMdllXQKaKTV1N8GDG8oyzeLDDRDQEUNP70fb4B189mknXLKTdNGS4A07/aZ0Y4FkQU
 VarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LYYG92cKXWRRdl6FS0Vnbmu0dttY95JWQ9/RSNjFx8Y=;
 b=JYg4WthtskbViMa4WzB/D2UVh1ufo7VTRAOIa08MGNEGHTbfslhqRE9BogyrRfiwuS
 RzNuD4aTllmy/XmFT6MoEXTC3eaPPRdyBpm14BT5RiBPtrvrgHaxwj07Bs4OrsT7hnL5
 7OBnXvqh6HdB6XO3OvZjIG94/QDAzGYxi3U/CNKHLp4NRjMoGL9sWHoXZjUK5IQ9Chow
 JF40uTHtbFiAtJn+82WMPMpWnxoqp0t03/biQEeeyNSMDj4dLy6oliHe4wUTCsm3eyt7
 oxxZBFRLBJE6hm/nWFN3ovvyy8PXYWfce+q1m02C1JGO25H/Ds8uM4BYR8o/Hpejr1MN
 gHdw==
X-Gm-Message-State: AGi0PubtEc0P4+nXjiNlbYilT5mkH4H5VgJL/+v9Su+hwCml9KwVlhYc
 899/1zEJ1agdeuT6cKLElas7u/j3aQU5qPxrVVI=
X-Google-Smtp-Source: APiQypIwG5GQMbIbiF2QyoH0SocC4oZGXOOGPu2uH3OndI0/KwM1pjQGxpKnRHmr/abbpQywwHtO5CAOBbsDLAI/l8k=
X-Received: by 2002:a19:84b:: with SMTP id 72mr2938984lfi.133.1588360512407;
 Fri, 01 May 2020 12:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2LfTQZnor5haAgBg=h34qv50xf8Bs1bgSeGESfr-E2ng@mail.gmail.com>
 <CAKmqyKNMiD6VJ1D-ty-q_HMyiZ7oj7F0XraKTaYy78-xjhAN4A@mail.gmail.com>
 <CAKmqyKO=edmrotcVa_tMO-VcTpdWEq7=0=EYiQquVhqwkS2F=g@mail.gmail.com>
 <CAC41xo1uOy4XVtZqfjAohNHJUfNfDcMKaxGv7dD5uDediQjxiw@mail.gmail.com>
In-Reply-To: <CAC41xo1uOy4XVtZqfjAohNHJUfNfDcMKaxGv7dD5uDediQjxiw@mail.gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Fri, 1 May 2020 15:14:46 -0400
Message-ID: <CANnJOVFOpnP5j79G39ku+0sUng1VdqqvfWF=uDn2+BtfdVWAnw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix check of guest pa top bits
To: Jose Martins <josemartins90@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001e0c0105a49b00c4"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=fintelia@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001e0c0105a49b00c4
Content-Type: text/plain; charset="UTF-8"

Yeah, I've run into the same issue. Even if you ask Gmail to treat the
email as plain text it still takes the liberty of hard wrapping lines
without asking you. It really is a shame that there isn't a good way to
submit patches via a web UI, the art of git send-email + manual SMTP isn't
as widespread as it once was.

Jonathan

On Fri, May 1, 2020 at 2:54 PM Jose Martins <josemartins90@gmail.com> wrote:

> Just resubmitted version 2. Sorry. Not really used to this. I actually
> wasn't using git send-email. I was copying the patch to my email
> client which was causing the weird wrapping. I think I also fixed the
> issues raised by checkpatch. Hope everything is correct now.
>
> Jose
>
> On Thu, 30 Apr 2020 at 22:36, Alistair Francis <alistair23@gmail.com>
> wrote:
> >
> > On Thu, Apr 30, 2020 at 12:45 PM Alistair Francis <alistair23@gmail.com>
> wrote:
> > >
> > > On Fri, Apr 24, 2020 at 8:10 AM Jose Martins <josemartins90@gmail.com>
> wrote:
> > > >
> > > > The spec states that on sv39x4 guest physical  "address bits 63:41
> > > > must all be zeros, or else a guest-page-fault exception occurs.".
> > > > However, the check performed for these top bits of the virtual
> address
> > > > on the second stage is the same as the one performed for virtual
> > > > addresses on the first stage except with the 2-bit extension,
> > > > effectively creating the same kind of "hole" in the guest's physical
> > > > address space. I believe the following patch fixes this issue:
> > > >
> > > > Signed-off-by: Jose Martins <josemartins90@gmail.com>
> > >
> > > Thanks for the patch.
> > >
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > > ---
> > > >  target/riscv/cpu_helper.c | 20 +++++++++++++-------
> > > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > > index d3ba9efb02..da879f5656 100644
> > > > --- a/target/riscv/cpu_helper.c
> > > > +++ b/target/riscv/cpu_helper.c
> > > > @@ -421,15 +421,21 @@ static int get_physical_address(CPURISCVState
> > > > *env, hwaddr *physical,
> > >
> > > There seems to be a strange wrapping here, that corrupts the patch.
> > > For future patches can you please check your git send-email setup?
> > >
> > > Applied to the RISC-V tree with the above line fixed up.
> >
> > This patch also fails checkpatch.
> >
> > Do you mind resending a v2 with the check patch issues fixed?
> >
> > Alistair
> >
> > >
> > > Alistair
> > >
> > > >      int va_bits = PGSHIFT + levels * ptidxbits + widened;
> > > >      target_ulong mask, masked_msbs;
> > > >
> > > > -    if (TARGET_LONG_BITS > (va_bits - 1)) {
> > > > -        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> > > > +    if(!first_stage){
> > > > +        if ((addr >> va_bits) != 0) {
> > > > +            return TRANSLATE_FAIL;
> > > > +        }
> > > >      } else {
> > > > -        mask = 0;
> > > > -    }
> > > > -    masked_msbs = (addr >> (va_bits - 1)) & mask;
> > > > +        if (TARGET_LONG_BITS > (va_bits - 1)) {
> > > > +            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> > > > +        } else {
> > > > +            mask = 0;
> > > > +        }
> > > > +        masked_msbs = (addr >> (va_bits - 1)) & mask;
> > > >
> > > > -    if (masked_msbs != 0 && masked_msbs != mask) {
> > > > -        return TRANSLATE_FAIL;
> > > > +        if (masked_msbs != 0 && masked_msbs != mask) {
> > > > +            return TRANSLATE_FAIL;
> > > > +        }
> > > >      }
> > > >
> > > >      int ptshift = (levels - 1) * ptidxbits;
> > > > --
> > > > 2.17.1
> > > >
> > > > Jose
> > > >
>
>

--0000000000001e0c0105a49b00c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yeah, I&#39;ve run into the same issue. Even if you a=
sk Gmail to treat the email as plain text it still takes the liberty of har=
d wrapping lines without asking you. It really is a shame that there isn&#3=
9;t a good way to submit patches via a web UI, the art of git send-email + =
manual SMTP isn&#39;t as widespread as it once was.</div><div><br></div><di=
v>Jonathan<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Fri, May 1, 2020 at 2:54 PM Jose Martins &lt;<a href=
=3D"mailto:josemartins90@gmail.com">josemartins90@gmail.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Just resubmitted=
 version 2. Sorry. Not really used to this. I actually<br>
wasn&#39;t using git send-email. I was copying the patch to my email<br>
client which was causing the weird wrapping. I think I also fixed the<br>
issues raised by checkpatch. Hope everything is correct now.<br>
<br>
Jose<br>
<br>
On Thu, 30 Apr 2020 at 22:36, Alistair Francis &lt;<a href=3D"mailto:alista=
ir23@gmail.com" target=3D"_blank">alistair23@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Thu, Apr 30, 2020 at 12:45 PM Alistair Francis &lt;<a href=3D"mailt=
o:alistair23@gmail.com" target=3D"_blank">alistair23@gmail.com</a>&gt; wrot=
e:<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Apr 24, 2020 at 8:10 AM Jose Martins &lt;<a href=3D"mailt=
o:josemartins90@gmail.com" target=3D"_blank">josemartins90@gmail.com</a>&gt=
; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The spec states that on sv39x4 guest physical=C2=A0 &quot;ad=
dress bits 63:41<br>
&gt; &gt; &gt; must all be zeros, or else a guest-page-fault exception occu=
rs.&quot;.<br>
&gt; &gt; &gt; However, the check performed for these top bits of the virtu=
al address<br>
&gt; &gt; &gt; on the second stage is the same as the one performed for vir=
tual<br>
&gt; &gt; &gt; addresses on the first stage except with the 2-bit extension=
,<br>
&gt; &gt; &gt; effectively creating the same kind of &quot;hole&quot; in th=
e guest&#39;s physical<br>
&gt; &gt; &gt; address space. I believe the following patch fixes this issu=
e:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Jose Martins &lt;<a href=3D"mailto:josemartin=
s90@gmail.com" target=3D"_blank">josemartins90@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks for the patch.<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.fran=
cis@wdc.com" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 target/riscv/cpu_helper.c | 20 +++++++++++++-------<br=
>
&gt; &gt; &gt;=C2=A0 1 file changed, 13 insertions(+), 7 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_he=
lper.c<br>
&gt; &gt; &gt; index d3ba9efb02..da879f5656 100644<br>
&gt; &gt; &gt; --- a/target/riscv/cpu_helper.c<br>
&gt; &gt; &gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; &gt; &gt; @@ -421,15 +421,21 @@ static int get_physical_address(CPURIS=
CVState<br>
&gt; &gt; &gt; *env, hwaddr *physical,<br>
&gt; &gt;<br>
&gt; &gt; There seems to be a strange wrapping here, that corrupts the patc=
h.<br>
&gt; &gt; For future patches can you please check your git send-email setup=
?<br>
&gt; &gt;<br>
&gt; &gt; Applied to the RISC-V tree with the above line fixed up.<br>
&gt;<br>
&gt; This patch also fails checkpatch.<br>
&gt;<br>
&gt; Do you mind resending a v2 with the check patch issues fixed?<br>
&gt;<br>
&gt; Alistair<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Alistair<br>
&gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 int va_bits =3D PGSHIFT + levels * ptidx=
bits + widened;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mask, masked_msbs;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (TARGET_LONG_BITS &gt; (va_bits - 1)) {<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D (1L &lt;&lt; (TARGET_L=
ONG_BITS - (va_bits - 1))) - 1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if(!first_stage){<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((addr &gt;&gt; va_bits) !=
=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_=
FAIL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 masked_msbs =3D (addr &gt;&gt; (va_bits - 1))=
 &amp; mask;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TARGET_LONG_BITS &gt; (va_b=
its - 1)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D (1L &lt;=
&lt; (TARGET_LONG_BITS - (va_bits - 1))) - 1;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 masked_msbs =3D (addr &gt;&gt; =
(va_bits - 1)) &amp; mask;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (masked_msbs !=3D 0 &amp;&amp; masked_msbs=
 !=3D mask) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_FAIL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (masked_msbs !=3D 0 &amp;&am=
p; masked_msbs !=3D mask) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return TRANSLATE_=
FAIL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ptshift =3D (levels - 1) * ptidxbits=
;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.17.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Jose<br>
&gt; &gt; &gt;<br>
<br>
</blockquote></div>

--0000000000001e0c0105a49b00c4--

