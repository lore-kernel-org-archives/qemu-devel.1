Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC47C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 16:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482E320791
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 16:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E320791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC3zX-0002xA-DP
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 12:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kC3yk-0002RE-KY
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 12:45:22 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:47046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kC3yi-0000eg-D2
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 12:45:22 -0400
Received: by mail-ej1-f66.google.com with SMTP id d11so3088207ejt.13
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 09:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NA9+N46o01a6W89L8qoDkMqjLqZ52nEpLkQ3zGwQigQ=;
 b=lLtLQDSqgDGW5b2OHUgd4+mqWKK+WHW4NUm0H5TNuae0NRCW3YakDLNmY6MFj7NU7D
 D2KNKQKJ7byj3OCofJ8U/z2erf3nwfSiQyXydtIwFVIAHpaMzpA8ublmkk/3CLFTi3Ps
 dvOp4tstDxZfuEV2fYjpnPV0Xua4xDoAdM9c1sQxCb5je+jvHIrZDyjFlWpcFavfKKf2
 85hwf1yQ7MfZQE/flVjwK6jdRvmwlwkTVpLpVoHvrUkjHB0X/Kap8GEz+BrpMmwfz7b5
 YBrG7U+yrRfX+OVGJtkUTOvkDD4Tlve/zWGzM/SnVzjJ9NIa/jmwFP9NKDkud4jhdaZ1
 2VTw==
X-Gm-Message-State: AOAM532BytpYsl4Dc96Y3LHOOmefDtiFc4yRVyuFqKkW5KfmlllD4E50
 m6xQ0hErUVD9W8RjOSbKBDIm2pS5K4he7D98S9k=
X-Google-Smtp-Source: ABdhPJwUYKoDqo1qLGDp2DzISXEoQkjm0ZxWFFdFugEMMe1OgiYQBmYumLtc9F3HP2YE5z8imqDJXBShNxbvzChKl1Q=
X-Received: by 2002:a17:906:2296:: with SMTP id
 p22mr4180424eja.510.1598719517639; 
 Sat, 29 Aug 2020 09:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200822142127.1316231-1-f4bug@amsat.org>
 <7300edf2-ab44-3676-6948-adf2c5af6c02@linaro.org>
 <20200829121341.59d8277b@glenfarclas>
In-Reply-To: <20200829121341.59d8277b@glenfarclas>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 29 Aug 2020 18:45:06 +0200
Message-ID: <CAAdtpL4Pi3w+5awNrohmSpySsZhmmPFQeby+a1-=TT8mJ7ZQVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
To: Michael <macallan1888@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f1c80a05ae06e485"
Received-SPF: pass client-ip=209.85.218.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 12:45:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Michael Lorenz <macallan@netbsd.org>, Andreas Gustafsson <gson@gson.org>,
 Richard Henderson <richard.henderson@linaro.org>, 1892540@bugs.launchpad.net,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f1c80a05ae06e485
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 29 ao=C3=BBt 2020 18:14, Michael <macallan1888@gmail.com> a =C3=A9c=
rit :

> Hello,
>
> since I wrote the NetBSD code in question, here are my 2 cent:
>
> On Sat, 29 Aug 2020 08:41:43 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
>
> > On 8/22/20 7:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > The S24/TCX datasheet is listed as "Unable to locate" on [1].
>
> I don't have it either, but someone did a lot of reverse engineering
> and gave me his notes. The hardware isn't that complicated, but quite
> weird.
>
> > > However the NetBSD revision 1.32 of the driver introduced
> > > 64-bit accesses to the stippler and blitter [2]. It is safe
> > > to assume these memory regions are 64-bit accessible.
> > > QEMU implementation is 32-bit, so fill the 'impl' fields.
>
> IIRC the real hardware *requires* 64bit accesses for stipple and
> blitter operations to work. For stipples you write a 64bit word into
> STIP space, the address defines where in the framebuffer you want to
> draw, the data contain a 32bit bitmask, foreground colour and a ROP.
> BLIT space works similarly, the 64bit word contains an offset were to
> read pixels from, and how many you want to copy.
>

Thanks Michael for this information!
If you don't mind I'll amend it to the commit description so there is a
reference for posterity.

I'm waiting for *Andreas Gustafsson to test it then will repost.*


> have fun
> Michael
>

--000000000000f1c80a05ae06e485
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le sam. 29 ao=C3=BBt 2020 18:14, Michael &lt;<a href=3D"mailto=
:macallan1888@gmail.com">macallan1888@gmail.com</a>&gt; a =C3=A9crit=C2=A0:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Hello,<br>
<br>
since I wrote the NetBSD code in question, here are my 2 cent:<br>
<br>
On Sat, 29 Aug 2020 08:41:43 -0700<br>
Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" targe=
t=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org</a>&gt; wrote:=
<br>
<br>
&gt; On 8/22/20 7:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; The S24/TCX datasheet is listed as &quot;Unable to locate&quot; o=
n [1].<br>
<br>
I don&#39;t have it either, but someone did a lot of reverse engineering<br=
>
and gave me his notes. The hardware isn&#39;t that complicated, but quite<b=
r>
weird.<br>
<br>
&gt; &gt; However the NetBSD revision 1.32 of the driver introduced<br>
&gt; &gt; 64-bit accesses to the stippler and blitter [2]. It is safe<br>
&gt; &gt; to assume these memory regions are 64-bit accessible.<br>
&gt; &gt; QEMU implementation is 32-bit, so fill the &#39;impl&#39; fields.=
<br>
<br>
IIRC the real hardware *requires* 64bit accesses for stipple and<br>
blitter operations to work. For stipples you write a 64bit word into<br>
STIP space, the address defines where in the framebuffer you want to<br>
draw, the data contain a 32bit bitmask, foreground colour and a ROP.<br>
BLIT space works similarly, the 64bit word contains an offset were to<br>
read pixels from, and how many you want to copy.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks Michael for this inf=
ormation!=C2=A0</div><div dir=3D"auto">If you don&#39;t mind I&#39;ll amend=
 it to the commit description so there is a reference for posterity.=C2=A0<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;m waiting for=C2=
=A0<i>Andreas Gustafsson to test it then will repost.</i></div><div dir=3D"=
auto"><i><br></i></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
have fun<br>
Michael<br>
</blockquote></div></div></div>

--000000000000f1c80a05ae06e485--

