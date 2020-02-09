Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A377DC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 22:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EEC207FF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 22:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPnTS8jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EEC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0vRh-0008Lg-DX
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 17:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0vQw-0007lh-Pd
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 17:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0vQv-0005gu-JW
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 17:52:10 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j0vQv-0005fP-CI; Sun, 09 Feb 2020 17:52:09 -0500
Received: by mail-io1-xd42.google.com with SMTP id z16so5472536iod.11;
 Sun, 09 Feb 2020 14:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gd64rIV7kYV4G/rTlVnwwyOn7DZScBsCVv3MQfDpVK8=;
 b=TPnTS8jy1rGL7kr0zvVWh2HW1FYf5NgJjByBAcZDfEVhPXRLLjPUxDkXaNORTWDl0l
 lTvK61HWf+vVBkhLsV2QB/9ZX1J5cQkjnWKmYCRcgQEG6ttutjV5EhKRe64+jCHt+u2F
 Xx8Hf8TfhqvhLl5i58EiZnautj1ECTAH4r1CQY8tQWsqgUd+Q0tkaWRVEjrj6kmngnC/
 H0sccIHugpKC/v9/lnlgx5JcrGDVRnnB+fQnwmtKbV8CGENkP0WGaIIwt6u1HO3njomE
 k52zNepUVjjrvOW69dx/9IGNKRIiZtsQgjbYfYojIQ7OCrIFDtEbK701vo8MKzeJc39l
 pVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gd64rIV7kYV4G/rTlVnwwyOn7DZScBsCVv3MQfDpVK8=;
 b=qlnJllr1/NWvbGfpUvdiGOU1iZZpbAIiU9BbQ15v4dSur+w3Iiw2i2QXPXnV3StBzc
 IthA0H6wrNBqhy/AyGLZUkFaKEVCWV+il+DQ5YlEd6INdxb+1DypCw3jnEuBl+tT9gOv
 02SiOeSYsgtWO5HleKcrzCRXL+asUu16Q+VmWBfmK0tC+86eJNBwvJtLPddRHnOvmC6z
 1qqh9AivWv9pZouUFBenk8c84HhM+6/qZs3SbxGU8HxpEPupyCDZyTFvQwxdu5ybsX32
 Xel73QoAQJOYdhRRs3X2EvgIgxKNx88Cczk4mY4sZa27KGoK/oR67Tu82kV4cNHt1rrP
 p6Zw==
X-Gm-Message-State: APjAAAWS1lwk6N398+tJlvSbgzelzRigCLAeAcUETv4ROOpdOxe/JbgM
 45Gcs6m43QGDWjQlEvn2R3JJGGsPCkLcRkEsaQs=
X-Google-Smtp-Source: APXvYqwUa3mANuJD19EcXkwz3HC0IrDZcdf9Zs1Lmwp/vKa9fg7dIrptp172h7S3dT2vcOO80aDvzrKRIdOtpBWQu+M=
X-Received: by 2002:a05:6602:2815:: with SMTP id
 d21mr6774912ioe.217.1581288728370; 
 Sun, 09 Feb 2020 14:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-3-f4bug@amsat.org>
In-Reply-To: <20200208165645.15657-3-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 9 Feb 2020 23:51:57 +0100
Message-ID: <CAPan3WoYkSB4ySUfjz-8efH3eaFgjcVC1TQb2Jc9j-cN0fCcoA@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] hw/arm/raspi: Correct the board descriptions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f12171059e2c7840"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f12171059e2c7840
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,


On Sat, Feb 8, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> We hardcode the board revision as 0xa21041 for the raspi2, and
> 0xa02082 for the raspi3:
>
>   166 static void raspi_init(MachineState *machine, int version)
>   167 {
>   ...
>   194     int board_rev =3D version =3D=3D 3 ? 0xa02082 : 0xa21041;
>
> These revision codes are for the 2B and 3B models, see:
>
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-c=
odes/README.md
>
> Correct the board description.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index f2ccabc662..818146fdbb 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -221,7 +221,7 @@ static void raspi2_init(MachineState *machine)
>
>  static void raspi2_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "Raspberry Pi 2";
> +    mc->desc =3D "Raspberry Pi 2B";
>      mc->init =3D raspi2_init;
>      mc->block_default_type =3D IF_SD;
>      mc->no_parallel =3D 1;
> @@ -243,7 +243,7 @@ static void raspi3_init(MachineState *machine)
>
>  static void raspi3_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "Raspberry Pi 3";
> +    mc->desc =3D "Raspberry Pi 3B";
>

Could this patch be replaced by patch #11 "hw/arm/raspi: Extract the board
model from the board revision"?

Regards,
Niek


>      mc->init =3D raspi3_init;
>      mc->block_default_type =3D IF_SD;
>      mc->no_parallel =3D 1;
> --
> 2.21.1
>
>

--=20
Niek Linnenbank

--000000000000f12171059e2c7840
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sat, Feb 8, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mail=
to:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">We hardcode the board revision as 0xa210=
41 for the raspi2, and<br>
0xa02082 for the raspi3:<br>
<br>
=C2=A0 166 static void raspi_init(MachineState *machine, int version)<br>
=C2=A0 167 {<br>
=C2=A0 ...<br>
=C2=A0 194=C2=A0 =C2=A0 =C2=A0int board_rev =3D version =3D=3D 3 ? 0xa02082=
 : 0xa21041;<br>
<br>
These revision codes are for the 2B and 3B models, see:<br>
<a href=3D"https://www.raspberrypi.org/documentation/hardware/raspberrypi/r=
evision-codes/README.md" rel=3D"noreferrer" target=3D"_blank">https://www.r=
aspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md<=
/a><br>
<br>
Correct the board description.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/arm/raspi.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c<br>
index f2ccabc662..818146fdbb 100644<br>
--- a/hw/arm/raspi.c<br>
+++ b/hw/arm/raspi.c<br>
@@ -221,7 +221,7 @@ static void raspi2_init(MachineState *machine)<br>
<br>
=C2=A0static void raspi2_machine_init(MachineClass *mc)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Raspberry Pi 2&quot;;<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Raspberry Pi 2B&quot;;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D raspi2_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;block_default_type =3D IF_SD;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;no_parallel =3D 1;<br>
@@ -243,7 +243,7 @@ static void raspi3_init(MachineState *machine)<br>
<br>
=C2=A0static void raspi3_machine_init(MachineClass *mc)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Raspberry Pi 3&quot;;<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Raspberry Pi 3B&quot;;<br></blockquote=
><div><br></div><div>Could this patch be replaced by patch #11 &quot;hw/arm=
/raspi: Extract the board model from the board revision&quot;?</div><div><b=
r></div><div>Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D raspi3_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;block_default_type =3D IF_SD;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;no_parallel =3D 1;<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f12171059e2c7840--

