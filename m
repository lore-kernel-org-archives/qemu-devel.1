Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC2A20656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aby/nMfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC2A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQHz-0007kd-06
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnQHJ-0007KV-Di
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:30:41 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnQHH-0006ky-F6
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:30:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so365328wmi.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=y5XcHRq24imWRdJ1lL9BB6MrFbkyzWUubKGl2J0af50=;
 b=Aby/nMfL6cOaW6WfENi30Tvpq5VEnDnEEakCMvx6oIQBkYLx99uyJDN56gCDkWF9st
 Tr9T8F3JSEBuGRnkHDpqYCJEs3m8hWdn6zhIBjMVUwh1NLgM0DBZtNN2gt6uKCJh6Xqp
 ME7u8bSd7fnGG7QGmLySrVrvK9wL38of14Kg6rbFn+Z4JtB/Qamu4Fbo6jr4cy4MtPXh
 vsnAqcOtASGWknMAHEnt9DmDkFVa3sIJGERK5dTMYI1hWOdHdeYeAbscG5+LTVT2Uovg
 NmuXBUT4TURGy04Yg0x4F1k+qpAbn3U09m5LtjiWoJ/ohoi3mW45WG+teGW/kzLLdreH
 3xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=y5XcHRq24imWRdJ1lL9BB6MrFbkyzWUubKGl2J0af50=;
 b=SVgiqKKrHsyuiMofuJrN66qIuKmPaWuawd7x1lWymrbuiT1FNVl60lynlAM92NdM5Y
 vl1fwePoVZe2p5PfUlSTsMYLBazQOViuBSeE2e1pBNXN+yS+4q/sOZ3A0AqP/FdL8jwY
 6GqACQobQ+o0OFquhOP0pKzUEwSf4Ry+46xgMniuJBwROLt5meAcvrBvB4s4kN5YTfji
 +4YivthdvZesJtoN2kWHGNc9fkELA1Cy5j4adjZZK9itbBYN6EGHCoawxTg6C2chrIhq
 r958KiG1IjOUqNKo7tOJoS4QOiX7OF71LvuLuWr0okUzllGd2PdvNbJKYsPc3cC8zplq
 Jolg==
X-Gm-Message-State: AOAM531AAL38AjsPrVJBTKVYRj+8EfY7jmGJUVD94WH/XZRGzj9xa6tK
 FCmyAPkobJq0Pv18GdFfNuPQy0N+sAVkCa0lUJU=
X-Google-Smtp-Source: ABdhPJxMsGYIC7zo6KtiRZnmSNhbuI5kXPkC7R16+bP7uDlxGExZaYzV/On89+c0oOcV9FKBVDsnlSx3qT8R+nlQbsw=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr20341584wmm.50.1592847037968; 
 Mon, 22 Jun 2020 10:30:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Mon, 22 Jun 2020 10:30:37
 -0700 (PDT)
In-Reply-To: <CAHiYmc7V0Be1i67ZscrvsKyDEXw7aWz1vJHJ3eEPgcyPELLyYw@mail.gmail.com>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
 <CAFEAcA-w4DGH2wEwySZd+zj-m+YpL39tog9S9LNH2iTcL84F9Q@mail.gmail.com>
 <8ec1ccc2-7e7f-94cf-dedf-86c09832c0f7@amsat.org>
 <CAHiYmc7V0Be1i67ZscrvsKyDEXw7aWz1vJHJ3eEPgcyPELLyYw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 22 Jun 2020 19:30:37 +0200
Message-ID: <CAHiYmc4+B22-0AjLMYnJmcAVVYxzKKiPnbViuR-9kBYJrpOK0A@mail.gmail.com>
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000e1374d05a8af990f"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e1374d05a8af990f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=D1=83=D0=
=BD 2020., Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:

>
>
> =D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=D1=83=
=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>> +Thomas
>>
>> On 6/22/20 6:19 PM, Peter Maydell wrote:
>> > On Mon, 22 Jun 2020 at 17:01, Peter Maydell <peter.maydell@linaro.org>
>> wrote:
>> >>
>> >> On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org>
>> wrote:
>> >>> Renesas hardware patches
>> >>>
>> >>> - Add a common entry for Renesas hardware in MAINTAINERS
>> >>> - Trivial SH4 cleanups
>> >>> - Add RX GDB simulator from Yoshinori Sato
>> >>>
>
>
>
> Can this rx patch be included in this pull request: (it was r-b-ed a
> couple of weeks ago already):
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08581.html
>
>
R-b by Richard is here:

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00229.html

The two messages are not directly connected on the list, since r-b was in
June, and the patch was in May.



> Thanks in advance!
>
> Aleksandar
>
>
>
>
>> >>> The Renesas RX target emulation was added in commit c8c35e5f51,
>> >>> these patches complete the target by adding the hardware emulation.
>> >>>
>> >>> Thank you Yoshinori for adding this code to QEMU, and your patience
>> >>> during the review process. Now your port is fully integrated.
>> >>>
>> >>> Travis-CI:
>> >>> https://travis-ci.org/github/philmd/qemu/builds/700461815
>> >>
>> >> Hi; I'm afraid there's a format-string issue here (manifests
>> >> on OSX, openbsd, and 32-bit platforms):
>> >>
>> >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function
>> 'rx_gdbsim_init':
>> >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error: format '%lli=
'
>> >> expects argument of type 'long long int', but argument 2 has type
>> >> 'ram_addr_t {aka unsigned int}' [-Werror=3Dformat=3D]
>> >>          error_report("Invalid RAM size, should be more than %" PRIi6=
4
>> " Bytes",
>> >>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >>                       mc->default_ram_size);
>> >>                       ~~~~~~~~~~~~~~~~~~~~
>> >
>> > Also there appears to be a makefile/dependency bug somewhere,
>> > because when I drop this merge attempt and retry building
>> > with current master I get this error:
>> >
>> > make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
>> > make[1]: Nothing to be done for 'all'.
>> > make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
>> >   CC      qga/main.o
>> >   CC      qemu-io.o
>> >   CC      monitor/qmp-cmds-control.o
>> > make: *** No rule to make target
>> > '/home/petmay01/qemu-for-merges/hw/rx/Kconfig', needed by
>> > 'aarch64-softmmu/config-devices.mak'.  Stop.
>> > make: *** Waiting for unfinished jobs....
>> > make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'
>> >
>> > This seems to be because aarch64-softmmu/config-devices.mak.d
>> > in the build tree says that aarch64-softmmu/config-devices.mak
>> > depends on all the Kconfig files; this means that if a Kconfig
>> > file gets deleted then incremental build stops working?
>>
>> This seems the same problem previously discussed here:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.html
>>
>>

--000000000000e1374d05a8af990f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=
=D1=83=D0=BD 2020., Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qe=
mu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=
=BA, 22. =D1=98=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">+Thomas<br>
<br>
On 6/22/20 6:19 PM, Peter Maydell wrote:<br>
&gt; On Mon, 22 Jun 2020 at 17:01, Peter Maydell &lt;<a href=3D"mailto:pete=
r.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wr=
ote:<br>
&gt;&gt;<br>
&gt;&gt; On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wr=
ote:<br>
&gt;&gt;&gt; Renesas hardware patches<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - Add a common entry for Renesas hardware in MAINTAINERS<br>
&gt;&gt;&gt; - Trivial SH4 cleanups<br>
&gt;&gt;&gt; - Add RX GDB simulator from Yoshinori Sato<br>
&gt;&gt;&gt;</blockquote><div><br></div><div><br></div><div>Can this rx pat=
ch be included in this pull request: (it was r-b-ed a couple of weeks ago a=
lready):</div><div><br></div><div><a href=3D"https://lists.gnu.org/archive/=
html/qemu-devel/2020-05/msg08581.html" target=3D"_blank">https://lists.gnu.=
org/archive/<wbr>html/qemu-devel/2020-05/<wbr>msg08581.html</a><br></div><d=
iv><br></div></blockquote><div><br></div><div>R-b by Richard is here:</div>=
<div><br></div><div><a href=3D"https://lists.gnu.org/archive/html/qemu-deve=
l/2020-06/msg00229.html">https://lists.gnu.org/archive/html/qemu-devel/2020=
-06/msg00229.html</a><br></div><div><br></div><div>The two messages are not=
 directly connected on the list, since r-b was in June, and the patch was i=
n May.</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div>Thanks in advance!</div><div><br></div><div>Aleksandar</div><div><br><=
/div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;&gt;&gt; The Renesas RX target emulation was added in commit c8c35e5f51=
,<br>
&gt;&gt;&gt; these patches complete the target by adding the hardware emula=
tion.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thank you Yoshinori for adding this code to QEMU, and your pat=
ience<br>
&gt;&gt;&gt; during the review process. Now your port is fully integrated.<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Travis-CI:<br>
&gt;&gt;&gt; <a href=3D"https://travis-ci.org/github/philmd/qemu/builds/700=
461815" target=3D"_blank">https://travis-ci.org/github/p<wbr>hilmd/qemu/bui=
lds/700461815</a><br>
&gt;&gt;<br>
&gt;&gt; Hi; I&#39;m afraid there&#39;s a format-string issue here (manifes=
ts<br>
&gt;&gt; on OSX, openbsd, and 32-bit platforms):<br>
&gt;&gt;<br>
&gt;&gt; /home/peter.maydell/qemu/hw/rx<wbr>/rx-gdbsim.c: In function &#39;=
rx_gdbsim_init&#39;:<br>
&gt;&gt; /home/peter.maydell/qemu/hw/rx<wbr>/rx-gdbsim.c:93:22: error: form=
at &#39;%lli&#39;<br>
&gt;&gt; expects argument of type &#39;long long int&#39;, but argument 2 h=
as type<br>
&gt;&gt; &#39;ram_addr_t {aka unsigned int}&#39; [-Werror=3Dformat=3D]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Invalid RAM s=
ize, should be more than %&quot; PRIi64 &quot; Bytes&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~<wbr>~~~~~~~~~~~~<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mc-&gt;default_ram_size);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0~~~~~~~~~~~~~~~~~~~~<br>
&gt; <br>
&gt; Also there appears to be a makefile/dependency bug somewhere,<br>
&gt; because when I drop this merge attempt and retry building<br>
&gt; with current master I get this error:<br>
&gt; <br>
&gt; make[1]: Entering directory &#39;/home/petmay01/qemu-for-merge<wbr>s/s=
lirp&#39;<br>
&gt; make[1]: Nothing to be done for &#39;all&#39;.<br>
&gt; make[1]: Leaving directory &#39;/home/petmay01/qemu-for-merge<wbr>s/sl=
irp&#39;<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 qga/main.o<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 qemu-io.o<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 monitor/qmp-cmds-control.o<br>
&gt; make: *** No rule to make target<br>
&gt; &#39;/home/petmay01/qemu-for-merge<wbr>s/hw/rx/Kconfig&#39;, needed by=
<br>
&gt; &#39;aarch64-softmmu/config-device<wbr>s.mak&#39;.=C2=A0 Stop.<br>
&gt; make: *** Waiting for unfinished jobs....<br>
&gt; make: Leaving directory &#39;/home/petmay01/qemu-for-merge<wbr>s/build=
/w64&#39;<br>
&gt; <br>
&gt; This seems to be because aarch64-softmmu/config-devices<wbr>.mak.d<br>
&gt; in the build tree says that aarch64-softmmu/config-devices<wbr>.mak<br=
>
&gt; depends on all the Kconfig files; this means that if a Kconfig<br>
&gt; file gets deleted then incremental build stops working?<br>
<br>
This seems the same problem previously discussed here:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.htm=
l" target=3D"_blank">https://www.mail-archive.com/q<wbr>emu-devel@nongnu.or=
g/msg676319<wbr>.html</a><br>
<br>
</blockquote>
</blockquote>

--000000000000e1374d05a8af990f--

