Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E38C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 20:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E72D20409
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 20:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHu/QICP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E72D20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im1Ny-0007eT-Qf
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 15:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1im1NJ-000779-Lr
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1im1NH-0001WK-RY
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 15:10:49 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:42987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1im1NH-0001Vi-GB; Mon, 30 Dec 2019 15:10:47 -0500
Received: by mail-il1-x143.google.com with SMTP id t2so13339140ilq.9;
 Mon, 30 Dec 2019 12:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c5Otgqe1JRl3ZBdsNri3GHgmpT8tEdVyUo3kmz6/T+E=;
 b=nHu/QICPy38pKXiJytNHC3k9WAaRmuFm03T2mS1YS6hjm0tceRB8a+VfPZ0wd2liRF
 jjLQLaXbagB/Az4DRNX7Zak7YLuseHIrUmkA2kk5hXHncZckWilFoK8mAjWYkQnsZH8u
 v6TZnybijrVOFe8l7cM7lzihSmrTp9C9xS52hzR5OC4MoFVr3dXST933W0INdPOREiK/
 zwS7lXLFVNcG/q2dDCMKYLLf0xU4cH6jvjaS7ZvesxJj3jqxcUxiANcN38Ufv8oA/L49
 cnlW4Sq0BzpN0S0KR8+5HiwPLpRGPD2bCl6ZQuLs9flBlPPeN4GKYx4DblJ+cMbaObsl
 l87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c5Otgqe1JRl3ZBdsNri3GHgmpT8tEdVyUo3kmz6/T+E=;
 b=OUwg/yJxvtDuf/0dtcTSRg6Jeypw2bZcdti6JZybh5qHoFV76CR4Jm7jdaAHdqZUcv
 INwiiEua2V355Uod6bR4WnaZ+5Qab70+OXM+kEnY9QUgQspC7MhiHlw8/4s7KBICzqNQ
 rNKmqckWYKJM81FR8lFll6FYIqqE5X7CjuKqcSGhi0qCD3/QWfSIuTszULAUjqMrpACW
 XtY4qd6TGmudFM3qDa+vclJyiGbltRAadYdaJg31RUPwyVEVIdcIrmiMELbOIzopwb4Q
 36jg5HK+mDw1r/NdF5sBoXw68yVev38Hpi7hlu6w9oLBnMWS9/E+pKMZj0p4vfEu32b2
 6KEA==
X-Gm-Message-State: APjAAAUZFlrAzo55hDFSJUwwr9d6s+aNTf8Wvf7rxFhomSUEI4zH0TTh
 5ptwyI2j5KUIKjTDpQ/GSEM8q7v4wov2k2Ma/zs=
X-Google-Smtp-Source: APXvYqwWNYypmvf2xieWXZJPHdbhwYTQ0eFkR4W4S510235nkZJPeatnJa21ZYeFHrDZsW7NW2cN2NXdebWeMU7kHSw=
X-Received: by 2002:a92:7509:: with SMTP id q9mr36693120ilc.67.1577736646489; 
 Mon, 30 Dec 2019 12:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
 <9756419b-55bf-23a9-556a-d5bc5fb29331@redhat.com>
In-Reply-To: <9756419b-55bf-23a9-556a-d5bc5fb29331@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 30 Dec 2019 21:10:35 +0100
Message-ID: <CAPan3WrYAK+PFtFM7ZDCVsKLc_ksGxZeHEcwB9_FK=4v5p8h=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005cfd1c059af17074"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005cfd1c059af17074
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 3:56 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/30/19 12:28 PM, Niek Linnenbank wrote:
> > Hi,
> >
> > Here a short status report of this patch series.
>
> Good idea!
>
> >
> > For V3 update I already prepared the following:
> >   - reworked all review comments from Philippe, except:
> >     - patch#8: question for the SID, whether command-line override is
> > required (and how is the best way for machine-specific cli arg?) [1]
>
> Answered recently.
>
Thanks!

>
> > - added BootROM support, allows booting with only specifying -sd <IMG>
> > - added SDRAM controller driver, for U-Boot SPL
> > - added Allwinner generic RTC driver (for both Cubieboard and OrangePi
> > PC, supports sun4i, sun6i, sun7i)
> > - small fixes for EMAC
> >
> > My current TODO:
> >   - integrate Philips acceptance tests in the series
>
> You can queue them in your series, adding your Signed-off-by tag after
> mine. See:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#si=
gn-your-work-the-developer-s-certificate-of-origin
>
>    The sign-off is a simple line at the end of the explanation for the
> patch, which certifies that you wrote it or otherwise have the right to
> pass it on as an open-source patch.
>
> See point (c).
>
> Ah that certainly helps. I'll read that page.


> >   - integrate Philips work for generalizing the Allwinner timer, and
> > finish it
>
> We can also do that later, and get your work merged first.
>

Ok that sounds very good! Agreed, lets do the timer work later.


>
> >   - test and fix BSD targets (NetBSD, FreeBSD) [2, 3]
> >   - further generalize the series to cover very similar SoCs: H2+, H5
> >
> > Does anyone have more comments/requests for the V3 update?
> >
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.html
> > [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
> > [3]
> >
> https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dshow&redirect=
=3DFreeBSD%2Farm%2FAllwinner
>
>

--=20
Niek Linnenbank

--0000000000005cfd1c059af17074
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30, 2019 at 3:56 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 12/30/19 12:28 PM, Niek Linnenbank wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Here a short status report of this patch series.<br>
<br>
Good idea!<br>
<br>
&gt; <br>
&gt; For V3 update I already prepared the following:<br>
&gt;=C2=A0 =C2=A0- reworked all review comments from Philippe, except:<br>
&gt;=C2=A0 =C2=A0=C2=A0 - patch#8: question for the SID, whether command-li=
ne override is <br>
&gt; required (and how is the best way for machine-specific cli arg?) [1]<b=
r>
<br>
Answered recently.<br></blockquote><div>Thanks! <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; - added BootROM support, allows booting with only specifying -sd &lt;I=
MG&gt;<br>
&gt; - added SDRAM controller driver, for U-Boot SPL<br>
&gt; - added Allwinner generic RTC driver (for both Cubieboard and OrangePi=
 <br>
&gt; PC, supports sun4i, sun6i, sun7i)<br>
&gt; - small fixes for EMAC<br>
&gt; <br>
&gt; My current TODO:<br>
&gt;=C2=A0 =C2=A0- integrate Philips acceptance tests in the series<br>
<br>
You can queue them in your series, adding your Signed-off-by tag after <br>
mine. See:<br>
<a href=3D"https://www.kernel.org/doc/html/latest/process/submitting-patche=
s.html#sign-your-work-the-developer-s-certificate-of-origin" rel=3D"norefer=
rer" target=3D"_blank">https://www.kernel.org/doc/html/latest/process/submi=
tting-patches.html#sign-your-work-the-developer-s-certificate-of-origin</a>=
<br>
<br>
=C2=A0 =C2=A0The sign-off is a simple line at the end of the explanation fo=
r the <br>
patch, which certifies that you wrote it or otherwise have the right to <br=
>
pass it on as an open-source patch.<br>
<br>
See point (c).<br>
<br></blockquote><div>Ah that certainly helps. I&#39;ll read that page.<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0- integrate Philips work for generalizing the Allwinner ti=
mer, and <br>
&gt; finish it<br>
<br>
We can also do that later, and get your work merged first.<br></blockquote>=
<div><br></div><div>Ok that sounds very good! Agreed, lets do the timer wor=
k later.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt;=C2=A0 =C2=A0- test and fix BSD targets (NetBSD, FreeBSD) [2, 3]<br>
&gt;=C2=A0 =C2=A0- further generalize the series to cover very similar SoCs=
: H2+, H5<br>
&gt; <br>
&gt; Does anyone have more comments/requests for the V3 update?<br>
&gt; <br>
&gt; [1] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/m=
sg04049.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2019-12/msg04049.html</a><br>
&gt; [2] <a href=3D"https://wiki.netbsd.org/ports/evbarm/allwinner/" rel=3D=
"noreferrer" target=3D"_blank">https://wiki.netbsd.org/ports/evbarm/allwinn=
er/</a><br>
&gt; [3] <br>
&gt; <a href=3D"https://wiki.freebsd.org/action/show/arm/Allwinner?action=
=3Dshow&amp;redirect=3DFreeBSD%2Farm%2FAllwinner" rel=3D"noreferrer" target=
=3D"_blank">https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dsho=
w&amp;redirect=3DFreeBSD%2Farm%2FAllwinner</a><br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000005cfd1c059af17074--

