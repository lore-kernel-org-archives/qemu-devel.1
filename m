Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496AA2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLwgCTWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496AA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE2B-0005XJ-KW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqE0z-0004yE-Om
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:01:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqE0w-00066b-8d
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:01:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so19661188wrv.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qFvB9VN6SkphOLN1XzjLgokkcdx7lAH3qhHtV5jAsaI=;
 b=QLwgCTWGinf4LrpQTxmJdJtbNM03i1rMLFsou/N9H3/ZtmJOnI9qVdv9BLnvtNl78N
 q55J3J6y7TwA+mioi1XjMzSvTQ3NJT3uArg4I6H2t5+SlBoNd9KYzNpY7KtsE6sqD59d
 flzRG6vycvGJ0EOCP2ytBNmmnvl4HqCLINT5GOxGeDGvlh71KNkSzV2GYmO8fDJgM+gF
 /1UxTP0s805RD8Gy3Ve7KRJqaNI3pIyR5g4GZoQmVL6VOZRyMY/miPyZmo/lsOyFgeuN
 W8b1g7qsvPUrgt0HzCq8AN8CU7h1k77Tdm/cVjFSxwD5DE7QbJhCI+MaqsyGHpOXjs6u
 Xy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qFvB9VN6SkphOLN1XzjLgokkcdx7lAH3qhHtV5jAsaI=;
 b=K0bhxEIqQcBDhGlyjOF9KYwyKb1W9DrcscvPm+szys2c2paMt1pOfWj9Y5awtFEqAV
 4FHv9Ysau5HNFYCJ5B5b+hw5BegW9rIbP0YUb9WmD14aLfPym7j/krmRo2zp97Csw08T
 zljT0J9SdKsZWbdB7j3OOS7rz8SZFnqZxLlOgKum6rI+88vLV9fJmAj45VQQsHc6IZ93
 K0rHPW28QXm14ZFdRjXvqq6VCeKFA/2CgI/E6SMQ+gSdhEQ6DOtdrf2upRGarzK78j36
 YHwvh3CB4MMjeyZLUVin5+15DLOJJyM03jUcswd5QMdYf6okvD+q1bd95a56CzHXpxbW
 7/8Q==
X-Gm-Message-State: AOAM530VjzoUr9eTWkHpRI8wND69awti4z/0TczMhqYIQ2nTqjrtJkqu
 hHDVgWvVDElHW/X9G+ANaQMwfIx03H0pYgFLdgw=
X-Google-Smtp-Source: ABdhPJxRUL2NtXaBcrbw9qO51GogwtGXRanKVPH9rPgvxZLWh+4bVXvnII1EnfN2XFfLh2LvLpWM1qXDj7U4zQvW69k=
X-Received: by 2002:adf:8462:: with SMTP id 89mr20989253wrf.420.1593514880833; 
 Tue, 30 Jun 2020 04:01:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 04:01:20
 -0700 (PDT)
In-Reply-To: <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 13:01:20 +0200
Message-ID: <CAHiYmc59Ahpii2dvhVD8EPK4qzc8y2RNTwTbp4L1d2Mjun+Phg@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000006a9dd205a94b188a"
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006a9dd205a94b188a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>
> wrote:
> >
> > On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> > >
> > >
> > > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., P=
hilippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> > > <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > >     Hi,
> > >
> > >     Following Jiaxun Yang's patch and discussion:
> > >     https://patchwork.kernel.org/patch/11416915/
> > >     <https://patchwork.kernel.org/patch/11416915/>
> > >
> > >     - Rename the current machine as 'malta-virt' (keeping 'malta'
> aliased)
> > >       Suggestions for better names are welcome, maybe 'malta-unreal' =
or
> > >       'malta-unleashed' instead?
> > >     - Add 'malta-phys' which respects hardware restrictions (on RAM s=
o
> far)
> > >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
> > >
> > >     Philippe Mathieu-Daud=C3=A9 (7):
> > >       hw/mips/malta: Trivial code movement
> > >       hw/mips/malta: Register the machine as a TypeInfo
> > >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
> > >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> > >       hw/mips/malta: Introduce the 'malta-phys' machine
> > >       hw/mips/malta: Verify malta-phys machine uses correct DIMM size=
s
> > >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
> > >
> > >      hw/mips/malta.c | 121 ++++++++++++++++++++++++++++++
> +++++++++---------
> > >      1 file changed, 99 insertions(+), 22 deletions(-)
> > >
> > >     --
> > >
> > >
> > >
> > > Thank you, Philippe, for providing this series.
> > >
> > > However, in previous discussion on the patch you mention above, I
> > > already expressed serious reservations on the approach taken in that
> > > patch. These reservations stay today too.
> > >
> > > There is nothing qualitatively different between the original patch a=
nd
> > > this series. Naming and related stuff are just cosmetic issues.
> >
> > OK, what about considering all patches except the last one?
> > So we can run firmware on a real Malta board, not the QEMU
> > imaginary one (in the discussion you said QEMU should respect
> > real hardware, which I agree).
> >
> > >
> > > The good thing about this series is that one can apply it dowstream, =
if
> > > one finds it useful. However, it is not suitable for upstreaming
>
> IOW, what is missing to have this series (except the last patch)
> accepted upstream?
>
>
It is not what is missing, but was already is in the series that makes it
not suitable for upstreaming. The very concept of the series is problematic=
.

Regards,
Aleksandar







> > >
> > > Regards,
> > > Aleksandar
> > >
> > >
> > >
> > >     2.21.3
> > >
>

--0000000000006a9dd205a94b188a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020.,=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Jun 30, 2020 at 12:=
52 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4=
bug@amsat.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 6/30/20 12:48 PM, Aleksandar Markovic wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020=
., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug=
@amsat.org</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>=
&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=
=B0:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Following Jiaxun Yang&#39;s patch and discussi=
on:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://patchwork.kernel.org/patch/=
11416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/114169=
15/</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patchwork.kernel.org/pa=
tch/11416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/11=
416915/</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- Rename the current machine as &#39;malta-vir=
t&#39; (keeping &#39;malta&#39; aliased)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Suggestions for better names are welcom=
e, maybe &#39;malta-unreal&#39; or<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;malta-unleashed&#39; instead?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- Add &#39;malta-phys&#39; which respects hard=
ware restrictions (on RAM so far)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- Unleash &#39;malta-virt&#39; to allow more t=
han 2GB on 64-bit<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9 (7):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Trivial code movement<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Register the machine as =
a TypeInfo<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Rename &#39;malta&#39; m=
achine as &#39;malta-virt&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Introduce MaltaMachineCl=
ass::max_ramsize<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Introduce the &#39;malta=
-phys&#39; machine<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Verify malta-phys machin=
e uses correct DIMM sizes<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: Allow more than 2GB on 6=
4-bit malta-virt<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 hw/mips/malta.c | 121 +++++++++++++++++++++++=
+++++++<wbr>+++++++++---------<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 1 file changed, 99 insertions(+), 22 deletion=
s(-)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thank you, Philippe, for providing this series.<br>
&gt; &gt;<br>
&gt; &gt; However, in previous discussion on the patch you mention above, I=
<br>
&gt; &gt; already expressed serious reservations on the approach taken in t=
hat<br>
&gt; &gt; patch. These reservations stay today too.<br>
&gt; &gt;<br>
&gt; &gt; There is nothing qualitatively different between the original pat=
ch and<br>
&gt; &gt; this series. Naming and related stuff are just cosmetic issues.<b=
r>
&gt;<br>
&gt; OK, what about considering all patches except the last one?<br>
&gt; So we can run firmware on a real Malta board, not the QEMU<br>
&gt; imaginary one (in the discussion you said QEMU should respect<br>
&gt; real hardware, which I agree).<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; The good thing about this series is that one can apply it dowstre=
am, if<br>
&gt; &gt; one finds it useful. However, it is not suitable for upstreaming<=
br>
<br>
IOW, what is missing to have this series (except the last patch)<br>
accepted upstream?<br>
<br></blockquote><div><br></div><div>It is not what is missing, but was alr=
eady is in the series that makes it not suitable for upstreaming. The very =
concept of the series is problematic.</div><div><br></div><div>Regards,</di=
v><div>Aleksandar</div><div><br></div><div><br></div><div><br></div><div><b=
r></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Aleksandar<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A02.21.3<br>
&gt; &gt;<br>
</blockquote>

--0000000000006a9dd205a94b188a--

