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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FB6C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 15:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C082086A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2Jy6sPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C082086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEb7m-0007Ld-Lv
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 11:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iEb6d-0006lq-Mm
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 11:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iEb6c-0005Fe-2o
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 11:27:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iEb6b-0005Ee-Q0; Sun, 29 Sep 2019 11:27:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so10598945wme.1;
 Sun, 29 Sep 2019 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=bMCb6LOHd+fuDrO7vVmSdWgZerHv61tnmFL2VWlbIrw=;
 b=p2Jy6sPlW3x/hcba8YeaMdXvj3CEX/Ad/aDNJoFGnrgb4jNWvBvPR4kFDZjzUXwSD8
 W/fcUK+lsuON/8Qid0ocJMTNvt8iPYZCMl+C5d+vnrHuwNx6Z09TcV4nudx5jPzs3h2v
 9iB6nx0fMYwzojKvlp50FV2ksciApnFTVMZ/AYgcJuj3USUbruhJNHHMqsNC7KTlNYwK
 mpdyLxwkZjYzn3WXXrea4PqvMWOgQMGadTiZ3lCptHQHfQon2ViqeBBm+UClViRC0Cb3
 6RuFKUrT44xw5B8XN42X8pPRToZrJ+INil7fz71DPxtHDZ4da7p6DwCKnjHIvNOoDhXZ
 le/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=bMCb6LOHd+fuDrO7vVmSdWgZerHv61tnmFL2VWlbIrw=;
 b=tIdBROv0oAhRAGLbZ1yZR9bw7XI2ZIiDj7/HP2LnzbqNexB0Qy3XgvGV5IoYfAkKOr
 eNMRHwXjMLBmhpeHmt2K1rjmac58RTNmBKE+iIWPw3/FFGziHIwPU/QB4UehhatgdQC8
 erj1ERLfe0wU0zE08WICf4ZUoj5uZVKrc8nBDH847W9vtskbHszlLSmBJF2brRRiTNkS
 ISkyOQR961naj2biu/SyFXC2Gcln/Ra4C7QHSPAnNy1WIoAZO0Pg4NvVFCpECFy23ti4
 ZjkH4be4tnCViYgEW2Ai9sfh3KBKUsUs1jCmbr0w42cY+xHywg3wvx5GMZWxvV88Fc7E
 +lnw==
X-Gm-Message-State: APjAAAUtMCya6OqvrNzMIJXEOODcpvnqVp5obF1Dmw+KkDmj3+PKB/gQ
 J6/9WtC7nakQUMVzw2Y6ZfQ=
X-Google-Smtp-Source: APXvYqxAKX++CBB2rHIz1gBuc5df7Kpeofg4L2dbDHDc1duUGn6GDwKrdAEfMJQHWGkOrrHJD6Ceyg==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr14501729wml.169.1569770844282; 
 Sun, 29 Sep 2019 08:27:24 -0700 (PDT)
Received: from ?IPv6:2a01:c22:b04f:b200:7a70:bbc8:8101:45be?
 ([2a01:c22:b04f:b200:7a70:bbc8:8101:45be])
 by smtp.gmail.com with ESMTPSA id u83sm25523519wme.0.2019.09.29.08.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 08:27:23 -0700 (PDT)
Message-ID: <40ddb83824dc19adea584fa8597884e5bdec0d11.camel@gmail.com>
Subject: Re: [PATCH 10/14] hw/arm/raspi: Define various blocks base addresses
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Baumann
 <Andrew.Baumann@microsoft.com>,  qemu-devel@nongnu.org, Pekka Enberg
 <penberg@iki.fi>,  =?ISO-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>
Date: Sun, 29 Sep 2019 17:27:13 +0200
In-Reply-To: <ba3fb4d4-0726-28ae-608b-95354107c2e6@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-11-f4bug@amsat.org>
 <ba3fb4d4-0726-28ae-608b-95354107c2e6@amsat.org>
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

El vie, 06-09-2019 a las 12:07 +0200, Philippe Mathieu-Daudé escribió:
> On 9/4/19 7:13 PM, Philippe Mathieu-Daudé wrote:
> > The Raspberry firmware is closed-source. While running it, it
> > accesses various I/O registers. Logging these accesses as UNIMP
> > (unimplemented) help to understand what the firmware is doing
> > (ideally we want it able to boot a Linux kernel).
> > 
> > Document various blocks we might use later.
> > 
> > Adresses and names based on:
> > https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > ---
> >  include/hw/arm/raspi_platform.h | 49 +++++++++++++++++++++++++++
> > ------
> >  1 file changed, 40 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/hw/arm/raspi_platform.h
> > b/include/hw/arm/raspi_platform.h
> > index 069edab526..c6f4985522 100644
> > --- a/include/hw/arm/raspi_platform.h
> > +++ b/include/hw/arm/raspi_platform.h
> > @@ -25,42 +25,73 @@
> >  #ifndef HW_ARM_RASPI_PLATFORM_H
> >  #define HW_ARM_RASPI_PLATFORM_H
> >  
> > -#define MCORE_OFFSET            0x0000   /* Fake frame buffer
> > device
> > -                                          * (the multicore sync
> > block) */
> > -#define IC0_OFFSET              0x2000
> > +#define MSYNC_OFFSET            0x0000   /* Multicore Sync Block
> > */
> > +#define CCPT_OFFSET             0x1000   /* Compact Camera Port 2
> > TX */
> > +#define INTE_OFFSET             0x2000   /* VC Interrupt
> > controller */
> >  #define ST_OFFSET               0x3000   /* System Timer */
> > +#define TXP_OFFSET              0x4000
> > +#define JPEG_OFFSET             0x5000
> >  #define MPHI_OFFSET             0x6000   /* Message-based Parallel
> > Host Intf. */
> >  #define DMA_OFFSET              0x7000   /* DMA controller,
> > channels 0-14 */
> > -#define ARM_OFFSET              0xB000   /* BCM2708 ARM control
> > block */
> > +#define ARBA_OFFSET             0x9000
> > +#define BRDG_OFFSET             0xa000
> > +#define ARM_OFFSET              0xB000   /* ARM control block */
> >  #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
> >  #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt
> > controller */
> > -#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0
> > and 1 */
> > +#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0
> > and 1 (SP804) */
> >  #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0
> > (ARM) Semaphores
> >                                                        * Doorbells
> > & Mailboxes */
> >  #define PM_OFFSET               0x100000 /* Power Management,
> > Reset controller
> >                                            * and Watchdog registers
> > */
> >  #define CPRMAN_OFFSET           0x101000 /* Clock Management */
> > +#define A2W_OFFSET              0x102000
> >  #define AVS_OFFSET              0x103000 /* Audio Video Standard
> > */
> >  #define RNG_OFFSET              0x104000
> >  #define GPIO_OFFSET             0x200000
> > -#define UART0_OFFSET            0x201000
> > -#define MMCI0_OFFSET            0x202000
> > -#define I2S_OFFSET              0x203000
> > -#define SPI0_OFFSET             0x204000
> > +#define UART0_OFFSET            0x201000 /* PL011 */
> > +#define MMCI0_OFFSET            0x202000 /* Legacy MMC */
> > +#define I2S_OFFSET              0x203000 /* PCM */
> > +#define SPI0_OFFSET             0x204000 /* SPI master */
> >  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> > +#define PIXV0_OFFSET            0x206000
> > +#define PIXV1_OFFSET            0x207000
> > +#define DPI_OFFSET              0x208000
> > +#define DSI0_OFFSET             0x209000 /* Display Serial
> > Interface */
> > +#define PWM_OFFSET              0x20c000
> > +#define PERM_OFFSET             0x20d000
> > +#define TEC_OFFSET              0x20e000
> >  #define OTP_OFFSET              0x20f000
> > +#define SLIM_OFFSET             0x100000 /* SLIMbus */
> > +#define CPG_OFFSET              0x110000
> >  #define AVSP_OFFSET             0x130000
> 
> These should be:
> 
> #define SLIM_OFFSET             0x210000 /* SLIMbus */
> #define CPG_OFFSET              0x211000
> #define AVSP_OFFSET             0x213000
> 
> >  #define BSC_SL_OFFSET           0x214000 /* SPI slave */
Looking in 
https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map I
found that 0x214000 is the "bootrom" register, why the difference?

> > +#define THERMAL_OFFSET          0x212000
> >  #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2
> > */
> >  #define EMMC1_OFFSET            0x300000
> > +#define EMMC2_OFFSET            0x340000
> > +#define HVS_OFFSET              0x400000
In github describe 7E400000 as ddrv register, ddrv is the same as HVS?
> >  #define SMI_OFFSET              0x600000
> > +#define DSI1_OFFSET             0x700000
> > +#define UCAM_OFFSET             0x800000
> > +#define CMI_OFFSET              0x802000
> >  #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
> >  #define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
> > +#define VECA_OFFSET             0x806000
> > +#define PIXV2_OFFSET            0x807000
> > +#define HDMI_OFFSET             0x808000
> > +#define HDCP_OFFSET             0x809000
> > +#define ARBR0_OFFSET            0x80a000
> >  #define DBUS_OFFSET             0x900000
> >  #define AVE0_OFFSET             0x910000
> >  #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller
> > */
> > +#define V3D_OFFSET              0xc00000
> >  #define SDRAMC_OFFSET           0xe00000
> > +#define L2CC_OFFSET             0xe01000 /* Level 2 Cache
> > controller */
> > +#define L1CC_OFFSET             0xe02000 /* Level 1 Cache
> > controller */
> > +#define ARBR1_OFFSET            0xe04000
> >  #define DMA15_OFFSET            0xE05000 /* DMA controller,
> > channel 15 */
> > +#define DCRC_OFFSET             0xe07000
> > +#define AXIP_OFFSET             0xe08000
> >  
> >  /* GPU interrupts */
> >  #define INTERRUPT_TIMER0               0
> > 


