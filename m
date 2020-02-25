Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F061FC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A55C21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIGZ14+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A55C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a6o-0006Ot-Qt
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Zcu-0006TJ-55
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Zcs-0007Ny-Ts
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:52 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Zcs-0007Ne-OX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so11942973oty.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/s7kcgzjK6Jcd+lbezo/Ccp7/oxDgNdlRqtHaMhsg7E=;
 b=SIGZ14+L/T4pUJ7s5q8BJoGdGbwusvHd39ts3++WjorzQF4mgBdbGNdrI9a2dFNyKN
 LWyt0ZWAuD4ok65VQuLb/AKe4QqNxpTsvj5iP6xVLYAcIjQu4B9CCP9DbQvHliwHRn7E
 klMQAj3LBf/B1N0g5KaxCQhBAbf/rHalwpg4X1qOHF2Gqc3MKMvuIKd36Kfa4HNryDaY
 02gOq2wqbDzrAbql0z6a9rSNcNEykoANoZUMi/xJm23IwTukgAiGfeDYaUnJa0DMtNwj
 /ORGK2p0w6/ua+dG31Eh1tJ+fmfZfAIJ7X/PMdPmTako2ts0k3gk2nZhYUvtMJdiacZJ
 6RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/s7kcgzjK6Jcd+lbezo/Ccp7/oxDgNdlRqtHaMhsg7E=;
 b=h56flYPiYxRbGhgjtquJiJKbZHeEIWR1PCf1z6bxDuYfxBoTihrNLEltN4XkvkjEJu
 PG9hq32myvTwb2IywopPSUB6GIeDPQcIb7kxNpO5dDp2DRU2En9ux/vD4w350Lz4MbXd
 kmPO5IbGPPP846mZWExUN0QXrJGB1YK+YEAraPypNHVUU7zkkLuZFqnijAOp1L7JiBIV
 vj8zpK83APeCC0wCDr8b9mOBpb9kEol/+rmvw0wPPuJ10UUUi/1KvrGMro3gLOTjSwdA
 580Qx0oNPnxj9TvmaDEOMusAwzKBPhZnL1hh/NasoRjYFaY33XttrIcDvRqdKs6NYb1+
 nROg==
X-Gm-Message-State: APjAAAUYzENde70pklsJdBYlPSrnv4cGKjGllQ8IEQOgMhGhewRni/H0
 6fFYvU1+qZ0ZoP9pvbJe6sUk7BJRTbO6j6B7C8npdQ==
X-Google-Smtp-Source: APXvYqzvJJJZAsuu/uKjBXy5ZW5E3m0RSXqNcogEeaug5xIXXKPHOVfhT5eJpInzGmCU6RAHlDpJC+BNVRqwPBSera0=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr44866318ota.232.1582634869785; 
 Tue, 25 Feb 2020 04:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20200223233033.15371-1-f4bug@amsat.org>
 <20200223233033.15371-3-f4bug@amsat.org>
In-Reply-To: <20200223233033.15371-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 12:47:38 +0000
Message-ID: <CAFEAcA9bZJ9X20SX-5J2M6rWEhNC=un3Re3RVhGGHD1qMEdWtw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] hw/arm/integratorcp: Map a CFI parallel flash
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Feb 2020 at 23:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The Linux kernel displays errors why trying to detect the flash:
>
>   Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (Lin=
aro GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
>   CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00093177
>   CPU: VIVT data cache, VIVT instruction cache
>   OF: fdt: Machine model: ARM Integrator/CP
>   ...
>   of-flash 24000000.flash: Integrator/CP flash protection
>   of-flash 24000000.flash: do_map_probe() failed for type cfi_probe
>   of-flash 24000000.flash: do_map_probe() failed
>
> Since we have a CFI pflash model available, wire it.
> The kernel properly detects it:
>
>   of-flash 24000000.flash: Integrator/CP flash protection
>   24000000.flash: Found 1 x32 devices at 0x0 in 32-bit bank. Manufacturer=
 ID 0x000000 Chip ID 0x000000
>   Intel/Sharp Extended Query Table at 0x0031
>   Using buffer write method
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: Kconfig change was not committed
>
> RFC because I have no idea of the flash model, its ID code, and which
> default CFI family (1 or 2).

ARM DUI 0102G ("ARM Firmware Suite Reference Guide") helpfully has
a few details:

Device                                  Size  Organization     Flash part
Integrator/AP Boot flash               512KB  1x512K block     Atmel AT49LV=
040
Integrator/AP Application flash         32MB  256x128K blocks  Intel 28F320=
S3
Integrator/CP Boot/Application flash    16MB  64x256K blocks   Intel 28F640=
J3A

(of which we only model the CP.) With luck that's enough to
nail down the relevant device properties.

> @@ -646,6 +649,14 @@ static void integratorcp_init(MachineState *machine)
>                            qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDI=
N, 0));
>      sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
>
> +    dinfo =3D drive_get(IF_PFLASH, 0, 0);
> +    if (!pflash_cfi01_register(0x24000000, "pflash", 16 * MiB,
> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
> +                               64 * KiB, 4, 0, 0, 0, 0, 0)) {
> +        error_report("Error registering flash memory");
> +        exit(1);
> +    }

Passing a 'width' argument of 0 means "weird legacy backcompat
device that's a bad emulation of a pair of 16-bit devices";
we should avoid that for new code, and instead set
the width and device-width properties to whatever the
hardware has. (This in turn means you can't use the old
pflash_cfi01_register() function.)

Should we be using blk_by_legacy_dinfo() in new code?
I'm not sure if there's a better way to do this if we don't
need to maintain back-compat with old commandline specifications
of the flash contents.

thanks
-- PMM

