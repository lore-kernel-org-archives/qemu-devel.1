Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F0DC10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFF320870
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCEii9Q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFF320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58999 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hINbY-0004y4-GG
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 21:18:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINad-0004Yw-3a
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINab-0000EF-W0
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:17:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hINab-0000Cx-Lt
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:17:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id y84so7421572oia.12
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RS7f0lZgziqzcIrjPjtyqAODQ3vPRxF/XtwxqrEHuY8=;
	b=jCEii9Q7BJbwp/tWXntvvQV6pru3mEaxq2c/Sq/ygMfK5zmL4XD65J9xG6iJ2xqZso
	XJYpWK8sZkD7CEiRqkI84FLQK3Dazx8XZAqWzBFdMh7z9fTjbmcAuwY2MEr7mMR4VLMz
	bYRdwAPioDu2iXopSMQgr+xG3+oLmZgnxpVGtxhKJQEXFTxav9Dxwys6qEXgPj9cwG8m
	hdKbroJpy8f7E+zARjIYTZIOhJcMbEvcJLtAmLivHPVVvAwdQGXN80nKjcCM9oNb90/x
	0n5Vl+K6xett41Bzj3tbc43VJtabBlzLb69rFkTB7Y0godlhBtrwyHnlyBVgPaO/kkvw
	qH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RS7f0lZgziqzcIrjPjtyqAODQ3vPRxF/XtwxqrEHuY8=;
	b=gElnqwJJe0fCVZ1im/aI0XRbLKHCQBHqZ1Y7bSuwKlzwRODCAObthpncIEXD84hBLr
	dujY9jg1VsUjUXN64DqutcDqESAohauZxpZeZInQlAsRq9FiAaqBZldRy8XR0z7AcGsF
	upOdJNqMl89zQFxjWBp/Ir0wNAfq0BuXvFhJb6bHytoLOVPexMk+bJhfVesBKrnIMOm+
	FSZ1bbXfCr4e/zYDRzqwjYZBakW4U7no+uu3KR9bMD9NNEVAJcRfQbWMEvIv5gt5jORS
	BASHuZqjjW8v87qCCsKNu6meyF6MtuPvu6K1RH/xxvzMf+EyuTUZjx5kGBVkVZUObNsn
	M2sw==
X-Gm-Message-State: APjAAAWnMB8+Oax3LQrKqU6E7NWLqLw3uSWtQWHX/MN55k/6/aNie5Lm
	1gz7Ln53QMXk9kT6ciS+GJOHuJRr31yTsuYQ0e4=
X-Google-Smtp-Source: APXvYqwkpZDcovfG+sZ2s+LqbwjadMCg4L3UyslOJK2b2xYsDmYxqV/Ujf4OSeZEROpnfmpiJFJDkhE60XgzeBCb6Xc=
X-Received: by 2002:aca:fdc6:: with SMTP id b189mr9222894oii.97.1555895864152; 
	Sun, 21 Apr 2019 18:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
	<46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
In-Reply-To: <46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Apr 2019 09:17:07 +0800
Message-ID:
 <CAKXe6S+5TTO3Czxsx98rd3d5UvyCnd5gMeWE6RW8b_eeE_b+3Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 1/3] edu: mmio: set 'max_access_size' to
 8
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jiri Slaby <jslaby@suse.cz>, Li Qiang <liq3ea@163.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422011707.XFwqydd6XaeXlW1iPbbufuTQTNq2WO1FBWOXoIM57y0@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:28=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> The patch title is not very descriptive, maybe "allow 64-bit access"
>
>
> On 4/20/19 6:14 PM, Li Qiang wrote:
> > The edu spec said, the MMIO area can be accessed by 8 bytes.
>
> or 64-bit...
>
> > However currently the 'max_access_size' is not so the MMIO
> > access dispatch can only access 4 bytes one time. This patch
>
> 32-bit
>
> > fixes this to respect the spec.
> >
> > Notice: here the 'min_access_size' is not a must, I set this
> > for completement.
>
> Which one? valid/impl? I think you can drop this comment from the commit
> description.
>
>
Both needed. from memory_access_size, if we has no valid.max_access_size,
this function will set it to 4.

static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
{
    unsigned access_size_max =3D mr->ops->valid.max_access_size;

    /* Regions are assumed to support 1-4 byte accesses unless
       otherwise specified.  */
    if (access_size_max =3D=3D 0) {
        access_size_max =3D 4;
    }
   ...
}

From access_with_adjusted_size, if we has no impl.max_access_size,
this function will set it to 4.

ps: I will appreciate if anyone can explain what's the meaning of valid and
impl's min/max_access_size
and how it affects the behavior.

Thanks,
Li Qiang

>
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/misc/edu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index 91af452c9e..65fc32b928 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops =3D {
> >      .read =3D edu_mmio_read,
> >      .write =3D edu_mmio_write,
> >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
>
> Per the spec, this is correct.
>
> > +        .max_access_size =3D 8,
>
> Correct.
>
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
>
> OK.
>
> > +        .max_access_size =3D 8,
>
> Correct.
>
> > +    },
> > +
> >  };
> >
> >  /*
> >
>
> With title/description updated:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>
