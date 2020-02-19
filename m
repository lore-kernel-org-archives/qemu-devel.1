Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B99C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC0724654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzn0w840"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC0724654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Edb-0000RF-Qv
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4Ecn-0008Fu-U2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4Ecl-0006t4-7C
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:58:05 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j4Ecl-0006rb-0T; Tue, 18 Feb 2020 20:58:03 -0500
Received: by mail-ot1-x342.google.com with SMTP id z9so21618861oth.5;
 Tue, 18 Feb 2020 17:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vndVulpWkdbIi0NYNoE+411qDuwFSanASXbWA8MeC0E=;
 b=qzn0w840nVIObMmGTddtyepNIlXIwruzNwRucaNzOnf/EHYqFVNEyaptKUF2GGIXrT
 F/ChvuJjgM+Cwb9LOnlhmIUwR2vQ3BIrDIvZL6sJB/jx62uwo6DE9Juv+nHSLkqFJsRx
 yMDnwyPYkBv93E73cmyY/8ZV3jHQNnMfK2+zPVcSisvdAuyPs/zJOyBpA/O3Zh2C431I
 K85j5zXj/53o777EIVi0vmWpoVWpLmU5W99osRvSbJ1Cae08FHPTp7T6oOHpEMxYHiIC
 KYT1jOtsh+KH3TUAvjBILZpD7wuRX3vbIjL5tR+lGjGWvea9a/6YknQXCJlw0XotSM43
 wVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vndVulpWkdbIi0NYNoE+411qDuwFSanASXbWA8MeC0E=;
 b=s71DazJJET6AlIx+I3LNJAeIKM0WU3WMy5qE8lTT9SW6YOcFbnIAJ/hXtaaBz5vAun
 0Ro6E5lQDvpo4nF+Y5siWM3/vQde1noUegMxP3JXkhQxsMi97K6xc1vUyiKntVrgvUXO
 IQmAjaRyrYRq0TBopN8kpcrB5/keDvP9XcSzKFtgSwwmTuoy1EitnfMv4tDI/kH1wnI/
 q/nYSLrvR09YN/WWSawRNoazNYB/9RS8X6Wz/klXXZFi3zxeaFhV8DI+LlQp2B1IVc3y
 icw7E8FhlZLrwHk0qKgzrp7d5Es6e3bnVZ2YYwIfsC8iAuZf++JzspGPh+Pz80NncnFX
 rk5w==
X-Gm-Message-State: APjAAAUprl4B2+CEhrYnSSmlLBMnfUvFCh95N9ZgyFDajiX4QdVze6RG
 /EDq9s9BGwqtygoDLnKMORNFuy49xEitJduUcgE=
X-Google-Smtp-Source: APXvYqy0Mpy1mCfQ54M+vaErEBla7HHkf4O7w8C5QglGDz1S4gDi3rOFnkxpB5l4r30G2IFry0jnbre68yJjGfRSoEE=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr12955992otr.295.1582077479061; 
 Tue, 18 Feb 2020 17:57:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
 <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
 <CAL1e-=gaVz5K=JMg+iN53weESLORKEuXRJvq-SFqU7FERojP8Q@mail.gmail.com>
In-Reply-To: <CAL1e-=gaVz5K=JMg+iN53weESLORKEuXRJvq-SFqU7FERojP8Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 19 Feb 2020 02:57:34 +0100
Message-ID: <CAL1e-=iUHwE2_h0dxOE6vN_FoyRWyYA6LbL++T9BSB9X8heEcA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: multipart/alternative; boundary="000000000000258b32059ee41ec7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

--000000000000258b32059ee41ec7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2:54 AM Sre, 19.02.2020. Aleksandar Markovic <aleksandar.m.mail@gmail.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> 2:06 AM Sre, 19.02.2020. Finn Thain <fthain@telegraphics.com.au> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On Tue, 18 Feb 2020, Aleksandar Markovic wrote:
> >
> > > On Wednesday, January 29, 2020, Finn Thain <fthain@telegraphics.com.a=
u
>
> > > wrote:
> > >
> > > > Hi All,
> > > >
> > > > There are bugs in the emulated dp8393x device that can stop packet
> > > > reception in a Linux/m68k guest (q800 machine).
> > > >
> > > > With a Linux/m68k v5.5 guest (q800), it's possible to remotely
trigger
> > > > an Oops by sending ping floods.
> > > >
> > > > With a Linux/mips guest (magnum machine), the driver fails to probe
> > > > the dp8393x device.
> > > >
> > > > With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
> > > > fatal to the guest kernel.
> > > >
> > > > Whilst debugging the device, I found that the receiver algorithm
> > > > differs from the one described in the National Semiconductor
> > > > datasheet.
> > > >
> > > > This patch series resolves these bugs.
> > > >
> > > > AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
> > > > ---
> > >
> > >
> > > Herve,
> > >
> > > Do your Jazz tests pass with these changes?
> > >
> >
> > AFAIK those tests did not expose the NetBSD panic that is caused by
> > mainline QEMU (mentioned above).
> >
> > I have actually run the tests you requested (Herv=C3=A9 described them =
in an
> > earlier thread). There was no regression. Quite the reverse -- it's no
> > longer possible to remotely crash the NetBSD kernel.
> >
> > Apparently my testing was also the first time that the jazzsonic driver
> > (from the Linux/mips Magnum port) was tested successfully with QEMU. It
> > doesn't work in mainline QEMU.
> >
>
> Well, I appologize if I missed all these facts. I just did not notice
them, at least not in this form. And, yes, some "Tested-by:" by Herve would
be desirable and nice.
>

Or, perhaps, even "Reviewed-by:".

> Yours,
> Aleksandae
>
> > Anyway, more testing is always nice, and I'd certainly welcome an
> > 'acked-by' or 'tested-by' if Herv=C3=A9 would like to send one.
> >
> > Please consider backporting this series of bug fixes to QEMU stable
> > branch(es).
> >
> > Regards,
> > Finn
> >
> > > Regards,
> > > Aleksandar
> > >
> > >
> > >
> > > > Changed since v1:
> > > >  - Minor revisions as described beneath commit logs.
> > > >  - Dropped patches 4/10 and 7/10.
> > > >  - Added 5 new patches.
> > > >
> > > > Changed since v2:
> > > >  - Minor revisions as described beneath commit logs.
> > > >  - Dropped patch 13/13.
> > > >  - Added 2 new patches.
> > > >
> > > > Changed since v3:
> > > >  - Replaced patch 13/14 with patch suggested by Philippe
Mathieu-Daud=C3=A9.
> > > >
> > > >
> > > > Finn Thain (14):
> > > >   dp8393x: Mask EOL bit from descriptor addresses
> > > >   dp8393x: Always use 32-bit accesses
> > > >   dp8393x: Clean up endianness hacks
> > > >   dp8393x: Have dp8393x_receive() return the packet size
> > > >   dp8393x: Update LLFA and CRDA registers from rx descriptor
> > > >   dp8393x: Clear RRRA command register bit only when appropriate
> > > >   dp8393x: Implement packet size limit and RBAE interrupt
> > > >   dp8393x: Don't clobber packet checksum
> > > >   dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
> > > >   dp8393x: Pad frames to word or long word boundary
> > > >   dp8393x: Clear descriptor in_use field to release packet
> > > >   dp8393x: Always update RRA pointers and sequence numbers
> > > >   dp8393x: Don't reset Silicon Revision register
> > > >   dp8393x: Don't stop reception upon RBE interrupt assertion
> > > >
> > > >  hw/net/dp8393x.c | 202
+++++++++++++++++++++++++++++++----------------
> > > >  1 file changed, 134 insertions(+), 68 deletions(-)
> > > >
> > > > --
> > > > 2.24.1
> > > >
> > > >
> > > >
> > >

--000000000000258b32059ee41ec7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">2:54 AM Sre, 19.02.2020. Aleksandar Markovic &lt;<a href=3D"=
mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; 2:06 AM Sre, 19.02.2020. Finn Thain &lt;<a href=3D"mailto:fthain@teleg=
raphics.com.au">fthain@telegraphics.com.au</a>&gt; =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; On Tue, 18 Feb 2020, Aleksandar Markovic wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On Wednesday, January 29, 2020, Finn Thain &lt;<a href=3D"ma=
ilto:fthain@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Hi All,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; There are bugs in the emulated dp8393x device that can =
stop packet<br>
&gt; &gt; &gt; &gt; reception in a Linux/m68k guest (q800 machine).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; With a Linux/m68k v5.5 guest (q800), it&#39;s possible =
to remotely trigger<br>
&gt; &gt; &gt; &gt; an Oops by sending ping floods.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; With a Linux/mips guest (magnum machine), the driver fa=
ils to probe<br>
&gt; &gt; &gt; &gt; the dp8393x device.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; With a NetBSD/arc 5.1 guest (magnum), the bugs in the d=
evice can be<br>
&gt; &gt; &gt; &gt; fatal to the guest kernel.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Whilst debugging the device, I found that the receiver =
algorithm<br>
&gt; &gt; &gt; &gt; differs from the one described in the National Semicond=
uctor<br>
&gt; &gt; &gt; &gt; datasheet.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; This patch series resolves these bugs.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; AFAIK, all bugs in the Linux sonic driver were fixed in=
 Linux v5.5.<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Herve,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Do your Jazz tests pass with these changes?<br>
&gt; &gt; &gt; <br>
&gt; &gt;<br>
&gt; &gt; AFAIK those tests did not expose the NetBSD panic that is caused =
by <br>
&gt; &gt; mainline QEMU (mentioned above).<br>
&gt; &gt;<br>
&gt; &gt; I have actually run the tests you requested (Herv=C3=A9 described=
 them in an <br>
&gt; &gt; earlier thread). There was no regression. Quite the reverse -- it=
&#39;s no <br>
&gt; &gt; longer possible to remotely crash the NetBSD kernel.<br>
&gt; &gt;<br>
&gt; &gt; Apparently my testing was also the first time that the jazzsonic =
driver <br>
&gt; &gt; (from the Linux/mips Magnum port) was tested successfully with QE=
MU. It <br>
&gt; &gt; doesn&#39;t work in mainline QEMU.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Well, I appologize if I missed all these facts. I just did not notice =
them, at least not in this form. And, yes, some &quot;Tested-by:&quot; by H=
erve would be desirable and nice.<br>
&gt;</p>
<p dir=3D"ltr">Or, perhaps, even &quot;Reviewed-by:&quot;.</p>
<p dir=3D"ltr">&gt; Yours,<br>
&gt; Aleksandae<br>
&gt;<br>
&gt; &gt; Anyway, more testing is always nice, and I&#39;d certainly welcom=
e an <br>
&gt; &gt; &#39;acked-by&#39; or &#39;tested-by&#39; if Herv=C3=A9 would lik=
e to send one.<br>
&gt; &gt;<br>
&gt; &gt; Please consider backporting this series of bug fixes to QEMU stab=
le <br>
&gt; &gt; branch(es).<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Finn<br>
&gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; Aleksandar<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Changed since v1:<br>
&gt; &gt; &gt; &gt;=C2=A0 - Minor revisions as described beneath commit log=
s.<br>
&gt; &gt; &gt; &gt;=C2=A0 - Dropped patches 4/10 and 7/10.<br>
&gt; &gt; &gt; &gt;=C2=A0 - Added 5 new patches.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Changed since v2:<br>
&gt; &gt; &gt; &gt;=C2=A0 - Minor revisions as described beneath commit log=
s.<br>
&gt; &gt; &gt; &gt;=C2=A0 - Dropped patch 13/13.<br>
&gt; &gt; &gt; &gt;=C2=A0 - Added 2 new patches.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Changed since v3:<br>
&gt; &gt; &gt; &gt;=C2=A0 - Replaced patch 13/14 with patch suggested by Ph=
ilippe Mathieu-Daud=C3=A9.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Finn Thain (14):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Mask EOL bit from descriptor addre=
sses<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Always use 32-bit accesses<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Clean up endianness hacks<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Have dp8393x_receive() return the =
packet size<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Update LLFA and CRDA registers fro=
m rx descriptor<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Clear RRRA command register bit on=
ly when appropriate<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Implement packet size limit and RB=
AE interrupt<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Don&#39;t clobber packet checksum<=
br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Use long-word-aligned RRA pointers=
 in 32-bit mode<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Pad frames to word or long word bo=
undary<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Clear descriptor in_use field to r=
elease packet<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Always update RRA pointers and seq=
uence numbers<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Don&#39;t reset Silicon Revision r=
egister<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0dp8393x: Don&#39;t stop reception upon RBE =
interrupt assertion<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 hw/net/dp8393x.c | 202 ++++++++++++++++++++++++++=
+++++----------------<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 134 insertions(+), 68 deletions(-=
)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; 2.24.1<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;</p>

--000000000000258b32059ee41ec7--

