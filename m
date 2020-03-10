Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2D5C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCDF2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTlRPsz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCDF2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVNq-0004cu-Kz
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jBVMx-0004CP-Fl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jBVMv-0002I9-UQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:15:47 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:44987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jBVMv-0002GT-ND
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:15:45 -0400
Received: by mail-io1-xd36.google.com with SMTP id t26so3600067ios.11
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 20:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ow/cd16mXfpNZkZ671++vaYNzM+kAsm72/SrMXWhARI=;
 b=mTlRPsz7t+u4eDFqe447JM0GjlyzYpEFblYOlrDSKcld/FvxDUI6PLkyIdPiLGVVf5
 TaIuhEa9yA0fEvnou9VfV5bVVuXdzfsv2PgdFTgA530VtKbQknkQKodVPy9Bi7UM1HDv
 4dprFrQRdNzQ8WrA8+lnk3TAwqfbEyUIW8Pjr83cVbfPQLtDOD6Xw1YqVif3OROYAW5M
 NUk0xImb3Lkr6p7hulGa7Hwj3fwQrrUhaEH5DH+rcEG7i/gaEh37s/69eZvi1Y3QR0k6
 m90vb5wVPl0ZDqE7CBLK6yGQE/9uPC/fQ10LHD4UD1wcVxzequLQt5aFLnIyJQZY4mBV
 ijEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ow/cd16mXfpNZkZ671++vaYNzM+kAsm72/SrMXWhARI=;
 b=DSGq0IpJKwkqggU2yumbaC23QII0fYzEEliTXYkhl5bbaE5rb7I24j7y9kYWE2/Bjc
 K1ngEEUWM1UP8LI/kwMFDKvSVitxSgriMcwmqAIn0fU3jXzLxfchjls6lH1qgy/oa6ng
 Qa4+7SP1EN40lsnRn3I7pmhfcgynhEpwG8goaRczbfMwVtfDJqx0vZPnxvbr5d9rtAgJ
 LBMC3XmV2bjOhomCnltS24T+A+4v/Xs2VzeBQwjAE+MS0FTHYzga/0b0CoJmDEl0kmYI
 EcsJQWoiI/VF6VkhuVUwfFISfJ2shkTQN61BFBOtZt6erFguco44SkwNIHaFpdFCoSfS
 UVKg==
X-Gm-Message-State: ANhLgQ0DVvPt3y08/vpVj6qeIRDKjsR/Cvbq5P4Vfu6G7A1ikwgGr1R9
 P7hXL0JwK42z8PnUpSLQAv1GxHRMJP+iTp5MAdg=
X-Google-Smtp-Source: ADFU+vsCtGA7Bs5j9iBZvTZHHyTyCVWyXCKLOUui4pYsE2vxpD/Gf/6sP67jM3oHFl0Z3irWXrls7iQVzszgKGEFEMU=
X-Received: by 2002:a6b:f118:: with SMTP id e24mr5033019iog.54.1583810144600; 
 Mon, 09 Mar 2020 20:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO79s5ZTWrvheAu=XHrVQO0O_RxLu9LD9=B=k982c8_mC6g@mail.gmail.com>
 <a3d88162-abb1-d770-0222-dec576bbdb6a@redhat.com>
In-Reply-To: <a3d88162-abb1-d770-0222-dec576bbdb6a@redhat.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 9 Mar 2020 20:15:33 -0700
Message-ID: <CADBGO7-O7=nZVH1Zm8Fi08KBJK8rhCLQJsNeXzv4va+o+3ViKA@mail.gmail.com>
Subject: Re: Any interest in dwc-otg (aka dwc2) device emulation? For Raspi 3
 and below.
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000f87a005a0778979"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000f87a005a0778979
Content-Type: text/plain; charset="UTF-8"

Hi John,

Thanks for the tips! I found an issue when testing with the usb-storage
device, so I will work on fixing that, and then think about how best to
split up the patches.

Thanks,
Paul

On Mon, Mar 9, 2020 at 7:23 PM John Snow <jsnow@redhat.com> wrote:

>
>
> On 3/6/20 7:34 PM, Paul Zimmerman wrote:
> > Hi Folks,
> >
> > I have been working on an emulation of the dwc-otg USB controller
> > (host mode only for now), as implemented on the Raspberry Pi 3 and
> > below, and on numerous other embedded platforms. I have it to a point
> > where it works pretty well with the dwc2 driver in the mainline Linux
> > kernel, and with the dwc-otg driver in the Raspbian kernel. Mouse and
> > keyboard work fine, and I *think* the usb-net device is working too,
> > although I have been unsuccessful in connecting to the outside world
> > with it.
> >
> > I haven't done anything with gadget-mode yet, but that could certainly
> > be added in the future.
> >
> > Would there be any interest in me submitting this for inclusion in
> > Qemu? I ask because I see there was a previous effort at this at
> > github.com/0xabu/qemu/hw/usb/bcm2835_usb.c, but it seems it never went
> > anywhere.
> >
> > Thanks,
> > Paul
> >
>
> At a minimum, I think you should send your patches to the list for
> posterity even if they don't wind up getting enough review pressure to
> be merged.
>
> If you want advice on how to split up your patches to entice more
> reviewers, please let us know and any one of us can write a thousand
> more :words: that might help make a better case.
>
> (There's a much-too-long wiki entry on the matter, if you are brave.)
>
> The issue, as always, is usually just reviewer time -- and how squeaky
> the wheel is. Making the patches look pretty and well organized is one
> way to trick well meaning people into reviewing your patches.
>
> --js
>
>

--0000000000000f87a005a0778979
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto">Hi John,</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks for the tips! I found an issue when testing with the usb-s=
torage device, so I will work on fixing that, and then think about how best=
 to split up the patches.</div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks,</div><div dir=3D"auto">Paul</div><div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 at 7:=
23 PM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 3/6/20 7:34 PM, Paul Zimmerman wrote:<br>
&gt; Hi Folks,<br>
&gt; <br>
&gt; I have been working on an emulation of the dwc-otg USB controller<br>
&gt; (host mode only for now), as implemented on the Raspberry Pi 3 and<br>
&gt; below, and on numerous other embedded platforms. I have it to a point<=
br>
&gt; where it works pretty well with the dwc2 driver in the mainline Linux<=
br>
&gt; kernel, and with the dwc-otg driver in the Raspbian kernel. Mouse and<=
br>
&gt; keyboard work fine, and I *think* the usb-net device is working too,<b=
r>
&gt; although I have been unsuccessful in connecting to the outside world<b=
r>
&gt; with it.<br>
&gt; <br>
&gt; I haven&#39;t done anything with gadget-mode yet, but that could certa=
inly<br>
&gt; be added in the future.<br>
&gt; <br>
&gt; Would there be any interest in me submitting this for inclusion in<br>
&gt; Qemu? I ask because I see there was a previous effort at this at<br>
&gt; <a href=3D"http://github.com/0xabu/qemu/hw/usb/bcm2835_usb.c" rel=3D"n=
oreferrer" target=3D"_blank">github.com/0xabu/qemu/hw/usb/bcm2835_usb.c</a>=
, but it seems it never went<br>
&gt; anywhere.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Paul<br>
&gt; <br>
<br>
At a minimum, I think you should send your patches to the list for<br>
posterity even if they don&#39;t wind up getting enough review pressure to<=
br>
be merged.<br>
<br>
If you want advice on how to split up your patches to entice more<br>
reviewers, please let us know and any one of us can write a thousand<br>
more :words: that might help make a better case.<br>
<br>
(There&#39;s a much-too-long wiki entry on the matter, if you are brave.)<b=
r>
<br>
The issue, as always, is usually just reviewer time -- and how squeaky<br>
the wheel is. Making the patches look pretty and well organized is one<br>
way to trick well meaning people into reviewing your patches.<br>
<br>
--js<br>
<br>
</blockquote></div></div>

--0000000000000f87a005a0778979--

