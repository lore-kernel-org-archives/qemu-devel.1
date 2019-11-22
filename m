Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4EC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A642085B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMdU6Atz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A642085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6kC-0000Lu-OO
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY6jV-0008GA-CQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY6jU-0002b5-5z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:04:13 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iY6jU-0002ac-0S
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:04:12 -0500
Received: by mail-ot1-x344.google.com with SMTP id z25so5818132oti.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=MqdIhm6t2G4nQ5iMjUIWj91KtKkY6FC4FMkyAoKijdw=;
 b=AMdU6AtzgipSBVpY6gEJKP3UWw5MfnT4WslEYtpXsttX4kj+13wEcejcx5ohe5drm4
 9+/alOiDu2uumPc8kIKBJWjZiauO+dTSvwGODaYeKGTXxC38ij66vxyDF5+0CHpBFBBT
 be4ZrZUEeRGa++7589QZXGc5jq99pAJ1s5pmWIkSuUGcM08iJ6Fkd0JqPqLTRzqTO5R6
 mYmwHwj0JMH4IqMmbmcbXteow2gnPLz38CkS4gxKybjCmavn7w1BmkO6e5BAXnYotxXD
 pvP9sosts1Pspjjl3wPguPtI2+vUIfuxWEibE2zW1H1gSLfb8vG+bs5+nSQJrCoTB1H9
 iD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=MqdIhm6t2G4nQ5iMjUIWj91KtKkY6FC4FMkyAoKijdw=;
 b=QydIDss9VXwp3SBqMBjHqaZs3T4sc11Dd1gOgSJg5kXFvFtbwfgSd3Uw4XarG00NaJ
 nqreN+XDKnqD5xjNrY54cO5aZoRN/8zHf0ISLgndIFjguXJsyfxCVeOcEGWZpkbTx/pG
 0+Sc7C/w2E5bhzFhhPrNzGVNstT2WT7YZ9FV9ELiJO4RCkp9nB86iOjAOi0GmlL0ieXA
 2ZK4sUN/0AbLR+Ip4sA+YJ/T7lIR7Mi4h7tCH/nlmQzR8dyUjw8ZUaeo6bJ6MjNDHN3o
 ddEiyMs5ZbhOXsNYm074LoL4ba3Ic3UOZ1efR3XIHw+qqj3Ou2KCRU1DgGu58VeRLMDq
 ZtXA==
X-Gm-Message-State: APjAAAXN5gqdyAVyPsY0r9jQ7ER5WCsKhzSsdWXX/rIKNfLz2pdTV46z
 Si1m7Bv2Ijn7pZ2Scp+eU+TQHeO+edrvEu4v/cI=
X-Google-Smtp-Source: APXvYqwttOOb3yjMqULs/UH0ibpUvP3NM2KQVq+z4ffBFTv9M1DRldnFHE6Jn7vZ6sXfQNuzTV/V3S/g8wpj49bewYA=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr10959955otc.295.1574420650949; 
 Fri, 22 Nov 2019 03:04:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Fri, 22 Nov 2019 03:04:10
 -0800 (PST)
In-Reply-To: <56528dfc-3305-da24-1df3-700f63779cac@redhat.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
 <56528dfc-3305-da24-1df3-700f63779cac@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 12:04:10 +0100
Message-ID: <CAL1e-=jDqunMSrhXfMOXkBfGzApi_b+B+H-NLArnkJaV-VW6ig@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a0847e0597ed5fde"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a0847e0597ed5fde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, November 22, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> On 11/21/19 9:55 PM, Aleksandar Markovic wrote:
>
>> Why not implement the dump_ASM code? This is very useful...
>>>
>>>
>> ... and time-consuming to implement, unless Michael have some
>> ready off-shelf code.
>>
>> It is great that you have lots of ideas, Philippe, however I think
>> that it is counterproductive to suggest Michael to work on this
>> at this moment.
>>
>
> I am just asking why. I later realized Michael and Sarah should be using
> their port via gdbstub, this having the gdb internal disassembler availab=
le.
>
>
Sure, perhaps I misread your 'why' sentence.

Keep your ideas coming! I don't mean to restrict your style and creativity,
I encourage you keeping and growing them. :)



> Disassembler is just a debugging tool,
>> non-essential to core functionality, and Michael should remain
>> focused on completing core bits and pieces of AVR emulation.
>>
>> My 2 cents,
>> Aleksandar
>>
>
>

--000000000000a0847e0597ed5fde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, November 22, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On 11/21/19 9:55 PM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Why not implement the dump_ASM code? This is very useful...<br>
<br>
</blockquote>
<br>
... and time-consuming to implement, unless Michael have some<br>
ready off-shelf code.<br>
<br>
It is great that you have lots of ideas, Philippe, however I think<br>
that it is counterproductive to suggest Michael to work on this<br>
at this moment.<br>
</blockquote>
<br>
I am just asking why. I later realized Michael and Sarah should be using th=
eir port via gdbstub, this having the gdb internal disassembler available.<=
br>
<br></blockquote><div><br></div><div>Sure, perhaps I misread your &#39;why&=
#39; sentence.</div><div><br></div><div>Keep your ideas coming! I don&#39;t=
 mean to restrict your style and creativity, I encourage you keeping and gr=
owing them. :)</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Disassembler is just a debugging tool,<br>
non-essential to core functionality, and Michael should remain<br>
focused on completing core bits and pieces of AVR emulation.<br>
<br>
My 2 cents,<br>
Aleksandar<br>
</blockquote>
<br>
</blockquote>

--000000000000a0847e0597ed5fde--

