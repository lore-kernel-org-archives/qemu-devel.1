Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D0C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 13:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF5E2073C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 13:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqzqIoiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF5E2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibP07-0006qU-Eu
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 08:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibOz4-0006E1-CU
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 08:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibOz2-0007h7-8H
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 08:09:54 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibOz1-0007gg-Vd
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 08:09:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id o9so7600591ote.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 05:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dXyJzs25woR94ZKyXLAuhcyFgLHwpcpCheBYT5iyP9c=;
 b=aqzqIoiKvBVe7g6cca0PaogemS4lxKXmvaU2ge0pi9zDBnTF/jUHIqqm+iaUuvSj6o
 xvHnFqFZVQOyn25SU1jEahE1wfLhX5bRUvPQ3KLjlukUGsJvDAox20aILH23amDmvOpO
 8SRMVQRW6swG19l7tQS9mZ3f6AOIl7udvqa2+3RO6jYglYzO4IQ79h3t5RpFGp+PNlvx
 3+5XFdqRAuCC9CI2WdV2dHfpkFjejBS3zW/i/3CyVZUht3pDeCmZXGAx4naRBoF9ena2
 BFg88FIGZ9MYsMZPg09eie02v25P7hX4CmnTg7zI8RypKD2X9QKI4o/38keankSqZJwU
 5uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dXyJzs25woR94ZKyXLAuhcyFgLHwpcpCheBYT5iyP9c=;
 b=lmc4a4b2bcQpE3zlau6Hv1O5uBaKVzsv64XumI54u6SdUGLiL6r66MiraRatrOfmW1
 tkUEVexQsTrxauvm6Zv4nQbX/31hpJsYoIPESMLmyZ/A+Eu4NjpSixH6+PQBzY2sVaIE
 alNP24JxK17YF5ZZp1qgbF/OY4ca05EjkUKgD4uaxmnYOgrFucz0t60nHI92Zgfk1tzN
 RTrrnE+mpNOHv5FOKJiB66VwBGlWXOtNGSValKBB7xwb+tZMgME1cEym9WIDboj6GvV0
 Sj0mLu0pryzknoKvUvH/DxwgHmu8Ua9mmDIDW5QX1wqwjq+vOVpBon6Mn7/UsLlSZto2
 xbOA==
X-Gm-Message-State: APjAAAXD8LxgE6zcdY+/CirUtm6EDeLyEUFieSNA6OQ79tUBgod34pd9
 eauiqPaxF9RF/yzbxyffhF9jSZWMOxJXGeEk2P4=
X-Google-Smtp-Source: APXvYqyH/L1MKJfvJtyQa1nbD3DwEHwx62awklS4SZsKkyQlkwh1tgLsL+QYRCoIyRMk63YOXMjNjjQh/wk94xm3Elk=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr12593400oth.121.1575205791041; 
 Sun, 01 Dec 2019 05:09:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 05:09:50
 -0800 (PST)
In-Reply-To: <CAK4993i8zPyYH2hGxx0hP4qQKr9oTJV2T5JDtQmKHZe2EpAsvw@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
 <5a784557-f322-dc3a-4ff1-a7d9a0409448@redhat.com>
 <CAL1e-=jJ5uNvYq7yNQYFhMJ0k94-d6mrybs-NyVjVi9Agb4Aeg@mail.gmail.com>
 <CAK4993i8zPyYH2hGxx0hP4qQKr9oTJV2T5JDtQmKHZe2EpAsvw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 14:09:50 +0100
Message-ID: <CAL1e-=jPqCde4=uVqfvnCZKVauNw2EQO57ET5oqUSQTRSrWEDg@mail.gmail.com>
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009f8e250598a42d04"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

--0000000000009f8e250598a42d04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Renaming devices such hw/char/avr_usart.c -> hw/char/atmel_usart.c
> (similarly with the macros) would be enough Aleksandar?
>
> On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> I will rename them.
>

AVR is the name of a microcontroller lineup, and Atmel is the name of the
company that started producing them. Atmel was recently acquired by
Microchip, so thw word Atmel now does not even exist in new specs.

Taking this into account, I don't think renaming

hw/char/avr_usart.c -> hw/char/atmel_usart.c

is not appropriate. Renaming macros, too. The current names are fine, for
now.

A separate but related naming question will show up later in future, when
we, let's say, want to implement two different version of a peripheral
(let's say USART), one as specified for older microcontrollers, and one for
newer.

But, OK, let's leave that for future.

Regards,
Aleksandar



> On Thu, Nov 28, 2019 at 3:41 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com>
>> wrote:
>>
>>> On 11/28/19 2:25 PM, Michael Rolnik wrote:
>>>
>>>> I don't see why you say that the peripherals are inside the chip, ther=
e
>>>> is CPU within target/avr directory and then there are some peripherals=
 in
>>>> hw directory, CPU does not depend on them. what am I missing?
>>>>
>>>> On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic <
>>>> aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
>>>> wrote:
>>>>
>>>>
>>>>
>>>>     On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com
>>>>     <mailto:mrolnik@gmail.com>> wrote:
>>>>
>>>>
>>>>
>>>>         On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic
>>>>         <aleksandar.m.mail@gmail.com
>>>>         <mailto:aleksandar.m.mail@gmail.com>> wrote:
>>>>
>>>>             On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik
>>>>             <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
>>>>              >
>>>>              > This series of patches adds 8bit AVR cores to QEMU.
>>>>              > All instruction, except BREAK/DES/SPM/SPMX, are
>>>>             implemented. Not fully tested yet.
>>>>              > However I was able to execute simple code with function=
s.
>>>>             e.g fibonacci calculation.
>>>>              > This series of patches include a non real, sample board=
.
>>>>              > No fuses support yet. PC is set to 0 at reset.
>>>>              >
>>>>
>>>>             I have a couple of general remarks, so I am responding to
>>>>             the cover
>>>>             letter, not individual patches.
>>>>
>>>>             1) The licenses for Sarah devices differ than the rest -
>>>>             shouldn't all
>>>>             licenses be harmonized?
>>>>
>>>>         Sarah,
>>>>         do you mind if use the same license I use for my code?
>>>>
>>>>
>>>>             2) There is an architectural problem with peripherals. It =
is
>>>>             possible
>>>>             that they evolve over time, so, for example, USART could n=
ot
>>>>             be the
>>>>             same for older and newer CPUs (in principle, newer
>>>> peripheral is
>>>>             expected to be o sort of "superset" of the older). How do
>>>>             you solve
>>>>             that problem? Right now, it may not looks serious to you,
>>>>             but if you
>>>>             don;t think about that right now, from the outset, soon th=
e
>>>>             code will
>>>>             become so entangled, ti woudl be almost very difficult to
>>>>             fix it.
>>>>             Please think about that, how would you solve it, is there =
a
>>>>             way to
>>>>             pass the information on the currently emulated CPU to the
>>>> code
>>>>             covering a peripheral, and provide a different behaviour?
>>>>
>>>>         Hi Aleksandar,
>>>>
>>>>         Please explain.
>>>>
>>>>
>>>>     My concern is about peripherals inside the chip, together with the
>>>> core.
>>>>
>>>>     If one models, let's say an external (in the sense, it is a separa=
te
>>>>     chip) ADC (analog-to-digital converter), one looks at specs,
>>>>     implement what is resonable possible in QEMU, plug it in in one of
>>>>     machines thst contains it, and that's it. That ADC remains the sam=
e,
>>>>     of course, whatever the surrounding system is.
>>>>
>>>>     In AVR case, I think we have a phenomenon likes of which we didn't
>>>>     see before (at least I don't know about). Number of AVR
>>>>     microcontrollers is very large, and both cores and peripherals
>>>> evolved.
>>>>
>>>>     For cores, you handle differences with all these AVR_FEATURE macro=
s,
>>>>     and this seems to be working, no significant objection from my sid=
e,
>>>>     and btw that was not an easy task to execute, all admiration from
>>>> me.
>>>>
>>>>     But what about peripherals inside the chip? A peripheral with the
>>>>     same name and the same general area of functionality may be
>>>>     differently specified for microcontrollers from 2010 and 2018. By
>>>>     the difference I don't mean starting address, but the difference i=
n
>>>>     behavior. I don't have time right now to spell many examples, but =
I
>>>>     read three different specs, and there are differences in USART
>>>>     specifications.
>>>>
>>>>     I am not clear what is your envisioned solution for these cases.
>>>>     Would you such close, but not the same, flabors of a peripheral
>>>>     treat as if they are two completely separate cases of a peripheral=
?
>>>>     Or would you have a single peripheral that would somehow configure
>>>>     itself depending on the core it is attached to?
>>>>
>>>>     I hope I was clearer this time.
>>>>
>>>>     Aleksandar
>>>>
>>>>
>>>>
>>>>
>>>>         I don't see any problem from CPU's perspective.
>>>>         as for the sample board is just a sample, I hope other people
>>>>         will create real models or real hw.
>>>>         there was no way I could provide a CPU alone, that's why there
>>>>         is sample.
>>>>
>>>
>>> If I understand Aleksandar correctly, the naming is incorrect because
>>> too generic to AVR family, why Sarah only modeled the Atmel implementat=
ion.
>>>
>>> Renaming devices such hw/char/avr_usart.c -> hw/char/atmel_usart.c
>>> (similarly with the macros) would be enough Aleksandar?
>>>
>>>
>>
>> Some renaming could help, perhaps not quite like the one above, but my
>> point (which I find hard to believe I can't explain to you) is that
>> peripherals inside the chip evolved over time, as starkly opposed to
>> external peripherals that are set in stone...
>>
>
>
> --
> Best Regards,
> Michael Rolnik
>

--0000000000009f8e250598a42d04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"gmail_quote" style=3D"color:rgb(0,123,53);font-size:14=
px;line-height:22.1200008392334px;margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-le=
ft:1ex">Renaming devices such hw/char/avr_usart.c -&gt; hw/char/atmel_usart=
.c (similarly with the macros) would be enough Aleksandar?<br><br></blockqu=
ote>On Thursday, November 28, 2019, Michael Rolnik &lt;<a href=3D"mailto:mr=
olnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr">I will rename them.</div></blockquote><div><br></=
div><div>AVR is the name of a microcontroller lineup, and Atmel is the name=
 of the company that started producing them. Atmel was recently acquired by=
 Microchip, so thw word Atmel now does not even exist in new specs.</div><d=
iv><br></div><div>Taking this into account, I don&#39;t think renaming=C2=
=A0</div><div><br></div><div><span style=3D"color:rgb(0,123,53);font-size:1=
4px;line-height:22.1200008392334px">hw/char/avr_usart.c -&gt; hw/char/atmel=
_usart.c</span><br></div><div><br></div><div>is not appropriate. Renaming m=
acros, too. The current names are fine, for now.</div><div><br></div><div>A=
 separate but related naming question will show up later in future, when we=
, let&#39;s say, want to implement two different version of a peripheral (l=
et&#39;s say USART), one as specified for older microcontrollers, and one f=
or newer.</div><div><br></div><div>But, OK, let&#39;s leave that for future=
.</div><div><br></div><div>Regards,</div><div>Aleksandar</div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 3:41 PM Ale=
ksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=
=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br><br>On Thursday, November 28, 20=
19, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" ta=
rget=3D"_blank">philmd@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 11/28/19 2:25 PM, Michael Rolnik wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I don&#39;t see why you say that the peripherals are inside the chip, there=
 is CPU within target/avr directory and then there are some peripherals=C2=
=A0in hw directory, CPU does not depend on them. what am I missing?<br>
<br>
On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic &lt;<a href=3D"mailto:a=
leksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</=
a> &lt;mailto:<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_bla=
nk">aleksandar.m.mail@<wbr>gmail.com</a>&gt;&gt; wrote:<br>
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
gmail.com" target=3D"_blank">aleksandar.m.mail@<wbr>gmail.com</a>&gt;&gt; w=
rote:<br>
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
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--0000000000009f8e250598a42d04--

