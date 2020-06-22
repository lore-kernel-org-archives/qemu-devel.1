Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EA320708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVupWKTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EA320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnSKu-0004S3-N8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnSJz-00033u-8K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:41:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnSJw-0001yE-St
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:41:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id q5so5533912wru.6
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Z7oG4JHwWIQx1CW8ixpJ9aTpKB0CsfYK53Niq5/W/+4=;
 b=iVupWKTJhS6Zvtnepc2ihPotEssQyBoViM0TAhvFTZNvVczrW3y9bIWh1W4E3Uz44i
 KlNXOCntovb6yD/hnjmWtRmQe6B7ZjTgLSLgeaXMtPRfXhFvtFqJnfNQFrd0EK+d0i10
 XlONyf0aKiUEGhEgw+vrqK7QP9v3EOZzoHEJPeOhJHqSZo9pAiHTcZPHu7WqimRAD26r
 361KizfhGEyvIGcgT65CFcHNldl9FPKGfo+GlBfBBWcL1f6+7m8dS5KdWdKQlJJ2UmXX
 8ol6QG6Q734kxMZsED1nIphknslPg+Samw3oxkYWcm8tC8q7VvjaO5Co63euAhdraYNJ
 d+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Z7oG4JHwWIQx1CW8ixpJ9aTpKB0CsfYK53Niq5/W/+4=;
 b=g8QqzVzQDjkdfrG9fHy0PWmTL8D9twRKm4alLsWJdJFP+uEs7nwPi/W4D0+m8EPRKM
 o7IuL0/a2Gn+StMQJsHDuTSLCXhqHEm2145MtIXri4tYvWc1a/awRwhiGOn1Cc31JVbN
 GH3+9zK7KRQTksOCzzkypYLlx/TXlcI55LrIToxChD9ODv8FPR39i5uAORYJBX9FpQDc
 abxgyPmmzWfrS3Qhh+r5/jDQ1uS+rSC9J4tL2AURFLTm1ir+dmxbjkFQQQC0bBgzbmEv
 6aY3NkMThEAKB9XqFbdk8ntscYciEv9zYExRacjidk4Kkr6CKZhZlJzF439p9LTVznpq
 jx4Q==
X-Gm-Message-State: AOAM531gxlVRvAhla2oECDVbVF+mBAStDS3QoeeFqmmWBM7T+hMVfDb8
 kVrTvdueNmqyYrISH2FGffBiAIiBJtBLEPosHdU=
X-Google-Smtp-Source: ABdhPJxpfAM9LdXDBhmJ06GUrpMkYhN5VYOlyWv3v+vSKbJCVhjihcb7qaUzZqB2G7YSveOk5ZnjkPRO3SA3+JDezoQ=
X-Received: by 2002:adf:8462:: with SMTP id 89mr5848223wrf.420.1592854891203; 
 Mon, 22 Jun 2020 12:41:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Mon, 22 Jun 2020 12:41:30
 -0700 (PDT)
In-Reply-To: <2741a5b7-91dc-4087-e9e5-9a17da353072@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
 <CAFEAcA-w4DGH2wEwySZd+zj-m+YpL39tog9S9LNH2iTcL84F9Q@mail.gmail.com>
 <8ec1ccc2-7e7f-94cf-dedf-86c09832c0f7@amsat.org>
 <CAHiYmc7V0Be1i67ZscrvsKyDEXw7aWz1vJHJ3eEPgcyPELLyYw@mail.gmail.com>
 <CAHiYmc4+B22-0AjLMYnJmcAVVYxzKKiPnbViuR-9kBYJrpOK0A@mail.gmail.com>
 <2741a5b7-91dc-4087-e9e5-9a17da353072@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 22 Jun 2020 21:41:30 +0200
Message-ID: <CAHiYmc7-Byoa-1+oadbh4BsOxzTF8VT_6Y+kPEoZL0+H0cBVuQ@mail.gmail.com>
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f80e5e05a8b16d05"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
 Ahmed Karaman <ahmed.khaled.karaman@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f80e5e05a8b16d05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=D1=83=D0=
=BD 2020., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Hi Aleksandar,
>
> On 6/22/20 7:30 PM, Aleksandar Markovic wrote:
> > =D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=D1=
=83=D0=BD 2020., Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com
> > <mailto:aleksandar.qemu.devel@gmail.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >
> >
> >     =D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=
=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >         +Thomas
> >
> >         On 6/22/20 6:19 PM, Peter Maydell wrote:
> >         > On Mon, 22 Jun 2020 at 17:01, Peter Maydell
> >         <peter.maydell@linaro.org <mailto:peter.maydell@linaro.org>>
> wrote:
> >         >>
> >         >> On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9
> >         <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
> >         >>> Renesas hardware patches
> >         >>>
> >         >>> - Add a common entry for Renesas hardware in MAINTAINERS
> >         >>> - Trivial SH4 cleanups
> >         >>> - Add RX GDB simulator from Yoshinori Sato
> >         >>>
> >
> >
> >
> >     Can this rx patch be included in this pull request: (it was r-b-ed =
a
> >     couple of weeks ago already):
> >
> >     https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08581.html
> >     <https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08581.htm=
l
> >
>
> This pull request only contains hardware emulation patches (files under
> hw/, not the TCG code from target/).
>
>
The patch in question affects system mode, therefore hardware emulation
too. Not a big deal, but, to me, it seems as a natural part of this pull
request. It is quite common that pull requests are not limited by
directories - optimally, they should deal with certain set of related
functionalities, not limited by directories. Why would be that patch be
left lonesome? Could you please, Philippe, reconsider exclusion/inclusion
of this patch, if possible?

Thanks, Aleksandar

> R-b by Richard is here:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00229.html
> >
> > The two messages are not directly connected on the list, since r-b was
> > in June, and the patch was in May.
> >
> >
> >
> >     Thanks in advance!
> >
> >     Aleksandar
> >
> >
> >
> >
> >         >>> The Renesas RX target emulation was added in commit
> c8c35e5f51,
> >         >>> these patches complete the target by adding the hardware
> >         emulation.
> >         >>>
> >         >>> Thank you Yoshinori for adding this code to QEMU, and your
> >         patience
> >         >>> during the review process. Now your port is fully integrate=
d.
> >         >>>
> >         >>> Travis-CI:
> >         >>> https://travis-ci.org/github/philmd/qemu/builds/700461815
> >         <https://travis-ci.org/github/philmd/qemu/builds/700461815>
> >         >>
> >         >> Hi; I'm afraid there's a format-string issue here (manifests
> >         >> on OSX, openbsd, and 32-bit platforms):
> >         >>
> >         >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function
> >         'rx_gdbsim_init':
> >         >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error:
> >         format '%lli'
> >         >> expects argument of type 'long long int', but argument 2 has
> type
> >         >> 'ram_addr_t {aka unsigned int}' [-Werror=3Dformat=3D]
> >         >>          error_report("Invalid RAM size, should be more than
> >         %" PRIi64 " Bytes",
> >         >>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~~~~~~~~~~
> >         >>                       mc->default_ram_size);
> >         >>                       ~~~~~~~~~~~~~~~~~~~~
> >         >
> >         > Also there appears to be a makefile/dependency bug somewhere,
> >         > because when I drop this merge attempt and retry building
> >         > with current master I get this error:
> >         >
> >         > make[1]: Entering directory '/home/petmay01/qemu-for-
> merges/slirp'
> >         > make[1]: Nothing to be done for 'all'.
> >         > make[1]: Leaving directory '/home/petmay01/qemu-for-
> merges/slirp'
> >         >   CC      qga/main.o
> >         >   CC      qemu-io.o
> >         >   CC      monitor/qmp-cmds-control.o
> >         > make: *** No rule to make target
> >         > '/home/petmay01/qemu-for-merges/hw/rx/Kconfig', needed by
> >         > 'aarch64-softmmu/config-devices.mak'.  Stop.
> >         > make: *** Waiting for unfinished jobs....
> >         > make: Leaving directory '/home/petmay01/qemu-for-
> merges/build/w64'
> >         >
> >         > This seems to be because aarch64-softmmu/config-devices.mak.d
> >         > in the build tree says that aarch64-softmmu/config-devices.ma=
k
> >         > depends on all the Kconfig files; this means that if a Kconfi=
g
> >         > file gets deleted then incremental build stops working?
> >
> >         This seems the same problem previously discussed here:
> >         https://www.mail-archive.com/qemu-devel@nongnu.org/
> msg676319.html <https://www.mail-archive.com/qemu-devel@nongnu.org/
> msg676319.html>
> >
>

--000000000000f80e5e05a8b16d05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=
=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Aleks=
andar,<br>
<br>
On 6/22/20 7:30 PM, Aleksandar Markovic wrote:<br>
&gt; =D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=D1=
=83=D0=BD 2020., Aleksandar Markovic<br>
&gt; &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu=
.devel@gmail.<wbr>com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksand=
ar.qemu.devel@<wbr>gmail.com</a>&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=
=BA, 22. =D1=98=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug=
@amsat.org</a>&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+Thomas<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 6/22/20 6:19 PM, Peter Maydell wro=
te:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Mon, 22 Jun 2020 at 17:01, Pe=
ter Maydell<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a> &lt;mailto:<a href=3D"mailto:peter.=
maydell@linaro.org">peter.maydell@linaro.<wbr>org</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; On Sun, 21 Jun 2020 at 13:50=
, Philippe Mathieu-Daud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:f4bug@amsat.org=
">f4bug@amsat.org</a> &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Renesas hardware patches=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; - Add a common entry for=
 Renesas hardware in MAINTAINERS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; - Trivial SH4 cleanups<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; - Add RX GDB simulator f=
rom Yoshinori Sato<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Can this rx patch be included in this pull request:=
 (it was r-b-ed a<br>
&gt;=C2=A0 =C2=A0 =C2=A0couple of weeks ago already):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.gnu.org/archive/html/qemu-=
devel/2020-05/msg08581.html" target=3D"_blank">https://lists.gnu.org/archiv=
e/<wbr>html/qemu-devel/2020-05/<wbr>msg08581.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://lists.gnu.org/archive/html/q=
emu-devel/2020-05/msg08581.html" target=3D"_blank">https://lists.gnu.org/<w=
br>archive/html/qemu-devel/2020-<wbr>05/msg08581.html</a>&gt;<br>
<br>
This pull request only contains hardware emulation patches (files under<br>
hw/, not the TCG code from target/).<br>
<br></blockquote><div><br></div><div>The patch in question affects system m=
ode, therefore hardware emulation too. Not a big deal, but, to me, it seems=
 as a natural part of this pull request. It is quite common that pull reque=
sts are not limited by directories - optimally, they should deal with certa=
in set of related functionalities, not limited by directories. Why would be=
 that patch be left lonesome? Could you please, Philippe, reconsider exclus=
ion/inclusion of this patch, if possible?</div><div><br></div><div>Thanks, =
Aleksandar</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; R-b by Richard is here:<br>
&gt; <br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00=
229.html" target=3D"_blank">https://lists.gnu.org/archive/<wbr>html/qemu-de=
vel/2020-06/<wbr>msg00229.html</a><br>
&gt; <br>
&gt; The two messages are not directly connected on the list, since r-b was=
<br>
&gt; in June, and the patch was in May.<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks in advance!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Aleksandar<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; The Renesas RX target em=
ulation was added in commit c8c35e5f51,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; these patches complete t=
he target by adding the hardware<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0emulation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Thank you Yoshinori for =
adding this code to QEMU, and your<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patience<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; during the review proces=
s. Now your port is fully integrated.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; Travis-CI:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;&gt; <a href=3D"https://travi=
s-ci.org/github/philmd/qemu/builds/700461815" target=3D"_blank">https://tra=
vis-ci.org/github/<wbr>philmd/qemu/builds/700461815</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://travis-ci.org/=
github/philmd/qemu/builds/700461815" target=3D"_blank">https://travis-ci.or=
g/github/<wbr>philmd/qemu/builds/700461815</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; Hi; I&#39;m afraid there&#39=
;s a format-string issue here (manifests<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; on OSX, openbsd, and 32-bit =
platforms):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; /home/peter.maydell/qemu/hw/=
<wbr>rx/rx-gdbsim.c: In function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rx_gdbsim_init&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; /home/peter.maydell/qemu/hw/=
<wbr>rx/rx-gdbsim.c:93:22: error:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0format &#39;%lli&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; expects argument of type &#3=
9;long long int&#39;, but argument 2 has type<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; &#39;ram_addr_t {aka unsigne=
d int}&#39; [-Werror=3Dformat=3D]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 error_report(&quot;Invalid RAM size, should be more than<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0%&quot; PRIi64 &quot; Bytes&quot;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~<wbr>~~~~~~~~~~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mc-&gt;default_ram_s=
ize);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~~~~~~~~~~~~~~=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Also there appears to be a makef=
ile/dependency bug somewhere,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; because when I drop this merge a=
ttempt and retry building<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; with current master I get this e=
rror:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; make[1]: Entering directory &#39=
;/home/petmay01/qemu-for-<wbr>merges/slirp&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; make[1]: Nothing to be done for =
&#39;all&#39;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; make[1]: Leaving directory &#39;=
/home/petmay01/qemu-for-<wbr>merges/slirp&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=
=A0 qga/main.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=
=A0 qemu-io.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=
=A0 monitor/qmp-cmds-control.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; make: *** No rule to make target=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &#39;/home/petmay01/qemu-for-<wb=
r>merges/hw/rx/Kconfig&#39;, needed by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &#39;aarch64-softmmu/config-<wbr=
>devices.mak&#39;.=C2=A0 Stop.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; make: *** Waiting for unfinished=
 jobs....<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; make: Leaving directory &#39;/ho=
me/petmay01/qemu-for-<wbr>merges/build/w64&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; This seems to be because aarch64=
-softmmu/config-<wbr>devices.mak.d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; in the build tree says that aarc=
h64-softmmu/config-<wbr>devices.mak<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; depends on all the Kconfig files=
; this means that if a Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; file gets deleted then increment=
al build stops working?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This seems the same problem previousl=
y discussed here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.mail-archive.c=
om/qemu-devel@nongnu.org/msg676319.html" target=3D"_blank">https://www.mail=
-archive.com/<wbr>qemu-devel@nongnu.org/<wbr>msg676319.html</a> &lt;<a href=
=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.html" targ=
et=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongnu.org/<wbr>=
msg676319.html</a>&gt;<br>
&gt; <br>
</blockquote>

--000000000000f80e5e05a8b16d05--

