Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDDBC32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85782246A5
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZvFFaOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85782246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iswQG-0003Nr-OA
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 17:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iswPV-0002ov-KA
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iswPU-0005KS-7H
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:17:41 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:40580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iswPT-0005Jx-Ed; Sat, 18 Jan 2020 17:17:39 -0500
Received: by mail-il1-x144.google.com with SMTP id c4so24329658ilo.7;
 Sat, 18 Jan 2020 14:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LwHgfidZ+zRbXHrlEI9nla79xjadEOrUICmgJs99C2w=;
 b=FZvFFaOp7g9FLDsUzuMB/KuUMh7WqymayODsGjNPnoNu8jde+o/sF+I7FwOeHAlkFm
 0+afptGK8UFxaaGfPDBboEYqqkikU2qU9jhbywuPgVAtr+Q9EHHUeaXLcpKSe1/WMWwR
 WW8L8z3z3fNbE2KNeHGpibiy3Utsn2wRNGRYODU9TFaYKLpM5Y0FQNsInM1vLFN3ZBZq
 FvHufnAaFDbTgGkJ9787r+DYV5zsi4gvKZgSEFnp/02nK0DSr0Af3RjJ0oCNntK8aKRd
 2CwmiZ+vT6C01g0AlG09m6XOWph1bbEGLghmPh8iPhtcA9mwi/x3VwWVmB6wm+oEYfUT
 frJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LwHgfidZ+zRbXHrlEI9nla79xjadEOrUICmgJs99C2w=;
 b=Fv+N2H+VhnKQpiNPP5PjWrnAgZ38UPpvgXHOtuduArGugIRMfpvC8Zfwr+0bEjNyS8
 n+XLnhJpYFJ5Wb/4nRBxuVWo5gjGFHqHyoAc00T3IPfDy8gXYaVxRU1Dno02eTExG6gV
 mkJrPJ05U4PveWINCWbKoP3h+P1BNfj6ytE2wqVnoUSnXc9Zz4dUXpDIQlS6/ErpnTvc
 sbueSqjPa84UVm57Wn+GHLQorllVfM3W77c/1cWNKeJxxCgDxGn8uzk+nhFCbOl5eACF
 0SIA55To5J3CaiKoUrHsElyYTAXLKzgGrTTNcuEjNOYuO0vY8qi3wvN11VylXzxZWADT
 v2pg==
X-Gm-Message-State: APjAAAXPJG2Ip6o4DRtYD3gLfo1lv7cd7Z0JmM1Gspi4WSpADsE3B06x
 ztyc2Ri7zNfeOfwJEKH14Wg9UAwTpjUWwwERIgM=
X-Google-Smtp-Source: APXvYqyte3YeHI7pTl/+Ggc5Hy55/Ep8zhk7cyw7lZnkKzhZTN9vzkEkOfjv/dBfIWrKad/nj7cc2IUb5TTQcoTWquU=
X-Received: by 2002:a92:a103:: with SMTP id v3mr4657039ili.265.1579385858514; 
 Sat, 18 Jan 2020 14:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-7-nieklinnenbank@gmail.com>
 <8bbf88b2-867a-c95d-a3ae-e819f7dd08ac@redhat.com>
 <CAPan3Wo3Li4XZJqHhhk5fnY_PnzGZ8YwUwCud8Ge4Z_+BOwW1w@mail.gmail.com>
 <5760dae5-f7cc-5736-7275-e6461f985dbd@redhat.com>
In-Reply-To: <5760dae5-f7cc-5736-7275-e6461f985dbd@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 18 Jan 2020 23:17:27 +0100
Message-ID: <CAPan3WpLzg0yzkgj29t3QdFczNsFwqubMUa1_xnqrO2RJMgxaA@mail.gmail.com>
Subject: Re: [PATCH v3 06/17] hw/arm/allwinner: add CPU Configuration module
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000f646a059c716d30"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000f646a059c716d30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2020 at 10:06 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 1/15/20 12:04 AM, Niek Linnenbank wrote:
> > On Tue, Jan 14, 2020 at 12:14 AM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> >      > Various Allwinner System on Chip designs contain multiple
> processors
> >      > that can be configured and reset using the generic CPU
> Configuration
> >      > module interface. This commit adds support for the Allwinner CPU
> >      > configuration interface which emulates the following features:
> >      >
> >      >   * CPU reset
> >      >   * CPU status
> >      >   * Shared 64-bit timer
> >      >
> [...]
> >      > +    case REG_CPU0_CTRL:         /* CPU#0 Control */
> >      > +    case REG_CPU1_CTRL:         /* CPU#1 Control */
> >      > +    case REG_CPU2_CTRL:         /* CPU#2 Control */
> >      > +    case REG_CPU3_CTRL:         /* CPU#3 Control */
> >      > +    case REG_CPU0_STATUS:       /* CPU#0 Status */
> >      > +    case REG_CPU1_STATUS:       /* CPU#1 Status */
> >      > +    case REG_CPU2_STATUS:       /* CPU#2 Status */
> >      > +    case REG_CPU3_STATUS:       /* CPU#3 Status */
> >      > +    case REG_CLK_GATING:        /* CPU Clock Gating */
> >      > +    case REG_GEN_CTRL:          /* General Control */
> >      > +        s->gen_ctrl =3D val;
> >      > +        break;
> >      > +    case REG_SUPER_STANDBY:     /* Super Standby Flag */
> >      > +        s->super_standby =3D val;
> >      > +        break;
> >      > +    case REG_ENTRY_ADDR:        /* Reset Entry Address */
> >      > +        s->entry_addr =3D val;
> >      > +        break;
> >      > +    case REG_DBG_EXTERN:        /* Debug External */
> >      > +        break;
> >      > +    case REG_CNT64_CTRL:        /* 64-bit Counter Control */
> >      > +        s->counter_ctrl =3D val;
> >      > +        break;
> >      > +    case REG_CNT64_LOW:         /* 64-bit Counter Low */
> >      > +    case REG_CNT64_HIGH:        /* 64-bit Counter High */
> >
> >     You forgot to set these. Maybe you can add a int64_t cnt64_diff, se=
t
> it
> >     here to the difference with qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> and
> >     in the read() function return cnt64_diff +
> >     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL).
> >
> > OK I'll need to look into that. Currently this timer is not used by
> > Linux, NetBSD or U-Boot as far
> > as I know. But since it is there, it should be correct indeed.
>
> You might reduce this patch by simply using LOG_UNIMP for these
> registers. Than add the patch when you find some use.
>
> We are more confident when reviewing code when we have a way to test it :=
)
>
>
True indeed. I'll just remove the 64-bit counter from this patch. Thanks!

Regards,
Niek


--=20
Niek Linnenbank

--0000000000000f646a059c716d30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 18, 2020 at 10:06 AM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 1/15/20 12:04 AM, Niek Linnenbank wrote:<br>
&gt; On Tue, Jan 14, 2020 at 12:14 AM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/8/20 9:00 PM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Various Allwinner System on Chip designs cont=
ain multiple processors<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; that can be configured and reset using the ge=
neric CPU Configuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; module interface. This commit adds support fo=
r the Allwinner CPU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; configuration interface which emulates the fo=
llowing features:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* CPU reset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* CPU status<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Shared 64-bit timer<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
[...]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU0_CTRL:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* CPU#0 Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU1_CTRL:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* CPU#1 Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU2_CTRL:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* CPU#2 Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU3_CTRL:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* CPU#3 Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU0_STATUS:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* CPU#0 Status */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU1_STATUS:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* CPU#1 Status */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU2_STATUS:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* CPU#2 Status */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CPU3_STATUS:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* CPU#3 Status */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CLK_GATING:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* CPU Clock Gating */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_GEN_CTRL:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* General Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gen_ctrl =
=3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_SUPER_STANDBY:=C2=A0 =
=C2=A0 =C2=A0/* Super Standby Flag */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;super_stan=
dby =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_ENTRY_ADDR:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* Reset Entry Address */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;entry_addr=
 =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_DBG_EXTERN:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* Debug External */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CNT64_CTRL:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* 64-bit Counter Control */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;counter_ct=
rl =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CNT64_LOW:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* 64-bit Counter Low */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 case REG_CNT64_HIGH:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* 64-bit Counter High */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You forgot to set these. Maybe you can add a int64_=
t cnt64_diff, set it<br>
&gt;=C2=A0 =C2=A0 =C2=A0here to the difference with qemu_clock_get_ns(QEMU_=
CLOCK_VIRTUAL), and<br>
&gt;=C2=A0 =C2=A0 =C2=A0in the read() function return cnt64_diff +<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL).<br>
&gt; <br>
&gt; OK I&#39;ll need to look into that. Currently this timer is not used b=
y <br>
&gt; Linux, NetBSD or U-Boot as far<br>
&gt; as I know. But since it is there, it should be correct indeed.<br>
<br>
You might reduce this patch by simply using LOG_UNIMP for these <br>
registers. Than add the patch when you find some use.<br>
<br>
We are more confident when reviewing code when we have a way to test it :)<=
br>
<br>
</blockquote></div><div><br></div><div>True indeed. I&#39;ll just remove th=
e 64-bit counter from this patch. Thanks!</div><div><br></div><div>Regards,=
</div><div>Niek<br></div><div><br></div><br>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></d=
iv></div></div>

--0000000000000f646a059c716d30--

