Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF837C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 22:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725B121883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 22:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ownyjE0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725B121883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Hie-00007Z-Iq
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 18:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i5Hhs-0007tT-5J
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 18:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i5Hhr-0008Cb-3t
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 18:55:24 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i5Hhq-0008Bh-Rz; Tue, 03 Sep 2019 18:55:23 -0400
Received: by mail-lj1-x244.google.com with SMTP id e17so6695156ljf.13;
 Tue, 03 Sep 2019 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+8Z7lgG57vQ2/yBLQqx76xo0fBYpHJQthGArthUlr+w=;
 b=ownyjE0r+JBG92A1Qf1f0GxvHa9KhgFOhwhe3OAm9OqCOVowc/T2iTHorzJB47pXNt
 AjuTpd+ShfRN2dB0QNwWLIIwe7DMzLvmvvZiP108Jg6xfhm95DsG/YVtMbbuIqcEIIOP
 vAlFPzA3vuu0C/I4y+i7mSGKnaa8dYZQbj20IpWFiDOL0x4uHwqgpWBGmHyc28Xe3aqm
 0h6DENZfw4CMc85icZeR+dz8hDaT0Dr9wdr5UrExlWNdSin+Fx5ePCnUNBzOPM2CAi8h
 47i12YGvGaC14hjjox4ZhRxjhaQYHZfgytoVew8nSUdVy3k9LD0YKVoJqHEmiGzFRAqe
 WUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+8Z7lgG57vQ2/yBLQqx76xo0fBYpHJQthGArthUlr+w=;
 b=NFwWU8zqwc3W3r1iIZ6T3q9KUSU48pnXZ2GJ9GgKoTdqAWA5XCeCW2On6AkzGgfSbn
 3a9Kw/mekEt8wJryHQ8xV0ymIYWSoEPtc+FCbfEYy+JP4jF6+lImkAC9DxQJBKbbF6na
 sWA4DNQoLm17h77tmcqwPwjDVCsLp5m8xz4FQxCIGGfY38uoL5VzZctDIxgeC/fhHxQG
 cLooo++h/1cKr6IxN2HsImy9BN2semxYuctNAO8wYhibaM0uKLebbUNgciEr2M3MY2wS
 F9G0NMLuNBz9TEj3xp2n/Y0kLELfKkd3SM94WFUDUx7ttiLzzNZxCd/ld59xFFe5WXQP
 ekWw==
X-Gm-Message-State: APjAAAWT/nTX45lILJU8DcDGNJi69Pdr0n3xUyDi1kKOD7WH0uvZ7EC7
 qAMHoALC2Z0TUIEaifI413bnn2Z869gHW+xCYStT1dX5Ya8=
X-Google-Smtp-Source: APXvYqxSm02sTj7GpMdy155PpInqJLx8uugRrA+mQ0nu4WlD7VoKjPer7qCg+Phc/xtSxipw2BL9JXPzlWSuqyDzfZQ=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr21100413ljb.33.1567551320702; 
 Tue, 03 Sep 2019 15:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190903114729.3400-1-philmd@redhat.com>
 <20190903114729.3400-4-philmd@redhat.com>
In-Reply-To: <20190903114729.3400-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Sep 2019 15:54:54 -0700
Message-ID: <CAKmqyKNdbbhc+knpetPvsHxHV=tNvNsvvzBCkijgSsGju1QSgw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 3/5] hw/arm: Restrict pre-ARMv7 cpus to
 TCG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 3, 2019 at 4:48 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> A KVM-only build won't be able to run pre-ARMv7 cpus, disable them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: - "depends on !KVM" -> "depends on TCG" (rth)
>     - do not modify default-configs/arm-softmmu.mak (thuth)
> ---
>  hw/arm/Kconfig | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 76a2a6bcbf..1c359a6f47 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -1,3 +1,15 @@
> +config ARM_V4
> +    depends on TCG
> +    bool
> +
> +config ARM_V5
> +    depends on TCG
> +    bool
> +
> +config ARM_V6
> +    depends on TCG
> +    bool
> +
>  config ARM_VIRT
>      bool
>      imply PCI_DEVICES
> @@ -23,6 +35,7 @@ config ARM_VIRT
>
>  config CHEETAH
>      bool
> +    select ARM_V4
>      select OMAP
>      select TSC210X
>
> @@ -32,6 +45,7 @@ config CUBIEBOARD
>
>  config DIGIC
>      bool
> +    select ARM_V5
>      select PTIMER
>      select PFLASH_CFI02
>
> @@ -61,6 +75,7 @@ config HIGHBANK
>
>  config INTEGRATOR
>      bool
> +    select ARM_V5
>      select ARM_TIMER
>      select INTEGRATOR_DEBUG
>      select PL011 # UART
> @@ -86,6 +101,7 @@ config MUSCA
>
>  config MUSICPAL
>      bool
> +    select ARM_V5
>      select BITBANG_I2C
>      select MARVELL_88W8618
>      select PTIMER
> @@ -99,6 +115,7 @@ config NETDUINO2
>
>  config NSERIES
>      bool
> +    select ARM_V6
>      select OMAP
>      select TMP105   # tempature sensor
>      select BLIZZARD # LCD/TV controller
> @@ -121,6 +138,7 @@ config OMAP
>
>  config PXA2XX
>      bool
> +    select ARM_V5
>      select FRAMEBUFFER
>      select I2C
>      select SERIAL
> @@ -232,10 +250,12 @@ config COLLIE
>
>  config SX1
>      bool
> +    select ARM_V4
>      select OMAP
>
>  config VERSATILE
>      bool
> +    select ARM_V5
>      select ARM_TIMER # sp804
>      select PFLASH_CFI01
>      select LSI_SCSI_PCI
> @@ -327,6 +347,7 @@ config XLNX_VERSAL
>
>  config FSL_IMX25
>      bool
> +    select ARM_V5
>      select IMX
>      select IMX_FEC
>      select IMX_I2C
> @@ -334,6 +355,7 @@ config FSL_IMX25
>
>  config FSL_IMX31
>      bool
> +    select ARM_V6
>      select SERIAL
>      select IMX
>      select IMX_I2C
> @@ -349,6 +371,7 @@ config FSL_IMX6
>
>  config ASPEED_SOC
>      bool
> +    select ARM_V5
>      select DS1338
>      select FTGMAC100
>      select I2C
> --
> 2.20.1
>
>

