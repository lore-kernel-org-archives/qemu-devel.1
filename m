Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F83AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E282076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRWFe7Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E282076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8Mi-00047p-JB
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francois.ozog@linaro.org>)
 id 1kY8LE-0003DG-Vo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:51:48 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:47081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francois.ozog@linaro.org>)
 id 1kY8LC-0001JW-H1
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:51:48 -0400
Received: by mail-lj1-x244.google.com with SMTP id 2so3119901ljj.13
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nJ7smN9h4w+RQLkvL/7YnTknBpJQaPkdOqf+xTeJpU4=;
 b=VRWFe7SvZPvnTHjm2fzpvMvFZzOBq15GduGXqhJ9lLH6YktmqXSu3slnWIXOAiLTgo
 JYIxLTNSit268zeneqU6p3JEuqo2w2u+6RY8chI6aJajslTDJjWdITY1i0l8lK6iEcPC
 1giHTVYd0XaPM9J9p1GQMZ0LaBpJ4SmDhkdJoQ0rFzu2HvPXkEn9grxKPEdWDIPVfE7F
 gcRRozEfAzSzrCDYXMUWEWzFAJj4EeqOxOW8oY5UnnN6UqH5UChzO2aT+9Fu2GTXKATv
 3AQz/9zvffRZWqjNemMlh3HDsyVuuvogijLGYzOn+EcDAV/Mgx4DYbZXg1B+XS5Y81fN
 AUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nJ7smN9h4w+RQLkvL/7YnTknBpJQaPkdOqf+xTeJpU4=;
 b=eAn9InVOMXzL6qza8pJdkA8i3vkN7z9a4eTyJWUbf/xHlu6yGXRxArFXQf/hsqQOek
 OnHsZbHsq0PaDh0/YmmqDSfSRs2YcxrvQJnYI2bKqi/BCaYDAXyiINpEczzDtQC7jbPh
 W73u8U7Mp/exQ5Dp/cqTSU/U2Z2G8kEQOK1QSVPFoQyFtqlFLKq3k8l0qgRCJRhyEi7a
 OqnCVJICdKgIHN3UW4fY/IQLYf0rTia3soQqCEmu4RZ1QU+i4U7fJhNCMmyoVEjxtMGd
 4oRrxwEognDYbIuoNABmmx2NAKIsIYcBVM/dwruw+cbbIVAcGfhs8dAkQ9EG8kadkGaT
 4osA==
X-Gm-Message-State: AOAM5322L7dQ6moTaT5pedRtzK3oIJKo3BK+cK5DjMgvl3IM7P+SPHaB
 MujaGBznRSZZTcIUpvVp87ACq+F27SwftxsFTvJVyA==
X-Google-Smtp-Source: ABdhPJxv0uM2c4uLONSCL3O5tC2g4n4+gQ+bYuZuPRrIt0AzPyVpQGysKY0aYp+E/YEGQBbXEYVAMdLKgo/8Nnnyh5E=
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr1912108lji.131.1603979502245; 
 Thu, 29 Oct 2020 06:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085918.14580-1-maxim.uvarov@linaro.org>
 <CAFEAcA8_1w=4qdE_AJxUP-uPoFL=Fsg9hy62Lw7bLDjKzL9Vvg@mail.gmail.com>
 <20201029111939.GI1664@vanye>
 <CAFEAcA8etCVD9QkG8+VNezF_5rX-CMVRV1tSjqwBT04yDvdM_Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8etCVD9QkG8+VNezF_5rX-CMVRV1tSjqwBT04yDvdM_Q@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>
Date: Thu, 29 Oct 2020 14:51:30 +0100
Message-ID: <CAHFG_=VggKS8x=GP9oX_hx2h5Fk6oo5391=dQvpznX39BpV1rg@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/virt: use sbsa-ec for reboot and poweroff in
 secure mode
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000756c4f05b2cf94f2"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=francois.ozog@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Maxim Uvarov <maxim.uvarov@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 QEMU Developers <qemu-devel@nongnu.org>, tf-a@lists.trustedfirmware.org,
 qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@arm.com>,
 Leif Lindholm <leif@nuviainc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000756c4f05b2cf94f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2020 at 12:26, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 29 Oct 2020 at 11:19, Leif Lindholm <leif@nuviainc.com> wrote:
> >
> > Hi Peter, (+Ard)
> >
> > Graeme is on holiday this week, and I would like his input.
>
> Sure. There's no rush here, as QEMU has just entered freeze for
> 5.2, so at the very earliest patches for this feature wouldn't go
> into master until mid-December.
>
> > On Wed, Oct 28, 2020 at 20:31:41 +0000, Peter Maydell wrote:
> > > A couple of notes on this patch if we do go down that route:
> > >  * we would need to arrange to only add the new device for
> > >    new versions of the virt board (that is, the "virt-5.0"
> > >    machine must not have this device because it must look
> > >    like the version of "virt" that shipped with QEMU 5.0)
> > >  * the device needs to be mapped into the Secure address
> > >    space only, because Secure firmware wants control over
> > >    it and doesn't want to allow NS code to reboot the system
> > >    without asking the firmware
> > >  * it would need to be described in the DTB (and maybe also
> > >    ACPI tables? I forget whether we need to describe Secure-only
> > >   devices there)
> >
> > Would it? Could it be something that goes into the virt spec?
> > We don't consume ACPI in firmware (but TF-A will of course have access
> > to the DT regardless).
>
> Well, for sbsa-ref it doesn't need to go into the DTB. For
> virt we mandate that everything is described in the DTB
> (and that secure firmware should consume the DTB to figure
> out where things live), so whatever power-control device we
> come up with would have to be described there. I'm less sure
> about ACPI because I think that is used only for describing
> the non-secure environment to the non-secure EL2/EL1 code
> so it doesn't need to describe devices that aren't visible there.
> But I'm not very familiar with ACPI, hence my uncertainty.
>
> > For sbsa-ref, I would ideally like to move to emulating communicating
> > with an SCP over time, as opposed to TF-A directly controlling the EC.
> > I am unsure if that leaves much opportunity for code sharing with
> > virt.
>
Arm SystemReady now defines BSA as the generic hardware requirements for
which S(erver)BSA is a special case. It feels like there are three use
cases driving three different QEMU platforms:
- virt =3D FW:{Qemu}, simple cloud native workloads,
- sbsa =3D HW:{watchdog, random number generator, secure flash, TPM, BMC?..=
.}
FW:{EDK2, KASLR, SecureBoot capabilities} --> developer vehicle for sbbr
- bsa =3D HW:{watchdog, random number generator, secure flash...}
FW:{U-boot,TF-A, OP-TEE, firmwareTPM} --> developer vehicle for ebbr, may
be automotive workloads to have virtual TAs/TPMs
I also think that ultimately SCP (
https://github.com/ARM-software/SCP-firmware) may end up running in the
context of QEMU.

>
> Yeah, that's the kind of complexity that we would want to avoid
> in 'virt', I think.
>
> thanks
> -- PMM
>


--=20
Fran=C3=A7ois-Fr=C3=A9d=C3=A9ric Ozog | *Director Linaro Edge & Fog Computi=
ng Group*
T: +33.67221.6485
francois.ozog@linaro.org | Skype: ffozog

--000000000000756c4f05b2cf94f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 29 Oct 2020 at 12:26, Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pe=
ter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Thu, 29 Oct 2020 at 11:19, Leif Lindholm &lt;<a hr=
ef=3D"mailto:leif@nuviainc.com" target=3D"_blank">leif@nuviainc.com</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; Hi Peter, (+Ard)<br>
&gt;<br>
&gt; Graeme is on holiday this week, and I would like his input.<br>
<br>
Sure. There&#39;s no rush here, as QEMU has just entered freeze for<br>
5.2, so at the very earliest patches for this feature wouldn&#39;t go<br>
into master until mid-December.<br>
<br>
&gt; On Wed, Oct 28, 2020 at 20:31:41 +0000, Peter Maydell wrote:<br>
&gt; &gt; A couple of notes on this patch if we do go down that route:<br>
&gt; &gt;=C2=A0 * we would need to arrange to only add the new device for<b=
r>
&gt; &gt;=C2=A0 =C2=A0 new versions of the virt board (that is, the &quot;v=
irt-5.0&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 machine must not have this device because it must lo=
ok<br>
&gt; &gt;=C2=A0 =C2=A0 like the version of &quot;virt&quot; that shipped wi=
th QEMU 5.0)<br>
&gt; &gt;=C2=A0 * the device needs to be mapped into the Secure address<br>
&gt; &gt;=C2=A0 =C2=A0 space only, because Secure firmware wants control ov=
er<br>
&gt; &gt;=C2=A0 =C2=A0 it and doesn&#39;t want to allow NS code to reboot t=
he system<br>
&gt; &gt;=C2=A0 =C2=A0 without asking the firmware<br>
&gt; &gt;=C2=A0 * it would need to be described in the DTB (and maybe also<=
br>
&gt; &gt;=C2=A0 =C2=A0 ACPI tables? I forget whether we need to describe Se=
cure-only<br>
&gt; &gt;=C2=A0 =C2=A0devices there)<br>
&gt;<br>
&gt; Would it? Could it be something that goes into the virt spec?<br>
&gt; We don&#39;t consume ACPI in firmware (but TF-A will of course have ac=
cess<br>
&gt; to the DT regardless).<br>
<br>
Well, for sbsa-ref it doesn&#39;t need to go into the DTB. For<br>
virt we mandate that everything is described in the DTB<br>
(and that secure firmware should consume the DTB to figure<br>
out where things live), so whatever power-control device we<br>
come up with would have to be described there. I&#39;m less sure<br>
about ACPI because I think that is used only for describing<br>
the non-secure environment to the non-secure EL2/EL1 code<br>
so it doesn&#39;t need to describe devices that aren&#39;t visible there.<b=
r>
But I&#39;m not very familiar with ACPI, hence my uncertainty.<br>
<br>
&gt; For sbsa-ref, I would ideally like to move to emulating communicating<=
br>
&gt; with an SCP over time, as opposed to TF-A directly controlling the EC.=
<br>
&gt; I am unsure if that leaves much opportunity for code sharing with<br>
&gt; virt.<br></blockquote><div>Arm SystemReady now defines BSA as the gene=
ric hardware requirements for which S(erver)BSA is a special=C2=A0case. It =
feels like there are three use cases driving three different QEMU platforms=
:</div><div>- virt =3D FW:{Qemu}, simple cloud native workloads, </div><div=
>- sbsa =3D HW:{watchdog, random number generator, secure flash, TPM, BMC?.=
..} FW:{EDK2, KASLR, SecureBoot capabilities} --&gt; developer vehicle for =
sbbr</div><div>- bsa =3D HW:{watchdog, random number generator, secure flas=
h...} FW:{U-boot,TF-A, OP-TEE, firmwareTPM} --&gt; developer=20

vehicle

for ebbr, may be automotive workloads to have virtual TAs/TPMs<br></div><di=
v>I also think that ultimately SCP (<a href=3D"https://github.com/ARM-softw=
are/SCP-firmware" target=3D"_blank">https://github.com/ARM-software/SCP-fir=
mware</a>) may end up running in the context of QEMU.</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
Yeah, that&#39;s the kind of complexity that we would want to avoid<br>
in &#39;virt&#39;, I think.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><table st=
yle=3D"font-size:small" border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><t=
body><tr><td style=3D"padding-right:10px" valign=3D"top"><img src=3D"https:=
//drive.google.com/a/linaro.org/uc?id=3D0BxTAygkus3RgQVhuNHMwUi1mYWc&amp;ex=
port=3Ddownload" width=3D"96" height=3D"53"></td><td valign=3D"top"><table =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td style=3D"fo=
nt-family:Arial,Helvetica,&quot;Sans Serif&quot;;white-space:nowrap;font-si=
ze:9pt;padding-top:0px;color:rgb(87,87,87)" valign=3D"top"><span style=3D"f=
ont-weight:bold">Fran=C3=A7ois-Fr=C3=A9d=C3=A9ric Ozog</span>=C2=A0<span st=
yle=3D"color:rgb(161,161,161)">|</span>=C2=A0<i>Director Linaro Edge &amp; =
Fog Computing Group</i></td></tr><tr><td style=3D"font-family:Arial,Helveti=
ca,&quot;Sans Serif&quot;;white-space:nowrap;font-size:9pt;padding-top:2px;=
color:rgb(87,87,87)" valign=3D"top">T:=C2=A0<a value=3D"+393384075993" styl=
e=3D"color:rgb(17,85,204)">+33.67221.6485</a><br><a href=3D"mailto:francois=
.ozog@linaro.org" style=3D"color:rgb(87,87,87);text-decoration:none" target=
=3D"_blank">francois.ozog@linaro.org</a>=C2=A0<span style=3D"color:rgb(161,=
161,161)">|</span>=C2=A0Skype:=C2=A0ffozog</td></tr></tbody></table></td></=
tr></tbody></table></div></div></div></div></div><div><div><br style=3D"fon=
t-size:small"></div></div></div></div></div></div></div></div></div></div><=
/div></div></div></div></div></div></div></div>

--000000000000756c4f05b2cf94f2--

