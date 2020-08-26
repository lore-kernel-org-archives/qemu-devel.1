Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D8FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F4D2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F4D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAs7B-0007Ep-JN
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kAs6g-0006oj-Sk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:52:38 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kAs6f-0001lE-Ay
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:52:38 -0400
Received: by mail-ej1-f65.google.com with SMTP id l2so1992401eji.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fA5XG4Fma/8NjsgBWmLolnnLghP/hZ65saA4DV+4sCE=;
 b=pC+Nczl9PCQhODD6pL/p85JbIFLblxQYvWxDhXUQQyU9/GLD3g8s3APswbH6DUPs9T
 Ww7pSOsbV9W/zDeZx6/hLoSKL7OM1p68OdmH8a0PuvnTRGx0VqnhjZ7uSKnF2TQ8wtON
 fEmPxdeBipu8ZIccHrj9V1azEIi6lESpjlvfvEPtsv+PnwJ4ocBhpHDiAMOC3g6Irn1r
 4GoAMHkGRA2x+727e1lCaJHzL4PJwB0tK7OfQZijX/HiKk/xRULgU5g4kV2dQ5fjbnl3
 equkGGvneTMthQFjZFGCNK+uLJps5uKJeMkxbFy68AoS2NVlF1m75NGcaIYYjv+Rh3te
 h+VA==
X-Gm-Message-State: AOAM532RKjItkQRQ/GiBgn8jKh+5gR0B9AUynVfnL54D1ZjQCl+BvKGb
 1qJPycHzpCG5R1scRIzjoaKieTSLfc4c0J135ME=
X-Google-Smtp-Source: ABdhPJwBsh+W68PiOUuRjvXhDLhxWbM5lAXNGkPf2GBG0/cd5IwgYwU4CZEdvLUlfEj2YAIQIF8UUuL9EmtUXZBLL6s=
X-Received: by 2002:a17:906:c1c3:: with SMTP id
 bw3mr15570794ejb.8.1598435556020; 
 Wed, 26 Aug 2020 02:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200806130340.17316-1-f4bug@amsat.org>
 <bc283986-6f08-fb1c-2219-9b4af64eaaa0@amsat.org>
 <CAFEAcA_XP+XbsfE3XhyrB=yO7iaz69j_rydanao1abVz8jaPKg@mail.gmail.com>
In-Reply-To: <CAFEAcA_XP+XbsfE3XhyrB=yO7iaz69j_rydanao1abVz8jaPKg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Aug 2020 11:52:23 +0200
Message-ID: <CAAdtpL7=Q8zTftQYJQGbj=xtCyLu3tusd+M_P8qtbNTOubceEw@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 0/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008353d805adc4c750"
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 05:36:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008353d805adc4c750
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Le lun. 24 ao=C3=BBt 2020 17:20, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> On Sat, 22 Aug 2020 at 21:00, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
> wrote:
> >
> > On 8/6/20 3:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > This series improve tracing of multiple UART device in the same
> > > chipset, and allow to use the Clock API to feed each device with
> > > an (updatable) input clock.
> > >
> > > Based-on: <20200730165900.7030-1-philmd@redhat.com>
> > > "hw/char: Remove TYPE_SERIAL_IO"
> > >
> > > Philippe Mathieu-Daud=C3=A9 (4):
> > >   hw/char/serial: Replace commented DPRINTF() by trace event
> > >   hw/char/serial: Remove old DEBUG_SERIAL commented code
> > >   hw/char/serial: Let SerialState have an 'id' field
> > >   hw/char/serial: Use the Clock API to feed the UART reference clock
> > >
> > >  include/hw/char/serial.h |  4 +++
> > >  hw/char/serial.c         | 55 +++++++++++++++++++++++---------------=
--
> > >  hw/char/trace-events     |  5 ++--
> > >  3 files changed, 39 insertions(+), 25 deletions(-)
> > >
> >
> > ping? Should I resend with the typo from patch 4 fixed?
>
> Which tree are you expecting the patches to go in via ?
>

I cc'ed you because having reviewed the Clock API series you are familiar
with it.
However I expect this series to be merged by the chardev maintainers.
In particular to verify the default values (when no input clock provided).


> thanks
> -- PMM
>
>

--0000000000008353d805adc4c750
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Peter,<br><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Le lun. 24 ao=C3=BBt 2020 17:20, Peter Maydel=
l &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org<=
/a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sat,=
 22 Aug 2020 at 21:00, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4=
bug@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; On 8/6/20 3:03 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; This series improve tracing of multiple UART device in the same<b=
r>
&gt; &gt; chipset, and allow to use the Clock API to feed each device with<=
br>
&gt; &gt; an (updatable) input clock.<br>
&gt; &gt;<br>
&gt; &gt; Based-on: &lt;<a href=3D"mailto:20200730165900.7030-1-philmd@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">20200730165900.7030-1-philmd@r=
edhat.com</a>&gt;<br>
&gt; &gt; &quot;hw/char: Remove TYPE_SERIAL_IO&quot;<br>
&gt; &gt;<br>
&gt; &gt; Philippe Mathieu-Daud=C3=A9 (4):<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Replace commented DPRINTF() by trace =
event<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Remove old DEBUG_SERIAL commented cod=
e<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Let SerialState have an &#39;id&#39; =
field<br>
&gt; &gt;=C2=A0 =C2=A0hw/char/serial: Use the Clock API to feed the UART re=
ference clock<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 include/hw/char/serial.h |=C2=A0 4 +++<br>
&gt; &gt;=C2=A0 hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 55 ++++=
+++++++++++++++++++-----------------<br>
&gt; &gt;=C2=A0 hw/char/trace-events=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 ++--<br>
&gt; &gt;=C2=A0 3 files changed, 39 insertions(+), 25 deletions(-)<br>
&gt; &gt;<br>
&gt;<br>
&gt; ping? Should I resend with the typo from patch 4 fixed?<br>
<br>
Which tree are you expecting the patches to go in via ?<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">I cc&#39;ed you beca=
use having reviewed the Clock API series you are familiar with it.</div><di=
v dir=3D"auto">However I expect this series to be merged by the chardev mai=
ntainers.</div><div dir=3D"auto">In particular to verify the default values=
 (when no input clock provided).</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--0000000000008353d805adc4c750--

