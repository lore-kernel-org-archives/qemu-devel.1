Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58559C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1451720718
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULemkRuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1451720718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6au-0002ct-2J
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iY6Zr-0001sn-Gb
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iY6Zq-0003yQ-18
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:54:15 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:37985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iY6Zp-0003xx-RN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:54:13 -0500
Received: by mail-qk1-x733.google.com with SMTP id e2so5856796qkn.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=esab7JXYyOGN53BJGnhQyC8hZ3sBdTpHHRYKackf6TM=;
 b=ULemkRuvc6qVz3Fa0wnlm/DPbWJRv1K68pteZgtLSv30N0+tbxHAvvlz/za+Qg0fmH
 xM7wF19TNnIhpgBbtfTwfLilyipUCa437zb/f17AWLEb3oi4RmhzqswoSJsqaT74G9HN
 a3UnH5ht+GNUBoMYgczSTAC2FoeA1HkfflwBBU4O177WsCHb+Y0eeDLL25MPkmx1o1d7
 1CIsTiYrGPy3zGOZiRTYIF0GB2JM6RvB4T4m16bIjM9NtmXSDrlvAojqjtmSdN65h1d1
 U4dC9tWS7c3A0vlmt308bpets4ENaCpGvgFo0MkUSU2PnXOsLi0cNiSs6YTUFhHJx5MJ
 HTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=esab7JXYyOGN53BJGnhQyC8hZ3sBdTpHHRYKackf6TM=;
 b=FGlUgD1st0a3gZrbpivYATKsiG/AlPPmQDRlHoUhWHmVvlbRVAAYvexev/eEt72m9k
 GACxxro5RLWIBDZ0ykSH13wHhBTsHe3OpLXdIXNjkYGrf3V+SulNp93XSahoeQzphZRO
 AF70d4T8H5y6TYwpljzStA64COfCgs63/kKLp70DVXHMCJHs5Sypk1SxgZieQYlsn+tS
 0ZQ2xn4y2VjuQt+Ed0YKlDKaBFv0h/gddZf650ghsbDk2J6Yiz0qCQU/6y5b5t1+Kjob
 BTnTYtza7OTJkGc0CsqfvKuGLTXQeaYj4q1Rlrd38MVkP3BwntutIfXYa/9YGihlhY0d
 tYSQ==
X-Gm-Message-State: APjAAAWeqP9B4Ya98GD8EVpr/OE2Tmrptv4TzuM/4c5XQMgVyRtzm8XL
 gXiF8XaI8YGId56XACABD00Pm/n8uJ1wv6VbmrE=
X-Google-Smtp-Source: APXvYqy7krSMLjUZ3msapQnpE/wOclBJVXbHKzupZKJG2+GTo3jkpuhMhcPK0ms1RHILhhT7A1SutSI5ZNsqC1M2DBE=
X-Received: by 2002:a37:7443:: with SMTP id p64mr12629121qkc.460.1574420052798; 
 Fri, 22 Nov 2019 02:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAK4993gtPkqESswLBoo1cMuvJFzwSVgUP=Oh-hpG2JSTKezjmw@mail.gmail.com>
 <CAK4993iFuC3LTzkwjAx7uKA18jh-zOo5aYx2+1ugc9fw8UPtYg@mail.gmail.com>
 <e1fedeff-3eab-f215-a376-334417f5bf53@linaro.org>
 <CAL1e-=hKepMcesqsOwxp_HSRO9mvF6V6k4TAoVn5kcmb=20FQg@mail.gmail.com>
 <88d92b88-d72e-8e7a-01ec-522ab07d10f0@redhat.com>
In-Reply-To: <88d92b88-d72e-8e7a-01ec-522ab07d10f0@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 22 Nov 2019 12:54:00 +0200
Message-ID: <CAK4993gbHSmUxSKfXta3zfghXU7zwNcRMGisHY_13G_OydZ-Qw@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f9703e0597ed3be1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::733
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f9703e0597ed3be1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

Once implemented, how to invoke this function?

Sent from my cell phone, please ignore typos

On Fri, Nov 22, 2019, 12:46 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> Hi Michael,
>
> On 11/22/19 9:43 AM, Aleksandar Markovic wrote:
> > On Friday, November 22, 2019, Richard Henderson
> > <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>>
> wrote:
> >
> >     On 11/21/19 8:53 PM, Michael Rolnik wrote:
> >      > It seems to be a huge investment. this function should parse the
> >      > binary data as `decode_insn` does, so I suggest to modify
> decodetree
> >      > tool to make decoding information available to the instruction
> print
> >      > function.
> >      > what do you think?
> >
> >     See target/openrisc/disas.c, which makes use of decodetree.
> >     It shouldn't be difficult to do something slimiar for avr.
> >
> >
> > I support Richard's suggested direction. Since you already implemenred
> > core AVR decoder using decodetree, and you have this openrisc QEMU
> > disassembler example, could you perhaps give a try to what Richard said=
,
> > Michael?
>
> As Aleksandar commented elsewhere in this thread, the port is useful as
> it, and having the disas output is a feature request.
>
> If you have time to look at it before 5.0 development window opens, I'll
> be pleased to review and test it. Anyway I won't object we merge your
> work because this is missing.
>
> Regards,
>
> Phil.
>
>

--000000000000f9703e0597ed3be1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi all.<div dir=3D"auto"><br></div><div dir=3D"auto">Once=
 implemented, how to invoke this function?<br><br><div data-smartmail=3D"gm=
ail_signature" dir=3D"auto">Sent from my cell phone, please ignore typos </=
div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Fri, Nov 22, 2019, 12:46 PM Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Hi Michael,<br>
<br>
On 11/22/19 9:43 AM, Aleksandar Markovic wrote:<br>
&gt; On Friday, November 22, 2019, Richard Henderson <br>
&gt; &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank" =
rel=3D"noreferrer">richard.henderson@linaro.org</a> &lt;mailto:<a href=3D"m=
ailto:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferrer">ri=
chard.henderson@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 11/21/19 8:53 PM, Michael Rolnik wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It seems to be a huge investment. this functi=
on should parse the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; binary data as `decode_insn` does, so I sugge=
st to modify decodetree<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; tool to make decoding information available t=
o the instruction print<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; function.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; what do you think?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0See target/openrisc/disas.c, which makes use of dec=
odetree.<br>
&gt;=C2=A0 =C2=A0 =C2=A0It shouldn&#39;t be difficult to do something slimi=
ar for avr.<br>
&gt; <br>
&gt; <br>
&gt; I support Richard&#39;s suggested direction. Since you already impleme=
nred <br>
&gt; core AVR decoder using decodetree, and you have this openrisc QEMU <br=
>
&gt; disassembler example, could you perhaps give a try to what Richard sai=
d, <br>
&gt; Michael?<br>
<br>
As Aleksandar commented elsewhere in this thread, the port is useful as <br=
>
it, and having the disas output is a feature request.<br>
<br>
If you have time to look at it before 5.0 development window opens, I&#39;l=
l <br>
be pleased to review and test it. Anyway I won&#39;t object we merge your <=
br>
work because this is missing.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div>

--000000000000f9703e0597ed3be1--

