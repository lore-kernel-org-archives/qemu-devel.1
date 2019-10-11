Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F70CECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A17820673
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbzxfxWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A17820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxGV-0001st-ED
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iIxFm-0001N5-Lh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iIxFl-0006xp-AF
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:54:54 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iIxFl-0006xR-4r
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:54:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id o44so8350286ota.10
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=DWz0+nozvnZMjtdngygEUcxoFesR1E4Zp1WMKU0KeGA=;
 b=MbzxfxWIgVYU8zfR73JZwSXW1KKXhAXlOJmtYjLlF+JDkUTM+6nfr3cdPfojiTW/rq
 2H/VB6rjO4dU8rCnZYOV14OcqbK+QKPfJQJPfjpXrksp9RieIe9vPLUTx+u5DqHOEcTz
 E9+O2wDC5GWYG5PNwrACNVNpIKt1GmdRBmfk0pG1QojtFfpokXhvZL1dayxxioSVWT4v
 bMcbH1ZmkjsGcJ9qsifFVpSSgeF8d9ywrmpv1s/5mElylGzoBwtRc/ms0cRGqZ9RDD8Z
 TgHwV2260aQThNAtBBLMtbj3r9Nht7iKDXPOyCUZuyFAotmjS8RGil70Ng/YDQkBg+8o
 l7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=DWz0+nozvnZMjtdngygEUcxoFesR1E4Zp1WMKU0KeGA=;
 b=lhEIqz+GSkc+WWu2Hj8wnkUJzMeZnZnLwxtL7epNk3E9a+R4FlqpDjd8EzIpikgDUQ
 COkTHD/TlEZjgoQHVsbRCV5oMRMxH4a21p7bfA8unEBQ61U8NaEmN+NwYPnje5cB3+gs
 KKrWKcZI83ZGQGMakh0+7YNnsEjk8SR/yEezA7K6B3yT4DiowDrf5tVI39ovb0Z4H3mp
 2jIgAVH3v4JwOlIHqtoZ6oExLEaFjmthw40k5DXRVrMbC1WpXqofo7nOQ9JGB+gcsoI8
 9FZIJEXXIDb5X1BcG88m9JGS6aSQGmlQAtBk+bp9MThY0s5P1/A9aJLYj9fn3eiw8dBT
 Idcg==
X-Gm-Message-State: APjAAAXnoLHdah/F9SGd+SbGuxfnN8ajN7SFprf39owTpaeAfyLNAv+B
 qwWdgg1wkRSdBCzLnpU3gJ3DAsT7ypGmYvyaOgc=
X-Google-Smtp-Source: APXvYqw9jyHGURGqBJ0Rr6559NImSKrHt4aY9fXhufrqJ954OSjVwRIh9pVM5kBAMkeUHj+9mJvj5/xvZYsl8DdVmvk=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr13054254oth.306.1570809292310; 
 Fri, 11 Oct 2019 08:54:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 11 Oct 2019 08:54:51
 -0700 (PDT)
In-Reply-To: <949009b8-58ec-4a9e-cfd7-7d4611fad380@redhat.com>
References: <20190902140134.74081-1-mrolnik@gmail.com>
 <949009b8-58ec-4a9e-cfd7-7d4611fad380@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 11 Oct 2019 17:54:51 +0200
Message-ID: <CAL1e-=h1PV6djRgWXikjnU79Ca7Pjfw9=0u9__Nz00FJ4R49Hg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v30 0/8] QEMU AVR 8 bit cores
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e0ccac0594a489a1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e0ccac0594a489a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, October 11, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Hi Michael,
>
> On 9/2/19 4:01 PM, Michael Rolnik wrote:
>
>> This series of patches adds 8bit AVR cores to QEMU.
>> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully
>> tested yet.
>> However I was able to execute simple code with functions. e.g fibonacci
>> calculation.
>> This series of patches include a non real, sample board.
>> No fuses support yet. PC is set to 0 at reset.
>>
>> the patches include the following
>> 1. just a basic 8bit AVR CPU, without instruction decoding or translatio=
n
>> 2. CPU features which allow define the following 8bit AVR cores
>>       avr1
>>       avr2 avr25
>>       avr3 avr31 avr35
>>       avr4
>>       avr5 avr51
>>       avr6
>>       xmega2 xmega4 xmega5 xmega6 xmega7
>> 3. a definition of sample machine with SRAM, FLASH and CPU which allows
>> to execute simple code
>> 4. encoding for all AVR instructions
>> 5. interrupt handling
>> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>> 7. a decoder which given an opcode decides what istruction it is
>> 8. translation of AVR instruction into TCG
>> 9. all features together
>>
>> [..]
>
>> Michael Rolnik (7):
>>    target/avr: Add outward facing interfaces and core CPU logic
>>    target/avr: Add instruction helpers
>>    target/avr: Add instruction decoding
>>    target/avr: Add instruction translation
>>    target/avr: Add example board configuration
>>    target/avr: Register AVR support with the rest of QEMU, the build
>>      system, and the MAINTAINERS file
>>    target/avr: Add tests
>>
>> Sarah Harris (1):
>>    target/avr: Add limited support for USART and 16 bit timer peripheral=
s
>>
>
> Overall architecture patches look good, but I'd like some more time to
> review the hardware patches. Unfortunately I won't have time until Novemb=
er.
> There was a chat on IRC about your series,


>
>
I don't see the reason why do you initiate IRC communication on this topic,
if we have the mailing list for discussing such important issues as
introducing a new target (that should be definitely visible to all
participants).

Thanks, Aleksandar



>
>
>

> I suggested Richard we could merge patches 1-4 and 7. They are almost
> sufficient to run the qemu-avr-tests gdbstub tests (but not the FreeRTOS
> ones).
>
> Regards,
>
> Phil.
>
>

--000000000000e0ccac0594a489a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 11, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Hi Michael,<br>
<br>
On 9/2/19 4:01 PM, Michael Rolnik wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This series of patches adds 8bit AVR cores to QEMU.<br>
All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully test=
ed yet.<br>
However I was able to execute simple code with functions. e.g fibonacci cal=
culation.<br>
This series of patches include a non real, sample board.<br>
No fuses support yet. PC is set to 0 at reset.<br>
<br>
the patches include the following<br>
1. just a basic 8bit AVR CPU, without instruction decoding or translation<b=
r>
2. CPU features which allow define the following 8bit AVR cores<br>
=C2=A0 =C2=A0 =C2=A0 avr1<br>
=C2=A0 =C2=A0 =C2=A0 avr2 avr25<br>
=C2=A0 =C2=A0 =C2=A0 avr3 avr31 avr35<br>
=C2=A0 =C2=A0 =C2=A0 avr4<br>
=C2=A0 =C2=A0 =C2=A0 avr5 avr51<br>
=C2=A0 =C2=A0 =C2=A0 avr6<br>
=C2=A0 =C2=A0 =C2=A0 xmega2 xmega4 xmega5 xmega6 xmega7<br>
3. a definition of sample machine with SRAM, FLASH and CPU which allows to =
execute simple code<br>
4. encoding for all AVR instructions<br>
5. interrupt handling<br>
6. helpers for IN, OUT, SLEEP, WBR &amp; unsupported instructions<br>
7. a decoder which given an opcode decides what istruction it is<br>
8. translation of AVR instruction into TCG<br>
9. all features together<br>
<br>
</blockquote>
[..]<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Michael Rolnik (7):<br>
=C2=A0 =C2=A0target/avr: Add outward facing interfaces and core CPU logic<b=
r>
=C2=A0 =C2=A0target/avr: Add instruction helpers<br>
=C2=A0 =C2=A0target/avr: Add instruction decoding<br>
=C2=A0 =C2=A0target/avr: Add instruction translation<br>
=C2=A0 =C2=A0target/avr: Add example board configuration<br>
=C2=A0 =C2=A0target/avr: Register AVR support with the rest of QEMU, the bu=
ild<br>
=C2=A0 =C2=A0 =C2=A0system, and the MAINTAINERS file<br>
=C2=A0 =C2=A0target/avr: Add tests<br>
<br>
Sarah Harris (1):<br>
=C2=A0 =C2=A0target/avr: Add limited support for USART and 16 bit timer per=
ipherals<br>
</blockquote>
<br>
Overall architecture patches look good, but I&#39;d like some more time to =
review the hardware patches. Unfortunately I won&#39;t have time until Nove=
mber.<br>
There was a chat on IRC about your series,=C2=A0</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></bl=
ockquote><div><br></div><div>I don&#39;t see the reason why do you initiate=
 IRC communication on this topic, if we have the mailing list for discussin=
g such important issues as introducing a new target (that should be definit=
ely visible to all participants).</div><div><br></div><div>Thanks, Aleksand=
ar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">=C2=A0<br></blockquote><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I su=
ggested Richard we could merge patches 1-4 and 7. They are almost sufficien=
t to run the qemu-avr-tests gdbstub tests (but not the FreeRTOS ones).<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote>

--000000000000e0ccac0594a489a1--

