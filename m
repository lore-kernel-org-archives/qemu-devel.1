Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1D82082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quXdpJNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1D82082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BA7-0007Cq-46
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6B9M-0006gS-AF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6B9K-0002eH-Rb
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:07:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6B9H-0002dF-Ol; Fri, 06 Sep 2019 06:07:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id t17so5867372wmi.2;
 Fri, 06 Sep 2019 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=47uvfA90LYJu5mkrZPS3mbyFg0FBJ9/6fLRHB97xDcM=;
 b=quXdpJNxuXQRk/i5z6FDTd4AZelccmTgWUeoepKMyLIyG/xAA9fqTJI9cu28pV/FMh
 GnwNZTt291I+mb06oL+CVURTj8R0DMfu7JEzqG+qXtufwZj7o9NEOqcL0cWdbd7RjRn2
 o8atm/+usglpmcr0U/flRWckBH35MtzqIH9t2iZw6VUTUP0m26ccqPUCBs/gPawqpyp9
 WzKzS4rnyf61MD3AsZHQgC82XY9CYAeiaob6uH0wQSJuikqWAjZ2/SkqKrltXLK5w2sd
 5lkeFPdto52kzTh2hbD9nG9vqbEPdSQKTh2Tz+KkFB3wVYPM1lfFUPMgPJEx1KqmaPNF
 6EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=47uvfA90LYJu5mkrZPS3mbyFg0FBJ9/6fLRHB97xDcM=;
 b=OikTJv8YI1Uii0l7t7JTqLV2tz2X/jtKtTsPaYdSkLRXN0ughOsujnlmXIA617QeSe
 nVUlnFygXfX9hAng3NtJyfGQWqs0RWJ6O2y8bxx84xek1A+Yq/AoP5044VgtxBrkFCFN
 DjTkokJCQAdnfbZUy9+CadbjMVCFJFMb36p910FGUAiDJJrC2CYN43pYJ76RQqcaUv+s
 q2m+pEj4CzQcfhz/GCOJ924JgAIW9nK6WfCf+JzTZg1CWSd9UPdFaI5VfkrC4aeeUbsi
 sNzcdhu40QnROLhKlYAhaVatE6tXeU/jNRDTFyWjdtHEZigBzpT+kWseXwJl5rUk0SNQ
 cr/g==
X-Gm-Message-State: APjAAAVc0EIH1oloycrf/2YaYb7FSFJuRJzjas4GR6A/taW9CwuRFxXc
 sWCHzkwAwueGZwynzR6j2XQ=
X-Google-Smtp-Source: APXvYqwMzjQpdYynU9EstxzwW8HuG0AS+Rn1iLj1/lK6p9zZIB5rGpyKvd2Y9Ejgk5H4fn6GZTfFvw==
X-Received: by 2002:a1c:c589:: with SMTP id v131mr6337846wmf.163.1567764442377; 
 Fri, 06 Sep 2019 03:07:22 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w125sm9216968wmg.32.2019.09.06.03.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 03:07:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?=
 <bztemail@gmail.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-11-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <ba3fb4d4-0726-28ae-608b-95354107c2e6@amsat.org>
Date: Fri, 6 Sep 2019 12:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904171315.8354-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 10/14] hw/arm/raspi: Define various blocks
 base addresses
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
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 7:13 PM, Philippe Mathieu-Daudé wrote:
> The Raspberry firmware is closed-source. While running it, it
> accesses various I/O registers. Logging these accesses as UNIMP
> (unimplemented) help to understand what the firmware is doing
> (ideally we want it able to boot a Linux kernel).
> 
> Document various blocks we might use later.
> 
> Adresses and names based on:
> https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/arm/raspi_platform.h | 49 +++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
> index 069edab526..c6f4985522 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -25,42 +25,73 @@
>  #ifndef HW_ARM_RASPI_PLATFORM_H
>  #define HW_ARM_RASPI_PLATFORM_H
>  
> -#define MCORE_OFFSET            0x0000   /* Fake frame buffer device
> -                                          * (the multicore sync block) */
> -#define IC0_OFFSET              0x2000
> +#define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
> +#define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
> +#define INTE_OFFSET             0x2000   /* VC Interrupt controller */
>  #define ST_OFFSET               0x3000   /* System Timer */
> +#define TXP_OFFSET              0x4000
> +#define JPEG_OFFSET             0x5000
>  #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
>  #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
> -#define ARM_OFFSET              0xB000   /* BCM2708 ARM control block */
> +#define ARBA_OFFSET             0x9000
> +#define BRDG_OFFSET             0xa000
> +#define ARM_OFFSET              0xB000   /* ARM control block */
>  #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
>  #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
> -#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
> +#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 (SP804) */
>  #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
>                                                        * Doorbells & Mailboxes */
>  #define PM_OFFSET               0x100000 /* Power Management, Reset controller
>                                            * and Watchdog registers */
>  #define CPRMAN_OFFSET           0x101000 /* Clock Management */
> +#define A2W_OFFSET              0x102000
>  #define AVS_OFFSET              0x103000 /* Audio Video Standard */
>  #define RNG_OFFSET              0x104000
>  #define GPIO_OFFSET             0x200000
> -#define UART0_OFFSET            0x201000
> -#define MMCI0_OFFSET            0x202000
> -#define I2S_OFFSET              0x203000
> -#define SPI0_OFFSET             0x204000
> +#define UART0_OFFSET            0x201000 /* PL011 */
> +#define MMCI0_OFFSET            0x202000 /* Legacy MMC */
> +#define I2S_OFFSET              0x203000 /* PCM */
> +#define SPI0_OFFSET             0x204000 /* SPI master */
>  #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> +#define PIXV0_OFFSET            0x206000
> +#define PIXV1_OFFSET            0x207000
> +#define DPI_OFFSET              0x208000
> +#define DSI0_OFFSET             0x209000 /* Display Serial Interface */
> +#define PWM_OFFSET              0x20c000
> +#define PERM_OFFSET             0x20d000
> +#define TEC_OFFSET              0x20e000
>  #define OTP_OFFSET              0x20f000
> +#define SLIM_OFFSET             0x100000 /* SLIMbus */
> +#define CPG_OFFSET              0x110000
>  #define AVSP_OFFSET             0x130000

These should be:

#define SLIM_OFFSET             0x210000 /* SLIMbus */
#define CPG_OFFSET              0x211000
#define AVSP_OFFSET             0x213000

>  #define BSC_SL_OFFSET           0x214000 /* SPI slave */
> +#define THERMAL_OFFSET          0x212000
>  #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
>  #define EMMC1_OFFSET            0x300000
> +#define EMMC2_OFFSET            0x340000
> +#define HVS_OFFSET              0x400000
>  #define SMI_OFFSET              0x600000
> +#define DSI1_OFFSET             0x700000
> +#define UCAM_OFFSET             0x800000
> +#define CMI_OFFSET              0x802000
>  #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
>  #define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
> +#define VECA_OFFSET             0x806000
> +#define PIXV2_OFFSET            0x807000
> +#define HDMI_OFFSET             0x808000
> +#define HDCP_OFFSET             0x809000
> +#define ARBR0_OFFSET            0x80a000
>  #define DBUS_OFFSET             0x900000
>  #define AVE0_OFFSET             0x910000
>  #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
> +#define V3D_OFFSET              0xc00000
>  #define SDRAMC_OFFSET           0xe00000
> +#define L2CC_OFFSET             0xe01000 /* Level 2 Cache controller */
> +#define L1CC_OFFSET             0xe02000 /* Level 1 Cache controller */
> +#define ARBR1_OFFSET            0xe04000
>  #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
> +#define DCRC_OFFSET             0xe07000
> +#define AXIP_OFFSET             0xe08000
>  
>  /* GPU interrupts */
>  #define INTERRUPT_TIMER0               0
> 

