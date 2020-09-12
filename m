Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4109DC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED042083E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="zRKahJTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED042083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH76C-0008Q3-P3
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1kH75M-0007fz-5X
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 11:05:04 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832]:41939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1kH75K-0002eW-1i
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 11:05:03 -0400
Received: by mail-qt1-x832.google.com with SMTP id t20so10209828qtr.8
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=14HcZeQlZCsaKO7f4zY86n0B1rIPGCzxXhMqyIFMf3w=;
 b=zRKahJTY864AZgv6odJQGFN7Tt6o9k10NxyGulWbkQUJlHdKBJFkPYw3tLhLvc+gbI
 4fnma0JpTvJeGkaaEhS8wAXiSv2GcrvuxSY2DCn+WrofyqcxzopkxB8jgZVrTqQu1y8o
 ti8a0rIdvXXm4HufVbPRJxzql//aXCP7wRZPpW6WTHL7fL8N6BT8vUImQ4/tv76MZ+o5
 nzvx/2pt/fNLJVlezYU5qdGgCADnPM5d5CozVSFZgrL8JoEwqIACR8if8321zbhRyQy5
 RjzqcRwJ+s4yQ6WxwPFsan8JhBBQwOJcuFcpLb1GT8yDHFqQ4bQ6OfxYDR0XnDHXoq43
 ltnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=14HcZeQlZCsaKO7f4zY86n0B1rIPGCzxXhMqyIFMf3w=;
 b=DsO2gFAYCravqX34fVM5utVW6a2YboSo4wIeDRpkIs9qf0xHb/On1AKm5juSGtmruj
 gIeDIVXFrOU9uH8gtVu1OJQGiJNptRzVWMNqWaY/qQS7OgqxCFOiGl2cvDheIAlrN1m7
 K5yMudpNq5WHn1nBwKBc1j97NWgV9xPzQmBneRC4S5X6fLsHlJ5TnSpbozUwGk5lPzP0
 qF4DQ6XQfZPKr3iAySvmXQxbTDLHbnXaebmbo4f8KnCqMssZctlTJuns+PhMr44AfzLf
 GITCfmn7pqA3Hfs9wFlNYWN5WQgCdDMjrC5HJ74SpobPDxdiCBIZvLf86wFyF6Ea5KCw
 Hd2A==
X-Gm-Message-State: AOAM531b1qqJDdC1uursAMzmg8La0b2VQQLTkdcIe2LmzxIEiy1GL2PC
 x1I6ToTStkttGURPZjFv5WTV2zUjqm4hjIa3msWY8w==
X-Google-Smtp-Source: ABdhPJyEL0BcTCJhmbvXujfwdixDIixcMtcR2GUVL7XAsi7t9kM5i2+ctj99xkwlUKW6cggVoIig0djLPNqbVqkRR9s=
X-Received: by 2002:ac8:3261:: with SMTP id y30mr6561634qta.242.1599923100589; 
 Sat, 12 Sep 2020 08:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200911184919.GV1618070@habkost.net>
 <CAFEAcA-dnKVyUQ3_ZifdDvrpCbKB1zciuu224BbB1WRV0npxzw@mail.gmail.com>
 <20200911200649.GW1618070@habkost.net>
 <CANCZdfq0CXqrLJgXQPi+eiDx+qmkNng7agQ40CyE9pH=z9g41g@mail.gmail.com>
 <aaf6ea38-7b96-9295-12e8-8ba77b605fd1@amsat.org>
In-Reply-To: <aaf6ea38-7b96-9295-12e8-8ba77b605fd1@amsat.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 12 Sep 2020 09:04:49 -0600
Message-ID: <CANCZdfqUe-XASrcWZq1A5ZTKz7dDr_PYkDu+O-0C1yzA6ykQ1A@mail.gmail.com>
Subject: Re: Moving to C11? (was Re: Redefinition of typedefs (C11 feature))
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000143b3605af1f205e"
Received-SPF: none client-ip=2607:f8b0:4864:20::832;
 envelope-from=wlosh@bsdimp.com; helo=mail-qt1-x832.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000143b3605af1f205e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2020, 2:16 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
wrote:

> On 9/11/20 10:10 PM, Warner Losh wrote:
> >
> >
> > On Fri, Sep 11, 2020 at 2:07 PM Eduardo Habkost <ehabkost@redhat.com
> > <mailto:ehabkost@redhat.com>> wrote:
> >
> >     On Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter Maydell wrote:
> >     > On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost <ehabkost@redhat.co=
m
> >     <mailto:ehabkost@redhat.com>> wrote:
> >     > >
> >     > > I'm wondering: do our supported build host platforms all includ=
e
> >     > > compilers that are new enough to let us redefine typedefs?
> >     > >
> >     > > The ability to redefine typedefs is a C11 feature which would b=
e
> >     > > very useful for simplifying our QOM boilerplate code.  The
> >     > > feature is supported by GCC since 2011 (v4.6.0)[1], and by clan=
g
> >     > > since 2012 (v3.1)[2].
> >     >
> >     > In configure we mandate either GCC v4.8 or better, or
> >     > clang v3.4 or better, or XCode Clang v5.1 or better
> >     > (Apple uses a different version numbering setup to upstream).
> >     > So you should probably double-check that that xcode clang has
> >     > what you want, but it looks like we're good to go otherwise.
> >
> >     Can anybody confirm if the following is accurate?
> >
> >     https://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67
> >     # Xcode 5.1 (5B130a)
> >     Apple LLVM version 5.1 (clang-503.0.38) (based on LLVM 3.4svn)
> >     Target: x86_64-apple-darwin13.1.0
> >     Thread model: posix
> >
> >     If we know we have GCC 4.8+ or clang 3.4+, can we move to C11 and
> >     start using -std=3Dgnu11?
> >
> >
> > All supported branches of FreeBSD tier 1 platforms would be fine since
> > they all use clang. Most of the tier 2 ones do too, but the ports/pkg
> > system we have will install a newer compiler if need be (the ones that
> > don't are still stuck at gcc 4.2.1 for GPLv3 reasons).
>
> See the quoted message from Peter: "In configure we mandate either
> GCC v4.8 or better"... You shouldn't be able to build QEMU in ports/pkg.
>

Ah, I was grepping for gcc/clang. It specifies compiler:c11 so I missed
that it already brings in a better compiler on those weird, old platforms.

In any event, FreeBSD won't be a problem....

Warner

Regards,
>
> Phil.
>

--000000000000143b3605af1f205e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Sep 12, 2020, 2:16 AM Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">On 9/11/20 10:10 PM, Warner Losh wro=
te:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Sep 11, 2020 at 2:07 PM Eduardo Habkost &lt;<a href=3D"mailto:=
ehabkost@redhat.com" target=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.c=
om</a><br>
&gt; &lt;mailto:<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">ehabkost@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter May=
dell wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost =
&lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">ehabkost@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;&gt; wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; I&#39;m wondering: do our supported build=
 host platforms all include<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; compilers that are new enough to let us r=
edefine typedefs?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; The ability to redefine typedefs is a C11=
 feature which would be<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; very useful for simplifying our QOM boile=
rplate code.=C2=A0 The<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; feature is supported by GCC since 2011 (v=
4.6.0)[1], and by clang<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; since 2012 (v3.1)[2].<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; In configure we mandate either GCC v4.8 or bet=
ter, or<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; clang v3.4 or better, or XCode Clang v5.1 or b=
etter<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; (Apple uses a different version numbering setu=
p to upstream).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So you should probably double-check that that =
xcode clang has<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; what you want, but it looks like we&#39;re goo=
d to go otherwise.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Can anybody confirm if the following is accurate?<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://gist.github.com/yamaya/2924292#f=
ile-xcode-clang-vers-L67" rel=3D"noreferrer noreferrer" target=3D"_blank">h=
ttps://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0# Xcode 5.1 (5B130a)<br>
&gt;=C2=A0 =C2=A0 =C2=A0Apple LLVM version 5.1 (clang-503.0.38) (based on L=
LVM 3.4svn)<br>
&gt;=C2=A0 =C2=A0 =C2=A0Target: x86_64-apple-darwin13.1.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0Thread model: posix<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If we know we have GCC 4.8+ or clang 3.4+, can we m=
ove to C11 and<br>
&gt;=C2=A0 =C2=A0 =C2=A0start using -std=3Dgnu11?<br>
&gt; <br>
&gt; <br>
&gt; All supported branches of FreeBSD tier 1 platforms would be fine since=
<br>
&gt; they all use clang. Most of the tier 2 ones do too, but the ports/pkg<=
br>
&gt; system we have will install a newer compiler if need be (the ones that=
<br>
&gt; don&#39;t are still stuck at gcc 4.2.1 for GPLv3 reasons).<br>
<br>
See the quoted message from Peter: &quot;In configure we mandate either<br>
GCC v4.8 or better&quot;... You shouldn&#39;t be able to build QEMU in port=
s/pkg.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Ah, I was grepping for gcc/clang. It specifies compiler:c11 so I miss=
ed that it already brings in a better compiler on those weird, old platform=
s.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">In any event, F=
reeBSD won&#39;t be a problem....</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Warner</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Regards,<br>
<br>
Phil.<br>
</blockquote></div></div></div>

--000000000000143b3605af1f205e--

