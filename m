Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF71AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78644205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAcqgkax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78644205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU6b-0005Qh-LL
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jCU2C-0005B0-CT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jCU2B-0005Mg-7W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 16:02:24 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:36764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jCU2B-0005IF-1q; Thu, 12 Mar 2020 16:02:23 -0400
Received: by mail-io1-xd2a.google.com with SMTP id d15so7014787iog.3;
 Thu, 12 Mar 2020 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iEExUs14yIhTspSpMTZEiP0XS6fhKXstB4RbOjXMcI8=;
 b=kAcqgkax3VsBgHjQ/4y69SlZ1Wq95HihuANakTA4nSOEPI0bYWsiqAt4LxCmyxjsok
 Osuj8BudukDevJ+O6y+7UKdDtkZYAgvXr51xFNISG5vHVfimofOJQbWi6b0zJN2eidpg
 6ytMLZVqz2xLmPC3afvyDObHxvua1NQdcPX20gdrfk0z2XunefVaTavFj/lxLTJnF8Uk
 676JqleQ0ICjAAQ9Wo/kBPd+DSOi6+QYYpra9iXi6bl4ltursirehS39kJacP/Pw3OEF
 IFC15iyk/ZzRfd1DOA3/hGEbfyv8H9OWOztk6zDehCFDWWYm6rDtkA8S7S7zrVGtHRao
 XYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iEExUs14yIhTspSpMTZEiP0XS6fhKXstB4RbOjXMcI8=;
 b=C9J2CnDbXJxujt9omtjT+UrH8t1hkHD9QHSvO723VISgpjVCYRPaS6+FywRvcRbxuC
 A3G/JuFZum6Ln1DI1o8bIOxtH5KtOGiL9sFv1vqte4Htg9//go0unMm+e9CtU7wEPZXU
 gq6OmrAFsodKGQaHKY3NtjFJg4YOGOgenstf2kTl/mXRh0uL/zllbl15lrP/jMWCgdGy
 1qSJvcmnrVqGYc7rBaz+4wdqOaj2WRkiVWIfE+ldsIrQadwB7EOyvMF8B/Sk+rQ2nu9t
 hnW3l1bG0aNIAxNrz1r3JP+Yneu4z8JIrA3uBS2qsoTaDa4PPdI7wM/UdU+uYRL88v/s
 pPfw==
X-Gm-Message-State: ANhLgQ0RZeKVu3+0sx4sRMpN1IJ+LEJ47ZFvfJWkRMNL3a26waMfNYu5
 FY03r//oIfCl25pi4H0Gj3GuDzcAYN/8MH2FAeU=
X-Google-Smtp-Source: ADFU+vsZ+8dqR3Tlma42xnqtUmTMantE6dZEz8LVB+6IIJEMvyVz4NMKgWny3j4gp5QLi3vWQkZ/UbUPmyA636srTN0=
X-Received: by 2002:a6b:5406:: with SMTP id i6mr9248179iob.188.1584043339648; 
 Thu, 12 Mar 2020 13:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200311221854.30370-1-nieklinnenbank@gmail.com>
 <CAFEAcA9UqDRT-32Qnap8n3uYh8hyK_89KhsTwceHDRiTzihyJg@mail.gmail.com>
In-Reply-To: <CAFEAcA9UqDRT-32Qnap8n3uYh8hyK_89KhsTwceHDRiTzihyJg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 12 Mar 2020 21:02:08 +0100
Message-ID: <CAPan3WpgoCnnQCqxeYC3vPJ692TxFkLxs3dnD1xv9HfCukr7NA@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009195a605a0add438"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2a
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009195a605a0add438
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 12, 2020 at 5:22 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 11 Mar 2020 at 22:19, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> >
> > Dear QEMU developers,
> >
> > Hereby I would like to contribute the following set of patches to QEMU
> > which add support for the Allwinner H3 System on Chip and the
> > Orange Pi PC machine. The following features and devices are supported:
> >
> >  * SMP (Quad Core Cortex A7)
> >  * Generic Interrupt Controller configuration
> >  * SRAM mappings
> >  * SDRAM controller
> >  * Real Time Clock
> >  * Timer device (re-used from Allwinner A10)
> >  * UART
> >  * SD/MMC storage controller
> >  * EMAC ethernet
> >  * USB 2.0 interfaces
> >  * Clock Control Unit
> >  * System Control module
> >  * Security Identifier device
>
>
>
> Applied to target-arm.next, thanks.


Great news! And thanks for your support as well Peter!


> (I moved
> the doc into the its new location now that the split-out
> of the arm board docs into separate files has landed.)
>
> Yeah sure, indeed, that makes sense.

Regards,
Niek


> -- PMM
>


-- 
Niek Linnenbank

--0000000000009195a605a0add438
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12, 2020 at 5:22 PM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Wed, 11 Mar 2020 at 22:19, Niek Linnenbank &lt;<a href=3D"mailto:n=
ieklinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; Dear QEMU developers,<br>
&gt;<br>
&gt; Hereby I would like to contribute the following set of patches to QEMU=
<br>
&gt; which add support for the Allwinner H3 System on Chip and the<br>
&gt; Orange Pi PC machine. The following features and devices are supported=
:<br>
&gt;<br>
&gt;=C2=A0 * SMP (Quad Core Cortex A7)<br>
&gt;=C2=A0 * Generic Interrupt Controller configuration<br>
&gt;=C2=A0 * SRAM mappings<br>
&gt;=C2=A0 * SDRAM controller<br>
&gt;=C2=A0 * Real Time Clock<br>
&gt;=C2=A0 * Timer device (re-used from Allwinner A10)<br>
&gt;=C2=A0 * UART<br>
&gt;=C2=A0 * SD/MMC storage controller<br>
&gt;=C2=A0 * EMAC ethernet<br>
&gt;=C2=A0 * USB 2.0 interfaces<br>
&gt;=C2=A0 * Clock Control Unit<br>
&gt;=C2=A0 * System Control module<br>
&gt;=C2=A0 * Security Identifier device<br>
<br>
<br>
<br>
Applied to target-arm.next, thanks. </blockquote><div><br></div><div>Great =
news! And thanks for your support as well Peter!<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">(I moved<br>
the doc into the its new location now that the split-out<br>
of the arm board docs into separate files has landed.)<br>
<br></blockquote><div>Yeah sure, indeed, that makes sense.</div><div><br></=
div><div>Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000009195a605a0add438--

