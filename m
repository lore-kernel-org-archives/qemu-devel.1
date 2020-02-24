Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4507EC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F108320836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDjGMPts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F108320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Alf-0003VU-7b
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rajnesh.kanwal49@gmail.com>) id 1j6Al2-0002uD-0r
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rajnesh.kanwal49@gmail.com>) id 1j6Al0-0008N6-5p
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:14:35 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rajnesh.kanwal49@gmail.com>)
 id 1j6Akw-0008Ld-5P; Mon, 24 Feb 2020 05:14:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so8365792wmj.5;
 Mon, 24 Feb 2020 02:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kW2Iwv5I2IH6ujiQvcZh6uDlv3gYNYR4E5TCFd5o3T8=;
 b=ZDjGMPtsQZZV86Uobr0s0EdAZ9root9yQRjBcvUUHMLC9+c4Vw+zFjYIjeS+aaI04j
 wUYDtURIAfvX7odRzEod3vAgL4O5Ifvbgxcf9cntvGoyrYtBfwC+KglRZC14iWTZ4Nm1
 KWm5hEGcc3wHTMALeP/CGWX7Y2R/ykELIKjBySwZbTFHROGIHuXfB3uU3rpe9WO7DNYa
 EOV9WGae02sXK0Rap34vL8fnKXNdF3EBbrCqylPfMgmWmKbuvXs3PdUBUluYdj9Lf+iq
 1OolUV8whMDN6A04NqPDMvUPEiSCzcXKZKWhRV0oIt8hO26H5QgziCgQ2oQWLyziYJ3c
 8kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kW2Iwv5I2IH6ujiQvcZh6uDlv3gYNYR4E5TCFd5o3T8=;
 b=mn+R6cQ5FpTOGntDcEb2t4MlwuLsIStdSOk1yHOHZe1SF7Dwh32VcnAgZHT718iKvu
 9+KQJbiX9AGT9jrM2IWAMhakOdx+kMVm7efPnky34Hh7VHPsfP7QoQPEwLmr7LoOBqAh
 vvHbDs3F99ADbkctoiaBEaQ9D81l8Rpkh5m+eZ8RYuXr+7G6WEnfZRQfdalxJvkOZBHn
 mDGsO/Son+LJa+Z225CR+zbKC7wv9OGOVtNnZQZIHStMkHryJEq5idTFCvVf9vMsJ3tp
 Kd8GH6JU4xtudUaccD6EK9OfEWt4RtobVnCcRfsJdY/B6Hwl558O47SF2EMUh2IXzdxm
 XZVA==
X-Gm-Message-State: APjAAAVZm794bn+lTivxeBTGy3gsDKKJG1+c+yu4FDeyNGmh6bAOFLVn
 HSwWOxvo9XHT01ZRDlSgJkxjNRYEioKWM+S8o4g=
X-Google-Smtp-Source: APXvYqyfB2HWcU0nFopX/MQDidIXK+S5U309RHUwRZtmfCi2/GN0qxOOEOj9U6ydTzW8s0n8axyTPJoHDqxHUEUX9rE=
X-Received: by 2002:a1c:e483:: with SMTP id
 b125mr21836923wmh.187.1582539269008; 
 Mon, 24 Feb 2020 02:14:29 -0800 (PST)
MIME-Version: 1.0
References: <0c4859f90948ba392da456c9e1daf8fde8f5b22e.1582453384.git.rajnesh.kanwal49@gmail.com>
 <CAC41xo0PWCZw4mrcEfRq9fv+b3mSk9sN0mWhFXPwgdD6LR8xnQ@mail.gmail.com>
 <CAHfcQ+GGCXj6f+PMMvqNhg=Lzpi1Ke+OaEO6-pb5gjSngm3Upg@mail.gmail.com>
 <CAC41xo0V_F4ExJjoYx4AWQXViX-WwgfFx219EyCb8mk-okKUAQ@mail.gmail.com>
In-Reply-To: <CAC41xo0V_F4ExJjoYx4AWQXViX-WwgfFx219EyCb8mk-okKUAQ@mail.gmail.com>
From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Date: Mon, 24 Feb 2020 15:13:31 +0500
Message-ID: <CAHfcQ+Fw_mEAyGXwry8_jdXBJcMoV3-x8T61oypzQ3_-1Tn_Pw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
To: Jose Martins <josemartins90@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f8f4ce059f4fa277"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

--000000000000f8f4ce059f4fa277
Content-Type: text/plain; charset="UTF-8"

Nice catch. You are right. I was a bit confused after looking at current
xvisor and KVM port. They are delegating S mode interrupts to VS mode, as
per my understanding after looking at
https://github.com/kvm-riscv/linux/blob/riscv_kvm_master/arch/riscv/kvm/main.c
line no. 34. I will see if there is a way to decline a patch.

Thanks for pointing that out.
Regards,
Rajnesh

On Sun, Feb 23, 2020 at 8:40 PM Jose Martins <josemartins90@gmail.com>
wrote:

> No problem. But I'm failing to see what you mean. My reasoning was:
> the specification mandates that only VS mode interrupt bits are
> writable in hideleg, all the others must be hardwired to zero. This
> means the hypervisor can't really delegate S mode interrupts as you
> are saying. So, if this is implemented correctly, you will never get
> inside that if condition because of an HS interrupt. And all
> delegatable asynchronous exception values must be decremented. So,
> checking if this is an async exception should do the job.
>
> Jose
>
> On Sun, 23 Feb 2020 at 15:10, Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> wrote:
> >
> > Hello Jose,
> >
> > Sorry I didn't see that as it hadn't became a part of the port. I don't
> know how
> > they proceed with same patches.
> >
> > Just to add, there is a minor problem with your patch. The cause value
> should
> > only be decremented by one for VS mode interrupts. In case if hypervisor
> has
> > delegated S mode interrupts then we should not decrement cause for those
> > interrupts.
> >
> > Regards,
> > Rajnesh
> >
> >
> > On Sun, Feb 23, 2020 at 7:41 PM Jose Martins <josemartins90@gmail.com>
> wrote:
> >>
> >> Hello rajnesh,
> >>
> >> I had already submitted almost this exact patch a few weeks ago.
> >>
> >> Jose
> >>
> >> On Sun, 23 Feb 2020 at 13:51, <rajnesh.kanwal49@gmail.com> wrote:
> >> >
> >> > From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> >> >
> >> > Currently riscv_cpu_local_irq_pending is used to find out pending
> >> > interrupt and VS mode interrupts are being shifted to represent
> >> > S mode interrupts in this function. So when the cause returned by
> >> > this function is passed to riscv_cpu_do_interrupt to actually
> >> > forward the interrupt, the VS mode forwarding check does not work
> >> > as intended and interrupt is actually forwarded to hypervisor. This
> >> > patch fixes this issue.
> >> >
> >> > Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> >> > ---
> >> >  target/riscv/cpu_helper.c | 9 ++++++++-
> >> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >> > index b9e90dfd9a..59535ecba6 100644
> >> > --- a/target/riscv/cpu_helper.c
> >> > +++ b/target/riscv/cpu_helper.c
> >> > @@ -46,7 +46,7 @@ static int
> riscv_cpu_local_irq_pending(CPURISCVState *env)
> >> >      target_ulong pending = env->mip & env->mie &
> >> >                                 ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
> >> >      target_ulong vspending = (env->mip & env->mie &
> >> > -                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP))
> >> 1;
> >> > +                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
> >> >
> >> >      target_ulong mie    = env->priv < PRV_M ||
> >> >                            (env->priv == PRV_M && mstatus_mie);
> >> > @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >> >
> >> >              if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) &
> 1) &&
> >> >                  !force_hs_execp) {
> >> > +                /*
> >> > +                 * See if we need to adjust cause. Yes if its VS
> mode interrupt
> >> > +                 * no if hypervisor has delegated one of hs mode's
> interrupt
> >> > +                 */
> >> > +                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
> >> > +                    cause == IRQ_VS_EXT)
> >> > +                    cause = cause - 1;
> >> >                  /* Trap to VS mode */
> >> >              } else if (riscv_cpu_virt_enabled(env)) {
> >> >                  /* Trap into HS mode, from virt */
> >> > --
> >> > 2.17.1
> >> >
> >> >
>

--000000000000f8f4ce059f4fa277
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Nice catch. You are right. I was a bit conf=
used after looking at current xvisor and KVM port. They are delegating S mo=
de interrupts to VS mode, as per my understanding after looking at <a href=
=3D"https://github.com/kvm-riscv/linux/blob/riscv_kvm_master/arch/riscv/kvm=
/main.c">https://github.com/kvm-riscv/linux/blob/riscv_kvm_master/arch/risc=
v/kvm/main.c</a> line no. 34. I will see if there is a way to decline a pat=
ch. <br><br></div>Thanks for pointing that out.<br></div>Regards,<br></div>=
Rajnesh<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Sun, Feb 23, 2020 at 8:40 PM Jose Martins &lt;<a href=3D"mail=
to:josemartins90@gmail.com">josemartins90@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">No problem. But I&#39;m =
failing to see what you mean. My reasoning was:<br>
the specification mandates that only VS mode interrupt bits are<br>
writable in hideleg, all the others must be hardwired to zero. This<br>
means the hypervisor can&#39;t really delegate S mode interrupts as you<br>
are saying. So, if this is implemented correctly, you will never get<br>
inside that if condition because of an HS interrupt. And all<br>
delegatable asynchronous exception values must be decremented. So,<br>
checking if this is an async exception should do the job.<br>
<br>
Jose<br>
<br>
On Sun, 23 Feb 2020 at 15:10, Rajnesh Kanwal &lt;<a href=3D"mailto:rajnesh.=
kanwal49@gmail.com" target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt; Hello Jose,<br>
&gt;<br>
&gt; Sorry I didn&#39;t see that as it hadn&#39;t became a part of the port=
. I don&#39;t know how<br>
&gt; they proceed with same patches.<br>
&gt;<br>
&gt; Just to add, there is a minor problem with your patch. The cause value=
 should<br>
&gt; only be decremented by one for VS mode interrupts. In case if hypervis=
or has<br>
&gt; delegated S mode interrupts then we should not decrement cause for tho=
se<br>
&gt; interrupts.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Rajnesh<br>
&gt;<br>
&gt;<br>
&gt; On Sun, Feb 23, 2020 at 7:41 PM Jose Martins &lt;<a href=3D"mailto:jos=
emartins90@gmail.com" target=3D"_blank">josemartins90@gmail.com</a>&gt; wro=
te:<br>
&gt;&gt;<br>
&gt;&gt; Hello rajnesh,<br>
&gt;&gt;<br>
&gt;&gt; I had already submitted almost this exact patch a few weeks ago.<b=
r>
&gt;&gt;<br>
&gt;&gt; Jose<br>
&gt;&gt;<br>
&gt;&gt; On Sun, 23 Feb 2020 at 13:51, &lt;<a href=3D"mailto:rajnesh.kanwal=
49@gmail.com" target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt; wrote:<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From: Rajnesh Kanwal &lt;<a href=3D"mailto:rajnesh.kanwal49@g=
mail.com" target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Currently riscv_cpu_local_irq_pending is used to find out pen=
ding<br>
&gt;&gt; &gt; interrupt and VS mode interrupts are being shifted to represe=
nt<br>
&gt;&gt; &gt; S mode interrupts in this function. So when the cause returne=
d by<br>
&gt;&gt; &gt; this function is passed to riscv_cpu_do_interrupt to actually=
<br>
&gt;&gt; &gt; forward the interrupt, the VS mode forwarding check does not =
work<br>
&gt;&gt; &gt; as intended and interrupt is actually forwarded to hypervisor=
. This<br>
&gt;&gt; &gt; patch fixes this issue.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rajnesh.k=
anwal49@gmail.com" target=3D"_blank">rajnesh.kanwal49@gmail.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 target/riscv/cpu_helper.c | 9 ++++++++-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_hel=
per.c<br>
&gt;&gt; &gt; index b9e90dfd9a..59535ecba6 100644<br>
&gt;&gt; &gt; --- a/target/riscv/cpu_helper.c<br>
&gt;&gt; &gt; +++ b/target/riscv/cpu_helper.c<br>
&gt;&gt; &gt; @@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPUR=
ISCVState *env)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong pending =3D env-&gt;mip &amp=
; env-&gt;mie &amp;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~(MIP_VSSIP | MIP_V=
STIP | MIP_VSEIP);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong vspending =3D (env-&gt;mip &=
amp; env-&gt;mie &amp;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MIP_VSSIP | MIP_VSTIP | MIP_=
VSEIP)) &gt;&gt; 1;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MIP_VSSIP | MIP_VSTIP | MIP_=
VSEIP));<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mie=C2=A0 =C2=A0 =3D env-&gt=
;priv &lt; PRV_M ||<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;priv =3D=3D PRV_M &amp;&amp; m=
status_mie);<br>
&gt;&gt; &gt; @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs=
)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu=
_virt_enabled(env) &amp;&amp; ((hdeleg &gt;&gt; cause) &amp; 1) &amp;&amp;<=
br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 !force_hs_execp) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<b=
r>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* See if we need to adjust cause. Yes if its VS mode interrupt<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* no if hypervisor has delegated one of hs mode&#39;s interrupt<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*/<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
cause =3D=3D IRQ_VS_TIMER || cause =3D=3D IRQ_VS_SOFT ||<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cause =3D=3D IRQ_VS_EXT)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cause =3D cause - 1;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* Trap to VS mode */<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ri=
scv_cpu_virt_enabled(env)) {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* Trap into HS mode, from virt */<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.17.1<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
</blockquote></div>

--000000000000f8f4ce059f4fa277--

