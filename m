Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5DAC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B662720867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLuH5SR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B662720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLEP-0008V6-5D
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iGK7Y-0002lN-4y
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iGK7W-0001GF-Nm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:43:32 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:44650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iGK7W-0001Bg-GJ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:43:30 -0400
Received: by mail-oi1-x231.google.com with SMTP id w6so5197292oie.11
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WFSJAYRpaoyLsENzTQ+K8D+e8lIzy7q2m2Khfcg/0Bo=;
 b=nLuH5SR+miQm3V/AOXaRm7FieAaXGJNISlk+4sUtdFHjERVZ2NOWMFyzD10Sq8zyrX
 32ELk0Pwb2KWsnxaPDhOlzzNAAJL4KMUfLRZIkI9hFNvB9uw70xxA4qMo6893POOCXD8
 GMM3SStaZJFvky7s8kjnl4XRz2EyZXGji/Awzcv+/BCUw41W2MiutfMFaluWRovBfFyK
 Nk9xytN7iX5AGf0akmAXVy6TKI2S1nAuuDoELsut/4VyOARpwq+nFi33EMtWjtEI8Bi5
 nmdghGcjsD5cdM/vjheytnNTZkOWbT1REhCbFQzdIdWNqoC3/FarXPVbcI0wGy2afVSJ
 L3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WFSJAYRpaoyLsENzTQ+K8D+e8lIzy7q2m2Khfcg/0Bo=;
 b=IRriEvBj230WddkDocDvEvZtHXKsCFIwfpsokuIcMbDrdGGctWYhS6h2VHladcd2m/
 ZPWae2HUmaekupwqMj0qbmGf9Q2GrJKuF3P0b2PP8S/+XtMDgXiW+OCj6xFfUO2ShO61
 rXeW2aU3c6s2Ndd2AP2Eb41sxmCliWJgVMqbNp/WrvHXxayVhZ3mgAm7ZBt1qOgTMyvl
 ZYW34fpJak8LCmm3Yk6LMgb8m1SsGQw26BCVNOjKHqNEgNP7pNGzYEGrGhpz4Bm0W3ZE
 NhEPWQZ2AdcIaM3/q2EMsPbb+GiSQDoIEoXUofrLpa9vUzZm9PJBHP1AYLT8PrWNzO8y
 CMSw==
X-Gm-Message-State: APjAAAWZJZRZMLDbAEFq1c15/lYS6Xvl7qPWPbbHt6aoX8XsC2LFXQeg
 XACPGNzQtM7kf6ye31F8/VAPUrT8RqKTwkR9ZNk=
X-Google-Smtp-Source: APXvYqySg9k5SbI9QleX7Taou1tfR1E4E7y0IkmOYLDlh4V8/t/3wFUnOgH/ZgXcSexzXO+z9fK//43ueh5vZs3csBQ=
X-Received: by 2002:aca:5ad7:: with SMTP id o206mr6473406oib.59.1570182207393; 
 Fri, 04 Oct 2019 02:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20160915151441.12160.56338.malonedeb@gac.canonical.com>
 <156990182871.21256.13331111233039136696.malone@chaenomeles.canonical.com>
In-Reply-To: <156990182871.21256.13331111233039136696.malone@chaenomeles.canonical.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 4 Oct 2019 11:43:16 +0200
Message-ID: <CABLmASFaiFgKTBhS3CYX0p5eH4uMDpmcaz5d+xAyBUqZxZVOfw@mail.gmail.com>
Subject: Re: [Bug 1623998] Re: pulseaudio Invalid argument error
To: Bug 1623998 <1623998@bugs.launchpad.net>
Content-Type: multipart/alternative; boundary="000000000000b452c10594128886"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b452c10594128886
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 1, 2019 at 6:06 AM Thomas Huth <1623998@bugs.launchpad.net>
wrote:

> Triaging old bug tickets ... Can you still reproduce this issue with the
> latest version of QEMU (currently 4.1)? Or could we close this ticket
> nowadays?
>
> ** Changed in: qemu
>        Status: New => Incomplete
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1623998
>
> Title:
>   pulseaudio Invalid argument error
>
> Status in QEMU:
>   Incomplete
>
> Bug description:
>   When using qemu-system-ppc on Ubuntu Mate 15 with the usb audio card,
>   I see these error messages:
>
>   pulseaudio: set_sink_input_volume() failed
>   pulseaudio: Reason: Invalid argument
>   pulseaudio: set_sink_input_mute() failed
>   pulseaudio: Reason: Invalid argument
>
>   No audio plays. When an attempt is made, QEMU seems to freeze for a
>   moment.
>
>   I use "-device usb-audio" to add the usb sound card. This issue is
>   present in both emulation and KVM mode.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1623998/+subscriptions


Hi

This is still visible with both current master and Gerd's queue/audio
branch compiled on Fedora 30.
Additionally, running qemu-system-ppc with Mac OS 9.2 guest and -device
usb-audio results in the icons on the guest desktop to disappear after a
few seconds. Before that happens, audio is playable OK.

Best,
Howard

--000000000000b452c10594128886
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 2019 at 6:06 AM Thomas=
 Huth &lt;<a href=3D"mailto:1623998@bugs.launchpad.net">1623998@bugs.launch=
pad.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Triaging old bug tickets ... Can you still reproduce this issue with=
 the<br>
latest version of QEMU (currently 4.1)? Or could we close this ticket<br>
nowadays?<br>
<br>
** Changed in: qemu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Status: New =3D&gt; Incomplete<br>
<br>
-- <br>
You received this bug notification because you are a member of qemu-<br>
devel-ml, which is subscribed to QEMU.<br>
<a href=3D"https://bugs.launchpad.net/bugs/1623998" rel=3D"noreferrer" targ=
et=3D"_blank">https://bugs.launchpad.net/bugs/1623998</a><br>
<br>
Title:<br>
=C2=A0 pulseaudio Invalid argument error<br>
<br>
Status in QEMU:<br>
=C2=A0 Incomplete<br>
<br>
Bug description:<br>
=C2=A0 When using qemu-system-ppc on Ubuntu Mate 15 with the usb audio card=
,<br>
=C2=A0 I see these error messages:<br>
<br>
=C2=A0 pulseaudio: set_sink_input_volume() failed<br>
=C2=A0 pulseaudio: Reason: Invalid argument<br>
=C2=A0 pulseaudio: set_sink_input_mute() failed<br>
=C2=A0 pulseaudio: Reason: Invalid argument<br>
<br>
=C2=A0 No audio plays. When an attempt is made, QEMU seems to freeze for a<=
br>
=C2=A0 moment.<br>
<br>
=C2=A0 I use &quot;-device usb-audio&quot; to add the usb sound card. This =
issue is<br>
=C2=A0 present in both emulation and KVM mode.<br>
<br>
To manage notifications about this bug go to:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+bug/1623998/+subscriptions" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1623=
998/+subscriptions</a></blockquote><div><br></div><div>Hi</div><div><br></d=
iv><div>This is still visible with both current master and Gerd&#39;s queue=
/audio branch compiled on Fedora 30.<br></div><div>Additionally, running qe=
mu-system-ppc with Mac OS 9.2 guest and -device usb-audio results in the ic=
ons on the guest desktop to disappear after a few seconds. Before that happ=
ens, audio is playable OK. <br></div><div><br></div><div>Best,</div><div>Ho=
ward<br></div><div><br></div><div>=C2=A0</div></div></div>

--000000000000b452c10594128886--

