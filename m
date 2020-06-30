Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B543C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A232067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOxvk79F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A232067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqEGt-0001gK-0e
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqEGF-00011S-LA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:17:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqEGD-0000PY-He
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:17:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so18426875wmg.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qmYn5BjOeUL80Ms3MvqfvRHucEBTIfskCbetAqNATo4=;
 b=qOxvk79Fp6zde2z3w1o5F986LSFPG9Z+Zy1d4uqcOepQdN69g8bymb9pQIupOVsR+P
 0OLAxHQctnAqFjDM9ABdUKQWGOT0RhQufd4MOWjI1NVzt0aVPoi2owDGUCrsclhGblLs
 C/bARm3+H6TU4IHuCVnsR6kS9pWC6M9TWfC+aTacXckIr+UktVy/lW9E0RbjkM3Y7p40
 ck+5OzzYBE9Y9mCWgd/RSXn90kkbKOiNjSAxOcvOLwmYOOPcbR9K51YNoGkXcZhDxwFx
 BqGTUgeqfx2L1WvtYFs3HXwOhawxur6CKX7ZU3YSxaOqEAF7i0dw7BtirFvALy8BDVhj
 oKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qmYn5BjOeUL80Ms3MvqfvRHucEBTIfskCbetAqNATo4=;
 b=KYwMfjhUDgBRafBAnmNMCGRSIJtdXfdjHVk3LFuU+8uX7YIAbZ3ZYAaYyiybt0k7lf
 ICz1OE7MyqhP7g92GxXOBwLB8SeoLQmih+50NlZGYvEUKj/KBWN48OI9eybtjXJCltwN
 yw9OfFVZP2GEdhynbgyzTFMfWDQVtGs/zGo18fOcydmfthWXwpGn1ri2IiA2Pqqesvsd
 cHhN5N/6qn0I3WHWiJy1FWlwAfxas5F3U09go6VvsdC67rwi6nSZq1vwwASSu17c5WD8
 eJ90rQf+u6iF+hXRS3fvnsR3XzWuABVJgWUcP8qMa4sptv5KfF8NIdmi6s6B40ydMzM+
 W8BA==
X-Gm-Message-State: AOAM530kk+9Y9xY7uM9uHaROJPb3qXqZ1SpZzt+CDgpJX7ln3VKwOKxh
 2fZje9WEcMnGQVDpRDK5SDMY3tmjN4ji/4YdVRo=
X-Google-Smtp-Source: ABdhPJwPvhTgVcN7uWAzNaJlYsd0yLc2jLeux+rW2DQByhIlpe3MBo77rCnq0xKLk1loGa9pkqhjDlHaHlWIARi4eYE=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr22062431wmm.50.1593515827752; 
 Tue, 30 Jun 2020 04:17:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 04:17:07
 -0700 (PDT)
In-Reply-To: <3b75d15d-9195-bcd5-87aa-e243547552e5@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAAdtpL7MObRjk77ZFsNF4Xoghdj33mwufZ9s3L8fAC3XxkJCqA@mail.gmail.com>
 <CAHiYmc59Ahpii2dvhVD8EPK4qzc8y2RNTwTbp4L1d2Mjun+Phg@mail.gmail.com>
 <3b75d15d-9195-bcd5-87aa-e243547552e5@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 13:17:07 +0200
Message-ID: <CAHiYmc4NOrG-ETX_rLGGR=Cac_Q_hNfjAsS3mF6PpAFFjLDHGw@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000db726705a94b506c"
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

--000000000000db726705a94b506c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On 6/30/20 1:01 PM, Aleksandar Markovic wrote:
> >
> >
> > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Phi=
lippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> > <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >     On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-Daud=C3=A9
> >     <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
> >     >
> >     > On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> >     > >
> >     > >
> >     > > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 20=
20., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>
> >     > > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >     > >
> >     > >     Hi,
> >     > >
> >     > >     Following Jiaxun Yang's patch and discussion:
> >     > >     https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>
> >     > >     <https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>>
> >     > >
> >     > >     - Rename the current machine as 'malta-virt' (keeping
> >     'malta' aliased)
> >     > >       Suggestions for better names are welcome, maybe
> >     'malta-unreal' or
> >     > >       'malta-unleashed' instead?
> >     > >     - Add 'malta-phys' which respects hardware restrictions (on
> >     RAM so far)
> >     > >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
> >     > >
> >     > >     Philippe Mathieu-Daud=C3=A9 (7):
> >     > >       hw/mips/malta: Trivial code movement
> >     > >       hw/mips/malta: Register the machine as a TypeInfo
> >     > >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
> >     > >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >     > >       hw/mips/malta: Introduce the 'malta-phys' machine
> >     > >       hw/mips/malta: Verify malta-phys machine uses correct DIM=
M
> >     sizes
> >     > >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
> >     > >
> >     > >      hw/mips/malta.c | 121
> >     +++++++++++++++++++++++++++++++++++++++---------
> >     > >      1 file changed, 99 insertions(+), 22 deletions(-)
> >     > >
> >     > >     --
> >     > >
> >     > >
> >     > >
> >     > > Thank you, Philippe, for providing this series.
> >     > >
> >     > > However, in previous discussion on the patch you mention above,=
 I
> >     > > already expressed serious reservations on the approach taken in
> that
> >     > > patch. These reservations stay today too.
> >     > >
> >     > > There is nothing qualitatively different between the original
> >     patch and
> >     > > this series. Naming and related stuff are just cosmetic issues.
> >     >
> >     > OK, what about considering all patches except the last one?
> >     > So we can run firmware on a real Malta board, not the QEMU
> >     > imaginary one (in the discussion you said QEMU should respect
> >     > real hardware, which I agree).
> >     >
> >     > >
> >     > > The good thing about this series is that one can apply it
> >     dowstream, if
> >     > > one finds it useful. However, it is not suitable for upstreamin=
g
> >
> >     IOW, what is missing to have this series (except the last patch)
> >     accepted upstream?
> >
> >
> > It is not what is missing, but was already is in the series that makes
> > it not suitable for upstreaming. The very concept of the series is
> > problematic.
>
> What is the series is not suitable for upstream? Can you point to
> patch and code please? How would you conceptually resolve the
> problem?
>
>
The answer is already in the original thread on the original patch.

The problem is artificialy imposed:

One needs a feature not present in the physical system. The solution is not
in creating "virtual" upgrade - this violates the basic foundation if QEMU.

If the feature is missing, the optimal solution would be emulating the
physical solution that has that feature.

In some rare cases (that should be avoided as mush as possible), and for
really good reasons, we can create an emulation of some imagined hardware
that was never designed let alone built - there are a couple of examples in
other targets.

But extending the emulation of existing physical system with non-existing
features is not acceptable.

Hopefuly everything is clear now to you. :)

Regards,
Aleksandar



> >
> > Regards,
> > Aleksandar
> >
> >
> >
> >
> >
> >
> >
> >     > >
> >     > > Regards,
> >     > > Aleksandar
> >     > >
> >     > >
> >     > >
> >     > >     2.21.3
> >     > >
> >
>

--000000000000db726705a94b506c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020.,=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On 6/30/20 1:01 PM, Aleksan=
dar Markovic wrote:<br>
&gt; <br>
&gt; <br>
&gt; =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsa=
t.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;&=
gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Jun 30, 2020 at 12:52 PM Philippe Mathieu-D=
aud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.=
org</a> &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&g=
t;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On 6/30/20 12:48 PM, Aleksandar Markovic wrote=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30.=
 =D1=98=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:f4bug@amsat.org">f4bug@amsat.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug=
@amsat.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.=
org">f4bug@amsat.org</a> &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bu=
g@amsat.org</a>&gt;&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0Following Jiaxun Yang&=
#39;s patch and discussion:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://pat=
chwork.kernel.org/patch/11416915/" target=3D"_blank">https://patchwork.kern=
el.org/<wbr>patch/11416915/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patchwork.kernel.org/patch/1=
1416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/1141691=
5/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https:/=
/patchwork.kernel.org/patch/11416915/" target=3D"_blank">https://patchwork.=
kernel.<wbr>org/patch/11416915/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patchwork.kernel.org/patch/1=
1416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/1141691=
5/</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0- Rename the current m=
achine as &#39;malta-virt&#39; (keeping<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;malta&#39; aliased)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Suggestions for=
 better names are welcome, maybe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;malta-unreal&#39; or<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;malta-unle=
ashed&#39; instead?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0- Add &#39;malta-phys&=
#39; which respects hardware restrictions (on<br>
&gt;=C2=A0 =C2=A0 =C2=A0RAM so far)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0- Unleash &#39;malta-v=
irt&#39; to allow more than 2GB on 64-bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0Philippe Mathieu-Daud=
=C3=A9 (7):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Trivial code movement<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Register the machine as a TypeInfo<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Rename &#39;malta&#39; machine as &#39;malta-virt&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Introduce MaltaMachineClass::max_ramsize<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Introduce the &#39;malta-phys&#39; machine<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Verify malta-phys machine uses correct DIMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0sizes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/mips/malta: =
Allow more than 2GB on 64-bit malta-virt<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 hw/mips/malta.c | 121=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++++++<wbr>+++++++++-------=
--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 1 file changed, 99 in=
sertions(+), 22 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Thank you, Philippe, for providing this s=
eries.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; However, in previous discussion on the pa=
tch you mention above, I<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; already expressed serious reservations on=
 the approach taken in that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; patch. These reservations stay today too.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; There is nothing qualitatively different =
between the original<br>
&gt;=C2=A0 =C2=A0 =C2=A0patch and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; this series. Naming and related stuff are=
 just cosmetic issues.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; OK, what about considering all patches except =
the last one?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So we can run firmware on a real Malta board, =
not the QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; imaginary one (in the discussion you said QEMU=
 should respect<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; real hardware, which I agree).<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; The good thing about this series is that =
one can apply it<br>
&gt;=C2=A0 =C2=A0 =C2=A0dowstream, if<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; one finds it useful. However, it is not s=
uitable for upstreaming<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0IOW, what is missing to have this series (except th=
e last patch)<br>
&gt;=C2=A0 =C2=A0 =C2=A0accepted upstream?<br>
&gt; <br>
&gt; <br>
&gt; It is not what is missing, but was already is in the series that makes=
<br>
&gt; it not suitable for upstreaming. The very concept of the series is<br>
&gt; problematic.<br>
<br>
What is the series is not suitable for upstream? Can you point to<br>
patch and code please? How would you conceptually resolve the<br>
problem?<br>
<br></blockquote><div><br></div><div>The answer is already in the original =
thread on the original patch.</div><div><br></div><div>The problem is artif=
icialy imposed:</div><div><br></div><div>One needs a feature not present in=
 the physical system. The solution is not in creating &quot;virtual&quot; u=
pgrade - this violates the basic foundation if QEMU.</div><div><br></div><d=
iv>If the feature is missing, the optimal solution would be emulating the p=
hysical solution that has that feature.</div><div><br></div><div>In some ra=
re cases (that should be avoided as mush as possible), and for really good =
reasons, we can create an emulation of some imagined hardware that was neve=
r designed let alone built - there are a couple of examples in other target=
s.</div><div><br></div><div>But extending the emulation of existing physica=
l system with non-existing features is not acceptable.</div><div><br></div>=
<div>Hopefuly everything is clear now to you. :)</div><div><br></div><div>R=
egards,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
&gt; <br>
&gt; Regards,<br>
&gt; Aleksandar<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Aleksandar<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A02.21.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt; <br>
</blockquote>

--000000000000db726705a94b506c--

