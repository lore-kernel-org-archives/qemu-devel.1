Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B30AC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B0B20724
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD7MzWnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B0B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFcpO-00054p-4x
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 08:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFcoe-0004dj-NI
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFcoc-0004I0-8b
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:01:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFcoc-0004HU-1C; Sat, 21 Mar 2020 08:01:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id 31so4619865wrs.3;
 Sat, 21 Mar 2020 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WD+fLXhzDeprzYi56If8q8l8H2M2HFiJuPfnS3uR8Mc=;
 b=DD7MzWnvmZi4hF/I/U9y+S/Na+/rhRUQTYle6AdROUp/S91bpFg//P2AwDQ7YnFuNf
 ctBBrvjnh/hl8oy4oD2oNR0+0sK4Q5le3NSjvkocBuCK7dH6qoSCA0Pt8Guhgzj3d2fE
 zyvyeLjVATdss3uakgP1oQVfwtpXLiY8j5heFNbc0UC57uFW+M7DrYp5F0x89gkwn4K0
 WxN3x5O1PdJ4MGYnF7V07oXlGAV93Q4m9hQUZILoiSg+l9JsOPIhPWDlRg0YjhpeOqAh
 Bgdi3NTILNeDxPDpZn1Ditz6tdvzqjDNQU661cle6ezMYa73KtnBubYB/vplxSrFdRH3
 71HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WD+fLXhzDeprzYi56If8q8l8H2M2HFiJuPfnS3uR8Mc=;
 b=shbprQngrQB7xxCrxqvC5pPO9Xu9dEUmXdzCVUsxs6LNRzeeHBnNWwg6Mupd+VeXlx
 jUw5hBPlk88F9vHBh3mFEfJnUKN4UhESt2FXDXVzIFwo8nAFAdGYAKO/Kfn+WyYGMRKX
 wM1BR+UfYWkXmIcXYQ/OI9S0LPaw0I2s44kqL4R2tFQYRK0F8KjZ8UyykN3T0zlXueWu
 Nq1GPLUnDOBH0LAvUJawb9Qhprf6bFZikTYwtrFa5culQAhGX3H+raAndGTMlCLsUhzm
 /Hp7FPN/Lp5I6IwtCnceQQxz/lMMJjpZkZO3LJtMUGrTnrD+f5RIkYxsRm7I52KWzAhQ
 zk4A==
X-Gm-Message-State: ANhLgQ3nte9NhU2YCOJqFBq+wv/4eNGFpHx8q8KsFlHj/9c5gXORYlJf
 bYFMHUioYRX9G7ZiU93goRSQqHcR1bztQdWixEE=
X-Google-Smtp-Source: ADFU+vt8ZCNwHP/oXhtbUSr29OOd034nVzPkmxze3fPYS8nueBp+NqWX7KfRMRbENayiNHEiato32XVg2Wu+AiNpJ+M=
X-Received: by 2002:adf:f64a:: with SMTP id x10mr1281251wrp.402.1584792080733; 
 Sat, 21 Mar 2020 05:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200321114615.5360-1-philmd@redhat.com>
In-Reply-To: <20200321114615.5360-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 21 Mar 2020 13:01:06 +0100
Message-ID: <CAHiYmc7JCR-_2Vb8hm1ob56-e3Et+1mtsoftt-CzY76i_qe2QA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 00/11] misc: Trivial static code analyzer fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000003daa205a15c296b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000003daa205a15c296b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12:47 PM Sub, 21.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
=D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Fix trivial warnings reported by the Clang static code analyzer.
>

Philippe,

It would be useful and customary for this type of fixes to provide here the
environment you used for obtaining the warnings (clang version, configure
parameters, and all needed elenents to repro the warnings).

Regards,
Aleksandar

> Philippe Mathieu-Daud=C3=A9 (11):
>   block: Remove dead assignment
>   blockdev: Remove dead assignment
>   hw/i2c/pm_smbus: Remove dead assignment
>   hw/input/adb-kbd: Remove dead assignment
>   hw/ide/sii3112: Remove dead assignment
>   hw/isa/i82378: Remove dead assignment
>   hw/gpio/aspeed_gpio: Remove dead assignment
>   hw/timer/exynos4210_mct: Remove dead assignments
>   hw/timer/stm32f2xx_timer: Remove dead assignment
>   hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning
>   hw/scsi/esp-pci: Remove dead assignment
>
>  block.c                    | 2 +-
>  blockdev.c                 | 2 +-
>  hw/gpio/aspeed_gpio.c      | 4 ++--
>  hw/i2c/pm_smbus.c          | 1 -
>  hw/ide/sii3112.c           | 2 +-
>  hw/input/adb-kbd.c         | 1 -
>  hw/isa/i82378.c            | 8 ++++----
>  hw/scsi/esp-pci.c          | 1 -
>  hw/timer/exynos4210_mct.c  | 3 ---
>  hw/timer/pxa2xx_timer.c    | 1 +
>  hw/timer/stm32f2xx_timer.c | 1 -
>  11 files changed, 10 insertions(+), 16 deletions(-)
>
> --
> 2.21.1
>
>

--00000000000003daa205a15c296b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">12:47 PM Sub, 21.03.2020. Philippe Mathieu-Daud=C3=A9 &lt;<a=
 href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Fix trivial warnings reported by the Clang static code analyzer.<br>
&gt;</p>
<p dir=3D"ltr">Philippe,</p>
<p dir=3D"ltr">It would be useful and customary for this type of fixes to p=
rovide here the environment you used for obtaining the warnings (clang vers=
ion, configure parameters, and all needed elenents to repro the warnings).<=
/p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; Philippe Mathieu-Daud=C3=A9 (11):<br>
&gt; =C2=A0 block: Remove dead assignment<br>
&gt; =C2=A0 blockdev: Remove dead assignment<br>
&gt; =C2=A0 hw/i2c/pm_smbus: Remove dead assignment<br>
&gt; =C2=A0 hw/input/adb-kbd: Remove dead assignment<br>
&gt; =C2=A0 hw/ide/sii3112: Remove dead assignment<br>
&gt; =C2=A0 hw/isa/i82378: Remove dead assignment<br>
&gt; =C2=A0 hw/gpio/aspeed_gpio: Remove dead assignment<br>
&gt; =C2=A0 hw/timer/exynos4210_mct: Remove dead assignments<br>
&gt; =C2=A0 hw/timer/stm32f2xx_timer: Remove dead assignment<br>
&gt; =C2=A0 hw/timer/pxa2xx_timer: Add assertion to silent static analyzer =
warning<br>
&gt; =C2=A0 hw/scsi/esp-pci: Remove dead assignment<br>
&gt;<br>
&gt; =C2=A0block.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 2 +-<br>
&gt; =C2=A0blockdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 2 +-<br>
&gt; =C2=A0hw/gpio/aspeed_gpio.c=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
&gt; =C2=A0hw/i2c/pm_smbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
&gt; =C2=A0hw/ide/sii3112.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt; =C2=A0hw/input/adb-kbd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
&gt; =C2=A0hw/isa/i82378.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8 +++=
+----<br>
&gt; =C2=A0hw/scsi/esp-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
&gt; =C2=A0hw/timer/exynos4210_mct.c=C2=A0 | 3 ---<br>
&gt; =C2=A0hw/timer/pxa2xx_timer.c=C2=A0 =C2=A0 | 1 +<br>
&gt; =C2=A0hw/timer/stm32f2xx_timer.c | 1 -<br>
&gt; =C2=A011 files changed, 10 insertions(+), 16 deletions(-)<br>
&gt;<br>
&gt; -- <br>
&gt; 2.21.1<br>
&gt;<br>
&gt;<br>
</p>

--00000000000003daa205a15c296b--

