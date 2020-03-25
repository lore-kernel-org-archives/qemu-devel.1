Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF60C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ED420771
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wyd/vvAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ED420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH46u-0001qW-4S
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH46H-0001Rp-Pq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH46G-0000Jx-4a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:21:33 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:42863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH46F-0000Il-Sw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:21:32 -0400
Received: by mail-lf1-x131.google.com with SMTP id t21so1419185lfe.9
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hkSxTrajaoUPOJKxe1XnP3trFEqgQTPjFz+MFSsslBI=;
 b=Wyd/vvAlD5MdrWD7Rhu/VoQdfYjeZ/O8fGAcMtalrQZPb5qj9YHnuP9p7mWaSIWqti
 Bcu9fCsPXz77CMcl870B0tXk2fYz4CoT7NNYmeMtq3d1H7yaNwMPVS/7PRoeh2/rxbHa
 8wpTuePXBMHjTiT8qYVanYMud9miOCXFM4dNPAW8x1wAc8pL97ppbq+nhyt/KV6UbwkU
 qfEMtQAsG1qgNTqT7XsrsANGUtCIysRf+2u8SJMQwdCdpEVubhpjAHYikDgcb+5Rs8vO
 EeyI9KJhS9CZdWGVB+5oWrjV1yhAvor8GlD1iuJZSdt9SYPTFRHdHOfIL9D89S+Gthb9
 bxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hkSxTrajaoUPOJKxe1XnP3trFEqgQTPjFz+MFSsslBI=;
 b=pqDjZicY+YDVwHtSLekuDmfg41Arv2rbeBhfRbKxK2o50jmeNnb1fnWaSNsklHIIY1
 u/eKHZN3tyzobktg6MTbKTjusZ2s/g2CLgkCF7efk7rDRcD9/ANh0QYa8Di1qnH5yz/R
 N4EELnvtXYdxV1ryicRgC0z7j7mA12R5eZbE6vHcbyuovPgXdW+JNqk4PFRI7/UCfXGP
 dngXJCkE0k7cD56VpF4uUl4e0BTY8mKfctG4UYloXXfK222lEnAvKUvuAjvsiN9yADcF
 oUuk/QYJMgsbAVkx4gZsvfbdbcu/kJ43OLLl427/GQmA7l8kgHE/Yvo2Ohw/Z3rTzPVd
 lppw==
X-Gm-Message-State: ANhLgQ0zM1M7+24Liu0NI9TB3rffG/n3EsXcrmVm4swBav3lnw6Ys8iC
 kDTm/cNn7z65GDFI1IkPO4Mn9grViadFAy/7suGvmg==
X-Google-Smtp-Source: ADFU+vsI+QrydQcdMPA76BhknRYQafo3W6/bqh0XUwumuSF1aYGF8scDUxwY4Nb5+C3tif1VHFpXLF8MLyrvLHFQygU=
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr2006836lfh.206.1585135289127; 
 Wed, 25 Mar 2020 04:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-7-alex.bennee@linaro.org>
 <20e5e10b-a2ac-06ed-edb4-5d4250c1775a@linaro.org>
 <CAHiYmc6G-RhqRxK7Dn2KAv3oN4yYy8HbiJbyHfTF-TKXgDbJmw@mail.gmail.com>
In-Reply-To: <CAHiYmc6G-RhqRxK7Dn2KAv3oN4yYy8HbiJbyHfTF-TKXgDbJmw@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Wed, 25 Mar 2020 11:21:16 +0000
Message-ID: <CAHDbmO2FevBpK31togh9eueQsvL1vYpk=XjzfpMHsRvQrWqDOA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] configure: disable MTTCG for MIPS guests
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d46bfc05a1ac112c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::131
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d46bfc05a1ac112c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes I'll put it through mine.

On Wed, 25 Mar 2020, 10:53 Aleksandar Markovic, <
aleksandar.qemu.devel@gmail.com> wrote:

> 20:17 Pon, 23.03.2020. Richard Henderson <richard.henderson@linaro.org>
> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On 3/23/20 9:15 AM, Alex Benn=C3=A9e wrote:
> > > While debugging check-acceptance failures I found an instability in
> > > the mips64el test case. Briefly the test case:
> > >
> > >   retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
> > >     -display none -vga none -serial mon:stdio \
> > >     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
> > >     -cpu I6400 -smp 8 -vga std \
> > >     -append "printk.time=3D0 clocksource=3DGIC console=3Dtty0 console=
=3DttyS0
> panic=3D-1" \
> > >     --no-reboot
> > >
> > > Reports about a 9% failure rate:
> > >
> > >   Results summary:
> > >   0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
> > >   -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
> > >   Ran command 100 times, 91 passes
> > >
> > > When re-run with "--accel tcg,thread=3Dsingle" the instability goes
> > > away.
> > >
> > >   Results summary:
> > >   0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80
> deviation)
> > >   Ran command 100 times, 100 passes
> > >
> > > Which seems to indicate there is some aspect of the MIPS MTTCG fixes
> > > that has been missed. Ideally we would fix that but I'm afraid I don'=
t
> > > have time to investigate and am not super familiar with the
> > > architecture anyway. In lieu of someone tracking down the failure let=
s
> > > disable it for now.
> > >
> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > > Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> >
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> >
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qem u.devel@gmail.com>
>
> But, Alex, I expect this patch will go through your queue, not MIPS queue
> (unless you told me otherwise).
>
> Thanks,
> Aleksandar
>
> >
> > r~
>

--000000000000d46bfc05a1ac112c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes I&#39;ll put it through mine.</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 25 Mar 2020, 10:=
53 Aleksandar Markovic, &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.c=
om">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><p dir=3D"ltr"></p>
<p dir=3D"ltr">20:17 Pon, 23.03.2020. Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferrer">richa=
rd.henderson@linaro.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 3/23/20 9:15 AM, Alex Benn=C3=A9e wrote:<br>
&gt; &gt; While debugging check-acceptance failures I found an instability =
in<br>
&gt; &gt; the mips64el test case. Briefly the test case:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-=
mips64el \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-display none -vga none -serial mon:stdio \<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-machine malta -kernel ./vmlinux-4.7.0-rc1.I64=
00 \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-cpu I6400 -smp 8 -vga std \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-append &quot;printk.time=3D0 clocksource=3DGI=
C console=3Dtty0 console=3DttyS0 panic=3D-1&quot; \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--no-reboot<br>
&gt; &gt; <br>
&gt; &gt; Reports about a 9% failure rate:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0Results summary:<br>
&gt; &gt;=C2=A0 =C2=A00: 91 times (91.00%), avg time 5.547 (0.45 varience/0=
.67 deviation)<br>
&gt; &gt;=C2=A0 =C2=A0-6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.=
13 deviation)<br>
&gt; &gt;=C2=A0 =C2=A0Ran command 100 times, 91 passes<br>
&gt; &gt; <br>
&gt; &gt; When re-run with &quot;--accel tcg,thread=3Dsingle&quot; the inst=
ability goes<br>
&gt; &gt; away.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0Results summary:<br>
&gt; &gt;=C2=A0 =C2=A00: 100 times (100.00%), avg time 17.318 (249.76 varie=
nce/15.80 deviation)<br>
&gt; &gt;=C2=A0 =C2=A0Ran command 100 times, 100 passes<br>
&gt; &gt; <br>
&gt; &gt; Which seems to indicate there is some aspect of the MIPS MTTCG fi=
xes<br>
&gt; &gt; that has been missed. Ideally we would fix that but I&#39;m afrai=
d I don&#39;t<br>
&gt; &gt; have time to investigate and am not super familiar with the<br>
&gt; &gt; architecture anyway. In lieu of someone tracking down the failure=
 lets<br>
&gt; &gt; disable it for now.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a=
>&gt;<br>
&gt; &gt; Acked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>&gt;<br=
>
&gt; &gt; Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com" target=3D"_blank" rel=3D"noreferrer">aleksandar.qemu.devel@gm=
ail.com</a>&gt;<br>
&gt; &gt; Cc: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net" ta=
rget=3D"_blank" rel=3D"noreferrer">aurelien@aurel32.net</a>&gt;<br>
&gt; &gt; Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-=
rk.com" target=3D"_blank" rel=3D"noreferrer">aleksandar.rikalo@rt-rk.com</a=
>&gt;<br>
&gt;<br>
&gt; Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br>
&gt;</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;aleksandar.qem <a href=
=3D"mailto:u.devel@gmail.com" target=3D"_blank" rel=3D"noreferrer">u.devel@=
gmail.com</a>&gt;</p>
<p dir=3D"ltr">But, Alex, I expect this patch will go through your queue, n=
ot MIPS queue (unless you told me otherwise).</p>
<p dir=3D"ltr">Thanks,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
</p>
</blockquote></div>

--000000000000d46bfc05a1ac112c--

