Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A003BC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CE8206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/qCwTc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CE8206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieOBR-0006an-Ei
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieO3K-0004u3-GN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieO3J-0008P9-8e
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:46:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieO3J-0008Ou-35
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:46:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id r27so13102632otc.8
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=EAfE4nYB7o7mTO0V8G+V4JfHreluZlAmEDVsWZBU1fs=;
 b=q/qCwTc1bmLZ2BLXiI7qdh+Cs6YKXNU+xzcu0bVLssiYbgb5E/sdX7IGIT9r4lLtOH
 wXvSypLY+6p5grUMrGdJpnnBbUaX310sH1kBBvBymLqmGyAtwN/MgFlisfFSHhwgSeEr
 FgaoExJ+aS31YN8YzPCDVh+Gj63I9PVAgwdFYXu6AOMkyxMqzq3Lr94uenLlBwzJho5F
 aZQto+b4kYFuSZGTH4v3FxNCKs9b4hOMvcA6m6mHBGzNxnff79/wHDuaJWWIAmVqt+Ra
 DAiPB5D2mMwU+Urj2GWJriS6gkTYlpIT8LjpYoVuQb7mdoVXE2lDwYuET1LA9H4yVxWt
 nIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=EAfE4nYB7o7mTO0V8G+V4JfHreluZlAmEDVsWZBU1fs=;
 b=NAOGND9tB9Fv0ls7vy5KzxbY6ehFD8QNRqGKaTdM2DzEF1NRr9sRHvlNMIiPyGCeM0
 HDeCHDTi6sFStOvPippQFDgF6skMWwi8l1DX+NCmckj8FYutgJ5jxAK2abdGgYSdMu/e
 +tVEZcg1EIaO7RP1VYxTY9TjMbRTP1wqrO3jJ7YF/2HsyG9jcnWmOktkbvLV5mg97nTd
 UXjtgOwZze5pZ+07kIeOPnenOFGSPECx/fpF4PdWFct0S8j64IVmJsutddrr86WUWk+o
 EU0Iqe6Szs+TdaaI2JkpYNZtR7Ax5C0fKyB44TgKZAxdCk5VsORYoXjf8cENrUiEroQI
 gLZA==
X-Gm-Message-State: APjAAAVhmSBCfoAxXwc6ufiRsuM8vumPZ43X5p+zulXYJytmEqJOY+yA
 HetRLqQ5/tqn0qmlXPhhVElWdJLlwa2MX0fTTaGegg==
X-Google-Smtp-Source: APXvYqw6S1WDnACabWPu+KFbaCh7i72NwNjjmcFZcWvyApxedRWneHh8sE9uZT5fXH50STa8teZKUNvfLn+g5z8Rg7k=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr22631077otp.306.1575917196457; 
 Mon, 09 Dec 2019 10:46:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 10:46:36 -0800 (PST)
In-Reply-To: <CAK4993iYJbOQD0++eTJYK7nwgFL_q6S4hFjm8DEtNPEp3tsG0A@mail.gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-19-mrolnik@gmail.com>
 <CAL1e-=jN=Z+zzsyq3OuVAZ=WwqU05oFX=F8nkGn1Xt8PHe=brg@mail.gmail.com>
 <CAK4993iYJbOQD0++eTJYK7nwgFL_q6S4hFjm8DEtNPEp3tsG0A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 19:46:36 +0100
Message-ID: <CAL1e-=h6Pp9H1JZBagWqzF7vC5WPGci_PvR=FPtFc2os2fz=DQ@mail.gmail.com>
Subject: Re: [PATCH v38 18/22] target/avr: Add machine none test
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b0bc0e059949d09f"
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b0bc0e059949d09f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, December 9, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> :)
>
> no idea. all other machines / CPUs have it, so I added as well
>
>>
>>
lol


> On Mon, Dec 9, 2019 at 8:13 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>  tests/machine-none-test.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>>
>> You need to add a commit message explaining how adding a test is achieve=
d
>> with this single line.
>>
>>
>>
>>> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
>>> index 5953d31755..3e5c74e73e 100644
>>> --- a/tests/machine-none-test.c
>>> +++ b/tests/machine-none-test.c
>>> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {
>>>      /* tested targets list */
>>>      { "arm", "cortex-a15" },
>>>      { "aarch64", "cortex-a57" },
>>> +    { "avr", "avr6-avr-cpu" },
>>>      { "x86_64", "qemu64,apic-id=3D0" },
>>>      { "i386", "qemu32,apic-id=3D0" },
>>>      { "alpha", "ev67" },
>>> --
>>> 2.17.2 (Apple Git-113)
>>>
>>>
>
> --
> Best Regards,
> Michael Rolnik
>

--000000000000b0bc0e059949d09f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 9, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr">:)<div><br></div><div>no idea. all other machine=
s / CPUs have it, so I added as well=C2=A0</div></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><br></blockquote></blockquote><div><br></div><div>lol</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 9, 2019 at 8:13 PM Aleksandar =
Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blan=
k">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><br><br>On Sunday, December 8, 2019, Michael =
Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@g=
mail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0tests/machine-none-test.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br></blockquote><div><br></div><div>You need to add a commit message expla=
ining how adding a test is achieved with this single line.</div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c<br>
index 5953d31755..3e5c74e73e 100644<br>
--- a/tests/machine-none-test.c<br>
+++ b/tests/machine-none-test.c<br>
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0/* tested targets list */<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;arm&quot;, &quot;cortex-a15&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;aarch64&quot;, &quot;cortex-a57&quot; },<br>
+=C2=A0 =C2=A0 { &quot;avr&quot;, &quot;avr6-avr-cpu&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;x86_64&quot;, &quot;qemu64,apic-id=3D0&quot; },=
<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;i386&quot;, &quot;qemu32,apic-id=3D0&quot; },<b=
r>
=C2=A0 =C2=A0 =C2=A0{ &quot;alpha&quot;, &quot;ev67&quot; },<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--000000000000b0bc0e059949d09f--

