Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A62C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 19:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8D52082E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4JMHn0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8D52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idfQt-00035o-72
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 14:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idfQ5-0002fa-6l
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 14:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idfQ3-0001Td-LS
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 14:07:09 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:44436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idfQ3-0001Sr-Eu
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 14:07:07 -0500
Received: by mail-oi1-x22f.google.com with SMTP id d62so2841065oia.11
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2019 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=pQ28wp/0U2JmOF8k82/HngUlFKdxZm9ISV62F03A1GA=;
 b=L4JMHn0hH2cI5T45Gc+DlRKA5PuXSOsO23y8n+V9DcvS5gfIXDGKLQ3++cICUWRg9B
 fCN+tJy3FT46GAHk5MWsuvJpBWbAWyjFqtnw2dd9+tyScO0Dgc3tn2iZETxSoedyfRdY
 9Y5VJOrPxaHDl42btOfFbF7tWY7qTS1uqgJrwV8gwJ5tY1TtNYExcrhPdB1Iu5Hp9KGV
 xcEfZ8v5z6gcizHY6n5RgEqmGBZczXbxf5sVRJoiIJXjgJPjudSOp9COU5PGTqYthT/6
 f+QtKvXhmFhoFJgcdGEvGpIqPu2HyTm5aPnMAoR9y8bYHbgBEbuJa8co0W9hMh3i9NF0
 c6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=pQ28wp/0U2JmOF8k82/HngUlFKdxZm9ISV62F03A1GA=;
 b=DmvfRQ9hDeOUevFHk3k96N8JsqFX57OSFiabV9I9eIK01d4czBPPImH2KB9uY34PUK
 d5HnBEtxq86ZVHdU9ljcXq60fdlxaAcu0xMldT5LllMOdviCz3lY1Y/XYkXeqZfdc+6O
 Wl7jduSSiLIiFv+twMGCaW5PMzR1mUBRyHDuAHY/gS/6nSiQwtdVoyHxt13AQyaSrPcN
 Pm7DmV0N+/ntBAtyVwId+x8bUl5B+3FipUS2p8OCLo9/gL4thhGR98l3WxbHNdN6rr6Y
 ewtMT8oa4NMok/MhtEZ9USMCtv19iI6AtU90H/znsqyKk0ttf8CZl4o2BMqqnCoKwe4W
 kPrg==
X-Gm-Message-State: APjAAAUAKQ9zyFexlFXs/V29lPRhdcaahDuEEAcFiVfnxqg+SJtqFN/l
 /JDpYCwP1F+vJt5v8F34z6byrj7pHgKPLqU8Sjo=
X-Google-Smtp-Source: APXvYqw1fQMCUL6KfchI71osaG8mvBE/baV31nbtZnE23tueC9J5TTjP8ILKA03jKmgvFXWVmFlGcew5SjABKiMOyPU=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr11663416oif.53.1575745626568; 
 Sat, 07 Dec 2019 11:07:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 7 Dec 2019 11:07:06 -0800 (PST)
In-Reply-To: <4a94a570-301b-e2db-6090-929e63f907cd@redhat.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
 <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CABDp7VoVpZsQpDc7U4uJ1B7ZVCc8A2KO5qNaOucHQH6xUdX8tQ@mail.gmail.com>
 <4a94a570-301b-e2db-6090-929e63f907cd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 7 Dec 2019 20:07:06 +0100
Message-ID: <CAL1e-=hwnBmyetp7bR0EEBx+GEu4-BP7Y-rNy9pq=XLJEjDfrA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership for Fulong 2E
 board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000540099059921de6b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: chen huacai <zltjiangshi@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000540099059921de6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, November 14, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 11/14/19 2:08 PM, chen huacai wrote:
>
>> Hi, all,
>>
>> On Thu, Nov 14, 2019 at 8:34 PM Aleksandar Markovic
>> <amarkovic@wavecomp.com> wrote:
>>
>>>
>>> Hi, Philippe,
>>>
>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>
>>>> Hi Aleksandar,
>>>>
>>>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>>>
>>>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>>
>>>>> Change the maintainership for Fulong 2E board to improve its quality.
>>>>>
>>>>
>>>> IIRC you told me once this board is named Fuloong, and its CPU is a
>>>>
>>> =E2=80=8E> Loongson, both with 2x 'o' :) I have a patch renaming the va=
rious
>>>
>>>> occurrences.
>>>>
>>>>
>>> I still think that the oficial name is "Fuloong 2E", however, it is
>>> shortened to "Fulong 2E" quite often in communication, and, it seems,
>>> sometimes even in various docs/app notes etc.
>>>
>>> Can perhaps Huacai Chen enlighten us regarding the right spelling?
>>>
>> The right spelling is Fuloong.
>>
>> [...]>>> The original author is active on the Linux kernel, let ask him
> if he'd
>
>> be OK to keep an eye on his work.
>>>>
>>>> Huacai, would you agree to be listed as a reviewer on the Fuloong
>>>> related QEMU files? You don't have to worry about the generic QEMU cod=
e
>>>> plate (like keeping API up to date) I'll manage that, but I'd like to
>>>> have you listed to assert the hardware is properly modeled.
>>>>
>>>> You would appear as:
>>>> R: Huacai Chen <chenhc@lemote.com>
>>>>
>>>>
>>> That is a great idea!
>>>
>>> Please, Chen, get involved, you would be very welcomed, there is a plac=
e
>>> for you in QEMU community!
>>>
>> I'm sorry that I'm busy now, but I think I will do something in QEMU
>> in the next year.
>>
>
> No problem, we'll keep in touch.
>
> +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>>>>
>>>>
>>>> I don't think Herv=C3=A9 is interested by this board, he has not modif=
ied the
>>>> code.
>>>>
>>>> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>> +S: Maintained
>>>>>
>>>>
>>>> Let keep it as "Odd Fixes" :)
>>>>
>>>>
>>> OK.
>>>
>>>     Odd Fixes:   It has a maintainer but they don't have
>>>>                  time to do much other than throw the odd
>>>>                  patch in.
>>>>
>>>>    F: hw/mips/mips_fulong2e.c
>>>>>    F: hw/isa/vt82c686.c
>>>>>    F: hw/pci-host/bonito.c
>>>>>
>>>>>
>>>> So the patch would be:
>>>>
>>>> -- 8< --
>>>>    Fulong 2E
>>>> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>>> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> +R: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> +R: Huacai Chen <chenhc@lemote.com>
>>>>    S: Odd Fixes
>>>>    F: hw/mips/mips_fulong2e.c
>>>>    F: hw/isa/vt82c686.c
>>>>
>>>
>>> Plus possible s/Fulong 2E/Fuloong 2E/
>>>
>>
> I'd prefer to keep this change for later, with the patch cleaning its use
> in the codebase (not that trivial because we need to alias the machine na=
me
> to keep backward compatibility).
>
>
>>> ---
>>>>
>>>> But let's wait to see what Huacai Chen thinks of it, before posting it=
.
>>>>
>>>
> Aleksandar, can you stay as co-maintainer?
>
> The patch would be:
>
> -- 8< --
>    Fulong 2E
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>    S: Odd Fixes
>    F: hw/mips/mips_fulong2e.c
>    F: hw/isa/vt82c686.c
> ---
>
>
OK, Philippe, all you said makes sense. Will update in v3. Not sure about
my R or M. I'll see later. Hopefully Chen is going to join soon next year.

Have a great weekend!

Aleks.




> Either this way, or if you prefer to be listed with a R-tag:
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>
>

--000000000000540099059921de6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 14, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a =
href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 11/14/19 2:08 PM, chen huacai wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi, all,<br>
<br>
On Thu, Nov 14, 2019 at 8:34 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank">amarkovic@w=
avecomp.com</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Hi, Philippe,<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" =
target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
Hi Aleksandar,<br>
<br>
On 11/13/19 2:47 PM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" tar=
get=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
<br>
Change the maintainership for Fulong 2E board to improve its quality.<br>
</blockquote>
<br>
IIRC you told me once this board is named Fuloong, and its CPU is a<br>
</blockquote>
=E2=80=8E&gt; Loongson, both with 2x &#39;o&#39; :) I have a patch renaming=
 the various<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
occurrences.<br>
<br>
</blockquote>
<br>
I still think that the oficial name is &quot;Fuloong 2E&quot;, however, it =
is<br>
shortened to &quot;Fulong 2E&quot; quite often in communication, and, it se=
ems,<br>
sometimes even in various docs/app notes etc.<br>
<br>
Can perhaps Huacai Chen enlighten us regarding the right spelling?<br>
</blockquote>
The right spelling is Fuloong.<br>
<br>
</blockquote>
[...]&gt;&gt;&gt; The original author is active on the Linux kernel, let as=
k him if he&#39;d<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
be OK to keep an eye on his work.<br>
<br>
Huacai, would you agree to be listed as a reviewer on the Fuloong<br>
related QEMU files? You don&#39;t have to worry about the generic QEMU code=
<br>
plate (like keeping API up to date) I&#39;ll manage that, but I&#39;d like =
to<br>
have you listed to assert the hardware is properly modeled.<br>
<br>
You would appear as:<br>
R: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com" target=3D"_blank">c=
henhc@lemote.com</a>&gt;<br>
<br>
</blockquote>
<br>
That is a great idea!<br>
<br>
Please, Chen, get involved, you would be very welcomed, there is a place<br=
>
for you in QEMU community!<br>
</blockquote>
I&#39;m sorry that I&#39;m busy now, but I think I will do something in QEM=
U<br>
in the next year.<br>
</blockquote>
<br>
No problem, we&#39;ll keep in touch.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
+R: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.org" targe=
t=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
</blockquote>
<br>
I don&#39;t think Herv=C3=A9 is interested by this board, he has not modifi=
ed the<br>
code.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
+R: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" targe=
t=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
+S: Maintained<br>
</blockquote>
<br>
Let keep it as &quot;Odd Fixes&quot; :)<br>
<br>
</blockquote>
<br>
OK.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 Odd Fixes:=C2=A0 =C2=A0It has a maintainer but they don&#39;t=
 have<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0time to do mu=
ch other than throw the odd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patch in.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0F: hw/mips/mips_fulong2e.c<br>
=C2=A0 =C2=A0F: hw/isa/vt82c686.c<br>
=C2=A0 =C2=A0F: hw/pci-host/bonito.c<br>
<br>
</blockquote>
<br>
So the patch would be:<br>
<br>
-- 8&lt; --<br>
=C2=A0 =C2=A0Fulong 2E<br>
-M: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" targe=
t=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
-R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com" ta=
rget=3D"_blank">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
+M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" targ=
et=3D"_blank">f4bug@amsat.org</a>&gt;<br>
+R: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" targe=
t=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
+R: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com" target=3D"_blank">=
chenhc@lemote.com</a>&gt;<br>
=C2=A0 =C2=A0S: Odd Fixes<br>
=C2=A0 =C2=A0F: hw/mips/mips_fulong2e.c<br>
=C2=A0 =C2=A0F: hw/isa/vt82c686.c<br>
</blockquote>
<br>
Plus possible s/Fulong 2E/Fuloong 2E/<br>
</blockquote></blockquote>
<br>
I&#39;d prefer to keep this change for later, with the patch cleaning its u=
se in the codebase (not that trivial because we need to alias the machine n=
ame to keep backward compatibility).<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
<br>
But let&#39;s wait to see what Huacai Chen thinks of it, before posting it.=
<br>
</blockquote></blockquote></blockquote>
<br>
Aleksandar, can you stay as co-maintainer?<br>
<br>
The patch would be:<br>
<br>
-- 8&lt; --<br>
=C2=A0 =C2=A0Fulong 2E<br>
+M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" targ=
et=3D"_blank">f4bug@amsat.org</a>&gt;<br>
=C2=A0M: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" =
target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
-R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com" ta=
rget=3D"_blank">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
=C2=A0 =C2=A0S: Odd Fixes<br>
=C2=A0 =C2=A0F: hw/mips/mips_fulong2e.c<br>
=C2=A0 =C2=A0F: hw/isa/vt82c686.c<br>
---<br>
<br></blockquote><div><br></div><div>OK, Philippe, all you said makes sense=
. Will update in v3. Not sure about my R or M. I&#39;ll see later. Hopefull=
y Chen is going to join soon next year.</div><div><br></div><div>Have a gre=
at weekend!</div><div><br></div><div>Aleks.</div><div><br></div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Either this way, or if you prefer to be listed with a R-tag:<br>
Acked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org=
" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
<br>
<br>
</blockquote>

--000000000000540099059921de6b--

