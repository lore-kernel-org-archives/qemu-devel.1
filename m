Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A522CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 17:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA4C2063A
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdEN2/Gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA4C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL9Bd-0003Ap-UF
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 13:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jL9At-0002gf-QQ
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jL9Ar-0005VZ-T9
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:35:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jL9Ar-0005T1-M0
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:35:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id r16so12334482wmg.5
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hIgCimc9+P4ldHwC0fBRD1Q+8Uph7zvR3+L164wlTs0=;
 b=OdEN2/GuSRPv41KMnJ9oEeFnfFu/B4y/12GCiz/WRHsyFjxj5dp7GYbXyIeo/xUWNO
 lXM5fkkQ+sYQNuWsl8D5c8j7x2/bHXM4CcghEo7ic9NgwIn5M3HlS+N0eJER+Dtd+QyM
 FrkkVlPylujrGNaSA+NRxSeIhnfuvqQpbrgy6Igga/WtDHFYgrvqichyrAof4bsjP9H6
 xcJmAOeoWowlXWhKKqhdc2c6j6D295okeyotNC2iPg81kEiTimkOM2DiYOHo5Hi1dMJu
 NYGhkZqKgyNF6nrH5EZLfzyJj/UUUUVqStNCDqRRfUOiwK4NlqoJdto28aCOLlyvU6dS
 xlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hIgCimc9+P4ldHwC0fBRD1Q+8Uph7zvR3+L164wlTs0=;
 b=iaBGuP1yGRndohAnHf/Xp6mW0CSydqCBKFOO0i8j1NKp/ltNnuVjQJfbRT2NGvoPM7
 kROFBU6DGCz8KJxTgYsd9vmo7OeD/sSiVtEmhDGmmSp9kU4oLikj9lTcCI7gFBwnnca8
 YGZBqBrtJBVfeZCAF1Zgab0ygxOs7nAgirpAq8J3ULi7qqw8TxZ6DYx/cjIoPn3hIS3Y
 kOEzE/L/BHpsKyDGWlRko4W9r17X9VgysJYyBcONyr4UqbEbEhNkBuXGPRIVW8M/qxtP
 UDvbGfeLi5qzvE0NsxCah+Saa0BbNkt2S+IPXMcDXyuPYSE0hTGHCO3EV6CRJxacIjUJ
 uoHA==
X-Gm-Message-State: AGi0Pua6WIFD3gNgxhBXSXs4pIRDfdKzJS6DWxnNi/irA3F1tRlgbIoM
 s8tW6ZPPOtolidMgMwhb+OgywmmGC3nEsbdfJgQ=
X-Google-Smtp-Source: APiQypICKU+to8+rqaWdlEbiEUkEqWRJdEWK2mnQ6SXoZ72gcoxxjjcUUX+5N8HD1I/ohiuWizQVgqdloHMCLRd29Co=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr13710888wmj.50.1586108109090; 
 Sun, 05 Apr 2020 10:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
 <CAHiYmc4+mjtFxvTvrKohG2YBAMVqEAVVDT1e-XfJLC9D_+fnyA@mail.gmail.com>
 <CAHiYmc7bQ-kdFtqbdKTnPor0vs4qLiu-4YAFatxE40DFioPyWA@mail.gmail.com>
 <1713fd44399.10077b02839968.3757708650599397810@flygoat.com>
In-Reply-To: <1713fd44399.10077b02839968.3757708650599397810@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 5 Apr 2020 19:34:48 +0200
Message-ID: <CAHiYmc44zKEkpYA3wc=hmLKiuNEQP8DvRQ_EoWTu8=ygZN5PDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/mips: Add loongson gs464 core
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="0000000000006af53005a28e92b1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: chenhc <chenhc@lemote.com>,
 "aleksandar.rikalo" <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006af53005a28e92b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

13:37 Pet, 03.04.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-04-03 18:00:31 Aleksand=
ar Markovic <
aleksandar.qemu.devel@gmail.com> =E6=92=B0=E5=86=99 ----
>  >
>  > 00:02 Pet, 27.03.2020. Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>  > >
>  > > 12:05 Sre, 25.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>  > > >
>  > > > Loongson gs464 core can be found in Loongson-3A1000 processor.
>  > > > This patchset add minimal support for that core.
>  > > > There are still some instructions missing, I'm going to work on
>  > > > them later.
>  > > >
>  > > > The corresponding hw board is also missing. I'm using modified
kernel
>  > > > for malta for testing purpose and planing to take the design of
Lemote's
>  > > > KVM virtual machine.
>  > > >
>  > > > Official manual of this core can be found here [1] (In Chinese).
>  > > > My collection of instruction documents mainly based on Chinese
>  > > > version of manual, binutils gas code and experiments on real
machine
>  > > > can be found here [2] (In English).
>  > > >
>  > > > [1]:
http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3A1000_cpu_user_2.pdf
>  > > > [2]:
https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
>  > > >
>  > >
>  > > Thanks, Jiaxun!
>  > >
>  > > Just to mention whay you probably know, since this is a new feature,
this is too late for 5.0, so we are shooting for integrsying it in 5.1.
>  > >
>  > > Speak to you later of course in more details.
>  > >
>  > Jiaxun, hello again.
>  > May I ask you to provide us the automatic english transl
>  > tion of document [1]?
>  > translate.google.com site has the festure of uploading and translating
a pdf file. Unfortunately, one can't download resulting pdf file. But,
there is a workaround: one can "print" the page to pdf format from the
browser.
>  > There may be other ways of automatic translation of pdfs, but the one
above seems pretty reasonable.
>  > Yours,
>  > Aleksandar
>
> Hi  Aleksandar,
>
> Machine translated version attached.
>
> It's not very easy to read it as Google Translation don't know much about
> computer sciences vocabulary in Chinese.
> And the figures are all messed up.

That is fine, Jiaxin, and, frankly, I did not expect anything better from
automatic Google translation.

Thanks again.

See you later, on the list!

Aleksandar

> Also, there are some known errata in this manual, some default values of
registers
> appear to be different from the actual hardware.
>
> If you have any questions about GS464 please ask me and I'll forward them
to
> Loongson guys. They're not willing to appear on the list but at least
they'll respond
> my questions.
>
> Thanks!
>  --
> Jiaxun Yang
>  >
>  >
>  > > Yours,
>  > > Aleksandar
>  > >
>  > > > Jiaxun Yang (3):
>  > > >   target/mips: Introduce loongson ext & mmi ASE flags
>  > > >   target/mips: Add loongson ext lsdc2 instrustions
>  > > >   target/mips: Add loongson gs464 core
>  > > >
>  > > >  target/mips/mips-defs.h          |   2 +
>  > > >  target/mips/translate.c          | 166
++++++++++++++++++++++++++++++-
>  > > >  target/mips/translate_init.inc.c |  25 ++++-
>  > > >  3 files changed, 188 insertions(+), 5 deletions(-)
>  > > >
>  > > > --
>  > > > 2.26.0.rc2
>  > > >
>  > > >
>  >
>  >

--0000000000006af53005a28e92b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">13:37 Pet, 03.04.2020. Jiaxun Yang &lt;<a href=3D"mailto:jia=
xun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-04-03 18:00:31 =
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">=
aleksandar.qemu.devel@gmail.com</a>&gt; =E6=92=B0=E5=86=99 ----<br>
&gt; =C2=A0&gt; <br>
&gt; =C2=A0&gt; 00:02 Pet, 27.03.2020. Aleksandar Markovic &lt;<a href=3D"m=
ailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&=
gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<b=
r>
&gt; =C2=A0&gt; &gt;<br>
&gt; =C2=A0&gt; &gt; 12:05 Sre, 25.03.2020. Jiaxun Yang &lt;<a href=3D"mail=
to:jiaxun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt; Loongson gs464 core can be found in Loongson-3A10=
00 processor.<br>
&gt; =C2=A0&gt; &gt; &gt; This patchset add minimal support for that core.<=
br>
&gt; =C2=A0&gt; &gt; &gt; There are still some instructions missing, I&#39;=
m going to work on<br>
&gt; =C2=A0&gt; &gt; &gt; them later.<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt; The corresponding hw board is also missing. I&#39=
;m using modified kernel<br>
&gt; =C2=A0&gt; &gt; &gt; for malta for testing purpose and planing to take=
 the design of Lemote&#39;s<br>
&gt; =C2=A0&gt; &gt; &gt; KVM virtual machine.<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt; Official manual of this core can be found here [1=
] (In Chinese).<br>
&gt; =C2=A0&gt; &gt; &gt; My collection of instruction documents mainly bas=
ed on Chinese<br>
&gt; =C2=A0&gt; &gt; &gt; version of manual, binutils gas code and experime=
nts on real machine<br>
&gt; =C2=A0&gt; &gt; &gt; can be found here [2] (In English).<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt; [1]: <a href=3D"http://loongson.cn/uploadfile/cpu=
/3A1000/Loongson_3A1000_cpu_user_2.pdf">http://loongson.cn/uploadfile/cpu/3=
A1000/Loongson_3A1000_cpu_user_2.pdf</a><br>
&gt; =C2=A0&gt; &gt; &gt; [2]: <a href=3D"https://github.com/FlyGoat/loongs=
on-insn/blob/master/loongson-ext.md">https://github.com/FlyGoat/loongson-in=
sn/blob/master/loongson-ext.md</a><br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt;<br>
&gt; =C2=A0&gt; &gt; Thanks, Jiaxun!<br>
&gt; =C2=A0&gt; &gt;<br>
&gt; =C2=A0&gt; &gt; Just to mention whay you probably know, since this is =
a new feature, this is too late for 5.0, so we are shooting for integrsying=
 it in 5.1.<br>
&gt; =C2=A0&gt; &gt;<br>
&gt; =C2=A0&gt; &gt; Speak to you later of course in more details.<br>
&gt; =C2=A0&gt; &gt;<br>
&gt; =C2=A0&gt; Jiaxun, hello again.<br>
&gt; =C2=A0&gt; May I ask you to provide us the automatic english transl<br=
>
&gt; =C2=A0&gt; tion of document [1]?<br>
&gt; =C2=A0&gt; <a href=3D"http://translate.google.com">translate.google.co=
m</a> site has the festure of uploading and translating a pdf file. Unfortu=
nately, one can&#39;t download resulting pdf file. But, there is a workarou=
nd: one can &quot;print&quot; the page to pdf format from the browser.<br>
&gt; =C2=A0&gt; There may be other ways of automatic translation of pdfs, b=
ut the one above seems pretty reasonable.<br>
&gt; =C2=A0&gt; Yours,<br>
&gt; =C2=A0&gt; Aleksandar<br>
&gt;<br>
&gt; Hi=C2=A0 Aleksandar, <br>
&gt;<br>
&gt; Machine translated version attached.<br>
&gt;<br>
&gt; It&#39;s not very easy to read it as Google Translation don&#39;t know=
 much about<br>
&gt; computer sciences vocabulary in Chinese.<br>
&gt; And the figures are all messed up.</p>
<p dir=3D"ltr">That is fine, Jiaxin, and, frankly, I did not expect anythin=
g better from automatic Google translation.</p>
<p dir=3D"ltr">Thanks again.</p>
<p dir=3D"ltr">See you later, on the list!</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt; Also, there are some known errata in this manual, some =
default values of registers<br>
&gt; appear to be different from the actual hardware.<br>
&gt;<br>
&gt; If you have any questions about GS464 please ask me and I&#39;ll forwa=
rd them to<br>
&gt; Loongson guys. They&#39;re not willing to appear on the list but at le=
ast they&#39;ll respond<br>
&gt; my questions.<br>
&gt;<br>
&gt; Thanks!<br>
&gt; =C2=A0--<br>
&gt; Jiaxun Yang<br>
&gt; =C2=A0&gt; <br>
&gt; =C2=A0&gt; <br>
&gt; =C2=A0&gt; &gt; Yours,<br>
&gt; =C2=A0&gt; &gt; Aleksandar<br>
&gt; =C2=A0&gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt; Jiaxun Yang (3):<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0target/mips: Introduce loongson ext &=
amp; mmi ASE flags<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0target/mips: Add loongson ext lsdc2 i=
nstrustions<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 =C2=A0target/mips: Add loongson gs464 core<=
br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 target/mips/mips-defs.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 target/mips/translate.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 166 ++++++++++++++++++++++++++++++-<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 target/mips/translate_init.inc.c |=C2=A0 25=
 ++++-<br>
&gt; =C2=A0&gt; &gt; &gt;=C2=A0 3 files changed, 188 insertions(+), 5 delet=
ions(-)<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt; -- <br>
&gt; =C2=A0&gt; &gt; &gt; 2.26.0.rc2<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; &gt; &gt;<br>
&gt; =C2=A0&gt; <br>
&gt; =C2=A0&gt;</p>

--0000000000006af53005a28e92b1--

