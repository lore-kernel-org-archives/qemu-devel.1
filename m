Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51230C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 20:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B626206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 20:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjLKwI+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B626206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJqN-0007Oo-RX
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 15:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1idJno-0005kY-28
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 15:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1idJnm-0003kh-1O
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 15:02:11 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1idJnk-0003fO-1T; Fri, 06 Dec 2019 15:02:08 -0500
Received: by mail-il1-x144.google.com with SMTP id z12so7259646iln.11;
 Fri, 06 Dec 2019 12:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ciqFUU5MY4QIDiBl5osr7K35WjCbFJa6f4x6hN3vQ3g=;
 b=PjLKwI+xL3+9lLuoQfj6Q4CB+J4ufMl4/gyXeyNsGYIn0H9lH4cjIuqupR5J8Bt/r4
 j3CUjzZYd3hY/DnEIkLGtxcPvWAL0fh6cLOgaoN+OY0gfeRGM6mZ7XDyAaiTJw9o7AUR
 Y0tMUgZBK3bDEWpEXH4/HZon30FnRDaSWal33AtuUgaMFrMOEsZz3NGYOFZDwQ+Ro9IJ
 HRQTOHJMIsml3qtIOG3m2nX2XofyvSlu0L1jQrrqoVyrmnf7eD0qm1LE/r0KqxZwFiKO
 yQpxlOGF6f9YGmSMv626QFAPCyKHxhhirNHq2eMWXdtPYyk9FBw/Qlm6NaU8x6cx08ry
 MQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ciqFUU5MY4QIDiBl5osr7K35WjCbFJa6f4x6hN3vQ3g=;
 b=WI9VQKggClc128DZaGOP81ZXPkZEaDHlVswC/NYVoDNP3zOzCXr/BFN9Mxzbch77wI
 ptQHRCyFmjn1MfxRowN7DRV6YFLD/T6ckMJPJetQcvaBX2HkViQxpeyz2LBRjoSeKkJb
 cLD3s40wiX/TlQvjaMxli2i1DRCGIGZg+gbmsUZnn6CmhuSU5DDCvDZpz/SVXpLQpGGl
 fZHtRO7oYSJwPlbB5/V3hmynvrN+aKLEor1weETnF89AKKArX5eZ2y51vAERVGunhC2n
 2+S1qi/o9GdxMQEd8/UH4XjgGG90T7sx3gQ+Rg3Icrc/b47Ek1j3G/WWuHeh8zzYpFFN
 RJLQ==
X-Gm-Message-State: APjAAAVSXA40Q0naWTTiY/m4DKi1ig1YaQuD94lqfa12eY7Nqi5W/T6X
 i5jkA6OdWOVlXWDGSBSwYw2mWu55CiZ7Hmp/v8k=
X-Google-Smtp-Source: APXvYqw/CxDSfKyY9oDRb9ZAOgaHYcB/cD2x69cRMa5LU2i7r0PDfXfvngoCytiKqgoTqV1QMkTTd+VJ6RETgUXVIco=
X-Received: by 2002:a92:af08:: with SMTP id n8mr15431530ili.217.1575662520840; 
 Fri, 06 Dec 2019 12:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-7-nieklinnenbank@gmail.com>
 <CAFEAcA9XxH7zSmm6=KR-2ttfuqdauXxq05SWw++WgGEWw06NEQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9XxH7zSmm6=KR-2ttfuqdauXxq05SWw++WgGEWw06NEQ@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 6 Dec 2019 21:01:49 +0100
Message-ID: <CAPan3WrYWpa2ymBjy5zCWAEdeVXVRYo7arNVOXWsbFeTAi0ucA@mail.gmail.com>
Subject: Re: [PATCH 06/10] arm/arm-powerctl: set NSACR.{CP11,
 CP10} bits in arm_set_cpu_on()
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d736f805990e8492"
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d736f805990e8492
Content-Type: text/plain; charset="UTF-8"

Hey Peter,

On Fri, Dec 6, 2019 at 3:25 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 2 Dec 2019 at 21:10, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >
> > This change ensures that the FPU can be accessed in Non-Secure mode
> > when the CPU core is reset using the arm_set_cpu_on() function call.
> > The NSACR.{CP11,CP10} bits define the exception level required to
> > access the FPU in Non-Secure mode. Without these bits set, the CPU
> > will give an undefined exception trap on the first FPU access for the
> > secondary cores under Linux.
> >
> > Fixes: fc1120a7f5
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
>
> Oops, another place where we failed to realise the ramifications
> of making NSACR actually do something.
>
> Since this is a bugfix I'm going to fish it out of this patchset
> and apply it to target-arm.next with a cc: stable.
>
> Thanks for the catch!
>

Sure, I'm happy to help. Note that I only tested this fix with
the Allwinner H3 SoC patches that I'm working on.

OK, I'll keep an eye out for it. Once it is solved in master, I'll remove
this patch from the patch series.

Regards,
Niek

>
> -- PMM
>


-- 
Niek Linnenbank

--000000000000d736f805990e8492
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Peter,<br></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 6, 2019 at 3:25 PM Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, 2 Dec 2019 at 21:10, Niek Linnenbank &lt;<a href=3D"mailto:niekl=
innenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; This change ensures that the FPU can be accessed in Non-Secure mode<br=
>
&gt; when the CPU core is reset using the arm_set_cpu_on() function call.<b=
r>
&gt; The NSACR.{CP11,CP10} bits define the exception level required to<br>
&gt; access the FPU in Non-Secure mode. Without these bits set, the CPU<br>
&gt; will give an undefined exception trap on the first FPU access for the<=
br>
&gt; secondary cores under Linux.<br>
&gt;<br>
&gt; Fixes: fc1120a7f5<br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
Oops, another place where we failed to realise the ramifications<br>
of making NSACR actually do something.<br>
<br></blockquote><div></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Since this is a bugfix I&#39;m going to fish it out of this patchset<br>
and apply it to target-arm.next with a cc: stable.<br>
<br>
Thanks for the catch!<br></blockquote><div>=C2=A0</div><div><div>Sure, I&#3=
9;m happy to help. Note that I only tested this fix with</div><div>the Allw=
inner H3 SoC patches that I&#39;m working on.</div></div><div><br></div><di=
v> OK, I&#39;ll keep an eye out for it. Once it is solved in master, I&#39;=
ll remove this patch from the patch series.<br></div><div>=C2=A0</div><div>=
Regards,</div><div>Niek<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000d736f805990e8492--

