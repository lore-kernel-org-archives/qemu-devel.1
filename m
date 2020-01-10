Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB2C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6565D205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcgceyrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6565D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0JS-0005Tx-BY
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iq0BJ-0002LJ-RR
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iq0BI-0006Ss-G4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:53 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:45096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iq0BI-0006Jo-8s
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:52 -0500
Received: by mail-oi1-x22f.google.com with SMTP id n16so2851731oie.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iOuOSyc9wjfQZVNf3uLAdiiSX40tvJj1DRMsJp182M0=;
 b=NcgceyrOHZs/xX2g512MwqXEnUyHs/bIDb2rhCmNlMwfmWqD4/z89IXFQ+PeQTRSGp
 CQLNG/pKN0A5Z5YZ7isc8BgJ2yNwWKVeI9kDo4D5DVVrrSaEwIb62JIKBkJVxG0Pr8j8
 xfzcpxJvYct+i2gOuHv45s83Vr3jSvo0EXYiVqRBmWb1AjmmFHVpIDvq/ivQdjA02C+Y
 5XF4ONzf0DIJcVNIlBLUnmvn2i+ThgMXWNA6Xm8I82nMnpcvPqV8RAYSwSQB+9J3qPOx
 K3HE7QNhaKZQ7Dym+H7u5oHcUQQ9uSy/73uDp5S14hdojdGqHwZyhJMhFd61UL9gb01K
 Xejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iOuOSyc9wjfQZVNf3uLAdiiSX40tvJj1DRMsJp182M0=;
 b=dErhXaPld74pxYV8ccu6YFAwYLs0CVBNAIBCcS03UjlZTZ8NaQ+sVrmrs8XEDL5zPK
 snMC4ThQpnrhXZO4oLslv4KgtQib4KfjQ8WV68LVFTBn0R++Sl05FBeo1JsN+UQKnLQP
 TPPQPnHPNq3hFWthP0eLz4Oh9lRpuXV/EAJt13kA1y+asSj6dNQfowEE5Ir83ReobV0V
 uvk6CPEOaQvm10yXxzvwvIkX/vCt8rI4bZDDPmN2Npz9NZAXK/iZ2u/bAZ/DCZINRXu/
 l0AZfpqyHQ3sLhrlgwohvqpAR+B63LDxZsQIwKjNVZ462qDyGHwzVYQR8u40kbnJi84i
 ncnA==
X-Gm-Message-State: APjAAAV3oYy4c2ok79poLkTwlaTs8tMa87AF4VmVeOKliwGYpEupDLBl
 e04MfbAqDRtLS+1qyXfA/PGy/ihqMwwFEzIHwWI=
X-Google-Smtp-Source: APXvYqy45LeF9YOTjZuzBYutQu0rS8NDILCBDQ2H1Gq8VioOwQttIe5SrSKHUQkX9o2Syejs7HcXDfFt7E1TRshaSNk=
X-Received: by 2002:aca:34c1:: with SMTP id b184mr3627548oia.62.1578685367660; 
 Fri, 10 Jan 2020 11:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
 <20200106064526.zh6rt4wbibfjrscu@sirius.home.kraxel.org>
In-Reply-To: <20200106064526.zh6rt4wbibfjrscu@sirius.home.kraxel.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 10 Jan 2020 20:42:31 +0100
Message-ID: <CAL1e-=iD+o7-MOuOAjtp0oEWA6ep9nXQuT0jeR7aOnuN1M6fqw@mail.gmail.com>
Subject: Re: [Qemu-devel] What should a virtual board emulate?
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008d3622059bce547e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008d3622059bce547e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

7:45 AM Pon, 06.01.2020. Gerd Hoffmann <kraxel@redhat.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>   Hi,
>
> > 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951 is the first bad commit
> > commit 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951
> > Author: Paolo Bonzini <pbonzini@redhat.com>
> > Date:   Tue Mar 19 15:37:19 2019 +0100
> >
> >     mips-fulong2e: obey -vga none
> >
> >     Do not create an ATI VGA if "-vga none" was passed on the command
line.
>
> > 1/ the Radeon chip is soldered on the motherboard,
> >
> > 2/ the default BIOS expects the Radeon chip to be
> >    unconditionally present,
> >
> > I insist this patch is incorrect for the particular case of the
Fuloong2e
> > board. I plan to revert it when I post the test.
>
> Yep.  IMHO devices which you can't unplug on the physical board should
> be present even with "qemu -nodefaults".
>

I have to agree with Philippe's approach. That is not to say that Zoltan's
efforts are not appreciated. Just that the patch in question that broke
Foolong scenario didn't fit quite well, however some other its
reincarnation may have better destiny.

Sincerely,
Aleksandar

> cheers,
>   Gerd
>
>

--0000000000008d3622059bce547e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">7:45 AM Pon, 06.01.2020. Gerd Hoffmann &lt;<a href=3D"mailto=
:kraxel@redhat.com">kraxel@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; =C2=A0 Hi,<br>
&gt;<br>
&gt; &gt; 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951 is the first bad commit<=
br>
&gt; &gt; commit 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951<br>
&gt; &gt; Author: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">=
pbonzini@redhat.com</a>&gt;<br>
&gt; &gt; Date:=C2=A0 =C2=A0Tue Mar 19 15:37:19 2019 +0100<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0mips-fulong2e: obey -vga none<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Do not create an ATI VGA if &quot;-vga none&qu=
ot; was passed on the command line.<br>
&gt;<br>
&gt; &gt; 1/ the Radeon chip is soldered on the motherboard,<br>
&gt; &gt; <br>
&gt; &gt; 2/ the default BIOS expects the Radeon chip to be<br>
&gt; &gt;=C2=A0 =C2=A0 unconditionally present,<br>
&gt; &gt; <br>
&gt; &gt; I insist this patch is incorrect for the particular case of the F=
uloong2e<br>
&gt; &gt; board. I plan to revert it when I post the test.<br>
&gt;<br>
&gt; Yep.=C2=A0 IMHO devices which you can&#39;t unplug on the physical boa=
rd should<br>
&gt; be present even with &quot;qemu -nodefaults&quot;.<br>
&gt;</p>
<p dir=3D"ltr">I have to agree with Philippe&#39;s approach. That is not to=
 say that Zoltan&#39;s efforts are not appreciated. Just that the patch in =
question that broke Foolong scenario didn&#39;t fit quite well, however som=
e other its reincarnation may have better destiny.</p>
<p dir=3D"ltr">Sincerely,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; cheers,<br>
&gt; =C2=A0 Gerd<br>
&gt;<br>
&gt;<br>
</p>

--0000000000008d3622059bce547e--

