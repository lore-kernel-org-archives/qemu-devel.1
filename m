Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0E2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 22:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7822B20721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 22:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTv/iJ06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7822B20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipgF2-00065E-JU
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 17:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipgEH-0005eO-53
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 17:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipgEF-0006Md-Ra
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 17:24:36 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:42991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipgEE-0006JE-0V
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 17:24:35 -0500
Received: by mail-oi1-x231.google.com with SMTP id 18so150802oin.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
 bh=BWp7K5j445TTBRacWxhIcF9R0ZbN0HSt4DB66NUOqEU=;
 b=GTv/iJ06scPe+GNf5ap1Gl7+0uvDvYJDE5TN8+mhw+ST2S7FP5EQkPz66XLsuckz0N
 nD/43sMSW9Uz1hXXDDn5SsgDEzz6wAEUTPYBnqgaV0mHuBMdE+H7p/ZAb8VR4i2RqMJx
 qp1YapRCnZIwiS/aTofXvcvIROTpmMHqCs0x62BIOMDX5dyNt+MozrJa6j6KQaTqrvzc
 +mQT/SLj/cdETpuw2vlHVyGVxgSOy+ME9n47XiCUFfFGM26x/eZNEz4B2RuUe66pVPMf
 kLhqVcK1rNkSFpfFsnB66uIKPZLIAXNcvpl8CC8IFKotYtqt76MqUZzEWizdcQfJyFMG
 3lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to;
 bh=BWp7K5j445TTBRacWxhIcF9R0ZbN0HSt4DB66NUOqEU=;
 b=SMAYVkDFRy6OUcnkt+HdnoSDfziAP1xky64cCZHk75NN1Jdp2IP4XTwh3cRffQDiCD
 b6IjarWKzRIehIvHML953zVtIzuEEBwl5e9fWLpgrcwW3zkNiW0KzqmCHOhGMx6I9qED
 NqZZ8N7kbcERmdpPckA1P6dS9G50DQZHEHDEeKVNSRpK9wNeg/tY7Qh5MtKPWZn6iAmj
 nF6qjUw8tQq0anMKJcTq/vWXMp3HgYkJt6oAOvHUZSte+5E5Z4iUPmZ647Q6C5Wgnprw
 hjXBkYZ4zXsfsuMxBOvKaZ0Tyzh0cx1am9SLmRjJbWgWQVwt/nIrVf+NIEeUwxj/6J22
 ge2Q==
X-Gm-Message-State: APjAAAU6l2QPbqvXqGZLPs1Qg1McGBjJp89usu5xeYQ5CvWQU9r1sKUr
 qBMIw3wE4myp+wleA1AQUr9ttsgNIvEp7dx006IZnQ==
X-Google-Smtp-Source: APXvYqwrkB4oPMzpvRob0EJ+BFs4qJuwRFMr8Nq5r0ikLj3YoY+FM+uqdHpeARacWQOAMxDwu7nwDSXPnI80tnrWsT8=
X-Received: by 2002:aca:f505:: with SMTP id t5mr5192355oih.136.1578608672418; 
 Thu, 09 Jan 2020 14:24:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 14:24:31 -0800 (PST)
In-Reply-To: <CAL1e-=hubhT9DDN9Co=CafNz=3vSUtfDF=ukshOGjU7=a9BbXA@mail.gmail.com>
References: <CAL1e-=hubhT9DDN9Co=CafNz=3vSUtfDF=ukshOGjU7=a9BbXA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 23:24:31 +0100
Message-ID: <CAL1e-=jEv+h7R_DJJ5TP+wxvMisfPUwh40ze80jBvj3DmyO0Ww@mail.gmail.com>
Subject: Re: version 3.2 is missing from QEMU download page
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000028b00a059bbc7933"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000028b00a059bbc7933
Content-Type: text/plain; charset="UTF-8"

On Thursday, January 9, 2020, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> Hi all,
>
> For some reason, QEMU download page
>
> https://download.qemu.org
>
> seems to contain tarballs of all QEMU versions/releases, except 3.2 and
> its follow-ups. This broke up some scripts that rely on presence of all
> versions on that page.
>
> Hm, sorry, I think I for some reason thought that 3.2 must have existed,
but it looks we had only  3.0 and 3.1 in 2018.

Sorry for the noise,
Alwksandar



> I don't know who is in charge of QEMU download page, but I would like to
> ask anyone with this power to fix the absence of 3.2, if possible.
>
> Thanks in advance,
> Aleksandar
>

--00000000000028b00a059bbc7933
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi all,<div><br></div><div>For some rea=
son, QEMU download page</div><div><br></div><div><a href=3D"https://downloa=
d.qemu.org" target=3D"_blank">https://download.qemu.org</a><br></div><div><=
br></div><div>seems to contain tarballs of all QEMU versions/releases, exce=
pt 3.2 and its follow-ups. This broke up some scripts that rely on presence=
 of all versions on that page.</div><div><br></div></blockquote><div>Hm, so=
rry, I think I for some reason thought that 3.2 must have existed, but it l=
ooks we had only =C2=A03.0 and 3.1 in 2018.</div><div><br></div><div>Sorry =
for the noise,</div><div>Alwksandar</div><div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div>I don&#39;t know who is in charge of QEMU=
 download page, but I would like to ask anyone with this power to fix the a=
bsence of 3.2, if possible.</div><div><br></div><div>Thanks in advance,</di=
v><div>Aleksandar</div>
</blockquote>

--00000000000028b00a059bbc7933--

