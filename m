Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC03AC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3792245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXrljjOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3792245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icp5Y-0002ip-N1
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 06:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icp4c-0001hn-JO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icp4a-0004Mi-Iu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:13:30 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icp4W-0004HC-04
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 06:13:24 -0500
Received: by mail-oi1-x242.google.com with SMTP id a67so2358151oib.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=nwVLJCHDhe+L7VkcN7T0cNaLHAII9uD6cDr5bifPb6s=;
 b=dXrljjOlbC1rlpyTGICxxoz8/bknVkjUxyKKBuVg/3tz2n3YelgeGEnYndddiwxnMo
 /odo6gRor8igsclGSzPuwxJIVWHopTq9vmiPs2ygixRzVwf6qPi5P/dhFPL6LPHZn9Oe
 iCDbfHTU5BLymNgh4DrGKd9Y5SUpHx8SvWKQI2f2am51NJ7PSb0QWEweiRKD3CEPqXJQ
 Tb0pAgwrDDyB0qdfkjMh0xC0niAX7vst6Gi35lVYVsQ7ks9JTvVFKOXYkYch0RrZy+Mb
 QAIUKdzdS7vjbXM1/0HKIWCXeujfvWxb3pSP2YWhlKaJ9grwhrJOhAH9D6N2kEump/iO
 QsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=nwVLJCHDhe+L7VkcN7T0cNaLHAII9uD6cDr5bifPb6s=;
 b=bnf+UY5AAt34bFggKurewkLF/eZnQ4lyi0uQmRS3onkkSDq3nmwmO2ndrwsIQqx00Y
 nrPdEuaeGr6DmShsP4deSCJJNLCDS0tMvOj4UePS882+ljDt0l9cj18M+/wmkM4RBKeg
 n02xxX6K+sK6Muhna7S/ueZOeri+ZO6/YJSA4KCSHRrolfhZLedmGejg0Ryr4LTSDsGh
 QKEHdODru1dnDMmeIxcm4OrLF8S10oIPvm1GvnoYC/77e3i5HiW0cpPx5E2/261esLUq
 Skl3A6gdJuPwqSBtXfNB5eOgELbfVScAFIdW1g8R7D8A8fRvykPBQWcKYAsTmGjLfo7F
 qQaQ==
X-Gm-Message-State: APjAAAW7V6CuD8eIN+B+WKjZa73/mCCHZ7fX6f85YJEMpg+fIR76fGkm
 36ampvYUSvKNP9TADIZn/wv1RsrhddiTsRcQrCI=
X-Google-Smtp-Source: APXvYqyxMwH3i81BoHXLeT/6S/2c/GwZxKG6M3mLXlZodI5YUymTMpEQid4qyCmbdG5K/0y4DbW3NjzSkcKMIopSRCs=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr6785605oic.62.1575544400356; 
 Thu, 05 Dec 2019 03:13:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 5 Dec 2019 03:13:19 -0800 (PST)
In-Reply-To: <CAL1e-=i6qjd2hwNqpV3eWmhN-QozC2c7jJnsns0JjGpLb+-Ppg@mail.gmail.com>
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-6-mrolnik@gmail.com>
 <000c01d542cf$d8476a00$88d63e00$@ru>
 <CAL1e-=h70Hrs7fFEBMgzhrq3HKhxuy9qGQg5148jJ1ACALSThg@mail.gmail.com>
 <CAL1e-=i6qjd2hwNqpV3eWmhN-QozC2c7jJnsns0JjGpLb+-Ppg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Dec 2019 12:13:19 +0100
Message-ID: <CAL1e-=izrNETHWpUNhUTsuLD9sSKSpUWXT8-=dgW9W=4sjmiLw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited support for
 USART and 16 bit timer peripherals
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004fa7be0598f304ff"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004fa7be0598f304ff
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 5, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Thursday, December 5, 2019, Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Thursday, July 25, 2019, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>>
>>> > From: Qemu-devel [mailto:qemu-devel-bounces+patchwork-qemu-
>>> > devel=patchwork.kernel.org@nongnu.org] On Behalf Of Michael Rolnik
>>> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
>>> >
>>> > These were designed to facilitate testing but should provide enough
>>> function to be useful in
>>> > other contexts.
>>>
>>> USART is very useful for testing, but to which model of AVR is belongs?
>>> We also started implementation of USART and other devices in our
>>> internship program,
>>> using prior version of your patches.
>>> There were other register addresses for the registers and some of them
>>> even intersect
>>> making read/write logic more complex (we looked at Atmega8).
>>>
>>> You also mix the board and the SoC into one file, making
>>> hardware-on-chip harder to reuse.
>>>
>>> I think that the structure can be revised in the following way:
>>> Board -> SoC -> Devices
>>>
>>>
>> Pavel,
>>
>> By "structure", did you mean structure of patches?
>>
>> Let's say, after the all ISA instruction patches are introduced, we first
>> introduce one real board of our choice (only infrastructure, with almost
>> empty content, than devices on that board, than the corresponding SoC/MCU
>> infrastucture, than device in that SoC.
>>
>> Additional boards would follow the same pattern, potentially reusing
>> already implemented devices, or whole SoC/MCU.
>>
>> One more question:
>>
>> We already saw that devices within SoC/MCUs for AVR platform exibit great
>> variation. First, there are around 17 generation of AVR cores (avr1, avr2,
>> ... xmega7). Than, there is, I think 600+ SoC/MCU models (hard to believe,
>> but true). Each SoC defines its devices, and in potentially different way
>> (not only its starting address, but real differences in terms of
>> functionality). I thought that at least for a particular core, the devices
>> would be defined in a consistent way, but even that is not true - for
>> example ADC for a SoC having core X can be significantly different that ADC
>> for another SoC having the same core X.
>>
>> How to deal with such avalanche of devices? How to organize and maintain
>> 27 significantly different versions of ADC; and 53 significantly different
>> versions of Watchdogs (the numbers are invented by me, but are likely to
>> describe the situation well)?
>>
>>
> Peter, may I ask you the same questions?
>
> I have a strong impression we here need to think colectively.
>
>
Of course, I did not mean that we'll ever support 600+ AVR SoCs/MCUs, or 53
AVR watchogs, but, as the work in Pavel's repository illustrates, we will
stumble very soon on, let's say different USART devices (in this case
between "atmega2560" and one of "xmega" cores. It is realistic that we can
potentially end up needing support for 5-6 AVR USARTs. How to name them, as
a first question?

Not to mention also possible dependencies between various devices,
interleaved memory ranges, shared registers...



> Yours,
>
> Aleksandar
>
>
>
>> Best regards,
>>
>> Aleksandar
>>
>>
>>
>>
>>
>>> Board includes SoC, loads the firmware, and adds some external
>>> peripheral devices, if needed.
>>>
>>> SoC includes embedded peripherals. It dispatches IO memory accesses and
>>> passes them
>>> to the devices. In this case you can have different register addresses
>>> for different SoCs, but
>>> the embedded device emulation code can be mostly the same for simple
>>> devices like USART.
>>>
>>> > Only a subset of the functions of each peripheral is implemented,
>>> mainly due to the lack of a
>>> > standard way to handle electrical connections (like GPIO pins).
>>>
>>> We did not got too much results, you can check for our changes here:
>>> https://github.com/Dovgalyuk/qemu/tree/avr8
>>>
>>> But we can help you in development of better version of the patches and
>>> split the work
>>> for making this platform more usable.
>>>
>>>
>>> Pavel Dovgalyuk
>>>
>>>
>>>

--0000000000004fa7be0598f304ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, December 5, 2019, Aleksandar Markovic &lt;<a href=3D"m=
ailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br><br>On Thursday, December 5, 2019,=
 Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" tar=
get=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><br><br>On Thursday, July 25, 2019, Pavel Dovgalyuk &lt;<a=
 href=3D"mailto:dovgaluk@ispras.ru" target=3D"_blank">dovgaluk@ispras.ru</a=
>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">&gt; From: Qemu-devel [mailt=
o:<a href=3D"mailto:qemu-devel-bounces+patchwork-qemu-" target=3D"_blank">q=
emu-devel-bounces+pat<wbr>chwork-qemu-</a><br>
&gt; devel=3D<a href=3D"mailto:patchwork.kernel.org@nongnu.org" target=3D"_=
blank">patchwork.kernel.org@non<wbr>gnu.org</a>] On Behalf Of Michael Rolni=
k<br>
&gt; From: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" target=
=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; <br>
&gt; These were designed to facilitate testing but should provide enough fu=
nction to be useful in<br>
&gt; other contexts.<br>
<br>
USART is very useful for testing, but to which model of AVR is belongs?<br>
We also started implementation of USART and other devices in our internship=
 program,<br>
using prior version of your patches.<br>
There were other register addresses for the registers and some of them even=
 intersect<br>
making read/write logic more complex (we looked at Atmega8).<br>
<br>
You also mix the board and the SoC into one file, making hardware-on-chip h=
arder to reuse.<br>
<br>
I think that the structure can be revised in the following way:<br>
Board -&gt; SoC -&gt; Devices<br>
<br></blockquote><div><br></div><div>Pavel,</div><div><br></div><div>By &qu=
ot;structure&quot;, did you mean structure of patches?</div><div><br></div>=
<div>Let&#39;s say, after the all ISA instruction patches are introduced, w=
e first introduce one real board of our choice (only infrastructure, with a=
lmost empty content, than devices on that board, than the corresponding SoC=
/MCU infrastucture, than device in that SoC.</div><div><br></div><div>Addit=
ional boards would follow the same pattern, potentially reusing already imp=
lemented devices, or whole SoC/MCU.</div><div><br></div><div>One more quest=
ion:</div><div><br></div><div>We already saw that devices within SoC/MCUs f=
or AVR platform exibit great variation. First, there are around 17 generati=
on of AVR cores (avr1, avr2, ... xmega7). Than, there is, I think 600+ SoC/=
MCU models (hard to believe, but true). Each SoC defines its devices, and i=
n potentially different way (not only its starting address, but real differ=
ences in terms of functionality). I thought that at least for a particular =
core, the devices would be defined in a consistent way, but even that is no=
t true - for example ADC for a SoC having core X can be significantly diffe=
rent that ADC for another SoC having the same core X.</div><div><br></div><=
div>How to deal with such avalanche of devices? How to organize and maintai=
n 27 significantly different versions of ADC; and 53 significantly differen=
t versions of Watchdogs (the numbers are invented by me, but are likely to =
describe the situation well)?</div><div><br></div></blockquote><div><br></d=
iv><div>Peter, may I ask you the same questions?</div><div><br></div><div>I=
 have a strong impression we here need to think colectively.</div><div><br>=
</div></blockquote><div><br></div><div>Of course, I did not mean that we&#3=
9;ll ever support 600+ AVR SoCs/MCUs, or 53 AVR watchogs, but, as the work =
in Pavel&#39;s repository illustrates, we will stumble very soon on, let&#3=
9;s say different USART devices (in this case between &quot;atmega2560&quot=
; and one of &quot;xmega&quot; cores. It is realistic that we can potential=
ly end up needing support for 5-6 AVR USARTs. How to name them, as a first =
question?</div><div><br></div><div>Not to mention also possible dependencie=
s between various devices, interleaved memory ranges, shared registers...</=
div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>You=
rs,</div><div><br></div><div>Aleksandar</div><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div>Best regards,</div><div><br></div><di=
v>Aleksandar</div><div><br></div><div><br></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
Board includes SoC, loads the firmware, and adds some external peripheral d=
evices, if needed.<br>
<br>
SoC includes embedded peripherals. It dispatches IO memory accesses and pas=
ses them<br>
to the devices. In this case you can have different register addresses for =
different SoCs, but<br>
the embedded device emulation code can be mostly the same for simple device=
s like USART.<br>
<br>
&gt; Only a subset of the functions of each peripheral is implemented, main=
ly due to the lack of a<br>
&gt; standard way to handle electrical connections (like GPIO pins).<br>
<br>
We did not got too much results, you can check for our changes here: <a hre=
f=3D"https://github.com/Dovgalyuk/qemu/tree/avr8" target=3D"_blank">https:/=
/github.com/Dovgalyuk/q<wbr>emu/tree/avr8</a><br>
<br>
But we can help you in development of better version of the patches and spl=
it the work<br>
for making this platform more usable.<br>
<br>
<br>
Pavel Dovgalyuk<br>
<br>
<br>
</blockquote>
</blockquote>
</blockquote>

--0000000000004fa7be0598f304ff--

