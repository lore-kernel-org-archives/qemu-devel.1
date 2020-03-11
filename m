Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3445C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEAF20739
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ8dXA4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEAF20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7fo-00064c-Hw
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC7fD-0005Yg-UE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC7fC-00035C-TG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:09:11 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC7fC-00034i-OF; Wed, 11 Mar 2020 16:09:10 -0400
Received: by mail-io1-xd43.google.com with SMTP id q128so3276617iof.9;
 Wed, 11 Mar 2020 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xYixRV7RXTViLl4bYR0dE+r+Ag/o16cbB/kb4gO+nQI=;
 b=PZ8dXA4MfuGDz0LR5YAHgUcCp9lA5bxwQf3Fm7Zo+MQiJNYDLpMO+l6DwTmIctayHZ
 bPyvxbhn+qRQIQ4ZpIemVrPlHg6dGn816jIvUfnYbWasQc3JisZ4ZWWzXzjPlrYAB2+w
 t120roErPbpgNagFeqTQY2iwlyIIODW4nnuxvvEZNz/8Wi9HPfhzccf2s9YQ6RiCX3Al
 Zix3MaU6NIVb2RLKIhNDipSzBo0FtY6DOhGqoUbk0q6HHaKie5QWMipSZOsibcFC2NSP
 fgVYsj7xniq98GuEk33pW0taLXySW2FJojAbD/R0AMN31Lhj9Schhgwfgfz/+aFrXfe9
 q05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xYixRV7RXTViLl4bYR0dE+r+Ag/o16cbB/kb4gO+nQI=;
 b=Aad6Sk0quQsAP9+lFGxgUycFc5FYlkQE5mEj+ExRNUN+q3IBfrAEWJEDiTVeJOyhwd
 ypIbjtmbBYz1AI2reMYoSZLWAPCzRMlYik07qkqni+fvWWQTYCI08XcfMLdqdFmqtJDu
 4QYuq/xdso4PgODaGizs6SpoyRT8PG1KMR20EYS5hZ8yCdJt91o6bQikqKTG3LWq+HyB
 vPuZdXurEROIJ+AUVCazf8WZZ4vb51h8BOpl/t8SeqMb4wSGyPk5wDlkxbHhJ9raC0yO
 P/VOFKy43uAH1MUtObtxyaErBEquc5mgn4GIzrkQXBsONgjqTdwCBZQuhH2951jmLLm/
 mwLA==
X-Gm-Message-State: ANhLgQ3x17ZKgmHTTC5gOMLCjGjbfIWIYq2sliY3gi/ARephWk779VsN
 BA7Nvyx4NTx4hCqw4N/dSjzBo18exJWsa3E435U=
X-Google-Smtp-Source: ADFU+vswfkhML4C2hPad1aB99trCLMlVY5V6Q+ymfGkLMJijUWhSLcd2xGHvu0yA4I1xdJU9Kpk5RXB+j2SYiOBbVL4=
X-Received: by 2002:a6b:5103:: with SMTP id f3mr4415840iob.181.1583957350042; 
 Wed, 11 Mar 2020 13:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <87o8t3f0o9.fsf@linaro.org>
In-Reply-To: <87o8t3f0o9.fsf@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 21:08:59 +0100
Message-ID: <CAPan3Wr+_W0S_TzFVf_TX2gej7gkdfMdpFmfoPafU5LFr+p6cA@mail.gmail.com>
Subject: Re: [PATCH v7 00/18] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000304f8305a099cfba"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

--000000000000304f8305a099cfba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 3:04 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>
> > Dear QEMU developers,
> >
> > Hereby I would like to contribute the following set of patches to QEMU
> > which add support for the Allwinner H3 System on Chip and the
> > Orange Pi PC machine. The following features and devices are supported:
> <snip>
>
> I've finished my pass through and I think everything has a review tag
> now. As there are some small fixes needed you can you do a v8 respin
> which Peter can apply to target-arm/next.
>

Thanks for taking the time to review Alex. I'm including the small fixes
you suggested and adding the tags and then I'll send v8 to the list.

Regards,
Niek


>
> --
> Alex Benn=C3=A9e
>


--=20
Niek Linnenbank

--000000000000304f8305a099cfba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 11, 2020 at 3:04 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_=
blank">nieklinnenbank@gmail.com</a>&gt; writes:<br>
<br>
&gt; Dear QEMU developers,<br>
&gt;<br>
&gt; Hereby I would like to contribute the following set of patches to QEMU=
<br>
&gt; which add support for the Allwinner H3 System on Chip and the<br>
&gt; Orange Pi PC machine. The following features and devices are supported=
:<br>
&lt;snip&gt;<br>
<br>
I&#39;ve finished my pass through and I think everything has a review tag<b=
r>
now. As there are some small fixes needed you can you do a v8 respin<br>
which Peter can apply to target-arm/next.<br></blockquote><div><br></div><d=
iv>Thanks for taking the time to review Alex. I&#39;m including the small f=
ixes</div><div>you suggested and adding the tags and then I&#39;ll send v8 =
to the list.</div><div><br></div><div>Regards,</div><div>Niek<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000304f8305a099cfba--

