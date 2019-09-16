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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37D4C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A199E214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuaFVrBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A199E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yo2-0000wA-Nk
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9yn8-0000Cc-S7
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9yn7-0001cx-Ce
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:44:14 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9yn6-0001cQ-TU; Mon, 16 Sep 2019 17:44:13 -0400
Received: by mail-lf1-x141.google.com with SMTP id w67so1165014lff.4;
 Mon, 16 Sep 2019 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ydq/wOLNsVLu6DqAx1bi9sX41tAUm839UCibkHYqB+U=;
 b=AuaFVrBMa7k8XWhGI3mpm4hMbxzh2Qw/K46Y1nrbWP95OahsDwZGczNg+adQA9m2dg
 RaGNn6Sc9jXUXRkoC2LTjDOQQ85hrFe4UXlWFBU8Q/jdhtxQgkXK5+TXtz0lFdDzLwkj
 5IEy515UP4hRxxFaB8RYf4AwgwfOOZJpgQl7wXe71j3sMQ+pc3eiDXdXZf8zpqsN3Fpe
 h31gKdgzWSHNvdAc29eKWhEwRDu1aSjFONfBwGGF/vj91SxHdrqCJLEta7Y0QsBjMIBg
 Cs+Lc23a0oRxBfLjlf2hamsZqExJFotXnOIJW8kxiVJYwmnsO+IxQ3CWRRt8p0N9hmkv
 +JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ydq/wOLNsVLu6DqAx1bi9sX41tAUm839UCibkHYqB+U=;
 b=fcdeY3WlOmn9TbTMyIJ6/hdLjCp4N89FezUGoHIckhzk97+dHaM73G+eH8nTR3ux2Z
 Ox+gU9K/MIW4jxS20hUiWM/oTzKWahEYFETMo1ufHoQQ+jHCsvqefYX+XhobM+Moda7h
 O8unOXjuQm2obMzK+i4Vn0KdJiryf4Y27SukfoiB8k/y06yeKEHpqGDgcLaYlUvq8OIH
 ArJwI5duOSObpoYSBvvAEtaHJxOvSr4+iZAxYmM376JPzfBSw1WUoXo3ouxog9AYOwTw
 6ypXncenoQU9VB0xeVfDQvuYrkptpgT8J8TrDAtsVPt8yCR5SyrsrufaldXG4WYamBq3
 PaVA==
X-Gm-Message-State: APjAAAVyQqp4iaYPP7Kmz5SgRFJpX+M2RLKFkPhvY49Vofjv2YKgkis6
 6BLVSdDRr5/syXGt3/74S815oDzmuSKqVEgboYM=
X-Google-Smtp-Source: APXvYqxAvJWylPMSmdRgZIiOaYe08Q7IwKTbVLdMdC9ZXwYBwaNljfUVI7Tp0fZa4bkjUp2/nPQ2q5XiFCZ2YJuaOPM=
X-Received: by 2002:ac2:51cd:: with SMTP id u13mr161547lfm.135.1568670251059; 
 Mon, 16 Sep 2019 14:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-8-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-8-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:39:40 -0700
Message-ID: <CAKmqyKNM5AkkdS6MHtyRqdN16cyiN2abG5DDfJY48OnJAGE5OA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH 07/13] hw: Move TWL92230 device from
 hw/timer/ to hw/rtc/ subdirectory
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

On Mon, Sep 16, 2019 at 9:37 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The TWL92230 is an "energy management device" companion with
> a RTC. Since we mostly model the RTC, move it under the hw/rtc/
> subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                  | 2 +-
>  hw/rtc/Kconfig               | 4 ++++
>  hw/rtc/Makefile.objs         | 1 +
>  hw/{timer =3D> rtc}/twl92230.c | 0
>  hw/timer/Kconfig             | 4 ----
>  hw/timer/Makefile.objs       | 1 -
>  6 files changed, 6 insertions(+), 6 deletions(-)
>  rename hw/{timer =3D> rtc}/twl92230.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb9a1ed075..d17058264b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -663,7 +663,7 @@ F: hw/display/blizzard.c
>  F: hw/input/lm832x.c
>  F: hw/input/tsc2005.c
>  F: hw/misc/cbus.c
> -F: hw/timer/twl92230.c
> +F: hw/rtc/twl92230.c
>  F: include/hw/display/blizzard.h
>  F: include/hw/input/tsc2xxx.h
>  F: include/hw/misc/cbus.h
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index cc7fead764..dff9d60946 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -8,6 +8,10 @@ config M48T59
>  config PL031
>      bool
>
> +config TWL92230
> +    bool
> +    depends on I2C
> +
>  config MC146818RTC
>      bool
>
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 4621b37bc2..810a38ee7b 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -4,5 +4,6 @@ ifeq ($(CONFIG_ISA_BUS),y)
>  common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
>  endif
>  common-obj-$(CONFIG_PL031) +=3D pl031.o
> +common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> diff --git a/hw/timer/twl92230.c b/hw/rtc/twl92230.c
> similarity index 100%
> rename from hw/timer/twl92230.c
> rename to hw/rtc/twl92230.c
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index b04c928136..9357875f28 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -20,10 +20,6 @@ config HPET
>  config I8254
>      bool
>
> -config TWL92230
> -    bool
> -    depends on I2C
> -
>  config ALTERA_TIMER
>      bool
>      select PTIMER
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 034bd30255..23be70b71d 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -7,7 +7,6 @@ common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
> -common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
>  common-obj-$(CONFIG_SLAVIO) +=3D slavio_timer.o
>  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_timer.o
> --
> 2.20.1
>
>

