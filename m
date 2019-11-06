Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40CC217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb0NUDzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40CC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSI2N-0000gr-4B
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zar1969@gmail.com>) id 1iSI1f-00009n-6N
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zar1969@gmail.com>) id 1iSI1e-0005Os-0Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:54:55 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:36107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zar1969@gmail.com>) id 1iSI1d-0005O3-PN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:54:53 -0500
Received: by mail-oi1-x22e.google.com with SMTP id j7so20438365oib.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n+bfa+XBueXq4eeI7ppl29nUcPWN7ZhId27AyQG4iBs=;
 b=Tb0NUDzTeIeqjSDU4cAUvl6BDsEFOm193LI1Y6spQlYlWbM0hKD6WvT2IqYjAiHens
 7BXQO3s0Yj0sDU7Pd3QcksiDdM/KCxmBkl9Z4LEE1R3ofWeFHOjvb4H4xH3wMJw9ooKw
 rlQZ1YguP8enniqh/8dgeP+cEVpqWUbqc07HLgOalWGZ4emtvMM2aiD2zcq53Df+J19X
 fq6522nhcMJULCuwIa3Q3ZDZWtUostNcoX1pbaaCxhy0vCMaWWVzABCib6ZqpWC57pJR
 gKMe4VNdMrlkYDBr6o8Rbrfn+F7kRnRwIfAx49r1WvF9GqeWIpTRY2+GdrWKqKXKL5UV
 GvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n+bfa+XBueXq4eeI7ppl29nUcPWN7ZhId27AyQG4iBs=;
 b=Iiic7J2kVc9iXxXMlU8M6ivarVpG7H+1aBlvXR4B0Q0aoQcZQaZSID/IrMBSR8Nj5j
 Z+4XUjAKZK7hGUWU7303yW0rp9YPJreuYhZgxg91eQ3cl/v27e8XUxxrs6Y3w/s+lIfH
 DXFklwfS3iynEoEFF4iACHAtTt3y2cvd174io3ZTD+bsU6wRRUkNvhg7c40QcNOZ3b46
 13UXFcOWL63Aez+msX5h0kXXtGT+LKM+LG1lhUL96OMrOkdnvZKQpDSA/wV16k37rSPr
 xf237tCIx1og7aqe02yyBEMawXK6G6c2MGa0jLdIqtYz4eaYOvao0Im80eVLVVAx+H8A
 hkdA==
X-Gm-Message-State: APjAAAXLDUPhC1rvYNODXK2Tct0Veb0WYu9q9TI+xCnOUON16NXfQIIk
 kOebE52WSuYQ9Zx29/ZI6fXVW0aP83kIe5f+hKU=
X-Google-Smtp-Source: APXvYqyQStgcBCR3lBe3j2qkQbCRUWRLmfOK3YHpPaTHYJJk9KDY8eqrIkWVimMZAiNZ0TCAkT/EOMsrrCfl2UGtidc=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr1492937oih.16.1573034091877; 
 Wed, 06 Nov 2019 01:54:51 -0800 (PST)
MIME-Version: 1.0
References: <CA+gXNfhCRT1kPq4KVumXwRiJvVaXYZZBRhs-QsVNKv+WzeMM+A@mail.gmail.com>
 <54af7410-569e-2b4b-70ed-f09039014bda@redhat.com>
 <56403a22-d48e-5bb3-15c5-904e2e7c667d@ilande.co.uk>
 <CACXAS8CVEbSGu7v4fLyGb-w95CZbw-1foM5=Mvs=yu7QsxspOA@mail.gmail.com>
In-Reply-To: <CACXAS8CVEbSGu7v4fLyGb-w95CZbw-1foM5=Mvs=yu7QsxspOA@mail.gmail.com>
From: Zainuddin AR <zar1969@gmail.com>
Date: Wed, 6 Nov 2019 17:54:38 +0800
Message-ID: <CA+gXNfiRPZOvViv4LBJKtayAvx4W4d8Vnn_dstKzqEcKW27hfg@mail.gmail.com>
Subject: Re: Sparc Solaris 10
To: Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000441d0b0596aa8abf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000441d0b0596aa8abf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for the reply and information.  Will check it out.

On Mon, Nov 4, 2019, 17:17 Artyom Tarasenko <atar4qemu@gmail.com> wrote:

> On Sun, Nov 3, 2019 at 10:01 PM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
> >
> > On 02/11/2019 19:56, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> > > Cc'ing the SPARC maintainers.
> > >
> > > On 11/1/19 4:49 AM, Zainuddin AR wrote:
> > >> Hi,
> > >>
> > >> I like to find to find out if you have a working qemu on solaris 10
> or 11. I have
> > >> tried the qemu-sun4vniagara but without networking. Is the networkin=
g
> support for
> > >> niagara version available?
> >
> > I'm not particularly familiar with sun4v, however I'm not aware of any
> current work
> > in this area. Do you know which network driver is typically used with
> sun4v?
>
> The sun4v NIC is currently not implemented. It's well documented in
> the opensparc documentation though, so if anyone has time for that,
> adding it to QEMU is doable.
>
> At the moment there is just a serial line which can probably be used
> for ppp or slip, but I haven't tried it yet.
>
> --
> Regards,
> Artyom Tarasenko
>
> SPARC and PPC PReP under qemu blog:
> http://tyom.blogspot.com/search/label/qemu
>

--000000000000441d0b0596aa8abf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Thank you very much for the reply and information.=
=C2=A0 Will check=C2=A0it out.</div><div dir=3D"auto"><br><div class=3D"gma=
il_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 4,=
 2019, 17:17 Artyom Tarasenko &lt;<a href=3D"mailto:atar4qemu@gmail.com">at=
ar4qemu@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Sun, Nov 3, 2019 at 10:01 PM Mark Cave-Ayland<br>
&lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank" rel=
=3D"noreferrer">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br>
&gt;<br>
&gt; On 02/11/2019 19:56, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt;<br>
&gt; &gt; Cc&#39;ing the SPARC maintainers.<br>
&gt; &gt;<br>
&gt; &gt; On 11/1/19 4:49 AM, Zainuddin AR wrote:<br>
&gt; &gt;&gt; Hi,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I like to find to find out if you have a working qemu on sola=
ris 10 or 11. I have<br>
&gt; &gt;&gt; tried the qemu-sun4vniagara but without networking. Is the ne=
tworking support for<br>
&gt; &gt;&gt; niagara version available?<br>
&gt;<br>
&gt; I&#39;m not particularly familiar with sun4v, however I&#39;m not awar=
e of any current work<br>
&gt; in this area. Do you know which network driver is typically used with =
sun4v?<br>
<br>
The sun4v NIC is currently not implemented. It&#39;s well documented in<br>
the opensparc documentation though, so if anyone has time for that,<br>
adding it to QEMU is doable.<br>
<br>
At the moment there is just a serial line which can probably be used<br>
for ppp or slip, but I haven&#39;t tried it yet.<br>
<br>
-- <br>
Regards,<br>
Artyom Tarasenko<br>
<br>
SPARC and PPC PReP under qemu blog: <a href=3D"http://tyom.blogspot.com/sea=
rch/label/qemu" rel=3D"noreferrer noreferrer" target=3D"_blank">http://tyom=
.blogspot.com/search/label/qemu</a><br>
</blockquote></div></div></div>

--000000000000441d0b0596aa8abf--

