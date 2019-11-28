Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B51C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8ED2158A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCc3mGj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8ED2158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMCe-0005dY-M0
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaL7b-0004wL-OB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iaL7X-0003hN-82
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:50:17 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iaL7W-0003VM-Sa
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:50:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id s71so23465882oih.11
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=1lkH4xky3Q5ZBaB5y2a3Jy8bzDQjw8UjawwDq59sEWg=;
 b=qCc3mGj5u5NUIgzfYDYIkKaCEdHQrK/+dws884kCHykHtW1Lk+VxJj3n9h5ADMZIQw
 d21VKLgypMGOH0hV2YHBXAVnp6QUY5afXkBeY7cAutKTRypAgbSZ1JrDo1o4ipOt3y0m
 pApo6Sl5eGEjrErvCnv40WnUwJAGWfUPZ7QYYSpecOakPREmruw8ahcHX8sDUa95/flq
 E5uJfpqOMcvwp7/89OxxXnc4BJ1305pnniNRgpkRkY0pzE15qDONojtMZm1+k9WIJuD/
 j2awmgZnp72v583z1nINOCY5q/bJinFoVwT/sZxfg0G7gx3IzBKPOiJP7Cyg3JtGrYTf
 n0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=1lkH4xky3Q5ZBaB5y2a3Jy8bzDQjw8UjawwDq59sEWg=;
 b=FOIjw7axvbY1aMygxjDhHT9z4XrKpiBr0Irr+mp2QVHEBzj2tRNc6kgdblx/udGCOl
 eSTPSp5ig9vmtGbVlrEanDHNX+44xrIekQ8SPUjYO3yw7dCxMUZwAFzp05x43I+zvVla
 8Abf4PZtFutp7u6HjM5uT2IFZl2b2VFET7lPj0cYmGGPSj0l9uIJC2bqKqAk18ZyFg1/
 zBWjW1lOcYXRP+h/k9vZUPWCFmkR7bzhzSQkOjmmvDQ3L5C47i6Rm3DKFN0M+UTYn2Ln
 VlhxckMZ9HwCupn/HPW4HjxuTwJPMavtbzMlSDxiDcyy1tJFs5Bm4P6jJq3SuKhoYRR4
 wyqw==
X-Gm-Message-State: APjAAAXoItLxDnIxeJtA1dMI0QFQHo+SfCFFnYTS9HHw0cx2Z/i6gyk8
 ABg5MU7lJJi7U6XkxrPLieJ4XDeNc4qSqubEC48=
X-Google-Smtp-Source: APXvYqzPKWaCt62AHDiaHtIvQ72uSvng+9o+4tkfM1bkMpQBjm/v3HwQb9eZufoP813Uc6vQLwK7jWa+Be9nI3dgvMc=
X-Received: by 2002:aca:d985:: with SMTP id q127mr9048516oig.62.1574952612518; 
 Thu, 28 Nov 2019 06:50:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Thu, 28 Nov 2019 06:50:11
 -0800 (PST)
In-Reply-To: <2540f517-5662-2afb-fb2f-4720fddd7eb5@redhat.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
 <5a784557-f322-dc3a-4ff1-a7d9a0409448@redhat.com>
 <CAL1e-=jJ5uNvYq7yNQYFhMJ0k94-d6mrybs-NyVjVi9Agb4Aeg@mail.gmail.com>
 <CAK4993i8zPyYH2hGxx0hP4qQKr9oTJV2T5JDtQmKHZe2EpAsvw@mail.gmail.com>
 <2540f517-5662-2afb-fb2f-4720fddd7eb5@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 28 Nov 2019 15:50:11 +0100
Message-ID: <CAL1e-=jiNWB4LhWBrhhvihPt+oGOq21qva=yoQqqWzPLhK3Eaw@mail.gmail.com>
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001dfc80598693b18"
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000001dfc80598693b18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 11/28/19 2:46 PM, Michael Rolnik wrote:
>
>> I will rename them.
>>
>
>>
Renaming alone won't solve anything.


> Please wait comments from Richard before a version respin.
>
> On Thu, Nov 28, 2019 at 3:41 PM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>>
> [...]
>
>>
>>
>>         If I understand Aleksandar correctly, the naming is incorrect
>>         because too generic to AVR family, why Sarah only modeled the
>>         Atmel implementation.
>>
>>         Renaming devices such hw/char/avr_usart.c ->
>>         hw/char/atmel_usart.c (similarly with the macros) would be
>>         enough Aleksandar?
>>
>>
>>
>>     Some renaming could help, perhaps not quite like the one above, but
>>     my point (which I find hard to believe I can't explain to you) is
>>     that peripherals inside the chip evolved over time, as starkly
>>     opposed to external peripherals that are set in stone...
>>
>
>

--00000000000001dfc80598693b18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 11/28/19 2:46 PM, Michael Rolnik wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I will rename them.<br>
</blockquote>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br></blockquote></blockquote><div><br></div=
><div>Renaming alone won&#39;t solve anything.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
Please wait comments from Richard before a version respin.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Thu, Nov 28, 2019 at 3:41 PM Aleksandar Markovic &lt;<a href=3D"mailto:a=
leksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</=
a> &lt;mailto:<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_bla=
nk">aleksandar.m.mail@<wbr>gmail.com</a>&gt;&gt; wrote:<br>
</blockquote>
[...]<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 If I understand Aleksandar correctly, the namin=
g is incorrect<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 because too generic to AVR family, why Sarah on=
ly modeled the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Atmel implementation.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Renaming devices such hw/char/avr_usart.c -&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/char/atmel_usart.c (similarly with the macro=
s) would be<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enough Aleksandar?<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 Some renaming could help, perhaps not quite like the one abov=
e, but<br>
=C2=A0 =C2=A0 my point (which I find hard to believe I can&#39;t explain to=
 you) is<br>
=C2=A0 =C2=A0 that peripherals inside the chip evolved over time, as starkl=
y<br>
=C2=A0 =C2=A0 opposed to external peripherals that are set in stone...<br>
</blockquote>
<br>
</blockquote>

--00000000000001dfc80598693b18--

