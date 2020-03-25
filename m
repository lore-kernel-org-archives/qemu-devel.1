Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD699C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862E820714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc1ZUuqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862E820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3vR-0005ti-N6
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jH3uN-00053A-F6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jH3uK-0006KZ-U9
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:09:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jH3uK-0006Jn-LL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:09:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id z5so1923120wml.5
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wmuu1RBoOaZapO8/fJKTI4jJVvI2d4wOve0iEmvFMF4=;
 b=jc1ZUuqfvRLwhN+jWDPBwlmDIdKIiLutpUv0QejG8setxVgQaNk7uSCBBjqlATUztf
 YtChJ90GB34wfKlJdndmP66XAm+TvF+maGGmnmKDTIGGZ9g2bb1837VNr/42tTB4ezba
 tbtelbgdzbGr6digv1A2+/DK8dWbE3a5wzXPBACJDJ7eHyyCcl785eKSUFMMuCPevXXO
 zZ+qWFaVDLzzesOOsqVeRGGNDjhcJ1/jsNcZrv3B9zBn+2XskFLoMFWviKEjJXprYkep
 WLjPHvQVEVFHyla7a5I1AqNGyzCSangAmquvQhywwiGjsLcev8H/Uew/DyHmN+wM+GjY
 3sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wmuu1RBoOaZapO8/fJKTI4jJVvI2d4wOve0iEmvFMF4=;
 b=DOBpZ2D6gdqV2JS9C54Vob3QOwdzuug0SIL0ZS8tBLcY1kZv2xz0fBuUOLmLkgKMPN
 aNLejv/EVTM91AmhswcBJK6tTcs8lMFPocLPoCtklz+HsxwoZ9dLnWgqgxX/GQdeRESO
 IcygBJdjmY1gO6RbF22eazBVP4LkLGQQwVigzdgsKjwntC7HOrAF3f8koTUywv1BTNKk
 4pVDjFp9VEKMrnHRbhxlI3fAdcnhh+Fm4RTS+yFKNRfhiP0PUz49Tea5o5deaVgKCzoU
 R+cdyvLEljA+xZS0AoHvajTgyBin54FnhIId9hIgAYBDC4N+mrI17GzQdzZCS66rFHCb
 clzg==
X-Gm-Message-State: ANhLgQ1BypGPsrRkhrb0S6YbBUUkDXuGbH6YwHck3koKp7yKTKtOKzHS
 CL4jZwaBplC0SdfiOc6QgF7JOxdsFoFXhpo3sGg=
X-Google-Smtp-Source: ADFU+vv0EV9zPrp2H7UfXno/jAVNPY/8vlEYPTl4THrwVxBzABUBV0IfIMTa5gjqRu03BLX3mN9vA3IVAtPm7+tMOVk=
X-Received: by 2002:a05:600c:2dd7:: with SMTP id
 e23mr2821342wmh.159.1585134550781; 
 Wed, 25 Mar 2020 04:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-7-alex.bennee@linaro.org>
 <20e5e10b-a2ac-06ed-edb4-5d4250c1775a@linaro.org>
 <CAHiYmc6G-RhqRxK7Dn2KAv3oN4yYy8HbiJbyHfTF-TKXgDbJmw@mail.gmail.com>
In-Reply-To: <CAHiYmc6G-RhqRxK7Dn2KAv3oN4yYy8HbiJbyHfTF-TKXgDbJmw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 25 Mar 2020 13:08:56 +0200
Message-ID: <CAHiYmc6rHnvpH9zrin04xMdHiAb7eXLhbvibLDBANfCVyoqP7Q@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] configure: disable MTTCG for MIPS guests
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d210d105a1abe5d6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d210d105a1abe5d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12:53 Sre, 25.03.2020. Aleksandar Markovic <aleksandar.qemu.devel@gmail.com=
>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> 20:17 Pon, 23.03.2020. Richard Henderson <richard.henderson@linaro.org>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
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
panic=3D-1" \
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
deviation)
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

Some trouble with text fi
mating - it should be:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Sorry about that.

> But, Alex, I expect this patch will go through your queue, not MIPS queue
(unless you told me otherwise).
>
> Thanks,
> Aleksandar
>
> >
> > r~

--000000000000d210d105a1abe5d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">12:53 Sre, 25.03.2020. Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&g=
t; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br=
>
&gt;<br>
&gt; 20:17 Pon, 23.03.2020. Richard Henderson &lt;<a href=3D"mailto:richard=
.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; On 3/23/20 9:15 AM, Alex Benn=C3=A9e wrote:<br>
&gt; &gt; &gt; While debugging check-acceptance failures I found an instabi=
lity in<br>
&gt; &gt; &gt; the mips64el test case. Briefly the test case:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0retry.py -n 100 -c -- ./mips64el-softmmu/qemu-sy=
stem-mips64el \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0-display none -vga none -serial mon:stdio=
 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0-machine malta -kernel ./vmlinux-4.7.0-rc=
1.I6400 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0-cpu I6400 -smp 8 -vga std \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0-append &quot;printk.time=3D0 clocksource=
=3DGIC console=3Dtty0 console=3DttyS0 panic=3D-1&quot; \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0--no-reboot<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Reports about a 9% failure rate:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0Results summary:<br>
&gt; &gt; &gt;=C2=A0 =C2=A00: 91 times (91.00%), avg time 5.547 (0.45 varie=
nce/0.67 deviation)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0-6: 9 times (9.00%), avg time 3.394 (0.02 varien=
ce/0.13 deviation)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Ran command 100 times, 91 passes<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; When re-run with &quot;--accel tcg,thread=3Dsingle&quot; the=
 instability goes<br>
&gt; &gt; &gt; away.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0Results summary:<br>
&gt; &gt; &gt;=C2=A0 =C2=A00: 100 times (100.00%), avg time 17.318 (249.76 =
varience/15.80 deviation)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Ran command 100 times, 100 passes<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Which seems to indicate there is some aspect of the MIPS MTT=
CG fixes<br>
&gt; &gt; &gt; that has been missed. Ideally we would fix that but I&#39;m =
afraid I don&#39;t<br>
&gt; &gt; &gt; have time to investigate and am not super familiar with the<=
br>
&gt; &gt; &gt; architecture anyway. In lieu of someone tracking down the fa=
ilure lets<br>
&gt; &gt; &gt; disable it for now.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.b=
ennee@linaro.org">alex.bennee@linaro.org</a>&gt;<br>
&gt; &gt; &gt; Acked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; &gt; &gt; Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qem=
u.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
&gt; &gt; &gt; Cc: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.ne=
t">aurelien@aurel32.net</a>&gt;<br>
&gt; &gt; &gt; Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikal=
o@rt-rk.com">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org">richard.henderson@linaro.org</a>&gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;aleksandar.qem <a href=3D"mailto:=
u.devel@gmail.com">u.devel@gmail.com</a>&gt;<br>
&gt;</p>
<p dir=3D"ltr">Some trouble with text fi<br>
mating - it should be:</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleks=
andar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;</p>
<p dir=3D"ltr">Sorry about that.</p>
<p dir=3D"ltr">&gt; But, Alex, I expect this patch will go through your que=
ue, not MIPS queue (unless you told me otherwise).<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Aleksandar<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; r~<br>
</p>

--000000000000d210d105a1abe5d6--

