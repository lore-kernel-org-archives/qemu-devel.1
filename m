Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745D5C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403A82072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403A82072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqRe-0002DP-Ai
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipqQi-0001mQ-79
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipqQg-00035j-PM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:18:08 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipqQg-00034f-Jd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:18:06 -0500
Received: by mail-yw1-f67.google.com with SMTP id 192so420329ywy.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 01:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zmk7cMCfwSD+03N2dOm+gwYXuFQX/06A/eSjGo4+P4g=;
 b=GMe40CYZcJa8pILEvhNziCyPxO0dnSxlyK9iUUu3PiNB1AQsv8ClhtHKPA+2YK5311
 GhcXE8KxXCTG4xJ2r5RWuZ7/3v/r4vkbPbIfKTSdpZ/3W7wKiJwVoTWRVXgNq75BGyXC
 iAdXAyxcE6OHQpBnmKcwonjxClAX8X3VCxBup9+/hROpgsTkgBNSOaXA3817n7zzMKhG
 mh99cvmI/CIAb8oGeupTuU22nVqLXes4q7SSTXrlaqZb1RjJE5icFM46bj0cyxV33jMl
 cF62IfO3iVAHK6PKPcMEZFar7CRDB0xcxl8ShlaW2Pkq1gcdzCT+ME0Pd0J1eLWV2tQ2
 C00g==
X-Gm-Message-State: APjAAAUE2W1L//ZG4BjjIuRA4JpIVwc5JEB+hJ7a57XVNrP0AUmMhCpT
 PiZVB3GEvAoruT0mPuwWH/BbTAwego3Zhz864JQ=
X-Google-Smtp-Source: APXvYqyyHIJrEBeNiBZfTc5Q168Ij8CR0AP3ZviuPW9Gs5n7tOsGeomhCeEurpMvE1pLKgwahbb7TYgDp46Rq2FF4gw=
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr1846754ywa.37.1578647886021; 
 Fri, 10 Jan 2020 01:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20200109153939.27173-1-philmd@redhat.com>
 <d94666ae-df03-0162-e3d0-e0038b68da83@vivier.eu>
In-Reply-To: <d94666ae-df03-0162-e3d0-e0038b68da83@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 10 Jan 2020 10:17:53 +0100
Message-ID: <CAAdtpL69XLuoZNEank0dC9M-tWCKhJqFKO46u5jjeLpf4TF=Pg@mail.gmail.com>
Subject: Re: [PATCH 0/4] buildsys: Build quicker (mostly tools and linux-user)
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="00000000000078c8ac059bc59afc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.67
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000078c8ac059bc59afc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 10 janv. 2020 09:36, Laurent Vivier <laurent@vivier.eu> a =C3=A9cri=
t :

> Le 09/01/2020 =C3=A0 16:39, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> > In some configuration (linux-user, tools) we can ignore building
> > various objects (and the libfdt).
> >
> > Philippe Mathieu-Daud=C3=A9 (4):
> >   configure: Do not build libfdt is not required
> >   Makefile: Clarify all the codebase requires qom/ objects
> >   Makefile: Restrict system emulation and tools objects
> >   Makefile: Remove unhelpful comment
> >
> >  configure     |  2 ++
> >  Makefile.objs | 31 ++++++++++---------------------
> >  2 files changed, 12 insertions(+), 21 deletions(-)
> >
>
> Did you test this with all the combinations of --[enable|disable]-tools,
> --[enable|disable]-user and --[enable|disable]-system
>

I tested 12 of 27 because I thought some sets might overlap but I might
have missed something, what combination is giving you problem?

>

--00000000000078c8ac059bc59afc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le ven. 10 janv. 2020 09:36, Laurent Vivier &lt;<a href=3D"mai=
lto:laurent@vivier.eu">laurent@vivier.eu</a>&gt; a =C3=A9crit=C2=A0:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Le 09/01/2020 =C3=A0 16:39, Philippe Math=
ieu-Daud=C3=A9 a =C3=A9crit=C2=A0:<br>
&gt; In some configuration (linux-user, tools) we can ignore building<br>
&gt; various objects (and the libfdt).<br>
&gt; <br>
&gt; Philippe Mathieu-Daud=C3=A9 (4):<br>
&gt;=C2=A0 =C2=A0configure: Do not build libfdt is not required<br>
&gt;=C2=A0 =C2=A0Makefile: Clarify all the codebase requires qom/ objects<b=
r>
&gt;=C2=A0 =C2=A0Makefile: Restrict system emulation and tools objects<br>
&gt;=C2=A0 =C2=A0Makefile: Remove unhelpful comment<br>
&gt; <br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 Makefile.objs | 31 ++++++++++---------------------<br>
&gt;=C2=A0 2 files changed, 12 insertions(+), 21 deletions(-)<br>
&gt; <br>
<br>
Did you test this with all the combinations of --[enable|disable]-tools,<br=
>
--[enable|disable]-user and --[enable|disable]-system<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">I tested 12 of 27 beca=
use I thought some sets might overlap but I might have missed something, wh=
at combination is giving you problem?=C2=A0</div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000078c8ac059bc59afc--

