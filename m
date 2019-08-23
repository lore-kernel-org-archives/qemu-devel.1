Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF79C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 20:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1942173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 20:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1942173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FpL-00047a-6m
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 16:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i1FoW-0003U6-KC
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 16:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i1FoT-0007fj-SP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 16:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i1FoT-0007ex-Dn
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 16:05:33 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF5A5C0578F8
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 20:05:31 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id j10so5326465wrb.16
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 13:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6INyOI/wxTun7F4Qw0IuDR6D8pAn858522st8g+1P2E=;
 b=p0vLowNM+aVq6WCEy79vztL/y2tL6BjFhTX2kBBmI1ZHMAOTGkZ7eGG+fF+2IxopBv
 InIHhyz7VLrSuzMTzat13XNCt6hQQsWHKMfy/gNgtidPEPpYUBfhVOKlF1tuvDoPxfKQ
 f0GztO+1Rl/Y3doNDZsRq0oRDujezHtlxZooTy1bVCLSFiBvSbzvVIlvHPtqL+UK50IU
 4+SkHfJBx3UTOGMpVXqFh7DgS3clONgpf3+RbCm9V1TiPT1y7s4nQvLzkwqnhSFLkEHt
 eEj27HA+euKTV+BINlrC9btzmZqIk2BfJozUP6XQhKkDXoBeHdIK64lgnV5LR4uK3wz7
 AQjw==
X-Gm-Message-State: APjAAAXVrBet4cnrf5aSrqfIT4i/DHF16N7iH+GdsiaQb6DY1VbB/j+U
 kqPSI3H9XoTh+ThZyR8eZIo5m3aBrcswah0gzlNHxkMLBwb/XpBonJjiDwCDvCpBFeVWB9NxlHr
 3cgd0/dS8orpiYes=
X-Received: by 2002:a1c:200a:: with SMTP id g10mr6761857wmg.160.1566590730083; 
 Fri, 23 Aug 2019 13:05:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZTSxyl8YmqQeDsK5KGS/6VI8WilK7dYiSFBxTU65HSV3TkfouTxkVKmaeCJQQmCfpJCijmA==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr6761834wmg.160.1566590729733; 
 Fri, 23 Aug 2019 13:05:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4566:f1b0:32e7:463f?
 ([2001:b07:6468:f312:4566:f1b0:32e7:463f])
 by smtp.gmail.com with ESMTPSA id c9sm2598670wrv.40.2019.08.23.13.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 13:05:29 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566467963.git.tony.nguyen@bt.com>
 <80a7e5f67a8c042a7311a621a2c31ac6c20a8e1e.1566467963.git.tony.nguyen@bt.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9a8024dc-3c91-dfae-3ee1-2fdc908e82eb@redhat.com>
Date: Fri, 23 Aug 2019 22:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80a7e5f67a8c042a7311a621a2c31ac6c20a8e1e.1566467963.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 17/17] build: Correct non-common
 common-obj-* to obj-*
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for splitting this.  The good news is that most of these devices
actually need _not_ be target-endian.  Comments are inline.

Paolo

On 23/08/19 20:56, Tony Nguyen wrote:
> diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
> index 63db383709..13133b412d 100644
> --- a/hw/audio/Makefile.objs
> +++ b/hw/audio/Makefile.objs
> @@ -5,7 +5,8 @@ common-obj-$(CONFIG_AC97) += ac97.o
>  common-obj-$(CONFIG_ADLIB) += fmopl.o adlib.o
>  common-obj-$(CONFIG_GUS) += gus.o gusemu_hal.o gusemu_mixer.o
>  common-obj-$(CONFIG_CS4231A) += cs4231a.o
> -common-obj-$(CONFIG_HDA) += intel-hda.o hda-codec.o
> +common-obj-$(CONFIG_HDA) += hda-codec.o
> +obj-$(CONFIG_HDA) += intel-hda.o

These are certainly little endian, since they are PCI devices.

>  common-obj-$(CONFIG_PCSPK) += pcspk.o
>  common-obj-$(CONFIG_WM8750) += wm8750.o
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index f5f643f0cc..04ed4d7722 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -1,9 +1,9 @@
>  common-obj-y += block.o cdrom.o hd-geometry.o
> -common-obj-$(CONFIG_FDC) += fdc.o
> +obj-$(CONFIG_FDC) += fdc.o

fdctrl_mem_ops and sysbus_fdc_info are not used AFAICT and
fdctrl_mem_strict_ops is min/max size=1 so it can be made host-endian.

>  common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
>  common-obj-$(CONFIG_NAND) += nand.o
> -common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
> -common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
> +obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
> +obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
>  common-obj-$(CONFIG_XEN) += xen-block.o
>  common-obj-$(CONFIG_ECC) += ecc.o
>  common-obj-$(CONFIG_ONENAND) += onenand.o
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 02d8a66925..215c02b752 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -1,7 +1,6 @@
>  common-obj-$(CONFIG_IPACK) += ipoctal232.o
>  common-obj-$(CONFIG_ESCC) += escc.o
>  common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
> -common-obj-$(CONFIG_PARALLEL) += parallel.o
>  common-obj-$(CONFIG_ISA_BUS) += parallel-isa.o
>  common-obj-$(CONFIG_PL011) += pl011.o
>  common-obj-$(CONFIG_SERIAL) += serial.o
> @@ -9,7 +8,6 @@ common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
>  common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
>  common-obj-$(CONFIG_SERIAL_PCI_MULTI) += serial-pci-multi.o
>  common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
> -common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
>  common-obj-$(CONFIG_XEN) += xen_console.o
>  common-obj-$(CONFIG_CADENCE) += cadence_uart.o
>  
> @@ -21,6 +19,8 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
>  obj-$(CONFIG_DIGIC) += digic-uart.o
>  obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
>  obj-$(CONFIG_RASPI) += bcm2835_aux.o
> +obj-$(CONFIG_PARALLEL) += parallel.o
> +obj-$(CONFIG_XILINX) += xilinx_uartlite.o
>  
>  common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index b49f880a0c..6ee184a6c4 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -9,7 +9,7 @@ common-obj-y += hotplug.o
>  common-obj-$(CONFIG_SOFTMMU) += nmi.o
>  common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
>  
> -common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
> +obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o

Bit bucket, just make it host endian.

>  common-obj-$(CONFIG_XILINX_AXI) += stream.o
>  common-obj-$(CONFIG_PTIMER) += ptimer.o
>  common-obj-$(CONFIG_SOFTMMU) += sysbus.o
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index a64998fc7b..facc1d4448 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -8,7 +8,7 @@ common-obj-$(CONFIG_ADS7846) += ads7846.o
>  common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
>  common-obj-$(call land,$(CONFIG_VGA_CIRRUS),$(CONFIG_VGA_ISA))+=cirrus_vga_isa.o
>  common-obj-$(CONFIG_G364FB) += g364fb.o
> -common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
> +obj-$(CONFIG_JAZZ_LED) += jazz_led.o

min/max size is 1, make it host endian.

>  common-obj-$(CONFIG_PL110) += pl110.o
>  common-obj-$(CONFIG_SII9022) += sii9022.o
>  common-obj-$(CONFIG_SSD0303) += ssd0303.o
> @@ -17,12 +17,12 @@ common-obj-$(CONFIG_XEN) += xenfb.o
>  
>  common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
>  common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
> -common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
> +obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
>  common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
>  common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
>  
>  common-obj-$(CONFIG_BLIZZARD) += blizzard.o
> -common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
> +obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o

ARM-only, can be little endian.

>  common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
>  common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
> index b672e7a522..5b45c8b9a3 100644
> --- a/hw/dma/Makefile.objs
> +++ b/hw/dma/Makefile.objs
> @@ -1,10 +1,10 @@
>  common-obj-$(CONFIG_PUV3) += puv3_dma.o
> -common-obj-$(CONFIG_RC4030) += rc4030.o
> +obj-$(CONFIG_RC4030) += rc4030.o
>  common-obj-$(CONFIG_PL080) += pl080.o
>  common-obj-$(CONFIG_PL330) += pl330.o
>  common-obj-$(CONFIG_I82374) += i82374.o
> -common-obj-$(CONFIG_I8257) += i8257.o
> -common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
> +obj-$(CONFIG_I8257) += i8257.o

min/max size is 1, can be host endian.

> +obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
>  common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
>  common-obj-$(CONFIG_STP2000) += sparc32_dma.o
> diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
> index e5da0cb54f..319928805b 100644
> --- a/hw/gpio/Makefile.objs
> +++ b/hw/gpio/Makefile.objs
> @@ -1,6 +1,6 @@
>  common-obj-$(CONFIG_MAX7310) += max7310.o
>  common-obj-$(CONFIG_PL061) += pl061.o
> -common-obj-$(CONFIG_PUV3) += puv3_gpio.o
> +obj-$(CONFIG_PUV3) += puv3_gpio.o

Only for unicore32; little endian.

>  common-obj-$(CONFIG_ZAURUS) += zaurus.o
>  common-obj-$(CONFIG_E500) += mpc8xxx.o
>  common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> index d7073a401f..f02694927b 100644
> --- a/hw/i2c/Makefile.objs
> +++ b/hw/i2c/Makefile.objs
> @@ -4,7 +4,7 @@ common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
>  common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
>  common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
>  common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
> -common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
> +obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o

ARM -> little endian.

>  common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
>  common-obj-$(CONFIG_NRF51_SOC) += microbit_i2c.o
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index f726d87532..f6336bee4c 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -2,14 +2,14 @@ common-obj-$(CONFIG_HEATHROW_PIC) += heathrow_pic.o
>  common-obj-$(CONFIG_I8259) += i8259_common.o i8259.o
>  common-obj-$(CONFIG_PL190) += pl190.o
>  common-obj-$(CONFIG_PUV3) += puv3_intc.o
> -common-obj-$(CONFIG_XILINX) += xilinx_intc.o
> +obj-$(CONFIG_XILINX) += xilinx_intc.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP_PMU) += xlnx-pmu-iomod-intc.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-ipi.o
>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_pic.o
>  common-obj-$(CONFIG_IMX) += imx_avic.o imx_gpcv2.o
>  common-obj-$(CONFIG_LM32) += lm32_pic.o
>  common-obj-$(CONFIG_REALVIEW) += realview_gic.o
> -common-obj-$(CONFIG_SLAVIO) += slavio_intctl.o
> +obj-$(CONFIG_SLAVIO) += slavio_intctl.o

SPARC only -> big endian.

>  common-obj-$(CONFIG_IOAPIC) += ioapic_common.o
>  common-obj-$(CONFIG_ARM_GIC) += arm_gic_common.o
>  common-obj-$(CONFIG_ARM_GIC) += arm_gic.o
> @@ -18,7 +18,7 @@ common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_common.o
>  common-obj-$(CONFIG_ARM_GIC) += arm_gicv3.o
>  common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_dist.o
>  common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_redist.o
> -common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_its_common.o
> +obj-$(CONFIG_ARM_GIC) += arm_gicv3_its_common.o

ARM only -> little endian.

>  common-obj-$(CONFIG_OPENPIC) += openpic.o
>  common-obj-y += intc.o
>  
> diff --git a/hw/ipack/Makefile.objs b/hw/ipack/Makefile.objs
> index 8b9bdcb549..a7c5485a46 100644
> --- a/hw/ipack/Makefile.objs
> +++ b/hw/ipack/Makefile.objs
> @@ -1,2 +1,2 @@
>  common-obj-$(CONFIG_IPACK) += ipack.o
> -common-obj-$(CONFIG_IPACK) += tpci200.o
> +obj-$(CONFIG_IPACK) += tpci200.o

PCI -> little endian.

> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index e4aad707fb..0781a56319 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-$(CONFIG_APPLESMC) += applesmc.o
> +ommon-obj-$(CONFIG_APPLESMC) += applesmc.o

Careful, typo.  The device can be host endian (min/max size = 1).

>  common-obj-$(CONFIG_MAX111X) += max111x.o
>  common-obj-$(CONFIG_TMP105) += tmp105.o
>  common-obj-$(CONFIG_TMP421) += tmp421.o
> @@ -6,20 +6,20 @@ common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
>  common-obj-$(CONFIG_SGA) += sga.o
>  common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
>  common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
> -common-obj-$(CONFIG_EDU) += edu.o
> +obj-$(CONFIG_EDU) += edu.o

PCI -> little endian.

>  common-obj-$(CONFIG_PCA9552) += pca9552.o
>  
> -common-obj-$(CONFIG_UNIMP) += unimp.o
> +obj-$(CONFIG_UNIMP) += unimp.o

Bit bucket -> host endian.

>  common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
>  
>  # ARM devices
>  common-obj-$(CONFIG_PL310) += arm_l2x0.o
> -common-obj-$(CONFIG_INTEGRATOR_DEBUG) += arm_integrator_debug.o
> +obj-$(CONFIG_INTEGRATOR_DEBUG) += arm_integrator_debug.o

ARM -> little endian.

>  common-obj-$(CONFIG_A9SCU) += a9scu.o
>  common-obj-$(CONFIG_ARM11SCU) += arm11scu.o
>  
>  # Mac devices
> -common-obj-$(CONFIG_MOS6522) += mos6522.o
> +obj-$(CONFIG_MOS6522) += mos6522.o

min/max size = 1 -> host endian.
>  
>  # PKUnity SoC devices
>  common-obj-$(CONFIG_PUV3) += puv3_pm.o
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index a9cd3e022d..02f286bd87 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) += ppce500.o
>  common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
>  
>  common-obj-$(CONFIG_PCI_SABRE) += sabre.o
> -common-obj-$(CONFIG_FULONG) += bonito.o
> +obj-$(CONFIG_FULONG) += bonito.o

FULONG is little endian.

>  common-obj-$(CONFIG_PCI_PIIX) += piix.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
>  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 123d92c969..b27513fe14 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -12,10 +12,10 @@ ifeq ($(CONFIG_ISA_BUS),y)
>  common-obj-$(CONFIG_M48T59) += m48t59-isa.o
>  endif
>  common-obj-$(CONFIG_PL031) += pl031.o
> -common-obj-$(CONFIG_PUV3) += puv3_ost.o
> +obj-$(CONFIG_PUV3) += puv3_ost.o

Unicore32 -> LE.

>  common-obj-$(CONFIG_TWL92230) += twl92230.o
> -common-obj-$(CONFIG_XILINX) += xilinx_timer.o
> -common-obj-$(CONFIG_SLAVIO) += slavio_timer.o
> +obj-$(CONFIG_XILINX) += xilinx_timer.o
> +obj-$(CONFIG_SLAVIO) += slavio_timer.o

SPARC -> BE.

>  common-obj-$(CONFIG_ETRAXFS) += etraxfs_timer.o
>  common-obj-$(CONFIG_GRLIB) += grlib_gptimer.o
>  common-obj-$(CONFIG_IMX) += imx_epit.o


