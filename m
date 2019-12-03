Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBFCC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1585120659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojQQysND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1585120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEsY-0004s8-4a
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icDuq-0005oM-LK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icDuk-0006b4-W4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:32:54 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1icDuk-0005gv-OG; Tue, 03 Dec 2019 14:32:50 -0500
Received: by mail-io1-xd41.google.com with SMTP id v18so5132952iol.2;
 Tue, 03 Dec 2019 11:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t5NL6mvqL5yVtcAOIAakNXXJi3byViXFQ5xzYZoL4+I=;
 b=ojQQysNDES/TTydF1eJA4NfyZk9a5YxTrlS79/TE6LG88x+Pj+gHEqZx3vGw4hBOk6
 aq4w2M3c1H7TFh6CpwIoBWqm39hRW5coOzjigf0eS1cRvdCsrMAYKIeK8JYl96mqQcWa
 H92eI04IQL4rF56pAUnOqfcVJsjNVHyua7whr0K3edERJVNjMuV1pFzQIKCQDxv2A48d
 y5TkVA9QNY7T/gF74Cd8CP+wJ3pqtTkqz8e1CTRfKxbV3bnmNFBIk/vgUnAfsf9TnEwl
 EssJ+wZEDLOcY5RJUkaUIWJ8JWYKkhjEIerASifQUQIi1bgxCewp28UKJuzEWS43NAKk
 ziMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t5NL6mvqL5yVtcAOIAakNXXJi3byViXFQ5xzYZoL4+I=;
 b=Xmupn/OhoBfdFbpceVSCw7OUVBZGRtfaz0/EdgnnRLeI24uvKft5XIRjYLQhty8h26
 2F86gN51UJ1iNTvXfZWvzM3Dp9cPyO9xyEaHMGArNpJQCbAqKqLRrNqEA+0hybEJeEv8
 fPstmrfayyprE6saWXsaAeQyHl2L/NTecWViTdGRNxsIHva/8RlbYgXvKovRJIWUvN7E
 KCKJa5zIqpeXXKRJcogTliNbEqk+nM1o55K6inytGCJ+7HaRfeWq+hVfzghcv+o4eA+6
 HhrM/aIJEXhupoz7D8DuUQUUnbyPYbjVK8edgTLcqLE/KViBkKthIx4nPjVcDdNj6G1K
 dzfw==
X-Gm-Message-State: APjAAAUsSBXrNJey5CKWGiSCJqeszcAg1fPcIkSGx8tFXk8hOBC6JOG3
 8tFdwTupDQkYsb1DmuRod9CrHiTtta8Qt3+1oNo=
X-Google-Smtp-Source: APXvYqx30guA7t3cMMjPaIYO+QxahhhX7rqGqPpnkPh6g6mptrkQWojaM2awR2uSw7uJpfN/s/6bCz6oIhk6y+TK/0g=
X-Received: by 2002:a5d:8f17:: with SMTP id f23mr3577178iof.265.1575401558814; 
 Tue, 03 Dec 2019 11:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <1de57227-8124-4d11-d996-9faf67b3e4f3@redhat.com>
In-Reply-To: <1de57227-8124-4d11-d996-9faf67b3e4f3@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 3 Dec 2019 20:32:27 +0100
Message-ID: <CAPan3WrNDoLjmEETAQHa2GmG70yP3TzPnJqzQLK_t+m7CV+ONw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004ab92a0598d1c28d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Niccol=C3=B2_Izzo?= <izzoniccolo@gmail.com>, b.galvani@gmail.com,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004ab92a0598d1c28d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

On Tue, Dec 3, 2019 at 10:02 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > Dear QEMU developers,
> >
> > Hereby I would like to contribute the following set of patches to QEMU
> > which add support for the Allwinner H3 System on Chip and the
> > Orange Pi PC machine. The following features and devices are supported:
> >
> >   * SMP (Quad Core Cortex A7)
> >   * Generic Interrupt Controller configuration
> >   * SRAM mappings
> >   * Timer device (re-used from Allwinner A10)
> >   * UART
> >   * SD/MMC storage controller
> >   * EMAC ethernet connectivity
> >   * USB 2.0 interfaces
> >   * Clock Control Unit
> >   * System Control module
> >   * Security Identifier device
> >
> > Functionality related to graphical output such as HDMI, GPU,
> > Display Engine and audio are not included.
>
> I'd love to see the OpenRISC AR100 core instantiated in this SoC.
>
> Your contribution makes another good example of multi-arch/single-binary
> QEMU (here 4x ARM + 1x OpenRISC).
>
>
Indeed that sounds like an interesting combination. Are there plans to
build a multi-arch/single-binary QEMU?
I have not looked yet at that part of the H3, but there is some documention
available here on this wiki:
  https://linux-sunxi.org/AR100

Regards,
Niek

--=20
Niek Linnenbank

WWW: http://www.nieklinnenbank.nl/
BLOG: http://nieklinnenbank.wordpress.com/
FUN:    http://www.FreeNOS.org/

--0000000000004ab92a0598d1c28d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe,<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 at 10:02 AM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt; Dear QEMU developers,<br>
&gt; <br>
&gt; Hereby I would like to contribute the following set of patches to QEMU=
<br>
&gt; which add support for the Allwinner H3 System on Chip and the<br>
&gt; Orange Pi PC machine. The following features and devices are supported=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* SMP (Quad Core Cortex A7)<br>
&gt;=C2=A0 =C2=A0* Generic Interrupt Controller configuration<br>
&gt;=C2=A0 =C2=A0* SRAM mappings<br>
&gt;=C2=A0 =C2=A0* Timer device (re-used from Allwinner A10)<br>
&gt;=C2=A0 =C2=A0* UART<br>
&gt;=C2=A0 =C2=A0* SD/MMC storage controller<br>
&gt;=C2=A0 =C2=A0* EMAC ethernet connectivity<br>
&gt;=C2=A0 =C2=A0* USB 2.0 interfaces<br>
&gt;=C2=A0 =C2=A0* Clock Control Unit<br>
&gt;=C2=A0 =C2=A0* System Control module<br>
&gt;=C2=A0 =C2=A0* Security Identifier device<br>
&gt; <br>
&gt; Functionality related to graphical output such as HDMI, GPU,<br>
&gt; Display Engine and audio are not included.<br>
<br>
I&#39;d love to see the OpenRISC AR100 core instantiated in this SoC.<br>
<br>
Your contribution makes another good example of multi-arch/single-binary <b=
r>
QEMU (here 4x ARM + 1x OpenRISC).<br>
<br>
</blockquote></div><div><br></div><div>Indeed that sounds like an interesti=
ng combination. Are there plans to build a multi-arch/single-binary QEMU?<b=
r></div><div>I have not looked yet at that part of the H3, but there is som=
e documention available here on this wiki:</div><div>=C2=A0 <a href=3D"http=
s://linux-sunxi.org/AR100">https://linux-sunxi.org/AR100</a></div><div><br>=
</div><div>Regards,</div><div>Niek<br></div><br>-- <br><div dir=3D"ltr" cla=
ss=3D"gmail_signature">Niek Linnenbank<br><br>WWW: <a href=3D"http://www.ni=
eklinnenbank.nl/" target=3D"_blank">http://www.nieklinnenbank.nl/</a><br>BL=
OG: <a href=3D"http://nieklinnenbank.wordpress.com/" target=3D"_blank">http=
://nieklinnenbank.wordpress.com/</a><br>FUN:=C2=A0 =C2=A0 <a href=3D"http:/=
/www.FreeNOS.org/" target=3D"_blank">http://www.FreeNOS.org/</a><br></div><=
/div>

--0000000000004ab92a0598d1c28d--

