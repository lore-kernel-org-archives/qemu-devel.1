Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66984C56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D7E2225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dcomp-ufs-br.20150623.gappssmtp.com header.i=@dcomp-ufs-br.20150623.gappssmtp.com header.b="EuJsonGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7E2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dcomp.ufs.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIdX-0008SM-Nz
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kVIHd-00045F-Tq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:52:21 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kVIHa-000098-UM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:52:21 -0400
Received: by mail-ot1-x333.google.com with SMTP id e20so2608888otj.11
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dcomp-ufs-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Si1gVFuSHE8pBxE93w1UHIBgpLN4Q83x/rQP4ycTsQQ=;
 b=EuJsonGGrCf/bbGeNCI44aw69zHUxDj6BZnpRQPaBwvc03+PPgxZIAuBitYS/VFLE2
 qZi3/ycJCfePDxagykL930iSxHNqIYYbUAu922fkiKbKUGknJ13Xk+CsaB1vewczLY1Z
 WsAAL6JTyaGCYyIsCqJf56UG6SZIHcgLnYvDV83E5IGy+ZlaB7Y+WKvGad40zmhv+SGG
 SoVYFi22UXW0KqHHSBcILfpPu8v1nLMUAtQjvXkNFM1FyOIKC2vFZX+JG1/DyLqw6x/U
 Q2W+xRzJS07AUen5ve2s/dahkdR7bk01Obh/4svEaMEj/8q8T1K5unT/EPb6nube/hOf
 SFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Si1gVFuSHE8pBxE93w1UHIBgpLN4Q83x/rQP4ycTsQQ=;
 b=NQWJkOHHt5pxCj8ZJtJC+BefQlIttIZctST0MXcmabET17uAcfuz7c1pPmZGlHLBfI
 cPrsC85VjPlA8SA/TGhDPMS2hRHNAEDb+RK9aiQ3njJS5A3SMP2GUMmI97H/OO5cZCd0
 SIEQN4Ku7Nq9AN/5lHletaKz0rNwg8gYhFo/JINayhKkb5IunKEOiSVTG7DJ6f95tLM5
 S1hzwzVdOcoGKiR84vRry3Ypvhw5V9XeeEQ3ak+w9OcTkiQnS8BtGIy3h0abQfLwpOAI
 wFksyzKAduyaresmEzWhmuCUSJb2iNrumaJG9rXsH73g/nXxaauiLd6a/ZjBZxLYtMmT
 mKbA==
X-Gm-Message-State: AOAM533DaW+CHy6KJ4uUOSzD5i37VyQnwt3iPP90eBis5XKUF/yUBHS5
 EHat4W/G+DiAsBomBY1VEIuxryU3qjqiDsNLWyQ=
X-Google-Smtp-Source: ABdhPJxQcICexQoLjQ/TSEgsKn1eJyIidpfQl9JvN63q0MEyQw7ae0oo4uy9CL/L7xD6LfW/7BRv9ewOj/marsUmzrs=
X-Received: by 2002:a9d:3a09:: with SMTP id j9mr3560602otc.312.1603302736695; 
 Wed, 21 Oct 2020 10:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
 <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
 <CAD5UmjrjORJbP0sj-DnGQFaQ443-vYMBa-1qCBzJsnUG+gU=jw@mail.gmail.com>
 <CAFEAcA9JecdSwd=gXSu7mhDHVysLP5JP4dtRBgBVr7=bt=j6Tw@mail.gmail.com>
 <CAD5UmjrFgv1pCKGW813dzmYcEEWLdvu9FmGi0ymvXbvfw-aonQ@mail.gmail.com>
 <CAD5UmjqDGmOksXSk31q3asXLogSggc7rqOXuo2K2yLLs81ccQQ@mail.gmail.com>
 <875z73wpkq.fsf@linaro.org>
In-Reply-To: <875z73wpkq.fsf@linaro.org>
From: Bruno Prado <bruno@dcomp.ufs.br>
Date: Wed, 21 Oct 2020 14:51:40 -0300
Message-ID: <CAD5UmjpZ=6-oORRyOXUxuD0Uc0eU=Zx4SJZ=U0ur6fCt=N=s9Q@mail.gmail.com>
Subject: Re: ARM semihosting issue
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001694c105b23202fe"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=bruno.otavio@gmail.com; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001694c105b23202fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot! I will check it out.

----
Bruno Prado


On Wed, Oct 21, 2020 at 12:45 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

>
> Bruno Prado <bruno@dcomp.ufs.br> writes:
>
> > Hello, is it really a bug?
> >
> > ----
> > Bruno Prado
> >
> >
> > On Fri, Oct 2, 2020 at 8:09 AM Bruno Prado <bruno@dcomp.ufs.br> wrote:
> >
> >> I am including some syscall functions:
> >>
> >> int _fstat(int file, struct stat* st) {
> >>        register int value asm("r0");
> >>        uint32_t p[] =3D { file };
> >>        R0(0x0C);
> >>        R1(p);
> >>        BKPT();
> >>        return value;
> >> }
> >>
> >> int _read(int file, char* ptr, int len) {
> >>        register int value asm("r0");
> >>        uint32_t p[] =3D { file, (uint32_t)(ptr), len };
> >>        R0(0x06);
> >>        R1(p);
> >>        BKPT();
> >>        return value;
> >> }
> >>
> >> int _write(int file, char* ptr, int len) {
> >>        register int value asm("r0");
> >>        uint32_t p[] =3D { file, (uint32_t)(ptr), len };
> >>        R0(0x05);
> >>        R1(p);
> >>        BKPT();
> >>        return value;
> >> }
> >>
> >> Also the interruption output from execution:
> >>
> >> $ qemu-system-arm -M netduino2 -nographic -semihosting -kernel vp2.bin
> -d
> >> int
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x1
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x1
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x1
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x1
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0xc
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x5
> >> What is your name?
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x5
> >> Reading from file...
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0xc
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x6
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0xc
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x6
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x5
> >> My name is Turing
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x5
> >> I am alive!!!
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0xa
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0xa
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x2
> >> Taking exception 16 [Semihosting call]
> >> ...handling as semihosting call 0x20
> >>
> >> Could you please provide any working example using ARM semihosting on
> >> stdin?
>
> We have a test which you can run by hand:
>
>    ./tests/tcg/arm-linux-user/semiconsole
>
> >>
> >> Thanks,
> >> ----
> >> Bruno Prado
> >>
> >>
> >> On Fri, Oct 2, 2020 at 7:25 AM Peter Maydell <peter.maydell@linaro.org=
>
> >> wrote:
> >>
> >>> On Thu, 1 Oct 2020 at 22:21, Bruno Prado <bruno@dcomp.ufs.br> wrote:
> >>> > Thanks for the reply... I am attaching some code and output:
> >>> >
> >>> > #include <stdio.h>
> >>> > int main() {
> >>> >        char name[50] =3D "Nobody";
> >>> >        FILE* file =3D fopen("name", "r");
> >>> >        printf("What is your name?\n");
> >>> >        fprintf(stdout, "Reading from file...\n");
> >>> >        fscanf(file, "%s", name);
> >>> >        fscanf(stdin, "%s", name);
> >>> >        printf("My name is %s\n", name);
> >>> >        fprintf(stderr, "I am alive!!!\n");
> >>> >        fclose(file);
> >>> >        return 0;
> >>> > }
> >>>
> >>> This is not making direct semihosting calls. The behaviour
> >>> of these function calls will depend on whatever the C
> >>> standard library implementation you're linking with is doing.
> >>>
> >>> You're not checking for errors from any of your function
> >>> calls, incidentally.
> >>>
> >>> thanks
> >>> -- PMM
> >>>
> >>
>
>
> --
> Alex Benn=C3=A9e
>

--0000000000001694c105b23202fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks a lot! I will check it out.<div><br clear=3D"all"><=
div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sign=
ature">----<br>Bruno Prado</div></div><br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 21, 2020 at 12:=
45 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.b=
ennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
Bruno Prado &lt;<a href=3D"mailto:bruno@dcomp.ufs.br" target=3D"_blank">bru=
no@dcomp.ufs.br</a>&gt; writes:<br>
<br>
&gt; Hello, is it really a bug?<br>
&gt;<br>
&gt; ----<br>
&gt; Bruno Prado<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Oct 2, 2020 at 8:09 AM Bruno Prado &lt;<a href=3D"mailto:bruno=
@dcomp.ufs.br" target=3D"_blank">bruno@dcomp.ufs.br</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; I am including some syscall functions:<br>
&gt;&gt;<br>
&gt;&gt; int _fstat(int file, struct stat* st) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 register int value asm(&quot;r0&quot;);=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t p[] =3D { file };<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 R0(0x0C);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 R1(p);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 BKPT();<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value;<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; int _read(int file, char* ptr, int len) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 register int value asm(&quot;r0&quot;);=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t p[] =3D { file, (uint32_t)(ptr=
), len };<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 R0(0x06);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 R1(p);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 BKPT();<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value;<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; int _write(int file, char* ptr, int len) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 register int value asm(&quot;r0&quot;);=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t p[] =3D { file, (uint32_t)(ptr=
), len };<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 R0(0x05);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 R1(p);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 BKPT();<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value;<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; Also the interruption output from execution:<br>
&gt;&gt;<br>
&gt;&gt; $ qemu-system-arm -M netduino2 -nographic -semihosting -kernel vp2=
.bin -d<br>
&gt;&gt; int<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x1<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x1<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x1<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x1<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0xc<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x5<br>
&gt;&gt; What is your name?<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x5<br>
&gt;&gt; Reading from file...<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0xc<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x6<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0xc<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x6<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x5<br>
&gt;&gt; My name is Turing<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x5<br>
&gt;&gt; I am alive!!!<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0xa<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0xa<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x2<br>
&gt;&gt; Taking exception 16 [Semihosting call]<br>
&gt;&gt; ...handling as semihosting call 0x20<br>
&gt;&gt;<br>
&gt;&gt; Could you please provide any working example using ARM semihosting=
 on<br>
&gt;&gt; stdin?<br>
<br>
We have a test which you can run by hand:<br>
<br>
=C2=A0 =C2=A0./tests/tcg/arm-linux-user/semiconsole<br>
<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; ----<br>
&gt;&gt; Bruno Prado<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Oct 2, 2020 at 7:25 AM Peter Maydell &lt;<a href=3D"mailto=
:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&g=
t;<br>
&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; On Thu, 1 Oct 2020 at 22:21, Bruno Prado &lt;<a href=3D"mailto=
:bruno@dcomp.ufs.br" target=3D"_blank">bruno@dcomp.ufs.br</a>&gt; wrote:<br=
>
&gt;&gt;&gt; &gt; Thanks for the reply... I am attaching some code and outp=
ut:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; #include &lt;stdio.h&gt;<br>
&gt;&gt;&gt; &gt; int main() {<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 char name[50] =3D &quot;Nobody=
&quot;;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE* file =3D fopen(&quot;nam=
e&quot;, &quot;r&quot;);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;What is your name=
?\n&quot;);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stdout, &quot;Reading =
from file...\n&quot;);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fscanf(file, &quot;%s&quot;, n=
ame);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fscanf(stdin, &quot;%s&quot;, =
name);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;My name is %s\n&q=
uot;, name);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;I am ali=
ve!!!\n&quot;);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(file);<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;&gt; &gt; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is not making direct semihosting calls. The behaviour<br>
&gt;&gt;&gt; of these function calls will depend on whatever the C<br>
&gt;&gt;&gt; standard library implementation you&#39;re linking with is doi=
ng.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You&#39;re not checking for errors from any of your function<b=
r>
&gt;&gt;&gt; calls, incidentally.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; thanks<br>
&gt;&gt;&gt; -- PMM<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--0000000000001694c105b23202fe--

