Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF40C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B919207FB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwW6f8YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B919207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hsU-0004Pz-JM
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hpK-000820-2U
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:17:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hpF-0004tV-Uk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597681053;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wsornqmd6qYOIHhdfWciVs6XiWAAK90PlF0kjMYy5I=;
 b=MwW6f8YPKmi9STHKpbRCzP0ORFcr4WsKVkArXdKjRzWfdMqf4gElna4Y8qSnw7r9SuBjsN
 ogbPfsC4uoQE86BrOnPvbTCBtRZ5t2DCS7jKVFPvYS+X5qcJBThJ2CSSqacjjNdw2PWvii
 G+BHgtIrA4HT3J/AhgC8my7d7yOFMco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-tKHJKPntN_K-AIbQ6ebDnQ-1; Mon, 17 Aug 2020 12:17:30 -0400
X-MC-Unique: tKHJKPntN_K-AIbQ6ebDnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAB81801AB5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:17:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 301745F1E4;
 Mon, 17 Aug 2020 16:17:27 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:17:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 36/41] [automated] Use DECLARE_*CHECKER* macros
Message-ID: <20200817161725.GH4775@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-37-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-37-ehabkost@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 06:26:20PM -0400, Eduardo Habkost wrote:
>  $ ./scripts/codeconverter/converter.py -i \
>    --pattern=TypeCheckMacro $(git grep -l '' -- '*.[ch]')
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  chardev/chardev-internal.h               |  3 +-
>  hw/9pfs/virtio-9p.h                      |  4 +-
>  hw/audio/intel-hda.h                     | 11 ++--
>  hw/avr/atmega.h                          |  3 +-
>  hw/block/nvme.h                          |  4 +-
>  hw/display/ati_int.h                     |  3 +-
>  hw/display/qxl.h                         |  3 +-
>  hw/display/virtio-vga.h                  |  8 +--
>  hw/i386/amd_iommu.h                      |  4 +-
>  hw/misc/tmp105.h                         |  3 +-
>  hw/net/fsl_etsec/etsec.h                 |  4 +-
>  hw/net/tulip.h                           |  3 +-
>  hw/net/vmxnet3_defs.h                    |  3 +-
>  hw/ppc/e500-ccsr.h                       |  3 +-
>  hw/ppc/e500.h                            |  8 +--
>  hw/ppc/mac.h                             |  8 +--
>  hw/rdma/vmw/pvrdma.h                     |  3 +-
>  hw/s390x/ccw-device.h                    |  7 +--
>  hw/s390x/ipl.h                           |  3 +-
>  hw/s390x/s390-pci-bus.h                  | 16 +++---
>  hw/s390x/virtio-ccw.h                    | 68 +++++++++++-------------
>  hw/usb/ccid.h                            |  8 +--
>  hw/usb/hcd-dwc2.h                        |  8 +--
>  hw/usb/hcd-ehci.h                        | 15 +++---
>  hw/usb/hcd-ohci.h                        |  3 +-
>  hw/usb/hcd-xhci.h                        |  4 +-
>  hw/virtio/virtio-mem-pci.h               |  4 +-
>  hw/virtio/virtio-pci.h                   | 16 ++----
>  hw/virtio/virtio-pmem-pci.h              |  4 +-
>  hw/xen/xen_pt.h                          |  4 +-
>  include/authz/base.h                     | 11 +---
>  include/authz/list.h                     | 11 +---
>  include/authz/listfile.h                 | 11 +---
>  include/authz/pamacct.h                  | 11 +---
>  include/authz/simple.h                   | 11 +---
>  include/block/throttle-groups.h          |  3 +-
>  include/chardev/char-fd.h                |  3 +-
>  include/chardev/char-win.h               |  3 +-
>  include/chardev/spice.h                  |  3 +-
>  include/crypto/secret.h                  |  4 +-
>  include/crypto/secret_common.h           | 10 +---
>  include/crypto/secret_keyring.h          | 11 +---
>  include/crypto/tls-cipher-suites.h       |  4 +-
>  include/crypto/tlscreds.h                |  4 +-
>  include/crypto/tlscredsanon.h            |  4 +-
>  include/crypto/tlscredspsk.h             |  4 +-
>  include/crypto/tlscredsx509.h            |  4 +-
>  include/hw/acpi/acpi_dev_interface.h     |  8 +--
>  include/hw/acpi/generic_event_device.h   |  4 +-
>  include/hw/acpi/vmgenid.h                |  3 +-
>  include/hw/adc/stm32f2xx_adc.h           |  4 +-
>  include/hw/arm/allwinner-a10.h           |  3 +-
>  include/hw/arm/allwinner-h3.h            |  3 +-
>  include/hw/arm/armv7m.h                  |  6 ++-
>  include/hw/arm/aspeed.h                  |  8 +--
>  include/hw/arm/aspeed_soc.h              |  7 +--
>  include/hw/arm/bcm2835_peripherals.h     |  4 +-
>  include/hw/arm/bcm2836.h                 |  7 +--
>  include/hw/arm/digic.h                   |  3 +-
>  include/hw/arm/exynos4210.h              |  4 +-
>  include/hw/arm/fsl-imx25.h               |  3 +-
>  include/hw/arm/fsl-imx31.h               |  3 +-
>  include/hw/arm/fsl-imx6.h                |  3 +-
>  include/hw/arm/fsl-imx6ul.h              |  3 +-
>  include/hw/arm/fsl-imx7.h                |  3 +-
>  include/hw/arm/linux-boot-if.h           |  6 +--
>  include/hw/arm/msf2-soc.h                |  3 +-
>  include/hw/arm/nrf51_soc.h               |  4 +-
>  include/hw/arm/omap.h                    |  7 +--
>  include/hw/arm/smmu-common.h             |  7 +--
>  include/hw/arm/smmuv3.h                  |  7 +--
>  include/hw/arm/stm32f205_soc.h           |  4 +-
>  include/hw/arm/stm32f405_soc.h           |  4 +-
>  include/hw/arm/virt.h                    |  8 +--
>  include/hw/arm/xlnx-versal.h             |  3 +-
>  include/hw/arm/xlnx-zynqmp.h             |  4 +-
>  include/hw/block/flash.h                 |  8 +--
>  include/hw/block/swim.h                  |  6 ++-
>  include/hw/char/avr_usart.h              |  4 +-
>  include/hw/char/bcm2835_aux.h            |  3 +-
>  include/hw/char/cadence_uart.h           |  4 +-
>  include/hw/char/cmsdk-apb-uart.h         |  4 +-
>  include/hw/char/digic-uart.h             |  4 +-
>  include/hw/char/escc.h                   |  3 +-
>  include/hw/char/ibex_uart.h              |  4 +-
>  include/hw/char/imx_serial.h             |  3 +-
>  include/hw/char/nrf51_uart.h             |  3 +-
>  include/hw/char/pl011.h                  |  3 +-
>  include/hw/char/renesas_sci.h            |  3 +-
>  include/hw/char/serial.h                 |  9 ++--
>  include/hw/char/stm32f2xx_usart.h        |  4 +-
>  include/hw/clock.h                       |  3 +-
>  include/hw/core/cpu.h                    |  4 +-
>  include/hw/core/generic-loader.h         |  4 +-
>  include/hw/core/split-irq.h              |  3 +-
>  include/hw/cpu/a15mpcore.h               |  4 +-
>  include/hw/cpu/a9mpcore.h                |  4 +-
>  include/hw/cpu/arm11mpcore.h             |  4 +-
>  include/hw/cpu/cluster.h                 |  4 +-
>  include/hw/cpu/core.h                    |  4 +-
>  include/hw/display/bcm2835_fb.h          |  3 +-
>  include/hw/display/dpcd.h                |  3 +-
>  include/hw/display/i2c-ddc.h             |  3 +-
>  include/hw/display/macfb.h               |  4 +-
>  include/hw/display/xlnx_dp.h             |  3 +-
>  include/hw/dma/bcm2835_dma.h             |  4 +-
>  include/hw/dma/pl080.h                   |  3 +-
>  include/hw/dma/xlnx-zdma.h               |  4 +-
>  include/hw/dma/xlnx-zynq-devcfg.h        |  4 +-
>  include/hw/dma/xlnx_dpdma.h              |  3 +-
>  include/hw/fw-path-provider.h            |  6 +--
>  include/hw/gpio/aspeed_gpio.h            |  7 +--
>  include/hw/gpio/bcm2835_gpio.h           |  4 +-
>  include/hw/gpio/imx_gpio.h               |  3 +-
>  include/hw/gpio/nrf51_gpio.h             |  3 +-
>  include/hw/hotplug.h                     |  6 +--
>  include/hw/hyperv/vmbus-bridge.h         |  3 +-
>  include/hw/hyperv/vmbus.h                |  8 +--
>  include/hw/i2c/arm_sbcon_i2c.h           |  4 +-
>  include/hw/i2c/aspeed_i2c.h              |  8 +--
>  include/hw/i2c/i2c.h                     |  8 +--
>  include/hw/i2c/imx_i2c.h                 |  3 +-
>  include/hw/i2c/microbit_i2c.h            |  4 +-
>  include/hw/i2c/ppc4xx_i2c.h              |  3 +-
>  include/hw/i2c/smbus_slave.h             |  8 +--
>  include/hw/i386/apic_internal.h          |  8 +--
>  include/hw/i386/ich9.h                   |  4 +-
>  include/hw/i386/intel_iommu.h            |  4 +-
>  include/hw/i386/ioapic_internal.h        |  8 +--
>  include/hw/i386/microvm.h                |  8 +--
>  include/hw/i386/x86.h                    |  8 +--
>  include/hw/ide/internal.h                | 11 ++--
>  include/hw/ide/pci.h                     |  3 +-
>  include/hw/input/adb.h                   | 10 ++--
>  include/hw/intc/allwinner-a10-pic.h      |  3 +-
>  include/hw/intc/arm_gic_common.h         |  8 +--
>  include/hw/intc/arm_gicv3_common.h       |  8 +--
>  include/hw/intc/arm_gicv3_its_common.h   |  8 +--
>  include/hw/intc/armv7m_nvic.h            |  4 +-
>  include/hw/intc/aspeed_vic.h             |  3 +-
>  include/hw/intc/bcm2835_ic.h             |  3 +-
>  include/hw/intc/bcm2836_control.h        |  4 +-
>  include/hw/intc/heathrow_pic.h           |  3 +-
>  include/hw/intc/ibex_plic.h              |  4 +-
>  include/hw/intc/imx_avic.h               |  3 +-
>  include/hw/intc/imx_gpcv2.h              |  3 +-
>  include/hw/intc/intc.h                   |  6 +--
>  include/hw/intc/mips_gic.h               |  3 +-
>  include/hw/intc/realview_gic.h           |  4 +-
>  include/hw/intc/rx_icu.h                 |  3 +-
>  include/hw/intc/xlnx-pmu-iomod-intc.h    |  4 +-
>  include/hw/intc/xlnx-zynqmp-ipi.h        |  4 +-
>  include/hw/ipack/ipack.h                 | 11 ++--
>  include/hw/ipmi/ipmi.h                   | 18 +++----
>  include/hw/isa/i8259_internal.h          |  8 +--
>  include/hw/isa/isa.h                     |  6 +--
>  include/hw/isa/pc87312.h                 |  3 +-
>  include/hw/isa/superio.h                 |  8 +--
>  include/hw/m68k/mcf_fec.h                |  3 +-
>  include/hw/mem/memory-device.h           |  6 +--
>  include/hw/mem/nvdimm.h                  |  6 +--
>  include/hw/mem/pc-dimm.h                 |  8 +--
>  include/hw/mips/cps.h                    |  3 +-
>  include/hw/misc/a9scu.h                  |  3 +-
>  include/hw/misc/allwinner-cpucfg.h       |  4 +-
>  include/hw/misc/allwinner-h3-ccu.h       |  4 +-
>  include/hw/misc/allwinner-h3-dramc.h     |  4 +-
>  include/hw/misc/allwinner-h3-sysctrl.h   |  4 +-
>  include/hw/misc/allwinner-sid.h          |  4 +-
>  include/hw/misc/arm11scu.h               |  3 +-
>  include/hw/misc/armsse-cpuid.h           |  3 +-
>  include/hw/misc/armsse-mhu.h             |  3 +-
>  include/hw/misc/aspeed_scu.h             |  7 +--
>  include/hw/misc/aspeed_sdmc.h            |  7 +--
>  include/hw/misc/aspeed_xdma.h            |  3 +-
>  include/hw/misc/auxbus.h                 |  7 +--
>  include/hw/misc/avr_power.h              |  3 +-
>  include/hw/misc/bcm2835_mbox.h           |  4 +-
>  include/hw/misc/bcm2835_mphi.h           |  4 +-
>  include/hw/misc/bcm2835_property.h       |  4 +-
>  include/hw/misc/bcm2835_rng.h            |  4 +-
>  include/hw/misc/bcm2835_thermal.h        |  4 +-
>  include/hw/misc/grlib_ahb_apb_pnp.h      |  8 +--
>  include/hw/misc/imx25_ccm.h              |  3 +-
>  include/hw/misc/imx31_ccm.h              |  3 +-
>  include/hw/misc/imx6_ccm.h               |  3 +-
>  include/hw/misc/imx6_src.h               |  3 +-
>  include/hw/misc/imx6ul_ccm.h             |  3 +-
>  include/hw/misc/imx7_ccm.h               |  6 ++-
>  include/hw/misc/imx7_gpr.h               |  3 +-
>  include/hw/misc/imx7_snvs.h              |  3 +-
>  include/hw/misc/imx_rngc.h               |  3 +-
>  include/hw/misc/iotkit-secctl.h          |  3 +-
>  include/hw/misc/iotkit-sysctl.h          |  4 +-
>  include/hw/misc/iotkit-sysinfo.h         |  4 +-
>  include/hw/misc/mac_via.h                | 11 ++--
>  include/hw/misc/macio/cuda.h             |  7 +--
>  include/hw/misc/macio/gpio.h             |  3 +-
>  include/hw/misc/macio/macio.h            | 17 +++---
>  include/hw/misc/macio/pmu.h              |  7 +--
>  include/hw/misc/max111x.h                |  4 +-
>  include/hw/misc/mips_cmgcr.h             |  3 +-
>  include/hw/misc/mips_cpc.h               |  3 +-
>  include/hw/misc/mips_itu.h               |  3 +-
>  include/hw/misc/mps2-fpgaio.h            |  3 +-
>  include/hw/misc/mps2-scc.h               |  3 +-
>  include/hw/misc/msf2-sysreg.h            |  3 +-
>  include/hw/misc/nrf51_rng.h              |  3 +-
>  include/hw/misc/pca9552.h                |  3 +-
>  include/hw/misc/stm32f2xx_syscfg.h       |  4 +-
>  include/hw/misc/stm32f4xx_exti.h         |  4 +-
>  include/hw/misc/stm32f4xx_syscfg.h       |  4 +-
>  include/hw/misc/tz-mpc.h                 |  3 +-
>  include/hw/misc/tz-msc.h                 |  3 +-
>  include/hw/misc/tz-ppc.h                 |  3 +-
>  include/hw/misc/unimp.h                  |  4 +-
>  include/hw/misc/vmcoreinfo.h             |  3 +-
>  include/hw/misc/zynq-xadc.h              |  4 +-
>  include/hw/net/allwinner-sun8i-emac.h    |  4 +-
>  include/hw/net/allwinner_emac.h          |  3 +-
>  include/hw/net/cadence_gem.h             |  3 +-
>  include/hw/net/ftgmac100.h               |  6 ++-
>  include/hw/net/imx_fec.h                 |  3 +-
>  include/hw/net/lance.h                   |  4 +-
>  include/hw/net/lasi_82596.h              |  4 +-
>  include/hw/net/msf2-emac.h               |  4 +-
>  include/hw/nmi.h                         |  6 +--
>  include/hw/nubus/mac-nubus-bridge.h      |  4 +-
>  include/hw/nubus/nubus.h                 |  7 +--
>  include/hw/nvram/fw_cfg.h                |  6 +--
>  include/hw/nvram/nrf51_nvm.h             |  3 +-
>  include/hw/or-irq.h                      |  3 +-
>  include/hw/pci-bridge/simba.h            |  4 +-
>  include/hw/pci-host/designware.h         |  8 +--
>  include/hw/pci-host/gpex.h               |  8 +--
>  include/hw/pci-host/i440fx.h             |  4 +-
>  include/hw/pci-host/pnv_phb3.h           |  9 ++--
>  include/hw/pci-host/pnv_phb4.h           | 15 +++---
>  include/hw/pci-host/q35.h                |  8 +--
>  include/hw/pci-host/sabre.h              |  8 +--
>  include/hw/pci-host/spapr.h              |  4 +-
>  include/hw/pci-host/uninorth.h           | 20 +++----
>  include/hw/pci-host/xilinx-pcie.h        |  8 +--
>  include/hw/pci/pcie_port.h               |  6 +--
>  include/hw/pcmcia.h                      |  8 +--
>  include/hw/platform-bus.h                |  4 +-
>  include/hw/ppc/mac_dbdma.h               |  3 +-
>  include/hw/ppc/openpic.h                 |  3 +-
>  include/hw/ppc/pnv.h                     | 44 +++++++--------
>  include/hw/ppc/pnv_core.h                | 12 ++---
>  include/hw/ppc/pnv_homer.h               | 13 +++--
>  include/hw/ppc/pnv_lpc.h                 | 17 +++---
>  include/hw/ppc/pnv_occ.h                 | 13 +++--
>  include/hw/ppc/pnv_pnor.h                |  3 +-
>  include/hw/ppc/pnv_psi.h                 | 16 +++---
>  include/hw/ppc/pnv_xive.h                |  7 +--
>  include/hw/ppc/pnv_xscom.h               |  5 +-
>  include/hw/ppc/spapr.h                   |  8 +--
>  include/hw/ppc/spapr_cpu_core.h          |  8 +--
>  include/hw/ppc/spapr_drc.h               | 67 ++++++-----------------
>  include/hw/ppc/spapr_irq.h               |  6 +--
>  include/hw/ppc/spapr_tpm_proxy.h         |  4 +-
>  include/hw/ppc/spapr_vio.h               | 11 ++--
>  include/hw/ppc/spapr_xive.h              |  7 +--
>  include/hw/ppc/xics.h                    | 23 +++-----
>  include/hw/ppc/xive.h                    | 36 +++++--------
>  include/hw/register.h                    |  3 +-
>  include/hw/resettable.h                  |  6 +--
>  include/hw/riscv/opentitan.h             |  4 +-
>  include/hw/riscv/riscv_hart.h            |  4 +-
>  include/hw/riscv/sifive_clint.h          |  4 +-
>  include/hw/riscv/sifive_e.h              |  8 +--
>  include/hw/riscv/sifive_e_prci.h         |  4 +-
>  include/hw/riscv/sifive_gpio.h           |  3 +-
>  include/hw/riscv/sifive_plic.h           |  4 +-
>  include/hw/riscv/sifive_test.h           |  4 +-
>  include/hw/riscv/sifive_u.h              |  8 +--
>  include/hw/riscv/sifive_u_otp.h          |  4 +-
>  include/hw/riscv/sifive_u_prci.h         |  4 +-
>  include/hw/riscv/sifive_uart.h           |  4 +-
>  include/hw/riscv/virt.h                  |  4 +-
>  include/hw/rtc/allwinner-rtc.h           |  8 +--
>  include/hw/rtc/aspeed_rtc.h              |  3 +-
>  include/hw/rtc/goldfish_rtc.h            |  4 +-
>  include/hw/rtc/m48t59.h                  |  6 +--
>  include/hw/rtc/mc146818rtc.h             |  3 +-
>  include/hw/rtc/pl031.h                   |  3 +-
>  include/hw/rtc/xlnx-zynqmp-rtc.h         |  4 +-
>  include/hw/rx/rx62n.h                    |  3 +-
>  include/hw/s390x/3270-ccw.h              |  8 +--
>  include/hw/s390x/ap-device.h             |  4 +-
>  include/hw/s390x/css-bridge.h            |  8 +--
>  include/hw/s390x/event-facility.h        |  8 +--
>  include/hw/s390x/s390-ccw.h              |  8 +--
>  include/hw/s390x/s390_flic.h             | 16 +++---
>  include/hw/s390x/sclp.h                  |  5 +-
>  include/hw/s390x/storage-attributes.h    | 16 +++---
>  include/hw/s390x/storage-keys.h          | 12 ++---
>  include/hw/s390x/tod.h                   |  7 +--
>  include/hw/s390x/vfio-ccw.h              |  4 +-
>  include/hw/scsi/esp.h                    |  3 +-
>  include/hw/scsi/scsi.h                   | 11 ++--
>  include/hw/sd/allwinner-sdhost.h         |  8 +--
>  include/hw/sd/aspeed_sdhci.h             |  4 +-
>  include/hw/sd/bcm2835_sdhost.h           |  4 +-
>  include/hw/sd/sd.h                       | 12 ++---
>  include/hw/sd/sdhci.h                    |  7 +--
>  include/hw/sparc/sparc32_dma.h           | 16 +++---
>  include/hw/sparc/sun4m_iommu.h           |  3 +-
>  include/hw/sparc/sun4u_iommu.h           |  3 +-
>  include/hw/ssi/aspeed_smc.h              |  7 +--
>  include/hw/ssi/imx_spi.h                 |  3 +-
>  include/hw/ssi/mss-spi.h                 |  3 +-
>  include/hw/ssi/pl022.h                   |  3 +-
>  include/hw/ssi/ssi.h                     |  8 +--
>  include/hw/ssi/stm32f2xx_spi.h           |  4 +-
>  include/hw/ssi/xilinx_spips.h            | 20 +++----
>  include/hw/stream.h                      |  6 +--
>  include/hw/sysbus.h                      |  8 +--
>  include/hw/timer/a9gtimer.h              |  3 +-
>  include/hw/timer/allwinner-a10-pit.h     |  3 +-
>  include/hw/timer/arm_mptimer.h           |  4 +-
>  include/hw/timer/armv7m_systick.h        |  3 +-
>  include/hw/timer/aspeed_timer.h          |  8 +--
>  include/hw/timer/avr_timer16.h           |  4 +-
>  include/hw/timer/bcm2835_systmr.h        |  4 +-
>  include/hw/timer/cmsdk-apb-dualtimer.h   |  4 +-
>  include/hw/timer/cmsdk-apb-timer.h       |  4 +-
>  include/hw/timer/digic-timer.h           |  3 +-
>  include/hw/timer/i8254.h                 |  8 +--
>  include/hw/timer/imx_epit.h              |  3 +-
>  include/hw/timer/imx_gpt.h               |  3 +-
>  include/hw/timer/mss-timer.h             |  4 +-
>  include/hw/timer/nrf51_timer.h           |  3 +-
>  include/hw/timer/renesas_cmt.h           |  3 +-
>  include/hw/timer/renesas_tmr.h           |  3 +-
>  include/hw/timer/stm32f2xx_timer.h       |  4 +-
>  include/hw/usb.h                         | 11 ++--
>  include/hw/usb/chipidea.h                |  3 +-
>  include/hw/usb/imx-usb-phy.h             |  3 +-
>  include/hw/vfio/vfio-amd-xgbe.h          | 10 +---
>  include/hw/vfio/vfio-calxeda-xgmac.h     | 10 +---
>  include/hw/vfio/vfio-platform.h          |  8 +--
>  include/hw/virtio/vhost-scsi-common.h    |  4 +-
>  include/hw/virtio/vhost-scsi.h           |  4 +-
>  include/hw/virtio/vhost-user-blk.h       |  4 +-
>  include/hw/virtio/vhost-user-fs.h        |  4 +-
>  include/hw/virtio/vhost-user-scsi.h      |  4 +-
>  include/hw/virtio/vhost-user-vsock.h     |  4 +-
>  include/hw/virtio/vhost-vsock-common.h   |  4 +-
>  include/hw/virtio/vhost-vsock.h          |  4 +-
>  include/hw/virtio/virtio-balloon.h       |  4 +-
>  include/hw/virtio/virtio-blk.h           |  4 +-
>  include/hw/virtio/virtio-bus.h           |  7 +--
>  include/hw/virtio/virtio-crypto.h        |  4 +-
>  include/hw/virtio/virtio-gpu-pci.h       |  4 +-
>  include/hw/virtio/virtio-gpu.h           | 12 ++---
>  include/hw/virtio/virtio-input.h         | 20 +++----
>  include/hw/virtio/virtio-iommu.h         |  4 +-
>  include/hw/virtio/virtio-mem.h           |  8 +--
>  include/hw/virtio/virtio-mmio.h          |  4 +-
>  include/hw/virtio/virtio-net.h           |  4 +-
>  include/hw/virtio/virtio-pmem.h          |  8 +--
>  include/hw/virtio/virtio-rng.h           |  4 +-
>  include/hw/virtio/virtio-scsi.h          |  8 +--
>  include/hw/virtio/virtio-serial.h        | 12 ++---
>  include/hw/vmstate-if.h                  |  6 +--
>  include/hw/watchdog/cmsdk-apb-watchdog.h |  4 +-
>  include/hw/watchdog/wdt_aspeed.h         |  8 +--
>  include/hw/watchdog/wdt_diag288.h        |  8 +--
>  include/hw/watchdog/wdt_imx2.h           |  3 +-
>  include/hw/xen/xen-block.h               | 16 +++---
>  include/hw/xen/xen-bus.h                 | 16 ++----
>  include/io/channel-buffer.h              |  4 +-
>  include/io/channel-command.h             |  4 +-
>  include/io/channel-file.h                |  4 +-
>  include/io/channel-socket.h              |  4 +-
>  include/io/channel-tls.h                 |  4 +-
>  include/io/channel-websock.h             |  4 +-
>  include/io/channel.h                     |  8 +--
>  include/io/dns-resolver.h                |  8 +--
>  include/io/net-listener.h                |  8 +--
>  include/net/can_emu.h                    |  4 +-
>  include/net/can_host.h                   |  8 +--
>  include/qom/object_interfaces.h          |  8 +--
>  include/scsi/pr-manager.h                |  8 +--
>  include/sysemu/accel.h                   |  8 +--
>  include/sysemu/cryptodev.h               | 11 +---
>  include/sysemu/hostmem.h                 |  8 +--
>  include/sysemu/hvf.h                     |  4 +-
>  include/sysemu/iothread.h                |  4 +-
>  include/sysemu/rng-random.h              |  3 +-
>  include/sysemu/rng.h                     |  8 +--
>  include/sysemu/tpm.h                     |  6 +--
>  include/sysemu/tpm_backend.h             |  8 +--
>  include/sysemu/vhost-user-backend.h      |  8 +--
>  target/alpha/cpu-qom.h                   |  8 +--
>  target/arm/cpu-qom.h                     |  8 +--
>  target/arm/idau.h                        |  6 +--
>  target/avr/cpu-qom.h                     |  8 +--
>  target/cris/cpu-qom.h                    |  8 +--
>  target/hppa/cpu-qom.h                    |  8 +--
>  target/i386/cpu-qom.h                    |  8 +--
>  target/lm32/cpu-qom.h                    |  8 +--
>  target/m68k/cpu-qom.h                    |  8 +--
>  target/microblaze/cpu-qom.h              |  8 +--
>  target/mips/cpu-qom.h                    |  8 +--
>  target/moxie/cpu.h                       |  8 +--
>  target/nios2/cpu.h                       |  8 +--
>  target/openrisc/cpu.h                    |  8 +--
>  target/ppc/cpu-qom.h                     |  8 +--
>  target/ppc/cpu.h                         | 10 +---
>  target/riscv/cpu.h                       |  8 +--
>  target/s390x/cpu-qom.h                   |  8 +--
>  target/sh4/cpu-qom.h                     |  8 +--
>  target/sparc/cpu-qom.h                   |  8 +--
>  target/tilegx/cpu.h                      |  8 +--
>  target/tricore/cpu-qom.h                 |  8 +--
>  target/unicore32/cpu-qom.h               |  8 +--
>  target/xtensa/cpu-qom.h                  |  8 +--
>  accel/tcg/tcg-all.c                      |  4 +-
>  backends/cryptodev-builtin.c             |  5 +-
>  backends/cryptodev-vhost-user.c          |  5 +-
>  backends/dbus-vmstate.c                  |  8 +--
>  backends/hostmem-file.c                  |  4 +-
>  backends/hostmem-memfd.c                 |  4 +-
>  backends/rng-builtin.c                   |  3 +-
>  backends/rng-egd.c                       |  3 +-
>  backends/tpm/tpm_emulator.c              |  4 +-
>  backends/tpm/tpm_passthrough.c           |  4 +-
>  chardev/baum.c                           |  3 +-
>  chardev/char-parallel.c                  |  6 +--
>  chardev/char-pty.c                       |  3 +-
>  chardev/char-ringbuf.c                   |  4 +-
>  chardev/char-socket.c                    |  4 +-
>  chardev/char-udp.c                       |  3 +-
>  chardev/char-win-stdio.c                 |  4 +-
>  chardev/msmouse.c                        |  4 +-
>  chardev/testdev.c                        |  4 +-
>  chardev/wctablet.c                       |  4 +-
>  hw/acpi/piix4.c                          |  4 +-
>  hw/alpha/typhoon.c                       |  4 +-
>  hw/arm/collie.c                          |  4 +-
>  hw/arm/highbank.c                        |  4 +-
>  hw/arm/integratorcp.c                    | 12 ++---
>  hw/arm/microbit.c                        |  4 +-
>  hw/arm/mps2-tz.c                         |  8 +--
>  hw/arm/mps2.c                            |  8 +--
>  hw/arm/musca.c                           |  8 +--
>  hw/arm/musicpal.c                        | 32 +++++------
>  hw/arm/palm.c                            |  4 +-
>  hw/arm/pxa2xx.c                          | 12 ++---
>  hw/arm/pxa2xx_gpio.c                     |  4 +-
>  hw/arm/pxa2xx_pic.c                      |  4 +-
>  hw/arm/raspi.c                           |  8 +--
>  hw/arm/sbsa-ref.c                        |  4 +-
>  hw/arm/spitz.c                           | 25 +++++----
>  hw/arm/stellaris.c                       | 12 ++---
>  hw/arm/strongarm.c                       | 24 ++++-----
>  hw/arm/tosa.c                            |  7 +--
>  hw/arm/versatilepb.c                     |  4 +-
>  hw/arm/vexpress.c                        |  8 +--
>  hw/arm/xilinx_zynq.c                     |  4 +-
>  hw/arm/xlnx-versal-virt.c                |  4 +-
>  hw/arm/xlnx-zcu102.c                     |  4 +-
>  hw/arm/z2.c                              |  6 ++-
>  hw/audio/ac97.c                          |  4 +-
>  hw/audio/adlib.c                         |  3 +-
>  hw/audio/cs4231.c                        |  4 +-
>  hw/audio/cs4231a.c                       |  3 +-
>  hw/audio/es1370.c                        |  4 +-
>  hw/audio/gus.c                           |  3 +-
>  hw/audio/hda-codec.c                     |  3 +-
>  hw/audio/intel-hda.c                     |  4 +-
>  hw/audio/marvell_88w8618.c               |  4 +-
>  hw/audio/milkymist-ac97.c                |  4 +-
>  hw/audio/pcspk.c                         |  3 +-
>  hw/audio/pl041.c                         |  3 +-
>  hw/audio/sb16.c                          |  3 +-
>  hw/audio/wm8750.c                        |  3 +-
>  hw/avr/arduino.c                         |  8 +--
>  hw/avr/atmega.c                          |  6 +--
>  hw/block/fdc.c                           | 13 +++--
>  hw/block/m25p80.c                        |  8 +--
>  hw/block/nand.c                          |  4 +-
>  hw/block/onenand.c                       |  3 +-
>  hw/char/debugcon.c                       |  4 +-
>  hw/char/etraxfs_ser.c                    |  4 +-
>  hw/char/exynos4210_uart.c                |  4 +-
>  hw/char/grlib_apbuart.c                  |  4 +-
>  hw/char/ipoctal232.c                     |  4 +-
>  hw/char/lm32_juart.c                     |  3 +-
>  hw/char/lm32_uart.c                      |  3 +-
>  hw/char/mcf_uart.c                       |  3 +-
>  hw/char/milkymist-uart.c                 |  4 +-
>  hw/char/parallel.c                       |  4 +-
>  hw/char/sclpconsole-lm.c                 |  4 +-
>  hw/char/sclpconsole.c                    |  4 +-
>  hw/char/serial-isa.c                     |  3 +-
>  hw/char/serial-pci.c                     |  3 +-
>  hw/char/spapr_vty.c                      |  4 +-
>  hw/char/terminal3270.c                   |  4 +-
>  hw/char/virtio-console.c                 |  4 +-
>  hw/char/xilinx_uartlite.c                |  4 +-
>  hw/cpu/realview_mpcore.c                 |  4 +-
>  hw/display/ads7846.c                     |  3 +-
>  hw/display/artist.c                      |  3 +-
>  hw/display/bochs-display.c               |  4 +-
>  hw/display/cg3.c                         |  3 +-
>  hw/display/cirrus_vga.c                  |  4 +-
>  hw/display/cirrus_vga_isa.c              |  4 +-
>  hw/display/exynos4210_fimd.c             |  4 +-
>  hw/display/g364fb.c                      |  3 +-
>  hw/display/jazz_led.c                    |  3 +-
>  hw/display/milkymist-tmu2.c              |  4 +-
>  hw/display/milkymist-vgafb.c             |  4 +-
>  hw/display/next-fb.c                     |  3 +-
>  hw/display/pl110.c                       |  3 +-
>  hw/display/ramfb-standalone.c            |  3 +-
>  hw/display/sii9022.c                     |  3 +-
>  hw/display/sm501.c                       |  7 +--
>  hw/display/ssd0303.c                     |  3 +-
>  hw/display/ssd0323.c                     |  3 +-
>  hw/display/tcx.c                         |  3 +-
>  hw/display/vga-isa.c                     |  3 +-
>  hw/display/vga-pci.c                     |  3 +-
>  hw/display/vhost-user-gpu-pci.c          |  4 +-
>  hw/display/vhost-user-vga.c              |  4 +-
>  hw/display/virtio-gpu-pci.c              |  4 +-
>  hw/display/virtio-vga.c                  |  4 +-
>  hw/dma/i82374.c                          |  3 +-
>  hw/dma/pl330.c                           |  3 +-
>  hw/dma/puv3_dma.c                        |  3 +-
>  hw/dma/pxa2xx_dma.c                      |  3 +-
>  hw/dma/rc4030.c                          |  4 +-
>  hw/dma/xilinx_axidma.c                   | 14 +++--
>  hw/gpio/gpio_key.c                       |  3 +-
>  hw/gpio/max7310.c                        |  3 +-
>  hw/gpio/mpc8xxx.c                        |  3 +-
>  hw/gpio/pl061.c                          |  3 +-
>  hw/gpio/puv3_gpio.c                      |  3 +-
>  hw/gpio/zaurus.c                         |  3 +-
>  hw/hppa/dino.c                           |  4 +-
>  hw/hppa/lasi.c                           |  4 +-
>  hw/hyperv/hyperv.c                       |  3 +-
>  hw/hyperv/hyperv_testdev.c               |  4 +-
>  hw/i2c/bitbang_i2c.c                     |  3 +-
>  hw/i2c/exynos4210_i2c.c                  |  4 +-
>  hw/i2c/mpc_i2c.c                         |  4 +-
>  hw/i2c/smbus_eeprom.c                    |  4 +-
>  hw/i2c/smbus_ich9.c                      |  4 +-
>  hw/i2c/versatile_i2c.c                   |  4 +-
>  hw/i386/kvm/clock.c                      |  3 +-
>  hw/i386/kvm/i8254.c                      |  7 +--
>  hw/i386/kvm/i8259.c                      |  6 +--
>  hw/i386/kvmvapic.c                       |  3 +-
>  hw/i386/port92.c                         |  3 +-
>  hw/i386/vmmouse.c                        |  3 +-
>  hw/i386/vmport.c                         |  3 +-
>  hw/i386/xen/xen_platform.c               |  4 +-
>  hw/i386/xen/xen_pvdevice.c               |  4 +-
>  hw/ide/isa.c                             |  3 +-
>  hw/ide/microdrive.c                      |  3 +-
>  hw/ide/mmio.c                            |  3 +-
>  hw/ide/sii3112.c                         |  2 +-
>  hw/input/adb-kbd.c                       |  7 +--
>  hw/input/adb-mouse.c                     |  7 +--
>  hw/input/lm832x.c                        |  3 +-
>  hw/input/milkymist-softusb.c             |  4 +-
>  hw/input/pl050.c                         |  3 +-
>  hw/intc/arm_gicv2m.c                     |  3 +-
>  hw/intc/exynos4210_combiner.c            |  4 +-
>  hw/intc/exynos4210_gic.c                 |  8 +--
>  hw/intc/grlib_irqmp.c                    |  3 +-
>  hw/intc/i8259.c                          |  4 +-
>  hw/intc/lm32_pic.c                       |  3 +-
>  hw/intc/nios2_iic.c                      |  4 +-
>  hw/intc/ompic.c                          |  3 +-
>  hw/intc/openpic_kvm.c                    |  4 +-
>  hw/intc/pl190.c                          |  3 +-
>  hw/intc/puv3_intc.c                      |  3 +-
>  hw/intc/s390_flic_kvm.c                  |  6 +--
>  hw/intc/slavio_intctl.c                  |  4 +-
>  hw/ipack/tpci200.c                       |  4 +-
>  hw/ipmi/ipmi_bmc_extern.c                |  4 +-
>  hw/ipmi/isa_ipmi_bt.c                    |  4 +-
>  hw/ipmi/isa_ipmi_kcs.c                   |  4 +-
>  hw/ipmi/pci_ipmi_bt.c                    |  4 +-
>  hw/ipmi/pci_ipmi_kcs.c                   |  4 +-
>  hw/ipmi/smbus_ipmi.c                     |  3 +-
>  hw/isa/i82378.c                          |  4 +-
>  hw/isa/piix4.c                           |  4 +-
>  hw/isa/vt82c686.c                        | 16 +++---
>  hw/m68k/mcf_intc.c                       |  3 +-
>  hw/m68k/next-cube.c                      |  3 +-
>  hw/m68k/next-kbd.c                       |  3 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c          |  4 +-
>  hw/mips/boston.c                         |  3 +-
>  hw/mips/gt64xxx_pci.c                    |  4 +-
>  hw/mips/malta.c                          |  3 +-
>  hw/misc/applesmc.c                       |  3 +-
>  hw/misc/arm_integrator_debug.c           |  4 +-
>  hw/misc/arm_l2x0.c                       |  3 +-
>  hw/misc/arm_sysctl.c                     |  4 +-
>  hw/misc/debugexit.c                      |  4 +-
>  hw/misc/eccmemctl.c                      |  3 +-
>  hw/misc/edu.c                            |  3 +-
>  hw/misc/empty_slot.c                     |  3 +-
>  hw/misc/exynos4210_clk.c                 |  4 +-
>  hw/misc/exynos4210_pmu.c                 |  4 +-
>  hw/misc/exynos4210_rng.c                 |  4 +-
>  hw/misc/ivshmem.c                        | 16 +++---
>  hw/misc/milkymist-hpdmc.c                |  4 +-
>  hw/misc/milkymist-pfpu.c                 |  4 +-
>  hw/misc/mst_fpga.c                       |  4 +-
>  hw/misc/pc-testdev.c                     |  4 +-
>  hw/misc/pca9552.c                        |  6 +--
>  hw/misc/pci-testdev.c                    |  4 +-
>  hw/misc/puv3_pm.c                        |  3 +-
>  hw/misc/pvpanic.c                        |  4 +-
>  hw/misc/sga.c                            |  3 +-
>  hw/misc/slavio_misc.c                    |  6 ++-
>  hw/misc/tmp421.c                         |  7 +--
>  hw/misc/zynq_slcr.c                      |  3 +-
>  hw/net/can/can_kvaser_pci.c              |  4 +-
>  hw/net/can/can_mioe3680_pci.c            |  4 +-
>  hw/net/can/can_pcm3680_pci.c             |  4 +-
>  hw/net/dp8393x.c                         |  3 +-
>  hw/net/e1000.c                           |  8 +--
>  hw/net/e1000e.c                          |  3 +-
>  hw/net/etraxfs_eth.c                     |  4 +-
>  hw/net/lan9118.c                         |  3 +-
>  hw/net/milkymist-minimac2.c              |  4 +-
>  hw/net/mipsnet.c                         |  3 +-
>  hw/net/ne2000-isa.c                      |  3 +-
>  hw/net/opencores_eth.c                   |  3 +-
>  hw/net/pcnet-pci.c                       |  4 +-
>  hw/net/rtl8139.c                         |  4 +-
>  hw/net/smc91c111.c                       |  3 +-
>  hw/net/spapr_llan.c                      |  4 +-
>  hw/net/stellaris_enet.c                  |  4 +-
>  hw/net/sungem.c                          |  3 +-
>  hw/net/sunhme.c                          |  3 +-
>  hw/net/vmxnet3.c                         |  6 +--
>  hw/net/xgmac.c                           |  3 +-
>  hw/net/xilinx_axienet.c                  | 14 +++--
>  hw/nvram/ds1225y.c                       |  3 +-
>  hw/nvram/eeprom_at24c.c                  |  3 +-
>  hw/nvram/spapr_nvram.c                   |  4 +-
>  hw/pci-bridge/dec.c                      |  3 +-
>  hw/pci-bridge/gen_pcie_root_port.c       |  4 +-
>  hw/pci-bridge/pci_bridge_dev.c           |  4 +-
>  hw/pci-bridge/pci_expander_bridge.c      | 12 +++--
>  hw/pci-bridge/pcie_pci_bridge.c          |  4 +-
>  hw/pci-host/bonito.c                     |  8 +--
>  hw/pci-host/grackle.c                    |  4 +-
>  hw/pci-host/i440fx.c                     |  4 +-
>  hw/pci-host/ppce500.c                    |  8 +--
>  hw/pci-host/prep.c                       |  8 +--
>  hw/pci-host/versatile.c                  |  4 +-
>  hw/ppc/mpc8544_guts.c                    |  3 +-
>  hw/ppc/ppc440_pcix.c                     |  4 +-
>  hw/ppc/ppc440_uc.c                       |  4 +-
>  hw/ppc/ppc4xx_pci.c                      |  4 +-
>  hw/ppc/ppce500_spin.c                    |  3 +-
>  hw/ppc/prep_systemio.c                   |  4 +-
>  hw/ppc/rs6000_mc.c                       |  4 +-
>  hw/ppc/spapr_rng.c                       |  4 +-
>  hw/rtc/ds1338.c                          |  3 +-
>  hw/rtc/exynos4210_rtc.c                  |  4 +-
>  hw/rtc/m41t80.c                          |  3 +-
>  hw/rtc/m48t59-isa.c                      |  8 +--
>  hw/rtc/m48t59.c                          |  8 +--
>  hw/rtc/sun4v-rtc.c                       |  3 +-
>  hw/rtc/twl92230.c                        |  3 +-
>  hw/rx/rx-gdbsim.c                        |  8 +--
>  hw/rx/rx62n.c                            |  6 +--
>  hw/scsi/esp-pci.c                        |  8 +--
>  hw/scsi/lsi53c895a.c                     |  4 +-
>  hw/scsi/megasas.c                        |  8 +--
>  hw/scsi/scsi-disk.c                      |  8 +--
>  hw/scsi/spapr_vscsi.c                    |  4 +-
>  hw/scsi/vmw_pvscsi.c                     |  7 +--
>  hw/sd/milkymist-memcard.c                |  4 +-
>  hw/sd/pl181.c                            |  3 +-
>  hw/sd/ssi-sd.c                           |  3 +-
>  hw/sh4/sh_pci.c                          |  4 +-
>  hw/sparc/sun4m.c                         | 13 +++--
>  hw/sparc64/sun4u.c                       | 12 +++--
>  hw/ssi/xilinx_spi.c                      |  3 +-
>  hw/timer/altera_timer.c                  |  4 +-
>  hw/timer/arm_timer.c                     |  7 +--
>  hw/timer/cadence_ttc.c                   |  4 +-
>  hw/timer/etraxfs_timer.c                 |  4 +-
>  hw/timer/exynos4210_mct.c                |  4 +-
>  hw/timer/exynos4210_pwm.c                |  4 +-
>  hw/timer/grlib_gptimer.c                 |  4 +-
>  hw/timer/hpet.c                          |  3 +-
>  hw/timer/i8254.c                         |  4 +-
>  hw/timer/lm32_timer.c                    |  3 +-
>  hw/timer/milkymist-sysctl.c              |  4 +-
>  hw/timer/puv3_ost.c                      |  3 +-
>  hw/timer/pxa2xx_timer.c                  |  4 +-
>  hw/timer/slavio_timer.c                  |  4 +-
>  hw/tpm/tpm_crb.c                         |  3 +-
>  hw/tpm/tpm_spapr.c                       |  4 +-
>  hw/tpm/tpm_tis_isa.c                     |  3 +-
>  hw/tpm/tpm_tis_sysbus.c                  |  3 +-
>  hw/usb/ccid-card-emulated.c              |  4 +-
>  hw/usb/ccid-card-passthru.c              |  4 +-
>  hw/usb/dev-audio.c                       |  3 +-
>  hw/usb/dev-hid.c                         |  3 +-
>  hw/usb/dev-hub.c                         |  3 +-
>  hw/usb/dev-mtp.c                         |  3 +-
>  hw/usb/dev-network.c                     |  3 +-
>  hw/usb/dev-serial.c                      |  3 +-
>  hw/usb/dev-smartcard-reader.c            |  6 ++-
>  hw/usb/dev-storage.c                     |  3 +-
>  hw/usb/dev-uas.c                         |  3 +-
>  hw/usb/dev-wacom.c                       |  3 +-
>  hw/usb/hcd-ohci-pci.c                    |  3 +-
>  hw/usb/hcd-uhci.c                        |  3 +-
>  hw/usb/host-libusb.c                     |  4 +-
>  hw/usb/redirect.c                        |  3 +-
>  hw/usb/tusb6010.c                        |  3 +-
>  hw/vfio/ap.c                             |  4 +-
>  hw/virtio/vhost-scsi-pci.c               |  4 +-
>  hw/virtio/vhost-user-blk-pci.c           |  4 +-
>  hw/virtio/vhost-user-fs-pci.c            |  4 +-
>  hw/virtio/vhost-user-input-pci.c         |  4 +-
>  hw/virtio/vhost-user-scsi-pci.c          |  4 +-
>  hw/virtio/vhost-user-vsock-pci.c         |  4 +-
>  hw/virtio/vhost-vsock-pci.c              |  4 +-
>  hw/virtio/virtio-9p-pci.c                |  4 +-
>  hw/virtio/virtio-balloon-pci.c           |  4 +-
>  hw/virtio/virtio-blk-pci.c               |  4 +-
>  hw/virtio/virtio-crypto-pci.c            |  4 +-
>  hw/virtio/virtio-input-host-pci.c        |  4 +-
>  hw/virtio/virtio-input-pci.c             |  8 +--
>  hw/virtio/virtio-iommu-pci.c             |  4 +-
>  hw/virtio/virtio-net-pci.c               |  4 +-
>  hw/virtio/virtio-rng-pci.c               |  4 +-
>  hw/virtio/virtio-scsi-pci.c              |  4 +-
>  hw/virtio/virtio-serial-pci.c            |  4 +-
>  hw/watchdog/wdt_i6300esb.c               |  4 +-
>  hw/watchdog/wdt_ib700.c                  |  3 +-
>  iothread.c                               |  6 +--
>  migration/rdma.c                         |  4 +-
>  net/can/can_socketcan.c                  |  4 +-
>  net/colo-compare.c                       |  4 +-
>  net/dump.c                               |  4 +-
>  net/filter-buffer.c                      |  4 +-
>  net/filter-mirror.c                      |  8 +--
>  net/filter-replay.c                      |  4 +-
>  net/filter-rewriter.c                    |  4 +-
>  scsi/pr-manager-helper.c                 |  5 +-
>  target/i386/sev.c                        |  4 +-
>  tests/check-qom-interface.c              |  6 +--
>  tests/check-qom-proplist.c               | 16 +++---
>  tests/test-qdev-global-props.c           |  8 +--
>  ui/console.c                             |  3 +-
>  ui/gtk.c                                 |  3 +-
>  ui/input-barrier.c                       |  8 +--
>  ui/input-linux.c                         |  8 +--
>  ui/spice-app.c                           |  3 +-
>  765 files changed, 1896 insertions(+), 2307 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


