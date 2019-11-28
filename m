Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DDC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC7421781
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0GhHif9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC7421781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIJI-0002Ve-75
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaHvd-0008PZ-5d
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaHvX-0005ld-DQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:25:41 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaHvU-0005g2-Dx
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:25:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id a67so4253240oib.6
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dRqoXWSIhcaQl37hxAQb6rOMoglmuist2IsCW2cpXMo=;
 b=T0GhHif9xwLLylvxqlmt8LIJ7H0b9PB44dVuoe5gADqpSqBKS/75n3Y/OLGvaEIio/
 /1ctzpllWauqc5MPErPmouV3M6UrMsnNbePlxgEY7bL2NNwLUMv4ijWCipuyoAUJJZaw
 A4yF1DruzS8gLh30zEz9Oy+RUll+lHIeymIsyaj2uPnnkfsAUgTzpUrLTedmsK+m2bL8
 LrZKClkXWHXx3wOwCKhEmV34Oddd17Sx6/MSYYdFEQLDcG2YwHErqDloz8fnTXuYs7YT
 h6eJflX7xo3tt3IU1x+Bn/SMRh4h16X5PzRDMrGlCuo/0YDrawxuFjtEtPPvPw+S41iz
 HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dRqoXWSIhcaQl37hxAQb6rOMoglmuist2IsCW2cpXMo=;
 b=brH7u8qO7ah5s4BxY+bP+mK5kje/nvxpLEaWZj6LS7E9cCCMFuW7SNt2X/JEABHDSJ
 HzxHQ9QDDxp7t+A2KtFu6xuWVkEzEdM6HR/G/Z/fDDl+dyhwZ2s2Yp6FmfW7Obpdv2V+
 SkNdf49XpMZERJUte89/WdiwqME2h17N4M3gsJqjZ6DA+PPNvw5POn7JAr3eTnoSwQII
 WZOzlg2nnFNZ4NARfue/5i2L2oFvogh/hQ3cdxKEmxM8RygI3Lof5EhyvBPn9rJZ0R+2
 50hk58Q75qr/x833d+PdKa/cnqJ5xrFDQmWRs0JlCPQA1sQImMg9olFIDVNyIopUrzNN
 HhYA==
X-Gm-Message-State: APjAAAU02zZyr+oPAfgvm0z6DdOWanTSskAc9Y7MTVc74CLtzP/HyHh4
 qUDOWNePr+pIxRWHsdndhr6RE9awNRn60vqigqFK7g==
X-Google-Smtp-Source: APXvYqz7whixOvZaada5XoVuhXKyt5HF8cQVIArl1lSjA5KxkUogF0ChCH3BpGEvPxcGEBAIOlXG5BPrC08cqclMGUM=
X-Received: by 2002:aca:d17:: with SMTP id 23mr8181302oin.136.1574940334173;
 Thu, 28 Nov 2019 03:25:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 03:25:33
 -0800 (PST)
In-Reply-To: <90a1f5a14be4a6e225e6bf99484c4718@ispras.ru>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
 <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
 <4ed9736f9e88d9d242a0aed10fb65aac@ispras.ru>
 <CAL1e-=ib7h8szh48ckOk8yvF+7SQd9_hyoYU3E+K=CGy0EJkGA@mail.gmail.com>
 <90a1f5a14be4a6e225e6bf99484c4718@ispras.ru>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 12:25:33 +0100
Message-ID: <CAL1e-=juWKu5Kv0wrzUGgjyfzKsFmLgLspjG_A==cUEZWq4dsg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: dovgaluk <dovgaluk@ispras.ru>
Content-Type: multipart/alternative; boundary="0000000000002932360598665fcb"
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002932360598665fcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 28, 2019, dovgaluk <dovgaluk@ispras.ru> wrote:

> Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 13:20:
>
>> On Thursday, November 28, 2019, dovgaluk <dovgaluk@ispras.ru> wrote:
>>
>> Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 12:28:
>>> On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9
>>> <f4bug@amsat.org> wrote:
>>>
>>> Add famous ATmega MCUs:
>>>
>>> - middle range: ATmega168 and ATmega328
>>> - high range: ATmega1280 and ATmega2560
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>
>>> Philippe, hi.
>>>
>>> Thank you for the impetus you give us all.
>>>
>>> However, is this the right direction?
>>>
>>> Let's analyse some bits and pieces.
>>>
>>> Starting from the commit message, the word "famous" is used, but I
>>> really don't see enumerated CPUs/MCUs are any special in Atmel
>>> lineup.
>>> Other than we often used the doc describing them (cited several
>>> times
>>> in our discussions) as our reference, but that doesn't make them
>>> "famous". Ofcourse, there other docs for other Atmel CPUs/MCUs, of
>>> at
>>> lest equivalent significance. For example, "tiny" ones are at least
>>> as
>>> famous as "mega" ones.
>>>
>>> Then, you introduce the term MCU, without proper discussion with
>>> others on terminology. In parlance of QEMU, ATmega168 at al. are
>>> CPUs
>>> (we all know and assume that that are some peripherals in it). I am
>>> not against using the term MCU, but let's first sync up on that.
>>>
>>> The added terminology trouble is that MCUs, as you defined them,
>>> have
>>> in array atmega_mcu[] a field called "cpu_type" - why is that field
>>> not called "mcu_type"? *Very* confusing for any future reader. And
>>> then, similar terminology conundrum continues with macro
>>> AVR_CPU_TYPE_NAME().
>>>
>>
>> MCU is a system-on-chip which includes CPU core and peripheral
>> devices.
>> Separating this is better that including everything into the machine.
>>
>> E.g., different MCUs may have different IO addresses for USART.
>>
>> Pavel,
>>
>> Do you know how is this resolved for other platforms?
>>
>> How other platfirms organize and use terms "soc", "mcu", "cpu",
>> "core", "cpu core"? And what is the relation between each of them and
>> QEMU command line options "-cpu" and "-machine"? Is thar organization
>> the same accross all platforms?
>>
>
> Here is an ARM example:
>  SoCs: hw/arm/aspeed_soc.c include/hw/arm/aspeed_soc.h
>  Boards: hw/arm/aspeed.c
>
> (I am asking you as you most likely have much wider experience in the
>> topic, sincr mine i limited to mips emulation)
>>
>
> As far as I know, there are MIPS SoCs too.
> Doesn't QEMU emulate any of them?


It does, but, admitedly, we could do a much better job in that area, and we
are certainly not good as a reference platform in that area. Some features
of MIPS SoCs are extremely difficult to implement in QEMU though (for
example, so called hardware miltithreading).

Thanks,
Aleksandar


>
> All of the above is far less important than this question: What
>>>> are we
>>>> achieving with proposed CPU/MCU definitions? I certainly see the
>>>> value
>>>> of fitting the complex variety of AVR CPUs/MCUs into QEMU object
>>>> model. No question about that. However, is this the right moment
>>>> to do
>>>> it? There are still some unresolved architectural problems with
>>>> peripheral definitions, as I noted in yhe comment to Michael's
>>>> last
>>>> cover letter. This patch does not solve them. It just assumes
>>>> everything is ready with peripherals, let's build CPUs/MCUs. The
>>>> machines based on proposed CPUs/MCUs are not more real that
>>>> machine
>>>> based on Michael's "sample" machine. At least Michal says "this is
>>>> not
>>>> a real machine". If we used proposed CPUs/MCUs from this patch,
>>>> the
>>>> resulting machine is as "paper" machine as yhe "sample" machine.
>>>> We
>>>> would just live in a la-la lend of thinking: "wow, we model real
>>>> hardware now".
>>>>
>>>> I would rather accept into QEMU a series admitting we are still
>>>> far
>>>> from modelling real machine or CPU/MCU, than a series that gives
>>>> an
>>>> illusion that we are modelling real machine or CPU/MCU.
>>>>
>>>> As far as utility of this patch for Michael's series, it looks to
>>>> me
>>>> they add more headake than help (not saying that the help is not
>>>> present) to Michael. He would have anotter abstraction layer to
>>>> think
>>>> of, at the moment he desperately needs (in my opinion) to focus on
>>>> providing the as solid as possible, and as complete as possinle
>>>> foundations. This patch looks like building castles in the air.
>>>> Again,
>>>> I am not claiming that the patch is not helpful at all.
>>>>
>>>> In summary, I think that this patch is premature.
>>>>
>>>
>
>
> Pavel Dovgalyuk
>
>

--0000000000002932360598665fcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, dovgaluk &lt;<a href=3D"mailto:dovg=
aluk@ispras.ru">dovgaluk@ispras.ru</a>&gt; wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 13:2=
0:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thursday, November 28, 2019, dovgaluk &lt;<a href=3D"mailto:dovgaluk@isp=
ras.ru" target=3D"_blank">dovgaluk@ispras.ru</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 12:28:<br>
On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a=
>&gt; wrote:<br>
<br>
Add famous ATmega MCUs:<br>
<br>
- middle range: ATmega168 and ATmega328<br>
- high range: ATmega1280 and ATmega2560<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
<br>
Philippe, hi.<br>
<br>
Thank you for the impetus you give us all.<br>
<br>
However, is this the right direction?<br>
<br>
Let&#39;s analyse some bits and pieces.<br>
<br>
Starting from the commit message, the word &quot;famous&quot; is used, but =
I<br>
really don&#39;t see enumerated CPUs/MCUs are any special in Atmel<br>
lineup.<br>
Other than we often used the doc describing them (cited several<br>
times<br>
in our discussions) as our reference, but that doesn&#39;t make them<br>
&quot;famous&quot;. Ofcourse, there other docs for other Atmel CPUs/MCUs, o=
f<br>
at<br>
lest equivalent significance. For example, &quot;tiny&quot; ones are at lea=
st<br>
as<br>
famous as &quot;mega&quot; ones.<br>
<br>
Then, you introduce the term MCU, without proper discussion with<br>
others on terminology. In parlance of QEMU, ATmega168 at al. are<br>
CPUs<br>
(we all know and assume that that are some peripherals in it). I am<br>
not against using the term MCU, but let&#39;s first sync up on that.<br>
<br>
The added terminology trouble is that MCUs, as you defined them,<br>
have<br>
in array atmega_mcu[] a field called &quot;cpu_type&quot; - why is that fie=
ld<br>
not called &quot;mcu_type&quot;? *Very* confusing for any future reader. An=
d<br>
then, similar terminology conundrum continues with macro<br>
AVR_CPU_TYPE_NAME().<br>
</blockquote>
<br>
MCU is a system-on-chip which includes CPU core and peripheral<br>
devices.<br>
Separating this is better that including everything into the machine.<br>
<br>
E.g., different MCUs may have different IO addresses for USART.<br>
<br>
Pavel,<br>
<br>
Do you know how is this resolved for other platforms?<br>
<br>
How other platfirms organize and use terms &quot;soc&quot;, &quot;mcu&quot;=
, &quot;cpu&quot;,<br>
&quot;core&quot;, &quot;cpu core&quot;? And what is the relation between ea=
ch of them and<br>
QEMU command line options &quot;-cpu&quot; and &quot;-machine&quot;? Is tha=
r organization<br>
the same accross all platforms?<br>
</blockquote>
<br>
Here is an ARM example:<br>
=C2=A0SoCs: hw/arm/aspeed_soc.c include/hw/arm/aspeed_soc.h<br>
=C2=A0Boards: hw/arm/aspeed.c<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
(I am asking you as you most likely have much wider experience in the<br>
topic, sincr mine i limited to mips emulation)<br>
</blockquote>
<br>
As far as I know, there are MIPS SoCs too.<br>
Doesn&#39;t QEMU emulate any of them?</blockquote><div><br></div><div>It do=
es, but, admitedly, we could do a much better job in that area, and we are =
certainly not good as a reference platform in that area. Some features of M=
IPS SoCs are extremely difficult to implement in QEMU though (for example, =
so=C2=A0called hardware miltithreading).</div><div><br></div><div>Thanks,</=
div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
All of the above is far less important than this question: What<br>
are we<br>
achieving with proposed CPU/MCU definitions? I certainly see the<br>
value<br>
of fitting the complex variety of AVR CPUs/MCUs into QEMU object<br>
model. No question about that. However, is this the right moment<br>
to do<br>
it? There are still some unresolved architectural problems with<br>
peripheral definitions, as I noted in yhe comment to Michael&#39;s<br>
last<br>
cover letter. This patch does not solve them. It just assumes<br>
everything is ready with peripherals, let&#39;s build CPUs/MCUs. The<br>
machines based on proposed CPUs/MCUs are not more real that<br>
machine<br>
based on Michael&#39;s &quot;sample&quot; machine. At least Michal says &qu=
ot;this is<br>
not<br>
a real machine&quot;. If we used proposed CPUs/MCUs from this patch,<br>
the<br>
resulting machine is as &quot;paper&quot; machine as yhe &quot;sample&quot;=
 machine.<br>
We<br>
would just live in a la-la lend of thinking: &quot;wow, we model real<br>
hardware now&quot;.<br>
<br>
I would rather accept into QEMU a series admitting we are still<br>
far<br>
from modelling real machine or CPU/MCU, than a series that gives<br>
an<br>
illusion that we are modelling real machine or CPU/MCU.<br>
<br>
As far as utility of this patch for Michael&#39;s series, it looks to<br>
me<br>
they add more headake than help (not saying that the help is not<br>
present) to Michael. He would have anotter abstraction layer to<br>
think<br>
of, at the moment he desperately needs (in my opinion) to focus on<br>
providing the as solid as possible, and as complete as possinle<br>
foundations. This patch looks like building castles in the air.<br>
Again,<br>
I am not claiming that the patch is not helpful at all.<br>
<br>
In summary, I think that this patch is premature.<br>
</blockquote></blockquote></blockquote>
<br>
<br>
<br>
Pavel Dovgalyuk<br>
<br>
</blockquote>

--0000000000002932360598665fcb--

