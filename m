Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F63C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE202074B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAu5Falp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE202074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8Pv-0002JK-FW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg8Oj-0001cy-E7; Tue, 02 Jun 2020 11:00:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg8Oi-0001Bs-5Q; Tue, 02 Jun 2020 11:00:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id j198so2442382wmj.0;
 Tue, 02 Jun 2020 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LP4IaES+Cgr4zDPbJ6yM8Eq9WPEoFGx8egQ6nV/yoXk=;
 b=tAu5Falp0P3uHZrWyfopi3YAxu0joL6vo0bUueuQ2wp/iPCNb1TLIEcPrYlVnyyPk8
 IERZbCS1F8Ewhy4pznEIZFl0gmcGJqRBTHxFV8np1MG0eayzeYhONvI5Rh6Cw+ZOoO/t
 Kaz5pAPczlh3GzWTKsNNM3yoMFdpQSem3ZPQqQ6MnComq4YghgD32ytLJGjKuFITJ9qd
 NzjSMF3LDBZylBTHOyk5czDQohbNUV0Cq5nMleUsmeV++wq+HFAl4gFAfvZc5+YhAkcz
 L8kCR2M+dVsqHI8+r/TtdTQw/kmAwgor1dmGUdGc46AZOWj1oPhFvgv1rPxdX/zwWApy
 Ofeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LP4IaES+Cgr4zDPbJ6yM8Eq9WPEoFGx8egQ6nV/yoXk=;
 b=Cvvf1BXm+CBaBekgZKJLEm3a18o1DyFwfQ2sw037NOI7uxD3c+d7HMWU/fApiWpo8i
 LhdihDIwMUYgs5I0+yY/iOEsxMDr9nJ9QRo04Ms8bTUIwhXt1LX2d48E6GMHxUBaCgxt
 tq0J9C0rNmGK708P3QZWLm3SLlAN1+fi9JX9AWQicEkBScuRFD9fhNOMFL9SqvxzFClq
 iEahqSV4kWvsY5CiDHB7TalmvYxIh3k7zlcHA9Uthn3aHGzq/T2XwyhrBExg2X/wVI8o
 Oi1FeAZjwyxlH4sErrA46a5VJF11On7hRAcON5gVEfX38d32+mQ/n7By+tQRg/VEVBdp
 7O+w==
X-Gm-Message-State: AOAM5334BoZB9McfDb59mcfBPZ9kPw7kg0IEKv7K9J+R9irMh8+8J0IQ
 tch6Pj1KEqCJEOg0S3p+lvGIUWgw
X-Google-Smtp-Source: ABdhPJztGDzM5LgSZm+0dEO0RXI8Tzaz1SPUvqP7q/msYP1Rc6IOFLGWqPNLUCBx/JeRageetKE4KQ==
X-Received: by 2002:a1c:a5ce:: with SMTP id o197mr4687922wme.85.1591110009946; 
 Tue, 02 Jun 2020 08:00:09 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 5sm70629wmz.16.2020.06.02.08.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 08:00:09 -0700 (PDT)
Subject: Re: [PATCH] docs/system: Document Aspeed boards
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200602135050.593692-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a46437ce-1be4-3c0a-8403-1c279ad8b90b@amsat.org>
Date: Tue, 2 Jun 2020 17:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200602135050.593692-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 3:50 PM, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  docs/system/arm/aspeed.rst | 85 ++++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst |  1 +
>  2 files changed, 86 insertions(+)
>  create mode 100644 docs/system/arm/aspeed.rst
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> new file mode 100644
> index 000000000000..45f891eb3cad
> --- /dev/null
> +++ b/docs/system/arm/aspeed.rst
> @@ -0,0 +1,85 @@
> +Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``)
> +==================================================================
> +
> +The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
> +Aspeed evaluation boards. They are based on different releases of the
> +Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
> +AST2500 with an ARM1176JZS CPU (800MHz) and more recently the AST2600
> +with dual cores ARM Cortex A7 CPUs (1.2GHz).
> +
> +The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
> +etc.
> +
> +AST2400 SoC based machines :
> +
> +- ``palmetto-bmc``         OpenPOWER Palmetto POWER8 BMC
> +
> +AST2500 SoC based machines :
> +
> +- ``ast2500-evb``          Aspeed AST2500 Evaluation board
> +- ``romulus-bmc``          OpenPOWER Romulus POWER9 BMC
> +- ``witherspoon-bmc``      OpenPOWER Witherspoon POWER9 BMC
> +- ``sonorapass-bmc``       OCP SonoraPass BMC
> +- ``swift-bmc``            OpenPOWER Swift BMC POWER9
> +
> +AST2600 SoC based machines :
> +
> +- ``ast2600-evb``          Aspeed AST2600 Evaluation board (Cortex A7)
> +- ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC
> +
> +Supported devices
> +-----------------
> +
> + * SMP (for the AST2600 Cortex-A7)
> + * Interrupt Controller (VIC)
> + * Timer Controller
> + * RTC Controller
> + * I2C Controller
> + * System Control Unit (SCU)
> + * SRAM mapping
> + * X-DMA Controller (basic interface)
> + * Static Memory Controller (SMC or FMC) - Only SPI Flash support
> + * SPI Memory Controller
> + * USB 2.0 Controller
> + * SD/MMC storage controllers
> + * SDRAM controller (dummy interface for basic settings and training)
> + * Watchdog Controller
> + * GPIO Controller (Master only)
> + * UART
> + * Ethernet controllers
> +
> +
> +Missing devices
> +---------------
> +
> + * Coprocessor support
> + * ADC (out of tree implementation)
> + * PWM and Fan Controller
> + * LPC Bus Controller
> + * Slave GPIO Controller
> + * Super I/O Controller

Is there public datasheet for this?

> + * Hash/Crypto Engine
> + * PCI-Express 1 Controller
> + * Graphic Display Controller
> + * PECI Controller
> + * MCTP Controller
> + * Mailbox Controller
> + * Virtual UART

Uh what is that? :)

> + * eSPI Controller
> + * I3C Controller
> +
> +Boot options
> +------------
> +
> +The Aspeed machines can be started using the -kernel option to load a
> +Linux kernel or from a firmare image which can be downloaded from the
> +OpenPOWER jenkins :
> +
> +   https://openpower.xyz/
> +
> +The image should be attached as an MTD drive. Run :
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -M romulus-bmc -nic user \
> +	-drive file=flash-romulus,format=raw,if=mtd -nographic
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index dce384cb0e3e..1bd477a2936c 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -81,6 +81,7 @@ undocumented; you can get a complete list by running
>     arm/realview
>     arm/versatile
>     arm/vexpress
> +   arm/aspeed

Maybe we should keep this section sorted.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>     arm/musicpal
>     arm/nseries
>     arm/orangepi
>

