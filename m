Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F65C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145692071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0qpoGIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145692071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw00H-0000YF-8I
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivzzi-000054-28
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivzzg-0007WE-T0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:43:41 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:45679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivzzg-0007Vr-OL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:43:40 -0500
Received: by mail-ot1-x32b.google.com with SMTP id 59so7575312otp.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1psS0DChZfHyVl9f5I3meG7sOTB+AatQBd5eNH9crhY=;
 b=N0qpoGIEbdAoBKC9c9GK7E/NRqErKoVd976Y3vFqpWy4Ys6OXWdrb1V92kIbW7pbdg
 i2UMYsSSjcobwPrYj5Lj+7/+bMOnJgqI0jSU/0LIzBxUFsADgL1mECAK/nnVKGBWol/A
 bRyBrMDmhuixZTo7JSLXvjyecBTDZmV7ksKQt1KKA/yMsFUth/iPDcScoHNpQSpHOFAm
 UClRQCfv13dgy6cxuvpHSNNsxnnE8cz+bnb5voWp4kymnLY11WMTS8iuhDap4zyj/Ysp
 Bwo59AubZcLxKDw0shHxPuC0ijRLc/E05180z0yW1o2LhaIOobtGLSAn8/CqRVCHDRJl
 EcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1psS0DChZfHyVl9f5I3meG7sOTB+AatQBd5eNH9crhY=;
 b=KCuMLH0ccNvGOz3vRkK6fJlL7N+HXwIUkJjrNdaH1Cbrutqt3FufSw7G2QGInaS3W3
 P/dhcJXBIk2LNEnA3aaBJ+nUhIvLKvv8cTAm96DXWsFFj63nYSb9N+9ikUvNsnDsEEXf
 5TP4bAI9FaW+D6JqgLINGXWgfGKsX335lTkpz528LlhhFF6mT50uCKfPf2IXgi4wHzyp
 f/aO+U7vmH4RaJ0uCzWrf8xNEs/Lmbq9/h8QsXkCsoKo6FloOn/ff1cqmgWEeL6b+jDV
 rQjshBvoUrZ6A2a+YH7E0cTwYXrfPCPo7XXst0NUzC/HvohmHigLG0wRms4b9FRzIHyW
 krpQ==
X-Gm-Message-State: APjAAAVgZoUyQhk5aOaJNhKEGqi0Mqx85d83AihsLx1ifzVzjWGQhYlF
 UDVm9FOYO06F6DLCMCALTYyyfddPu+PX/z/vJw4=
X-Google-Smtp-Source: APXvYqzQ3lNwinQZxrQmWfTzFxk3cEwV2Cp6Awf1V3zf8wYdA6N5tIRfn+qR9+kXIxXKtPY+pJ2Aw82X0ZNly8yub0U=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr11214875otk.64.1580114619642; 
 Mon, 27 Jan 2020 00:43:39 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=h5v5nXBkoxhSx6inU6G59AHca_8_XrkOsX13C7uRU1jA@mail.gmail.com>
 <8743beb5-22e1-4500-7e81-649298316580@redhat.com>
In-Reply-To: <8743beb5-22e1-4500-7e81-649298316580@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 Jan 2020 09:43:22 +0100
Message-ID: <CAL1e-=ip-KYeo9M1qRacXcari8HbwFJu3zyK4iz0tRFJYt0fcA@mail.gmail.com>
Subject: Re: [PATCH rc3 02/30] target/avr: Introduce AVR CPU class object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009bb698059d1b1ae7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
 Michael Rolnik <mrolnik@gmail.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009bb698059d1b1ae7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

09:03 Pon, 27.01.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 1/27/20 3:39 AM, Aleksandar Markovic wrote:
> >> +static void avr_cpu_initfn(Object *obj)
> >> +{
> >> +    AVRCPU *cpu =3D AVR_CPU(obj);
> >> +
> >> +    cpu_set_cpustate_pointers(cpu);
> >> +
> >> +#ifndef CONFIG_USER_ONLY
> >> +    /* Set the number of interrupts supported by the CPU. */
> >> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
> >> +            sizeof(cpu->env.intsrc) * 8);
> >> +#endif
> >> +}
> >
> > A question for Michael:
> >
> > What is CONFIG_USER_ONLY doing here, if we know AVR cores from this
> > series doesn't have and will never have user mode, since they do not
> > work with the kernel?
> >
> > Do you plan to support some AVR 32-bit CPUs in the same file, which
> > would be able to have linux-user mode? But, in this case, many files
> > must be completely redone. My advice is to separate them completely,
> > and that this file supports only 8-bit AVR cores, and in that case
> > checks for CONFIG_USER_ONLY do not make sense.
>
> You are right, CONFIG_USER_ONLY doesn't make sense.
>
> Suggestion: add in target/avr/cpu.h:
>
>    #ifdef CONFIG_USER_ONLY
>    #error "AVR 8-bit does not support user mode"
>    #endif
>

I agree with your suggestion, in fact, it is an excellent one.

--0000000000009bb698059d1b1ae7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">09:03 Pon, 27.01.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 1/27/20 3:39 AM, Aleksandar Markovic wrote:<br>
&gt; &gt;&gt; +static void avr_cpu_initfn(Object *obj)<br>
&gt; &gt;&gt; +{<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 cpu_set_cpustate_pointers(cpu);<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 /* Set the number of interrupts supported by t=
he CPU. */<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int=
,<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(cpu-&gt;env=
.intsrc) * 8);<br>
&gt; &gt;&gt; +#endif<br>
&gt; &gt;&gt; +}<br>
&gt; &gt; <br>
&gt; &gt; A question for Michael:<br>
&gt; &gt; <br>
&gt; &gt; What is CONFIG_USER_ONLY doing here, if we know AVR cores from th=
is<br>
&gt; &gt; series doesn&#39;t have and will never have user mode, since they=
 do not<br>
&gt; &gt; work with the kernel?<br>
&gt; &gt; <br>
&gt; &gt; Do you plan to support some AVR 32-bit CPUs in the same file, whi=
ch<br>
&gt; &gt; would be able to have linux-user mode? But, in this case, many fi=
les<br>
&gt; &gt; must be completely redone. My advice is to separate them complete=
ly,<br>
&gt; &gt; and that this file supports only 8-bit AVR cores, and in that cas=
e<br>
&gt; &gt; checks for CONFIG_USER_ONLY do not make sense.<br>
&gt;<br>
&gt; You are right, CONFIG_USER_ONLY doesn&#39;t make sense.<br>
&gt;<br>
&gt; Suggestion: add in target/avr/cpu.h:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0#ifdef CONFIG_USER_ONLY<br>
&gt; =C2=A0 =C2=A0#error &quot;AVR 8-bit does not support user mode&quot;<b=
r>
&gt; =C2=A0 =C2=A0#endif<br>
&gt;</p>
<p dir=3D"ltr">I agree with your suggestion, in fact, it is an excellent on=
e.<br>
</p>

--0000000000009bb698059d1b1ae7--

