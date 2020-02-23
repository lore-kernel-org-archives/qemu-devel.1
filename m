Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B5C35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 15:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C37220675
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt2p4bkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C37220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5sv8-0007ZJ-Dx
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 10:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rajnesh.kanwal49@gmail.com>) id 1j5suN-000743-3K
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rajnesh.kanwal49@gmail.com>) id 1j5suL-0004KD-Qs
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:11:03 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rajnesh.kanwal49@gmail.com>)
 id 1j5suI-0004JG-Mk; Sun, 23 Feb 2020 10:10:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id r11so7397244wrq.10;
 Sun, 23 Feb 2020 07:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X9+Mkqc6EcEgTtDLf7Wuh9ccIURejMBb0nCY+JWCJMc=;
 b=kt2p4bkOEmJj7UbHAUxXvwn19bOpoa53d5KG3kU9Un2WceKjgQ78ZnSUGSd5lNHg65
 zggLAGNEZ1jC0T0bcHc0+GCFzqnAdkNBomF/s5oPFQDbD7pQQUzE883Ntu2N1NFI3k+c
 ijyNeunt6itRoUejsQm/EtcqfXwtgeoBh2gUg9M7+A6hCy1me7Y2NMyPIQlJk5z0oZ/O
 CJ0jtjHWBQgp/SXxh4MvvL72fKe+iP1DI2wOa/SVTMNYmDEFJRcPpWm5dDBr0swwjwZV
 tt7q8Myfj6Ef8tLKdcp9L7f1UqjYAvwQ/KjGxj9pMJ0lahcNnJKP6yrI+KNsfMo42w6W
 gUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X9+Mkqc6EcEgTtDLf7Wuh9ccIURejMBb0nCY+JWCJMc=;
 b=m712+gR3IjPbrX/NEjQyom22wZAyIfKeKOM+kpG9ivPPcdOQ64Ok63FZCvMCdmPdYF
 0TZyaqx5X9IN/tyIk+0CHGC6/TQz5WisyR4vyWmsxaD8SxPV4EBZWA3cHSZbosZuKPG8
 4yoKzroM12Ff8h+2Go/tn7FLovGipdH+J6orjUaHVvS+C4E1x2KytF2bMsDrIZs9R12r
 GkPPt4AyRYWTaTlSkcDu3j6SbwgO1OXw69pa7olhNQiTQNToY1MXOEZ9BrWwncR2gB5a
 d2ECrL2LYUyQtcTRWEGBUjdBYnk25VZoyoqgRLAg2ATHaTRQuShukD8BfOW0lP8b0NGI
 EgiA==
X-Gm-Message-State: APjAAAU6iNqX1aWRvd+QG0YlTn7KRHAs4JfuOxTw7uFaKKCVOkDTaJ9Z
 HptHYT5Vyn0XhQR0Ya2AzLz0pmxMPeeup7pLRWE=
X-Google-Smtp-Source: APXvYqzjrrJVymJwcUL2vCKYKu3RYxTo+WGze3YfUCyF2dr7hjkCRVfYxgabt5Yl9t/zNKZTgHVXAcBEYy50sTulA74=
X-Received: by 2002:a5d:6390:: with SMTP id p16mr63637635wru.170.1582470657089; 
 Sun, 23 Feb 2020 07:10:57 -0800 (PST)
MIME-Version: 1.0
References: <0c4859f90948ba392da456c9e1daf8fde8f5b22e.1582453384.git.rajnesh.kanwal49@gmail.com>
 <CAC41xo0PWCZw4mrcEfRq9fv+b3mSk9sN0mWhFXPwgdD6LR8xnQ@mail.gmail.com>
In-Reply-To: <CAC41xo0PWCZw4mrcEfRq9fv+b3mSk9sN0mWhFXPwgdD6LR8xnQ@mail.gmail.com>
From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Date: Sun, 23 Feb 2020 20:10:03 +0500
Message-ID: <CAHfcQ+GGCXj6f+PMMvqNhg=Lzpi1Ke+OaEO6-pb5gjSngm3Upg@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
To: Jose Martins <josemartins90@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000622588059f3fa975"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: alistair.francis@wdc.com, palmerdabbelt@google.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000622588059f3fa975
Content-Type: text/plain; charset="UTF-8"

Hello Jose,

Sorry I didn't see that as it hadn't became a part of the port. I don't
know how
they proceed with same patches.

Just to add, there is a minor problem with your patch. The cause value
should
only be decremented by one for VS mode interrupts. In case if hypervisor has
delegated S mode interrupts then we should not decrement cause for those
interrupts.

Regards,
Rajnesh


On Sun, Feb 23, 2020 at 7:41 PM Jose Martins <josemartins90@gmail.com>
wrote:

> Hello rajnesh,
>
> I had already submitted almost this exact patch a few weeks ago.
>
> Jose
>
> On Sun, 23 Feb 2020 at 13:51, <rajnesh.kanwal49@gmail.com> wrote:
> >
> > From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> >
> > Currently riscv_cpu_local_irq_pending is used to find out pending
> > interrupt and VS mode interrupts are being shifted to represent
> > S mode interrupts in this function. So when the cause returned by
> > this function is passed to riscv_cpu_do_interrupt to actually
> > forward the interrupt, the VS mode forwarding check does not work
> > as intended and interrupt is actually forwarded to hypervisor. This
> > patch fixes this issue.
> >
> > Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> > ---
> >  target/riscv/cpu_helper.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index b9e90dfd9a..59535ecba6 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState
> *env)
> >      target_ulong pending = env->mip & env->mie &
> >                                 ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> >      target_ulong vspending = (env->mip & env->mie &
> > -                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
> > +                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
> >
> >      target_ulong mie    = env->priv < PRV_M ||
> >                            (env->priv == PRV_M && mstatus_mie);
> > @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >
> >              if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1)
> &&
> >                  !force_hs_execp) {
> > +                /*
> > +                 * See if we need to adjust cause. Yes if its VS mode
> interrupt
> > +                 * no if hypervisor has delegated one of hs mode's
> interrupt
> > +                 */
> > +                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
> > +                    cause == IRQ_VS_EXT)
> > +                    cause = cause - 1;
> >                  /* Trap to VS mode */
> >              } else if (riscv_cpu_virt_enabled(env)) {
> >                  /* Trap into HS mode, from virt */
> > --
> > 2.17.1
> >
> >
>

--000000000000622588059f3fa975
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Jose,</div><div><br></div><div>Sorry I didn&#39=
;t see that as it hadn&#39;t became a part of the port. I don&#39;t know ho=
w <br></div><div>they proceed with same patches.<br><br> Just to add, there=
 is a minor problem with your patch. The cause value should <br>only be dec=
remented by one for VS mode interrupts. In case if hypervisor has</div><div=
> delegated S mode interrupts then we should not decrement cause for those<=
/div><div> interrupts.<br></div><div><br></div><div>Regards,<br></div><div>=
Rajnesh<br></div><div><br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 23, 2020 at 7:41 PM Jose Martin=
s &lt;<a href=3D"mailto:josemartins90@gmail.com">josemartins90@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hel=
lo rajnesh,<br>
<br>
I had already submitted almost this exact patch a few weeks ago.<br>
<br>
Jose<br>
<br>
On Sun, 23 Feb 2020 at 13:51, &lt;<a href=3D"mailto:rajnesh.kanwal49@gmail.=
com" target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Rajnesh Kanwal &lt;<a href=3D"mailto:rajnesh.kanwal49@gmail.com"=
 target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Currently riscv_cpu_local_irq_pending is used to find out pending<br>
&gt; interrupt and VS mode interrupts are being shifted to represent<br>
&gt; S mode interrupts in this function. So when the cause returned by<br>
&gt; this function is passed to riscv_cpu_do_interrupt to actually<br>
&gt; forward the interrupt, the VS mode forwarding check does not work<br>
&gt; as intended and interrupt is actually forwarded to hypervisor. This<br=
>
&gt; patch fixes this issue.<br>
&gt;<br>
&gt; Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rajnesh.kanwal49@g=
mail.com" target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/cpu_helper.c | 9 ++++++++-<br>
&gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index b9e90dfd9a..59535ecba6 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState=
 *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong pending =3D env-&gt;mip &amp; env-&gt=
;mie &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~(MIP_VSSIP | MIP_VSTIP | M=
IP_VSEIP);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong vspending =3D (env-&gt;mip &amp; env-=
&gt;mie &amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) &g=
t;&gt; 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mie=C2=A0 =C2=A0 =3D env-&gt;priv &lt=
; PRV_M ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;priv =3D=3D PRV_M &amp;&amp; mstatus_m=
ie);<br>
&gt; @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_virt_ena=
bled(env) &amp;&amp; ((hdeleg &gt;&gt; cause) &amp; 1) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !force_h=
s_execp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* See i=
f we need to adjust cause. Yes if its VS mode interrupt<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* no if=
 hypervisor has delegated one of hs mode&#39;s interrupt<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cause =3D=
=3D IRQ_VS_TIMER || cause =3D=3D IRQ_VS_SOFT ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cause =3D=3D IRQ_VS_EXT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cause =3D cause - 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Trap =
to VS mode */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (riscv_cpu_v=
irt_enabled(env)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Trap =
into HS mode, from virt */<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000622588059f3fa975--

