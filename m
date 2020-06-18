Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5016C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718422070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZSN4MDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718422070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltEV-0002xr-Lc
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jltDh-0002SF-1Z
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:00:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jltDe-00072e-Me
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:00:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so5786773wro.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=lVVwnh4OFzrdsTw1x0nwg/8VVBmrtpjbC0uUui9UVZQ=;
 b=fZSN4MDtwAYH1Crq6fOeLdTsq96RCX+xoEdHBIHm+gIeM5wkRixVUwoTy/xyl9ROxn
 nrZUWQn1j/+OcMQrQg8O2GbGZV1wN5SuFOmEmrhtXi0dLqYYr91vkAddVMRiQd/X3BVr
 zagd96bwa96Wf9/4vdrL47MHoZnsoXC2W+PQmLBOQ3pariJcx8rRJ3uHF6btd/TF0qbm
 VtPdhoVip8PxKUSWx+Lh0QFGQ0IazRN+PzfVTm0VnE9By3S7votlTr2ALPQXAmIMTSTH
 EveItPTgDL5J/0J5YchbtJDTjmoQmpJgYAqHkO431Unlf3LwoMc8r4O0rhnRxIzD6WrC
 eZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=lVVwnh4OFzrdsTw1x0nwg/8VVBmrtpjbC0uUui9UVZQ=;
 b=lm2I8kimaetrCN19PMQ5slku8y4Moer4541FRYtUAI8jRhimoXIePiggXIvIHhI0PJ
 oO78X1H5g2ODkCr9GFZsklv79vu96huLXah9wWsxLwcMw+FOIitA++uizah850l/W0/c
 bsx9AT/5YDDadT+hzO6e+7VAR+jWBHwAnm6F7RbNaHSamMVyCVV7+JYlZyggB0pC0G8w
 y3P3SP6Dy7z2QAHvkAHh/GJ8ySTik6WhOc48GHlIs9Y6KYIPMJyb6qXp6gyfstMC7q7l
 72HQOxgZyy7ac4Qs7X4IpmihPeOaLWALlpHzkZ0PwbXKkJIPlDV056HUyXXzyxtK/AsR
 gNdg==
X-Gm-Message-State: AOAM532mM/HBFf5T0dMngeofoRES071E1AnLQ9XKfGBlq1CI8Gy8LGFH
 p/rw7qaj7H5ynb5jXxiZURneZeoyM5LCNHrvgXk=
X-Google-Smtp-Source: ABdhPJxydDR7XZc6zrC2CPgdMqixk6p9ntHLr6NAscvSjCnp784qKk7gGA1C9sOR6FTxoNL9HaBiTE5qgqmXt+PwP2I=
X-Received: by 2002:adf:c98a:: with SMTP id f10mr4266298wrh.329.1592481632921; 
 Thu, 18 Jun 2020 05:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Thu, 18 Jun 2020 05:00:32 -0700 (PDT)
In-Reply-To: <519e6f85-4484-fb6c-67e4-a92c99aa7093@flygoat.com>
References: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
 <CAHiYmc6QEU4zk=0Xa6_gs1JEV+1mGNp3oNYQ6rZoxeLF5cABBw@mail.gmail.com>
 <46907c6f-6c0f-5918-0885-a60b0114e1d1@flygoat.com>
 <CAHiYmc6CYez1Ur2atyFa66HvbHSpiDLGa-emJ8CUK=hV0kpqXQ@mail.gmail.com>
 <519e6f85-4484-fb6c-67e4-a92c99aa7093@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 18 Jun 2020 14:00:32 +0200
Message-ID: <CAHiYmc41rQVuv2i2r0Qgin2emtVOBi15-kx4sHjw4H5EbDeaJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/mips: Add two groups of loongson-ext
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="0000000000000aa93905a85a86e7"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
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

--0000000000000aa93905a85a86e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Jiaxun Yang <=
jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:

>
>
> =E5=9C=A8 2020/6/16 22:41, Aleksandar Markovic =E5=86=99=E9=81=93:
>
>>
>>
>> =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Jiax=
un Yang <jiaxun.yang@flygoat.com <mailto:
>> jiaxun.yang@flygoat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
>>
>>
>>
>>     =E5=9C=A8 2020/6/16 18:38, Aleksandar Markovic =E5=86=99=E9=81=93:
>>
>>
>>
>>         =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 202=
0., Jiaxun Yang <jiaxun.yang@flygoat.com
>>         <mailto:jiaxun.yang@flygoat.com> <mailto:jiaxun.yang@flygoat.com
>>         <mailto:jiaxun.yang@flygoat.com>>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>>              This is the sucessor of:
>>              "Basic TCG Loongson-3A1000 Support"
>>
>>              Thanks!
>>
>>
>>         Hi, Jiaxun.
>>
>>         Thanks for providing updated version of the series.
>>
>>         I wonder, given so many "#if defined(TARGET_MIPS64)" lines in
>>         this series, what would be the 32-bit processors that support
>>         Loongson EXT ASE?
>>
>>
>>     Loongson GS232 core which can be found in Loongson-1A/B/C should
>>     support it.
>>     Although I have no intension to work on QEMU support of these
>>     processors.
>>
>>
>> ...And, for the sake of accuracy, you nevertheless included the correct
>> implementation (for both 32-bir and 64-bit). That is very good. I would =
do
>> the same, if I were you.
>>
>> However, there is a problem. We can't upstream (at least not in QEMU for
>> MIPS) anything without the proper documentation.
>>
>> So, please provide the links or attach the supporting files to the cover
>> letter in v2. You already did something similar in some of your previous
>> series and patches. I am perfectly fine with machine translation from
>> Chinese.
>>
>> For example, you need to provide, among other things, docs describing EX=
T
>> support in GS 232 cores. We can't just make assumptions, or trust your
>> word. These sources of information should be repeated for all versions (=
v2,
>> v3,...) of the series, in their cover letters.
>>
>
> I'll attach necessary information about these instructions in next
> version, however, there is no public document avilable for GS232 core.
> That's why I'm not intend to upstream it for now.
>
> Should I keep these code as is? Ot just filter all Loongson EXT out for
> MIPS32.
>
>
Sorry for late response, Jiaxun, I got carried away with other things.

I am not sure, I simply don't have access to the appropriate info. at this
moment, I'd say you can keep (for now) the "ifdef"-ed code for handling
32-bit, since it will never be actually used.

But, how do you know the code is correct, if there is no doc? How do you
know about specifics of 32-bit ext? Is it just guessing, or more than that?
Mention the source of information in commit messages, if any. Or say this
is just a guess.

A short comment should be added about handling for 32-bit just before the
main functions that handle Loongson EXT, just like Richard did for those
instructions from LMMI that he could not find proper documentation.

Also, can you mention what is achieved by having EXT in QEMU? What
Longson-related scenarion would work, that previously (currently) would not=
?

Thanks for this nice series, and all valuable efforts, hopefully we will
resolve documentation issue in comming days or weeks.

Aleksandar





> Thanks.
>
>
>> I salute your series, but it needs much more justification.
>>
>> Yours,
>> Aleksandar
>>
>>
>>         Thanks,
>>         Aleksandar
>>
>>              Jiaxun Yang (2):
>>                 target/mips: Add loongson-ext lsdc2 group of instruction=
s
>>                 target/mips: Add loongson-ext lswc2 group of instrustion=
s
>>
>>
>>         Also, a spelling mistake in the second title.
>>
>>
>>     Ahh, My bad....
>>
>>
>>                target/mips/translate.c | 437
>>         ++++++++++++++++++++++++++++++++++++++++
>>                1 file changed, 437 insertions(+)
>>
>>              --     2.27.0.rc2
>>
>>
>>     --     - Jiaxun
>>
>>
> --
> - Jiaxun
>

--0000000000000aa93905a85a86e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 17. =D1=98=D1=83=D0=BD 2020., Jiaxu=
n Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.yang@flygoat.c=
om</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><br>
<br>
=E5=9C=A8 2020/6/16 22:41, Aleksandar Markovic =E5=86=99=E9=81=93:<br>
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
<br>
<br>
=C2=A0 =C2=A0 =E5=9C=A8 2020/6/16 18:38, Aleksandar Markovic =E5=86=99=E9=
=81=93:<br>
<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=
=98=D1=83=D0=BD 2020., Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoa=
t.com" target=3D"_blank">jiaxun.yang@flygoat.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jiaxun.yang@flygoa=
t.com" target=3D"_blank">jiaxun.yang@flygoat.co<wbr>m</a>&gt; &lt;mailto:<a=
 href=3D"mailto:jiaxun.yang@flygoat.com" target=3D"_blank">jiaxun.yang@flyg=
oat.co<wbr>m</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:jiaxun.yang@flygoa=
t.com" target=3D"_blank">jiaxun.yang@flygoat.co<wbr>m</a>&gt;&gt;&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 This is the sucessor of:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 &quot;Basic TCG Loongson-3A=
1000 Support&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 Thanks!<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Hi, Jiaxun.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanks for providing updated version of the ser=
ies.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 I wonder, given so many &quot;#if defined(TARGE=
T_MIPS64)&quot; lines in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 this series, what would be the 32-bit processor=
s that support<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Loongson EXT ASE?<br>
<br>
<br>
=C2=A0 =C2=A0 Loongson GS232 core which can be found in Loongson-1A/B/C sho=
uld<br>
=C2=A0 =C2=A0 support it.<br>
=C2=A0 =C2=A0 Although I have no intension to work on QEMU support of these=
<br>
=C2=A0 =C2=A0 processors.<br>
<br>
<br>
...And, for the sake of accuracy, you nevertheless included the correct imp=
lementation (for both 32-bir and 64-bit). That is very good. I would do the=
 same, if I were you.<br>
<br>
However, there is a problem. We can&#39;t upstream (at least not in QEMU fo=
r MIPS) anything without the proper documentation.<br>
<br>
So, please provide the links or attach the supporting files to the cover le=
tter in v2. You already did something similar in some of your previous seri=
es and patches. I am perfectly fine with machine translation from Chinese.<=
br>
<br>
For example, you need to provide, among other things, docs describing EXT s=
upport in GS 232 cores. We can&#39;t just make assumptions, or trust your w=
ord. These sources of information should be repeated for all versions (v2, =
v3,...) of the series, in their cover letters.<br>
</blockquote>
<br>
I&#39;ll attach necessary information about these instructions in next vers=
ion, however, there is no public document avilable for GS232 core.<br>
That&#39;s why I&#39;m not intend to upstream it for now.<br>
<br>
Should I keep these code as is? Ot just filter all Loongson EXT out for MIP=
S32.<br>
<br></blockquote><div><br></div><div>Sorry for late response, Jiaxun, I got=
 carried away with other things.</div><div><br></div><div>I am not sure, I =
simply don&#39;t have access to the appropriate info. at this moment, I&#39=
;d say you can keep (for now) the &quot;ifdef&quot;-ed code for handling 32=
-bit, since it will never be actually used.</div><div><br></div><div>But, h=
ow do you know the code is correct, if there is no doc? How do you know abo=
ut specifics of 32-bit ext? Is it just guessing, or more than that? Mention=
 the source of information in commit messages, if any. Or say this is just =
a guess.</div><div><br></div><div>A short comment should be added about han=
dling for 32-bit just before the main functions that handle Loongson EXT, j=
ust like Richard did for those instructions from LMMI that he could not fin=
d proper documentation.</div><div><br></div><div>Also, can you mention what=
 is achieved by having EXT in QEMU? What Longson-related scenarion would wo=
rk, that previously (currently) would not?</div><div><br></div><div>Thanks =
for this nice series, and all valuable efforts, hopefully we will resolve d=
ocumentation issue in comming days or weeks.</div><div><br></div><div>Aleks=
andar</div><div><br></div><div><br></div><div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
Thanks.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
I salute your series, but it needs much more justification.<br>
<br>
Yours,<br>
Aleksandar<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanks,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Aleksandar<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 Jiaxun Yang (2):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 target/mips: A=
dd loongson-ext lsdc2 group of instructions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 target/mips: A=
dd loongson-ext lswc2 group of instrustions<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Also, a spelling mistake in the second title.<b=
r>
<br>
<br>
=C2=A0 =C2=A0 Ahh, My bad....<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0target/mips/tra=
nslate.c | 437<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++++++++++++++++++++++++++++++<wbr>++++++++++<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed,=
 437 insertions(+)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A02.27.=
0.rc2<br>
<br>
<br>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0- Jiaxun<br>
<br>
</blockquote>
<br>
-- <br>
- Jiaxun<br>
</blockquote>

--0000000000000aa93905a85a86e7--

