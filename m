Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F9C206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX+EQ6gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F9C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9utj-0001OU-OE
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9usa-0000k4-5K
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9usQ-0000vJ-3I
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:33:32 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9usP-0000to-ML; Mon, 16 Sep 2019 13:33:25 -0400
Received: by mail-lf1-x141.google.com with SMTP id y127so653368lfc.0;
 Mon, 16 Sep 2019 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UxeB0aHfJo086cN/r9SqUUkaVF934dhjoqHLxRzhEKA=;
 b=HX+EQ6gTCZ+FBgBa4uM+E2uwJ08SmiroHYi40STV+ZmjHAE469/hovmQAwOgbfxlnP
 Hd+VX/Cfr2np7f0KX2cylJD913EgZNVG0oV4OVGdNzvJi3jMvbE8RMw8UVHIAEykAwNT
 VxK240SBZy/t85mbf676yXxe1ScEmlyHia/p64TryLt55cS2fdEny1rM5RZDcDVVZMSu
 ZNlYEv6a1Kg68bsZpkjan8I/y7xeKVRlXTjHsTsg9g2sUgOt01oVHugb2gvO93TbWqjk
 jKgOcuP+IymLWdoxIkZj9GnXQP5J/sB7XUTBP7UzJHZGrU4T82P2JE/SKKDubhdy3aBg
 ymBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UxeB0aHfJo086cN/r9SqUUkaVF934dhjoqHLxRzhEKA=;
 b=Bxo6wHVxf8ivL1VJdJKkOoYS8oi8AsgsRRC61pxLSxGKDX2vvedjoaPeyfG65/55ui
 VRtvii9oLoip4K637Af6jKR8yUeZWVVkoAVi0AKw89IU5uh9+DINGE8mCe49g++ou7SY
 JTVuwNFkBIOciCtRbgH16itcj1P7w2YYbafUu2rjrjUIWfI+qnyB6nM52CJl7i4KIwr7
 xeECH9Vbswr44THJqKODyq6sX7y+CqC6oHECdHN9pF89M1xiBKqXWFqXCC0xiOnCxYCf
 brSeOeLeQOX0XyC4UIoEmaCjg3CqUwH4hX5n7W2286zauB0QPKRKSPU0GmfJiIeGcOGS
 t3vw==
X-Gm-Message-State: APjAAAWkcuMMUDFqKwOWEY3xmL7Rl3Cwg3UYOTwzt5Ea04yjNjW01iE0
 Q4xXZFzvqP+o5m4LdojydbcKO5JjNROkaayj+9w=
X-Google-Smtp-Source: APXvYqxpm77wnZdqADZ1lBt/HHBXe43PNYtypgiqYu3IXIhnHlVvXcPkHrCDanDM2iv1vqgysOF9YFROOnm9Wnhuh4A=
X-Received: by 2002:ac2:562c:: with SMTP id b12mr323033lff.156.1568655204027; 
 Mon, 16 Sep 2019 10:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-2-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 10:28:53 -0700
Message-ID: <CAKmqyKOoO8ZGP4sPNhN-51iSL6gmomcwSjcR892AbwpOYnCcZQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH 01/13] hw/timer: Compile devices not
 target-dependent as common object
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 9:02 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> All these devices do not contain any target-specific. While most
> of them are arch-specific, they are shared between different
> targets of the same arch family (ARM and AArch64, MIPS32/MIPS64,
> endianess, ...).
> Put them into common-obj-y to compile them once for all targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/Makefile.objs | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 123d92c969..f407523aa4 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -25,20 +25,20 @@ common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.=
o
>  common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
>  common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
>
> -obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
> -obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
> -obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o
> -obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
> -obj-$(CONFIG_OMAP) +=3D omap_gptimer.o
> -obj-$(CONFIG_OMAP) +=3D omap_synctimer.o
> -obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
> -obj-$(CONFIG_SH4) +=3D sh_timer.o
> -obj-$(CONFIG_DIGIC) +=3D digic-timer.o
> -obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
> +common-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
> +common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
> +common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o
> +common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
> +common-obj-$(CONFIG_OMAP) +=3D omap_gptimer.o
> +common-obj-$(CONFIG_OMAP) +=3D omap_synctimer.o
> +common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_timer.o
> +common-obj-$(CONFIG_SH4) +=3D sh_timer.o
> +common-obj-$(CONFIG_DIGIC) +=3D digic-timer.o
> +common-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
>
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>
> -obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
> +common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
>
>  common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
>  common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
> --
> 2.20.1
>
>

