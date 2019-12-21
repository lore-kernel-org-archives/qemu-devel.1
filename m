Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3082FC2D0C3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 18:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF582070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iiao2gsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF582070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iijDd-0001pG-2j
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 13:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iijCk-00015V-Tl
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 13:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iijCj-0005HH-A8
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 13:10:18 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iijCj-0005DQ-0u; Sat, 21 Dec 2019 13:10:17 -0500
Received: by mail-oi1-x243.google.com with SMTP id h19so5904228oih.4;
 Sat, 21 Dec 2019 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dCkkWWgZCiYfmg2QJJcmgGsbE7ykXCBuzZSq3XwzsXk=;
 b=Iiao2gsJMEgnIvdvhEnse3nA8IFGdXRaDfBjGqC3Uv2sbEs+xRWqRLLRyI/C9Fxsut
 b14CQ3cCwsP5FCEkjXtRcAYF2gxJAC7K+MxhXEJlVSIf0+bq/5bGmHemh9OTDgS4g74E
 aUxnyPg9PhT6rw2Hl5U1z/w86i7LoOqqIaLOxLSzZ5lMAdJXFz799DQt1Qrb3P4IOSJs
 X4glP5qD0lZJ2njwmbfh4ZKRcGy/Z/8EQOS2Vbps8fj9vEAugdgyz4KoINYQxKZBffPk
 qUP4SejT/+Lc6UPgLOSYwlOCBE3j67kKhkjUie4Z9raFPZc4KIilRO+W+5t3Ww4kB1XA
 1r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dCkkWWgZCiYfmg2QJJcmgGsbE7ykXCBuzZSq3XwzsXk=;
 b=ij9avwxJ+41G4Jf2Zk4bz95rgm7HE41NWYRlpi96fMz1B8ytdWx4OQe0obrq+hHwyH
 RoRpAQRDsH6QS6zsmEXBNC+s067TGGmjG7Rd1PQzwOLrGh2jRaBYzo8yRY3UQqm2gYyI
 xKcaZDDINMDEXUGBmApFji5G5darFGVnWGBjBbtbb2wbYFIPInRh3Cq55dJFy22qMiZ7
 VcoP/OKoLlPhlsH9n7aRzyzEYRlpFcCTb1xs6YODIXYRhuMrYk6kW/mdqNLV9xgzvFJR
 eNEjGm8ltpfBZ96jFPEwPgc2amWzsDCCqbD30rjle/fldfsjNHpWgLpk9O8pA/BAlpIS
 ry5Q==
X-Gm-Message-State: APjAAAXPeyNpklj6ptQr+D1MKR9rV6Lxs+5us3YTeJquIjOGSNyC7OAw
 B4PlVPfo/zEvCPizqJ3xS9O6SGg0OhSpWMor1Ew=
X-Google-Smtp-Source: APXvYqxZbPBiVgmC7hN8epfnjvH4deG7idXRd5VjMjncywrKEiwopes56r0Mj4PzfvCJDi3MoiXHhZ+2EICSt+yOMDo=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr4968718oib.106.1576951815962; 
 Sat, 21 Dec 2019 10:10:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 21 Dec 2019 10:10:15 -0800 (PST)
In-Reply-To: <7c8bc635-96cc-ab3d-01d3-db97013cda3e@redhat.com>
References: <8736dfdkph.fsf@dusky.pond.sub.org>
 <7c8bc635-96cc-ab3d-01d3-db97013cda3e@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 21 Dec 2019 19:10:15 +0100
Message-ID: <CAL1e-=iuu9ZAJ_Z4qEvRtydd7-tcXVUzdZDeZPw8VHCP0QYT3A@mail.gmail.com>
Subject: Re: Can we retire Python 2 now?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d18774059a3ab486"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d18774059a3ab486
Content-Type: text/plain; charset="UTF-8"

On Saturday, December 21, 2019, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 20/12/19 17:29, Markus Armbruster wrote:
> > Python 2 EOL is only a few days away[*].  We made configure bitch about
> > it in commit e5abf59eae "Deprecate Python 2 support", 2019-07-01.  Any
> > objections to retiring it now, i.e. in 5.0?
> >
> > Cc'ing everyone who appears to be maintaining something that looks like
> > a Python script.
> >
> > [*] https://pythonclock.org/
>
> Fortunately Betteridge's law of headlines is not always true.  :)
>
>
Perhaps we can formulate a new law that says:

"Any person who says that he/she is pretty sure he/she is not a maintainer
of something at all, is, in fact, and for sure, the maintainer of that
thing."

:)

Aleksandar

Paolo
>
>
>

--000000000000d18774059a3ab486
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 21, 2019, Paolo Bonzini &lt;<a href=3D"mailto=
:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On 20/12/19 17:29, Markus Armbruster wrote:<br>
&gt; Python 2 EOL is only a few days away[*].=C2=A0 We made configure bitch=
 about<br>
&gt; it in commit e5abf59eae &quot;Deprecate Python 2 support&quot;, 2019-0=
7-01.=C2=A0 Any<br>
&gt; objections to retiring it now, i.e. in 5.0?<br>
&gt; <br>
&gt; Cc&#39;ing everyone who appears to be maintaining something that looks=
 like<br>
&gt; a Python script.<br>
&gt; <br>
&gt; [*] <a href=3D"https://pythonclock.org/" target=3D"_blank">https://pyt=
honclock.org/</a><br>
<br>
Fortunately Betteridge&#39;s law of headlines is not always true.=C2=A0 :)<=
br>
<br></blockquote><div><br></div><div>Perhaps we can formulate a new law tha=
t says:</div><div><br></div><div>&quot;Any person who says that he/she is p=
retty sure he/she is not a maintainer of something at all, is, in fact, and=
 for sure, the maintainer of that thing.&quot;</div><div><br></div><div>:)<=
/div><div><br></div><div>Aleksandar</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
Paolo<br>
<br>
<br>
</blockquote>

--000000000000d18774059a3ab486--

