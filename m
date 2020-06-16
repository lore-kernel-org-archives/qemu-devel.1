Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C9EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A7A207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkO+6O/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A7A207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDGp-0001n6-Fp
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlCm5-0001tt-5r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:41:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlCm3-0002Em-5Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:41:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id t18so21060776wru.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=zuwVhVMeKT0h6q8nDG34XQIrLSAFWowEVxHgsU97kn4=;
 b=MkO+6O/qmXEwEi+zpbOtDXGpujwETxMjwMmpW2bSi99D5mgkv7e+zDqpgxbcRAdWaK
 EqbENr1VdZRgiyEJyoo7yhPWn55PUc8qPv32LVh41QmzdrYQm+SAN3X6D8JSSoWTWBaq
 gXhIg15MZ6tUBuIz5NFWLvZWHPbP8oYGVl11sBINiuT6LTF9Yv8ATF8s9osFwmdgy6dj
 owyeuOaigVNTZbfYonVk6OQPBf05wPT+UFG3eS0bL3CPhuj0pAKojEHW4AVpRfvZNZMw
 RBitO2QzBoJeDhLoLATy+EYt7W34ZIKCM/Cs7awhx37JzbSxYHj+jovqxOV6N/MdVllZ
 4/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=zuwVhVMeKT0h6q8nDG34XQIrLSAFWowEVxHgsU97kn4=;
 b=r3mou0Ckk4ZFJg2+CHFZ4zHQnqmh7nIQxCr7MVFJm5ZQKs8iLMYSjmbnW3LG7sQb5R
 6ML20ouN/jtIVTlWaZ1tQ/nBYxGjrYJGu2S0GUeOfDq/BubdgixFOWnNaJRrulITo4z8
 brRrE1SqIIGjCQPe7VP3bhNcGN/hLsrXwouoc/51avYlmrsL4zPLUUYBqo8ncEqCsNIo
 agWou0tlJSskBfBEe2pEnG0DmDyIxLO8HpkBF0sL+tMkfa3YZT3sL9DGV1NOX8eGTIk1
 7twP2wYbs5yqMeISbuX1SwyMp2xkiZl3+Po1QRrcF+4GOdyGf8JqYinzGAh2YVjse9nm
 vc4Q==
X-Gm-Message-State: AOAM530bn+/tXTXq8yor+VZD+FhuGHnIDmIT91hCVVyjCQwi0J9xNjaZ
 k0Irh6/SEVGNMm0vHgerhlkVpEabH64p1KHQHPk=
X-Google-Smtp-Source: ABdhPJzHFQuHb0NeGZ+AEkDNiGDF73ODgVTJpSYs57D+kY4upe5BBpl0WxoPQ1nbv7InJ9toc7ezOJAZqZDFFLuczks=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr3357974wrv.162.1592318473571; 
 Tue, 16 Jun 2020 07:41:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 07:41:13 -0700 (PDT)
In-Reply-To: <46907c6f-6c0f-5918-0885-a60b0114e1d1@flygoat.com>
References: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
 <CAHiYmc6QEU4zk=0Xa6_gs1JEV+1mGNp3oNYQ6rZoxeLF5cABBw@mail.gmail.com>
 <46907c6f-6c0f-5918-0885-a60b0114e1d1@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 16 Jun 2020 16:41:13 +0200
Message-ID: <CAHiYmc6CYez1Ur2atyFa66HvbHSpiDLGa-emJ8CUK=hV0kpqXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/mips: Add two groups of loongson-ext
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="000000000000fc90da05a8348840"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "chenhc@lemote.com" <chenhc@lemote.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc90da05a8348840
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Jiaxun =
Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

>
>
> =E5=9C=A8 2020/6/16 18:38, Aleksandar Markovic =E5=86=99=E9=81=93:
>
>>
>>
>> =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Jiax=
un Yang <jiaxun.yang@flygoat.com <mailto:
>> jiaxun.yang@flygoat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
>>
>>     This is the sucessor of:
>>     "Basic TCG Loongson-3A1000 Support"
>>
>>     Thanks!
>>
>>
>> Hi, Jiaxun.
>>
>> Thanks for providing updated version of the series.
>>
>> I wonder, given so many "#if defined(TARGET_MIPS64)" lines in this
>> series, what would be the 32-bit processors that support Loongson EXT AS=
E?
>>
>
> Loongson GS232 core which can be found in Loongson-1A/B/C should support
> it.
> Although I have no intension to work on QEMU support of these processors.
>
>
...And, for the sake of accuracy, you nevertheless included the correct
implementation (for both 32-bir and 64-bit). That is very good. I would do
the same, if I were you.

However, there is a problem. We can't upstream (at least not in QEMU for
MIPS) anything without the proper documentation.

So, please provide the links or attach the supporting files to the cover
letter in v2. You already did something similar in some of your previous
series and patches. I am perfectly fine with machine translation from
Chinese.

For example, you need to provide, among other things, docs describing EXT
support in GS 232 cores. We can't just make assumptions, or trust your
word. These sources of information should be repeated for all versions (v2,
v3,...) of the series, in their cover letters.

I salute your series, but it needs much more justification.

Yours,
Aleksandar



>
>> Thanks,
>> Aleksandar
>>
>>     Jiaxun Yang (2):
>>        target/mips: Add loongson-ext lsdc2 group of instructions
>>        target/mips: Add loongson-ext lswc2 group of instrustions
>>
>>
>> Also, a spelling mistake in the second title.
>>
>
> Ahh, My bad....
>
>
>>       target/mips/translate.c | 437 ++++++++++++++++++++++++++++++
>> ++++++++++
>>       1 file changed, 437 insertions(+)
>>
>>     --     2.27.0.rc2
>>
>>
> --
> - Jiaxun
>

--000000000000fc90da05a8348840
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020.,=
 Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.yang@fly=
goat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
=E5=9C=A8 2020/6/16 18:38, Aleksandar Markovic =E5=86=99=E9=81=93:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Jiaxun =
Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com" target=3D"_blank">jiaxu=
n.yang@flygoat.com</a> &lt;mailto:<a href=3D"mailto:jiaxun.yang@flygoat.com=
" target=3D"_blank">jiaxun.yang@flygoat.co<wbr>m</a>&gt;&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
<br>
=C2=A0 =C2=A0 This is the sucessor of:<br>
=C2=A0 =C2=A0 &quot;Basic TCG Loongson-3A1000 Support&quot;<br>
<br>
=C2=A0 =C2=A0 Thanks!<br>
<br>
<br>
Hi, Jiaxun.<br>
<br>
Thanks for providing updated version of the series.<br>
<br>
I wonder, given so many &quot;#if defined(TARGET_MIPS64)&quot; lines in thi=
s series, what would be the 32-bit processors that support Loongson EXT ASE=
?<br>
</blockquote>
<br>
Loongson GS232 core which can be found in Loongson-1A/B/C should support it=
.<br>
Although I have no intension to work on QEMU support of these processors.<b=
r>
<br></blockquote><div><br></div><div>...And, for the sake of accuracy, you =
nevertheless included the correct implementation (for both 32-bir and 64-bi=
t). That is very good. I would do the same, if I were you.</div><div><br></=
div><div>However, there is a problem. We can&#39;t upstream (at least not i=
n QEMU for MIPS) anything without the proper documentation.</div><div><br><=
/div><div>So, please provide the links or attach the supporting files to th=
e cover letter in v2. You already did something similar in some of your pre=
vious series and patches. I am perfectly fine with machine translation from=
 Chinese.</div><div><br></div><div>For example, you need to provide, among =
other things, docs describing EXT support in GS 232 cores. We can&#39;t jus=
t make assumptions, or trust your word. These sources of information should=
 be repeated for all versions (v2, v3,...) of the series, in their cover le=
tters.</div><div><br></div><div>I salute your series, but it needs much mor=
e justification.</div><div><br></div><div>Yours,</div><div>Aleksandar</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Aleksandar<br>
<br>
=C2=A0 =C2=A0 Jiaxun Yang (2):<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 target/mips: Add loongson-ext lsdc2 group of ins=
tructions<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 target/mips: Add loongson-ext lswc2 group of ins=
trustions<br>
<br>
<br>
Also, a spelling mistake in the second title.<br>
</blockquote>
<br>
Ahh, My bad....<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0target/mips/translate.c | 437 +++++++++++++++++++=
+++++++++++<wbr>++++++++++<br>
=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 437 insertions(+)<br>
<br>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A02.27.0.rc2<br>
<br>
</blockquote>
<br>
-- <br>
- Jiaxun<br>
</blockquote>

--000000000000fc90da05a8348840--

