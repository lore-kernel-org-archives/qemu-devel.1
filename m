Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F0C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8557924655
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOx6eOZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8557924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4EaI-0007YU-Tp
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4EZW-0006wQ-Ls
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4EZU-0004WK-NO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:54:42 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j4EZU-0004VZ-Hk; Tue, 18 Feb 2020 20:54:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id j16so21640630otl.1;
 Tue, 18 Feb 2020 17:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DpgtMQbXX5PpF9YhJmOuyqk/epg/8bO61B8WaHMIMUU=;
 b=KOx6eOZ5KXIEFlf7min1K7KsXq1TT0CiVWzm2HuFiIdyy3evTLCvXskv225PEjR2he
 D4HHDay3znjmCdmy6ozm9PWdPmL/FuNbsTghgXK5ndn1Sh3/tess7g/t6ppCXTH6aLaR
 6eZdR7nwy0foaw6FulG8E02RePnEeEjkB5k+zUS7Kodq3ZPJkAw4yZGeErgrrhWkKBz3
 8FWxAlW7KODPbeMSJ4enIbWt1t8r+qAo3EBpol3skYEtz9TB82QSgd1kJaL4BpKkxrjy
 DkmAke2jXGNc+VVxvp2OWfCAtkUCa4WXWENM7B65uFbWfrrLfY1mqwbsczY5RA/2seEd
 Km+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DpgtMQbXX5PpF9YhJmOuyqk/epg/8bO61B8WaHMIMUU=;
 b=bOKnPXlRyand88gNvIbevdXwhhLMd05ZuAP7OJ2DIo43IBOUxFQbhlzHnO57Twfkmk
 pylleXL88VNRZEXTGorDLPAs0ka+sXoSs1ODs3ONQFgHF8fqKq8lmNxBb7MC12Xy7uzq
 Em1iL9HbvZG1L9/6SCPdFHdhpXwQ8n4D50Bq9eDU6UZOdGDWZHRviBkHjlpDaFwrDRE9
 datDwGFdgWHY30A2JWUqYFKQj6KSbNv81u1sxP5yamg1qmLy/bTD5ZhLdGe9wKOuUbhe
 PfL2sjFx07ULb7a07CoHWP2TZy7PrXvMfybYwiw8oEeWL5G5P7ahpxvjjHfw5k64RGsM
 YCTQ==
X-Gm-Message-State: APjAAAXlkuiUR9xT2hWYk2//Sw/93KlKLvfrEwabyiT3kP7l1rcScYa3
 AHb1GUe6XcwqKgoZE7iKlRd/48F5KfQfKtPRSU0=
X-Google-Smtp-Source: APXvYqxJq59wBKijpKoH6dVCnrasiGZr8QJNGXz8MkTHWLxR3QER9T600NRCTd7wJ30ghk9gOf7MK1U0ihTUDn9AgLk=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr17110649otk.64.1582077279552; 
 Tue, 18 Feb 2020 17:54:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
 <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 19 Feb 2020 02:54:17 +0100
Message-ID: <CAL1e-=gaVz5K=JMg+iN53weESLORKEuXRJvq-SFqU7FERojP8Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: multipart/alternative; boundary="00000000000041498b059ee41252"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000041498b059ee41252
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2:06 AM Sre, 19.02.2020. Finn Thain <fthain@telegraphics.com.au> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, 18 Feb 2020, Aleksandar Markovic wrote:
>
> > On Wednesday, January 29, 2020, Finn Thain <fthain@telegraphics.com.au>
> > wrote:
> >
> > > Hi All,
> > >
> > > There are bugs in the emulated dp8393x device that can stop packet
> > > reception in a Linux/m68k guest (q800 machine).
> > >
> > > With a Linux/m68k v5.5 guest (q800), it's possible to remotely trigge=
r
> > > an Oops by sending ping floods.
> > >
> > > With a Linux/mips guest (magnum machine), the driver fails to probe
> > > the dp8393x device.
> > >
> > > With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
> > > fatal to the guest kernel.
> > >
> > > Whilst debugging the device, I found that the receiver algorithm
> > > differs from the one described in the National Semiconductor
> > > datasheet.
> > >
> > > This patch series resolves these bugs.
> > >
> > > AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
> > > ---
> >
> >
> > Herve,
> >
> > Do your Jazz tests pass with these changes?
> >
>
> AFAIK those tests did not expose the NetBSD panic that is caused by
> mainline QEMU (mentioned above).
>
> I have actually run the tests you requested (Herv=C3=A9 described them in=
 an
> earlier thread). There was no regression. Quite the reverse -- it's no
> longer possible to remotely crash the NetBSD kernel.
>
> Apparently my testing was also the first time that the jazzsonic driver
> (from the Linux/mips Magnum port) was tested successfully with QEMU. It
> doesn't work in mainline QEMU.
>

Well, I appologize if I missed all these facts. I just did not notice them,
at least not in this form. And, yes, some "Tested-by:" by Herve would be
desirable and nice.

Yours,
Aleksandae

> Anyway, more testing is always nice, and I'd certainly welcome an
> 'acked-by' or 'tested-by' if Herv=C3=A9 would like to send one.
>
> Please consider backporting this series of bug fixes to QEMU stable
> branch(es).
>
> Regards,
> Finn
>
> > Regards,
> > Aleksandar
> >
> >
> >
> > > Changed since v1:
> > >  - Minor revisions as described beneath commit logs.
> > >  - Dropped patches 4/10 and 7/10.
> > >  - Added 5 new patches.
> > >
> > > Changed since v2:
> > >  - Minor revisions as described beneath commit logs.
> > >  - Dropped patch 13/13.
> > >  - Added 2 new patches.
> > >
> > > Changed since v3:
> > >  - Replaced patch 13/14 with patch suggested by Philippe
Mathieu-Daud=C3=A9.
> > >
> > >
> > > Finn Thain (14):
> > >   dp8393x: Mask EOL bit from descriptor addresses
> > >   dp8393x: Always use 32-bit accesses
> > >   dp8393x: Clean up endianness hacks
> > >   dp8393x: Have dp8393x_receive() return the packet size
> > >   dp8393x: Update LLFA and CRDA registers from rx descriptor
> > >   dp8393x: Clear RRRA command register bit only when appropriate
> > >   dp8393x: Implement packet size limit and RBAE interrupt
> > >   dp8393x: Don't clobber packet checksum
> > >   dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
> > >   dp8393x: Pad frames to word or long word boundary
> > >   dp8393x: Clear descriptor in_use field to release packet
> > >   dp8393x: Always update RRA pointers and sequence numbers
> > >   dp8393x: Don't reset Silicon Revision register
> > >   dp8393x: Don't stop reception upon RBE interrupt assertion
> > >
> > >  hw/net/dp8393x.c | 202
+++++++++++++++++++++++++++++++----------------
> > >  1 file changed, 134 insertions(+), 68 deletions(-)
> > >
> > > --
> > > 2.24.1
> > >
> > >
> > >
> >

--00000000000041498b059ee41252
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">2:06 AM Sre, 19.02.2020. Finn Thain &lt;<a href=3D"mailto:ft=
hain@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Tue, 18 Feb 2020, Aleksandar Markovic wrote:<br>
&gt;<br>
&gt; &gt; On Wednesday, January 29, 2020, Finn Thain &lt;<a href=3D"mailto:=
fthain@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; Hi All,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There are bugs in the emulated dp8393x device that can stop =
packet<br>
&gt; &gt; &gt; reception in a Linux/m68k guest (q800 machine).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; With a Linux/m68k v5.5 guest (q800), it&#39;s possible to re=
motely trigger<br>
&gt; &gt; &gt; an Oops by sending ping floods.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; With a Linux/mips guest (magnum machine), the driver fails t=
o probe<br>
&gt; &gt; &gt; the dp8393x device.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; With a NetBSD/arc 5.1 guest (magnum), the bugs in the device=
 can be<br>
&gt; &gt; &gt; fatal to the guest kernel.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Whilst debugging the device, I found that the receiver algor=
ithm<br>
&gt; &gt; &gt; differs from the one described in the National Semiconductor=
<br>
&gt; &gt; &gt; datasheet.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This patch series resolves these bugs.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; AFAIK, all bugs in the Linux sonic driver were fixed in Linu=
x v5.5.<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Herve,<br>
&gt; &gt; <br>
&gt; &gt; Do your Jazz tests pass with these changes?<br>
&gt; &gt; <br>
&gt;<br>
&gt; AFAIK those tests did not expose the NetBSD panic that is caused by <b=
r>
&gt; mainline QEMU (mentioned above).<br>
&gt;<br>
&gt; I have actually run the tests you requested (Herv=C3=A9 described them=
 in an <br>
&gt; earlier thread). There was no regression. Quite the reverse -- it&#39;=
s no <br>
&gt; longer possible to remotely crash the NetBSD kernel.<br>
&gt;<br>
&gt; Apparently my testing was also the first time that the jazzsonic drive=
r <br>
&gt; (from the Linux/mips Magnum port) was tested successfully with QEMU. I=
t <br>
&gt; doesn&#39;t work in mainline QEMU.<br>
&gt;</p>
<p dir=3D"ltr">Well, I appologize if I missed all these facts. I just did n=
ot notice them, at least not in this form. And, yes, some &quot;Tested-by:&=
quot; by Herve would be desirable and nice.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandae<br></p>
<p dir=3D"ltr">&gt; Anyway, more testing is always nice, and I&#39;d certai=
nly welcome an <br>
&gt; &#39;acked-by&#39; or &#39;tested-by&#39; if Herv=C3=A9 would like to =
send one.<br>
&gt;<br>
&gt; Please consider backporting this series of bug fixes to QEMU stable <b=
r>
&gt; branch(es).<br>
&gt;<br>
&gt; Regards,<br>
&gt; Finn<br>
&gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Aleksandar<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; &gt; Changed since v1:<br>
&gt; &gt; &gt;=C2=A0 - Minor revisions as described beneath commit logs.<br=
>
&gt; &gt; &gt;=C2=A0 - Dropped patches 4/10 and 7/10.<br>
&gt; &gt; &gt;=C2=A0 - Added 5 new patches.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Changed since v2:<br>
&gt; &gt; &gt;=C2=A0 - Minor revisions as described beneath commit logs.<br=
>
&gt; &gt; &gt;=C2=A0 - Dropped patch 13/13.<br>
&gt; &gt; &gt;=C2=A0 - Added 2 new patches.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Changed since v3:<br>
&gt; &gt; &gt;=C2=A0 - Replaced patch 13/14 with patch suggested by Philipp=
e Mathieu-Daud=C3=A9.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Finn Thain (14):<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Mask EOL bit from descriptor addresses<=
br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Always use 32-bit accesses<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Clean up endianness hacks<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Have dp8393x_receive() return the packe=
t size<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Update LLFA and CRDA registers from rx =
descriptor<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Clear RRRA command register bit only wh=
en appropriate<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Implement packet size limit and RBAE in=
terrupt<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Don&#39;t clobber packet checksum<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Use long-word-aligned RRA pointers in 3=
2-bit mode<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Pad frames to word or long word boundar=
y<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Clear descriptor in_use field to releas=
e packet<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Always update RRA pointers and sequence=
 numbers<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Don&#39;t reset Silicon Revision regist=
er<br>
&gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Don&#39;t stop reception upon RBE inter=
rupt assertion<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 hw/net/dp8393x.c | 202 +++++++++++++++++++++++++++++++=
----------------<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 134 insertions(+), 68 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.24.1<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;</p>

--00000000000041498b059ee41252--

