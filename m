Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A562071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg75Ay0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A562071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBIb-00023r-M3
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZBHP-0001OB-5N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZBHO-0008Q1-38
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:07:39 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZBHN-0008Nt-Pt
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:07:38 -0500
Received: by mail-oi1-x241.google.com with SMTP id a14so12556062oid.5
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=6eolbGp4gch1dz6iRpvVtbysy9FRaOZEzSkNlOtP5DQ=;
 b=Cg75Ay0avNJQFa1gjTGHR0xidkMktsDU7dTqtk4lZNNWbGvu9uu5o89DqWpD+g7J2s
 v0KoAwJsZumMvsQNw1gwCl2dLAppk1+CaZwuy810eCeDB6PqcRvNt2/NXo69OJOcVh4G
 UHbPaFrIG8KH0ivka654jeZTpQRiGDdPC1ruPeATOvP/PSUZ++SIQYOfJoO8mJHooaf2
 PAsRwwK4Avk5AUn82IjJN/tO3ZEY//ilBedg8pJM/8v6g1oYc7Wg9pMAh7kLaKQM4OLu
 mF+RPP/V53YusxDoVz4Oc7V08nlc7HKBCOeUL2/4c0cPQKsDOyqiwyNelsD/xKsEh5WG
 uWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=6eolbGp4gch1dz6iRpvVtbysy9FRaOZEzSkNlOtP5DQ=;
 b=qKTa1e0zsbt23PADesxtQ5iERSkOctHsprujPjNyCxgCwh8Sc8JnYidYqpqQUKxvy4
 BKCxMS5dRXZC6IoV5O9ONd9deN5tLHWO4C9Uz/fCQkEKP/dKJ4OD/YKzs+5/8+4v8sJk
 JyGMHiT3BCEjiyC6tah+LcrBWvVAz1VJN4rzk7CcV2X9isIUEqmWEFRtHn7HGHUQAX5H
 BYci4Ge5N9zs0lTthRffnRGvy/NcCv76kEfopP/H96qzxd1LKkUv5iI5pQZGj+eddp9d
 IGjQ7U5P8fxLFxb5G2N9APmutsaPdHeSYXWwgP+KKpjvRkxMpQWFeNWQnLuui/h8Ghyi
 8meg==
X-Gm-Message-State: APjAAAXtNrhIw1YMsTOthCREyA1QYH4dP3vpWfPzQGdJG4sQMmyDKGW2
 kk9uI9WzwXgOZ3ZdmZpRAG4svMmJ12rrP0eRWzE=
X-Google-Smtp-Source: APXvYqwhOtBKhiLLUwdynYRqeBp4BSZC34HQyPsD7UIOs6KOQ02L1yOV9xT2tSrA9LuepTbW/jZwOOWLPt/ln67NiA4=
X-Received: by 2002:aca:484f:: with SMTP id v76mr22475342oia.62.1574676454894; 
 Mon, 25 Nov 2019 02:07:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 02:07:34
 -0800 (PST)
In-Reply-To: <20191120152442.26657-19-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 11:07:34 +0100
Message-ID: <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000baf106059828ee66"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000baf106059828ee66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mips/mips_mipssim.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index bfafa4d7e9..3cd0e6eb33 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
>      if (serial_hd(0)) {
>          DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>
> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>          qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>          qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>          qdev_init_nofail(dev);
> --


Please mention in your commit message where the default baudbase is set.

Also, is there a guarantie that default value 115200 will never change in
future?

Yours, Aleksandar



> 2.24.0
>
>
>

--000000000000baf106059828ee66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Marc-Andr=C3=A9 Lu=
reau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@re=
dhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_mipssim.c | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index bfafa4d7e9..3cd0e6eb33 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceState *dev =3D qdev_create(NULL, TY=
PE_SERIAL_IO);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>dev), &quot;b=
audbase&quot;, 115200);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_chr(dev, &quot;chardev&quot=
;, serial_hd(0));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_legacy_instance_id(<wbr>dev, 0x3=
f8, 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(dev);<br>
--=C2=A0</blockquote><div><br></div><div>Please mention in your commit mess=
age where the default baudbase is set.</div><div><br></div><div>Also, is th=
ere a guarantie that default value 115200 will never change in future?</div=
><div><br></div><div>Yours, Aleksandar</div><div><br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
2.24.0<br>
<br>
<br>
</blockquote>

--000000000000baf106059828ee66--

