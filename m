Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296402072C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296402072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTMOn-0003uJ-1u
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTMMj-00039l-RY; Fri, 16 Oct 2020 05:49:38 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTMMh-0008HP-TP; Fri, 16 Oct 2020 05:49:37 -0400
Received: by mail-ej1-f66.google.com with SMTP id p15so2222181ejm.7;
 Fri, 16 Oct 2020 02:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wcc4sa8FZWR8hneIfj6Whm/Bq7kZCwcxlUdGIBIfi9c=;
 b=dw2Iw4uXyxgWVEnVhAHZASQ4HWN5V1YAmUA54yJNZCeAQ3Qk/fsZ4TExF+lgU8A6Yw
 6lQvo+umcN4uxbJYl/VLQIO3ubGdOUr6vpowg5xjsNdSb1X+ZHoZ80e4K64LGbUDUoOm
 ObBfUh9FEBkqNRxxJMlIWf8gCWt3lruq29hSFAuZ/zgIuSvgRS3EyI9oKinX57eUbKVS
 jLIbBM2KNK9lyNZZZGK4LSGmVMt1mxPxaDGfRESVvqEWjtxlflx88exEulvJEuFB/U52
 +QAaxRb2Cq4y03+p9jMo0oIdOowL3Vmd90qgg0XmTRO3W3g0iidDEKOxtbap9uuzRPEB
 5nQw==
X-Gm-Message-State: AOAM530TaMqMTZxpxdl0qVJDi7fDbcs6Hvb+Sh6OZJVpUDPool23HmfP
 rb6Vk5ANVoYYvQxczHSTfQHdy88feG5LLnhrDBU=
X-Google-Smtp-Source: ABdhPJynjeMVolVISqO6dF3HjFHzjbxF3W3DPCpOL+k+CGIbyF4BRqRaSitOF7xn99TX1vOgvYlUvV24UuZRmZBIAvc=
X-Received: by 2002:a17:906:bc42:: with SMTP id
 s2mr2729786ejv.251.1602841773819; 
 Fri, 16 Oct 2020 02:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201015194647.477252-1-f4bug@amsat.org>
 <991e3614-e416-1ef3-c097-dccfaa8fb77d@ilande.co.uk>
In-Reply-To: <991e3614-e416-1ef3-c097-dccfaa8fb77d@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Oct 2020 11:49:21 +0200
Message-ID: <CAAdtpL7DfhqqpUfMSx=uHP7azVsXaopqApL0=-vnmHF49M0B3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/rtc/m48t59: Simplify m48t59_init()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000008f4dbc05b1c6ae60"
Received-SPF: pass client-ip=209.85.218.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 04:26:29
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008f4dbc05b1c6ae60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2020 11:39, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk=
>
a =C3=A9crit :

> On 15/10/2020 20:46, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > Since v1:
> > - Do not remove mem_base in patch 1 (Laurent)
> > - Pass MemoryRegion* (new patch)
> > - Run check-qtest
> >
> > Philippe Mathieu-Daud=C3=A9 (2):
> >    hw/rtc/m48t59: Simplify m48t59_init() removing 'io_base' argument
> >    hw/rtc/m48t59: Simplify m48t59_init() passing MemoryRegion argument
> >
> >   include/hw/rtc/m48t59.h |  5 ++---
> >   hw/ppc/ppc405_boards.c  |  2 +-
> >   hw/rtc/m48t59.c         | 14 +++-----------
> >   hw/sparc/sun4m.c        |  3 ++-
> >   hw/sparc64/sun4u.c      |  7 ++-----
> >   5 files changed, 10 insertions(+), 21 deletions(-)
>
> This looks good, and from what you've done here it's only a little more
> work to
> remove m48t59_init() completely. Would you mind if I try this using these
> patches as
> a starting point? :)
>

I had a look at your previous suggestion, but I have too many in flight
series waiting for 5.2, so sure go ahead!


>
> ATB,
>
> Mark.
>
>

--0000000000008f4dbc05b1c6ae60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le ven. 16 oct. 2020 11:39, Mark Cave-Ayland &lt;<a href=3D"ma=
ilto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; a=
 =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 15/10/2020 20=
:46, Philippe Mathieu-Daud=C3=A9 wrote:<br>
<br>
&gt; Since v1:<br>
&gt; - Do not remove mem_base in patch 1 (Laurent)<br>
&gt; - Pass MemoryRegion* (new patch)<br>
&gt; - Run check-qtest<br>
&gt; <br>
&gt; Philippe Mathieu-Daud=C3=A9 (2):<br>
&gt;=C2=A0 =C2=A0 hw/rtc/m48t59: Simplify m48t59_init() removing &#39;io_ba=
se&#39; argument<br>
&gt;=C2=A0 =C2=A0 hw/rtc/m48t59: Simplify m48t59_init() passing MemoryRegio=
n argument<br>
&gt; <br>
&gt;=C2=A0 =C2=A0include/hw/rtc/m48t59.h |=C2=A0 5 ++---<br>
&gt;=C2=A0 =C2=A0hw/ppc/ppc405_boards.c=C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0hw/rtc/m48t59.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++-=
----------<br>
&gt;=C2=A0 =C2=A0hw/sparc/sun4m.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<=
br>
&gt;=C2=A0 =C2=A0hw/sparc64/sun4u.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++-----<b=
r>
&gt;=C2=A0 =C2=A05 files changed, 10 insertions(+), 21 deletions(-)<br>
<br>
This looks good, and from what you&#39;ve done here it&#39;s only a little =
more work to <br>
remove m48t59_init() completely. Would you mind if I try this using these p=
atches as <br>
a starting point? :)<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">I had a look at your previous suggestion, but I have to=
o many in flight series waiting for 5.2, so sure go ahead!=C2=A0</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--0000000000008f4dbc05b1c6ae60--

