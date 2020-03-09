Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5998C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B674F24649
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgdk4T88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B674F24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPKi-00054z-O0
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBPJf-0003mb-Lv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBPJe-0003Tg-C0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:47:59 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f]:35411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBPJe-0003TI-77; Mon, 09 Mar 2020 16:47:58 -0400
Received: by mail-il1-x12f.google.com with SMTP id g126so10023498ilh.2;
 Mon, 09 Mar 2020 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ClDmCOXkIqwUS0OK+foMTDvWaVdbjsZ1J3i3yHgwa4Y=;
 b=Mgdk4T88XigrkH2+AnADnu4SOCuUfl5/mU4s1Mg1bDbl2A1ZOtGJJ4d2V3wEFwNR85
 mjAYHktatIYlqbaEw54Peh8C/dXfokJ5/VImGWB3wyrooxt9KosIQKJSRt3/6oeUJmIw
 LenvpvthLOVwyZRPjazsncPigLETqNA+sV8Jhg+AXWgcFeK5eihXelUcJykTMnKJp5rA
 00eRuXFh+qrdZ4ujc8GUujymLHw076jbh7eCaDwOldecNHRs6zVQqs9HmtUQ4WzglFI0
 FmfEi2ZL2r4jZJPxyCnuR1cCVCdWLXd1B3PNCU6IepY7afOYaC8G24N5eWCJsSLtOubX
 s1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ClDmCOXkIqwUS0OK+foMTDvWaVdbjsZ1J3i3yHgwa4Y=;
 b=htdwSQYwGyV6/kqLn5e0f7d0MDmRC8wYEZM0wEy7rghuW8HmSlwKLY4TD28uuVEzDY
 t3IEwG2yzYBRN0qQfio/t39O1uhHsu/ZaVxIJVyiY54VAqmTbN385Daly5ReLN1Iz/kQ
 T0eAYTJX325t8iQSznfip11WPpYSn77hMDX0fryGZ2iKiak+0hvCt33x67nQTZVGLFZS
 CDw4k+tqOdjp53dTAHAvyTfHlMk+5V74jICJRNcPuX9vSCPpDS5pfJD/r782g13Z8gz7
 sP72eA5gLH3G7oSnKeIV2n8ebQFRJc7PlxxpdmBDVkCbe7hfUlAYO7+9YJ7RM2nqnvvM
 X7bQ==
X-Gm-Message-State: ANhLgQ3nMQGciQybCGDiPZHYi8xuU4PvwZmdC9pgA9kyzTMVNtAV7Qvh
 pM7HWY1ksNrB+rUZJiDqpv77jgtjl+19c6tI9Ik=
X-Google-Smtp-Source: ADFU+vvbd4JGzatVFvHKi91xnfeFyS3z8obA05VJncM1wvffC1cqudEVIcxc6jFFBsODveCbcHMal5PfYFwlfyF06FA=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr2760951ilh.265.1583786877495; 
 Mon, 09 Mar 2020 13:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
 <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
 <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
 <CAPan3Wr-oS-QRxmCDPXLRBG81yqjnp56B2WNuxtBMOxr2b9D6A@mail.gmail.com>
 <CAFEAcA_rY1hXNbzsj6EJvKzODX_EWdTOK1Gfxi2Jbv+UsYxRtQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_rY1hXNbzsj6EJvKzODX_EWdTOK1Gfxi2Jbv+UsYxRtQ@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 9 Mar 2020 21:47:46 +0100
Message-ID: <CAPan3Wq8GZWRrKo3tBuz+jqttSTg_qeW7AfJEBLMasjBROOF1w@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003baf6305a0721ea3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12f
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003baf6305a0721ea3
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 9, 2020 at 9:12 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 9 Mar 2020 at 20:05, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> > Ah now I see what is going on here. So the new rst files are ment to
> automatically generate
> > documentation in various formats using the Python sphinx tool, correct?
>
> Yep. Assuming you have Sphinx installed, "make" should build the
> documentation as well as the executables (ie you don't need
> specifically 'make html').
>
> > I played around a bit with running 'make html' and using the include
> directive you suggested in
> > the target-arm.rst file like:
> >
> >   .. include:: orangepi.rst
>
> I'm currently writing a patchset which splits the existing
> target-arm.rst into a bunch of per-board files in
> docs/system/arm/. If that patchset goes in before you
> roll the next verison of the series then it should
> just be a matter of putting orangepi.rst in the
> docs/system/arm/ directory and adding a line to the
> table-of-contents in docs/system/target-arm.rst.
>

Ah yes, that makes sense indeed. I'll keep an eye out for your new patchset.


> If you're ready to send out the next version before that,
> then leave it with the include:: directive and we can
> fix it up to the new structure later.
>

OK Peter!

Regards,
Niek



> thanks
> -- PMM
>


-- 
Niek Linnenbank

--0000000000003baf6305a0721ea3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 at 9:12 PM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Mon, 9 Mar 2020 at 20:05, Niek Linnenbank &lt;<a href=3D"mailto:nie=
klinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; w=
rote:<br>
&gt; Ah now I see what is going on here. So the new rst files are ment to a=
utomatically generate<br>
&gt; documentation in various formats using the Python sphinx tool, correct=
?<br>
<br>
Yep. Assuming you have Sphinx installed, &quot;make&quot; should build the<=
br>
documentation as well as the executables (ie you don&#39;t need<br>
specifically &#39;make html&#39;).<br>
<br>
&gt; I played around a bit with running &#39;make html&#39; and using the i=
nclude directive you suggested in<br>
&gt; the target-arm.rst file like:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0.. include:: orangepi.rst<br>
<br>
I&#39;m currently writing a patchset which splits the existing<br>
target-arm.rst into a bunch of per-board files in<br>
docs/system/arm/. If that patchset goes in before you<br>
roll the next verison of the series then it should<br>
just be a matter of putting orangepi.rst in the<br>
docs/system/arm/ directory and adding a line to the<br>
table-of-contents in docs/system/target-arm.rst.<br></blockquote><div><br><=
/div><div>Ah yes, that makes sense indeed. I&#39;ll keep an eye out for you=
r new patchset.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
If you&#39;re ready to send out the next version before that,<br>
then leave it with the include:: directive and we can<br>
fix it up to the new structure later.<br></blockquote><div><br></div><div>O=
K Peter!<br></div><div>=C2=A0</div><div>Regards,</div><div>Niek<br></div><d=
iv><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000003baf6305a0721ea3--

