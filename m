Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60077C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D59320CC7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5Qe4GyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D59320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dxm-0004z8-91
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j9Dwx-0004V2-Av
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 15:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j9Dwu-0001BY-OP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 15:15:31 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e]:45269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j9Dwu-0001BU-GG; Tue, 03 Mar 2020 15:15:28 -0500
Received: by mail-il1-x12e.google.com with SMTP id p8so3933508iln.12;
 Tue, 03 Mar 2020 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x0/OgHW8syNUTp4RdLAXqlwfKECnZr120+Xj23NB9d0=;
 b=Z5Qe4GySC3e3GKdFdX4HkvEddV4zfFQYWOe52RBw0NBHwuE3e1VxyhXobCCevQPVQK
 FrkxnWSbHUuIva3Pxy2gKn3b4DL0IyKjdZs8trDKHPwbFLAuhZ7ecC/9tfe+1PlDa75O
 uR5E6Lyk9dq+Z2KwQsXJdC6ePfwW4hHQIa4g04F8snpMovVVcLgvTGsDJ9syMogromDs
 T8p/L8gukbq/ZeNhw2D5GaJRglsGkwi5rQPYbO5FTBz+WGc+hY9hslUcAC7qPRT7w914
 Qor6ocxAcDS5FOzHvgB2UkIMGrNnj4DAPpExNMqDB+Pa2+0jzJ5j2BHnzdCJvTrQIWQH
 ghQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x0/OgHW8syNUTp4RdLAXqlwfKECnZr120+Xj23NB9d0=;
 b=FHDBpMUuD2BNfC1OthOMdjiZSgigbpKXxed0v6rKAkDxTT+CpKFGvJawmWP3xUZvjn
 Se/ijxnVGQvLOGqHpQOk99QYfi1ErE/patdWRNvgxexUd0o0adWl6z4BfGLdmzK0ATkK
 5eXRQ8AJ+pmnOM67GLTKD8tvjFwDX/nlZXR6RlGwM6bMD18nfbh71XuF+fby4CxzxF95
 FNzO9ssPm0euJzDqvIyjAHpmfLypcLa/rgfIyLtfFoZ6jKjGGvhHBLMpgDuEEPc2KTMS
 WVceLTUquX83cdCk3Fz5GFe7Nu/LFv9tj7gwvxVpI9dSpZV3Cc2A1w9t2VJjGG6xZaBy
 i5wA==
X-Gm-Message-State: ANhLgQ2vGuevTzgMBxxkUNVYiSBKvUq9t1ggiB8Wj5Zcq+cPgDL6Y6qt
 GG/yHqz5QSnROX/5GNlR8ZIKWWrebRWF8wdTbiM=
X-Google-Smtp-Source: ADFU+vvKzcMvYYvzsHq8RkySZjmVUoX0tIlOWq1uh8q/Wg0OyCFnpr+TpkHCeDOJrqUwWchnKH82siG8jpOlMDMlWtA=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr6267383ilq.306.1583266527760; 
 Tue, 03 Mar 2020 12:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-7-nieklinnenbank@gmail.com> <87d09t7i8i.fsf@linaro.org>
In-Reply-To: <87d09t7i8i.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 3 Mar 2020 21:15:16 +0100
Message-ID: <CAPan3Wo6_15zFSHJwf0hVq9CVUSfOBU+frwSLQX21SWrXW03iA@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] hw/arm/allwinner: add CPU Configuration module
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f8d7e3059ff8f6b5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12e
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f8d7e3059ff8f6b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

First thanks for all your reviews, I'll add the tags in the next version of
this series.

On Tue, Mar 3, 2020 at 1:09 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
> > Various Allwinner System on Chip designs contain multiple processors
> > that can be configured and reset using the generic CPU Configuration
> > module interface. This commit adds support for the Allwinner CPU
> > configuration interface which emulates the following features:
> >
> >  * CPU reset
> >  * CPU status
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> <snip>
> > +
> > +/* CPUCFG constants */
> > +enum {
> > +    CPU_EXCEPTION_LEVEL_ON_RESET =3D 3, /* EL3 */
> > +};
> > +
> > +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_i=
d)
> > +{
> > +    int ret;
> > +
> > +    trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
> > +
> > +    ret =3D arm_set_cpu_on(cpu_id, s->entry_addr, 0,
> > +                         CPU_EXCEPTION_LEVEL_ON_RESET, false);
>
> According to the arm_set_cpu_on code:
>
>     if (!target_aa64 && arm_feature(&target_cpu->env,
> ARM_FEATURE_AARCH64)) {
>         /*
>          * For now we don't support booting an AArch64 CPU in AArch32 mod=
e
>          * TODO: We should add this support later
>          */
>         qemu_log_mask(LOG_UNIMP,
>                       "[ARM]%s: Starting AArch64 CPU %" PRId64
>                       " in AArch32 mode is not supported yet\n",
>                       __func__, cpuid);
>         return QEMU_ARM_POWERCTL_INVALID_PARAM;
>     }
>
> Do you really want to reboot in aarch32 mode on a reset? If so we should
> fix the TODO.
>

Very good remark, I'll try to clarify what I did here. In earlier version
of this series, I made this CPU Configuration Module specific
to the Allwinner H3 SoC, as I thought it was a SoC specific component.
Later I discovered that the CPU Configuration Module is
actually a generic Allwinner component and used in multiple SoCs. Taking
that into account, I renamed it to allwinner-cpucfg.c and
updated the comments/docs. That way it should be re-usable in future SoC
modules.

The Allwinner H3 has four ARM Cortex-A7 cores and are 32-bit, so in the
early version I filled the @target_aa64 parameter with false to
keep it in 32-bit mode. And for usage in the current Allwinner H3 SoC that
is sufficient, but as soon as a potential new SoC implementation
with a 64-bit CPU starts to use this module, the hardcoded @target_aa64
parameter will become a problem.

And the TODO inside the arm_set_cpu_on() function I was not yet aware of as
well, so that will also need to be resolved
indeed once this module is going to be used for a new SoC with a 64-bit CPU=
.

Maybe I should just use some function to check if the current emulated CPU
its 32-bit or 64-bit and use that for @target_aa64?
That way the CPU Configuration Module itself should be ready for 64-bit and
the TODO for arm_set_cpu_on() can be
resolved in a later series for newer SoCs.

Regards,
Niek





>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--000000000000f8d7e3059ff8f6b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alex,</div><div><br></div><div>First thanks for al=
l your reviews, I&#39;ll add the tags in the next version of this series.<b=
r></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Mar 3, 2020 at 1:09 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:ale=
x.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; Various Allwinner System on Chip designs contain multiple processors<b=
r>
&gt; that can be configured and reset using the generic CPU Configuration<b=
r>
&gt; module interface. This commit adds support for the Allwinner CPU<br>
&gt; configuration interface which emulates the following features:<br>
&gt;<br>
&gt;=C2=A0 * CPU reset<br>
&gt;=C2=A0 * CPU status<br>
&gt;<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&lt;snip&gt;<br>
&gt; +<br>
&gt; +/* CPUCFG constants */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 CPU_EXCEPTION_LEVEL_ON_RESET =3D 3, /* EL3 */<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_=
id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_cpucfg_cpu_reset(cpu_id, s-&gt;entry_ad=
dr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D arm_set_cpu_on(cpu_id, s-&gt;entry_addr, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0CPU_EXCEPTION_LEVEL_ON_RESET, false);<br>
<br>
According to the arm_set_cpu_on code:<br>
<br>
=C2=A0 =C2=A0 if (!target_aa64 &amp;&amp; arm_feature(&amp;target_cpu-&gt;e=
nv, ARM_FEATURE_AARCH64)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For now we don&#39;t support booting an=
 AArch64 CPU in AArch32 mode<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TODO: We should add this support later<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;[ARM]%s: Starting AArch64 CPU %&quot; PRId64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; in AArch32 mode is not supported yet\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, cpuid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return QEMU_ARM_POWERCTL_INVALID_PARAM;<br>
=C2=A0 =C2=A0 }<br>
<br>
Do you really want to reboot in aarch32 mode on a reset? If so we should<br=
>
fix the TODO.<br></blockquote><div><br></div><div>Very good remark, I&#39;l=
l try to clarify what I did here. In earlier version of this series, I made=
 this CPU Configuration Module specific</div><div>to the Allwinner H3 SoC, =
as I thought it was a SoC specific component. Later I discovered that the C=
PU Configuration Module is</div><div>actually a generic Allwinner component=
 and used in multiple SoCs. Taking that into account, I renamed it to allwi=
nner-cpucfg.c and</div><div>updated the comments/docs. That way it should b=
e re-usable in future SoC modules.<br></div><div><br></div><div>The Allwinn=
er H3 has four ARM Cortex-A7 cores and are 32-bit, so in the early version =
I filled the @target_aa64 parameter with false to</div><div>keep it in 32-b=
it mode. And for usage in the current Allwinner H3 SoC that is sufficient, =
but as soon as a potential new SoC implementation</div><div>with a 64-bit C=
PU starts to use this module, the hardcoded @target_aa64 parameter will bec=
ome a problem.</div><div><br></div><div><div>And the TODO inside the arm_se=
t_cpu_on() function I was not yet aware of as well, so that will also need =
to be resolved</div><div>indeed once this module is going to be used for a =
new SoC with a 64-bit CPU.</div></div><div><br></div><div>Maybe I should ju=
st use some function to check if the current emulated CPU its 32-bit or 64-=
bit and use that for @target_aa64?</div><div>That way the CPU Configuration=
 Module itself should be ready for 64-bit and the TODO for arm_set_cpu_on()=
 can be</div><div>resolved in a later series for newer SoCs.<br></div><div>=
<br></div><div>Regards,</div><div>Niek<br></div><div><br></div><div><br></d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f8d7e3059ff8f6b5--

