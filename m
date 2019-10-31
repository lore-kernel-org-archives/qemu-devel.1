Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_MIME_MALF,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0C2CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3F1208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSzWXT01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3F1208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQDFR-0001uX-NF
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 12:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1iQCtb-0001am-FY
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1iQCtY-0003e2-W7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 12:01:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1iQCtY-0003be-OY
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 12:01:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q70so6498907wme.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=PxxpORXBvq9761vLpJp3Tvr67iqXsynnVM6uWL6sUL4=;
 b=DSzWXT013zjKOeNZQzyXRc3kDfzB6dnmzY8gasN7gJWTnTgxZk+8aLPlUNZPTCiy96
 k0p3eWW393OjOYAnC2YKzGsfgB+vq6evjbGXgWLF64DeG2uc/99Y1zY7R3CdExfQdkxx
 jTKCAr3NB46pUsQ+2iYVKaY0H8rieKaSH0bLPpVB9rJNk+bXqw4mlJeFh6tJXzeulzzG
 nF4W8OaRbEURDd9dN2RahlERWjgpA2+Kiziz9hJw1vnbAWyZZDiLiDto3V2Hm3y1PJvP
 iR6cObWRVKNf18gGsxsdnhlYRzyFpasNvZGTcKMfDgwlNbbKNKztmw1BX7oLckrlOWiy
 7RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=PxxpORXBvq9761vLpJp3Tvr67iqXsynnVM6uWL6sUL4=;
 b=hOeh4XKFsqA+w1Ke4NDI8Fss0v+EgSW9PXsPICCm7RMZbF397tKHewhKTcgmAHnlsb
 wA0wnwFur8+frlo2zHj6ZB0F1mAl3xlabRBy0KnHxcv1j02u6p7CTMzlaY+1wQTv5jhh
 T9fusFNopDLYQTOebqw89t+biZctn1EwjwQ//fYWn3kbx6I1p7Om8k7bisVQshcJM/KS
 5LzzHHUUZQ5xSzV5o//LPijMdQnC9b6RTO5OZp7Gs4AURt1YqqecH+WOlpDK7eln4z+W
 zlsms+wRReHzgoruv+OpnM4zfnpLCYn6rps6eeePmofsYtanEfYX3acNJXbFs5qXqGIW
 KcPQ==
X-Gm-Message-State: APjAAAXC1/7z7xNuXoZvLXmLYvHDygyKrS89fpRJZhLJcSRs4i3fU0vi
 tEp9BUcOaE0bhcyIJI3UdJeT6gF4feiaMf1UmKdBMg==
X-Google-Smtp-Source: APXvYqwMDUIsxx457IJ3i/HQzsRg10SjOVybJpe4Ui/KnsNwCjv/Z12JbdIaI8QLMKYPW4ieyIglahYng90EkGjZ6y8=
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr6067317wmd.3.1572537715025; 
 Thu, 31 Oct 2019 09:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.89.1572425520.22191.qemu-devel@nongnu.org>
In-Reply-To: <mailman.89.1572425520.22191.qemu-devel@nongnu.org>
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 31 Oct 2019 12:01:43 -0400
Message-ID: <CAKyx-3NXjmx13rJ7EJwt_6ovG4CGAqePiWduAus7SyYMUp+E0A@mail.gmail.com>
Subject: Re: [Bug 1850570] [NEW] Cannot use usb-host on Mac OS
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>, 1850570@bugs.launchpad.net
Content-Type: multipart/alternative; boundary="000000000000e66a1a059636f741"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e66a1a059636f741
Content-Type: text/plain; charset="UTF-8"

>
> Message: 9
> Date: Wed, 30 Oct 2019 01:46:54 -0000
> From: John Canada <1850570@bugs.launchpad.net>
> To: qemu-devel@nongnu.org
> Subject: [Bug 1850570] [NEW] Cannot use usb-host on Mac OS
> Message-ID:
>         <
> 157240001496.28481.10507378472210680134.malonedeb@chaenomeles.canonical.com
> >
>
> Content-Type: text/plain; charset="utf-8"
>
> Public bug reported:
>
> Usb-host will not work on Mac OS 10.15.  Qemu runs, though it gives
> these errors and the drive does not show up.  Also, when Qemu is
> starting the drive ejects and remounts twice. Qemu built with
> ./configure --target-list=i386-softmmu,x86_64-softmmu --enable-sdl
> --disable-cocoa --enable-sdl-image.
>
> qemu-system-i386 image.qcow -usb -device usb-kbd  -device
> usb-host,vendorid=0x0781,productid=0x5571
> libusb: error [darwin_claim_interface] USBInterfaceOpen: another process
> has device opened for exclusive access
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] USBInterfaceOpen: another process
> has device opened for exclusive access
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
> libusb: error [darwin_claim_interface] interface not found
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1850570
>
> Title:
>   Cannot use usb-host on Mac OS
>
> Status in QEMU:
>   New
>
> Bug description:
>   Usb-host will not work on Mac OS 10.15.  Qemu runs, though it gives
>   these errors and the drive does not show up.  Also, when Qemu is
>   starting the drive ejects and remounts twice. Qemu built with
>   ./configure --target-list=i386-softmmu,x86_64-softmmu --enable-sdl
>   --disable-cocoa --enable-sdl-image.
>
>   qemu-system-i386 image.qcow -usb -device usb-kbd  -device
> usb-host,vendorid=0x0781,productid=0x5571
>   libusb: error [darwin_claim_interface] USBInterfaceOpen: another process
> has device opened for exclusive access
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] USBInterfaceOpen: another process
> has device opened for exclusive access
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>   libusb: error [darwin_claim_interface] interface not found
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1850570/+subscriptions
>
>
>
Have you tried running QEMU under root yet? I had a similar issue with
accessing the optical drive on my computer until I ran QEMU like this:

sudo qemu-system-i386 ...

--000000000000e66a1a059636f741
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Message: 9<br>
Date: Wed, 30 Oct 2019 01:46:54 -0000<br>
From: John Canada &lt;<a href=3D"mailto:1850570@bugs.launchpad.net" target=
=3D"_blank">1850570@bugs.launchpad.net</a>&gt;<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
Subject: [Bug 1850570] [NEW] Cannot use usb-host on Mac OS<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:157240001496.28481.105073=
78472210680134.malonedeb@chaenomeles.canonical.com" target=3D"_blank">15724=
0001496.28481.10507378472210680134.malonedeb@chaenomeles.canonical.com</a>&=
gt;<br>
<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
Public bug reported:<br>
<br>
Usb-host will not work on Mac OS 10.15.=C2=A0 Qemu runs, though it gives<br=
>
these errors and the drive does not show up.=C2=A0 Also, when Qemu is<br>
starting the drive ejects and remounts twice. Qemu built with<br>
./configure --target-list=3Di386-softmmu,x86_64-softmmu --enable-sdl<br>
--disable-cocoa --enable-sdl-image.<br>
<br>
qemu-system-i386 image.qcow -usb -device usb-kbd=C2=A0 -device usb-host,ven=
dorid=3D0x0781,productid=3D0x5571<br>
libusb: error [darwin_claim_interface] USBInterfaceOpen: another process ha=
s device opened for exclusive access<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] USBInterfaceOpen: another process ha=
s device opened for exclusive access<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
libusb: error [darwin_claim_interface] interface not found<br>
<br>
** Affects: qemu<br>
=C2=A0 =C2=A0 =C2=A0Importance: Undecided<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Status: New<br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1850570" rel=3D"noreferrer" targ=
et=3D"_blank">https://bugs.launchpad.net/bugs/1850570</a><br>
<br>
Title:<br>
=C2=A0 Cannot use usb-host on Mac OS<br>
<br>
Status in QEMU:<br>
=C2=A0 New<br>
<br>
Bug description:<br>
=C2=A0 Usb-host will not work on Mac OS 10.15.=C2=A0 Qemu runs, though it g=
ives<br>
=C2=A0 these errors and the drive does not show up.=C2=A0 Also, when Qemu i=
s<br>
=C2=A0 starting the drive ejects and remounts twice. Qemu built with<br>
=C2=A0 ./configure --target-list=3Di386-softmmu,x86_64-softmmu --enable-sdl=
<br>
=C2=A0 --disable-cocoa --enable-sdl-image.<br>
<br>
=C2=A0 qemu-system-i386 image.qcow -usb -device usb-kbd=C2=A0 -device usb-h=
ost,vendorid=3D0x0781,productid=3D0x5571<br>
=C2=A0 libusb: error [darwin_claim_interface] USBInterfaceOpen: another pro=
cess has device opened for exclusive access<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] USBInterfaceOpen: another pro=
cess has device opened for exclusive access<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
=C2=A0 libusb: error [darwin_claim_interface] interface not found<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1850570/+subscriptions" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1850=
570/+subscriptions</a><br>
<br><br></blockquote><div><br></div><div>Have you tried running QEMU under =
root yet? I had a similar issue with accessing the optical drive on my comp=
uter until I ran QEMU like this:<br></div><div><br></div><div>sudo qemu-sys=
tem-i386 ...<br></div><div>=C2=A0</div></div></div>

--000000000000e66a1a059636f741--

