Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 00:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649CC20748
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 00:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqlhig1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649CC20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZOHt-0005VY-JC
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 19:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZOGX-0004Wg-U7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZOGW-0000VF-KZ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:59:37 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:39409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZOGW-0000U0-Fs
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:59:36 -0500
Received: by mail-oi1-x231.google.com with SMTP id v138so14933772oif.6
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=cxD/1Mkh2cW7gJIgBC9LAhbgtS/10Z7ZEDjjxqBlk3Q=;
 b=nqlhig1Tw4RbBsbbrsA+nOvsWuR3AAljUAFtMsDQJu31Yte8T1IojV247Cn6N7rC9j
 npkeTFCOFEL6JOinD934TU+43LDHP5fxO7blP4N7RdiADBiSr7INqUh+skiuIjDZm6qP
 GZtrG+i14XdgaLNlX3KP6Pw9UScWhaORdQaFB3H1GB5S2nsAYQMrJSx6PhoKA1bJb3Sv
 gXH/P3E/B/ozSXRZ/mXHBODMU2Mfka9ykn+Wn5Eo8qYc2FOdPhbnM99HQknHU8Yvs9ZU
 Onla7PZGA4n0YlQ0tbc7l7dfPOdJ7DGg+u3hh1s87CaPy41ysKIlLO7iarlFMVN3Te3b
 DZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=cxD/1Mkh2cW7gJIgBC9LAhbgtS/10Z7ZEDjjxqBlk3Q=;
 b=FJU5OaHtR1dIiwhjpRCNY6F9p1Sw+wWBNZORlBX2cxT7Ci2Y54t6wwMe77mxxMgcUP
 tgkQE60K3rx1lIV5Ek1dgvwka+N0YeeyYZ9BbfroV27bCZBhv6B8yd6bvDNhlIBU4lcl
 loYs2UrMQcywkjj3Pho9tTglySZ/hMh7fnj4fw/F4k7As5OH2kaVIxrOyuNup0Ms678N
 nQ8k06zYk+q3UIIPJntXsw4Yj7jEL56szLz7y+FpI0yBWporhtkJZXIAprQqUOvU8seK
 Mhn/9p89R99TXIDHHf1y/avL5Xen8B4lkYxeRh7qy2Ukj+Nrc6JgpGTM3KsbVjTkSUtm
 NHwQ==
X-Gm-Message-State: APjAAAVU6S1WFvZJYgX9jqrSF3NLxMnhm7Z4bgyMe+HnWamqkF97pTsp
 K9I2SMfuBxaz0bupSLYotknucYmTpBQv040yVyo=
X-Google-Smtp-Source: APXvYqxL+9PYaTi6gQrLb2Zx8zCTasUDueuQp/qbShPfxcjIv0Nl2bDYj0tsKhUAsckCOIGF1nMF9x7qE/DIT5xa+WI=
X-Received: by 2002:aca:670b:: with SMTP id z11mr1128222oix.79.1574726364356; 
 Mon, 25 Nov 2019 15:59:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Mon, 25 Nov 2019 15:59:23
 -0800 (PST)
In-Reply-To: <5edee836-b97b-57fb-70fb-9b6b6bc44a52@redhat.com>
References: <CAL1e-=gmaimCBh5NBBYFp6Z1ci4ZheQtXpyjU9Uexqi4zSHh2A@mail.gmail.com>
 <CAL1e-=i-u5eR7Fk_Muobbe0-Viim0iPceHoEGtJWCq7L1o9teA@mail.gmail.com>
 <5edee836-b97b-57fb-70fb-9b6b6bc44a52@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 00:59:23 +0100
Message-ID: <CAL1e-=ijZQrDw6ABJcJ6DPD=VmAXgOCHdy+qE63Jd6jkLefu4A@mail.gmail.com>
Subject: Re: [QUESTION] What is the best license option for new files
 introduced in QEMU?
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000090e60d0598348d5c"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000090e60d0598348d5c
Content-Type: text/plain; charset="UTF-8"

On Monday, November 25, 2019, Eric Blake <eblake@redhat.com> wrote:

> On 11/25/19 1:25 PM, Aleksandar Markovic wrote:
>
> Thomas pointed to me that I mixed up GPL and LGPL - which is true.
>>
>> Still, the question remains with these options:
>>
>> * GPL 2.0
>>
>
> Not good. It artificially limits who can reuse this code.
>
> * GPL 2.0 + wording "or later (at your option)"
>>
>
> Matches what qemu itself uses, so fine; but makes it harder to reuse the
> code in a standalone library.
>
> * LGPL 2.1
>>
>
> Same problems as GPL2-only
>
> * LGPL 2.1 + wording "or later (at your option)"
>>
>
> Looser than qemu as a whole, has all the benefits of GPL2+ plus the
> additional benefit of being able to copy the code into other LGPL
> standalone libraries.
>
> It's also acceptable to use even looser licenses, like BSD 2-clause, but
> preferably only if that other license is already used by part of qemu (we
> don't need to make our mix even worse than it already is).
>
>
>> The context of my question is that I am reviewing a series that came
>> with files with different license preambles (or without it at all), and I
>> want to advice the submitters on the best option.
>>
>
> You may also want advice from lawyers, based on how you see your code
> being reused outside of qemu.  This list can offer advice, but it is
> non-binding and may not best fit your needs.
>
>
I truly appreciate your response!

-- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--00000000000090e60d0598348d5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Eric Blake &lt;<a href=3D"mailto:ebla=
ke@redhat.com">eblake@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">On 11/25/19 1:25 PM, Aleksandar Markovic wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Thomas pointed to me that I mixed up GPL and LGPL - which is true.<br>
<br>
Still, the question remains with these options:<br>
<br>
* GPL 2.0<br>
</blockquote>
<br>
Not good. It artificially limits who can reuse this code.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
* GPL 2.0 + wording &quot;or later (at your option)&quot;<br>
</blockquote>
<br>
Matches what qemu itself uses, so fine; but makes it harder to reuse the co=
de in a standalone library.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
* LGPL 2.1<br>
</blockquote>
<br>
Same problems as GPL2-only<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
* LGPL 2.1 + wording &quot;or later (at your option)&quot;<br>
</blockquote>
<br>
Looser than qemu as a whole, has all the benefits of GPL2+ plus the additio=
nal benefit of being able to copy the code into other LGPL standalone libra=
ries.<br>
<br>
It&#39;s also acceptable to use even looser licenses, like BSD 2-clause, bu=
t preferably only if that other license is already used by part of qemu (we=
 don&#39;t need to make our mix even worse than it already is).<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
The context of my question is that I am reviewing a series that came<br>
with files with different license preambles (or without it at all), and I<b=
r>
want to advice the submitters on the best option.<br>
</blockquote>
<br>
You may also want advice from lawyers, based on how you see your code being=
 reused outside of qemu.=C2=A0 This list can offer advice, but it is non-bi=
nding and may not best fit your needs.<br>
<br></blockquote><div><br></div><div>I truly appreciate your response!</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" target=3D"_blank">qemu.or=
g</a> | <a href=3D"http://libvirt.org" target=3D"_blank">libvirt.org</a><br=
>
<br>
</blockquote>

--00000000000090e60d0598348d5c--

