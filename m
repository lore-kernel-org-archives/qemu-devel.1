Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C623C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05A622D00
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTN56nF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A622D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hpR-0007lO-NX
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hoP-0005yJ-J3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:16:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hoL-0004n8-1d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597680996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXLlAJ5h9PWH7cMbdihgZrg/i2EKt7RUYodaxTBVjhM=;
 b=DTN56nF0Mf8MZXe+6dFzv8hXJgoIAvOOVujS34xvfJDU+eXTmgdYEhgFQt3QPtdcjGJ+E6
 /3NRK0Zg0e3M3RTrFXiSrzcGLWARwO0B76LTwL0bjeWEwfGBpdDJNWL0EMSryiYqnfXt0E
 wJ81sVZGz/AON5XWoazsEiMOQ5K3UOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-66uKBz19NWSie5MpVcfnXQ-1; Mon, 17 Aug 2020 12:16:33 -0400
X-MC-Unique: 66uKBz19NWSie5MpVcfnXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C08410059A7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:16:31 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0921B1002391;
 Mon, 17 Aug 2020 16:16:29 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:16:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 35/41] [automated] Move QOM typedefs and add missing
 includes
Message-ID: <20200817161626.GG4775@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-36-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-36-ehabkost@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Thu, Aug 13, 2020 at 06:26:19PM -0400, Eduardo Habkost wrote:
> Some typedefs and macros are defined after the type check macros.
> This makes it difficult to automatically replace their
> definitions with OBJECT_DECLARE_TYPE.
> 
> Patch generated using:
> 
>  $ ./scripts/codeconverter/converter.py -i \
>    --pattern=QOMStructTypedefSplit $(git grep -l '' -- '*.[ch]')
> 
> which will split "typdef struct { ... } TypedefName"
> declarations.
> 
> Followed by:
> 
>  $ ./scripts/codeconverter/converter.py -i --pattern=MoveSymbols \
>     $(git grep -l '' -- '*.[ch]')
> 
> which will:
> - move the typedefs and #defines above the type check macros
> - add missing #include "qom/object.h" lines if necessary
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  chardev/chardev-internal.h               |  5 +-
>  hw/9pfs/virtio-9p.h                      |  7 ++-
>  hw/audio/intel-hda.h                     | 11 ++--
>  hw/avr/atmega.h                          |  6 +-
>  hw/block/nvme.h                          |  6 +-
>  hw/display/ati_int.h                     |  6 +-
>  hw/display/qxl.h                         |  6 +-
>  hw/display/virtio-vga.h                  | 11 ++--
>  hw/i386/amd_iommu.h                      |  6 +-
>  hw/ide/ahci_internal.h                   |  1 +
>  hw/misc/tmp105.h                         |  6 +-
>  hw/net/fsl_etsec/etsec.h                 |  6 +-
>  hw/net/tulip.h                           |  1 +
>  hw/net/vmxnet3_defs.h                    |  6 +-
>  hw/ppc/e500-ccsr.h                       |  6 +-
>  hw/ppc/e500.h                            | 11 ++--
>  hw/ppc/mac.h                             | 11 ++--
>  hw/rdma/vmw/pvrdma.h                     |  6 +-
>  hw/s390x/ccw-device.h                    | 10 ++--
>  hw/s390x/ipl.h                           |  3 +-
>  hw/s390x/s390-pci-bus.h                  | 18 +++---
>  hw/s390x/virtio-ccw.h                    | 73 ++++++++++++++----------
>  hw/usb/ccid.h                            |  6 +-
>  hw/usb/hcd-dwc2.h                        |  1 +
>  hw/usb/hcd-ehci.h                        | 21 ++++---
>  hw/usb/hcd-ohci.h                        |  6 +-
>  hw/usb/hcd-xhci.h                        |  3 +-
>  hw/virtio/virtio-mem-pci.h               |  1 +
>  hw/virtio/virtio-pci.h                   |  6 +-
>  hw/virtio/virtio-pmem-pci.h              |  1 +
>  hw/xen/xen_pt.h                          |  1 +
>  include/authz/base.h                     |  4 +-
>  include/authz/list.h                     |  5 +-
>  include/authz/listfile.h                 |  5 +-
>  include/authz/pamacct.h                  |  5 +-
>  include/authz/simple.h                   |  5 +-
>  include/block/throttle-groups.h          |  1 +
>  include/chardev/char-fd.h                |  6 +-
>  include/chardev/char-win.h               |  6 +-
>  include/chardev/char.h                   |  5 +-
>  include/chardev/spice.h                  |  6 +-
>  include/crypto/secret.h                  |  2 +-
>  include/crypto/secret_common.h           |  4 +-
>  include/crypto/secret_keyring.h          |  4 +-
>  include/crypto/tls-cipher-suites.h       |  5 +-
>  include/crypto/tlscreds.h                |  2 +-
>  include/crypto/tlscredsanon.h            |  3 +-
>  include/crypto/tlscredspsk.h             |  3 +-
>  include/crypto/tlscredsx509.h            |  3 +-
>  include/exec/memory.h                    |  5 +-
>  include/hw/acpi/acpi_dev_interface.h     |  5 +-
>  include/hw/acpi/generic_event_device.h   |  6 +-
>  include/hw/acpi/vmgenid.h                |  6 +-
>  include/hw/adc/stm32f2xx_adc.h           |  6 +-
>  include/hw/arm/allwinner-a10.h           |  6 +-
>  include/hw/arm/allwinner-h3.h            |  5 +-
>  include/hw/arm/armsse.h                  | 11 ++--
>  include/hw/arm/armv7m.h                  | 11 ++--
>  include/hw/arm/aspeed.h                  |  6 +-
>  include/hw/arm/aspeed_soc.h              | 11 ++--
>  include/hw/arm/bcm2835_peripherals.h     |  6 +-
>  include/hw/arm/bcm2836.h                 | 11 ++--
>  include/hw/arm/digic.h                   |  6 +-
>  include/hw/arm/exynos4210.h              |  6 +-
>  include/hw/arm/fsl-imx25.h               |  6 +-
>  include/hw/arm/fsl-imx31.h               |  6 +-
>  include/hw/arm/fsl-imx6.h                |  6 +-
>  include/hw/arm/fsl-imx6ul.h              |  6 +-
>  include/hw/arm/fsl-imx7.h                |  6 +-
>  include/hw/arm/linux-boot-if.h           |  5 +-
>  include/hw/arm/msf2-soc.h                |  6 +-
>  include/hw/arm/nrf51_soc.h               |  6 +-
>  include/hw/arm/omap.h                    |  5 +-
>  include/hw/arm/smmu-common.h             | 11 ++--
>  include/hw/arm/smmuv3.h                  | 11 ++--
>  include/hw/arm/stm32f205_soc.h           |  6 +-
>  include/hw/arm/stm32f405_soc.h           |  6 +-
>  include/hw/arm/virt.h                    | 11 ++--
>  include/hw/arm/xlnx-versal.h             |  6 +-
>  include/hw/arm/xlnx-zynqmp.h             |  6 +-
>  include/hw/block/flash.h                 |  5 +-
>  include/hw/block/swim.h                  |  6 +-
>  include/hw/char/avr_usart.h              |  6 +-
>  include/hw/char/bcm2835_aux.h            |  6 +-
>  include/hw/char/cadence_uart.h           |  6 +-
>  include/hw/char/cmsdk-apb-uart.h         |  6 +-
>  include/hw/char/digic-uart.h             |  6 +-
>  include/hw/char/escc.h                   |  6 +-
>  include/hw/char/ibex_uart.h              |  6 +-
>  include/hw/char/imx_serial.h             |  6 +-
>  include/hw/char/nrf51_uart.h             |  6 +-
>  include/hw/char/pl011.h                  |  6 +-
>  include/hw/char/renesas_sci.h            |  6 +-
>  include/hw/char/serial.h                 | 16 ++++--
>  include/hw/char/stm32f2xx_usart.h        |  6 +-
>  include/hw/clock.h                       |  2 +-
>  include/hw/core/cpu.h                    |  6 +-
>  include/hw/core/generic-loader.h         |  6 +-
>  include/hw/cpu/a15mpcore.h               |  6 +-
>  include/hw/cpu/a9mpcore.h                |  6 +-
>  include/hw/cpu/arm11mpcore.h             |  6 +-
>  include/hw/cpu/cluster.h                 |  6 +-
>  include/hw/cpu/core.h                    |  6 +-
>  include/hw/display/bcm2835_fb.h          |  6 +-
>  include/hw/display/dpcd.h                |  1 +
>  include/hw/display/i2c-ddc.h             |  1 +
>  include/hw/display/macfb.h               | 18 +++---
>  include/hw/display/xlnx_dp.h             |  6 +-
>  include/hw/dma/bcm2835_dma.h             |  6 +-
>  include/hw/dma/pl080.h                   |  6 +-
>  include/hw/dma/xlnx-zdma.h               |  6 +-
>  include/hw/dma/xlnx-zynq-devcfg.h        |  6 +-
>  include/hw/dma/xlnx_dpdma.h              |  1 +
>  include/hw/fw-path-provider.h            |  5 +-
>  include/hw/gpio/aspeed_gpio.h            | 11 ++--
>  include/hw/gpio/bcm2835_gpio.h           |  6 +-
>  include/hw/gpio/imx_gpio.h               |  6 +-
>  include/hw/gpio/nrf51_gpio.h             |  6 +-
>  include/hw/hotplug.h                     |  5 +-
>  include/hw/hyperv/vmbus-bridge.h         |  6 +-
>  include/hw/hyperv/vmbus.h                |  8 ++-
>  include/hw/i2c/arm_sbcon_i2c.h           |  6 +-
>  include/hw/i2c/aspeed_i2c.h              | 11 ++--
>  include/hw/i2c/i2c.h                     |  6 +-
>  include/hw/i2c/imx_i2c.h                 |  6 +-
>  include/hw/i2c/microbit_i2c.h            |  6 +-
>  include/hw/i2c/ppc4xx_i2c.h              |  6 +-
>  include/hw/i2c/smbus_slave.h             |  9 +--
>  include/hw/i386/apic_internal.h          |  7 ++-
>  include/hw/i386/ich9.h                   |  6 +-
>  include/hw/i386/intel_iommu.h            |  3 +-
>  include/hw/i386/ioapic_internal.h        |  6 +-
>  include/hw/i386/microvm.h                | 11 ++--
>  include/hw/i386/pc.h                     |  6 +-
>  include/hw/i386/x86-iommu.h              |  5 +-
>  include/hw/i386/x86.h                    | 11 ++--
>  include/hw/ide/internal.h                |  6 +-
>  include/hw/ide/pci.h                     |  6 +-
>  include/hw/input/adb.h                   |  6 +-
>  include/hw/intc/allwinner-a10-pic.h      |  6 +-
>  include/hw/intc/arm_gic.h                |  6 +-
>  include/hw/intc/arm_gic_common.h         | 11 ++--
>  include/hw/intc/arm_gicv3.h              |  6 +-
>  include/hw/intc/arm_gicv3_common.h       |  6 +-
>  include/hw/intc/arm_gicv3_its_common.h   |  3 +-
>  include/hw/intc/armv7m_nvic.h            |  6 +-
>  include/hw/intc/aspeed_vic.h             |  6 +-
>  include/hw/intc/bcm2835_ic.h             |  6 +-
>  include/hw/intc/bcm2836_control.h        |  6 +-
>  include/hw/intc/heathrow_pic.h           |  6 +-
>  include/hw/intc/ibex_plic.h              |  6 +-
>  include/hw/intc/imx_avic.h               |  6 +-
>  include/hw/intc/imx_gpcv2.h              |  6 +-
>  include/hw/intc/intc.h                   |  5 +-
>  include/hw/intc/mips_gic.h               |  3 +-
>  include/hw/intc/realview_gic.h           |  6 +-
>  include/hw/intc/rx_icu.h                 |  1 +
>  include/hw/intc/xlnx-pmu-iomod-intc.h    |  6 +-
>  include/hw/intc/xlnx-zynqmp-ipi.h        |  6 +-
>  include/hw/ipack/ipack.h                 |  1 +
>  include/hw/ipmi/ipmi.h                   | 18 +++---
>  include/hw/isa/i8259_internal.h          |  7 ++-
>  include/hw/isa/isa.h                     | 11 ++--
>  include/hw/isa/pc87312.h                 |  6 +-
>  include/hw/isa/superio.h                 | 11 ++--
>  include/hw/m68k/mcf_fec.h                |  1 +
>  include/hw/mem/memory-device.h           |  5 +-
>  include/hw/mem/nvdimm.h                  |  5 +-
>  include/hw/mem/pc-dimm.h                 | 11 ++--
>  include/hw/mips/cps.h                    |  6 +-
>  include/hw/misc/a9scu.h                  |  6 +-
>  include/hw/misc/allwinner-cpucfg.h       |  5 +-
>  include/hw/misc/allwinner-h3-ccu.h       |  5 +-
>  include/hw/misc/allwinner-h3-dramc.h     |  5 +-
>  include/hw/misc/allwinner-h3-sysctrl.h   |  5 +-
>  include/hw/misc/allwinner-sid.h          |  5 +-
>  include/hw/misc/arm11scu.h               |  6 +-
>  include/hw/misc/armsse-cpuid.h           |  6 +-
>  include/hw/misc/armsse-mhu.h             |  6 +-
>  include/hw/misc/aspeed_scu.h             | 11 ++--
>  include/hw/misc/aspeed_sdmc.h            | 11 ++--
>  include/hw/misc/aspeed_xdma.h            |  6 +-
>  include/hw/misc/auxbus.h                 |  1 +
>  include/hw/misc/avr_power.h              |  6 +-
>  include/hw/misc/bcm2835_mbox.h           |  6 +-
>  include/hw/misc/bcm2835_mphi.h           |  1 +
>  include/hw/misc/bcm2835_property.h       |  6 +-
>  include/hw/misc/bcm2835_rng.h            |  6 +-
>  include/hw/misc/bcm2835_thermal.h        |  6 +-
>  include/hw/misc/grlib_ahb_apb_pnp.h      |  5 +-
>  include/hw/misc/imx25_ccm.h              |  6 +-
>  include/hw/misc/imx31_ccm.h              |  6 +-
>  include/hw/misc/imx6_ccm.h               |  6 +-
>  include/hw/misc/imx6_src.h               |  6 +-
>  include/hw/misc/imx6ul_ccm.h             |  6 +-
>  include/hw/misc/imx7_ccm.h               | 11 ++--
>  include/hw/misc/imx7_gpr.h               |  6 +-
>  include/hw/misc/imx7_snvs.h              |  6 +-
>  include/hw/misc/imx_ccm.h                | 11 ++--
>  include/hw/misc/imx_rngc.h               |  6 +-
>  include/hw/misc/iotkit-secctl.h          |  3 +-
>  include/hw/misc/iotkit-sysctl.h          |  6 +-
>  include/hw/misc/iotkit-sysinfo.h         |  6 +-
>  include/hw/misc/mac_via.h                | 16 ++++--
>  include/hw/misc/macio/cuda.h             | 11 ++--
>  include/hw/misc/macio/gpio.h             |  6 +-
>  include/hw/misc/macio/macio.h            | 26 +++++----
>  include/hw/misc/macio/pmu.h              | 11 ++--
>  include/hw/misc/max111x.h                |  6 +-
>  include/hw/misc/mips_cmgcr.h             |  3 +-
>  include/hw/misc/mips_cpc.h               |  6 +-
>  include/hw/misc/mips_itu.h               |  6 +-
>  include/hw/misc/mos6522.h                | 11 ++--
>  include/hw/misc/mps2-fpgaio.h            |  6 +-
>  include/hw/misc/mps2-scc.h               |  6 +-
>  include/hw/misc/msf2-sysreg.h            |  6 +-
>  include/hw/misc/nrf51_rng.h              |  6 +-
>  include/hw/misc/pca9552.h                |  6 +-
>  include/hw/misc/stm32f2xx_syscfg.h       |  6 +-
>  include/hw/misc/stm32f4xx_exti.h         |  6 +-
>  include/hw/misc/stm32f4xx_syscfg.h       |  6 +-
>  include/hw/misc/tz-mpc.h                 |  3 +-
>  include/hw/misc/tz-msc.h                 |  6 +-
>  include/hw/misc/tz-ppc.h                 |  3 +-
>  include/hw/misc/unimp.h                  |  6 +-
>  include/hw/misc/vmcoreinfo.h             |  6 +-
>  include/hw/misc/zynq-xadc.h              |  6 +-
>  include/hw/net/allwinner-sun8i-emac.h    |  5 +-
>  include/hw/net/allwinner_emac.h          |  6 +-
>  include/hw/net/cadence_gem.h             |  6 +-
>  include/hw/net/ftgmac100.h               | 11 ++--
>  include/hw/net/imx_fec.h                 |  6 +-
>  include/hw/net/lance.h                   |  6 +-
>  include/hw/net/lasi_82596.h              |  6 +-
>  include/hw/net/msf2-emac.h               |  6 +-
>  include/hw/nmi.h                         |  5 +-
>  include/hw/nubus/mac-nubus-bridge.h      |  6 +-
>  include/hw/nubus/nubus.h                 | 11 ++--
>  include/hw/nvram/fw_cfg.h                |  6 +-
>  include/hw/nvram/nrf51_nvm.h             |  6 +-
>  include/hw/pci-bridge/simba.h            |  6 +-
>  include/hw/pci-host/designware.h         |  8 ++-
>  include/hw/pci-host/gpex.h               | 11 ++--
>  include/hw/pci-host/i440fx.h             |  6 +-
>  include/hw/pci-host/pnv_phb3.h           | 11 ++--
>  include/hw/pci-host/pnv_phb4.h           |  6 +-
>  include/hw/pci-host/q35.h                | 11 ++--
>  include/hw/pci-host/sabre.h              | 11 ++--
>  include/hw/pci-host/spapr.h              |  3 +-
>  include/hw/pci-host/uninorth.h           | 11 ++--
>  include/hw/pci-host/xilinx-pcie.h        | 11 ++--
>  include/hw/pci/pci.h                     |  6 +-
>  include/hw/pci/pci_bridge.h              |  1 +
>  include/hw/pci/pci_host.h                |  6 +-
>  include/hw/pci/pcie_host.h               |  1 +
>  include/hw/pci/pcie_port.h               |  6 +-
>  include/hw/pcmcia.h                      | 11 ++--
>  include/hw/platform-bus.h                |  1 +
>  include/hw/ppc/mac_dbdma.h               |  6 +-
>  include/hw/ppc/openpic.h                 |  6 +-
>  include/hw/ppc/pnv.h                     | 33 ++++++-----
>  include/hw/ppc/pnv_core.h                | 16 ++++--
>  include/hw/ppc/pnv_homer.h               | 11 ++--
>  include/hw/ppc/pnv_lpc.h                 | 11 ++--
>  include/hw/ppc/pnv_occ.h                 | 11 ++--
>  include/hw/ppc/pnv_pnor.h                |  6 +-
>  include/hw/ppc/pnv_psi.h                 | 21 ++++---
>  include/hw/ppc/pnv_xive.h                | 11 ++--
>  include/hw/ppc/pnv_xscom.h               |  5 +-
>  include/hw/ppc/spapr.h                   |  3 +-
>  include/hw/ppc/spapr_cpu_core.h          | 11 ++--
>  include/hw/ppc/spapr_drc.h               | 15 +++--
>  include/hw/ppc/spapr_irq.h               |  6 +-
>  include/hw/ppc/spapr_tpm_proxy.h         |  5 +-
>  include/hw/ppc/spapr_vio.h               | 10 ++--
>  include/hw/ppc/spapr_xive.h              | 11 ++--
>  include/hw/ppc/xics.h                    |  6 +-
>  include/hw/ppc/xics_spapr.h              |  1 +
>  include/hw/ppc/xive.h                    | 41 +++++++------
>  include/hw/qdev-core.h                   |  5 +-
>  include/hw/rdma/rdma.h                   |  5 +-
>  include/hw/register.h                    |  1 +
>  include/hw/resettable.h                  |  5 +-
>  include/hw/riscv/opentitan.h             |  6 +-
>  include/hw/riscv/riscv_hart.h            |  6 +-
>  include/hw/riscv/sifive_clint.h          |  6 +-
>  include/hw/riscv/sifive_e.h              | 11 ++--
>  include/hw/riscv/sifive_e_prci.h         |  6 +-
>  include/hw/riscv/sifive_gpio.h           |  6 +-
>  include/hw/riscv/sifive_plic.h           |  6 +-
>  include/hw/riscv/sifive_test.h           |  6 +-
>  include/hw/riscv/sifive_u.h              | 11 ++--
>  include/hw/riscv/sifive_u_otp.h          |  6 +-
>  include/hw/riscv/sifive_u_prci.h         |  6 +-
>  include/hw/riscv/sifive_uart.h           |  6 +-
>  include/hw/riscv/virt.h                  |  6 +-
>  include/hw/rtc/allwinner-rtc.h           | 10 ++--
>  include/hw/rtc/aspeed_rtc.h              |  6 +-
>  include/hw/rtc/goldfish_rtc.h            |  6 +-
>  include/hw/rtc/m48t59.h                  |  5 +-
>  include/hw/rtc/mc146818rtc.h             |  6 +-
>  include/hw/rtc/pl031.h                   |  6 +-
>  include/hw/rtc/xlnx-zynqmp-rtc.h         |  6 +-
>  include/hw/rx/rx62n.h                    |  6 +-
>  include/hw/s390x/3270-ccw.h              | 11 ++--
>  include/hw/s390x/ap-device.h             |  6 +-
>  include/hw/s390x/css-bridge.h            | 10 ++--
>  include/hw/s390x/event-facility.h        | 16 ++++--
>  include/hw/s390x/s390-ccw.h              | 11 ++--
>  include/hw/s390x/s390-virtio-ccw.h       | 11 ++--
>  include/hw/s390x/s390_flic.h             | 16 ++++--
>  include/hw/s390x/sclp.h                  | 11 ++--
>  include/hw/s390x/storage-attributes.h    | 21 ++++---
>  include/hw/s390x/storage-keys.h          | 16 ++++--
>  include/hw/s390x/tod.h                   | 11 ++--
>  include/hw/s390x/vfio-ccw.h              |  3 +-
>  include/hw/scsi/esp.h                    |  6 +-
>  include/hw/scsi/scsi.h                   |  6 +-
>  include/hw/sd/allwinner-sdhost.h         | 10 ++--
>  include/hw/sd/aspeed_sdhci.h             |  6 +-
>  include/hw/sd/bcm2835_sdhost.h           |  6 +-
>  include/hw/sd/sd.h                       | 11 ++--
>  include/hw/sd/sdhci.h                    |  6 +-
>  include/hw/sparc/sparc32_dma.h           | 18 +++---
>  include/hw/sparc/sun4m_iommu.h           |  6 +-
>  include/hw/sparc/sun4u_iommu.h           |  6 +-
>  include/hw/ssi/aspeed_smc.h              | 11 ++--
>  include/hw/ssi/imx_spi.h                 |  6 +-
>  include/hw/ssi/mss-spi.h                 |  6 +-
>  include/hw/ssi/pl022.h                   |  6 +-
>  include/hw/ssi/ssi.h                     |  1 +
>  include/hw/ssi/stm32f2xx_spi.h           |  6 +-
>  include/hw/ssi/xilinx_spips.h            | 16 ++++--
>  include/hw/stream.h                      |  5 +-
>  include/hw/sysbus.h                      |  6 +-
>  include/hw/timer/a9gtimer.h              |  3 +-
>  include/hw/timer/allwinner-a10-pit.h     |  3 +-
>  include/hw/timer/arm_mptimer.h           |  6 +-
>  include/hw/timer/armv7m_systick.h        |  6 +-
>  include/hw/timer/aspeed_timer.h          | 13 +++--
>  include/hw/timer/avr_timer16.h           |  6 +-
>  include/hw/timer/bcm2835_systmr.h        |  6 +-
>  include/hw/timer/cmsdk-apb-dualtimer.h   |  3 +-
>  include/hw/timer/cmsdk-apb-timer.h       |  6 +-
>  include/hw/timer/digic-timer.h           |  6 +-
>  include/hw/timer/i8254.h                 |  1 +
>  include/hw/timer/imx_epit.h              |  6 +-
>  include/hw/timer/imx_gpt.h               |  6 +-
>  include/hw/timer/mss-timer.h             |  6 +-
>  include/hw/timer/nrf51_timer.h           |  6 +-
>  include/hw/timer/renesas_cmt.h           |  6 +-
>  include/hw/timer/renesas_tmr.h           |  6 +-
>  include/hw/timer/stm32f2xx_timer.h       |  6 +-
>  include/hw/usb.h                         |  6 +-
>  include/hw/usb/chipidea.h                |  6 +-
>  include/hw/usb/imx-usb-phy.h             |  6 +-
>  include/hw/vfio/vfio-amd-xgbe.h          |  1 +
>  include/hw/vfio/vfio-calxeda-xgmac.h     | 11 ++--
>  include/hw/vfio/vfio-platform.h          | 11 ++--
>  include/hw/virtio/vhost-scsi-common.h    |  6 +-
>  include/hw/virtio/vhost-scsi.h           |  6 +-
>  include/hw/virtio/vhost-user-blk.h       |  6 +-
>  include/hw/virtio/vhost-user-fs.h        |  6 +-
>  include/hw/virtio/vhost-user-scsi.h      |  6 +-
>  include/hw/virtio/vhost-user-vsock.h     |  6 +-
>  include/hw/virtio/vhost-vsock-common.h   |  6 +-
>  include/hw/virtio/vhost-vsock.h          |  6 +-
>  include/hw/virtio/virtio-balloon.h       |  6 +-
>  include/hw/virtio/virtio-blk.h           |  6 +-
>  include/hw/virtio/virtio-bus.h           |  8 ++-
>  include/hw/virtio/virtio-crypto.h        |  6 +-
>  include/hw/virtio/virtio-gpu-pci.h       |  1 +
>  include/hw/virtio/virtio-gpu.h           | 16 ++++--
>  include/hw/virtio/virtio-input.h         | 11 ++--
>  include/hw/virtio/virtio-iommu.h         |  6 +-
>  include/hw/virtio/virtio-mem.h           | 11 ++--
>  include/hw/virtio/virtio-mmio.h          |  6 +-
>  include/hw/virtio/virtio-net.h           |  3 +-
>  include/hw/virtio/virtio-pmem.h          | 11 ++--
>  include/hw/virtio/virtio-rng.h           |  6 +-
>  include/hw/virtio/virtio-scsi.h          | 11 ++--
>  include/hw/virtio/virtio-serial.h        |  8 ++-
>  include/hw/virtio/virtio.h               |  6 +-
>  include/hw/vmstate-if.h                  |  5 +-
>  include/hw/watchdog/cmsdk-apb-watchdog.h |  6 +-
>  include/hw/watchdog/wdt_aspeed.h         | 11 ++--
>  include/hw/watchdog/wdt_diag288.h        | 11 ++--
>  include/hw/watchdog/wdt_imx2.h           |  6 +-
>  include/hw/xen/xen-block.h               | 21 ++++---
>  include/hw/xen/xen-bus.h                 | 21 ++++---
>  include/hw/xen/xen-legacy-backend.h      |  1 +
>  include/io/channel-buffer.h              |  3 +-
>  include/io/channel-command.h             |  3 +-
>  include/io/channel-file.h                |  3 +-
>  include/io/channel-socket.h              |  3 +-
>  include/io/channel-tls.h                 |  3 +-
>  include/io/channel-websock.h             |  3 +-
>  include/io/channel.h                     |  4 +-
>  include/io/dns-resolver.h                |  4 +-
>  include/io/net-listener.h                |  5 +-
>  include/net/can_host.h                   | 11 ++--
>  include/net/filter.h                     |  5 +-
>  include/qom/object.h                     |  1 +
>  include/qom/object_interfaces.h          |  5 +-
>  include/scsi/pr-manager.h                | 10 ++--
>  include/sysemu/accel.h                   | 10 ++--
>  include/sysemu/cryptodev.h               |  7 ++-
>  include/sysemu/hostmem.h                 |  4 +-
>  include/sysemu/hvf.h                     |  1 +
>  include/sysemu/iothread.h                |  5 +-
>  include/sysemu/kvm_int.h                 |  1 +
>  include/sysemu/rng-random.h              |  2 +-
>  include/sysemu/rng.h                     |  4 +-
>  include/sysemu/tpm.h                     |  5 +-
>  include/sysemu/tpm_backend.h             |  4 +-
>  include/sysemu/vhost-user-backend.h      |  4 +-
>  include/ui/console.h                     |  2 +-
>  migration/migration.h                    |  6 +-
>  target/alpha/cpu-qom.h                   |  8 ++-
>  target/arm/cpu-qom.h                     | 13 +++--
>  target/arm/idau.h                        |  5 +-
>  target/avr/cpu-qom.h                     |  8 ++-
>  target/cris/cpu-qom.h                    |  8 ++-
>  target/hppa/cpu-qom.h                    |  8 ++-
>  target/i386/cpu-qom.h                    |  8 ++-
>  target/lm32/cpu-qom.h                    |  8 ++-
>  target/m68k/cpu-qom.h                    |  8 ++-
>  target/microblaze/cpu-qom.h              |  8 ++-
>  target/mips/cpu-qom.h                    |  8 ++-
>  target/moxie/cpu.h                       | 11 ++--
>  target/nios2/cpu.h                       | 11 ++--
>  target/openrisc/cpu.h                    | 11 ++--
>  target/ppc/cpu-qom.h                     |  8 ++-
>  target/ppc/cpu.h                         |  1 +
>  target/riscv/cpu.h                       | 11 ++--
>  target/rx/cpu-qom.h                      |  6 +-
>  target/s390x/cpu-qom.h                   |  8 ++-
>  target/sh4/cpu-qom.h                     |  8 ++-
>  target/sparc/cpu-qom.h                   |  8 ++-
>  target/tilegx/cpu.h                      | 11 ++--
>  target/tricore/cpu-qom.h                 |  8 ++-
>  target/unicore32/cpu-qom.h               |  8 ++-
>  target/xtensa/cpu-qom.h                  |  8 ++-
>  accel/tcg/tcg-all.c                      |  5 +-
>  backends/cryptodev-builtin.c             |  5 +-
>  backends/cryptodev-vhost-user.c          |  6 +-
>  backends/dbus-vmstate.c                  |  1 +
>  backends/hostmem-file.c                  |  3 +-
>  backends/hostmem-memfd.c                 |  3 +-
>  backends/rng-builtin.c                   |  6 +-
>  backends/rng-egd.c                       |  7 ++-
>  backends/tpm/tpm_emulator.c              |  6 +-
>  backends/tpm/tpm_passthrough.c           |  3 +-
>  chardev/baum.c                           |  6 +-
>  chardev/char-parallel.c                  | 11 ++--
>  chardev/char-pty.c                       |  6 +-
>  chardev/char-ringbuf.c                   |  6 +-
>  chardev/char-socket.c                    |  6 +-
>  chardev/char-udp.c                       |  6 +-
>  chardev/char-win-stdio.c                 |  6 +-
>  chardev/msmouse.c                        |  6 +-
>  chardev/testdev.c                        |  6 +-
>  chardev/wctablet.c                       |  6 +-
>  hw/acpi/piix4.c                          |  6 +-
>  hw/alpha/typhoon.c                       |  6 +-
>  hw/arm/collie.c                          |  6 +-
>  hw/arm/highbank.c                        |  6 +-
>  hw/arm/integratorcp.c                    | 16 ++++--
>  hw/arm/microbit.c                        |  6 +-
>  hw/arm/mps2-tz.c                         | 11 ++--
>  hw/arm/mps2.c                            | 11 ++--
>  hw/arm/musca.c                           | 11 ++--
>  hw/arm/musicpal.c                        | 41 +++++++------
>  hw/arm/palm.c                            |  6 +-
>  hw/arm/pxa2xx.c                          | 16 ++++--
>  hw/arm/pxa2xx_gpio.c                     |  3 +-
>  hw/arm/pxa2xx_pic.c                      |  6 +-
>  hw/arm/raspi.c                           | 11 ++--
>  hw/arm/sbsa-ref.c                        |  6 +-
>  hw/arm/spitz.c                           | 36 +++++++-----
>  hw/arm/stellaris.c                       | 16 ++++--
>  hw/arm/strongarm.c                       | 25 ++++----
>  hw/arm/tosa.c                            | 11 ++--
>  hw/arm/versatilepb.c                     |  6 +-
>  hw/arm/vexpress.c                        | 11 ++--
>  hw/arm/xilinx_zynq.c                     |  6 +-
>  hw/arm/xlnx-versal-virt.c                |  6 +-
>  hw/arm/xlnx-zcu102.c                     |  6 +-
>  hw/arm/z2.c                              | 11 ++--
>  hw/audio/ac97.c                          |  6 +-
>  hw/audio/adlib.c                         |  6 +-
>  hw/audio/cs4231.c                        |  6 +-
>  hw/audio/cs4231a.c                       |  6 +-
>  hw/audio/es1370.c                        |  6 +-
>  hw/audio/gus.c                           |  6 +-
>  hw/audio/hda-codec.c                     |  1 +
>  hw/audio/intel-hda.c                     |  1 +
>  hw/audio/marvell_88w8618.c               |  6 +-
>  hw/audio/milkymist-ac97.c                |  3 +-
>  hw/audio/pcspk.c                         |  6 +-
>  hw/audio/pl041.c                         |  6 +-
>  hw/audio/sb16.c                          |  6 +-
>  hw/audio/wm8750.c                        |  6 +-
>  hw/avr/arduino.c                         | 11 ++--
>  hw/avr/atmega.c                          |  6 +-
>  hw/block/fdc.c                           | 21 ++++---
>  hw/block/m25p80.c                        | 11 ++--
>  hw/block/nand.c                          |  1 +
>  hw/block/onenand.c                       |  6 +-
>  hw/char/debugcon.c                       |  6 +-
>  hw/char/etraxfs_ser.c                    |  6 +-
>  hw/char/exynos4210_uart.c                |  6 +-
>  hw/char/grlib_apbuart.c                  |  6 +-
>  hw/char/ipoctal232.c                     |  1 +
>  hw/char/lm32_juart.c                     |  3 +-
>  hw/char/lm32_uart.c                      |  3 +-
>  hw/char/mcf_uart.c                       |  6 +-
>  hw/char/milkymist-uart.c                 |  3 +-
>  hw/char/parallel.c                       |  6 +-
>  hw/char/sclpconsole-lm.c                 |  6 +-
>  hw/char/sclpconsole.c                    |  6 +-
>  hw/char/serial-isa.c                     |  6 +-
>  hw/char/serial-pci.c                     |  6 +-
>  hw/char/spapr_vty.c                      |  6 +-
>  hw/char/terminal3270.c                   |  6 +-
>  hw/char/virtio-console.c                 |  6 +-
>  hw/char/virtio-serial-bus.c              |  1 +
>  hw/char/xilinx_uartlite.c                |  6 +-
>  hw/cpu/realview_mpcore.c                 |  6 +-
>  hw/display/ads7846.c                     |  6 +-
>  hw/display/artist.c                      |  6 +-
>  hw/display/bochs-display.c               |  6 +-
>  hw/display/cg3.c                         |  6 +-
>  hw/display/cirrus_vga.c                  |  6 +-
>  hw/display/cirrus_vga_isa.c              |  6 +-
>  hw/display/exynos4210_fimd.c             |  6 +-
>  hw/display/g364fb.c                      |  6 +-
>  hw/display/jazz_led.c                    |  6 +-
>  hw/display/milkymist-tmu2.c              |  3 +-
>  hw/display/milkymist-vgafb.c             |  3 +-
>  hw/display/next-fb.c                     |  3 +-
>  hw/display/pl110.c                       |  6 +-
>  hw/display/ramfb-standalone.c            |  6 +-
>  hw/display/sii9022.c                     |  6 +-
>  hw/display/sm501.c                       | 11 ++--
>  hw/display/ssd0303.c                     |  6 +-
>  hw/display/ssd0323.c                     |  6 +-
>  hw/display/tcx.c                         |  6 +-
>  hw/display/vga-isa.c                     |  6 +-
>  hw/display/vga-pci.c                     |  6 +-
>  hw/display/vhost-user-gpu-pci.c          |  6 +-
>  hw/display/vhost-user-gpu.c              |  1 +
>  hw/display/vhost-user-vga.c              |  6 +-
>  hw/display/virtio-gpu-pci.c              |  6 +-
>  hw/display/virtio-vga.c                  |  6 +-
>  hw/display/vmware_vga.c                  |  1 +
>  hw/dma/i82374.c                          |  6 +-
>  hw/dma/i8257.c                           |  1 +
>  hw/dma/pl330.c                           |  1 +
>  hw/dma/puv3_dma.c                        |  6 +-
>  hw/dma/pxa2xx_dma.c                      |  6 +-
>  hw/dma/rc4030.c                          |  6 +-
>  hw/dma/xilinx_axidma.c                   |  5 +-
>  hw/gpio/gpio_key.c                       |  6 +-
>  hw/gpio/max7310.c                        |  6 +-
>  hw/gpio/mpc8xxx.c                        |  6 +-
>  hw/gpio/pl061.c                          |  6 +-
>  hw/gpio/puv3_gpio.c                      |  6 +-
>  hw/gpio/zaurus.c                         |  3 +-
>  hw/hppa/dino.c                           |  6 +-
>  hw/hppa/lasi.c                           |  6 +-
>  hw/hyperv/hyperv.c                       |  6 +-
>  hw/hyperv/hyperv_testdev.c               |  1 +
>  hw/hyperv/vmbus.c                        |  1 +
>  hw/i2c/bitbang_i2c.c                     |  6 +-
>  hw/i2c/exynos4210_i2c.c                  |  6 +-
>  hw/i2c/mpc_i2c.c                         |  6 +-
>  hw/i2c/smbus_eeprom.c                    |  6 +-
>  hw/i2c/smbus_ich9.c                      |  6 +-
>  hw/i2c/versatile_i2c.c                   |  3 +-
>  hw/i386/kvm/clock.c                      |  6 +-
>  hw/i386/kvm/i8254.c                      | 11 ++--
>  hw/i386/kvm/i8259.c                      |  6 +-
>  hw/i386/kvmvapic.c                       |  6 +-
>  hw/i386/port92.c                         |  6 +-
>  hw/i386/vmmouse.c                        |  7 ++-
>  hw/i386/vmport.c                         |  6 +-
>  hw/i386/xen/xen_platform.c               |  6 +-
>  hw/i386/xen/xen_pvdevice.c               |  6 +-
>  hw/ide/ahci-allwinner.c                  |  1 +
>  hw/ide/isa.c                             |  6 +-
>  hw/ide/microdrive.c                      |  6 +-
>  hw/ide/mmio.c                            |  6 +-
>  hw/ide/sii3112.c                         |  6 +-
>  hw/input/adb-kbd.c                       | 11 ++--
>  hw/input/adb-mouse.c                     | 11 ++--
>  hw/input/lm832x.c                        |  6 +-
>  hw/input/milkymist-softusb.c             |  3 +-
>  hw/input/pckbd.c                         |  1 +
>  hw/input/pl050.c                         |  6 +-
>  hw/intc/apic.c                           |  1 +
>  hw/intc/arm_gic_kvm.c                    |  6 +-
>  hw/intc/arm_gicv2m.c                     |  6 +-
>  hw/intc/arm_gicv3_its_kvm.c              |  6 +-
>  hw/intc/arm_gicv3_kvm.c                  |  6 +-
>  hw/intc/etraxfs_pic.c                    |  1 +
>  hw/intc/exynos4210_combiner.c            |  6 +-
>  hw/intc/exynos4210_gic.c                 | 11 ++--
>  hw/intc/grlib_irqmp.c                    |  6 +-
>  hw/intc/i8259.c                          |  6 +-
>  hw/intc/lm32_pic.c                       |  3 +-
>  hw/intc/loongson_liointc.c               |  1 +
>  hw/intc/nios2_iic.c                      |  6 +-
>  hw/intc/ompic.c                          |  3 +-
>  hw/intc/openpic_kvm.c                    |  6 +-
>  hw/intc/pl190.c                          |  6 +-
>  hw/intc/puv3_intc.c                      |  6 +-
>  hw/intc/s390_flic_kvm.c                  |  6 +-
>  hw/intc/slavio_intctl.c                  |  6 +-
>  hw/intc/xilinx_intc.c                    |  1 +
>  hw/ipack/tpci200.c                       |  6 +-
>  hw/ipmi/ipmi_bmc_extern.c                |  6 +-
>  hw/ipmi/isa_ipmi_bt.c                    |  6 +-
>  hw/ipmi/isa_ipmi_kcs.c                   |  6 +-
>  hw/ipmi/pci_ipmi_bt.c                    |  6 +-
>  hw/ipmi/pci_ipmi_kcs.c                   |  6 +-
>  hw/ipmi/smbus_ipmi.c                     |  6 +-
>  hw/isa/i82378.c                          |  6 +-
>  hw/isa/piix3.c                           |  1 +
>  hw/isa/piix4.c                           |  6 +-
>  hw/isa/vt82c686.c                        | 21 ++++---
>  hw/m68k/mcf_intc.c                       |  6 +-
>  hw/m68k/next-cube.c                      |  6 +-
>  hw/m68k/next-kbd.c                       |  6 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c          |  6 +-
>  hw/mips/boston.c                         |  6 +-
>  hw/mips/gt64xxx_pci.c                    |  6 +-
>  hw/mips/malta.c                          |  6 +-
>  hw/misc/applesmc.c                       |  3 +-
>  hw/misc/arm_integrator_debug.c           |  6 +-
>  hw/misc/arm_l2x0.c                       |  6 +-
>  hw/misc/arm_sysctl.c                     |  6 +-
>  hw/misc/auxbus.c                         |  1 +
>  hw/misc/debugexit.c                      |  6 +-
>  hw/misc/eccmemctl.c                      |  6 +-
>  hw/misc/edu.c                            |  6 +-
>  hw/misc/empty_slot.c                     |  6 +-
>  hw/misc/exynos4210_clk.c                 |  6 +-
>  hw/misc/exynos4210_pmu.c                 |  6 +-
>  hw/misc/exynos4210_rng.c                 |  6 +-
>  hw/misc/ivshmem.c                        |  6 +-
>  hw/misc/milkymist-hpdmc.c                |  3 +-
>  hw/misc/milkymist-pfpu.c                 |  3 +-
>  hw/misc/mst_fpga.c                       |  6 +-
>  hw/misc/pc-testdev.c                     |  6 +-
>  hw/misc/pca9552.c                        |  6 +-
>  hw/misc/pci-testdev.c                    |  6 +-
>  hw/misc/puv3_pm.c                        |  6 +-
>  hw/misc/pvpanic.c                        |  6 +-
>  hw/misc/sga.c                            |  6 +-
>  hw/misc/slavio_misc.c                    | 11 ++--
>  hw/misc/tmp421.c                         | 11 ++--
>  hw/misc/zynq_slcr.c                      |  6 +-
>  hw/net/can/can_kvaser_pci.c              |  6 +-
>  hw/net/can/can_mioe3680_pci.c            |  6 +-
>  hw/net/can/can_pcm3680_pci.c             |  6 +-
>  hw/net/dp8393x.c                         |  6 +-
>  hw/net/e1000.c                           | 11 ++--
>  hw/net/e1000e.c                          |  6 +-
>  hw/net/etraxfs_eth.c                     |  7 ++-
>  hw/net/lan9118.c                         |  6 +-
>  hw/net/milkymist-minimac2.c              |  3 +-
>  hw/net/mipsnet.c                         |  6 +-
>  hw/net/ne2000-isa.c                      |  6 +-
>  hw/net/opencores_eth.c                   |  6 +-
>  hw/net/pcnet-pci.c                       |  6 +-
>  hw/net/rocker/rocker.c                   |  1 +
>  hw/net/rtl8139.c                         |  6 +-
>  hw/net/smc91c111.c                       |  6 +-
>  hw/net/spapr_llan.c                      |  6 +-
>  hw/net/stellaris_enet.c                  |  6 +-
>  hw/net/sungem.c                          |  6 +-
>  hw/net/sunhme.c                          |  6 +-
>  hw/net/vmxnet3.c                         |  6 +-
>  hw/net/xgmac.c                           |  6 +-
>  hw/net/xilinx_axienet.c                  |  5 +-
>  hw/net/xilinx_ethlite.c                  |  1 +
>  hw/nvram/ds1225y.c                       |  6 +-
>  hw/nvram/eeprom_at24c.c                  |  6 +-
>  hw/nvram/spapr_nvram.c                   |  6 +-
>  hw/pci-bridge/dec.c                      |  6 +-
>  hw/pci-bridge/gen_pcie_root_port.c       |  6 +-
>  hw/pci-bridge/pci_bridge_dev.c           |  3 +-
>  hw/pci-bridge/pci_expander_bridge.c      | 11 ++--
>  hw/pci-bridge/pcie_pci_bridge.c          |  6 +-
>  hw/pci-host/bonito.c                     |  6 +-
>  hw/pci-host/grackle.c                    |  6 +-
>  hw/pci-host/i440fx.c                     |  6 +-
>  hw/pci-host/pnv_phb3.c                   |  1 +
>  hw/pci-host/pnv_phb4.c                   |  1 +
>  hw/pci-host/ppce500.c                    |  5 +-
>  hw/pci-host/prep.c                       | 11 ++--
>  hw/pci-host/versatile.c                  |  6 +-
>  hw/pcmcia/pxa2xx.c                       |  1 +
>  hw/ppc/mpc8544_guts.c                    |  3 +-
>  hw/ppc/ppc440_pcix.c                     |  6 +-
>  hw/ppc/ppc440_uc.c                       |  6 +-
>  hw/ppc/ppc4xx_pci.c                      |  3 +-
>  hw/ppc/ppce500_spin.c                    |  6 +-
>  hw/ppc/prep_systemio.c                   |  6 +-
>  hw/ppc/rs6000_mc.c                       |  6 +-
>  hw/ppc/spapr_rng.c                       |  3 +-
>  hw/rtc/ds1338.c                          |  6 +-
>  hw/rtc/exynos4210_rtc.c                  |  6 +-
>  hw/rtc/m41t80.c                          |  6 +-
>  hw/rtc/m48t59-isa.c                      | 11 ++--
>  hw/rtc/m48t59.c                          | 11 ++--
>  hw/rtc/sun4v-rtc.c                       |  6 +-
>  hw/rtc/twl92230.c                        |  6 +-
>  hw/rx/rx-gdbsim.c                        | 11 ++--
>  hw/rx/rx62n.c                            |  6 +-
>  hw/scsi/esp-pci.c                        | 11 ++--
>  hw/scsi/lsi53c895a.c                     |  6 +-
>  hw/scsi/megasas.c                        | 11 ++--
>  hw/scsi/mptsas.c                         |  1 +
>  hw/scsi/scsi-disk.c                      | 12 ++--
>  hw/scsi/spapr_vscsi.c                    |  6 +-
>  hw/scsi/vmw_pvscsi.c                     | 11 ++--
>  hw/sd/allwinner-sdhost.c                 |  1 +
>  hw/sd/bcm2835_sdhost.c                   |  1 +
>  hw/sd/milkymist-memcard.c                |  3 +-
>  hw/sd/pl181.c                            |  6 +-
>  hw/sd/pxa2xx_mmci.c                      |  1 +
>  hw/sd/sdhci.c                            |  1 +
>  hw/sd/ssi-sd.c                           |  6 +-
>  hw/sh4/sh_pci.c                          |  6 +-
>  hw/sparc/sun4m.c                         | 21 ++++---
>  hw/sparc64/sun4u.c                       | 21 ++++---
>  hw/ssi/ssi.c                             |  1 +
>  hw/ssi/xilinx_spi.c                      |  6 +-
>  hw/timer/altera_timer.c                  |  6 +-
>  hw/timer/arm_timer.c                     | 11 ++--
>  hw/timer/cadence_ttc.c                   |  6 +-
>  hw/timer/etraxfs_timer.c                 |  6 +-
>  hw/timer/exynos4210_mct.c                |  6 +-
>  hw/timer/exynos4210_pwm.c                |  6 +-
>  hw/timer/grlib_gptimer.c                 |  3 +-
>  hw/timer/hpet.c                          |  6 +-
>  hw/timer/i8254.c                         |  6 +-
>  hw/timer/lm32_timer.c                    |  3 +-
>  hw/timer/milkymist-sysctl.c              |  3 +-
>  hw/timer/puv3_ost.c                      |  6 +-
>  hw/timer/pxa2xx_timer.c                  |  3 +-
>  hw/timer/slavio_timer.c                  |  6 +-
>  hw/timer/xilinx_timer.c                  |  1 +
>  hw/tpm/tpm_crb.c                         |  6 +-
>  hw/tpm/tpm_spapr.c                       |  6 +-
>  hw/tpm/tpm_tis_isa.c                     |  6 +-
>  hw/tpm/tpm_tis_sysbus.c                  |  6 +-
>  hw/usb/ccid-card-emulated.c              |  3 +-
>  hw/usb/ccid-card-passthru.c              |  1 +
>  hw/usb/dev-audio.c                       |  6 +-
>  hw/usb/dev-hid.c                         |  6 +-
>  hw/usb/dev-hub.c                         |  6 +-
>  hw/usb/dev-mtp.c                         |  1 +
>  hw/usb/dev-network.c                     |  6 +-
>  hw/usb/dev-serial.c                      |  6 +-
>  hw/usb/dev-smartcard-reader.c            | 11 ++--
>  hw/usb/dev-storage.c                     |  6 +-
>  hw/usb/dev-uas.c                         |  1 +
>  hw/usb/dev-wacom.c                       |  6 +-
>  hw/usb/hcd-ohci-pci.c                    |  6 +-
>  hw/usb/hcd-uhci.c                        |  1 +
>  hw/usb/host-libusb.c                     |  3 +-
>  hw/usb/redirect.c                        |  1 +
>  hw/usb/tusb6010.c                        |  6 +-
>  hw/vfio/ap.c                             |  6 +-
>  hw/vfio/pci.c                            |  1 +
>  hw/virtio/vhost-scsi-pci.c               |  1 +
>  hw/virtio/vhost-user-blk-pci.c           |  1 +
>  hw/virtio/vhost-user-fs-pci.c            |  1 +
>  hw/virtio/vhost-user-input-pci.c         |  1 +
>  hw/virtio/vhost-user-scsi-pci.c          |  1 +
>  hw/virtio/vhost-user-vsock-pci.c         |  1 +
>  hw/virtio/vhost-vsock-pci.c              |  1 +
>  hw/virtio/virtio-9p-pci.c                |  6 +-
>  hw/virtio/virtio-balloon-pci.c           |  1 +
>  hw/virtio/virtio-blk-pci.c               |  1 +
>  hw/virtio/virtio-crypto-pci.c            |  1 +
>  hw/virtio/virtio-input-host-pci.c        |  1 +
>  hw/virtio/virtio-input-pci.c             |  1 +
>  hw/virtio/virtio-iommu-pci.c             |  1 +
>  hw/virtio/virtio-net-pci.c               |  1 +
>  hw/virtio/virtio-rng-pci.c               |  1 +
>  hw/virtio/virtio-scsi-pci.c              |  1 +
>  hw/virtio/virtio-serial-pci.c            |  1 +
>  hw/watchdog/wdt_i6300esb.c               |  1 +
>  hw/watchdog/wdt_ib700.c                  |  6 +-
>  migration/rdma.c                         |  3 +-
>  net/can/can_socketcan.c                  |  6 +-
>  net/colo-compare.c                       |  5 +-
>  net/dump.c                               |  3 +-
>  net/filter-buffer.c                      |  5 +-
>  net/filter-mirror.c                      |  9 +--
>  net/filter-replay.c                      |  3 +-
>  net/filter-rewriter.c                    |  7 ++-
>  scsi/pr-manager-helper.c                 |  6 +-
>  target/i386/sev.c                        |  3 +-
>  tests/check-qom-interface.c              |  5 +-
>  tests/test-qdev-global-props.c           |  5 +-
>  ui/console.c                             |  6 +-
>  ui/gtk.c                                 |  5 +-
>  ui/input-barrier.c                       |  5 +-
>  ui/input-linux.c                         |  5 +-
>  ui/spice-app.c                           |  6 +-
>  815 files changed, 3439 insertions(+), 1852 deletions(-)

Wow, alot of files using unusual style - another good example in favour
of automating the boilerplate

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


