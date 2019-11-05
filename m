Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A5CA9EC9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 00:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8474E20717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 00:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO/FzuVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8474E20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRmMa-0003oy-TZ
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 19:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRmLc-0003FO-EN
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 19:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRmLa-0007K9-TW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 19:05:24 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:37719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iRmLa-0007J4-NO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 19:05:22 -0500
Received: by mail-oi1-x233.google.com with SMTP id y194so15903425oie.4
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=zPgoE3B//bSof/a019IsxqWvW7UgErKOv+7ZZDNVtsI=;
 b=JO/FzuVRH9POOr2wJ+DGcaNZp46tgE6bYqU4Mo5MC/cKGT//aoUhn2g29hyC/GKdMx
 /rhYY2HwfTx3pvy6nNDvtE6WB2rmVsqw0gDEOhsX+G3LO2cG/UNkLkLkx71Z2Qr3eYnu
 rvNGtfDXTRdKwQvuaVkcF2udgYYAtHtlGz/9QRp7cwzLbyMljuPlaoqKnAHgKeeQygvc
 MjzvWS4gME9hbHNvjEzYnoPoZTehMjm7icKBTOG9Gta8GBXucB4bQzQyFT0dQIuHiDmo
 5mIg853dd5FeY964cCZisSmTPlaahVVquQN8rWkbVujhXM6SZ+dz9NYCd1DoP8q4WZy9
 vrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=zPgoE3B//bSof/a019IsxqWvW7UgErKOv+7ZZDNVtsI=;
 b=dJg71rTlQQtaaEGy7cguK3L8nWNTtWF9tbVJA4OLVTVWmHRm2M7K5qmj2hlS2cdj+D
 CQTmZrfd4fkK6t278Zww1waaFqvVTT4A3k513//MpC/mx/ZNj+VjEjDliJiV/KjewG8z
 tDAcHGMHXnwEUUfsukfiCkuLtpaqez2bapqDBJ+kk/enj5rx/gZB9X7PzcOHF5q5iS36
 Fo9QFckOwHZlpTpp8XTGUMZzf5N+HYqS/Pi/sEZNe7akfpaIKYXzwC2ulG/g5THDoryN
 ysqQ68CzNhYZkEwr8p2tc19bg6joXn9pyNnGxipSoMv9R3xAQ91tImCjEYlbqNMdYU7G
 oXyA==
X-Gm-Message-State: APjAAAW8pFVdH10sm8wRYNTirbZPItgPz8WefVNoj+GTkFjXhWXFPyrk
 UDNRIkf+MUY5YFqqHx+R0K8ZazNSrsJULOMrb/I=
X-Google-Smtp-Source: APXvYqzDmP5jE0lRPTn8sKyyDBSNO2VWEUpnS+cQMTV9Q5yTzFOnIe01JmW7VJdvUdlQ0tzDnilChjvokiiS1iKR7EE=
X-Received: by 2002:aca:62d5:: with SMTP id w204mr1503578oib.136.1572912321542; 
 Mon, 04 Nov 2019 16:05:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:6748:0:0:0:0:0 with HTTP;
 Mon, 4 Nov 2019 16:05:20 -0800 (PST)
In-Reply-To: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 5 Nov 2019 01:05:20 +0100
Message-ID: <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000303fbc05968e3037"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Alessandro Di Federico <ale@rev.ng>, "nizzo@rev.ng" <nizzo@rev.ng>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=C3=B2_Izzo?= <izzoniccolo@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000303fbc05968e3037
Content-Type: text/plain; charset="UTF-8"

On Friday, October 25, 2019, Taylor Simpson <tsimpson@quicinc.com> wrote:

> We would like inform the you that we will be doing a talk at the KVM Forum
> next week on QEMU for Qualcomm Hexagon.  Alessandro Di Federico, Niccolo
> Izzo, and I have been working independently on implementations of the
> Hexagon target.  We plan to merge the implementations, have a community
> review, and ultimately have Hexagon be an official target in QEMU.  Our
> code is available at the links below.
>
> *https://github.com/revng/qemu-hexagon
> <https://github.com/revng/qemu-hexagon>*
>
> *https://github.com/quic/qemu <https://github.com/quic/qemu>*
>
> If anyone has any feedback on the code as it stands today or guidance on
> how best to prepare it for review, please let us know.
>
>
>

Hi, Taylor, Niccolo (and Alessandro too).

I didn't have a chance to take a look at neither the code nor the docs, but
I did attend you presentation at KVM Forum, and I found it superb and
attractive, one of the best on the conference, if not the very best.

I just have a couple of general questions:

- Regarding the code you plan to upstream, are all SIMD instructions
implemented via tcg API, or perhaps some of them remain being implemented
using helpers?

- Most of SIMD instructions can be viewed simply as several paralel
elementary operations. However, for a given SIMD instruction set, usually
not all of them fit into this pattern. For example, "horizontal add"
(addind data elements from the same SIMD register), various
"pack/unpack/interleave/merge" operations, and more general
"shuffle/permute" operations as well (here I am not sure which of these are
included in Hexagon SIMD set, but there must be some). How did you deal
with them?

- What were the most challenging Hexagon SIMD instructions you came accross
while developing your solution?

Sincerely,
Aleksandar





> Thanks,
>
> Taylor
>

--000000000000303fbc05968e3037
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 25, 2019, Taylor Simpson &lt;<a href=3D"mailto:t=
simpson@quicinc.com">tsimpson@quicinc.com</a>&gt; wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal">We would like inform the you that we will be doing a=
 talk at the KVM Forum next week on QEMU for Qualcomm Hexagon.=C2=A0 Alessa=
ndro Di Federico, Niccolo Izzo, and I have been working independently on im=
plementations of the Hexagon target.=C2=A0 We
 plan to merge the implementations, have a community review, and ultimately=
 have Hexagon be an official target in QEMU.=C2=A0 Our code is available at=
 the links below.<u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in"><u><a href=3D"https://git=
hub.com/revng/qemu-hexagon" target=3D"_blank">https://github.com/revng/qemu=
-<wbr>hexagon</a></u><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in"><u><a href=3D"https://git=
hub.com/quic/qemu" target=3D"_blank">https://github.com/quic/qemu</a></u><u=
></u><u></u></p>
<p class=3D"MsoNormal">If anyone has any feedback on the code as it stands =
today or guidance on how best to prepare it for review, please let us know.=
<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div></div></blockquote><di=
v><br></div><div>Hi, Taylor, Niccolo (and Alessandro too).</div><div><br></=
div><div>I didn&#39;t have a chance to take a look at neither the code nor =
the docs, but I did attend you presentation at KVM Forum, and I found it su=
perb and attractive, one of the best on the conference, if not the very bes=
t.</div><div><br></div><div>I just have a couple of general questions:</div=
><div><br></div><div>- Regarding the code you plan to upstream, are all SIM=
D instructions implemented via tcg API, or perhaps some of them remain bein=
g implemented using helpers?</div><div><br></div><div>- Most of SIMD instru=
ctions can be viewed simply as several paralel elementary operations. Howev=
er, for a given SIMD instruction set, usually not all of them fit into this=
 pattern. For example, &quot;horizontal add&quot; (addind data elements fro=
m the same SIMD register), various &quot;pack/unpack/interleave/merge&quot;=
 operations, and more general &quot;shuffle/permute&quot; operations as wel=
l (here I am not sure which of these are included in Hexagon SIMD set, but =
there must be some). How did you deal with them?</div><div><br></div><div>-=
 What were the most challenging Hexagon SIMD instructions you came accross =
while developing your solution?</div><div><br></div><div>Sincerely,</div><d=
iv>Aleksandar</div><div><br></div><div><br></div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div lang=3D"EN-US" link=3D"#0563C1" v=
link=3D"#954F72"><div>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Taylor<u></u><u></u></p>
</div>
</div>

</blockquote>

--000000000000303fbc05968e3037--

