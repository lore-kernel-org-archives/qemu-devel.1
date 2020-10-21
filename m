Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB2C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D3B22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dcomp-ufs-br.20150623.gappssmtp.com header.i=@dcomp-ufs-br.20150623.gappssmtp.com header.b="kXOsgINU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D3B22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dcomp.ufs.br
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEwX-0002pn-Ok
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kVEvp-00021S-58
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:17:37 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:41424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.otavio@gmail.com>)
 id 1kVEvm-0002ct-Fu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 10:17:36 -0400
Received: by mail-oi1-x22f.google.com with SMTP id q136so2217373oic.8
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dcomp-ufs-br.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iROrmkBqDzQeScHYQs2DCy4kVq7FcyoJUXW5d7IJkD0=;
 b=kXOsgINUroriAoCVbHomO554dCoa2oKAD/D8MGSlYtDycKpGRDhZaNbsXBslM3bnZU
 6RmtV4eW8ZZV5ypp1ivetRRiSobaWo5vCTwq3Q9SX09jhyxS074F/aEF5TPn+eJP3zpF
 8bLrzJEOIzioPE7h/wnWrJR3sAowGJNlFZQza2kKLEBY9ja3u2oYGWRQgyQAVHDpIe6d
 xGsBrFII7uXdT8dkls6KFRSBE08YqGXPHKtuRc0b/gFGy8bze+ZKU/PrpPOGuzgtfWLM
 7VfaFekCkCSnXSDZt4TH0Mqt3i4ct2+ViTdzSAR9oE/1OJRbITDayIOiTz0jwQouIXYS
 wbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iROrmkBqDzQeScHYQs2DCy4kVq7FcyoJUXW5d7IJkD0=;
 b=tDwRYpzb+NVCQr+V7Am9UFiKkY4CumEmohx/3eatcqgt2eKvLZ+WYYz/eVLXvmozPg
 J8JFspnT1EFAIAmrn1YwcsDGQSOo3vAUFl7Ysc3ybSK/RHiUGcw6E8gx7RVm8zmwQ0fU
 vVYh6eIQRpYqKHcqEp0hk8/20aNotrxsBwZW6mqqrAoSo4rWtddxCUvAFXUJqeNqa38w
 WlPGXZwyR6BsHrICMAYsL69seuMwF/mQe9KnYNNZWfMkOIdF7kkCDTa32HqqMtqDOWPd
 5MRklIX3VvcqHLsd2CADJVfSG2mOJh1uXqkpUfIJXhKEQ5xdPAWnQzTTJrFg7Nbe3mXx
 OkSA==
X-Gm-Message-State: AOAM532OG8Ljg6Lr1oZeCDwRRtGu6QhhWO7VfAYxcNJHs7Vx2NmU+zw3
 6n4QgI2+cmTNaCkpcgK8di7dp+yiNyLbHA95keY=
X-Google-Smtp-Source: ABdhPJwReNK4HfWhRHF+Qkn2A0xXEyHUABjS5fsaxL80yXbr0suAkE6+yX7PeNe11xhEc/A7C/nbDm7L7cZkyZOTtmU=
X-Received: by 2002:aca:5515:: with SMTP id j21mr2385256oib.150.1603289853069; 
 Wed, 21 Oct 2020 07:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
 <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
 <CAD5UmjrjORJbP0sj-DnGQFaQ443-vYMBa-1qCBzJsnUG+gU=jw@mail.gmail.com>
 <CAFEAcA9JecdSwd=gXSu7mhDHVysLP5JP4dtRBgBVr7=bt=j6Tw@mail.gmail.com>
 <CAD5UmjrFgv1pCKGW813dzmYcEEWLdvu9FmGi0ymvXbvfw-aonQ@mail.gmail.com>
In-Reply-To: <CAD5UmjrFgv1pCKGW813dzmYcEEWLdvu9FmGi0ymvXbvfw-aonQ@mail.gmail.com>
From: Bruno Prado <bruno@dcomp.ufs.br>
Date: Wed, 21 Oct 2020 11:16:56 -0300
Message-ID: <CAD5UmjqDGmOksXSk31q3asXLogSggc7rqOXuo2K2yLLs81ccQQ@mail.gmail.com>
Subject: Re: ARM semihosting issue
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002a0e9e05b22f0211"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=bruno.otavio@gmail.com; helo=mail-oi1-x22f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002a0e9e05b22f0211
Content-Type: text/plain; charset="UTF-8"

Hello, is it really a bug?

----
Bruno Prado


On Fri, Oct 2, 2020 at 8:09 AM Bruno Prado <bruno@dcomp.ufs.br> wrote:

> I am including some syscall functions:
>
> int _fstat(int file, struct stat* st) {
>        register int value asm("r0");
>        uint32_t p[] = { file };
>        R0(0x0C);
>        R1(p);
>        BKPT();
>        return value;
> }
>
> int _read(int file, char* ptr, int len) {
>        register int value asm("r0");
>        uint32_t p[] = { file, (uint32_t)(ptr), len };
>        R0(0x06);
>        R1(p);
>        BKPT();
>        return value;
> }
>
> int _write(int file, char* ptr, int len) {
>        register int value asm("r0");
>        uint32_t p[] = { file, (uint32_t)(ptr), len };
>        R0(0x05);
>        R1(p);
>        BKPT();
>        return value;
> }
>
> Also the interruption output from execution:
>
> $ qemu-system-arm -M netduino2 -nographic -semihosting -kernel vp2.bin -d
> int
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x1
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x1
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x1
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x1
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0xc
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x5
> What is your name?
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x5
> Reading from file...
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0xc
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x6
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0xc
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x6
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x5
> My name is Turing
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x5
> I am alive!!!
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0xa
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0xa
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x2
> Taking exception 16 [Semihosting call]
> ...handling as semihosting call 0x20
>
> Could you please provide any working example using ARM semihosting on
> stdin?
>
> Thanks,
> ----
> Bruno Prado
>
>
> On Fri, Oct 2, 2020 at 7:25 AM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On Thu, 1 Oct 2020 at 22:21, Bruno Prado <bruno@dcomp.ufs.br> wrote:
>> > Thanks for the reply... I am attaching some code and output:
>> >
>> > #include <stdio.h>
>> > int main() {
>> >        char name[50] = "Nobody";
>> >        FILE* file = fopen("name", "r");
>> >        printf("What is your name?\n");
>> >        fprintf(stdout, "Reading from file...\n");
>> >        fscanf(file, "%s", name);
>> >        fscanf(stdin, "%s", name);
>> >        printf("My name is %s\n", name);
>> >        fprintf(stderr, "I am alive!!!\n");
>> >        fclose(file);
>> >        return 0;
>> > }
>>
>> This is not making direct semihosting calls. The behaviour
>> of these function calls will depend on whatever the C
>> standard library implementation you're linking with is doing.
>>
>> You're not checking for errors from any of your function
>> calls, incidentally.
>>
>> thanks
>> -- PMM
>>
>

--0000000000002a0e9e05b22f0211
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello, is it really a bug?<div><br clear=3D"all"><div><div=
 dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-=
---<br>Bruno Prado</div></div><br></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 2, 2020 at 8:09 AM Brun=
o Prado &lt;<a href=3D"mailto:bruno@dcomp.ufs.br">bruno@dcomp.ufs.br</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr">I am including some syscall functions:<div><br></div><div><span s=
tyle=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0)">int _fstat(=
int file, struct stat* st) {
</span><br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0register int value as=
m(&quot;r0&quot;);
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t p[] =3D { file };
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0R0(0x0C);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0R1(p);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BKPT();
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return value;
<br>}<br></span></div><div><br></div><div><span style=3D"font-family:monosp=
ace"><span style=3D"color:rgb(0,0,0)">int _read(int file, char* ptr, int le=
n) {
</span><br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0register int value as=
m(&quot;r0&quot;);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t p[] =3D { file, (ui=
nt32_t)(ptr), len };
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0R0(0x06);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0R1(p);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BKPT();
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return value;
<br>}<br></span></div><div><br></div><div><span style=3D"font-family:monosp=
ace"><span style=3D"color:rgb(0,0,0)">int _write(int file, char* ptr, int l=
en) {
</span><br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0register int value as=
m(&quot;r0&quot;);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t p[] =3D { file, (ui=
nt32_t)(ptr), len };
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0R0(0x05);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0R1(p);
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BKPT();
<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return value;
<br>}<br></span><div><div dir=3D"ltr"><br></div><div>Also the interruption =
output from execution:</div><div><br></div><div><span style=3D"font-family:=
monospace"><span style=3D"color:rgb(0,0,0)">$ qemu-system-arm -M netduino2 =
-nographic -semihosting -kernel vp2.bin -d int
</span><br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x1
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x1
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x1
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x1
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0xc
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x5
<br>What is your name?
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x5
<br>Reading from file...
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0xc
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x6
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0xc
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x6
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x5
<br>My name is Turing
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x5
<br>I am alive!!!
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0xa
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0xa
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x2
<br>Taking exception 16 [Semihosting call]
<br>...handling as semihosting call 0x20<br></span></div><div dir=3D"ltr"><=
br></div><div>Could you please provide any working example using ARM semiho=
sting on stdin?</div><div><br></div><div>Thanks,</div><div dir=3D"ltr">----=
<br>Bruno Prado</div></div><br></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 2, 2020 at 7:25 AM Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pe=
ter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Thu, 1 Oct 2020 at 22:21, Bruno Prado &lt;<a href=
=3D"mailto:bruno@dcomp.ufs.br" target=3D"_blank">bruno@dcomp.ufs.br</a>&gt;=
 wrote:<br>
&gt; Thanks for the reply... I am attaching some code and output:<br>
&gt;<br>
&gt; #include &lt;stdio.h&gt;<br>
&gt; int main() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 char name[50] =3D &quot;Nobody&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE* file =3D fopen(&quot;name&quot;, &quo=
t;r&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;What is your name?\n&quot;);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stdout, &quot;Reading from file...\=
n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fscanf(file, &quot;%s&quot;, name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fscanf(stdin, &quot;%s&quot;, name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;My name is %s\n&quot;, name);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;I am alive!!!\n&quot;=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(file);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; }<br>
<br>
This is not making direct semihosting calls. The behaviour<br>
of these function calls will depend on whatever the C<br>
standard library implementation you&#39;re linking with is doing.<br>
<br>
You&#39;re not checking for errors from any of your function<br>
calls, incidentally.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>
</blockquote></div>

--0000000000002a0e9e05b22f0211--

