Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF687C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B9F21BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B9F21BE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLcY-0004Ic-Hu
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvLc1-0003ft-HA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvLbz-0006Z5-HL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:04:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvLby-0006YX-UV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:04:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so81725689wme.4
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=32j0lo/aqAZRG5pgTGK/fOohzdZBMcXc0WfIt4hVlMc=;
 b=fK7EEi6pxZ3QQG+JGYgrbM2YjX1KLbmZS+tQW+LodirQb/NIpcMZnDRb0R0/V7PC5O
 CuqwcBMq0c+j2r64GDAhEdmT2JP1XnuexmgwcYHsflO+boFwjJb0m2vg+EfIGaCx/Foq
 EJW80GBup+bmgjt+MVheYLksKXbANPvKLOIyTWvqpr5qPOisu+Mn/GHBaEo55EMNuSN9
 ICDOcjwrGA1+M2OcvaBSJQzzRhiOPSB7C2zsBIG/s8VN3h6ZXjcoTYHGnvtWS0jWPXfA
 m/1eMdIeK158fSsG6b6qgs1q389m2cZ0w3Mgu/L33QQUl9PL0/8IG5iKIgYUaZjGpPAr
 j01A==
X-Gm-Message-State: APjAAAUATU5ztwXgj39XjA/TLx8aI0Qo+HAn+OMGjkJoILeDqmyeev4k
 inGspq0SB16hQYwWjtJja1qCUA==
X-Google-Smtp-Source: APXvYqzMvrrIktauStiq4NrsBocXQF7B8uiiCD+2U1rLmbsgTmZ9PtnaqfNMldGsqLv9BuvxZkhs6A==
X-Received: by 2002:a1c:ef0c:: with SMTP id n12mr10349333wmh.132.1565183053527; 
 Wed, 07 Aug 2019 06:04:13 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id y18sm88306983wmi.23.2019.08.07.06.04.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:04:12 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
Date: Wed, 7 Aug 2019 15:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> In my "build everything" tree, changing hw/irq.h triggers a recompile
> of some 5400 out of 6600 objects (not counting tests and objects that
> don't depend on qemu/osdep.h).
> 
> hw/hw.h supposedly includes it for convenience.  Several other headers
> include it just to get qemu_irq and.or qemu_irq_handler.
> 
> Move the qemu_irq and qemu_irq_handler typedefs from hw/irq.h to
> qemu/typedefs.h, and then include hw/irq.h only where it's still
> needed.  Touching it now recompiles only some 500 objects.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/acpi/core.c                   | 1 +
>  hw/acpi/piix4.c                  | 1 +
>  hw/alpha/alpha_sys.h             | 1 -
>  hw/alpha/typhoon.c               | 1 +
>  hw/arm/armsse.c                  | 1 +
>  hw/arm/exynos4210.c              | 1 +
>  hw/arm/exynos4_boards.c          | 1 +
>  hw/arm/integratorcp.c            | 1 +
>  hw/arm/msf2-soc.c                | 1 +
>  hw/arm/musicpal.c                | 1 +
>  hw/arm/omap1.c                   | 1 +
>  hw/arm/omap2.c                   | 1 +
>  hw/arm/palm.c                    | 2 ++
>  hw/arm/pxa2xx.c                  | 1 +
>  hw/arm/pxa2xx_gpio.c             | 1 +
>  hw/arm/realview.c                | 1 +
>  hw/arm/smmuv3.c                  | 1 +
>  hw/arm/spitz.c                   | 1 +
>  hw/arm/stellaris.c               | 1 +
>  hw/arm/strongarm.c               | 1 +
>  hw/arm/tosa.c                    | 1 +
>  hw/arm/versatilepb.c             | 1 +
>  hw/arm/virt.c                    | 1 +
>  hw/arm/z2.c                      | 1 +
>  hw/audio/cs4231a.c               | 1 +
>  hw/audio/gus.c                   | 1 +
>  hw/audio/marvell_88w8618.c       | 1 +
>  hw/audio/milkymist-ac97.c        | 1 +
>  hw/audio/pl041.c                 | 1 +
>  hw/audio/sb16.c                  | 1 +
>  hw/block/fdc.c                   | 1 +
>  hw/char/bcm2835_aux.c            | 1 +
>  hw/char/cadence_uart.c           | 1 +
>  hw/char/cmsdk-apb-uart.c         | 1 +
>  hw/char/escc.c                   | 1 +
>  hw/char/etraxfs_ser.c            | 1 +
>  hw/char/exynos4210_uart.c        | 1 +
>  hw/char/grlib_apbuart.c          | 1 +
>  hw/char/imx_serial.c             | 1 +
>  hw/char/ipoctal232.c             | 1 +
>  hw/char/lm32_uart.c              | 1 +
>  hw/char/mcf_uart.c               | 1 +
>  hw/char/milkymist-uart.c         | 1 +
>  hw/char/nrf51_uart.c             | 1 +
>  hw/char/parallel.c               | 1 +
>  hw/char/pl011.c                  | 1 +
>  hw/char/serial-pci-multi.c       | 1 +
>  hw/char/serial-pci.c             | 1 +
>  hw/char/serial.c                 | 1 +
>  hw/char/sh_serial.c              | 2 ++
>  hw/char/spapr_vty.c              | 1 +
>  hw/char/stm32f2xx_usart.c        | 1 +
>  hw/char/xilinx_uartlite.c        | 1 +
>  hw/core/or-irq.c                 | 1 +
>  hw/core/qdev.c                   | 1 +
>  hw/core/split-irq.c              | 1 +
>  hw/cpu/a15mpcore.c               | 1 +
>  hw/cpu/a9mpcore.c                | 1 +
>  hw/cpu/arm11mpcore.c             | 1 +
>  hw/cpu/realview_mpcore.c         | 1 +
>  hw/display/ads7846.c             | 1 +
>  hw/display/bcm2835_fb.c          | 1 +
>  hw/display/cg3.c                 | 1 +
>  hw/display/exynos4210_fimd.c     | 1 +
>  hw/display/g364fb.c              | 1 +
>  hw/display/milkymist-tmu2.c      | 1 +
>  hw/display/omap_dss.c            | 2 ++
>  hw/display/omap_lcdc.c           | 2 ++
>  hw/display/pl110.c               | 1 +
>  hw/display/pxa2xx_lcd.c          | 1 +
>  hw/display/tc6393xb.c            | 2 ++
>  hw/display/xlnx_dp.c             | 1 +
>  hw/dma/bcm2835_dma.c             | 1 +
>  hw/dma/etraxfs_dma.c             | 2 ++
>  hw/dma/pl080.c                   | 1 +
>  hw/dma/pl330.c                   | 1 +
>  hw/dma/pxa2xx_dma.c              | 1 +
>  hw/dma/rc4030.c                  | 1 +
>  hw/dma/sparc32_dma.c             | 1 +
>  hw/dma/xilinx_axidma.c           | 1 +
>  hw/dma/xlnx-zdma.c               | 1 +
>  hw/dma/xlnx-zynq-devcfg.c        | 1 +
>  hw/dma/xlnx_dpdma.c              | 1 +
>  hw/gpio/bcm2835_gpio.c           | 1 +
>  hw/gpio/gpio_key.c               | 1 +
>  hw/gpio/imx_gpio.c               | 1 +
>  hw/gpio/max7310.c                | 1 +
>  hw/gpio/mpc8xxx.c                | 1 +
>  hw/gpio/nrf51_gpio.c             | 1 +
>  hw/gpio/omap_gpio.c              | 1 +
>  hw/gpio/pl061.c                  | 1 +
>  hw/gpio/zaurus.c                 | 1 +
>  hw/hppa/dino.c                   | 1 +
>  hw/hppa/hppa_sys.h               | 1 -
>  hw/i2c/aspeed_i2c.c              | 1 +
>  hw/i2c/bitbang_i2c.c             | 1 +
>  hw/i2c/exynos4210_i2c.c          | 1 +
>  hw/i2c/imx_i2c.c                 | 1 +
>  hw/i2c/mpc_i2c.c                 | 1 +
>  hw/i2c/omap_i2c.c                | 1 +
>  hw/i2c/ppc4xx_i2c.c              | 1 +
>  hw/i386/kvm/i8259.c              | 1 +
>  hw/i386/kvm/ioapic.c             | 1 +
>  hw/i386/pc.c                     | 1 +
>  hw/i386/pc_piix.c                | 1 +
>  hw/i386/xen/xen-hvm.c            | 1 +
>  hw/input/lm832x.c                | 1 +
>  hw/input/milkymist-softusb.c     | 1 +
>  hw/input/pckbd.c                 | 1 +
>  hw/input/pl050.c                 | 1 +
>  hw/input/pxa2xx_keypad.c         | 1 +
>  hw/input/stellaris_input.c       | 2 ++
>  hw/input/tsc2005.c               | 1 +
>  hw/input/tsc210x.c               | 1 +
>  hw/intc/allwinner-a10-pic.c      | 1 +
>  hw/intc/arm_gic.c                | 1 +
>  hw/intc/arm_gicv2m.c             | 1 +
>  hw/intc/arm_gicv3_cpuif.c        | 1 +
>  hw/intc/armv7m_nvic.c            | 1 +
>  hw/intc/aspeed_vic.c             | 1 +
>  hw/intc/bcm2835_ic.c             | 1 +
>  hw/intc/bcm2836_control.c        | 1 +
>  hw/intc/etraxfs_pic.c            | 1 +
>  hw/intc/exynos4210_combiner.c    | 1 +
>  hw/intc/heathrow_pic.c           | 1 +
>  hw/intc/i8259.c                  | 2 ++
>  hw/intc/imx_avic.c               | 1 +
>  hw/intc/lm32_pic.c               | 1 +
>  hw/intc/mips_gic.c               | 1 +
>  hw/intc/nios2_iic.c              | 1 +
>  hw/intc/omap_intc.c              | 1 +
>  hw/intc/ompic.c                  | 1 +
>  hw/intc/openpic.c                | 1 +
>  hw/intc/pl190.c                  | 1 +
>  hw/intc/puv3_intc.c              | 1 +
>  hw/intc/realview_gic.c           | 1 +
>  hw/intc/sh_intc.c                | 1 +
>  hw/intc/slavio_intctl.c          | 1 +
>  hw/intc/xics.c                   | 1 +
>  hw/intc/xilinx_intc.c            | 1 +
>  hw/intc/xive.c                   | 1 +
>  hw/intc/xlnx-pmu-iomod-intc.c    | 1 +
>  hw/intc/xlnx-zynqmp-ipi.c        | 1 +
>  hw/ipack/ipack.c                 | 1 +
>  hw/ipack/tpci200.c               | 1 +
>  hw/ipmi/isa_ipmi_bt.c            | 1 +
>  hw/ipmi/isa_ipmi_kcs.c           | 1 +
>  hw/isa/i82378.c                  | 1 +
>  hw/isa/lpc_ich9.c                | 2 ++
>  hw/lm32/lm32_boards.c            | 1 +
>  hw/lm32/milkymist.c              | 1 +
>  hw/m68k/mcf5206.c                | 2 ++
>  hw/m68k/mcf5208.c                | 2 ++
>  hw/m68k/mcf_intc.c               | 1 +
>  hw/mips/gt64xxx_pci.c            | 1 +
>  hw/mips/mips_int.c               | 1 +
>  hw/mips/mips_malta.c             | 1 +
>  hw/misc/arm_sysctl.c             | 1 +
>  hw/misc/armsse-mhu.c             | 1 +
>  hw/misc/aspeed_xdma.c            | 1 +
>  hw/misc/bcm2835_mbox.c           | 1 +
>  hw/misc/bcm2835_property.c       | 1 +
>  hw/misc/eccmemctl.c              | 1 +
>  hw/misc/iotkit-secctl.c          | 1 +
>  hw/misc/macio/mac_dbdma.c        | 1 +
>  hw/misc/macio/pmu.c              | 1 +
>  hw/misc/max111x.c                | 1 +
>  hw/misc/milkymist-pfpu.c         | 1 +
>  hw/misc/mos6522.c                | 1 +
>  hw/misc/mst_fpga.c               | 1 +
>  hw/misc/nrf51_rng.c              | 1 +
>  hw/misc/omap_clk.c               | 2 ++
>  hw/misc/omap_gpmc.c              | 2 ++
>  hw/misc/pc-testdev.c             | 1 +
>  hw/misc/slavio_misc.c            | 1 +
>  hw/misc/tmp105.c                 | 1 +
>  hw/misc/tz-mpc.c                 | 1 +
>  hw/misc/tz-msc.c                 | 1 +
>  hw/misc/tz-ppc.c                 | 1 +
>  hw/misc/zynq-xadc.c              | 1 +
>  hw/net/allwinner_emac.c          | 1 +
>  hw/net/cadence_gem.c             | 1 +
>  hw/net/can/can_kvaser_pci.c      | 1 +
>  hw/net/can/can_mioe3680_pci.c    | 1 +
>  hw/net/can/can_pcm3680_pci.c     | 1 +
>  hw/net/can/can_sja1000.c         | 2 ++
>  hw/net/dp8393x.c                 | 1 +
>  hw/net/fsl_etsec/etsec.c         | 1 +
>  hw/net/ftgmac100.c               | 1 +
>  hw/net/imx_fec.c                 | 1 +
>  hw/net/lan9118.c                 | 1 +
>  hw/net/mcf_fec.c                 | 1 +
>  hw/net/milkymist-minimac2.c      | 1 +
>  hw/net/mipsnet.c                 | 1 +
>  hw/net/ne2000-pci.c              | 2 ++
>  hw/net/ne2000.c                  | 1 +
>  hw/net/opencores_eth.c           | 1 +
>  hw/net/pcnet-pci.c               | 1 +
>  hw/net/pcnet.c                   | 1 +
>  hw/net/smc91c111.c               | 1 +
>  hw/net/spapr_llan.c              | 1 +
>  hw/net/stellaris_enet.c          | 1 +
>  hw/net/xgmac.c                   | 1 +
>  hw/net/xilinx_axienet.c          | 1 +
>  hw/net/xilinx_ethlite.c          | 1 +
>  hw/nios2/cpu_pic.c               | 1 +
>  hw/openrisc/openrisc_sim.c       | 1 +
>  hw/openrisc/pic_cpu.c            | 1 +
>  hw/pci-host/bonito.c             | 1 +
>  hw/pci-host/designware.c         | 1 +
>  hw/pci-host/gpex.c               | 1 +
>  hw/pci-host/grackle.c            | 1 +
>  hw/pci-host/piix.c               | 1 +
>  hw/pci-host/ppce500.c            | 1 +
>  hw/pci-host/prep.c               | 1 +
>  hw/pci-host/sabre.c              | 1 +
>  hw/pci-host/uninorth.c           | 1 +
>  hw/pci-host/versatile.c          | 1 +
>  hw/pci-host/xilinx-pcie.c        | 1 +
>  hw/pci/pci.c                     | 1 +
>  hw/pcmcia/pxa2xx.c               | 1 +
>  hw/ppc/e500.c                    | 1 +
>  hw/ppc/pnv_lpc.c                 | 1 +
>  hw/ppc/pnv_psi.c                 | 1 +
>  hw/ppc/ppc.c                     | 2 ++
>  hw/ppc/ppc405_uc.c               | 1 +
>  hw/ppc/ppc440_pcix.c             | 1 +
>  hw/ppc/ppc440_uc.c               | 1 +
>  hw/ppc/ppc4xx_devs.c             | 1 +
>  hw/ppc/ppc4xx_pci.c              | 1 +
>  hw/ppc/prep.c                    | 1 +
>  hw/ppc/prep_systemio.c           | 1 +
>  hw/ppc/spapr_events.c            | 2 ++
>  hw/ppc/spapr_irq.c               | 1 +
>  hw/ppc/spapr_pci.c               | 1 +
>  hw/ppc/spapr_vio.c               | 1 +
>  hw/riscv/sifive_gpio.c           | 1 +
>  hw/riscv/sifive_uart.c           | 1 +
>  hw/scsi/esp-pci.c                | 1 +
>  hw/scsi/esp.c                    | 1 +
>  hw/scsi/lsi53c895a.c             | 1 +
>  hw/sd/bcm2835_sdhost.c           | 1 +
>  hw/sd/omap_mmc.c                 | 2 ++
>  hw/sd/pl181.c                    | 1 +
>  hw/sd/pxa2xx_mmci.c              | 1 +
>  hw/sd/sd.c                       | 1 +
>  hw/sd/sdhci.c                    | 1 +
>  hw/sh4/r2d.c                     | 1 +
>  hw/sh4/sh7750.c                  | 2 ++
>  hw/sh4/sh_pci.c                  | 1 +
>  hw/sparc/leon3.c                 | 1 +
>  hw/sparc/sun4m.c                 | 1 +
>  hw/sparc/sun4m_iommu.c           | 1 +
>  hw/ssi/aspeed_smc.c              | 1 +
>  hw/ssi/imx_spi.c                 | 1 +
>  hw/ssi/mss-spi.c                 | 1 +
>  hw/ssi/omap_spi.c                | 2 ++
>  hw/ssi/pl022.c                   | 1 +
>  hw/ssi/xilinx_spi.c              | 1 +
>  hw/ssi/xilinx_spips.c            | 1 +
>  hw/timer/a9gtimer.c              | 1 +
>  hw/timer/allwinner-a10-pit.c     | 1 +
>  hw/timer/altera_timer.c          | 1 +
>  hw/timer/arm_mptimer.c           | 1 +
>  hw/timer/arm_timer.c             | 1 +
>  hw/timer/armv7m_systick.c        | 1 +
>  hw/timer/aspeed_timer.c          | 1 +
>  hw/timer/cadence_ttc.c           | 1 +
>  hw/timer/cmsdk-apb-dualtimer.c   | 1 +
>  hw/timer/cmsdk-apb-timer.c       | 1 +
>  hw/timer/etraxfs_timer.c         | 1 +
>  hw/timer/exynos4210_mct.c        | 1 +
>  hw/timer/exynos4210_pwm.c        | 1 +
>  hw/timer/exynos4210_rtc.c        | 1 +
>  hw/timer/grlib_gptimer.c         | 1 +
>  hw/timer/hpet.c                  | 1 +
>  hw/timer/i8254.c                 | 1 +
>  hw/timer/imx_epit.c              | 1 +
>  hw/timer/imx_gpt.c               | 1 +
>  hw/timer/lm32_timer.c            | 1 +
>  hw/timer/m48t59.c                | 1 +
>  hw/timer/mc146818rtc.c           | 1 +
>  hw/timer/milkymist-sysctl.c      | 1 +
>  hw/timer/mss-timer.c             | 1 +
>  hw/timer/nrf51_timer.c           | 1 +
>  hw/timer/omap_gptimer.c          | 2 ++
>  hw/timer/pl031.c                 | 1 +
>  hw/timer/puv3_ost.c              | 1 +
>  hw/timer/pxa2xx_timer.c          | 1 +
>  hw/timer/sh_timer.c              | 1 +
>  hw/timer/slavio_timer.c          | 1 +
>  hw/timer/stm32f2xx_timer.c       | 1 +
>  hw/timer/twl92230.c              | 1 +
>  hw/timer/xilinx_timer.c          | 1 +
>  hw/timer/xlnx-zynqmp-rtc.c       | 1 +
>  hw/tpm/tpm_tis.c                 | 1 +
>  hw/unicore32/puv3.c              | 1 +
>  hw/usb/hcd-ehci.c                | 1 +
>  hw/usb/hcd-ohci.c                | 1 +
>  hw/vfio/platform.c               | 1 +
>  hw/virtio/virtio-mmio.c          | 1 +
>  hw/watchdog/cmsdk-apb-watchdog.c | 1 +
>  hw/xtensa/mx_pic.c               | 1 +
>  hw/xtensa/pic_cpu.c              | 1 +
>  include/hw/acpi/acpi.h           | 1 -
>  include/hw/arm/boot.h            | 1 -
>  include/hw/arm/omap.h            | 1 -
>  include/hw/arm/soc_dma.h         | 1 -
>  include/hw/block/fdc.h           | 1 -
>  include/hw/bt.h                  | 1 -
>  include/hw/core/split-irq.h      | 1 -
>  include/hw/cris/etraxfs_dma.h    | 1 -
>  include/hw/display/blizzard.h    | 1 -
>  include/hw/display/tc6393xb.h    | 1 -
>  include/hw/hw.h                  | 1 -
>  include/hw/ide/internal.h        | 1 +
>  include/hw/input/gamepad.h       | 1 -
>  include/hw/input/tsc2xxx.h       | 1 -
>  include/hw/irq.h                 | 4 ----
>  include/hw/isa/vt82c686.h        | 1 -
>  include/hw/mips/mips.h           | 1 -
>  include/hw/misc/cbus.h           | 1 -
>  include/hw/net/lan9118.h         | 1 -
>  include/hw/net/smc91c111.h       | 1 -
>  include/hw/or-irq.h              | 1 -
>  include/hw/ppc/spapr_irq.h       | 1 -
>  include/hw/qdev-core.h           | 1 -
>  include/hw/sh4/sh_intc.h         | 1 -
>  include/hw/timer/m48t59.h        | 1 -
>  include/hw/tricore/tricore.h     | 1 -
>  include/hw/vfio/vfio-platform.h  | 1 -
>  include/hw/xen/xen.h             | 1 -
>  include/hw/xtensa/mx_pic.h       | 1 -
>  include/qemu/typedefs.h          | 9 +++++++++
>  include/sysemu/kvm.h             | 1 -
>  target/arm/helper.c              | 1 +
>  target/arm/kvm.c                 | 1 +
>  target/mips/cp0_timer.c          | 1 +
>  338 files changed, 336 insertions(+), 34 deletions(-)
[...]
> diff --git a/include/hw/irq.h b/include/hw/irq.h
> index 7a40e3ed26..fe527f6f51 100644
> --- a/include/hw/irq.h
> +++ b/include/hw/irq.h
> @@ -5,10 +5,6 @@
>  
>  #define TYPE_IRQ "irq"
>  
> -typedef struct IRQState *qemu_irq;
> -
> -typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> -
>  void qemu_set_irq(qemu_irq irq, int level);
>  
>  static inline void qemu_irq_raise(qemu_irq irq)
[...]
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 29346648d4..c32efb5b18 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -102,10 +102,19 @@ typedef struct SSIBus SSIBus;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
>  
> +/*
> + * Pointer types
> + * Such typedefs should be limited to cases where the typedef's users
> + * are oblivious of its "pointer-ness".
> + * Please keep this list in case-insensitive alphabetical order.
> + */
> +typedef struct IRQState *qemu_irq;
> +
>  /*
>   * Function types
>   */
>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
> +typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>  
>  #endif /* QEMU_TYPEDEFS_H */

This one was painful to review.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

