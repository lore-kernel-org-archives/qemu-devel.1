Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F46720757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKOlTqQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F46720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJ9D-0000cs-57
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jKJ8C-0008Fs-JD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jKJ8A-0006bu-Qm
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:00:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jKJ8A-0006W7-H8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:00:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so7763600wrx.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vc5Xg30ucEwTjNoWSlNkQrdAMkSjcfl5FF66NJ6114E=;
 b=PKOlTqQeAOa3NJlZUVKYikwALL1d14sA0thtujxxbs2kLsLbT3mIpSyzJKqv13t/XQ
 7x4pYTuJFmzxooTs4grnnhLx/2RKksaGcw4yhwHTSz2oI0m83Md69xd52fV4tW/+bRcI
 gRdG35/AHbCa8mgknZaFEtrwdab7dbH/DY6iqADMy4Oi+21DEu0kvtT2a+qLBFq+0Iwo
 4yYfGp6bPY3AYaA9pHLPhWVPajzdXAHP5yfYsgYOc+oRVg26NRedD7vfbQEcRZ5uEufx
 4FhKvZVRwN91kZFAI5+LO58byfYsKxmrHa9GWSMQwpIYYYtUfvrxY3agN0oPJh7kD2gx
 Bdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vc5Xg30ucEwTjNoWSlNkQrdAMkSjcfl5FF66NJ6114E=;
 b=mWycRpo4C9kYewUvce4f2+a4ltOmkBkf6H5TbsXOVhZTZptmqsqJkLmjOlwW9HZXfp
 gHbfJM0H9iiyxBR/uS7Z7Vt7IVGcWqxnfcED8omGZZOhaRMIWgPlF9/l/J+/JVkMBBKw
 KFTgi4r3RFREmfVwAST3ktQE/ZIZqdtA0u2pcge1owP4M2YRts1xCcgY43NCweMRbVK9
 lMLiVIKvPXzz0bN1BViN6VzUwhZ5BHHjq9E4s6MWR/3HtyI+awSGLpyQGH+qxC/Rj2/D
 l9H5/kbuSAp7rnXulrfvHtvn1lKkv5uQZwA536gCFQ3k7wKhE3/3l+f+3X+4m6AntBuH
 15mg==
X-Gm-Message-State: AGi0PuYZ0lDqlplntD4wP37MR8l4EDIKffjnop+Ni8TLgY+qO7bTg60I
 G3O11vvSgaKskmwCqusGickcHawRWiS/tc00I6o=
X-Google-Smtp-Source: APiQypLg+TE8io85Pf0mI28ka+Da1R2ud3EMOBGtEF7CI8g9aDvr8B4PxqZLcliHEO5a8pKLz8fWWNSwc5yM7JcqAMM=
X-Received: by 2002:adf:a459:: with SMTP id e25mr955214wra.402.1585908052333; 
 Fri, 03 Apr 2020 03:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
 <CAHiYmc4+mjtFxvTvrKohG2YBAMVqEAVVDT1e-XfJLC9D_+fnyA@mail.gmail.com>
In-Reply-To: <CAHiYmc4+mjtFxvTvrKohG2YBAMVqEAVVDT1e-XfJLC9D_+fnyA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 3 Apr 2020 12:00:31 +0200
Message-ID: <CAHiYmc7bQ-kdFtqbdKTnPor0vs4qLiu-4YAFatxE40DFioPyWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/mips: Add loongson gs464 core
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="0000000000001b1e1705a25ffea5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: chenhc@lemote.com, aleksandar.rikalo@rt-rk.com,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001b1e1705a25ffea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

00:02 Pet, 27.03.2020. Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> 12:05 Sre, 25.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > Loongson gs464 core can be found in Loongson-3A1000 processor.
> > This patchset add minimal support for that core.
> > There are still some instructions missing, I'm going to work on
> > them later.
> >
> > The corresponding hw board is also missing. I'm using modified kernel
> > for malta for testing purpose and planing to take the design of Lemote'=
s
> > KVM virtual machine.
> >
> > Official manual of this core can be found here [1] (In Chinese).
> > My collection of instruction documents mainly based on Chinese
> > version of manual, binutils gas code and experiments on real machine
> > can be found here [2] (In English).
> >
> > [1]:
http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3A1000_cpu_user_2.pdf
> > [2]:
https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> >
>
> Thanks, Jiaxun!
>
> Just to mention whay you probably know, since this is a new feature, this
is too late for 5.0, so we are shooting for integrsying it in 5.1.
>
> Speak to you later of course in more details.
>

Jiaxun, hello again.

May I ask you to provide us the automatic english transl
tion of document [1]?

translate.google.com site has the festure of uploading and translating a
pdf file. Unfortunately, one can't download resulting pdf file. But, there
is a workaround: one can "print" the page to pdf format from the browser.

There may be other ways of automatic translation of pdfs, but the one above
seems pretty reasonable.

Yours,
Aleksandar

> Yours,
> Aleksandar
>
> > Jiaxun Yang (3):
> >   target/mips: Introduce loongson ext & mmi ASE flags
> >   target/mips: Add loongson ext lsdc2 instrustions
> >   target/mips: Add loongson gs464 core
> >
> >  target/mips/mips-defs.h          |   2 +
> >  target/mips/translate.c          | 166 ++++++++++++++++++++++++++++++-
> >  target/mips/translate_init.inc.c |  25 ++++-
> >  3 files changed, 188 insertions(+), 5 deletions(-)
> >
> > --
> > 2.26.0.rc2
> >
> >

--0000000000001b1e1705a25ffea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">00:02 Pet, 27.03.2020. Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt;<br>
&gt; 12:05 Sre, 25.03.2020. Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@f=
lygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; Loongson gs464 core can be found in Loongson-3A1000 processor.<br=
>
&gt; &gt; This patchset add minimal support for that core.<br>
&gt; &gt; There are still some instructions missing, I&#39;m going to work =
on<br>
&gt; &gt; them later.<br>
&gt; &gt;<br>
&gt; &gt; The corresponding hw board is also missing. I&#39;m using modifie=
d kernel<br>
&gt; &gt; for malta for testing purpose and planing to take the design of L=
emote&#39;s<br>
&gt; &gt; KVM virtual machine.<br>
&gt; &gt;<br>
&gt; &gt; Official manual of this core can be found here [1] (In Chinese).<=
br>
&gt; &gt; My collection of instruction documents mainly based on Chinese<br=
>
&gt; &gt; version of manual, binutils gas code and experiments on real mach=
ine<br>
&gt; &gt; can be found here [2] (In English).<br>
&gt; &gt;<br>
&gt; &gt; [1]: <a href=3D"http://loongson.cn/uploadfile/cpu/3A1000/Loongson=
_3A1000_cpu_user_2.pdf">http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3=
A1000_cpu_user_2.pdf</a><br>
&gt; &gt; [2]: <a href=3D"https://github.com/FlyGoat/loongson-insn/blob/mas=
ter/loongson-ext.md">https://github.com/FlyGoat/loongson-insn/blob/master/l=
oongson-ext.md</a><br>
&gt; &gt;<br>
&gt;<br>
&gt; Thanks, Jiaxun!<br>
&gt;<br>
&gt; Just to mention whay you probably know, since this is a new feature, t=
his is too late for 5.0, so we are shooting for integrsying it in 5.1.<br>
&gt;<br>
&gt; Speak to you later of course in more details.<br>
&gt;</p>
<p dir=3D"ltr">Jiaxun, hello again.</p>
<p dir=3D"ltr">May I ask you to provide us the automatic english transl<br>
tion of document [1]?</p>
<p dir=3D"ltr"><a href=3D"http://translate.google.com">translate.google.com=
</a> site has the festure of uploading and translating a pdf file. Unfortun=
ately, one can&#39;t download resulting pdf file. But, there is a workaroun=
d: one can &quot;print&quot; the page to pdf format from the browser.</p>
<p dir=3D"ltr">There may be other ways of automatic translation of pdfs, bu=
t the one above seems pretty reasonable.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar<br><br></p>
<p dir=3D"ltr">&gt; Yours,<br>
&gt; Aleksandar<br>
&gt;<br>
&gt; &gt; Jiaxun Yang (3):<br>
&gt; &gt; =C2=A0 target/mips: Introduce loongson ext &amp; mmi ASE flags<br=
>
&gt; &gt; =C2=A0 target/mips: Add loongson ext lsdc2 instrustions<br>
&gt; &gt; =C2=A0 target/mips: Add loongson gs464 core<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0target/mips/mips-defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +<br>
&gt; &gt; =C2=A0target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 166 ++++++++++++++++++++++++++++++-<br>
&gt; &gt; =C2=A0target/mips/translate_init.inc.c |=C2=A0 25 ++++-<br>
&gt; &gt; =C2=A03 files changed, 188 insertions(+), 5 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; -- <br>
&gt; &gt; 2.26.0.rc2<br>
&gt; &gt;<br>
&gt; &gt;<br>
</p>

--0000000000001b1e1705a25ffea5--

