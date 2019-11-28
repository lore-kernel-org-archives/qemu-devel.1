Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FAA21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa5yEt8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FAA21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKng-0001SI-VW
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iaK9U-0004NS-QY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iaK9O-0008G9-UG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:48:10 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32]:46163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iaK9N-0007vz-Ph
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:48:06 -0500
Received: by mail-qv1-xf32.google.com with SMTP id t9so253950qvh.13
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T2wn9cklqee2U2Z0NqjwUV/+20RCBNB7HYANQt375L4=;
 b=Aa5yEt8Mo0HU5LWgLkDLvUOkNjaymP1ZUKj+rc5Tx2ePeG+IBZay3duoyGlZgIrqs9
 EfXSUjfv4jYDtnDr+F+sxoSiTVIEdK9AHiLwNv2T6Uki4WsEuaLY27rvQJTA6biyvZi3
 P5ODoYjikXNP7XHdmscJBIFbqu8aTfXr6+TALoxioDnq0vcbAQ2mped7i01LKghXlGoi
 G0vks9JKPlaaN7pBicMk2ifBMThZY0XSsSJQdFIOrzo6+e+rMGbCYRvChh5k+d/uelM9
 UsA4lhgltAJ2YW7xjTd7Sv4qdaKP6ve6KWSNigjQPBrGojoZ2sC7IOd8W4yIm3M4mI1N
 8Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T2wn9cklqee2U2Z0NqjwUV/+20RCBNB7HYANQt375L4=;
 b=RxlClBuIzLLLDgIPSgc5DBGEEvIdsCZavkWnUEdiizcdJr1RNJvRxJ+bX8zmvrQyMB
 isJiVKtlKWNS6e9Tajq6RWi2+FkDJeV1RlKaJFv+HV7FENZY8PVG3M9UAo9hHiIbxZQV
 scsYleW74dFow3RoSvbaypRXcLSzibk/FnBshGjrqXR9VvsRvDM2hAy+A2xc3luH4itT
 gqGzyqYjs//sZN5JUr9/BTvqFD8akvRXEf7ZzWxrcFgHaKwOAFTumkn9yfkcSPF6qFxu
 xmO4rVZMSKGMDFSb8j4BEx+0U29uO5WDvNsi2ZN5ILpLZ9O16MHiWBXAENLdsm5AwYlY
 Nqsg==
X-Gm-Message-State: APjAAAVlKCJH70yxEm6b+SwV5cjkh3YDUh9wz8LVZuUm4i3wSD3biySY
 CawhoaQfnP5YJA0ZDUnkWliIMSSgBKpmAgVvitQ=
X-Google-Smtp-Source: APXvYqzh8R4GaxJPmG9mqPplSqAX9VoO94iLt9PJwziJxrBerw3NS+Ggtn0Y2KuutSkeqVBAZIkdOurX/Y+cXKzO18U=
X-Received: by 2002:a05:6214:8e5:: with SMTP id
 dr5mr10576569qvb.79.1574948881353; 
 Thu, 28 Nov 2019 05:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
 <5a784557-f322-dc3a-4ff1-a7d9a0409448@redhat.com>
 <CAL1e-=jJ5uNvYq7yNQYFhMJ0k94-d6mrybs-NyVjVi9Agb4Aeg@mail.gmail.com>
In-Reply-To: <CAL1e-=jJ5uNvYq7yNQYFhMJ0k94-d6mrybs-NyVjVi9Agb4Aeg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 28 Nov 2019 15:46:53 +0200
Message-ID: <CAK4993i8zPyYH2hGxx0hP4qQKr9oTJV2T5JDtQmKHZe2EpAsvw@mail.gmail.com>
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009ccf630598685ce5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f32
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009ccf630598685ce5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will rename them.

On Thu, Nov 28, 2019 at 3:41 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> On 11/28/19 2:25 PM, Michael Rolnik wrote:
>>
>>> I don't see why you say that the peripherals are inside the chip, there
>>> is CPU within target/avr directory and then there are some peripherals =
in
>>> hw directory, CPU does not depend on them. what am I missing?
>>>
>>> On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic <
>>> aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote=
:
>>>
>>>
>>>
>>>     On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com
>>>     <mailto:mrolnik@gmail.com>> wrote:
>>>
>>>
>>>
>>>         On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic
>>>         <aleksandar.m.mail@gmail.com
>>>         <mailto:aleksandar.m.mail@gmail.com>> wrote:
>>>
>>>             On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik
>>>             <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
>>>              >
>>>              > This series of patches adds 8bit AVR cores to QEMU.
>>>              > All instruction, except BREAK/DES/SPM/SPMX, are
>>>             implemented. Not fully tested yet.
>>>              > However I was able to execute simple code with functions=
.
>>>             e.g fibonacci calculation.
>>>              > This series of patches include a non real, sample board.
>>>              > No fuses support yet. PC is set to 0 at reset.
>>>              >
>>>
>>>             I have a couple of general remarks, so I am responding to
>>>             the cover
>>>             letter, not individual patches.
>>>
>>>             1) The licenses for Sarah devices differ than the rest -
>>>             shouldn't all
>>>             licenses be harmonized?
>>>
>>>         Sarah,
>>>         do you mind if use the same license I use for my code?
>>>
>>>
>>>             2) There is an architectural problem with peripherals. It i=
s
>>>             possible
>>>             that they evolve over time, so, for example, USART could no=
t
>>>             be the
>>>             same for older and newer CPUs (in principle, newer
>>> peripheral is
>>>             expected to be o sort of "superset" of the older). How do
>>>             you solve
>>>             that problem? Right now, it may not looks serious to you,
>>>             but if you
>>>             don;t think about that right now, from the outset, soon the
>>>             code will
>>>             become so entangled, ti woudl be almost very difficult to
>>>             fix it.
>>>             Please think about that, how would you solve it, is there a
>>>             way to
>>>             pass the information on the currently emulated CPU to the
>>> code
>>>             covering a peripheral, and provide a different behaviour?
>>>
>>>         Hi Aleksandar,
>>>
>>>         Please explain.
>>>
>>>
>>>     My concern is about peripherals inside the chip, together with the
>>> core.
>>>
>>>     If one models, let's say an external (in the sense, it is a separat=
e
>>>     chip) ADC (analog-to-digital converter), one looks at specs,
>>>     implement what is resonable possible in QEMU, plug it in in one of
>>>     machines thst contains it, and that's it. That ADC remains the same=
,
>>>     of course, whatever the surrounding system is.
>>>
>>>     In AVR case, I think we have a phenomenon likes of which we didn't
>>>     see before (at least I don't know about). Number of AVR
>>>     microcontrollers is very large, and both cores and peripherals
>>> evolved.
>>>
>>>     For cores, you handle differences with all these AVR_FEATURE macros=
,
>>>     and this seems to be working, no significant objection from my side=
,
>>>     and btw that was not an easy task to execute, all admiration from m=
e.
>>>
>>>     But what about peripherals inside the chip? A peripheral with the
>>>     same name and the same general area of functionality may be
>>>     differently specified for microcontrollers from 2010 and 2018. By
>>>     the difference I don't mean starting address, but the difference in
>>>     behavior. I don't have time right now to spell many examples, but I
>>>     read three different specs, and there are differences in USART
>>>     specifications.
>>>
>>>     I am not clear what is your envisioned solution for these cases.
>>>     Would you such close, but not the same, flabors of a peripheral
>>>     treat as if they are two completely separate cases of a peripheral?
>>>     Or would you have a single peripheral that would somehow configure
>>>     itself depending on the core it is attached to?
>>>
>>>     I hope I was clearer this time.
>>>
>>>     Aleksandar
>>>
>>>
>>>
>>>
>>>         I don't see any problem from CPU's perspective.
>>>         as for the sample board is just a sample, I hope other people
>>>         will create real models or real hw.
>>>         there was no way I could provide a CPU alone, that's why there
>>>         is sample.
>>>
>>
>> If I understand Aleksandar correctly, the naming is incorrect because to=
o
>> generic to AVR family, why Sarah only modeled the Atmel implementation.
>>
>> Renaming devices such hw/char/avr_usart.c -> hw/char/atmel_usart.c
>> (similarly with the macros) would be enough Aleksandar?
>>
>>
>
> Some renaming could help, perhaps not quite like the one above, but my
> point (which I find hard to believe I can't explain to you) is that
> peripherals inside the chip evolved over time, as starkly opposed to
> external peripherals that are set in stone...
>


--=20
Best Regards,
Michael Rolnik

--0000000000009ccf630598685ce5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will rename them.</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 3:41 PM Aleksan=
dar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.=
m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br><br>On Thursday, November 28, 2019, Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@=
redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 11/28/19 2:25 PM, Michael Rolnik wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I don&#39;t see why you say that the peripherals are inside the chip, there=
 is CPU within target/avr directory and then there are some peripherals=C2=
=A0in hw directory, CPU does not depend on them. what am I missing?<br>
<br>
On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic &lt;<a href=3D"mailto:a=
leksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</=
a> &lt;mailto:<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_bla=
nk">aleksandar.m.mail@gmail.com</a>&gt;&gt; wrote:<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 On Thursday, November 28, 2019, Michael Rolnik &lt;<a href=3D=
"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:mrolnik@gmail.com" target=3D"_bl=
ank">mrolnik@gmail.com</a>&gt;&gt; wrote:<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Mar=
kovic<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.c=
om" target=3D"_blank">aleksandar.m.mail@gmail.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:aleksandar.m.mail@=
gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;&gt; wrote:=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, Nov 27, 2019 at 6:53 PM M=
ichael Rolnik<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:mrolnik@gma=
il.com" target=3D"_blank">mrolnik@gmail.com</a> &lt;mailto:<a href=3D"mailt=
o:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;&gt; wrote:=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; This series of patches=
 adds 8bit AVR cores to QEMU.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; All instruction, excep=
t BREAK/DES/SPM/SPMX, are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 implemented. Not fully tested yet=
.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; However I was able to =
execute simple code with functions.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e.g fibonacci calculation.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; This series of patches=
 include a non real, sample board.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; No fuses support yet. =
PC is set to 0 at reset.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I have a couple of general remark=
s, so I am responding to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the cover<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 letter, not individual patches.<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1) The licenses for Sarah devices=
 differ than the rest -<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shouldn&#39;t all<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 licenses be harmonized?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sarah,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do you mind if use the same license I use for m=
y code?<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2) There is an architectural prob=
lem with peripherals. It is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 possible<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that they evolve over time, so, f=
or example, USART could not<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 same for older and newer CPUs (in=
 principle, newer peripheral is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expected to be o sort of &quot;su=
perset&quot; of the older). How do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 you solve<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that problem? Right now, it may n=
ot looks serious to you,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 but if you<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 don;t think about that right now,=
 from the outset, soon the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 code will<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 become so entangled, ti woudl be =
almost very difficult to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fix it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Please think about that, how woul=
d you solve it, is there a<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 way to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass the information on the curre=
ntly emulated CPU to the code<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 covering a peripheral, and provid=
e a different behaviour?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi Aleksandar,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Please explain.<br>
<br>
<br>
=C2=A0 =C2=A0 My concern is about peripherals inside the chip, together wit=
h the core.<br>
<br>
=C2=A0 =C2=A0 If one models, let&#39;s say an external (in the sense, it is=
 a separate<br>
=C2=A0 =C2=A0 chip) ADC (analog-to-digital converter), one looks at specs,<=
br>
=C2=A0 =C2=A0 implement what is resonable possible in QEMU, plug it in in o=
ne of<br>
=C2=A0 =C2=A0 machines thst contains it, and that&#39;s it. That ADC remain=
s the same,<br>
=C2=A0 =C2=A0 of course, whatever the surrounding system is.<br>
<br>
=C2=A0 =C2=A0 In AVR case, I think we have a phenomenon likes of which we d=
idn&#39;t<br>
=C2=A0 =C2=A0 see before (at least I don&#39;t know about). Number of AVR<b=
r>
=C2=A0 =C2=A0 microcontrollers is very large, and both cores and peripheral=
s evolved.<br>
<br>
=C2=A0 =C2=A0 For cores, you handle differences with all these AVR_FEATURE =
macros,<br>
=C2=A0 =C2=A0 and this seems to be working, no significant objection from m=
y side,<br>
=C2=A0 =C2=A0 and btw that was not an easy task to execute, all admiration =
from me.<br>
<br>
=C2=A0 =C2=A0 But what about peripherals inside the chip? A peripheral with=
 the<br>
=C2=A0 =C2=A0 same name and the same general area of functionality may be<b=
r>
=C2=A0 =C2=A0 differently specified for microcontrollers from 2010 and 2018=
. By<br>
=C2=A0 =C2=A0 the difference I don&#39;t mean starting address, but the dif=
ference in<br>
=C2=A0 =C2=A0 behavior. I don&#39;t have time right now to spell many examp=
les, but I<br>
=C2=A0 =C2=A0 read three different specs, and there are differences in USAR=
T<br>
=C2=A0 =C2=A0 specifications.<br>
<br>
=C2=A0 =C2=A0 I am not clear what is your envisioned solution for these cas=
es.<br>
=C2=A0 =C2=A0 Would you such close, but not the same, flabors of a peripher=
al<br>
=C2=A0 =C2=A0 treat as if they are two completely separate cases of a perip=
heral?<br>
=C2=A0 =C2=A0 Or would you have a single peripheral that would somehow conf=
igure<br>
=C2=A0 =C2=A0 itself depending on the core it is attached to?<br>
<br>
=C2=A0 =C2=A0 I hope I was clearer this time.<br>
<br>
=C2=A0 =C2=A0 Aleksandar<br>
<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I don&#39;t see any problem from CPU&#39;s pers=
pective.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 as for the sample board is just a sample, I hop=
e other people<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 will create real models or real hw.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 there was no way I could provide a CPU alone, t=
hat&#39;s why there<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 is sample.<br>
</blockquote>
<br>
If I understand Aleksandar correctly, the naming is incorrect because too g=
eneric to AVR family, why Sarah only modeled the Atmel implementation.<br>
<br>
Renaming devices such hw/char/avr_usart.c -&gt; hw/char/atmel_usart.c (simi=
larly with the macros) would be enough Aleksandar?<br>
<br>
</blockquote><div><br></div><div><br></div><div>Some renaming could help, p=
erhaps not quite like the one above, but my point (which I find hard to bel=
ieve I can&#39;t explain to you) is that peripherals inside the chip evolve=
d over time, as starkly opposed to external peripherals that are set in sto=
ne...</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000009ccf630598685ce5--

