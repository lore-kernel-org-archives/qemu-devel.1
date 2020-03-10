Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40460C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0305120873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSVooyEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0305120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBkbD-0004cf-5P
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBka0-0003lh-SW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBkZy-0006t4-Tr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:30:16 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131]:43642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBkZx-0006od-3r; Tue, 10 Mar 2020 15:30:13 -0400
Received: by mail-il1-x131.google.com with SMTP id o18so13069857ilg.10;
 Tue, 10 Mar 2020 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ec4zzvCEIRAZ5xfSFujdt3O/MmVFFCSSaTkJNA0Gesk=;
 b=JSVooyEe2SRDrMNSu6eJ2ilSaVUqiDJJHEPU88wdpKdlsC8RBu3Ku/TKIDJRCH69AY
 rL1HfDg4T+0ffEuw6s27icwmR+46ArMPYyM5zM44aacjqwCf+QZNeSHzgqviWtNN8/rU
 Q7urx5INqAt0aIR6r3GKVaViXS916KjyfQRN413Z+IruFnDjieUZAqEziOwBG1g9neQZ
 0Rb/Mls/rv66pjP1AHa+MlbI1YjbOapgIWqc65VlTWCLHQljxFj7qtaD0kxKa5Y1hDaJ
 MYUyMQIielUOJux43X2KGqbeeZ56WyX2G4rzkNksWkHHDlbs4xTSSpE91NnmozrndbOX
 ibZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ec4zzvCEIRAZ5xfSFujdt3O/MmVFFCSSaTkJNA0Gesk=;
 b=DKANm1WiwPzPx7jvIYmwD5MjwmoKu75o80M017mORPeJNioXFXO8KOWfyOM6jped/J
 U28Gs3AuICdkGgQglirxvxUzITKmkkANbWPh2UqyiTEAou3TEQp/N3qa62+zSgJnhavN
 0Q4OeBOhZ4I5ryUbHXoJb5agJj3YyUn7fgDTsu6aruCjDNx66Z8NuMazRNVFXyrI+qeN
 LwK/ASYXVzet31Z006aErPYHHoJIAgFbH6aqrj8YeoArvfYEwqrekOV3k8FV9unt8fR6
 +bNTknnXoJBeJGbuKBZu2La3dzjv1SllAO97jjWlpbFBs8WBKcqbIn2qSU7rILB/Q9wP
 I0Dg==
X-Gm-Message-State: ANhLgQ14AwQrKoHQ7D92Ai91PbsFEVFqTFhfFyXk5CFz8hywxa0NMNdV
 ViBKOTFe8MyjpK+4sVbRkWHZ5D4cbL4ISkqoWsQ=
X-Google-Smtp-Source: ADFU+vtVDIkIb5z7RR8jJzmALdrRQn05cTcgu3CPKp3sK97WzjtLn+6ei218QLPZFovuMtjdfgbw+mAhrJJXYQJMNO8=
X-Received: by 2002:a92:5f45:: with SMTP id t66mr21962193ilb.28.1583868611206; 
 Tue, 10 Mar 2020 12:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-7-nieklinnenbank@gmail.com> <87d09t7i8i.fsf@linaro.org>
 <CAPan3Wo6_15zFSHJwf0hVq9CVUSfOBU+frwSLQX21SWrXW03iA@mail.gmail.com>
 <CAFEAcA_wTrqgAh+NK5jmtqPeU9y6bhouzaXWQyPR_iYU5waOGg@mail.gmail.com>
In-Reply-To: <CAFEAcA_wTrqgAh+NK5jmtqPeU9y6bhouzaXWQyPR_iYU5waOGg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 20:30:00 +0100
Message-ID: <CAPan3WpVsb0=gpdghsuhmnKc1CTXi8n1A7xfW=NsTpav9RNCLA@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] hw/arm/allwinner: add CPU Configuration module
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f1241905a085253d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::131
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f1241905a085253d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2020 at 12:18 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 3 Mar 2020 at 20:15, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> > On Tue, Mar 3, 2020 at 1:09 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
>
> wrote:
> >> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
> >> > +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t
> cpu_id)
> >> > +{
> >> > +    int ret;
> >> > +
> >> > +    trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
> >> > +
> >> > +    ret =3D arm_set_cpu_on(cpu_id, s->entry_addr, 0,
> >> > +                         CPU_EXCEPTION_LEVEL_ON_RESET, false);
> >>
> >> According to the arm_set_cpu_on code:
> >>
> >>     if (!target_aa64 && arm_feature(&target_cpu->env,
> ARM_FEATURE_AARCH64)) {
> >>         /*
> >>          * For now we don't support booting an AArch64 CPU in AArch32
> mode
> >>          * TODO: We should add this support later
> >>          */
> >>         qemu_log_mask(LOG_UNIMP,
> >>                       "[ARM]%s: Starting AArch64 CPU %" PRId64
> >>                       " in AArch32 mode is not supported yet\n",
> >>                       __func__, cpuid);
> >>         return QEMU_ARM_POWERCTL_INVALID_PARAM;
> >>     }
> >>
> >> Do you really want to reboot in aarch32 mode on a reset? If so we shou=
ld
> >> fix the TODO.
> >
> > The Allwinner H3 has four ARM Cortex-A7 cores and are 32-bit, so in the
> > early version I filled the @target_aa64 parameter with false to
> > keep it in 32-bit mode. And for usage in the current Allwinner H3 SoC
> > that is sufficient, but as soon as a potential new SoC implementation
> > with a 64-bit CPU starts to use this module, the hardcoded @target_aa64
> > parameter will become a problem.
>
> > Maybe I should just use some function to check if the current emulated
> > CPU its 32-bit or 64-bit and use that for @target_aa64?
>
> If the intended behaviour is "just power on the CPU into EL3
> in the aarch32/aarch64 state it would naturally have out of reset"
> then you can get the right value to pass to target_aa64 like this:
>
>    ARMCPU *target_cpu =3D ARM_CPU(arm_get_cpu_by_id(cpu_id));
>
>    if (!target_cpu) {
>        /*
>         * handle the case of "guest wrote bogus value to RST_CTRL
>         * field, probably by returning doing nothing
>         */
>    }
>    target_aa64 =3D arm_feature(&target_cpu->env, ARM_FEATURE_AARCH64);
>
>
Thanks for explaining Peter. This solution is working fine. I'm including
it in the v7 respin.

Regards,
Niek


> Or if the required behaviour for a 64-bit CPU is more complicated
> you can just assert or something with a comment that this would need
> updating if we ever modelled a 64-bit Allwinner SoC.
>
> thanks
> -- PMM
>


--=20
Niek Linnenbank

--000000000000f1241905a085253d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 at 12:18 PM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Tue, 3 Mar 2020 at 20:15, Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; =
wrote:<br>
&gt; On Tue, Mar 3, 2020 at 1:09 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wr=
ote:<br>
&gt;&gt; Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" ta=
rget=3D"_blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
&gt;&gt; &gt; +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uin=
t8_t cpu_id)<br>
&gt;&gt; &gt; +{<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 int ret;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 trace_allwinner_cpucfg_cpu_reset(cpu_id, s-&gt=
;entry_addr);<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 ret =3D arm_set_cpu_on(cpu_id, s-&gt;entry_add=
r, 0,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU_EXCEPTION_LEVEL_ON_RESET, false);<br>
&gt;&gt;<br>
&gt;&gt; According to the arm_set_cpu_on code:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0if (!target_aa64 &amp;&amp; arm_feature(&amp;ta=
rget_cpu-&gt;env, ARM_FEATURE_AARCH64)) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * For now we don&#39;t support b=
ooting an AArch64 CPU in AArch32 mode<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * TODO: We should add this suppo=
rt later<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;[ARM]%s: Starting AArch64 CPU %&quot; PRId64<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot; in AArch32 mode is not supported yet\n&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0__func__, cpuid);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return QEMU_ARM_POWERCTL_INVALID_=
PARAM;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; Do you really want to reboot in aarch32 mode on a reset? If so we =
should<br>
&gt;&gt; fix the TODO.<br>
&gt;<br>
&gt; The Allwinner H3 has four ARM Cortex-A7 cores and are 32-bit, so in th=
e<br>
&gt; early version I filled the @target_aa64 parameter with false to<br>
&gt; keep it in 32-bit mode. And for usage in the current Allwinner H3 SoC<=
br>
&gt; that is sufficient, but as soon as a potential new SoC implementation<=
br>
&gt; with a 64-bit CPU starts to use this module, the hardcoded @target_aa6=
4<br>
&gt; parameter will become a problem.<br>
<br>
&gt; Maybe I should just use some function to check if the current emulated=
<br>
&gt; CPU its 32-bit or 64-bit and use that for @target_aa64?<br>
<br>
If the intended behaviour is &quot;just power on the CPU into EL3<br>
in the aarch32/aarch64 state it would naturally have out of reset&quot;<br>
then you can get the right value to pass to target_aa64 like this:<br>
<br>
=C2=A0 =C2=A0ARMCPU *target_cpu =3D ARM_CPU(arm_get_cpu_by_id(cpu_id));<br>
<br>
=C2=A0 =C2=A0if (!target_cpu) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * handle the case of &quot;guest wrote bogus va=
lue to RST_CTRL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * field, probably by returning doing nothing<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0target_aa64 =3D arm_feature(&amp;target_cpu-&gt;env, ARM_FEATU=
RE_AARCH64);<br>
<br></blockquote><div><br></div><div>Thanks for explaining Peter. This solu=
tion is working fine. I&#39;m including it in the v7 respin.</div><div><br>=
</div><div>Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Or if the required behaviour for a 64-bit CPU is more complicated<br>
you can just assert or something with a comment that this would need<br>
updating if we ever modelled a 64-bit Allwinner SoC.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f1241905a085253d--

