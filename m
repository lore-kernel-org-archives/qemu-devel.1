Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C99C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA772218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LamFINOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA772218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33903 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ6iX-0003qa-1d
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 21:28:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJ6hF-0002zp-5H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJ6XW-0004yC-9G
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:17:35 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hJ6XW-0004xI-00
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:17:34 -0400
Received: by mail-ot1-x342.google.com with SMTP id j10so14673063otq.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 18:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1Drxi0czTndeQYtSj5oqTKM47n8G11q5OHlMiZW2iK4=;
	b=LamFINOZv5O8/FGGe6TY0WsIu6+7O6YPLLMWAGbAAJm4ph5eXBKde7fMeZphIpC5Ef
	B+iE4SmpeGO3LQHU5v1TiclveasBPEyWQNcluzy4uLc2mxdeo1V07CtHIrWExB0+7lO2
	Iqzpyempxf2lEauXu5JBaqZndiQcLtTxAq/vc+XKS4Vo27fQWfL/HfNibIIdQz/EbVye
	FAARKv9F6EUn5hwmDPOePDaZ/NHUfUQxlhDDwHWQ33VsIznATHlfHaN7qissKGXCQqoh
	Zznw7EnEMe+/HRU0CmasWrdD4CLwfeuSF9Bl3yjPykEGzQPQIL79msBApzBz9k/aYGRB
	ZEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1Drxi0czTndeQYtSj5oqTKM47n8G11q5OHlMiZW2iK4=;
	b=hcaW4w7FyNY5Y2xFUh+AjVpgsr8MSh40kOIM8LKSZSKQzso4g8BSAAr7H7HfsyjW95
	bfyIFOVcON/6NnYylVjYIgWvJ2I57XP4I0OMpGwKqL+tYp8Z8D47xauvfuUCj716rKy8
	naRtubI6Ud0Vsbz0ivF9hOebdy0DbjkXmCOX7tWH2BLC2CafCf6p4VBFoTsee8KPeLal
	MgU7eWT8rgWJS2mrV4su3VIver2b8qyPtR8CLd4FsubY2GTZAkzAx7Qx9GFcoizUIvDO
	F9Zu+RttocQAcewCgGOoHi9ZbBh454vulM03tRKp9VLykWBLA0i1oI6XxL706KANGjoC
	Xalw==
X-Gm-Message-State: APjAAAWWavcIbzGDIopJBNKGGg3a0kVT4NskOpuqrLi1uklBGFXlivuT
	AHCAKgmyHDDd0Vnmrx1ckkIsL83bHFRae47C0Go=
X-Google-Smtp-Source: APXvYqxU0oplcUDNZWkhHccwdPFBDUWVKLyvs40Pf5mSqqgU70Hj95MZixbxybHmFZZlDtBIcYYnygAtkzjn5k7yUIw=
X-Received: by 2002:a05:6830:2148:: with SMTP id
	r8mr5299304otd.25.1556068653065; 
	Tue, 23 Apr 2019 18:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
In-Reply-To: <a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 24 Apr 2019 09:16:56 +0800
Message-ID:
 <CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
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
Cc: lvivier@redhat.com,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424011656.UhcN5O-qXN8F5qH2apHu3cRTDITTByvNaEpGlaz2PFg@z>

Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A

> On 20/04/2019 12.00, Li Qiang wrote:
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/fw_cfg-test.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> > index c22503619f..9f75dbb5f4 100644
> > --- a/tests/fw_cfg-test.c
> > +++ b/tests/fw_cfg-test.c
> > @@ -174,6 +174,24 @@ static void test_fw_cfg_boot_menu(void)
> >      qtest_quit(s);
> >  }
> >
> > +static void test_fw_cfg_reboot_timeout(void)
> > +{
> > +    QFWCFG *fw_cfg;
> > +    QTestState *s;
> > +    uint32_t reboot_timeout =3D 0;
> > +    size_t filesize;
> > +
> > +    s =3D qtest_init("-boot reboot-timeout=3D15");
> > +    fw_cfg =3D pc_fw_cfg_init(s);
> > +
> > +    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> > +                     &reboot_timeout, sizeof(reboot_timeout));
> > +    g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
> > +    g_assert_cmpint(reboot_timeout, =3D=3D, 15);
>
> Is this endianess-safe? Or do you need to byteswap reboot_timeout if the
> host and guest endianess does not match?
>
>

Good question!

IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream. So
there is no need
to consider the file's endianess. If when the file entry is stored without
considering endianess,
it will be ok to ignore the endianess. So for this patch, the 'reboot_timeo=
ut'
is ok as when we stored
it we don't consider endianess. But for 'splash-time', when we stored it
we convert it to little endian
so when we fetches it, we should also convert it from little endian to
cpu-endian.

So this raises another question.
Should we consider the endianness for this 'file' entry used for 'integer
value'?
I read the seabios related code function 'qemu_cfg_read_file' and
'romfile_loadint'.
It doesn't consider endianess. This seems we should drop the 'endianess
convertion' in 'fw_cfg_bootsplash'
when we store 'etc/boot-menu-wait'.
However what's if the emulation target has a different endianess for the
host target. I think there will be inconsistent.
So I think we can have following choose:

1. Don't consider the endianess, this is ok when emaulated target and host
target has the same endianess.
2. definite an endianess for the 'file' entry used as an integer value.
When we store this kind of data we uses the definited endianess
and when we fetch it out, we also do an endianess convertion. This will
change the seabios I think.

Gerd, Philippe

What do you think of this?

Thanks,
Li Qiang





>  Thomas
>
