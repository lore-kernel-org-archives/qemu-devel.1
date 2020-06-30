Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2051C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA22C20780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+yOz/lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA22C20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDvW-0001Zi-TT
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqDuh-00010j-BV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:54:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqDuf-0004z8-Ed
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:54:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so8372334wrl.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=hFfzvXq347UavI0eMhGthPMJIUoF8CLcuEDmGIIAse8=;
 b=i+yOz/lwC4PxGIIjLepgs50PDKza8zkbJgmCveioYjPaqLPoiBz4PZXU2s2PP3BeLI
 RAf8+u4hnC0VaSszPfD+zqkd3y+2hz5gekBuTtOZ2rV4bAiqxPmySzLh8v0knjQNQAh1
 wKq/LyTArSpgU5Z3ynKilpE0Gth4Li9s5RqUZ2xkmD3vzlKSZ9oGZz2yc7OQjypcXV9e
 DmgevES3I+9P9SWgO/huM3pHs8HxzaI3MAQo9shIsNXv34hqiMqj0mEpO8CRWRt9+3LF
 IGQHSh3p7r8GmdMRIKp5cARZwOFE5efozP49XjG4/yK/zATR/st0HnITJ4gXZ+JgNEnV
 JijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=hFfzvXq347UavI0eMhGthPMJIUoF8CLcuEDmGIIAse8=;
 b=S54WQLtKJmiN0WxyKLEHdokkc9ohGjFIp89loPDtYLL2U1Gh2yB9Kq80WxzI0+mLDg
 c2dmsyTYeLkQWiNF7lLsY3vJWMYEx4IUio6UdKcblKrs4ymUD5NfE81pdOqSr8fotz2X
 S2EPA1DDSqREE6/PUfVCMZ6wPiDL21qM/Ex5XOVNCaXP/sOIHNxHOlq6iLc1XyjPjMsT
 tHnhJA9bKsnYCc7TKKaJZmQvVJNNCLrKF4M36RDx5l2aYNYdc5khxQAmp9Xma5BwBJke
 /z/NT38iKiUEdrpkpROCgl1xjXI0CBum7FUE01TyrFo1sU6RoprogmJXZbyQi6J3sOSC
 WAsQ==
X-Gm-Message-State: AOAM5302mFs4xjJkjoRPKHTx96y+FLbT0yMDeCi0Cq/OBQZHi3QLwEax
 YRhnSEiPB5+NDG0yzw6H5HEM6p/Ps2B495A0L/s=
X-Google-Smtp-Source: ABdhPJxTQ4tm9S+e8/2KZ5pKdeDqHVT/Po7y6SngHiS2HRLvJzmjQxkZzbwTNRbJm5oirrtIU5VQCtnbXx+PxKi0Qf8=
X-Received: by 2002:adf:a283:: with SMTP id s3mr19922216wra.147.1593514491850; 
 Tue, 30 Jun 2020 03:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 03:54:51
 -0700 (PDT)
In-Reply-To: <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 12:54:51 +0200
Message-ID: <CAHiYmc6gzvEAk6oNFzQHc9DrsZ6xfWZFKr6+FHVfus-jjcyp7Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000003b327d05a94b0112"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
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

--0000000000003b327d05a94b0112
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> >
> >
> > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Phi=
lippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> > <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >     Hi,
> >
> >     Following Jiaxun Yang's patch and discussion:
> >     https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>
> >
> >     - Rename the current machine as 'malta-virt' (keeping 'malta'
> aliased)
> >       Suggestions for better names are welcome, maybe 'malta-unreal' or
> >       'malta-unleashed' instead?
> >     - Add 'malta-phys' which respects hardware restrictions (on RAM so
> far)
> >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
> >
> >     Philippe Mathieu-Daud=C3=A9 (7):
> >       hw/mips/malta: Trivial code movement
> >       hw/mips/malta: Register the machine as a TypeInfo
> >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
> >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >       hw/mips/malta: Introduce the 'malta-phys' machine
> >       hw/mips/malta: Verify malta-phys machine uses correct DIMM sizes
> >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
> >
> >      hw/mips/malta.c | 121 ++++++++++++++++++++++++++++++
> +++++++++---------
> >      1 file changed, 99 insertions(+), 22 deletions(-)
> >
> >     --
> >
> >
> >
> > Thank you, Philippe, for providing this series.
> >
> > However, in previous discussion on the patch you mention above, I
> > already expressed serious reservations on the approach taken in that
> > patch. These reservations stay today too.
> >
> > There is nothing qualitatively different between the original patch and
> > this series. Naming and related stuff are just cosmetic issues.
>
> OK, what about considering all patches except the last one?
> So we can run firmware on a real Malta board, not the QEMU
> imaginary one (in the discussion you said QEMU should respect
> real hardware, which I agree).
>
>
Redo the series, and we can discuss, of course.


> >
> > The good thing about this series is that one can apply it dowstream, if
> > one finds it useful. However, it is not suitable for upstreaming
> >
> > Regards,
> > Aleksandar
> >
> >
> >
> >     2.21.3
> >
>

--0000000000003b327d05a94b0112
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020.,=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On 6/30/20 12:48 PM, Aleksa=
ndar Markovic wrote:<br>
&gt; <br>
&gt; <br>
&gt; =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsa=
t.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;&=
gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Following Jiaxun Yang&#39;s patch and discussion:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://patchwork.kernel.org/patch/11416=
915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/11416915/</=
a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patchwork.kernel.org/patch/1=
1416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/1141691=
5/</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- Rename the current machine as &#39;malta-virt&#39=
; (keeping &#39;malta&#39; aliased)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 Suggestions for better names are welcome, ma=
ybe &#39;malta-unreal&#39; or<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 &#39;malta-unleashed&#39; instead?<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Add &#39;malta-phys&#39; which respects hardware =
restrictions (on RAM so far)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Unleash &#39;malta-virt&#39; to allow more than 2=
GB on 64-bit<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9 (7):<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Trivial code movement<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Register the machine as a Typ=
eInfo<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Rename &#39;malta&#39; machin=
e as &#39;malta-virt&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Introduce MaltaMachineClass::=
max_ramsize<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Introduce the &#39;malta-phys=
&#39; machine<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Verify malta-phys machine use=
s correct DIMM sizes<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Allow more than 2GB on 64-bit=
 malta-virt<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/mips/malta.c | 121 +++++++++++++++++++++++=
+++++++<wbr>+++++++++---------<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 99 insertions(+), 22 deletion=
s(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--=C2=A0<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Thank you, Philippe, for providing this series.<br>
&gt; <br>
&gt; However, in previous discussion on the patch you mention above,=C2=A0I=
<br>
&gt; already expressed serious=C2=A0reservations on the=C2=A0approach taken=
 in that<br>
&gt; patch. These reservations stay today too.<br>
&gt; <br>
&gt; There is nothing qualitatively different between the original patch an=
d<br>
&gt; this series. Naming and related stuff are just cosmetic issues.<br>
<br>
OK, what about considering all patches except the last one?<br>
So we can run firmware on a real Malta board, not the QEMU<br>
imaginary one (in the discussion you said QEMU should respect<br>
real hardware, which I agree).<br>
<br></blockquote><div><br></div><div>Redo the series, and we can discuss, o=
f course.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; <br>
&gt; The good thing about this series is that one can apply it dowstream, i=
f<br>
&gt; one finds it useful. However, it is not suitable for upstreaming=C2=A0=
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Aleksandar<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A02.21.3<br>
&gt; <br>
</blockquote>

--0000000000003b327d05a94b0112--

