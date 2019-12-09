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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3507CC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1745205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSlJDwDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1745205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNy2-0006Oa-PI
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ieNmd-0000E7-Qf
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ieNmc-0001uZ-N0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:29:23 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:46142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ieNmc-0001sR-Fk
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:29:22 -0500
Received: by mail-qv1-xf41.google.com with SMTP id t9so3020991qvh.13
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 10:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pE//A0etXnYRbCED7fhw67X4lp6PdI/7hgAZ9mu/8Vo=;
 b=ZSlJDwDk/XXSqYvkMuX/Jjme7QmBP66eprhs8Gwcq46xHzCLuJNu9RrTLoJVfh6R6G
 nba/LHepOm39FLF9kYsFRicJXb6LY7DyFBH4oYRSud0TyG9OveiPQ7vQm5h2CG7WBNFF
 VALPsb/Jl0EP0v7ZXXVEHNeC90SFV0vqrHf7SS58Dar7VYrVuD+5Ci9cCpf5Tfi1KQAc
 p7ouRlIR+LRLwjdWB8thBVsqtYFboaaWJHA1hX/q437KsluujAzgINpn0FIszZe1v5nY
 WBskngtPigWfav3ILHpwVbTz5iJ/Cl9PO5NtGXX+lht8WctLaJcesGr+r/dArWqfDky0
 bWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pE//A0etXnYRbCED7fhw67X4lp6PdI/7hgAZ9mu/8Vo=;
 b=oYc31yBXCaV1g82iW2PFyTiBIOr34hp4HemXNC0gPdPArTvSVuVfgS7u4zXXlEN05a
 KzQi8atZMHxNxc2k07Q7tl0ivvWcC36JxCL/ABfj0SPGIcTRoM3fdGB8/WVjA7YnkbFY
 qr8UksSg5WA0UH5+bK5cql7xQOmXrT/OqTsVX9sDWWK8GHo33HB6/5q21JeN1CZDGEvz
 MNZuHgabv3RZUm8dVfxkvQZ1pJsO2chqk//R6uED0TRivzQuSJqmny9PK0zhl3HNU6tW
 KMKVRn10rKLtm99ZiylfmTODDrGAJCGuBu2amiaxEUGbGEDUK6JwQS3HGIGVkonD7sgG
 rXOw==
X-Gm-Message-State: APjAAAX94aUFSQbijpGpm/uJMmUGwxS8r+2uSWDu0oA8S202XfYmcrXX
 3YjkgDxqd2Zq0nS6cOfGj+PWUqq4gpQY+ti+lDo=
X-Google-Smtp-Source: APXvYqxyNFjH9YW0AODDUb3ApRk2qbQZ8g0vFOyMgWOpy54U6D8Jq5qj32Un73srRKvF3R9inpzgvpFbY5y5qIuwSbg=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr24401835qvn.79.1575916161651; 
 Mon, 09 Dec 2019 10:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-19-mrolnik@gmail.com>
 <CAL1e-=jN=Z+zzsyq3OuVAZ=WwqU05oFX=F8nkGn1Xt8PHe=brg@mail.gmail.com>
In-Reply-To: <CAL1e-=jN=Z+zzsyq3OuVAZ=WwqU05oFX=F8nkGn1Xt8PHe=brg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 9 Dec 2019 20:28:37 +0200
Message-ID: <CAK4993iYJbOQD0++eTJYK7nwgFL_q6S4hFjm8DEtNPEp3tsG0A@mail.gmail.com>
Subject: Re: [PATCH v38 18/22] target/avr: Add machine none test
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000002d6410599499332"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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

--00000000000002d6410599499332
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

:)

no idea. all other machines / CPUs have it, so I added as well

On Mon, Dec 9, 2019 at 8:13 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>  tests/machine-none-test.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>>
> You need to add a commit message explaining how adding a test is achieved
> with this single line.
>
>
>
>> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
>> index 5953d31755..3e5c74e73e 100644
>> --- a/tests/machine-none-test.c
>> +++ b/tests/machine-none-test.c
>> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {
>>      /* tested targets list */
>>      { "arm", "cortex-a15" },
>>      { "aarch64", "cortex-a57" },
>> +    { "avr", "avr6-avr-cpu" },
>>      { "x86_64", "qemu64,apic-id=3D0" },
>>      { "i386", "qemu32,apic-id=3D0" },
>>      { "alpha", "ev67" },
>> --
>> 2.17.2 (Apple Git-113)
>>
>>

--=20
Best Regards,
Michael Rolnik

--00000000000002d6410599499332
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">:)<div><br></div><div>no idea. all other machines / CPUs h=
ave it, so I added as well=C2=A0</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 9, 2019 at 8:13 PM Aleksa=
ndar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar=
.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><br><br>On Sunday, December 8, 2019, Michael Rolnik &lt;<a=
 href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&=
gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-=
by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blan=
k">mrolnik@gmail.com</a>&gt;<br>
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
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000002d6410599499332--

