Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A925CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7517123750
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8b47lae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517123750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqYT-00047i-GY
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpqWZ-0001fv-4C
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:56:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpqWX-0003fA-8q
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:56:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id a6so15894113wrm.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Xxe4Ln+IUmqpCvcqnHLYESLIygJO2ZbhKQyXoOjRicA=;
 b=o8b47laebUZ7tsrUC2Sr08bQDxhu4Oo0CLX0ikuVsF25R6EOsXLoQGuYVof+syompB
 bkjIYNbwdtWYu0O/GIK+Mqkwe9H95EDG+/BZx6VaaGpLIb6/LPth5EMq/BUiXOlPcCM7
 Uac8jF7BD45uf5nV6aXm+TuQNG5CfP44Cp1AItEwCB1ZLCb1mLteuRvUTunIgTnVg2su
 iC9V/uqXe5BuJLZKtY9HakhBd3vJ7uJYlCkReWFalRL1eOFEC+R9TfsmEToGtWgjGx9J
 7nbAnYSaBGrYgHFQPjVQ4ttQe3+H7Eqa0ltAUsNnwAcQNuMNjXvuVb5sgBsVwG3Nv5qv
 kxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Xxe4Ln+IUmqpCvcqnHLYESLIygJO2ZbhKQyXoOjRicA=;
 b=pWxn9IEgGr1nhs0ZGmhGuFswmaRFHtCWAqddeULEhQKYUPyI/62KOrstBRE7uTywHb
 7s0UKsCtFOpK5+wP24QSBn2Gn7iea2GZvQwMuKwEf40/byT2rJmkT6kcSfjy3gbDbYb9
 HyacCAMg1lgVOsNhGGx0RknDoWbUTQuV+3iY/EpQyHDH5JA6nr/xj7wM08omKLP2h6d4
 9E35S50nyEBOcC7hpdEdzXv3SP7qmEtSACQIpVNg8yKVlpX6ApYsboNUcDThMGbI+DSz
 3uRLyjlIYFkdKxkhxdslkSJruEv7pD4mGKGuAsYUHSrcIrqGcvtd2wcA1KOyqqLSVg4k
 4YJg==
X-Gm-Message-State: AOAM532NqHtlDQOqydiyDyyYQ4CT5UTeQ0LTqF82fTo6qZmu/akD1LLp
 0Un/k6/XYUYP3ESKZrzb641N4bAkzUnQcdgj8OI=
X-Google-Smtp-Source: ABdhPJywwvBDRKwUHpSd2V2DZ5NBi0U43IbxJHU773Y0cS3MOwjKY4bTM4XkN+Lt9OP/6oazEO9EeNXmOR53RcvGPzM=
X-Received: by 2002:adf:8462:: with SMTP id 89mr16007849wrf.420.1593424583385; 
 Mon, 29 Jun 2020 02:56:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Mon, 29 Jun 2020 02:56:23
 -0700 (PDT)
In-Reply-To: <362d8118-93c9-d020-90ba-7ddbd8ad446d@amsat.org>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-4-git-send-email-aleksandar.qemu.devel@gmail.com>
 <362d8118-93c9-d020-90ba-7ddbd8ad446d@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 29 Jun 2020 11:56:23 +0200
Message-ID: <CAHiYmc5dGWU+iQezH=AqiEV4kxoxSa4iOcjORPX2vMheyC_z+Q@mail.gmail.com>
Subject: Re: [PULL 3/6] MAINTAINERS: Add Loongson-3 maintainer and reviewer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000044e6f705a936122e"
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000044e6f705a936122e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=D1=83=D0=
=BD 2020., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
> > From: Huacai Chen <zltjiangshi@gmail.com>
> >
> > Add myself as the maintainer for Loongson-3 virtual platforms, and
> > also add Jiaxun Yang as the reviewer.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Message-Id: <1592995531-32600-5-git-send-email-chenhc@lemote.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1b40446..fe925ea 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1096,6 +1096,13 @@ F: hw/isa/vt82c686.c
> >  F: hw/pci-host/bonito.c
> >  F: include/hw/isa/vt82c686.h
> >
> > +Loongson-3 Virtual Platform
> > +M: Huacai Chen <chenhc@lemote.com>
> > +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > +S: Maintained
> > +F: hw/mips/loongson3_virt.c
>
> This file has not been commited, is this pull request incomplete?
>
> > +F: hw/intc/loongson_liointc.c
>
>
This line, in this patch, was my mistake. I did delete the line, but forgot
to do "git add MAINTAINERS". So, the deletion happened in the next patch
dealing with MAINTAINERS.

So, my bad. An honest mistake. I apoligize.

However, the final outcome of the pull request is 100% as desired, and as I
informed other in my responses to patches.  No need to do any follow ups.

How can we test this device?
>
>
Please read the commit message of patch 3/4 of Huacai's recent series v6.


> > +
> >  Boston
> >  M: Paul Burton <pburton@wavecomp.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> >
>
>

--00000000000044e6f705a936122e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=
=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 6/27/=
20 9:51 PM, Aleksandar Markovic wrote:<br>
&gt; From: Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjian=
gshi@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Add myself as the maintainer for Loongson-3 virtual platforms, and<br>
&gt; also add Jiaxun Yang as the reviewer.<br>
&gt; <br>
&gt; Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">ch=
enhc@lemote.com</a>&gt;<br>
&gt; Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat=
.com">jiaxun.yang@flygoat.com</a>&gt;<br>
&gt; Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu=
.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qe=
mu.devel@gmail.com">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:1592995531-32600-5-git-send-email-ch=
enhc@lemote.com">1592995531-32600-5-git-send-<wbr>email-chenhc@lemote.com</=
a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS | 7 +++++++<br>
&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 1b40446..fe925ea 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -1096,6 +1096,13 @@ F: hw/isa/vt82c686.c<br>
&gt;=C2=A0 F: hw/pci-host/bonito.c<br>
&gt;=C2=A0 F: include/hw/isa/vt82c686.h<br>
&gt;=C2=A0 <br>
&gt; +Loongson-3 Virtual Platform<br>
&gt; +M: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote=
.com</a>&gt;<br>
&gt; +R: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com">jiaxun.=
yang@flygoat.com</a>&gt;<br>
&gt; +S: Maintained<br>
&gt; +F: hw/mips/loongson3_virt.c<br>
<br>
This file has not been commited, is this pull request incomplete?<br>
<br>
&gt; +F: hw/intc/loongson_liointc.c<br>
<br></blockquote><div><br></div><div>This line, in this patch, was my mista=
ke. I did delete the line, but forgot to do &quot;git add MAINTAINERS&quot;=
. So, the deletion happened in the next patch dealing with MAINTAINERS.</di=
v><div><br></div><div>So, my bad. An honest mistake. I apoligize.</div><div=
><br></div><div>However, the final outcome of the pull request is 100% as d=
esired, and as I informed other in my responses to patches.=C2=A0 No need t=
o do any follow ups.</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
How can we test this device?<br>
<br></blockquote><div><br></div><div>Please read the commit message of patc=
h 3/4 of Huacai&#39;s recent series v6.</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
&gt; +<br>
&gt;=C2=A0 Boston<br>
&gt;=C2=A0 M: Paul Burton &lt;<a href=3D"mailto:pburton@wavecomp.com">pburt=
on@wavecomp.com</a>&gt;<br>
&gt;=C2=A0 R: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@syr=
mia.com">aleksandar.rikalo@syrmia.com</a>&gt;<br>
&gt; <br>
<br>
</blockquote>

--00000000000044e6f705a936122e--

