Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F585C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B49F20658
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 19:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CykNEQzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B49F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDueI-0006eo-AT
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 15:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDudj-0006E3-KU; Thu, 03 Sep 2020 15:11:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDudh-0008Ci-LB; Thu, 03 Sep 2020 15:11:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id q9so3941719wmj.2;
 Thu, 03 Sep 2020 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5nM72480vaeVQaDhqXyKdo3mtvfUvuL74vJ1YKyfIRE=;
 b=CykNEQzQlKR/rzL+dLm60FxIDNxGvtMxkhAkQB2fCgKByh9NsOJm3Qzh+iZNRDakq1
 lOlUUXPvvD0Y6uy2+EHDOZmKkXuZ0yBwt58GP02JUBEnEGfnQzZFMJAP1wBC5mhIvese
 6Xqq7bAoV8l3eqxsNWxIUCh0sUKI+1gSE/358TV5HbVcZd/EWdGd4mHtPvx7n3mt+P6W
 p8gEbQXje3V7JTDrVZSIcdh8Wlzc04mrwMu7DIuauxvZtLHQ/CuTMTHomJNy3D54KbhJ
 5zQKvJjpJcOvnRzQCu36mDiqG1bwlHLk76qc8mRrhU2IhU5apMheRvwMieNsZ+/fSi1u
 HJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5nM72480vaeVQaDhqXyKdo3mtvfUvuL74vJ1YKyfIRE=;
 b=siLQFa/XUBdf2dhJmSfZv7rrrgEKBv43eHH3nmteYXwIRxOqu0hWN22aBUYAZgnokF
 LmZaptOsdtP0B91PQLZQJK4SA/6fajM+M7HKZO1JAP+4FtT3Sh2LwemCm962IFc6wD3b
 rrnLCTda2R7raCLnP2e/hhcsk/V5U4BLgHKv/GZ9pMsgxKbataUtPQP5o/uqZbvvLEzY
 FK5W0r4axhh2MFrydKI2afcTGf3O0qgvPNvUC+jwhasRTblgw/eVKcp7Cs7ItiBO3P6a
 P2cReYQW+gwtmgV2nfw9VmKKG+lHY6HFTzVR/DkTp6GTVfWlU+TVKwchfJQqigDvRgak
 YnnA==
X-Gm-Message-State: AOAM533NMKWA8WOPrPDxDFycHnYBrFJvpp80A+hxLUIihF9eyqOltGtw
 POmUqaTdcwsNHuEG3eSco/s=
X-Google-Smtp-Source: ABdhPJyMpk0RlAqm+w+k6rFkV1R+NEyc+Ej9jKSsXpV9K+Wae1D5/fQ85AJpjp+qO30HjCQEE1yvmA==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr3852010wmc.142.1599160275751; 
 Thu, 03 Sep 2020 12:11:15 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id n11sm6005373wrx.91.2020.09.03.12.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 12:11:14 -0700 (PDT)
Subject: Re: [PATCH v8 13/14] docs/system: Add Nuvoton machine documentation
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200825001711.1340443-14-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e979aba1-3bfd-2263-1ed3-577b83ac1be3@amsat.org>
Date: Thu, 3 Sep 2020 21:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825001711.1340443-14-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kfting@nuvoton.com, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:17 AM, Havard Skinnemoen via wrote:
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  docs/system/arm/nuvoton.rst | 90 +++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst  |  1 +
>  2 files changed, 91 insertions(+)
>  create mode 100644 docs/system/arm/nuvoton.rst
> 
> diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
> new file mode 100644
> index 0000000000..36bf901122
> --- /dev/null
> +++ b/docs/system/arm/nuvoton.rst
> @@ -0,0 +1,90 @@
> +Nuvoton iBMC boards (``npcm750-evb``, ``quanta-gsj``)
> +=====================================================
> +
> +The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
> +designed to be used as Baseboard Management Controllers (BMCs) in various
> +servers. They all feature one or two ARM Cortex A9 CPU cores, as well as an
> +assortment of peripherals targeted for either Enterprise or Data Center /
> +Hyperscale applications. The former is a superset of the latter, so NPCM750 has
> +all the peripherals of NPCM730 and more.
> +
> +.. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
> +
> +The NPCM750 SoC has two Cortex A9 cores and is targeted for the Enterprise
> +segment. The following machines are based on this chip :
> +
> +- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board
> +
> +The NPCM730 SoC has two Cortex A9 cores and is targeted for Data Center and
> +Hyperscale applications. The following machines are based on this chip :
> +
> +- ``quanta-gsj``        Quanta GSJ server BMC
> +
> +There are also two more SoCs, NPCM710 and NPCM705, which are single-core
> +variants of NPCM750 and NPCM730, respectively. These are currently not
> +supported by QEMU.
> +
> +Supported devices
> +-----------------
> +
> + * SMP (Dual Core Cortex-A9)
> + * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private Timer
> +   and Watchdog.
> + * SRAM, ROM and DRAM mappings
> + * System Global Control Registers (GCR)
> + * Clock and reset controller (CLK)
> + * Timer controller (TIM)
> + * Serial ports (16550-based)
> + * DDR4 memory controller (dummy interface indicating memory training is done)
> + * OTP controllers (no protection features)
> + * Flash Interface Unit (FIU; no protection features)
> +
> +Missing devices
> +---------------
> +
> + * GPIO controller
> + * LPC/eSPI host-to-BMC interface, including
> +
> +   * Keyboard and mouse controller interface (KBCI)
> +   * Keyboard Controller Style (KCS) channels
> +   * BIOS POST code FIFO
> +   * System Wake-up Control (SWC)
> +   * Shared memory (SHM)
> +   * eSPI slave interface
> +
> + * Ethernet controllers (GMAC and EMC)
> + * USB host (USBH)
> + * USB device (USBD)
> + * SMBus controller (SMBF)
> + * Peripheral SPI controller (PSPI)
> + * Analog to Digital Converter (ADC)
> + * SD/MMC host
> + * Random Number Generator (RNG)
> + * PECI interface
> + * Pulse Width Modulation (PWM)
> + * Tachometer
> + * PCI and PCIe root complex and bridges
> + * VDM and MCTP support
> + * Serial I/O expansion
> + * LPC/eSPI host
> + * Coprocessor
> + * Graphics
> + * Video capture
> + * Encoding compression engine
> + * Security features
> +
> +Boot options
> +------------
> +
> +The Nuvoton machines can boot from an OpenBMC firmware image, or directly into
> +a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj` and
> +possibly others can be downloaded from the OpenPOWER jenkins :
> +
> +   https://openpower.xyz/
> +

Maybe mention the usual root password is '0penBmc'?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +The firmware image should be attached as an MTD drive. Example :
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -machine quanta-gsj -nographic \
> +      -drive file=image-bmc,if=mtd,bus=0,unit=0,format=raw
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index afdb37e738..fdcf25c237 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -86,6 +86,7 @@ undocumented; you can get a complete list by running
>     arm/musicpal
>     arm/gumstix
>     arm/nseries
> +   arm/nuvoton
>     arm/orangepi
>     arm/palm
>     arm/xscale
> 

