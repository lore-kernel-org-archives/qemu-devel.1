Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB35FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34862176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB+vxT/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34862176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgom-0008Dw-RI
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgnJ-0007D9-Fo
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ihgnI-000465-2s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:23:45 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ihgnH-00043R-Sm; Wed, 18 Dec 2019 16:23:44 -0500
Received: by mail-io1-xd43.google.com with SMTP id r13so3542887ioa.3;
 Wed, 18 Dec 2019 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WtKoWcYA4eLIkTD5hhsie5xpQCIYiUwxTm3208IaOxQ=;
 b=VB+vxT/N6AhQaOfbqc9J8H2pfyaQ1f2YM0CnHaQOsHkvoQf423NiJKfcQ4LlY8QivG
 dTOxiOVp6h6uF7vKsetAHW1zdH2kUY19wofGZOkZvS4DbLi5TfJPMSsAhuJcLBg68MMr
 b6d1s4d3cgaajIu4pHKDh7w+sn7/X3tn/1+W7aPwUN0wJqdD0vuu0Xt6lpH43RFgZI+6
 +JCBiyjCniMu5AlMV8W3eSuOSm7JPKq4lNGUTQJX7xkFNobUB+hDBl6plMB3bsZShVes
 Ntg3G2YETn2Ep7n0XP2QOMAWljtgAh1gixenT8PfYDWbWyJTiC5yl8VWt6fqe2KJDRdt
 qI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WtKoWcYA4eLIkTD5hhsie5xpQCIYiUwxTm3208IaOxQ=;
 b=BEDoeq/+Q/nhjJIrm/FNCVsmEzIE8mV5n5W40I/5eNZ/4Y/Jo/F/0gqAgGfTP65EfZ
 3n1kSdJ2Z5eJ0oV5VDlC4uXXYXeZm2V4VVd+6ZcDZezJqPxF3bN0w8YONyO0rBGXJHL+
 yj+BH+p1rCBlj7hx3rNgeeXXtc1JfhF9eK+oin0X0JaaZkJCm76x1ZxMLHHtqu17AvW2
 yu5UkbRy8FkXLjS7tlKcAl0gAhvQdTpLoALuRtPc6Ke+w30IRuQtyPsCwKV2QTgnoVK8
 QMXjy4/xezH/C/ITde9MDHBFXEYidWGZWT4ViJaawA05l2nyuUKApUIAbSvpH4GbJB1w
 pPwg==
X-Gm-Message-State: APjAAAUydaQHHbh0FZ5UUOj0pL3gz0bSAGztZ8EUbohaUUMfEg73yEon
 a66H/stgkVaVgMuPkAd0IukYiOHCqHpXG5zdsD0=
X-Google-Smtp-Source: APXvYqwnw6dhg98pv1fDSDdgEea4/1/0StD071ln9a2/MIcBmJCoxMIqn40ZP8h/TBgc+4ljrPrz4fd7bxeYNDpp9T8=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr4373763jac.126.1576704223115; 
 Wed, 18 Dec 2019 13:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-5-f4bug@amsat.org>
In-Reply-To: <20191217182730.943-5-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 18 Dec 2019 22:23:32 +0100
Message-ID: <CAPan3WoW60CgKWhXD8RD0xAjH+g+vRa8aKY7dx4fxC=XPxZ7WQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] !fixup "hw: arm: add Xunlong Orange Pi PC machine"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000002281e1059a010fc4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
 QEMU Developers <qemu-devel@nongnu.org>, Guenter Roeck <linux@roeck-us.net>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002281e1059a010fc4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Noted. I'll make sure mc->default_ram_size =3D 1 * GiB is added for the nex=
t
reworked patch set v3.

Regards,
Niek

On Tue, Dec 17, 2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Without this, the machine starts with default 128MB, and Ubuntu Bionic
> fails:
>
> [ ***  ] (2 of 4) A start job is running for=E2=80=A6Persistent Storage (=
37s /
> 2min 1s)
> [  *** ] (2 of 4) A start job is running for=E2=80=A6Persistent Storage (=
38s /
> 2min 1s)
> [  OK  ] Started Flush Journal to Persistent Storage.
> Starting Create Volatile Files and Directories...
> Starting Armbian ZRAM config...
> [    **] (3 of 6) A start job is running for=E2=80=A6s and Directories (5=
5s / no
> limit)
> [     *] (3 of 6) A start job is running for=E2=80=A6s and Directories (5=
5s / no
> limit)
> [    **] (3 of 6) A start job is running for=E2=80=A6s and Directories (5=
6s / no
> limit)
> [  OK  ] Started Create Volatile Files and Directories.
> [***   ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config (1min 1=
0s / 1min
> 19s)
> [**    ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config (1min 1=
2s / 1min
> 19s)
> [*     ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config (1min 1=
3s / 1min
> 19s)
> [FAILED] Failed to start Armbian ZRAM config.
> See 'systemctl status armbian-zram-config.service' for details.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/orangepi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 119f370924..da758d7eba 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -122,6 +122,7 @@ static void orangepi_machine_init(MachineClass *mc)
>      mc->max_cpus =3D AW_H3_NUM_CPUS;
>      mc->default_cpus =3D AW_H3_NUM_CPUS;
>      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> +    mc->default_ram_size =3D 1 * GiB;
>  }
>
>  DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
> --
> 2.21.0
>
>

--=20
Niek Linnenbank

--0000000000002281e1059a010fc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>Noted. I&#39;ll=
 make sure mc-&gt;default_ram_size =3D 1 * GiB is added for the next rework=
ed patch set v3.</div><div><br></div><div>Regards,</div><div>Niek<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, Dec 17, 2019 at 7:27 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"=
mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Without this, the machine starts wit=
h default 128MB, and Ubuntu Bionic<br>
fails:<br>
<br>
[ ***=C2=A0 ] (2 of 4) A start job is running for=E2=80=A6Persistent Storag=
e (37s / 2min 1s)<br>
[=C2=A0 *** ] (2 of 4) A start job is running for=E2=80=A6Persistent Storag=
e (38s / 2min 1s)<br>
[=C2=A0 OK=C2=A0 ] Started Flush Journal to Persistent Storage.<br>
Starting Create Volatile Files and Directories...<br>
Starting Armbian ZRAM config...<br>
[=C2=A0 =C2=A0 **] (3 of 6) A start job is running for=E2=80=A6s and Direct=
ories (55s / no limit)<br>
[=C2=A0 =C2=A0 =C2=A0*] (3 of 6) A start job is running for=E2=80=A6s and D=
irectories (55s / no limit)<br>
[=C2=A0 =C2=A0 **] (3 of 6) A start job is running for=E2=80=A6s and Direct=
ories (56s / no limit)<br>
[=C2=A0 OK=C2=A0 ] Started Create Volatile Files and Directories.<br>
[***=C2=A0 =C2=A0] (5 of 6) A start job is running for=E2=80=A6 ZRAM config=
 (1min 10s / 1min 19s)<br>
[**=C2=A0 =C2=A0 ] (5 of 6) A start job is running for=E2=80=A6 ZRAM config=
 (1min 12s / 1min 19s)<br>
[*=C2=A0 =C2=A0 =C2=A0] (5 of 6) A start job is running for=E2=80=A6 ZRAM c=
onfig (1min 13s / 1min 19s)<br>
[FAILED] Failed to start Armbian ZRAM config.<br>
See &#39;systemctl status armbian-zram-config.service&#39; for details.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/arm/orangepi.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
index 119f370924..da758d7eba 100644<br>
--- a/hw/arm/orangepi.c<br>
+++ b/hw/arm/orangepi.c<br>
@@ -122,6 +122,7 @@ static void orangepi_machine_init(MachineClass *mc)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;max_cpus =3D AW_H3_NUM_CPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpus =3D AW_H3_NUM_CPUS;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpu_type =3D ARM_CPU_TYPE_NAME(&quot;cor=
tex-a7&quot;);<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1 * GiB;<br>
=C2=A0}<br>
<br>
=C2=A0DEFINE_MACHINE(&quot;orangepi-pc&quot;, orangepi_machine_init)<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--0000000000002281e1059a010fc4--

