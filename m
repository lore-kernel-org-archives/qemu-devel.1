Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065FDC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C732121D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX8mEnyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C732121D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9Wx-000507-Mg
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1iD964-0002MB-Go
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1iD963-0005Rx-52
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:20:52 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1iD95z-0005Pg-3H; Wed, 25 Sep 2019 11:20:47 -0400
Received: by mail-lf1-x144.google.com with SMTP id c195so4516064lfg.9;
 Wed, 25 Sep 2019 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hBoDidx9ZQfLS3KKPQQ3ChK5cRax0JL9wFoDaCafu70=;
 b=eX8mEnyBBQ2AhN6eRJqtUg0xNcm/4QcMP70JaVjikhxfGZQT9JNPP49Z543iDdwfVB
 A0myyoSAXB8pWwiXo783GAKwD4vKTQGCTBXKqnuThdfqXzFy6imD2tdqnpYKX+nysomT
 4BppEqSVRj3oqAkQsMCcgsxVtEQtAH50qvKHTgnY23xpEqj8p/hODwwiXc6qO2etCSlN
 MuiYM9y1Bo0up6DPcpvK0kKvVw2qjekvDY60f1h2GdZNHeHPdzHmCHMqJ2nJacGoNZ5Y
 U0CsohhSWowSTFR5S+hpt32KPrCc4eBTcBIczpGxrpHDJc6rYCfsjJa6wQDIIQyOnAyX
 X76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hBoDidx9ZQfLS3KKPQQ3ChK5cRax0JL9wFoDaCafu70=;
 b=hUgSWptZ4+d8/8bFK8YEB2VED6kDDEPsJXT3nK1uWuW7GuN1C9xXa3XK110QljlgAv
 j8tjOI9TRV2dvDkIyA7Qbs8f5cyyW1kaKYhpS1RnOMFOdXYDVHkqZZGcEGnlQ9xX1bA8
 upspSVTpuKwmNieHA3Uao2xVNR1DBwaC3KQA4ayafQenl0Lnr6x6AwYup+bdNE1UIwK7
 zCiQHyVi6ljl3osIMpzmX3fP5BF0hlO6Hvpy9QG+Du+JjcTAg33NOgeV1KD7s7RL9Zp5
 HnyV+UiMsYGLgfgjWhCfkvJcC0mmJKC2hg6oe3t05XzFNIwj177oB4GXBs9Q/Bo8Ps+9
 qCVA==
X-Gm-Message-State: APjAAAXXsTtaWLQZZ/Mho5MkTLBOoGEDO0AAbLspFNIX/h4/3hXS1PGW
 oe3eTXAQyVXPMFdHvVCEnFpvnFR6CzZn5/dz8Qg=
X-Google-Smtp-Source: APXvYqwArIGULCJL36G8mc0x7Ql6n5L8wPLZ0cr9eSkSw3glW8xhVecTguLSEt73o3q3z6RnbUkjWiH1CY20naQIJkc=
X-Received: by 2002:ac2:4427:: with SMTP id w7mr6588461lfl.143.1569424844768; 
 Wed, 25 Sep 2019 08:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
 <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
In-Reply-To: <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Wed, 25 Sep 2019 11:19:43 -0400
Message-ID: <CANnJOVFkviip0g1tBHdL6n2B8pMAQxVBC83RTaF4PAE1t+aPew@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Guo Ren <guoren@kernel.org>
Content-Type: multipart/alternative; boundary="0000000000005fcd970593623226"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005fcd970593623226
Content-Type: text/plain; charset="UTF-8"

Any code whose behavior is changed by this patch is wrong, so it doesn't
seem like it matters much whether this is merged or not. Personally I'd
lean towards making sure that attempts to use PTEs with the reserved bit
set would always fault, rather than wrapping around to low memory and
perhaps silently succeeding.

Jonathan

On Wed, Sep 25, 2019 at 8:29 AM Guo Ren <guoren@kernel.org> wrote:

> On Wed, Sep 25, 2019 at 1:19 PM Alistair Francis <alistair23@gmail.com>
> wrote:
> >
> > On Tue, Sep 24, 2019 at 9:48 PM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <ren_guo@c-sky.com>
> > >
> > > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so
> we
> > > need to ignore them. They can not be a part of ppn.
> > >
> > > 1: The RISC-V Instruction Set Manual, Volume II: Privileged
> Architecture
> > >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> > >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> >
> > Hey,
> >
> > As I mentioned on patch 2 I don't think this is right. It isn't up to
> > HW to clear these bits, software should keep them clear.
>
> These bits are not part of ppn in spec, so we still need to ignore them
> for ppn.
>
> The patch is reasonable.
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
>
>

--0000000000005fcd970593623226
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Any code whose behavior is changed by this patch is w=
rong, so it doesn&#39;t seem like it matters much whether this is merged or=
 not. Personally I&#39;d lean towards making sure that attempts to use PTEs=
 with the reserved bit set would always fault, rather than wrapping around =
to low memory and perhaps silently succeeding.</div><div><br></div><div>Jon=
athan<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Sep 25, 2019 at 8:29 AM Guo Ren &lt;<a href=3D"mail=
to:guoren@kernel.org">guoren@kernel.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Wed, Sep 25, 2019 at 1:19 PM Alis=
tair Francis &lt;<a href=3D"mailto:alistair23@gmail.com" target=3D"_blank">=
alistair23@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Sep 24, 2019 at 9:48 PM &lt;<a href=3D"mailto:guoren@kernel.or=
g" target=3D"_blank">guoren@kernel.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Guo Ren &lt;<a href=3D"mailto:ren_guo@c-sky.com" target=3D"=
_blank">ren_guo@c-sky.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1]=
, so we<br>
&gt; &gt; need to ignore them. They can not be a part of ppn.<br>
&gt; &gt;<br>
&gt; &gt; 1: The RISC-V Instruction Set Manual, Volume II: Privileged Archi=
tecture<br>
&gt; &gt;=C2=A0 =C2=A0 4.4 Sv39: Page-Based 39-bit Virtual-Memory System<br=
>
&gt; &gt;=C2=A0 =C2=A0 4.5 Sv48: Page-Based 48-bit Virtual-Memory System<br=
>
&gt;<br>
&gt; Hey,<br>
&gt;<br>
&gt; As I mentioned on patch 2 I don&#39;t think this is right. It isn&#39;=
t up to<br>
&gt; HW to clear these bits, software should keep them clear.<br>
<br>
These bits are not part of ppn in spec, so we still need to ignore them for=
 ppn.<br>
<br>
The patch is reasonable.<br>
<br>
-- <br>
Best Regards<br>
=C2=A0Guo Ren<br>
<br>
ML: <a href=3D"https://lore.kernel.org/linux-csky/" rel=3D"noreferrer" targ=
et=3D"_blank">https://lore.kernel.org/linux-csky/</a><br>
<br>
</blockquote></div>

--0000000000005fcd970593623226--

