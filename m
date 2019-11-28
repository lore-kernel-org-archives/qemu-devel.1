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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777CCC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA5821774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA+h+NAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA5821774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaGyp-0004F7-BN
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaGuq-0002rD-1G
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaGuk-0004WR-5m
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:20:47 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaGuj-0004TG-V8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:20:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id o9so691155ote.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VmYWAjo4DeBIPJ6QGO1K599MBHF5M+80noAZqXgpU7o=;
 b=NA+h+NARHvPWWKkIttOB9DnaNUwO3XjqCW8/iVAKKtXCD+2OLSbWSM8xPVaw2yvquF
 yXwXZMREKH0vOaIQkgisP44CJBPKCSika/KwlC6GjDLfxAVEf5SCMZ4EmKMGLeduwlN4
 U/jLo/Eh2vziMx45MUPfLcn59gY0GeVmM7IBFz/Bt7EqU72UwhNFT5ZCc+Et/3ZhRkSv
 mOzPSqqrUF0fGZtmKvk460p7Jcqy7p5dp2iQ4fdK6AWW1YyPK89eu04v2mtUDGlLkDvW
 LtoxSdJSi3jJPM8+S7RtsHxTfH87o+ArJreYGELs3WM0R+34s8ZPQcNd7QyjU3srcbmE
 SSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VmYWAjo4DeBIPJ6QGO1K599MBHF5M+80noAZqXgpU7o=;
 b=onArbjMk1NOPQq0e1Sw5VnunTdgktOL/+5CMKhSY+BTzoMgttw+8bAYsh1d+BD9eRk
 uHVNRQN5pUiKZ98OIN2J90JMS+5mB/TiGlHzubmgKbD/ZJgPZw/YPnwT/cb9PIXyxpBK
 Mlt7FygZXEp/vKL7isf5NtpdPq7YsfwhuFFLTRoNtI+KRgAbLAHm7iVnlXKWNHqUF5sA
 7A/cdadDs1J6NopxMs/KZr/M6aE+tTlBH2qUW6sWGswLcNlhRZUTiAVxdf8BQ01K2rvY
 B1maNpkoRDsGDilDyxBNZ13hAxfQDUZmCdELq4ak//7WCOCc/SanmpP1gK/lMbs0umbJ
 gWlw==
X-Gm-Message-State: APjAAAWg8wQ3n6V467VtgWjcSZ68NQ57bvYxkOaOBdcezaA0cheriyeB
 +/bMsJnu1kuP8MK2JWkJb2ESvs6ku38Yr4eBwvY=
X-Google-Smtp-Source: APXvYqwqgu1c/vaz/NwHfch4bubCp4o6yq8Oxgr8b09OwIDWHlrY8sGeZUk2U74pcKZ3/X3kkDAqv/iIA6GplsJoOQQ=
X-Received: by 2002:a05:6830:81:: with SMTP id a1mr6763889oto.64.1574936445109; 
 Thu, 28 Nov 2019 02:20:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 02:20:44
 -0800 (PST)
In-Reply-To: <4ed9736f9e88d9d242a0aed10fb65aac@ispras.ru>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
 <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
 <4ed9736f9e88d9d242a0aed10fb65aac@ispras.ru>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 11:20:44 +0100
Message-ID: <CAL1e-=ib7h8szh48ckOk8yvF+7SQd9_hyoYU3E+K=CGy0EJkGA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: dovgaluk <dovgaluk@ispras.ru>
Content-Type: multipart/alternative; boundary="0000000000005ac8c10598657735"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

--0000000000005ac8c10598657735
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 28, 2019, dovgaluk <dovgaluk@ispras.ru> wrote:

> Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 12:28:
>
>> On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9
>> <f4bug@amsat.org> wrote:
>>
>> Add famous ATmega MCUs:
>>>
>>> - middle range: ATmega168 and ATmega328
>>> - high range: ATmega1280 and ATmega2560
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>
>>
>> Philippe, hi.
>>
>> Thank you for the impetus you give us all.
>>
>> However, is this the right direction?
>>
>> Let's analyse some bits and pieces.
>>
>> Starting from the commit message, the word "famous" is used, but I
>> really don't see enumerated CPUs/MCUs are any special in Atmel lineup.
>> Other than we often used the doc describing them (cited several times
>> in our discussions) as our reference, but that doesn't make them
>> "famous". Ofcourse, there other docs for other Atmel CPUs/MCUs, of at
>> lest equivalent significance. For example, "tiny" ones are at least as
>> famous as "mega" ones.
>>
>> Then, you introduce the term MCU, without proper discussion with
>> others on terminology. In parlance of QEMU, ATmega168 at al. are CPUs
>> (we all know and assume that that are some peripherals in it). I am
>> not against using the term MCU, but let's first sync up on that.
>>
>> The added terminology trouble is that MCUs, as you defined them, have
>> in array atmega_mcu[] a field called "cpu_type" - why is that field
>> not called "mcu_type"? *Very* confusing for any future reader. And
>> then, similar terminology conundrum continues with macro
>> AVR_CPU_TYPE_NAME().
>>
>
> MCU is a system-on-chip which includes CPU core and peripheral devices.
> Separating this is better that including everything into the machine.
>
> E.g., different MCUs may have different IO addresses for USART.
>
>
Pavel,

Do you know how is this resolved for other platforms?

How other platfirms organize and use terms "soc", "mcu", "cpu",  "core",
"cpu core"? And what is the relation between each of them and QEMU command
line options "-cpu" and "-machine"? Is thar organization the same accross
all platforms?

(I am asking you as you most likely have much wider experience in the
topic, sincr mine i limited to mips emulation)

Yours, Aleksandar





> All of the above is far less important than this question: What are we
>> achieving with proposed CPU/MCU definitions? I certainly see the value
>> of fitting the complex variety of AVR CPUs/MCUs into QEMU object
>> model. No question about that. However, is this the right moment to do
>> it? There are still some unresolved architectural problems with
>> peripheral definitions, as I noted in yhe comment to Michael's last
>> cover letter. This patch does not solve them. It just assumes
>> everything is ready with peripherals, let's build CPUs/MCUs. The
>> machines based on proposed CPUs/MCUs are not more real that machine
>> based on Michael's "sample" machine. At least Michal says "this is not
>> a real machine". If we used proposed CPUs/MCUs from this patch, the
>> resulting machine is as "paper" machine as yhe "sample" machine. We
>> would just live in a la-la lend of thinking: "wow, we model real
>> hardware now".
>>
>> I would rather accept into QEMU a series admitting we are still far
>> from modelling real machine or CPU/MCU, than a series that gives an
>> illusion that we are modelling real machine or CPU/MCU.
>>
>> As far as utility of this patch for Michael's series, it looks to me
>> they add more headake than help (not saying that the help is not
>> present) to Michael. He would have anotter abstraction layer to think
>> of, at the moment he desperately needs (in my opinion) to focus on
>> providing the as solid as possible, and as complete as possinle
>> foundations. This patch looks like building castles in the air. Again,
>> I am not claiming that the patch is not helpful at all.
>>
>> In summary, I think that this patch is premature.
>>
>>
>
> Pavel Dovgalyuk
>

--0000000000005ac8c10598657735
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, dovgaluk &lt;<a href=3D"mailto:dovg=
aluk@ispras.ru">dovgaluk@ispras.ru</a>&gt; wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-11-28 12:2=
8:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a=
>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Add famous ATmega MCUs:<br>
<br>
- middle range: ATmega168 and ATmega328<br>
- high range: ATmega1280 and ATmega2560<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
</blockquote>
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
really don&#39;t see enumerated CPUs/MCUs are any special in Atmel lineup.<=
br>
Other than we often used the doc describing them (cited several times<br>
in our discussions) as our reference, but that doesn&#39;t make them<br>
&quot;famous&quot;. Ofcourse, there other docs for other Atmel CPUs/MCUs, o=
f at<br>
lest equivalent significance. For example, &quot;tiny&quot; ones are at lea=
st as<br>
famous as &quot;mega&quot; ones.<br>
<br>
Then, you introduce the term MCU, without proper discussion with<br>
others on terminology. In parlance of QEMU, ATmega168 at al. are CPUs<br>
(we all know and assume that that are some peripherals in it). I am<br>
not against using the term MCU, but let&#39;s first sync up on that.<br>
<br>
The added terminology trouble is that MCUs, as you defined them, have<br>
in array atmega_mcu[] a field called &quot;cpu_type&quot; - why is that fie=
ld<br>
not called &quot;mcu_type&quot;? *Very* confusing for any future reader. An=
d<br>
then, similar terminology conundrum continues with macro<br>
AVR_CPU_TYPE_NAME().<br>
</blockquote>
<br>
MCU is a system-on-chip which includes CPU core and peripheral devices.<br>
Separating this is better that including everything into the machine.<br>
<br>
E.g., different MCUs may have different IO addresses for USART.<br>
<br></blockquote><div><br></div><div>Pavel,</div><div><br></div><div>Do you=
 know how is this resolved for other platforms?</div><div><br></div><div>Ho=
w other platfirms organize and use terms &quot;soc&quot;, &quot;mcu&quot;, =
&quot;cpu&quot;, =C2=A0&quot;core&quot;, &quot;cpu core&quot;? And what is =
the relation between each of them and QEMU command line options &quot;-cpu&=
quot; and &quot;-machine&quot;? Is thar organization the same accross all p=
latforms?</div><div><br></div><div>(I am asking you as you most likely have=
 much wider experience in the topic, sincr mine i limited to mips emulation=
)</div><div><br></div><div>Yours, Aleksandar</div><div><br></div><div><br><=
/div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
All of the above is far less important than this question: What are we<br>
achieving with proposed CPU/MCU definitions? I certainly see the value<br>
of fitting the complex variety of AVR CPUs/MCUs into QEMU object<br>
model. No question about that. However, is this the right moment to do<br>
it? There are still some unresolved architectural problems with<br>
peripheral definitions, as I noted in yhe comment to Michael&#39;s last<br>
cover letter. This patch does not solve them. It just assumes<br>
everything is ready with peripherals, let&#39;s build CPUs/MCUs. The<br>
machines based on proposed CPUs/MCUs are not more real that machine<br>
based on Michael&#39;s &quot;sample&quot; machine. At least Michal says &qu=
ot;this is not<br>
a real machine&quot;. If we used proposed CPUs/MCUs from this patch, the<br=
>
resulting machine is as &quot;paper&quot; machine as yhe &quot;sample&quot;=
 machine. We<br>
would just live in a la-la lend of thinking: &quot;wow, we model real<br>
hardware now&quot;.<br>
<br>
I would rather accept into QEMU a series admitting we are still far<br>
from modelling real machine or CPU/MCU, than a series that gives an<br>
illusion that we are modelling real machine or CPU/MCU.<br>
<br>
As far as utility of this patch for Michael&#39;s series, it looks to me<br=
>
they add more headake than help (not saying that the help is not<br>
present) to Michael. He would have anotter abstraction layer to think<br>
of, at the moment he desperately needs (in my opinion) to focus on<br>
providing the as solid as possible, and as complete as possinle<br>
foundations. This patch looks like building castles in the air. Again,<br>
I am not claiming that the patch is not helpful at all.<br>
<br>
In summary, I think that this patch is premature.<br>
<br>
</blockquote>
<br>
<br>
Pavel Dovgalyuk<br>
</blockquote>

--0000000000005ac8c10598657735--

