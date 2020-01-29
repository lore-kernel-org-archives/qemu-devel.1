Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB68C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3646C206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR8JMcsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3646C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpN0-0005CS-6h
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iwpME-0004lU-5U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iwpMB-0000sM-Bz
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:34:22 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a]:43774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iwpMB-0000q0-7C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:34:19 -0500
Received: by mail-qk1-x72a.google.com with SMTP id j20so17381604qka.10
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4qy8ST0BdalimhpIa5QN0/h5YE3vT29K+fjPkcYNBeE=;
 b=JR8JMcsDgKSrb6shJ6v2++pe2BiForm6tdnRMNiXaHz9SVsEcM8Mu8M/DKnxBbidHl
 TJrsk5WHdiAYlzp9l/QhNB2R5GzeMMTCBc4Pw6bdfeJAJCX3RcmWFXBrkm/B5CzoC1LA
 OI5RGtUKN5ZCL3+HEFOmzwmqMa7s73W0tjMCIIhN5EW9oQdVuRNQnIwVVXzPN1bVHI4L
 bOTdzeUf9xl/c6ZFnw825wwVVLEjKQcSGDyaRz3axQ+/jW/8w6Nd1qc0PtBdFMYc45XY
 pKl3364yImUUutMWBQmqAuZfSx5LDkTYP32CpzSOeY++/byZ7HD1VYXQ3L1WZqJwHO3b
 4BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4qy8ST0BdalimhpIa5QN0/h5YE3vT29K+fjPkcYNBeE=;
 b=lEEPcE2rjx5PmQxRYwclNYiaYIfVE/REuU76zymMsboZJB8HvnTCkZB9Xhpf+lXppe
 kNdSmAvNSvz4TCSGX/qCEKP+WKCWv2s4fvObkWBYjt57EgmKeb8JOQDYT0wyMAfvxywj
 8UU22o4SgAZHDShCWV/pvVXUsLl1ghtAH5XoGFnykNe9EvwTJaRh6iqYTHSSsl0cySV1
 WlJH36BmjX1MXRPCV8WifbEpeLqz0kOW7FFJ8UNOkSVV+Mg1Kn3lAwXUTmhFP1BwM+tS
 EHngIjMdPwEfrf23ORZLNvjEEifxh3PmupcL8c9ys0jJvWr9C4gE/3uCbBwHMlX+Z7w8
 c5kg==
X-Gm-Message-State: APjAAAVzsFxkH+ZxqlcA0+DPrZq2mspP3nzUtSKZLUJ5DnKCTIFqqNTO
 zQNX4uLfknAMc1cNbrFiulMZVrraA9nd1aYqgn0=
X-Google-Smtp-Source: APXvYqw2p0T4W5jxFmQ870WAOAMpUqegbh7BwGML3e6wdBC1TmHoG2/H8tW63PuOehFJHmE1Iz1dMYZPeLb99eXzJhs=
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr230636qkl.378.1580312058293; 
 Wed, 29 Jan 2020 07:34:18 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200129122058.3714c0c4195afc62fc0ce297@kent.ac.uk>
 <CAL1e-=g=6zXB6pW4XYJ_NXYe4tu43N4DSUBPw=tJPqT1WvKCqg@mail.gmail.com>
In-Reply-To: <CAL1e-=g=6zXB6pW4XYJ_NXYe4tu43N4DSUBPw=tJPqT1WvKCqg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 29 Jan 2020 17:34:06 +0200
Message-ID: <CAK4993hnLhdapLxrwGVWYJ21Sr2tbMG1g4ye9h1LU0Pyg6VmVg@mail.gmail.com>
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000de70f6059d491205"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72a
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "S.Harris" <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Sarah Harris <seh53@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000de70f6059d491205
Content-Type: text/plain; charset="UTF-8"

Sounds good.

Sent from my cell phone, please ignore typos

On Wed, Jan 29, 2020, 5:12 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> On Wed, Jan 29, 2020 at 1:20 PM Sarah Harris <seh53@kent.ac.uk> wrote:
> >
> > Hi,
> >
> > I think I've found a minor bug: the stack pointer should be initialised
> to the size of SRAM in some or most cases.
> > Currently, SP is initialised to zero.
> >
>
> Very good (that you spotted the bug)!
>
> > It seems modern AVRs set SP to the size of SRAM (RAMEND) at power-on,
> though a few older ones initialise to zero.
> > The ATmega328 (from 2009) [1], ATmega2560 (from 2005) [2], ATtiny2313
> (from 2003) [6], and ATtiny85 (from 2005) [3] all use RAMEND.
> > The ATmega8 (from 2001) [4], ATmega8535 (from 2002) [5], and AT90S8535
> (from 1998) [7] use zero.
>
> It looks we'll have tremendous "fun" dealing with huge variety of AVR SoCs.
>
> > I haven't found a list of which AVRs use which value (other than reading
> every datasheet).
>
> Yes, I find this to be a big practical problem, this glaring lack of
> some summary documentation, and, unfortunately, this affects not only
> this particular case (SP initialization). It appears to me that for
> many features and details (especially regarding SoC devices) one will
> have to carefully examine multiple documents, as you did in this
> email.
>
> >
> > Given that GCC performs this initialisation in software anyway (so what
> the hardware does doesn't matter), I think this is a minor issue.
> > It will only affect hand written assembly programs that don't do their
> own initialisation (which seems to be discouraged as not all resets are
> power-on events).
> > I'm not sure what, if anything, needs to be done about it but it might
> be worth fixing now we're emulating specific chips.
> >
>
> Let's think a little bit about it. In my honest opinion, this may be
> handled after the series merge, and if you guys agree, there is no
> rush.
>
> > Kind regards,
> > Sarah Harris
> >
>
> Thanks!
> Aleksandar
>
> > [1]
> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf
> (section 6.5.1)
> > [2]
> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
> (section 7.6)
> > [3]
> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf
> (section 4.6.1)
> > [4]
> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2486-8-bit-AVR-microcontroller-ATmega8_L_datasheet.pdf
> (page 13)
> > [5] http://ww1.microchip.com/downloads/en/DeviceDoc/doc2502.pdf (page
> 12)
> > [6]
> http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2543-AVR-ATtiny2313_Datasheet.pdf
> (page 11)
> > [7] http://ww1.microchip.com/downloads/en/DeviceDoc/doc1041.pdf (page
> 20)
> >
> > On Sun, 26 Jan 2020 23:54:43 +0100
> > Aleksandar Markovic <aleksandar.markovic@rt-rk.com> wrote:
> >
> > > +static void avr_cpu_reset(CPUState *cs)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(cs);
> > > +    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    mcc->parent_reset(cs);
> > > +
> > > +    env->pc_w = 0;
> > > +    env->sregI = 1;
> > > +    env->sregC = 0;
> > > +    env->sregZ = 0;
> > > +    env->sregN = 0;
> > > +    env->sregV = 0;
> > > +    env->sregS = 0;
> > > +    env->sregH = 0;
> > > +    env->sregT = 0;
> > > +
> > > +    env->rampD = 0;
> > > +    env->rampX = 0;
> > > +    env->rampY = 0;
> > > +    env->rampZ = 0;
> > > +    env->eind = 0;
> > > +    env->sp = 0;
> > > +
> > > +    env->skip = 0;
> > > +
> > > +    memset(env->r, 0, sizeof(env->r));
> > > +
> > > +    tlb_flush(cs);
> > > +}
>

--000000000000de70f6059d491205
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sounds good.<br><br><div data-smartmail=3D"gmail_signatur=
e">Sent from my cell phone, please ignore typos </div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 29, 2020=
, 5:12 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail=
.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Wed, Jan 29, 2020 at 1:20 PM Sarah Harris &lt;<a href=3D"m=
ailto:seh53@kent.ac.uk" target=3D"_blank" rel=3D"noreferrer">seh53@kent.ac.=
uk</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I think I&#39;ve found a minor bug: the stack pointer should be initia=
lised to the size of SRAM in some or most cases.<br>
&gt; Currently, SP is initialised to zero.<br>
&gt;<br>
<br>
Very good (that you spotted the bug)!<br>
<br>
&gt; It seems modern AVRs set SP to the size of SRAM (RAMEND) at power-on, =
though a few older ones initialise to zero.<br>
&gt; The ATmega328 (from 2009) [1], ATmega2560 (from 2005) [2], ATtiny2313 =
(from 2003) [6], and ATtiny85 (from 2005) [3] all use RAMEND.<br>
&gt; The ATmega8 (from 2001) [4], ATmega8535 (from 2002) [5], and AT90S8535=
 (from 1998) [7] use zero.<br>
<br>
It looks we&#39;ll have tremendous &quot;fun&quot; dealing with huge variet=
y of AVR SoCs.<br>
<br>
&gt; I haven&#39;t found a list of which AVRs use which value (other than r=
eading every datasheet).<br>
<br>
Yes, I find this to be a big practical problem, this glaring lack of<br>
some summary documentation, and, unfortunately, this affects not only<br>
this particular case (SP initialization). It appears to me that for<br>
many features and details (especially regarding SoC devices) one will<br>
have to carefully examine multiple documents, as you did in this<br>
email.<br>
<br>
&gt;<br>
&gt; Given that GCC performs this initialisation in software anyway (so wha=
t the hardware does doesn&#39;t matter), I think this is a minor issue.<br>
&gt; It will only affect hand written assembly programs that don&#39;t do t=
heir own initialisation (which seems to be discouraged as not all resets ar=
e power-on events).<br>
&gt; I&#39;m not sure what, if anything, needs to be done about it but it m=
ight be worth fixing now we&#39;re emulating specific chips.<br>
&gt;<br>
<br>
Let&#39;s think a little bit about it. In my honest opinion, this may be<br=
>
handled after the series merge, and if you guys agree, there is no<br>
rush.<br>
<br>
&gt; Kind regards,<br>
&gt; Sarah Harris<br>
&gt;<br>
<br>
Thanks!<br>
Aleksandar<br>
<br>
&gt; [1] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7=
810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">http://ww1.microchip.com/downloads/en/Device=
Doc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf</a> (se=
ction 6.5.1)<br>
&gt; [2] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2=
549-8-bit-AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf" =
rel=3D"noreferrer noreferrer" target=3D"_blank">http://ww1.microchip.com/do=
wnloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microcontroller-ATmega640-1280-12=
81-2560-2561_datasheet.pdf</a> (section 7.6)<br>
&gt; [3] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2=
586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-ATtiny85_Datasheet.pdf" rel=
=3D"noreferrer noreferrer" target=3D"_blank">http://ww1.microchip.com/downl=
oads/en/DeviceDoc/Atmel-2586-AVR-8-bit-Microcontroller-ATtiny25-ATtiny45-AT=
tiny85_Datasheet.pdf</a> (section 4.6.1)<br>
&gt; [4] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2=
486-8-bit-AVR-microcontroller-ATmega8_L_datasheet.pdf" rel=3D"noreferrer no=
referrer" target=3D"_blank">http://ww1.microchip.com/downloads/en/DeviceDoc=
/Atmel-2486-8-bit-AVR-microcontroller-ATmega8_L_datasheet.pdf</a> (page 13)=
<br>
&gt; [5] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/doc2502=
.pdf" rel=3D"noreferrer noreferrer" target=3D"_blank">http://ww1.microchip.=
com/downloads/en/DeviceDoc/doc2502.pdf</a> (page 12)<br>
&gt; [6] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2=
543-AVR-ATtiny2313_Datasheet.pdf" rel=3D"noreferrer noreferrer" target=3D"_=
blank">http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2543-AVR-ATtin=
y2313_Datasheet.pdf</a> (page 11)<br>
&gt; [7] <a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/doc1041=
.pdf" rel=3D"noreferrer noreferrer" target=3D"_blank">http://ww1.microchip.=
com/downloads/en/DeviceDoc/doc1041.pdf</a> (page 20)<br>
&gt;<br>
&gt; On Sun, 26 Jan 2020 23:54:43 +0100<br>
&gt; Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.markovic@rt-rk.co=
m" target=3D"_blank" rel=3D"noreferrer">aleksandar.markovic@rt-rk.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; &gt; +static void avr_cpu_reset(CPUState *cs)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(cs);<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 mcc-&gt;parent_reset(cs);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;pc_w =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregI =3D 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregC =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregZ =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregN =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregV =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregS =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregH =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sregT =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;rampD =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;rampX =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;rampY =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;rampZ =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;eind =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;sp =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 env-&gt;skip =3D 0;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 memset(env-&gt;r, 0, sizeof(env-&gt;r));<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 tlb_flush(cs);<br>
&gt; &gt; +}<br>
</blockquote></div>

--000000000000de70f6059d491205--

