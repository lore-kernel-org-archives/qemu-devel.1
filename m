Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253F0C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 15:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1896217F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 15:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP1H/WjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1896217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEbOy-0006vO-7K
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 11:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iEbNK-00063p-Gq
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 11:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iEbNI-0005Gd-ME
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 11:44:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iEbNI-0005C3-CD; Sun, 29 Sep 2019 11:44:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so10622344wme.1;
 Sun, 29 Sep 2019 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=U+PpBRXD87EEtIopkNPmczkYp/++2aPpGB5jY2ELCok=;
 b=UP1H/WjYeCU30SMLWIE2GUXnu3wKfAKoA2v0qFTMctL9iqDn2G54eIYf3E+lXCGlLb
 4rTry1EPkNSL0Ers9I5BfZY8N3lVy0ngJ+KSAP/c3RPKl8X0bJSa0m4yciQmdW3aExSr
 FdtpIltix7M9FZunRBIJVzkJwE3IWovM8v/C/bw+r4ftdlabaARZTjGTNFShLP6khiDr
 Bi94MeY9o8S1vbcAjVCs+vzmn0SyT6KR2ScHablhyaN5IoSWz3PJSA3QfXblWnhogp3b
 AoDLxGWULSgRUQTeVv+SVVkuPpgawmNXmb9xpmFT0y7DvNu1uQu640juXV60j2cGR9Vp
 wq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=U+PpBRXD87EEtIopkNPmczkYp/++2aPpGB5jY2ELCok=;
 b=rtNPvUmYrCA2f+tiRndaBr+4I63FJe8WWorBOcVnHqEgsEBvv5/47uvnBVA5r24eX9
 WqSxnt8oCIDO88Be1mt+z6kh0sdLwNOiB40zAx+Id6JStu/mRw8iRH27lLOdDAyoum2E
 PSJjAAwC8u/vdbfYJBpZvtnT4DzQBiEKcyZiDZHwNDEJJ9z5wabqWOqLfktlrFRXWqHB
 y7TmFQZzOMjXs7p23hqD8WFmQkgaORNkGTYsmm2D9K2rtP9EPvzy8+tqsW8phWZf0g2W
 yXn+J2VGnq1X90R6fEdOIlDtR0Fu4UB0s6m82h5XdHYKGD7yGfRIlB34riVYJteehNRJ
 OEYg==
X-Gm-Message-State: APjAAAWDDPvW89bl3Pitueu/4XeKt5xqoiTmLQ20JbKTMgbiNcmoCE8z
 Lu1wuQjFoQu4GRiqqvV7HN0=
X-Google-Smtp-Source: APXvYqz2UK47AbODbSYVLSbIdG+Td6HTCyC6ftSJeE+wPb2XwcaYX9RERePTlEk6bUmHs+Y/CS4Nqg==
X-Received: by 2002:a05:600c:2108:: with SMTP id
 u8mr14771480wml.13.1569771878596; 
 Sun, 29 Sep 2019 08:44:38 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id e20sm22570496wrc.34.2019.09.29.08.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 08:44:38 -0700 (PDT)
Message-ID: <1a2fbee61f06d382adab396f6074ae66583a442f.camel@gmail.com>
Subject: Re: [PATCH 11/14] hw/arm/bcm2835_peripherals: Map various BCM2838
 blocks
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 17:44:27 +0200
In-Reply-To: <20190904171315.8354-12-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-12-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El mié, 04-09-2019 a las 19:13 +0200, Philippe Mathieu-Daudé escribió:
> The BCM2838 provides more peripherals.
> Add them as 'unimplemented' so we can track when/how firmware
> and kernel access them.
> 
> Based on various sources:
> 
> * U-boot: https://github.com/raspberrypi/firmware/tree/next/boot
> 
>   - arch/arm/dts/bcm283x.dtsi
>   - arch/arm/dts/bcm2838.dtsi
>   - arch/arm/dts/bcm2838-rpi-4-b.dts
> 
> * Arnd Bergmann analysis: 
> https://www.cnx-software.com/2019/06/24/raspberry-pi-4-features-broadcom-bcm2711-processor-up-to-4gb-ram/#comment-563948
> 
> * Linux: https://patchwork.kernel.org/patch/11053097/
> 
>   - arch/arm/boot/dts/bcm283x.dtsi
>   - arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
>   - arch/arm/boot/dts/bcm2711.dtsi
>   - arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> TODO: At least use proper pl011[2] and pl011[3]
> ---
>  hw/arm/bcm2835_peripherals.c         | 23 +++++++++++++++++++----
>  include/hw/arm/bcm2835_peripherals.h |  8 ++++++--
>  include/hw/arm/raspi_platform.h      | 14 ++++++++++++++
>  3 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c
> b/hw/arm/bcm2835_peripherals.c
> index be6270b8ef..72287d5921 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -342,15 +342,30 @@ static void
> bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>      create_unimp(s, &s->a2w, "bcm2835-a2w", 0x102000, 0x1000);
>      create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>      create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
> -    create_unimp(s, &s->spi0, "bcm2835-spi0", SPI0_OFFSET, 0x20);
> +    create_unimp(s, &s->uartu[2], "!pl011[2]", UART2_OFFSET, 0x100);
> +    create_unimp(s, &s->uartu[3], "!pl011[3]", UART3_OFFSET, 0x100);
> +    create_unimp(s, &s->uartu[4], "!pl011[4]", UART4_OFFSET, 0x100);
> +    create_unimp(s, &s->uartu[5], "!pl011[5]", UART5_OFFSET, 0x100);
> +    create_unimp(s, &s->spi[0], "bcm2835-spi[0]", SPI0_OFFSET,
> 0x20);
> +    create_unimp(s, &s->spi[3], "bcm2835-spi[3]", SPI3_OFFSET,
> 0x20);
> +    create_unimp(s, &s->spi[4], "bcm2835-spi[4]", SPI4_OFFSET,
> 0x20);
> +    create_unimp(s, &s->spi[5], "bcm2835-spi[5]", SPI5_OFFSET,
> 0x20);
> +    create_unimp(s, &s->spi[6], "bcm2835-spi[6]", SPI6_OFFSET,
> 0x20);
>      create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET,
> 0x100);
> -    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
> -    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
> -    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
> +    create_unimp(s, &s->i2c[0], "bcm2835-i2c[0]", BSC0_OFFSET,
> 0x20);
> +    create_unimp(s, &s->i2c[1], "bcm2835-i2c[1]", BSC1_OFFSET,
> 0x20);
> +    create_unimp(s, &s->i2c[2], "bcm2835-i2c[2]", BSC2_OFFSET,
> 0x20);
> +    create_unimp(s, &s->i2c[3], "bcm2835-i2c[3]", BSC3_OFFSET,
> 0x20);
> +    create_unimp(s, &s->i2c[4], "bcm2835-i2c[4]", BSC4_OFFSET,
> 0x20);
> +    create_unimp(s, &s->i2c[5], "bcm2835-i2c[5]", BSC5_OFFSET,
> 0x20);
> +    create_unimp(s, &s->i2c[6], "bcm2835-i2c[6]", BSC6_OFFSET,
> 0x20);
>      create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
>      create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
>      create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
>      create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x100);
> +    create_unimp(s, &s->xhci, "bcm2838-xhci", USB_XHCI_OFFSET,
> 0x100000);
> +    create_unimp(s, &s->argon, "bcm2838-argon", ARGON_OFFSET, 4 *
> 0x10000);
> +    create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x10000);
>      create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET,
> 0x100);
>  }
>  
> diff --git a/include/hw/arm/bcm2835_peripherals.h
> b/include/hw/arm/bcm2835_peripherals.h
> index 44a182b399..2e5f243b39 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -42,6 +42,7 @@ typedef struct BCM2835PeripheralState {
>      UnimplementedDeviceState cprman;
>      UnimplementedDeviceState a2w;
>      PL011State uart0;
> +    UnimplementedDeviceState uartu[6];
>      BCM2835AuxState aux;
>      BCM2835FBState fb;
>      BCM2835DMAState dma;
> @@ -53,14 +54,17 @@ typedef struct BCM2835PeripheralState {
>      BCM2835SDHostState sdhost;
>      BCM2835GpioState gpio;
>      UnimplementedDeviceState i2s;
> -    UnimplementedDeviceState spi0;
> -    UnimplementedDeviceState i2c[3];
> +    UnimplementedDeviceState spi[7];
> +    UnimplementedDeviceState i2c[7];
>      UnimplementedDeviceState otp;
>      UnimplementedDeviceState dbus;
>      UnimplementedDeviceState ave0;
>      UnimplementedDeviceState bscsl;
>      UnimplementedDeviceState smi;
>      UnimplementedDeviceState dwc2;
> +    UnimplementedDeviceState xhci;
> +    UnimplementedDeviceState argon;
> +    UnimplementedDeviceState v3d;
>      UnimplementedDeviceState sdramc;
>  } BCM2835PeripheralState;
>  
> diff --git a/include/hw/arm/raspi_platform.h
> b/include/hw/arm/raspi_platform.h
> index c6f4985522..0ea547669f 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -49,10 +49,22 @@
>  #define RNG_OFFSET              0x104000
>  #define GPIO_OFFSET             0x200000
>  #define UART0_OFFSET            0x201000 /* PL011 */
> +#define UART2_OFFSET            0x201400 /* PL011 */
> +#define UART3_OFFSET            0x201600 /* PL011 */
> +#define UART4_OFFSET            0x201800 /* PL011 */
> +#define UART5_OFFSET            0x201a00 /* PL011 */
>  #define MMCI0_OFFSET            0x202000 /* Legacy MMC */
>  #define I2S_OFFSET              0x203000 /* PCM */
>  #define SPI0_OFFSET             0x204000 /* SPI master */
> +#define SPI3_OFFSET             0x204600
> +#define SPI4_OFFSET             0x204800
> +#define SPI5_OFFSET             0x204a00
> +#define SPI6_OFFSET             0x204c00
>  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> +#define BSC3_OFFSET             0x205600
> +#define BSC4_OFFSET             0x205800
> +#define BSC5_OFFSET             0x205a00
> +#define BSC6_OFFSET             0x205c00
>  #define PIXV0_OFFSET            0x206000
>  #define PIXV1_OFFSET            0x207000
>  #define DPI_OFFSET              0x208000
> @@ -84,6 +96,8 @@
>  #define DBUS_OFFSET             0x900000
>  #define AVE0_OFFSET             0x910000
>  #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller
> */
> +#define USB_XHCI_OFFSET         0x9c0000 /* generic-xhci controller
> */
> +#define ARGON_OFFSET            0xb00000
>  #define V3D_OFFSET              0xc00000
>  #define SDRAMC_OFFSET           0xe00000
>  #define L2CC_OFFSET             0xe01000 /* Level 2 Cache controller
> */
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


