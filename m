Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2736C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93762199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93762199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNBy-0003QF-SJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvNBO-0002aI-GD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvNBM-0003ub-2n
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:44:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvNBL-0003tv-Pl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:44:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so91623383wrl.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yssw40hHBwIjj5Ne6ei/YiS4S7ZWCi9dP1rk5Ra3L4A=;
 b=a8g80WzjZI6g2HeFMmuEAuAP6pHvhuF118zqH4kGWa1yb1zqIOI3IREoXDkL71DD53
 lM7MdWqtBfQtf/F8xg9LtK1XNT8pyR1tlUBuoRYzuo79TMYbl1XL59bshiL0EkC436jq
 FhEZnlpkkFZiYw0ASoSseBiZY4NNBpiIqGWo+vSidyYHmgYmdj/NoVcwB0v5Mj96Xalh
 KW5Ng2E4WnCkt/GTWsDHkUV2UwCzJs+oEdV0bMkELTQJxAt4BTO+YVYGdp5Nm3qQsP/I
 5naod6RIZf/T7wEGnlLd0Cdp4QhUDWqnfqXWtV162ihZal/8ZjrxGMvM2WUesVruib3j
 Sbrg==
X-Gm-Message-State: APjAAAUI7E8m3pVsLyDIfIfptdLvH2qgaMHOAC2sb14EeE7Y21dP03ew
 TxVG9PWZ8bx4+9G5Mu8/Ir4I+A==
X-Google-Smtp-Source: APXvYqzLMYxnsGZrR8MvOsrS4f2bRC6VliVXp6yOEMA4zIKVI2SYdAacJOH4fQ8deKmqievI/l/3cQ==
X-Received: by 2002:a5d:490a:: with SMTP id x10mr7017845wrq.152.1565189090361; 
 Wed, 07 Aug 2019 07:44:50 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id t185sm252565wma.11.2019.08.07.07.44.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 07:44:49 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-16-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3cec7bcc-984f-bc82-6366-d530ae48b356@redhat.com>
Date: Wed, 7 Aug 2019 16:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 15/29] Include migration/vmstate.h less
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
> In my "build everything" tree, changing migration/vmstate.h triggers a
> recompile of some 2700 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).
> 
> hw/hw.h supposedly includes it for convenience.  Several other headers
> include it just to get VMStateDescription.  The previous commit made
> that unnecessary.
> 
> Include migration/vmstate.h only where it's still needed.  Touching it
> now recompiles only some 1600 objects.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  audio/audio.c                      | 1 +
>  cpus.c                             | 1 +
>  hw/acpi/cpu.c                      | 1 +
>  hw/acpi/ich9.c                     | 1 +
>  hw/acpi/memory_hotplug.c           | 1 +
>  hw/acpi/pcihp.c                    | 1 +
>  hw/acpi/piix4.c                    | 1 +
>  hw/acpi/tco.c                      | 2 ++
>  hw/acpi/vmgenid.c                  | 1 +
>  hw/adc/stm32f2xx_adc.c             | 1 +
>  hw/arm/armsse.c                    | 1 +
>  hw/arm/highbank.c                  | 1 +
>  hw/arm/integratorcp.c              | 1 +
>  hw/arm/musicpal.c                  | 1 +
>  hw/arm/pxa2xx.c                    | 1 +
>  hw/arm/pxa2xx_gpio.c               | 1 +
>  hw/arm/pxa2xx_pic.c                | 1 +
>  hw/arm/smmuv3.c                    | 1 +
>  hw/arm/spitz.c                     | 1 +
>  hw/arm/stellaris.c                 | 1 +
>  hw/arm/strongarm.c                 | 1 +
>  hw/arm/versatilepb.c               | 1 +
>  hw/arm/virt-acpi-build.c           | 1 +
>  hw/arm/z2.c                        | 1 +
>  hw/audio/ac97.c                    | 1 +
>  hw/audio/cs4231.c                  | 1 +
>  hw/audio/cs4231a.c                 | 1 +
>  hw/audio/es1370.c                  | 1 +
>  hw/audio/gus.c                     | 1 +
>  hw/audio/hda-codec.c               | 1 +
>  hw/audio/intel-hda.c               | 1 +
>  hw/audio/lm4549.c                  | 1 +
>  hw/audio/marvell_88w8618.c         | 1 +
>  hw/audio/milkymist-ac97.c          | 1 +
>  hw/audio/pcspk.c                   | 1 +
>  hw/audio/pl041.c                   | 1 +
>  hw/audio/sb16.c                    | 1 +
>  hw/audio/wm8750.c                  | 1 +
>  hw/block/ecc.c                     | 1 +
>  hw/block/fdc.c                     | 1 +
>  hw/block/m25p80.c                  | 1 +
>  hw/block/nand.c                    | 1 +
>  hw/block/nvme.c                    | 1 +
>  hw/block/onenand.c                 | 1 +
>  hw/block/pflash_cfi01.c            | 1 +
>  hw/block/pflash_cfi02.c            | 1 +
>  hw/char/bcm2835_aux.c              | 1 +
>  hw/char/cadence_uart.c             | 1 +
>  hw/char/cmsdk-apb-uart.c           | 1 +
>  hw/char/digic-uart.c               | 1 +
>  hw/char/escc.c                     | 1 +
>  hw/char/exynos4210_uart.c          | 1 +
>  hw/char/imx_serial.c               | 1 +
>  hw/char/ipoctal232.c               | 1 +
>  hw/char/lm32_juart.c               | 1 +
>  hw/char/lm32_uart.c                | 1 +
>  hw/char/milkymist-uart.c           | 1 +
>  hw/char/nrf51_uart.c               | 1 +
>  hw/char/parallel.c                 | 1 +
>  hw/char/pl011.c                    | 1 +
>  hw/char/sclpconsole-lm.c           | 1 +
>  hw/char/sclpconsole.c              | 1 +
>  hw/char/serial-isa.c               | 1 +
>  hw/char/serial-pci-multi.c         | 1 +
>  hw/char/serial-pci.c               | 1 +
>  hw/char/serial.c                   | 1 +
>  hw/char/spapr_vty.c                | 1 +
>  hw/core/loader.c                   | 1 +
>  hw/core/numa.c                     | 1 +
>  hw/core/or-irq.c                   | 1 +
>  hw/core/ptimer.c                   | 2 ++
>  hw/core/qdev.c                     | 1 +
>  hw/display/ads7846.c               | 1 +
>  hw/display/bcm2835_fb.c            | 1 +
>  hw/display/bochs-display.c         | 1 +
>  hw/display/cg3.c                   | 1 +
>  hw/display/cirrus_vga.c            | 1 +
>  hw/display/dpcd.c                  | 1 +
>  hw/display/exynos4210_fimd.c       | 1 +
>  hw/display/g364fb.c                | 1 +
>  hw/display/i2c-ddc.c               | 1 +
>  hw/display/jazz_led.c              | 1 +
>  hw/display/milkymist-tmu2.c        | 1 +
>  hw/display/milkymist-vgafb.c       | 1 +
>  hw/display/pl110.c                 | 1 +
>  hw/display/pxa2xx_lcd.c            | 1 +
>  hw/display/qxl.c                   | 1 +
>  hw/display/sii9022.c               | 1 +
>  hw/display/sm501.c                 | 1 +
>  hw/display/ssd0303.c               | 1 +
>  hw/display/ssd0323.c               | 1 +
>  hw/display/tcx.c                   | 1 +
>  hw/display/vga-isa-mm.c            | 2 ++
>  hw/display/vga-pci.c               | 1 +
>  hw/display/vga.c                   | 1 +
>  hw/display/vmware_vga.c            | 1 +
>  hw/display/xlnx_dp.c               | 1 +
>  hw/dma/bcm2835_dma.c               | 1 +
>  hw/dma/i82374.c                    | 1 +
>  hw/dma/i8257.c                     | 1 +
>  hw/dma/pl080.c                     | 1 +
>  hw/dma/pl330.c                     | 1 +
>  hw/dma/pxa2xx_dma.c                | 1 +
>  hw/dma/rc4030.c                    | 1 +
>  hw/dma/sparc32_dma.c               | 1 +
>  hw/dma/xlnx-zdma.c                 | 1 +
>  hw/dma/xlnx-zynq-devcfg.c          | 1 +
>  hw/dma/xlnx_dpdma.c                | 1 +
>  hw/gpio/bcm2835_gpio.c             | 1 +
>  hw/gpio/gpio_key.c                 | 1 +
>  hw/gpio/imx_gpio.c                 | 1 +
>  hw/gpio/max7310.c                  | 1 +
>  hw/gpio/mpc8xxx.c                  | 1 +
>  hw/gpio/nrf51_gpio.c               | 1 +
>  hw/gpio/pl061.c                    | 1 +
>  hw/gpio/zaurus.c                   | 1 +
>  hw/hppa/dino.c                     | 1 +
>  hw/i2c/aspeed_i2c.c                | 1 +
>  hw/i2c/core.c                      | 1 +
>  hw/i2c/exynos4210_i2c.c            | 1 +
>  hw/i2c/imx_i2c.c                   | 1 +
>  hw/i2c/microbit_i2c.c              | 1 +
>  hw/i2c/mpc_i2c.c                   | 1 +
>  hw/i2c/pm_smbus.c                  | 2 ++
>  hw/i2c/smbus_eeprom.c              | 1 +
>  hw/i2c/smbus_ich9.c                | 1 +
>  hw/i2c/smbus_slave.c               | 1 +
>  hw/i386/acpi-build.c               | 1 +
>  hw/i386/amd_iommu.c                | 2 ++
>  hw/i386/intel_iommu.c              | 1 +
>  hw/i386/kvm/clock.c                | 1 +
>  hw/i386/kvmvapic.c                 | 1 +
>  hw/i386/pc.c                       | 1 +
>  hw/i386/vmmouse.c                  | 2 ++
>  hw/i386/xen/xen_platform.c         | 1 +
>  hw/i386/xen/xen_pvdevice.c         | 1 +
>  hw/ide/ahci-allwinner.c            | 1 +
>  hw/ide/ahci.c                      | 1 +
>  hw/ide/cmd646.c                    | 1 +
>  hw/ide/core.c                      | 1 +
>  hw/ide/ich.c                       | 1 +
>  hw/ide/isa.c                       | 1 +
>  hw/ide/macio.c                     | 1 +
>  hw/ide/microdrive.c                | 1 +
>  hw/ide/mmio.c                      | 1 +
>  hw/ide/pci.c                       | 1 +
>  hw/ide/piix.c                      | 1 +
>  hw/ide/via.c                       | 1 +
>  hw/input/adb-kbd.c                 | 1 +
>  hw/input/adb-mouse.c               | 1 +
>  hw/input/adb.c                     | 1 +
>  hw/input/hid.c                     | 2 ++
>  hw/input/lm832x.c                  | 1 +
>  hw/input/milkymist-softusb.c       | 1 +
>  hw/input/pckbd.c                   | 1 +
>  hw/input/pl050.c                   | 1 +
>  hw/input/ps2.c                     | 1 +
>  hw/input/pxa2xx_keypad.c           | 1 +
>  hw/input/stellaris_input.c         | 1 +
>  hw/input/tsc2005.c                 | 1 +
>  hw/input/tsc210x.c                 | 1 +
>  hw/intc/allwinner-a10-pic.c        | 1 +
>  hw/intc/apic_common.c              | 1 +
>  hw/intc/arm_gic_common.c           | 1 +
>  hw/intc/arm_gicv3_common.c         | 1 +
>  hw/intc/arm_gicv3_its_common.c     | 1 +
>  hw/intc/armv7m_nvic.c              | 1 +
>  hw/intc/aspeed_vic.c               | 1 +
>  hw/intc/bcm2835_ic.c               | 1 +
>  hw/intc/bcm2836_control.c          | 1 +
>  hw/intc/exynos4210_combiner.c      | 1 +
>  hw/intc/exynos4210_gic.c           | 1 +
>  hw/intc/heathrow_pic.c             | 1 +
>  hw/intc/i8259_common.c             | 2 ++
>  hw/intc/imx_avic.c                 | 1 +
>  hw/intc/imx_gpcv2.c                | 1 +
>  hw/intc/ioapic_common.c            | 1 +
>  hw/intc/lm32_pic.c                 | 1 +
>  hw/intc/ompic.c                    | 1 +
>  hw/intc/openpic.c                  | 1 +
>  hw/intc/pl190.c                    | 1 +
>  hw/intc/slavio_intctl.c            | 1 +
>  hw/intc/spapr_xive.c               | 1 +
>  hw/intc/xics.c                     | 1 +
>  hw/intc/xive.c                     | 1 +
>  hw/intc/xlnx-pmu-iomod-intc.c      | 1 +
>  hw/intc/xlnx-zynqmp-ipi.c          | 1 +
>  hw/ipack/ipack.c                   | 1 +
>  hw/ipack/tpci200.c                 | 1 +
>  hw/ipmi/ipmi_bmc_extern.c          | 1 +
>  hw/ipmi/ipmi_bmc_sim.c             | 1 +
>  hw/ipmi/isa_ipmi_bt.c              | 1 +
>  hw/ipmi/isa_ipmi_kcs.c             | 1 +
>  hw/isa/apm.c                       | 1 +
>  hw/isa/i82378.c                    | 1 +
>  hw/isa/lpc_ich9.c                  | 1 +
>  hw/isa/pc87312.c                   | 1 +
>  hw/isa/piix4.c                     | 1 +
>  hw/isa/vt82c686.c                  | 1 +
>  hw/mem/pc-dimm.c                   | 1 +
>  hw/mips/gt64xxx_pci.c              | 1 +
>  hw/misc/a9scu.c                    | 1 +
>  hw/misc/arm_l2x0.c                 | 1 +
>  hw/misc/arm_sysctl.c               | 1 +
>  hw/misc/armsse-mhu.c               | 1 +
>  hw/misc/aspeed_scu.c               | 1 +
>  hw/misc/aspeed_sdmc.c              | 1 +
>  hw/misc/aspeed_xdma.c              | 1 +
>  hw/misc/bcm2835_mbox.c             | 1 +
>  hw/misc/bcm2835_property.c         | 1 +
>  hw/misc/bcm2835_rng.c              | 1 +
>  hw/misc/eccmemctl.c                | 1 +
>  hw/misc/exynos4210_clk.c           | 1 +
>  hw/misc/exynos4210_pmu.c           | 1 +
>  hw/misc/exynos4210_rng.c           | 1 +
>  hw/misc/imx25_ccm.c                | 1 +
>  hw/misc/imx31_ccm.c                | 1 +
>  hw/misc/imx6_ccm.c                 | 1 +
>  hw/misc/imx6_src.c                 | 1 +
>  hw/misc/imx6ul_ccm.c               | 1 +
>  hw/misc/imx7_ccm.c                 | 1 +
>  hw/misc/iotkit-secctl.c            | 1 +
>  hw/misc/iotkit-sysctl.c            | 1 +
>  hw/misc/ivshmem.c                  | 1 +
>  hw/misc/macio/cuda.c               | 1 +
>  hw/misc/macio/gpio.c               | 1 +
>  hw/misc/macio/mac_dbdma.c          | 1 +
>  hw/misc/macio/macio.c              | 1 +
>  hw/misc/macio/pmu.c                | 1 +
>  hw/misc/max111x.c                  | 1 +
>  hw/misc/milkymist-hpdmc.c          | 1 +
>  hw/misc/milkymist-pfpu.c           | 1 +
>  hw/misc/mips_cmgcr.c               | 1 +
>  hw/misc/mips_cpc.c                 | 1 +
>  hw/misc/mos6522.c                  | 1 +
>  hw/misc/mps2-fpgaio.c              | 1 +
>  hw/misc/mps2-scc.c                 | 1 +
>  hw/misc/msf2-sysreg.c              | 1 +
>  hw/misc/mst_fpga.c                 | 1 +
>  hw/misc/nrf51_rng.c                | 1 +
>  hw/misc/pca9552.c                  | 1 +
>  hw/misc/slavio_misc.c              | 1 +
>  hw/misc/tmp105.c                   | 1 +
>  hw/misc/tmp421.c                   | 1 +
>  hw/misc/tz-mpc.c                   | 1 +
>  hw/misc/tz-msc.c                   | 1 +
>  hw/misc/tz-ppc.c                   | 1 +
>  hw/misc/vmcoreinfo.c               | 1 +
>  hw/misc/zynq-xadc.c                | 1 +
>  hw/misc/zynq_slcr.c                | 1 +
>  hw/net/allwinner_emac.c            | 1 +
>  hw/net/cadence_gem.c               | 1 +
>  hw/net/can/can_kvaser_pci.c        | 1 +
>  hw/net/can/can_mioe3680_pci.c      | 1 +
>  hw/net/can/can_pcm3680_pci.c       | 1 +
>  hw/net/can/can_sja1000.c           | 1 +
>  hw/net/dp8393x.c                   | 1 +
>  hw/net/e1000.c                     | 1 +
>  hw/net/e1000e.c                    | 1 +
>  hw/net/eepro100.c                  | 1 +
>  hw/net/ftgmac100.c                 | 1 +
>  hw/net/imx_fec.c                   | 1 +
>  hw/net/lan9118.c                   | 1 +
>  hw/net/lance.c                     | 1 +
>  hw/net/milkymist-minimac2.c        | 1 +
>  hw/net/mipsnet.c                   | 1 +
>  hw/net/ne2000-isa.c                | 1 +
>  hw/net/ne2000-pci.c                | 1 +
>  hw/net/ne2000.c                    | 1 +
>  hw/net/pcnet-pci.c                 | 1 +
>  hw/net/pcnet.c                     | 1 +
>  hw/net/rocker/rocker.c             | 1 +
>  hw/net/rtl8139.c                   | 1 +
>  hw/net/smc91c111.c                 | 1 +
>  hw/net/spapr_llan.c                | 1 +
>  hw/net/stellaris_enet.c            | 1 +
>  hw/net/sungem.c                    | 1 +
>  hw/net/sunhme.c                    | 1 +
>  hw/net/vmxnet3.c                   | 1 +
>  hw/net/xgmac.c                     | 1 +
>  hw/nvram/ds1225y.c                 | 1 +
>  hw/nvram/eeprom93xx.c              | 1 +
>  hw/nvram/fw_cfg.c                  | 1 +
>  hw/nvram/mac_nvram.c               | 1 +
>  hw/nvram/nrf51_nvm.c               | 1 +
>  hw/nvram/spapr_nvram.c             | 1 +
>  hw/openrisc/cputimer.c             | 1 +
>  hw/pci-bridge/gen_pcie_root_port.c | 1 +
>  hw/pci-bridge/i82801b11.c          | 1 +
>  hw/pci-bridge/ioh3420.c            | 1 +
>  hw/pci-bridge/xio3130_downstream.c | 1 +
>  hw/pci-bridge/xio3130_upstream.c   | 1 +
>  hw/pci-host/bonito.c               | 1 +
>  hw/pci-host/designware.c           | 1 +
>  hw/pci-host/gpex.c                 | 1 +
>  hw/pci-host/piix.c                 | 1 +
>  hw/pci-host/ppce500.c              | 1 +
>  hw/pci-host/prep.c                 | 1 +
>  hw/pci-host/q35.c                  | 1 +
>  hw/pci-host/versatile.c            | 1 +
>  hw/pci/msix.c                      | 1 +
>  hw/pci/pci.c                       | 1 +
>  hw/pci/pcie_aer.c                  | 1 +
>  hw/ppc/ppc.c                       | 1 +
>  hw/ppc/ppc4xx_pci.c                | 1 +
>  hw/ppc/prep_systemio.c             | 1 +
>  hw/ppc/rs6000_mc.c                 | 1 +
>  hw/ppc/spapr_caps.c                | 1 +
>  hw/ppc/spapr_cpu_core.c            | 1 +
>  hw/ppc/spapr_drc.c                 | 1 +
>  hw/ppc/spapr_iommu.c               | 1 +
>  hw/ppc/spapr_ovec.c                | 1 +
>  hw/ppc/spapr_pci.c                 | 1 +
>  hw/ppc/spapr_rtc.c                 | 1 +
>  hw/ppc/spapr_vio.c                 | 1 +
>  hw/riscv/sifive_gpio.c             | 1 +
>  hw/s390x/event-facility.c          | 1 +
>  hw/s390x/sclpquiesce.c             | 1 +
>  hw/scsi/esp-pci.c                  | 1 +
>  hw/scsi/esp.c                      | 1 +
>  hw/scsi/lsi53c895a.c               | 1 +
>  hw/scsi/megasas.c                  | 1 +
>  hw/scsi/mptsas.c                   | 1 +
>  hw/scsi/scsi-bus.c                 | 1 +
>  hw/scsi/scsi-disk.c                | 1 +
>  hw/scsi/spapr_vscsi.c              | 1 +
>  hw/scsi/vmw_pvscsi.c               | 1 +
>  hw/sd/bcm2835_sdhost.c             | 1 +
>  hw/sd/milkymist-memcard.c          | 1 +
>  hw/sd/pl181.c                      | 1 +
>  hw/sd/pxa2xx_mmci.c                | 1 +
>  hw/sd/sd.c                         | 1 +
>  hw/sd/sdhci.c                      | 1 +
>  hw/sd/ssi-sd.c                     | 1 +
>  hw/sparc/sun4m.c                   | 1 +
>  hw/sparc/sun4m_iommu.c             | 1 +
>  hw/sparc64/sun4u.c                 | 2 ++
>  hw/ssi/aspeed_smc.c                | 1 +
>  hw/ssi/imx_spi.c                   | 1 +
>  hw/ssi/mss-spi.c                   | 1 +
>  hw/ssi/pl022.c                     | 1 +
>  hw/ssi/ssi.c                       | 1 +
>  hw/ssi/stm32f2xx_spi.c             | 1 +
>  hw/ssi/xilinx_spi.c                | 1 +
>  hw/ssi/xilinx_spips.c              | 1 +
>  hw/timer/a9gtimer.c                | 1 +
>  hw/timer/allwinner-a10-pit.c       | 1 +
>  hw/timer/arm_mptimer.c             | 1 +
>  hw/timer/arm_timer.c               | 1 +
>  hw/timer/armv7m_systick.c          | 1 +
>  hw/timer/aspeed_rtc.c              | 1 +
>  hw/timer/aspeed_timer.c            | 1 +
>  hw/timer/cadence_ttc.c             | 1 +
>  hw/timer/cmsdk-apb-dualtimer.c     | 1 +
>  hw/timer/cmsdk-apb-timer.c         | 1 +
>  hw/timer/digic-timer.c             | 1 +
>  hw/timer/ds1338.c                  | 1 +
>  hw/timer/exynos4210_mct.c          | 1 +
>  hw/timer/exynos4210_pwm.c          | 1 +
>  hw/timer/exynos4210_rtc.c          | 1 +
>  hw/timer/hpet.c                    | 1 +
>  hw/timer/i8254_common.c            | 1 +
>  hw/timer/imx_epit.c                | 1 +
>  hw/timer/imx_gpt.c                 | 1 +
>  hw/timer/lm32_timer.c              | 1 +
>  hw/timer/m48t59.c                  | 1 +
>  hw/timer/mc146818rtc.c             | 1 +
>  hw/timer/milkymist-sysctl.c        | 1 +
>  hw/timer/mss-timer.c               | 1 +
>  hw/timer/nrf51_timer.c             | 1 +
>  hw/timer/pl031.c                   | 1 +
>  hw/timer/pxa2xx_timer.c            | 1 +
>  hw/timer/slavio_timer.c            | 1 +
>  hw/timer/stm32f2xx_timer.c         | 1 +
>  hw/timer/twl92230.c                | 1 +
>  hw/timer/xlnx-zynqmp-rtc.c         | 1 +
>  hw/tpm/tpm_emulator.c              | 1 +
>  hw/tpm/tpm_tis.c                   | 1 +
>  hw/usb/bus.c                       | 1 +
>  hw/usb/ccid-card-passthru.c        | 1 +
>  hw/usb/dev-audio.c                 | 1 +
>  hw/usb/dev-bluetooth.c             | 1 +
>  hw/usb/dev-hid.c                   | 1 +
>  hw/usb/dev-hub.c                   | 1 +
>  hw/usb/dev-mtp.c                   | 1 +
>  hw/usb/dev-network.c               | 1 +
>  hw/usb/dev-serial.c                | 1 +
>  hw/usb/dev-smartcard-reader.c      | 1 +
>  hw/usb/dev-storage.c               | 1 +
>  hw/usb/dev-uas.c                   | 1 +
>  hw/usb/dev-wacom.c                 | 1 +
>  hw/usb/hcd-ehci-pci.c              | 1 +
>  hw/usb/hcd-ehci-sysbus.c           | 1 +
>  hw/usb/hcd-ehci.c                  | 1 +
>  hw/usb/hcd-ohci-pci.c              | 1 +
>  hw/usb/hcd-ohci.c                  | 1 +
>  hw/usb/hcd-uhci.c                  | 1 +
>  hw/usb/hcd-xhci.c                  | 1 +
>  hw/usb/host-libusb.c               | 1 +
>  hw/usb/redirect.c                  | 1 +
>  hw/vfio/amd-xgbe.c                 | 1 +
>  hw/vfio/ap.c                       | 1 +
>  hw/vfio/calxeda-xgmac.c            | 1 +
>  hw/vfio/pci.c                      | 1 +
>  hw/vfio/platform.c                 | 1 +
>  hw/watchdog/cmsdk-apb-watchdog.c   | 1 +
>  hw/watchdog/wdt_aspeed.c           | 1 +
>  hw/watchdog/wdt_diag288.c          | 1 +
>  hw/watchdog/wdt_i6300esb.c         | 1 +
>  hw/watchdog/wdt_ib700.c            | 1 +
>  hw/xtensa/xtfpga.c                 | 1 +
>  include/hw/acpi/tco.h              | 1 -
>  include/hw/block/flash.h           | 1 -
>  include/hw/hw.h                    | 1 -
>  include/hw/input/hid.h             | 1 -
>  include/hw/pci/shpc.h              | 1 +
>  include/hw/ppc/spapr_ovec.h        | 1 -
>  include/hw/ptimer.h                | 1 -
>  include/hw/virtio/virtio.h         | 1 +
>  include/net/net.h                  | 1 -
>  include/qemu/fifo8.h               | 1 -
>  migration/savevm.c                 | 1 +
>  target/alpha/machine.c             | 1 +
>  target/arm/machine.c               | 1 +
>  target/cris/machine.c              | 1 +
>  target/hppa/machine.c              | 1 +
>  target/i386/machine.c              | 1 +
>  target/lm32/machine.c              | 1 +
>  target/mips/machine.c              | 1 +
>  target/moxie/machine.c             | 1 +
>  target/openrisc/machine.c          | 1 +
>  target/ppc/machine.c               | 1 +
>  target/s390x/machine.c             | 1 +
>  target/sparc/machine.c             | 1 +

target/*/machine.c are odd files... Find a common pattern is not obvious.

$ git grep 'cc..vmsd ='
target/arm/cpu.c:2604:    cc->vmsd = &vmstate_arm_cpu;
target/i386/cpu.c:5953:    cc->vmsd = &vmstate_x86_cpu;
target/lm32/cpu.c:235:    cc->vmsd = &vmstate_lm32_cpu;
target/mips/cpu.c:203:    cc->vmsd = &vmstate_mips_cpu;
target/moxie/cpu.c:116:    cc->vmsd = &vmstate_moxie_cpu;
target/ppc/translate_init.inc.c:10597:    cc->vmsd = &vmstate_ppc_cpu;
target/riscv/cpu.c:492:    cc->vmsd = &vmstate_riscv_cpu;
target/s390x/cpu.c:491:    cc->vmsd = &vmstate_s390_cpu;
target/sparc/cpu.c:883:    cc->vmsd = &vmstate_sparc_cpu;

Various machine.c are not justified and could go into cpu.c.
(Not this patch problem).

However I wonder if "migration/vmstate.h" shouldn't be included in
include/migration/cpu.h instead.

>  util/fifo8.c                       | 1 +
>  435 files changed, 436 insertions(+), 8 deletions(-)
[...]
> diff --git a/target/moxie/machine.c b/target/moxie/machine.c
> index 322a724e6f..0d6012603e 100644
> --- a/target/moxie/machine.c
> +++ b/target/moxie/machine.c
> @@ -4,6 +4,7 @@
>  #include "hw/boards.h"
>  #include "machine.h"
>  #include "migration/cpu.h"
> +#include "migration/vmstate.h"

Hmm this one seems to belong to target/moxie/machine.h... which happens
to be also odd.

>  const VMStateDescription vmstate_moxie_cpu = {
>      .name = "cpu",
> diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
> index 9fa285217d..1332a2c0ee 100644
> --- a/target/openrisc/machine.c
> +++ b/target/openrisc/machine.c
> @@ -22,6 +22,7 @@
>  #include "hw/hw.h"
>  #include "hw/boards.h"
>  #include "migration/cpu.h"
> +#include "migration/vmstate.h"
>  
>  static const VMStateDescription vmstate_tlb_entry = {
>      .name = "tlb_entry",
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index e82f5de9db..f1cd41aeb4 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -7,6 +7,7 @@
>  #include "helper_regs.h"
>  #include "mmu-hash64.h"
>  #include "migration/cpu.h"
> +#include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "kvm_ppc.h"
>  #include "exec/helper-proto.h"
> diff --git a/target/s390x/machine.c b/target/s390x/machine.c
> index 1e9526e937..12a2cd65b0 100644
> --- a/target/s390x/machine.c
> +++ b/target/s390x/machine.c
> @@ -19,6 +19,7 @@
>  #include "cpu.h"
>  #include "internal.h"
>  #include "kvm_s390x.h"
> +#include "migration/vmstate.h"
>  #include "tcg_s390x.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 32d453c008..f7dabea326 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -6,6 +6,7 @@
>  #include "qemu/timer.h"
>  
>  #include "migration/cpu.h"
> +#include "migration/vmstate.h"
>  
>  #ifdef TARGET_SPARC64
>  static const VMStateDescription vmstate_cpu_timer = {
> diff --git a/util/fifo8.c b/util/fifo8.c
> index a9aa20a9f7..a5dd789ce5 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "migration/vmstate.h"
>  #include "qemu/fifo8.h"
>  
>  void fifo8_create(Fifo8 *fifo, uint32_t capacity)
> 

