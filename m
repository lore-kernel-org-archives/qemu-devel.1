Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E359C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F6320772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE7BjiLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqkRY-0005pV-9v
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 17:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqkPq-00054q-KV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 17:37:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:36325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqkPn-0007qs-Gm
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 17:37:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 17so25100319wmo.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3EVYmWpuuK7ptNmQlk3Hr2QQN1QxNUTeIGWLPhKgv+w=;
 b=OE7BjiLgcIAnX4cPv+ee17V6M1dXBXZRcejlq4/nZT9VY+ZUXFDQh66AZebsb0AMk8
 DJ7VekCVLwCaIpN4ubltwoMzdG6RV/AX0U3qD7nncDtq5XK6GYvRccc7SxJZj71Fi9aw
 /4jzu/s0jr2CK111GqStgxiZo1ABUauefs7MF35DtG4G7dOePCdHo4q5489jL+tmt5vh
 1u2L+lTib+BC+P5Islkf/ssk5m2vWqXw7LqfMchUdRbchkjAy0cjG3DSyK8NiBZj7uCf
 1y1IooIK7EzRzF4lx/aDZcPCToMR2MByoYUSvQAFZ7b5B0Y2bt6s7VatRNCGmSnY3Tab
 xSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3EVYmWpuuK7ptNmQlk3Hr2QQN1QxNUTeIGWLPhKgv+w=;
 b=Fvd0zCutIgEusw88ksgQbdsTQR2J//ZIP2TQjlutyrEPDLci5djEb4MeQEnVSXWka9
 5+205/c+hTZYQbK4NJisgabUB56IzjZf1BYQiqyUUpXPOXOGSM2WSrX7zDPGedybpaJT
 C4Mme/g7HhLvQQaQW8dPFYgqPwvMKbkhfU+Ae+gRx+csv3gJi39upP5P5WVq2uQAtU0G
 3NHGoy0JOnWWSFHL9TG2pPZtytUesrW/X1LUS/WRe3UCvwyTqJ6vVtlfgOcIIxFNQxgU
 0poUWGuu42U0XIcw8CgcCAHUsvLH2kV2OzKz4F8TvBBbfV4Lw5Ij537d/8bwSC3p24M8
 bwkA==
X-Gm-Message-State: AOAM532plGjNP2zBa/hRedecB/FDUeeoyoLTxMUWpcxm+knh9BbmlVcJ
 +SMZtFBUy6iCKT/0SOHFathKFAp/N3mR1RaAmsA=
X-Google-Smtp-Source: ABdhPJwYeolGBEhvueF6MhAfoBDKChGl8lq+HHqgtdRAPaGf3mxQ7oX3y3fsWeqCDxxzkvWwbmZZEZfhI4Qk5A2vS+8=
X-Received: by 2002:a1c:ac81:: with SMTP id
 v123mr27632714wme.159.1593639429724; 
 Wed, 01 Jul 2020 14:37:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Wed, 1 Jul 2020 14:37:09 -0700 (PDT)
In-Reply-To: <20200701201157.GA1093783@aurel32.net>
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
 <20200701201157.GA1093783@aurel32.net>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 1 Jul 2020 23:37:09 +0200
Message-ID: <CAHiYmc5k8YTKt6X+a1m7=5G4O5c9udbhsBoJ6ezkqfwseNXY6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aurelien Jarno <aurelien@aurel32.net>
Content-Type: multipart/alternative; boundary="0000000000001bdddd05a968182e"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "aleksandar.rikalo@syrmia.com" <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001bdddd05a968182e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, July 1, 2020, Aurelien Jarno <aurelien@aurel32.net> wrote:

> Hi Aleksandar,
>
> I know you have sent a v3 of this patch in the meantime, but I would
> still like to comment on it.
>
> First of all I confirm, that I do not have time to contribute to QEMU
> anymore and that I said I would like to resign from QEMU maintainership.
> We discussed that in person in Lyon back in October. I am happy to see
> that people are interested to take the maintainership.
>
> It happens that I known Huacai Chen from the time he was upstreaming the
> Loongson 3 support to the kernel, I have been testing and reviewing his
> patches. I also know Jiaxun Yang from the #debian-mips IRC channel. I
> know that they are both very competent and have a good knowledge of the
> open source world. I therefore agree that they are good additions to
> maintain and/or review the MIPS part of QEMU.
>
> All that said, they have been contributing only relatively recently to
> QEMU, and only to some areas. While I do support adding them to those
> areas, I wonder for example why adding them to the MIPS TCG target or
> to the Jazz board. That's probably something that should be done in a
> second step if they have an interest in doing so.
>
> I am fully aware that you posted a v3, that fixes exactly that after you
> got pointed out. However, I am still concerned by the way things
> happened.
>
>
Sure, I understand your point.

I am glad you respond in a reasonable, civilized, way, about a reasonable
topic, and I find talking to you a very pleasant experience - even if we
disagree, it doesn't make a difference at all.

The point of the segments you described is:

You have to throw somebody in unkown water, on purpose, in order to teach
him how to swim in the best way, and get out of him the best, his best.

That is all what I meant. No ulterior motive whatsoever.

Somebody like it, somebody does not.

Huacai doesn't, and I respect it, as shown in v3.

If you were here, all will be easier - we could talk, consult each other,
advice each other. I would enjoy working with you. I have also strong
feeling we would find common interest outside technical world, probably in
various intelectual realms. Perhaps this is not known to you, but french
thinkers are much appreciated and understood here in Serbia. We are
frankofilles.

But you choose not to be here. And what can I do? I can't force you to be
somewhere you don't want to be. I felt the loss of you not being here
throughout all my online presence.

Mixed feelings, ha?

Truly yours,
Aleksandar




> Regards,
> Aurelien
>
>
> On 2020-06-30 18:46, Aleksandar Markovic wrote:
> > Paul Burton and Aurelien Jarno removed for not being present.
> >
> > Huacai Chen and Jiaxun Yang step in as new energy.
> >
> > CC: Paul Burton <paulburton@kernel.org>
> > CC: Aurelien Jarno <aurelien@aurel32.net>
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > ---
> >  MAINTAINERS | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5d8acf8d31..7fc16e21c9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -213,7 +213,8 @@ F: disas/microblaze.c
> >
> >  MIPS TCG CPUs
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > -R: Aurelien Jarno <aurelien@aurel32.net>
> > +M: Huacai Chen <chenhc@lemote.com>
> > +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >  S: Maintained
> >  F: target/mips/
> > @@ -377,6 +378,7 @@ F: target/arm/kvm.c
> >
> >  MIPS KVM CPUs
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > +M: Huacai Chen <chenhc@lemote.com>
> >  S: Odd Fixes
> >  F: target/mips/kvm.c
> >
> > @@ -1052,6 +1054,7 @@ MIPS Machines
> >  -------------
> >  Jazz
> >  M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> > +M: Huacai Chen <chenhc@lemote.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >  S: Maintained
> >  F: hw/mips/jazz.c
> > @@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c
> >
> >  Malta
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > +M: Huacai Chen <chenhc@lemote.com>
> >  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > -R: Aurelien Jarno <aurelien@aurel32.net>
> >  S: Maintained
> >  F: hw/isa/piix4.c
> >  F: hw/acpi/piix4.c
> > @@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_malta.py
> >
> >  Mipssim
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > +M: Huacai Chen <chenhc@lemote.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >  S: Odd Fixes
> >  F: hw/mips/mipssim.c
> > @@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c
> >
> >  R4000
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > -R: Aurelien Jarno <aurelien@aurel32.net>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >  S: Obsolete
> >  F: hw/mips/r4k.c
> > @@ -1103,7 +1106,8 @@ S: Maintained
> >  F: hw/intc/loongson_liointc.c
> >
> >  Boston
> > -M: Paul Burton <pburton@wavecomp.com>
> > +M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > +M: Huacai Chen <chenhc@lemote.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >  S: Maintained
> >  F: hw/core/loader-fit.c
> > @@ -2677,7 +2681,8 @@ F: disas/i386.c
> >
> >  MIPS TCG target
> >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > -R: Aurelien Jarno <aurelien@aurel32.net>
> > +M: Huacai Chen <chenhc@lemote.com>
> > +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >  S: Maintained
> >  F: tcg/mips/
> > --
> > 2.20.1
> >
> >
> >
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net
>

--0000000000001bdddd05a968182e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, July 1, 2020, Aurelien Jarno &lt;<a href=3D"mailto:au=
relien@aurel32.net">aurelien@aurel32.net</a>&gt; wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">Hi Aleksandar,<br>
<br>
I know you have sent a v3 of this patch in the meantime, but I would<br>
still like to comment on it.<br>
<br>
First of all I confirm, that I do not have time to contribute to QEMU<br>
anymore and that I said I would like to resign from QEMU maintainership.<br=
>
We discussed that in person in Lyon back in October. I am happy to see<br>
that people are interested to take the maintainership.<br>
<br>
It happens that I known Huacai Chen from the time he was upstreaming the<br=
>
Loongson 3 support to the kernel, I have been testing and reviewing his<br>
patches. I also know Jiaxun Yang from the #debian-mips IRC channel. I<br>
know that they are both very competent and have a good knowledge of the<br>
open source world. I therefore agree that they are good additions to<br>
maintain and/or review the MIPS part of QEMU.<br>
<br>
All that said, they have been contributing only relatively recently to<br>
QEMU, and only to some areas. While I do support adding them to those<br>
areas, I wonder for example why adding them to the MIPS TCG target or<br>
to the Jazz board. That&#39;s probably something that should be done in a<b=
r>
second step if they have an interest in doing so.<br>
<br>
I am fully aware that you posted a v3, that fixes exactly that after you<br=
>
got pointed out. However, I am still concerned by the way things<br>
happened.<br>
<br></blockquote><div><br></div><div>Sure, I understand your point.</div><d=
iv><br></div><div>I am glad you respond in a reasonable, civilized, way, ab=
out a reasonable topic, and I find talking to you a very pleasant experienc=
e - even if we disagree, it doesn&#39;t make a difference at all.</div><div=
><br></div><div>The point of the segments you described is:</div><div><br><=
/div><div>You have to throw somebody in unkown water, on purpose, in order =
to teach him how to swim in the best way, and get out of him the best, his =
best.</div><div><br></div><div>That is all what I meant. No ulterior motive=
 whatsoever.</div><div><br></div><div>Somebody like it, somebody does not.<=
/div><div><br></div><div>Huacai doesn&#39;t, and I respect it, as shown in =
v3.</div><div><br></div><div>If you were here, all will be easier - we coul=
d talk, consult each other, advice each other. I would enjoy working with y=
ou. I have also strong feeling we would find common interest outside techni=
cal world, probably in various intelectual realms. Perhaps this is not know=
n to you, but french thinkers are much appreciated and understood here in S=
erbia. We are frankofilles.</div><div><br></div><div>But you choose not to =
be here. And what can I do? I can&#39;t force you to be somewhere you don&#=
39;t want to be. I felt the loss of you not being here throughout all my on=
line presence.</div><div><br></div><div>Mixed feelings, ha?</div><div><br><=
/div><div>Truly yours,</div><div>Aleksandar</div><div><br></div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Regards,<br>
Aurelien<br>
<br>
<br>
On 2020-06-30 18:46, Aleksandar Markovic wrote:<br>
&gt; Paul Burton and Aurelien Jarno removed for not being present.<br>
&gt; <br>
&gt; Huacai Chen and Jiaxun Yang step in as new energy.<br>
&gt; <br>
&gt; CC: Paul Burton &lt;<a href=3D"mailto:paulburton@kernel.org">paulburto=
n@kernel.org</a>&gt;<br>
&gt; CC: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qe=
mu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS | 15 ++++++++++-----<br>
&gt;=C2=A0 1 file changed, 10 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 5d8acf8d31..7fc16e21c9 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -213,7 +213,8 @@ F: disas/microblaze.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 MIPS TCG CPUs<br>
&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; -R: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt; +R: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.=
yang@flygoat.com</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: target/mips/<br>
&gt; @@ -377,6 +378,7 @@ F: target/arm/kvm.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 MIPS KVM CPUs<br>
&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt;=C2=A0 S: Odd Fixes<br>
&gt;=C2=A0 F: target/mips/kvm.c<br>
&gt;=C2=A0 <br>
&gt; @@ -1052,6 +1054,7 @@ MIPS Machines<br>
&gt;=C2=A0 -------------<br>
&gt;=C2=A0 Jazz<br>
&gt;=C2=A0 M: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.=
org">hpoussin@reactos.org</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: hw/mips/jazz.c<br>
&gt; @@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Malta<br>
&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt;=C2=A0 M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat=
.org">f4bug@amsat.org</a>&gt;<br>
&gt; -R: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: hw/isa/piix4.c<br>
&gt;=C2=A0 F: hw/acpi/piix4.c<br>
&gt; @@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_<wbr>malta.py<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 Mipssim<br>
&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt;=C2=A0 S: Odd Fixes<br>
&gt;=C2=A0 F: hw/mips/mipssim.c<br>
&gt; @@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 R4000<br>
&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; -R: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt;=C2=A0 S: Obsolete<br>
&gt;=C2=A0 F: hw/mips/r4k.c<br>
&gt; @@ -1103,7 +1106,8 @@ S: Maintained<br>
&gt;=C2=A0 F: hw/intc/loongson_liointc.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Boston<br>
&gt; -M: Paul Burton &lt;<a href=3D"mailto:pburton@wavecomp.com">pburton@wa=
vecomp.com</a>&gt;<br>
&gt; +M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gm=
ail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: hw/core/loader-fit.c<br>
&gt; @@ -2677,7 +2681,8 @@ F: disas/i386.c<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 MIPS TCG target<br>
&gt;=C2=A0 M: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; -R: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelie=
n@aurel32.net</a>&gt;<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt; +R: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.=
yang@flygoat.com</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt;=C2=A0 F: tcg/mips/<br>
&gt; -- <br>
&gt; 2.20.1<br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
-- <br>
Aurelien Jarno=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPG: 4096R/1DDD8C9B<br>
<a href=3D"mailto:aurelien@aurel32.net">aurelien@aurel32.net</a>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.a=
urel32.net" target=3D"_blank">http://www.aurel32.net</a><br>
</blockquote>

--0000000000001bdddd05a968182e--

