Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9137C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1BA20665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1BA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCoO-0007jC-Qw
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50009)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxClM-0001rg-O6
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxClK-0001CL-FI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:01:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxClK-0001Bi-72
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:01:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so8324860wrq.9
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 09:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8U1s7cn2ZZyW4D/vly704i4JaoRLhq+fTyh2QaWIPGA=;
 b=J1nkMK8kcR+d+oSWmnQ01+j4G9PGONpzmcB0AqnIfpbO+xon1OplZlI1QqxSLTLX1e
 bzmapZQVyfLKtKFcHWvjcGsvjyMVpWMivC0UPYUoGmkhJqOUOFImdQH89uCF+73A7uuv
 p5jaBdDeZPEblCdAE63QM0djWk04znm5bZ0/pY3bwBiWIqVWgS2aHzSZxRreeOjKZ/UV
 8K8HE67LprvEK16S0GZYr5LorNv3rHkOQLhjhhhcKRCalnqWRDgqHgw3oIsc4AaNS/BN
 OigIJeCpz6JMddESGH267QieKTvfat1f6TCdtV7Gl+kpCx6isQQRKC00c+a9XC1qToZl
 SX0A==
X-Gm-Message-State: APjAAAWFpDwu8TL506YrtXNDU9DT6u0T9HH1W5hXGvXzpsM/2ewfKsRg
 Djo49Y5Oe7PmKo70DtDwpykfKw==
X-Google-Smtp-Source: APXvYqygt/i0XNj9JJVCph3+YWgs0nDOrjG93zKZ5n5K+CZ5r3oIGBt2PXomPzpBW8bedbNQ7yKXGg==
X-Received: by 2002:adf:fd8b:: with SMTP id d11mr3287092wrr.300.1565625692384; 
 Mon, 12 Aug 2019 09:01:32 -0700 (PDT)
Received: from [192.168.1.34] (59.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.59])
 by smtp.gmail.com with ESMTPSA id h97sm31253716wrh.74.2019.08.12.09.01.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 09:01:31 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-19-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fc6a09ea-c214-f0e6-7e78-43d85a82706b@redhat.com>
Date: Mon, 12 Aug 2019 18:01:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812052359.30071-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 18/29] Include hw/hw.h exactly where
 needed
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

On 8/12/19 7:23 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing hw/hw.h triggers a recompile
> of some 2600 out of 6600 objects (not counting tests and objects that
> don't depend on qemu/osdep.h).
> 
> The previous commits have left only the declaration of hw_error() in
> hw/hw.h.  This permits dropping most of its inclusions.  Touching it
> now recompiles less than 200 objects.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/display/qxl.h                         | 1 -
>  hw/i386/amd_iommu.h                      | 1 -
>  hw/microblaze/boot.h                     | 1 -
>  hw/net/ne2000.h                          | 1 -
>  hw/nios2/boot.h                          | 1 -
>  hw/usb/hcd-ehci.h                        | 1 -
>  include/hw/audio/pcspk.h                 | 1 -
>  include/hw/audio/wm8750.h                | 1 -
>  include/hw/char/serial.h                 | 1 -
>  include/hw/char/stm32f2xx_usart.h        | 1 -
>  include/hw/dma/i8257.h                   | 1 -
>  include/hw/hw.h                          | 1 -
>  include/hw/i386/ich9.h                   | 1 -
>  include/hw/i386/ioapic_internal.h        | 1 -
>  include/hw/input/i8042.h                 | 1 -
>  include/hw/isa/apm.h                     | 1 -
>  include/hw/isa/i8259_internal.h          | 1 -
>  include/hw/misc/stm32f2xx_syscfg.h       | 1 -
>  include/hw/net/ne2000-isa.h              | 1 -
>  include/hw/pci-host/designware.h         | 1 -
>  include/hw/pci-host/gpex.h               | 1 -
>  include/hw/pci-host/q35.h                | 1 -
>  include/hw/pci-host/uninorth.h           | 1 -
>  include/hw/pci-host/xilinx-pcie.h        | 1 -
>  include/hw/pci/pcie.h                    | 1 -
>  include/hw/pci/pcie_aer.h                | 1 -
>  include/hw/qdev.h                        | 1 -
>  include/hw/riscv/riscv_htif.h            | 1 -
>  include/hw/ssi/stm32f2xx_spi.h           | 1 -
>  include/hw/timer/aspeed_rtc.h            | 1 -
>  include/hw/timer/i8254.h                 | 1 -
>  include/hw/timer/i8254_internal.h        | 1 -
>  include/hw/virtio/vhost.h                | 1 -
>  include/hw/virtio/virtio.h               | 1 -
>  include/hw/xen/xen_common.h              | 1 -
>  include/sysemu/dma.h                     | 1 -
>  include/sysemu/hax.h                     | 1 -
>  include/sysemu/hvf.h                     | 1 -
>  accel/kvm/kvm-all.c                      | 1 -
>  audio/audio.c                            | 1 -
>  audio/spiceaudio.c                       | 1 -
>  audio/wavcapture.c                       | 1 -
>  cpus.c                                   | 1 +
>  device-hotplug.c                         | 1 -
>  exec.c                                   | 1 -
>  hw/9pfs/xen-9p-backend.c                 | 1 -
>  hw/acpi/core.c                           | 1 -
>  hw/acpi/cpu_hotplug.c                    | 1 -
>  hw/acpi/ich9.c                           | 1 -
>  hw/acpi/pcihp.c                          | 1 -
>  hw/acpi/piix4.c                          | 1 -
>  hw/adc/stm32f2xx_adc.c                   | 1 -
>  hw/alpha/dp264.c                         | 1 -
>  hw/alpha/typhoon.c                       | 1 -
>  hw/arm/boot.c                            | 1 -
>  hw/arm/collie.c                          | 1 -
>  hw/arm/gumstix.c                         | 1 -
>  hw/arm/integratorcp.c                    | 1 +
>  hw/arm/mainstone.c                       | 1 -
>  hw/arm/musicpal.c                        | 1 +
>  hw/arm/omap2.c                           | 1 -
>  hw/arm/omap_sx1.c                        | 1 -
>  hw/arm/palm.c                            | 1 -
>  hw/arm/pxa2xx_pic.c                      | 1 -
>  hw/arm/spitz.c                           | 1 -
>  hw/arm/tosa.c                            | 1 -
>  hw/arm/virt-acpi-build.c                 | 1 -
>  hw/arm/z2.c                              | 1 -
>  hw/audio/ac97.c                          | 1 -
>  hw/audio/adlib.c                         | 1 -
>  hw/audio/cs4231a.c                       | 1 -
>  hw/audio/es1370.c                        | 1 -
>  hw/audio/gus.c                           | 1 -
>  hw/audio/hda-codec.c                     | 1 -
>  hw/audio/intel-hda.c                     | 1 -
>  hw/audio/marvell_88w8618.c               | 1 -
>  hw/audio/milkymist-ac97.c                | 1 -
>  hw/audio/pcspk.c                         | 1 -
>  hw/audio/sb16.c                          | 1 -
>  hw/block/dataplane/xen-block.c           | 1 -
>  hw/block/ecc.c                           | 1 -
>  hw/block/fdc.c                           | 1 -
>  hw/block/m25p80.c                        | 1 -
>  hw/block/nvme.c                          | 1 -
>  hw/block/pflash_cfi01.c                  | 1 -
>  hw/block/pflash_cfi02.c                  | 1 -
>  hw/block/tc58128.c                       | 1 -
>  hw/block/xen-block.c                     | 1 -
>  hw/char/debugcon.c                       | 1 -
>  hw/char/digic-uart.c                     | 1 -
>  hw/char/escc.c                           | 1 -
>  hw/char/lm32_juart.c                     | 1 -
>  hw/char/lm32_uart.c                      | 1 -
>  hw/char/mcf_uart.c                       | 1 -
>  hw/char/milkymist-uart.c                 | 1 -
>  hw/char/omap_uart.c                      | 1 -
>  hw/char/parallel.c                       | 1 -
>  hw/char/sh_serial.c                      | 1 -
>  hw/char/xen_console.c                    | 1 -
>  hw/char/xilinx_uartlite.c                | 1 +
>  hw/core/empty_slot.c                     | 1 -
>  hw/core/null-machine.c                   | 1 -
>  hw/core/ptimer.c                         | 1 -
>  hw/cris/boot.c                           | 1 -
>  hw/display/ati.c                         | 1 -
>  hw/display/bcm2835_fb.c                  | 1 +
>  hw/display/bochs-display.c               | 1 -
>  hw/display/cirrus_vga.c                  | 1 -
>  hw/display/cirrus_vga_isa.c              | 1 -
>  hw/display/exynos4210_fimd.c             | 1 +
>  hw/display/framebuffer.c                 | 1 -
>  hw/display/milkymist-tmu2.c              | 1 -
>  hw/display/omap_lcdc.c                   | 1 -
>  hw/display/sm501.c                       | 1 -
>  hw/display/tc6393xb.c                    | 1 -
>  hw/display/vga-isa-mm.c                  | 1 -
>  hw/display/vga-isa.c                     | 1 -
>  hw/display/vga-pci.c                     | 1 -
>  hw/display/vga.c                         | 1 -
>  hw/display/virtio-vga.c                  | 1 -
>  hw/display/vmware_vga.c                  | 1 -
>  hw/display/xenfb.c                       | 1 -
>  hw/dma/i8257.c                           | 1 -
>  hw/dma/pl080.c                           | 1 +
>  hw/dma/puv3_dma.c                        | 1 -
>  hw/dma/rc4030.c                          | 1 -
>  hw/dma/sparc32_dma.c                     | 1 -
>  hw/dma/xilinx_axidma.c                   | 1 +
>  hw/gpio/max7310.c                        | 1 +
>  hw/gpio/omap_gpio.c                      | 1 -
>  hw/gpio/puv3_gpio.c                      | 1 -
>  hw/gpio/zaurus.c                         | 1 -
>  hw/hppa/dino.c                           | 1 -
>  hw/hppa/machine.c                        | 1 -
>  hw/i2c/bitbang_i2c.c                     | 1 -
>  hw/i2c/omap_i2c.c                        | 1 -
>  hw/i2c/pm_smbus.c                        | 1 -
>  hw/i2c/ppc4xx_i2c.c                      | 1 -
>  hw/i2c/smbus_eeprom.c                    | 1 -
>  hw/i2c/smbus_ich9.c                      | 1 -
>  hw/i2c/smbus_master.c                    | 1 -
>  hw/i2c/smbus_slave.c                     | 1 -
>  hw/i386/multiboot.c                      | 1 -
>  hw/i386/pc.c                             | 1 -
>  hw/i386/pc_piix.c                        | 1 -
>  hw/i386/pc_q35.c                         | 1 -
>  hw/i386/pc_sysfw.c                       | 1 -
>  hw/i386/vmmouse.c                        | 1 -
>  hw/i386/vmport.c                         | 1 -
>  hw/i386/xen/xen-hvm.c                    | 1 +
>  hw/i386/xen/xen_platform.c               | 1 -
>  hw/i386/xen/xen_pvdevice.c               | 1 -
>  hw/ide/ahci-allwinner.c                  | 1 -
>  hw/ide/ahci.c                            | 1 -
>  hw/ide/cmd646.c                          | 1 -
>  hw/ide/core.c                            | 1 -
>  hw/ide/ich.c                             | 1 -
>  hw/ide/ioport.c                          | 1 -
>  hw/ide/isa.c                             | 1 -
>  hw/ide/macio.c                           | 1 -
>  hw/ide/microdrive.c                      | 1 -
>  hw/ide/mmio.c                            | 1 -
>  hw/ide/pci.c                             | 1 -
>  hw/ide/piix.c                            | 1 -
>  hw/ide/qdev.c                            | 1 -
>  hw/ide/via.c                             | 1 -
>  hw/input/hid.c                           | 1 -
>  hw/input/lm832x.c                        | 1 -
>  hw/input/milkymist-softusb.c             | 1 -
>  hw/input/pckbd.c                         | 1 -
>  hw/input/ps2.c                           | 1 -
>  hw/input/stellaris_input.c               | 1 -
>  hw/input/tsc2005.c                       | 1 -
>  hw/intc/etraxfs_pic.c                    | 1 -
>  hw/intc/exynos4210_combiner.c            | 1 +
>  hw/intc/heathrow_pic.c                   | 1 -
>  hw/intc/i8259.c                          | 1 -
>  hw/intc/ioapic.c                         | 1 -
>  hw/intc/lm32_pic.c                       | 1 -
>  hw/intc/mips_gic.c                       | 1 -
>  hw/intc/omap_intc.c                      | 1 -
>  hw/intc/ompic.c                          | 1 -
>  hw/intc/openpic.c                        | 1 -
>  hw/intc/openpic_kvm.c                    | 1 -
>  hw/intc/sh_intc.c                        | 1 -
>  hw/intc/xics.c                           | 1 -
>  hw/intc/xics_kvm.c                       | 1 -
>  hw/intc/xics_spapr.c                     | 1 -
>  hw/intc/xilinx_intc.c                    | 1 -
>  hw/ipmi/ipmi.c                           | 1 -
>  hw/ipmi/isa_ipmi_bt.c                    | 1 -
>  hw/ipmi/isa_ipmi_kcs.c                   | 1 -
>  hw/isa/apm.c                             | 1 -
>  hw/isa/lpc_ich9.c                        | 1 -
>  hw/isa/piix4.c                           | 1 -
>  hw/isa/vt82c686.c                        | 1 -
>  hw/lm32/lm32_boards.c                    | 1 -
>  hw/lm32/milkymist.c                      | 1 -
>  hw/m68k/an5206.c                         | 1 -
>  hw/microblaze/petalogix_ml605_mmu.c      | 1 -
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
>  hw/mips/addr.c                           | 1 -
>  hw/mips/boston.c                         | 1 -
>  hw/mips/gt64xxx_pci.c                    | 1 -
>  hw/mips/mips_fulong2e.c                  | 1 -
>  hw/mips/mips_int.c                       | 1 -
>  hw/mips/mips_jazz.c                      | 1 -
>  hw/mips/mips_malta.c                     | 1 -
>  hw/mips/mips_mipssim.c                   | 1 -
>  hw/mips/mips_r4k.c                       | 1 -
>  hw/misc/applesmc.c                       | 1 -
>  hw/misc/arm_integrator_debug.c           | 1 -
>  hw/misc/arm_sysctl.c                     | 1 -
>  hw/misc/debugexit.c                      | 1 -
>  hw/misc/edu.c                            | 1 +
>  hw/misc/ivshmem.c                        | 1 -
>  hw/misc/macio/cuda.c                     | 1 -
>  hw/misc/macio/gpio.c                     | 1 -
>  hw/misc/macio/mac_dbdma.c                | 1 -
>  hw/misc/macio/macio.c                    | 1 -
>  hw/misc/macio/pmu.c                      | 1 -
>  hw/misc/milkymist-hpdmc.c                | 1 -
>  hw/misc/milkymist-pfpu.c                 | 1 -
>  hw/misc/mips_cmgcr.c                     | 1 -
>  hw/misc/mos6522.c                        | 1 -
>  hw/misc/mst_fpga.c                       | 1 -
>  hw/misc/omap_gpmc.c                      | 1 -
>  hw/misc/omap_l4.c                        | 1 -
>  hw/misc/omap_sdrc.c                      | 1 -
>  hw/misc/pc-testdev.c                     | 1 -
>  hw/misc/pca9552.c                        | 1 -
>  hw/misc/pci-testdev.c                    | 1 -
>  hw/misc/puv3_pm.c                        | 1 -
>  hw/misc/tmp105.c                         | 1 -
>  hw/misc/tmp421.c                         | 1 -
>  hw/misc/unimp.c                          | 1 -
>  hw/misc/zynq-xadc.c                      | 1 -
>  hw/misc/zynq_slcr.c                      | 1 -
>  hw/moxie/moxiesim.c                      | 1 -
>  hw/net/can/can_kvaser_pci.c              | 1 -
>  hw/net/can/can_mioe3680_pci.c            | 1 -
>  hw/net/can/can_pcm3680_pci.c             | 1 -
>  hw/net/can/can_sja1000.c                 | 1 -
>  hw/net/e1000.c                           | 1 -
>  hw/net/e1000e.c                          | 1 +
>  hw/net/e1000e_core.c                     | 1 +
>  hw/net/e1000x_common.c                   | 1 -
>  hw/net/eepro100.c                        | 1 -
>  hw/net/lan9118.c                         | 1 +
>  hw/net/milkymist-minimac2.c              | 1 -
>  hw/net/mipsnet.c                         | 1 -
>  hw/net/opencores_eth.c                   | 1 -
>  hw/net/rocker/rocker.c                   | 1 -
>  hw/net/rocker/rocker_desc.c              | 1 -
>  hw/net/rtl8139.c                         | 1 -
>  hw/net/spapr_llan.c                      | 1 -
>  hw/net/sunhme.c                          | 1 -
>  hw/net/xen_nic.c                         | 1 -
>  hw/net/xilinx_axienet.c                  | 1 +
>  hw/net/xilinx_ethlite.c                  | 1 -
>  hw/nios2/10m50_devboard.c                | 1 -
>  hw/nios2/generic_nommu.c                 | 1 -
>  hw/nvram/chrp_nvram.c                    | 1 -
>  hw/nvram/eeprom93xx.c                    | 1 -
>  hw/nvram/eeprom_at24c.c                  | 1 -
>  hw/nvram/fw_cfg.c                        | 1 -
>  hw/nvram/mac_nvram.c                     | 1 -
>  hw/openrisc/cputimer.c                   | 1 -
>  hw/openrisc/openrisc_sim.c               | 1 -
>  hw/openrisc/pic_cpu.c                    | 1 -
>  hw/pci-host/bonito.c                     | 1 -
>  hw/pci-host/gpex.c                       | 1 -
>  hw/pci-host/piix.c                       | 1 -
>  hw/pci-host/ppce500.c                    | 1 -
>  hw/pci-host/prep.c                       | 1 -
>  hw/pci-host/q35.c                        | 1 -
>  hw/pci-host/uninorth.c                   | 1 -
>  hw/pci/msix.c                            | 1 -
>  hw/pci/pci.c                             | 1 -
>  hw/pci/pcie_host.c                       | 1 -
>  hw/pcmcia/pcmcia.c                       | 1 -
>  hw/pcmcia/pxa2xx.c                       | 1 -
>  hw/ppc/e500.c                            | 1 -
>  hw/ppc/mac_newworld.c                    | 1 -
>  hw/ppc/mac_oldworld.c                    | 1 -
>  hw/ppc/mpc8544_guts.c                    | 1 -
>  hw/ppc/pnv.c                             | 1 -
>  hw/ppc/pnv_bmc.c                         | 1 -
>  hw/ppc/pnv_occ.c                         | 1 -
>  hw/ppc/pnv_psi.c                         | 1 -
>  hw/ppc/pnv_xscom.c                       | 1 -
>  hw/ppc/ppc.c                             | 1 -
>  hw/ppc/ppc405_boards.c                   | 1 -
>  hw/ppc/ppc405_uc.c                       | 1 -
>  hw/ppc/ppc440_bamboo.c                   | 1 -
>  hw/ppc/ppc440_pcix.c                     | 1 -
>  hw/ppc/ppc440_uc.c                       | 1 -
>  hw/ppc/ppc4xx_devs.c                     | 1 -
>  hw/ppc/ppc4xx_pci.c                      | 1 -
>  hw/ppc/ppc_booke.c                       | 1 -
>  hw/ppc/prep.c                            | 1 -
>  hw/ppc/sam460ex.c                        | 1 -
>  hw/ppc/spapr.c                           | 1 -
>  hw/ppc/spapr_iommu.c                     | 1 -
>  hw/ppc/spapr_pci.c                       | 1 -
>  hw/ppc/spapr_vio.c                       | 1 -
>  hw/ppc/virtex_ml507.c                    | 1 -
>  hw/rdma/vmw/pvrdma_cmd.c                 | 1 -
>  hw/rdma/vmw/pvrdma_main.c                | 1 -
>  hw/riscv/sifive_e.c                      | 1 -
>  hw/riscv/sifive_prci.c                   | 1 +
>  hw/riscv/sifive_test.c                   | 1 +
>  hw/riscv/sifive_u.c                      | 1 -
>  hw/riscv/sifive_uart.c                   | 1 +
>  hw/riscv/spike.c                         | 1 -
>  hw/riscv/virt.c                          | 1 -
>  hw/s390x/virtio-ccw.c                    | 1 -
>  hw/scsi/lsi53c895a.c                     | 1 -
>  hw/scsi/megasas.c                        | 1 -
>  hw/scsi/mptconfig.c                      | 1 -
>  hw/scsi/mptendian.c                      | 1 -
>  hw/scsi/mptsas.c                         | 1 -
>  hw/scsi/scsi-bus.c                       | 1 -
>  hw/scsi/spapr_vscsi.c                    | 1 -
>  hw/sd/milkymist-memcard.c                | 1 -
>  hw/sd/omap_mmc.c                         | 1 -
>  hw/sd/pxa2xx_mmci.c                      | 1 -
>  hw/sd/sd.c                               | 1 -
>  hw/sd/sdhci-pci.c                        | 1 -
>  hw/sd/sdhci.c                            | 1 -
>  hw/sh4/r2d.c                             | 1 -
>  hw/sh4/sh7750.c                          | 1 -
>  hw/sh4/sh7750_regnames.c                 | 1 -
>  hw/sh4/shix.c                            | 1 -
>  hw/sparc/leon3.c                         | 1 -
>  hw/sparc64/niagara.c                     | 1 -
>  hw/sparc64/sun4u.c                       | 1 -
>  hw/timer/a9gtimer.c                      | 1 +
>  hw/timer/arm_mptimer.c                   | 1 +
>  hw/timer/exynos4210_mct.c                | 1 +
>  hw/timer/exynos4210_rtc.c                | 1 -
>  hw/timer/hpet.c                          | 1 -
>  hw/timer/i8254.c                         | 1 -
>  hw/timer/i8254_common.c                  | 1 -
>  hw/timer/lm32_timer.c                    | 1 -
>  hw/timer/m48t59.c                        | 1 -
>  hw/timer/mc146818rtc.c                   | 1 -
>  hw/timer/milkymist-sysctl.c              | 1 -
>  hw/timer/mips_gictimer.c                 | 1 -
>  hw/timer/omap_gptimer.c                  | 1 -
>  hw/timer/omap_synctimer.c                | 1 -
>  hw/timer/pxa2xx_timer.c                  | 1 -
>  hw/timer/sun4v-rtc.c                     | 1 -
>  hw/timer/twl92230.c                      | 1 -
>  hw/tpm/tpm_emulator.c                    | 1 -
>  hw/tpm/tpm_passthrough.c                 | 1 -
>  hw/tricore/tricore_testboard.c           | 1 -
>  hw/usb/bus.c                             | 1 -
>  hw/usb/dev-audio.c                       | 1 -
>  hw/usb/dev-hid.c                         | 1 -
>  hw/usb/dev-wacom.c                       | 1 -
>  hw/usb/hcd-ohci-pci.c                    | 1 -
>  hw/usb/hcd-ohci.c                        | 1 -
>  hw/usb/hcd-uhci.c                        | 1 -
>  hw/usb/hcd-xhci-nec.c                    | 1 -
>  hw/usb/hcd-xhci.c                        | 1 -
>  hw/usb/libhw.c                           | 1 -
>  hw/usb/tusb6010.c                        | 1 +
>  hw/vfio/pci-quirks.c                     | 1 +
>  hw/vfio/pci.c                            | 1 +
>  hw/virtio/vhost.c                        | 1 -
>  hw/virtio/virtio-bus.c                   | 1 -
>  hw/watchdog/wdt_i6300esb.c               | 1 -
>  hw/watchdog/wdt_ib700.c                  | 1 -
>  hw/xen/xen-bus-helper.c                  | 1 -
>  hw/xen/xen-bus.c                         | 1 -
>  hw/xen/xen-legacy-backend.c              | 1 -
>  hw/xen/xen_pt_load_rom.c                 | 1 -
>  hw/xenpv/xen_machine_pv.c                | 1 -
>  hw/xtensa/mx_pic.c                       | 1 -
>  hw/xtensa/pic_cpu.c                      | 1 -
>  monitor/misc.c                           | 1 -
>  target/alpha/machine.c                   | 1 -
>  target/arm/machine.c                     | 1 -
>  target/cris/machine.c                    | 1 -
>  target/hppa/machine.c                    | 1 -
>  target/i386/cpu.c                        | 1 -
>  target/i386/machine.c                    | 1 -
>  target/lm32/machine.c                    | 1 -
>  target/mips/machine.c                    | 1 -
>  target/moxie/machine.c                   | 1 -
>  target/openrisc/machine.c                | 1 -
>  target/ppc/kvm.c                         | 1 +
>  target/ppc/machine.c                     | 1 -
>  target/s390x/cpu.c                       | 1 -
>  target/s390x/kvm.c                       | 1 -
>  target/s390x/machine.c                   | 1 -
>  target/s390x/mmu_helper.c                | 1 +
>  target/sparc/machine.c                   | 1 -
>  ui/spice-core.c                          | 1 -
>  vl.c                                     | 1 -
>  401 files changed, 27 insertions(+), 374 deletions(-)

