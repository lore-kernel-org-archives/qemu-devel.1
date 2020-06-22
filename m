Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE76DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8432075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU3ImPpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8432075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQ9o-0000Au-0i
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnQ96-0007rM-HA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:22:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnQ94-0005XL-Hb
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:22:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so322286wmh.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=hFDGBo+0EtTiHdA1ZrJrcXLAmzaiWvL79JkZSQkynbE=;
 b=mU3ImPpG+HX9RJt4dyehdMx3PJww+N4rXxQHAzCaXbAgxF7IHC2tj7B0KQD7m1mDJT
 v+nW5eXx4HX+9KGLR6nQtWCvzHoX/3OpNCAbbL0BABCR2+j3/TkwlC6mWOX6Lja8wvQm
 yFA19npDVsZvliyp6XVj22NkVDKkcO2G/NVOMuM6wxFMBPR9ZeIqWX4cOfYwxBr7HdQ5
 sqsY9OyKn/pqjvLujx6g+vncNWnpMYuzp0Wc5UVKK1oeufJRrOwnA+8wGQfunqtQvg0w
 HLpMeW6Ia/9eYGp7M6F4B7V8Jr/+OVmYViaDYjt7yHLA7c3DTukRKs05V7CNJnyPUIbZ
 YDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=hFDGBo+0EtTiHdA1ZrJrcXLAmzaiWvL79JkZSQkynbE=;
 b=fYCoRnAPU3/JCazUGMcqOacJHeo62PNoqTOeur+mzZC7r7i1gCXKzLnHkYltqZRcYF
 DUDXsszLh6uBB8DJQQHjU+n1OvQRHp7uA/zzfkxo8ijyHU9HNS0uQK7FQgXucSD7puDM
 zzWry3PZPXbck7IjN22NmP0/9kZ9zsXRVIWw+xT6Y225qWU0E2d359CP1/64ubs/GvGI
 Gv4AvybR8xI8FJ46EKUQmaFNaL6qxED4XwcAJjeOOC19CpfHrW9UpsDmxq5UOhhJqCeA
 sFCADHvS3mGXqSDl0K83b3zDS0IfuUhw0DFiD2JoJH5Fy6veEH5o5/xCCQn1HtYLOPwj
 oPmw==
X-Gm-Message-State: AOAM533cvqerx2ALcaAt01ZwWsvbzzuFXLQs1P7up7XlFFf940M4bgWn
 7kFbC5wjlOCrPflCIylxjAVXOB25FGq8sqc+PiU=
X-Google-Smtp-Source: ABdhPJzzqwzIkLsiHV6nTVRGw5xPTizzZfvqNl6Ga9Jh7B97KpvjqT078pJGR/Euxr6TogN7RHlKf0Ji4OWY4+FNKlE=
X-Received: by 2002:a1c:4444:: with SMTP id r65mr1226200wma.129.1592846528558; 
 Mon, 22 Jun 2020 10:22:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Mon, 22 Jun 2020 10:22:08
 -0700 (PDT)
In-Reply-To: <8ec1ccc2-7e7f-94cf-dedf-86c09832c0f7@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <CAFEAcA_5663fFNVqcr1maATB6v8R297LmJEtD+8V4LvhaSkjPA@mail.gmail.com>
 <CAFEAcA-w4DGH2wEwySZd+zj-m+YpL39tog9S9LNH2iTcL84F9Q@mail.gmail.com>
 <8ec1ccc2-7e7f-94cf-dedf-86c09832c0f7@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 22 Jun 2020 19:22:08 +0200
Message-ID: <CAHiYmc7V0Be1i67ZscrvsKyDEXw7aWz1vJHJ3eEPgcyPELLyYw@mail.gmail.com>
Subject: Re: [PULL 00/15] Renesas hardware patches for 2020-06-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000084391005a8af7b02"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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

--00000000000084391005a8af7b02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=D1=83=D0=
=BD 2020., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> +Thomas
>
> On 6/22/20 6:19 PM, Peter Maydell wrote:
> > On Mon, 22 Jun 2020 at 17:01, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >>
> >> On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>
> wrote:
> >>> Renesas hardware patches
> >>>
> >>> - Add a common entry for Renesas hardware in MAINTAINERS
> >>> - Trivial SH4 cleanups
> >>> - Add RX GDB simulator from Yoshinori Sato
> >>>



Can this rx patch be included in this pull request: (it was r-b-ed a couple
of weeks ago already):

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08581.html

Thanks in advance!

Aleksandar




> >>> The Renesas RX target emulation was added in commit c8c35e5f51,
> >>> these patches complete the target by adding the hardware emulation.
> >>>
> >>> Thank you Yoshinori for adding this code to QEMU, and your patience
> >>> during the review process. Now your port is fully integrated.
> >>>
> >>> Travis-CI:
> >>> https://travis-ci.org/github/philmd/qemu/builds/700461815
> >>
> >> Hi; I'm afraid there's a format-string issue here (manifests
> >> on OSX, openbsd, and 32-bit platforms):
> >>
> >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c: In function
> 'rx_gdbsim_init':
> >> /home/peter.maydell/qemu/hw/rx/rx-gdbsim.c:93:22: error: format '%lli'
> >> expects argument of type 'long long int', but argument 2 has type
> >> 'ram_addr_t {aka unsigned int}' [-Werror=3Dformat=3D]
> >>          error_report("Invalid RAM size, should be more than %" PRIi64
> " Bytes",
> >>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>                       mc->default_ram_size);
> >>                       ~~~~~~~~~~~~~~~~~~~~
> >
> > Also there appears to be a makefile/dependency bug somewhere,
> > because when I drop this merge attempt and retry building
> > with current master I get this error:
> >
> > make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
> >   CC      qga/main.o
> >   CC      qemu-io.o
> >   CC      monitor/qmp-cmds-control.o
> > make: *** No rule to make target
> > '/home/petmay01/qemu-for-merges/hw/rx/Kconfig', needed by
> > 'aarch64-softmmu/config-devices.mak'.  Stop.
> > make: *** Waiting for unfinished jobs....
> > make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'
> >
> > This seems to be because aarch64-softmmu/config-devices.mak.d
> > in the build tree says that aarch64-softmmu/config-devices.mak
> > depends on all the Kconfig files; this means that if a Kconfig
> > file gets deleted then incremental build stops working?
>
> This seems the same problem previously discussed here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.html
>
>

--00000000000084391005a8af7b02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 22. =D1=98=
=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">+Thomas<=
br>
<br>
On 6/22/20 6:19 PM, Peter Maydell wrote:<br>
&gt; On Mon, 22 Jun 2020 at 17:01, Peter Maydell &lt;<a href=3D"mailto:pete=
r.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Sun, 21 Jun 2020 at 13:50, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br>
&gt;&gt;&gt; Renesas hardware patches<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - Add a common entry for Renesas hardware in MAINTAINERS<br>
&gt;&gt;&gt; - Trivial SH4 cleanups<br>
&gt;&gt;&gt; - Add RX GDB simulator from Yoshinori Sato<br>
&gt;&gt;&gt;</blockquote><div><br></div><div><br></div><div>Can this rx pat=
ch be included in this pull request: (it was r-b-ed a couple of weeks ago a=
lready):</div><div><br></div><div><a href=3D"https://lists.gnu.org/archive/=
html/qemu-devel/2020-05/msg08581.html">https://lists.gnu.org/archive/html/q=
emu-devel/2020-05/msg08581.html</a><br></div><div><br></div><div>Thanks in =
advance!</div><div><br></div><div>Aleksandar</div><div><br></div><div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
461815" target=3D"_blank">https://travis-ci.org/github/<wbr>philmd/qemu/bui=
lds/700461815</a><br>
&gt;&gt;<br>
&gt;&gt; Hi; I&#39;m afraid there&#39;s a format-string issue here (manifes=
ts<br>
&gt;&gt; on OSX, openbsd, and 32-bit platforms):<br>
&gt;&gt;<br>
&gt;&gt; /home/peter.maydell/qemu/hw/<wbr>rx/rx-gdbsim.c: In function &#39;=
rx_gdbsim_init&#39;:<br>
&gt;&gt; /home/peter.maydell/qemu/hw/<wbr>rx/rx-gdbsim.c:93:22: error: form=
at &#39;%lli&#39;<br>
&gt;&gt; expects argument of type &#39;long long int&#39;, but argument 2 h=
as type<br>
&gt;&gt; &#39;ram_addr_t {aka unsigned int}&#39; [-Werror=3Dformat=3D]<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Invalid RAM s=
ize, should be more than %&quot; PRIi64 &quot; Bytes&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<wbr>~~~~~~~~~~~<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mc-&gt;default_ram_size);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0~~~~~~~~~~~~~~~~~~~~<br>
&gt; <br>
&gt; Also there appears to be a makefile/dependency bug somewhere,<br>
&gt; because when I drop this merge attempt and retry building<br>
&gt; with current master I get this error:<br>
&gt; <br>
&gt; make[1]: Entering directory &#39;/home/petmay01/qemu-for-<wbr>merges/s=
lirp&#39;<br>
&gt; make[1]: Nothing to be done for &#39;all&#39;.<br>
&gt; make[1]: Leaving directory &#39;/home/petmay01/qemu-for-<wbr>merges/sl=
irp&#39;<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 qga/main.o<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 qemu-io.o<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 monitor/qmp-cmds-control.o<br>
&gt; make: *** No rule to make target<br>
&gt; &#39;/home/petmay01/qemu-for-<wbr>merges/hw/rx/Kconfig&#39;, needed by=
<br>
&gt; &#39;aarch64-softmmu/config-<wbr>devices.mak&#39;.=C2=A0 Stop.<br>
&gt; make: *** Waiting for unfinished jobs....<br>
&gt; make: Leaving directory &#39;/home/petmay01/qemu-for-<wbr>merges/build=
/w64&#39;<br>
&gt; <br>
&gt; This seems to be because aarch64-softmmu/config-<wbr>devices.mak.d<br>
&gt; in the build tree says that aarch64-softmmu/config-<wbr>devices.mak<br=
>
&gt; depends on all the Kconfig files; this means that if a Kconfig<br>
&gt; file gets deleted then incremental build stops working?<br>
<br>
This seems the same problem previously discussed here:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg676319.htm=
l" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongnu.or=
g/<wbr>msg676319.html</a><br>
<br>
</blockquote>

--00000000000084391005a8af7b02--

