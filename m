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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A9C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C732171F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp9nU3d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C732171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ycZ-00034T-J6
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9yaa-0001to-9v
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9yaZ-0004uN-2f
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:31:16 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9yaY-0004tD-Pb; Mon, 16 Sep 2019 17:31:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id v24so1384871ljj.3;
 Mon, 16 Sep 2019 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dzOo5iF+PS67mIaAS7E3oa6CGJDLcuVs/L7NlmeUK4k=;
 b=Hp9nU3d4+NgnzQXJ4UOaeiwSzsF/MpVPMAvgZ1OZuPguwe37hLVtpyXm8s6kOGjCYn
 K+t/dpNr6bPaMZTXb3B8Hjh23ibVC4QKKGG0lBAy3Y5enWnYDMx5a3sFOGGF6wmv0Xom
 G6l6vX0C/e14fGIJTXcoYs+qkbLuWOQAgme8qFLd6WCpcgWWpvy95X17vRi7AqxjCKWn
 hkGUg4hg9p6DEQYFOW97tEgG22U9+JLvXnAaJn9N92a87h6dYC0Z004RbSBI5QR6DHGR
 Lp2NydbJZ3bqq+iedNaowoi5iv68aIS/NVRrnVHvhJ1nzG5VDl9qvVX0H2gVP4e1VOu3
 vK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dzOo5iF+PS67mIaAS7E3oa6CGJDLcuVs/L7NlmeUK4k=;
 b=CrhoAKm9WgAH93MLE0WNLyWH+F07GUIuTg/BmjxthlgXZBSEC68oji066M+Q8XO+9q
 ncXw6isDVv+YngGQk/8Px1mTVvR10eBWryynbMtdW3ACgUHKiRR2STzWdPBs2P38LM6S
 JxT/Mod91w0wSTpxgijT3F/KvIdkkDzevlSsVlcT4uRdutSv0hmthWz8tf+borXtOo+6
 oPDt/tiGhHh8ONNzyhQiGexrBr4yz2hvtlUMU+4zeRmZzNYkJgZ8LS7A36usj1KmpHrU
 OZHNziaLBDjzE8+uj6qv5MZS24flinMWOmfZTGhzlWUfeV8y0D+ofeuUhxYALLYERzUw
 5IGA==
X-Gm-Message-State: APjAAAW7/Ix5xqPBPbHcDHy7To1zaJITgBEAvsN54979C3YPMR9MdTam
 8RQY9AFPkIGWH56oJYUvfPxOnvQnJEaerHYM5wU=
X-Google-Smtp-Source: APXvYqxnpChGUftliM4/KyY9cyntdQvlfj2goI/Vtj57j/U84rsUSi6EOZF8pe8u+vVY/Q9ZTSkwJOzDP+9/wyyfiRM=
X-Received: by 2002:a2e:3902:: with SMTP id g2mr9956lja.196.1568669473416;
 Mon, 16 Sep 2019 14:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-6-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-6-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:26:42 -0700
Message-ID: <CAKmqyKMh1OMYH5Vy52imhM+Tn0FBrf2FC2otfVH8PV9yScomrQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 05/13] hw: Move M41T80 device from
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

On Mon, Sep 16, 2019 at 9:35 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The M41T80 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                | 2 +-
>  hw/rtc/Kconfig             | 4 ++++
>  hw/rtc/Makefile.objs       | 1 +
>  hw/{timer =3D> rtc}/m41t80.c | 0
>  hw/timer/Kconfig           | 4 ----
>  hw/timer/Makefile.objs     | 1 -
>  6 files changed, 6 insertions(+), 6 deletions(-)
>  rename hw/{timer =3D> rtc}/m41t80.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 679b026fe0..fd68b2383a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1113,7 +1113,7 @@ F: hw/ppc/sam460ex.c
>  F: hw/ppc/ppc440_pcix.c
>  F: hw/display/sm501*
>  F: hw/ide/sii3112.c
> -F: hw/timer/m41t80.c
> +F: hw/rtc/m41t80.c
>  F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 159c233517..434b20b2b1 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,3 +1,7 @@
> +config M41T80
> +    bool
> +    depends on I2C
> +
>  config M48T59
>      bool
>
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index c87f81405e..89e8e48c64 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1,3 +1,4 @@
> +common-obj-$(CONFIG_M41T80) +=3D m41t80.o
>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
>  ifeq ($(CONFIG_ISA_BUS),y)
>  common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> diff --git a/hw/timer/m41t80.c b/hw/rtc/m41t80.c
> similarity index 100%
> rename from hw/timer/m41t80.c
> rename to hw/rtc/m41t80.c
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index a57e9b59fc..a6b668b255 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -20,10 +20,6 @@ config HPET
>  config I8254
>      bool
>
> -config M41T80
> -    bool
> -    depends on I2C
> -
>  config TWL92230
>      bool
>      depends on I2C
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index fe2d1fbc40..2fb12162a6 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -6,7 +6,6 @@ common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
> -common-obj-$(CONFIG_M41T80) +=3D m41t80.o
>  common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
>  common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
> --
> 2.20.1
>
>

