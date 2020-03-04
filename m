Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900CAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E0C2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E0C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SfJ-0002fP-Jt
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j9SeW-0001pu-PE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j9SeV-0001cZ-KK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:57:28 -0500
Received: from mail-yw1-f52.google.com ([209.85.161.52]:44340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j9SeV-0001cL-G7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:57:27 -0500
Received: by mail-yw1-f52.google.com with SMTP id t141so1620115ywc.11
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 03:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9aHZsipCStuuKiHnRRhsVvu7qYR/8zxyZKfN4WPF6qU=;
 b=f6G1tXuaQAS/xVXMycJlI4RdYanCGHREfxJhUhYC0V6VEcxUdBJLOWMu1GmWNbJUB4
 q9ZIdMyPd8aSjEk7KOj+SQiJJYwKpR1jH1Q5g9zjuw6l0Ko8ECCZJ6qRLBfGhGH+4tgv
 ovCE5QmSncKdz3rfqwj3wN0qzk3dPlil/yVM9G+71cBlSRAY/fLELJ6MIF2rQvuYJg46
 xaw+NEGIVgIDVJhc1FvyxiZD/Ku2eKe5XHcWy/amn2c2djiSRMqocFKo3nF58Ds6Yt7v
 uqnHUlFmP02EMzJCROo3KzFHfXgAclYgIZzYlTcm6OWkiYKslpw/J7YnBfekvRhNuV/t
 ZaYQ==
X-Gm-Message-State: ANhLgQ1uhQ9qu85R77DYr8zDQj9Sq3YNkoQE2DeM2emFiOen6NLv0Ggj
 hgBDha6n4kwkJ+l/XDTk4LFVKtIZonvrxwdKn1vJpKbuZqA=
X-Google-Smtp-Source: ADFU+vsjlzaEsM0SHCw7IbZxFWBt9gTAq2VMmc+Gu46l64M7jB+8R5k84QqBUI0WzD+Q3QB0AgH7dnq/AdaU3Aep6YI=
X-Received: by 2002:a25:69c1:: with SMTP id e184mr2005374ybc.316.1583323046723; 
 Wed, 04 Mar 2020 03:57:26 -0800 (PST)
MIME-Version: 1.0
References: <b4440411-cc60-cd7e-988e-458baf0c8b6d@xcancerberox.com.ar>
In-Reply-To: <b4440411-cc60-cd7e-988e-458baf0c8b6d@xcancerberox.com.ar>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 4 Mar 2020 12:57:14 +0100
Message-ID: <CAAdtpL4Fg3rjxOXxGA=sSLpsXrT1E0Ko1kjt1YugvRCtKPi-hw@mail.gmail.com>
Subject: Re: Wiki user request
To: Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: multipart/alternative; boundary="000000000000c3c65305a0061f8e"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.52
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c3c65305a0061f8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

Le jeu. 27 f=C3=A9vr. 2020 10:29, Joaquin de Andres <me@xcancerberox.com.ar=
> a
=C3=A9crit :

> Hi!
>
> I wonder if I can get write access to the wiki page. I'm working with
> Philippe Mathieu-Daud=C3=A9 in the GSoC Arduino Visualization project ([1=
])
> and I need to modify and add pages.
>
> Thanks!
> --joa
>
> [1] https://wiki.qemu.org/Internships/ProjectIdeas/ArduinoVisualisation
>
>

--000000000000c3c65305a0061f8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Ping?<br><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">Le jeu. 27 f=C3=A9vr. 2020 10:29, Joaquin de Andr=
es &lt;<a href=3D"mailto:me@xcancerberox.com.ar">me@xcancerberox.com.ar</a>=
&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi!<br>
<br>
I wonder if I can get write access to the wiki page. I&#39;m working with<b=
r>
Philippe Mathieu-Daud=C3=A9 in the GSoC Arduino Visualization project ([1])=
<br>
and I need to modify and add pages.<br>
<br>
Thanks!<br>
--joa<br>
<br>
[1] <a href=3D"https://wiki.qemu.org/Internships/ProjectIdeas/ArduinoVisual=
isation" rel=3D"noreferrer noreferrer" target=3D"_blank">https://wiki.qemu.=
org/Internships/ProjectIdeas/ArduinoVisualisation</a><br>
<br>
</blockquote></div></div></div>

--000000000000c3c65305a0061f8e--

