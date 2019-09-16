Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016AFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F82214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItSHY9nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F82214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yra-0002K4-1M
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9yqW-0001e2-7z
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9yqV-0002i9-6l
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:47:44 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9yqU-0002gQ-VG; Mon, 16 Sep 2019 17:47:43 -0400
Received: by mail-lf1-x143.google.com with SMTP id r2so1141389lfn.8;
 Mon, 16 Sep 2019 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d6KsQJZ4uOyC2kdk7MqSRWQlWcAq1Lv8qHXSBMW/b9Q=;
 b=ItSHY9nOzTCzVMLRr4d2oWSz6AoLhREAUiG8wFWG/VNkS8A+COXukZvpLFtWXv9mgZ
 oWMfGQrjiLS4dC6ZuwWXClpywoEesNvYH32NBUAePfWCE0ShEVPI//yZk6ZSGaE9EjcC
 784pA+OPRnOOhXqSmX6w8NsH2Qhh+WfwcB+wI5ZHJR5DzqudQegwLIq7wMQTfVm7nSAB
 z4pqlwmpVvTYs7eMJBvku+Nx8D34yylijFqYWXVV3FYivtq/t3UOqnhV7EraQaLWxnBd
 ZDVSysaR1uTyi6U12Zv8ofU0yG/bm+dqWeTKxnhMqENATy8Gh3Gs/Wx/A4DLT1xGyjJt
 Lbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d6KsQJZ4uOyC2kdk7MqSRWQlWcAq1Lv8qHXSBMW/b9Q=;
 b=g6vsZKYyCP7w9q5ZycPUKqeGM0oPiIdVZ4r9MJ7NsxJEbgi72Hn62h4TutW9YgjoP+
 m9m0luWaS2HO0xvTh1ReN1APUmQmb9bkabIxx/yq1nHxJG8/2wzhea0af3UdeMOQHPg1
 RBPwIxHWZFbSwtzgoa6Yh9dbezyk+ieMaUlZJ+oYe+RnriZy0Mka7Z/D/bqF3HMBkyZD
 K3yDL4A6ZEJysz2ni02KqMULHADR72xjfez/KBu1AIZq+FDOQcTxbroK4JI81Ae9iMRh
 +IVCw7jYi15sPfvfGzYA2oSXsj9wD7WHeWOikO9/VgJOaMBNC27cftRVzlBecd11kwLG
 VH5A==
X-Gm-Message-State: APjAAAWH/GqJaCAzDan9tGV6bsxvEWl6r1AM/fwFvw1Hqfv8Q3VED1+v
 SN1wt3cusD1g8qnjy9VIa8/kg+KFb1XVmQpZXts=
X-Google-Smtp-Source: APXvYqz203nAyxQdvO8s2n6qurpE5FzGJMudr1vTtDG4MPrBc6JmfPLjFBZ5gYBsM4T11A1YS29XodOFansiaL+Kky8=
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr176281lfp.86.1568670461772;
 Mon, 16 Sep 2019 14:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-9-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-9-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:43:10 -0700
Message-ID: <CAKmqyKOFCbNyOvrm2Y4UuB9X96dGO5NEz1=yZju0kqhJ-j_vOA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 08/13] hw: Move DS1338 device from
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

On Mon, Sep 16, 2019 at 9:39 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The DS1338 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/rtc/Kconfig             | 4 ++++
>  hw/rtc/Makefile.objs       | 1 +
>  hw/{timer =3D> rtc}/ds1338.c | 0
>  hw/timer/Kconfig           | 4 ----
>  hw/timer/Makefile.objs     | 1 -
>  5 files changed, 5 insertions(+), 5 deletions(-)
>  rename hw/{timer =3D> rtc}/ds1338.c (100%)
>
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index dff9d60946..45daa8d655 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,3 +1,7 @@
> +config DS1338
> +    bool
> +    depends on I2C
> +
>  config M41T80
>      bool
>      depends on I2C
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 810a38ee7b..b195863291 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1,3 +1,4 @@
> +common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_M41T80) +=3D m41t80.o
>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
>  ifeq ($(CONFIG_ISA_BUS),y)
> diff --git a/hw/timer/ds1338.c b/hw/rtc/ds1338.c
> similarity index 100%
> rename from hw/timer/ds1338.c
> rename to hw/rtc/ds1338.c
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 9357875f28..a990f9fe35 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -9,10 +9,6 @@ config ARM_MPTIMER
>  config A9_GTIMER
>      bool
>
> -config DS1338
> -    bool
> -    depends on I2C
> -
>  config HPET
>      bool
>      default y if PC
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 23be70b71d..70b61b69c7 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -3,7 +3,6 @@ common-obj-$(CONFIG_ARM_MPTIMER) +=3D arm_mptimer.o
>  common-obj-$(CONFIG_ARM_V7M) +=3D armv7m_systick.o
>  common-obj-$(CONFIG_A9_GTIMER) +=3D a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
> -common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
> --
> 2.20.1
>
>

