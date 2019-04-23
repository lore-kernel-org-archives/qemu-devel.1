Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCB2C282E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA6B8206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+xh4QOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6B8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hImTS-0005ji-03
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 23:52:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hImSe-0005NC-3E
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hImSc-0001EY-9h
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:51:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hImSb-0001DX-UL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:51:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id m10so11598998otp.2
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 20:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eISLlkwpMqxMSe8soJ5EweYDLaYRo4/RUwhGMm5/Afw=;
	b=T+xh4QOArud/LMZe6m1IarqKeadIFnmyOXY17XphRkwtrWGD6VYcINhVYSuiLIGoTk
	hJVnSCVcmIrquXvrpQGACONBwfGdRM/j5FBQL0nqHv7aZp2CsrGDw33JcTQJsVERwAxK
	R8FtAEfELg/UocwDXsA0p1t0U/ESF4fJ6VZDoX9XnC5QFqsJGRWlIrbZsruPWDLNr7k5
	bpTbu7c1vPe+0ej9qzPOJV7GZKvoxbquJkaxGfyiQn0yHtdZO0/yGEjcA44FhKVV3NFB
	FPn1dy3yc3FnijN6b3CE2H7V+vA67N+0PZPCN2g+JowoN2a0+/l91KzxIwkHHqGnAWR0
	Jfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eISLlkwpMqxMSe8soJ5EweYDLaYRo4/RUwhGMm5/Afw=;
	b=HlRBbHXTysW+W+Ecv+LTBOcA7aHwwA2L2Yk9YKf8tIFb+Y5aYq9UWBEpe/YoN/hPv+
	xHko5RrKnRbhB94vdww7KgNGUNvSwAv+rtPdEIOBYY939b4GHlRcrTyhutI2lD6me2rd
	sXmcsCVmdSYB1pIA9cRjvQrCt0w6fyIvN5wFV4lSkO3z7Cw5fwBMg6kZqpiCHiXueIHP
	vPBH/cFyUghDaccs7mJcwcweymEFMWtNs3+91VwzTs/2Idm7xKj3vSGf3zgKhpziFV0G
	2nDggo4qOx1Bes20y5cRbugGeuR4ecyMPSSlGAA1iE441KOMeqd4WZ9ZFp3Dn2TiILJb
	g1Iw==
X-Gm-Message-State: APjAAAUDpaKiAJfjiA97A6KTCQOl7t3Bh3TEWcG4GME9Ey7etDEelfjb
	VLtMuOYR9l3XLxD0t+X6XIBVbFNI3KtNy7H8Ydk=
X-Google-Smtp-Source: APXvYqyritVQrEd5AHejs2P0IqXIptczb+SkKb772eYT6tlqTS3WaDxQCVNz7XFbCtnnZintd4ucPPpOfloMekYKk2c=
X-Received: by 2002:a05:6830:13cd:: with SMTP id
	e13mr14595264otq.139.1555991468353; 
	Mon, 22 Apr 2019 20:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
	<46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
	<CAKXe6S+5TTO3Czxsx98rd3d5UvyCnd5gMeWE6RW8b_eeE_b+3Q@mail.gmail.com>
	<6538e063-8710-3ad1-cb88-cda110d57212@redhat.com>
In-Reply-To: <6538e063-8710-3ad1-cb88-cda110d57212@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Apr 2019 11:50:32 +0800
Message-ID:
 <CAKXe6SJuPw9cMcc-d9fYH1NiBVq3Oe5uN7R28nBtKX+zx2ReUA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Message-ID: <20190423035032.skw6i71kWDuYJhkExQXdDJ4_oirMwL4m7-_fzumAhL4@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:28=E5=86=99=E9=81=
=93=EF=BC=9A

> On 4/22/19 3:17 AM, Li Qiang wrote:
> >
> >
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E
> > 2019=E5=B9=B44=E6=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=88=
6:28=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     Hi Li,
> >
> >     The patch title is not very descriptive, maybe "allow 64-bit access=
"
> >
> >
> >     On 4/20/19 6:14 PM, Li Qiang wrote:
> >     > The edu spec said, the MMIO area can be accessed by 8 bytes.
> >
> >     or 64-bit...
> >
> >     > However currently the 'max_access_size' is not so the MMIO
> >     > access dispatch can only access 4 bytes one time. This patch
> >
> >     32-bit
> >
> >     > fixes this to respect the spec.
> >     >
> >     > Notice: here the 'min_access_size' is not a must, I set this
> >     > for completement.
> >
> >     Which one? valid/impl? I think you can drop this comment from the
> commit
> >     description.
> >
> >
> > Both needed. from memory_access_size, if we has no valid.max_access_siz=
e,
> > this function will set it to 4.
> >
> > static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr=
)
> > {
> >     unsigned access_size_max =3D mr->ops->valid.max_access_size;
> >
> >     /* Regions are assumed to support 1-4 byte accesses unless
> >        otherwise specified.  */
> >     if (access_size_max =3D=3D 0) {
> >         access_size_max =3D 4;
> >     }
> >    ...
> > }
> >
> > From access_with_adjusted_size, if we has no impl.max_access_size,
> > this function will set it to 4.
> >
> > ps: I will appreciate if anyone can explain what's the meaning of valid
> > and impl's min/max_access_size
> > and how it affects the behavior.
>
> "valid" describes the valid access from the bus to the device.
>
> Indeed in the EDU case those are 4 and 8.
>
> "impl" describes the accesses implemented by the QEMU device model.
> The developper who writes the device is free to choose the accesses he
> will model.
>
> If valid/impl accesses don't match, the function
> access_with_adjusted_size() from memory.c will adjust the bus access to
> the device implementation.
>
> For example, if the device only implements 1 and 2 bytes accesses, with
> a 1-4 valid access, if the CPU executes a 32-bit access, this function
> will do 2x 16-bit access to the device (incrementing the address by 2)
> and returns a 32-bit result.
>
> Similarly, if the CPU does a 8-bit access on a 32-bit impl device,
> access_with_adjusted_size() will execute a single 32-bit access to the
> device, then mask/shift the returned value and returns a 8-bit result to
> the caller.
>
>
Thanks  Philippe,

I think I get the pointer.

Thanks,
Li Qiang



> > Thanks,
> > Li Qiang
> >
> >     >
> >     > Signed-off-by: Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>>
> >     > ---
> >     >  hw/misc/edu.c | 9 +++++++++
> >     >  1 file changed, 9 insertions(+)
> >     >
> >     > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> >     > index 91af452c9e..65fc32b928 100644
> >     > --- a/hw/misc/edu.c
> >     > +++ b/hw/misc/edu.c
> >     > @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops =
=3D {
> >     >      .read =3D edu_mmio_read,
> >     >      .write =3D edu_mmio_write,
> >     >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> >     > +    .valid =3D {
> >     > +        .min_access_size =3D 4,
> >
> >     Per the spec, this is correct.
> >
> >     > +        .max_access_size =3D 8,
> >
> >     Correct.
> >
> >     > +    },
> >     > +    .impl =3D {
> >     > +        .min_access_size =3D 4,
> >
> >     OK.
> >
> >     > +        .max_access_size =3D 8,
> >
> >     Correct.
> >
> >     > +    },
> >     > +
> >     >  };
> >     >
> >     >  /*
> >     >
> >
> >     With title/description updated:
> >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >     <mailto:philmd@redhat.com>>
> >
>
