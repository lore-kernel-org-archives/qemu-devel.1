Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C8C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C4A206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxdY0N5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C4A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozFq-0007UH-NL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iozF7-00074G-L2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iozF6-0001rE-Kj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:30:37 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:44992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iozF5-0001pF-UQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:30:36 -0500
Received: by mail-lj1-x22d.google.com with SMTP id u71so1439280lje.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I3hVRQZ2S4pGZMBjHNQmI+7oKqUFc2LBvXHEk2FX7yw=;
 b=mxdY0N5WQi0qiGpYaQgP5Ps/ftym5Obc14SvrBlWvkYpDs3B8dXZm86QOI2cwnMNrx
 Jk/Hdu42sJqEgAOqU89LpcUx+gaHNoX+2i5uZ7YRIJ+WUj23L5gnO4mfauxGlOYUPJYw
 L3NbpkCE2znRa2qxiVZ5iM1kgDmt0UWFmbw4SPLSYmUP6zF7o5JkQgvTcZsdxrWQE+et
 pxUIKj4JHkktoYz1VMzuQkbA3PI3lks+adm5fmTCnHFmrKKfdWZvQfQNF0VlDot83pam
 aFpqMD1TE/YADZlTABH2E3gzQ0gf6EiMteYPzqI7SSrzlLHtkuawurtXpsuSv5aGp3ol
 RAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I3hVRQZ2S4pGZMBjHNQmI+7oKqUFc2LBvXHEk2FX7yw=;
 b=BswLJ6t/mW1Yunw9+4zX2LKvxt//qsIebTBxS3KM/eB6wxgXnCCyoF3RFN9R2whnsc
 gy/u0ulLus2s04mkiA1JhOr8OE+u94D7QNjOR62c2G1fNUr3gI4UvxWImQVOw0jWhAtT
 GLtdJjlk5Cx1hFR+suMGiPiN72r17tQosi9MWjdsk5X4Q25WpfYfO/A5GBEJfq/X5yt/
 JY0L99J2Sj5mZLxoskkfjPFg2oOwr1TahAoPQF/MF1YG5suwsgxClhOGjVVte7AXXvsl
 MFoduPYbVl+WouEuI0H+7UwxjYslXxIjVdcR4D/CV3cd/xzZpWOmQESdD29of3wV1H4G
 qfpQ==
X-Gm-Message-State: APjAAAXessTzGXSMtlbog36VyeAm4WUJzrGqe4J1q3F3LBRdkAIMi1/z
 9/mscmlQ1FG7msER4gAlbQiKFcw/oscGEGhuYXo=
X-Google-Smtp-Source: APXvYqysdiZyccxsc/oN12/yJrs6X4cOPyyg/PyUQT8Qqct4c12eNw4/vulntNg6nvV720bLAIn+SYaQRExU3cTCvmU=
X-Received: by 2002:a05:651c:1214:: with SMTP id
 i20mr1232960lja.107.1578443433630; 
 Tue, 07 Jan 2020 16:30:33 -0800 (PST)
MIME-Version: 1.0
References: <157658912470.5706.7275804988501900768.malonedeb@gac.canonical.com>
 <bf392e35-7962-38fa-6dce-d4d8bb5ef485@redhat.com>
In-Reply-To: <bf392e35-7962-38fa-6dce-d4d8bb5ef485@redhat.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 7 Jan 2020 17:30:21 -0700
Message-ID: <CAJy5ezqveu3i_YC6hhS9yBipycFWUqNOBbmJuRmw2reqeYhUXA@mail.gmail.com>
Subject: Re: [Bug 1856706] [NEW] target/mips/op_helper.c:971:duplicated
 branches ?
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000028deec059b9600a1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22d
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Bug 1856706 <1856706@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000028deec059b9600a1
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec. 2019, 09:28 Thomas Huth, <thuth@redhat.com> wrote:

> On 17/12/2019 14.25, dcb wrote:
> > Public bug reported:
> >
> > qemu-4.2.0/target/mips/op_helper.c:971:8: warning: this condition has
> > identical branches [-Wduplicated-branches]
> >
> > Source code is
> >
> >    if (other_tc == other->current_tc) {
> >         tccause = other->CP0_Cause;
> >     } else {
> >         tccause = other->CP0_Cause;
> >     }
> >
> > Possible cut'n'paste error ?
>
>  Hi Edgar,
>
> you added the code in 2011 ... do you still remember the details here,
> whether that was on purpose or whether it should look differently?
>
>  Thomas
>


Hi Thomas,

Sorry but I barely recall yesterday, 2011 was a long time ago... It does
look weird.

IIRC smp was kinda of working but the multithreading support wasn't. Some
of these paths were probably not tested too much at the time.

Cheers,
Edgar

>
>

--00000000000028deec059b9600a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, 17 Dec. 2019, 09:28 Thomas Huth, &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 17/12/2019 14.25, dcb wrote:<br>
&gt; Public bug reported:<br>
&gt; <br>
&gt; qemu-4.2.0/target/mips/op_helper.c:971:8: warning: this condition has<=
br>
&gt; identical branches [-Wduplicated-branches]<br>
&gt; <br>
&gt; Source code is<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 if (other_tc =3D=3D other-&gt;current_tc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tccause =3D other-&gt;CP0_Cause;<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tccause =3D other-&gt;CP0_Cause;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; Possible cut&#39;n&#39;paste error ?<br>
<br>
=C2=A0Hi Edgar,<br>
<br>
you added the code in 2011 ... do you still remember the details here,<br>
whether that was on purpose or whether it should look differently?<br>
<br>
=C2=A0Thomas<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Hi Thomas,=C2=A0</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Sorry but I barely recall yesterday, 2011 =
was a long time ago... It does look weird.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">IIRC smp was kinda of working but the multithreading sup=
port wasn&#39;t. Some of these paths were probably not tested too much at t=
he time.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Cheers,</=
div><div dir=3D"auto">Edgar</div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
</blockquote></div></div></div>

--00000000000028deec059b9600a1--

