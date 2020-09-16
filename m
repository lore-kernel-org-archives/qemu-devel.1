Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CBDC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E6F206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 18:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLFVzf/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIc9i-0000N4-Ls
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 14:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIc7e-0007JI-03
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIc7T-00011U-Gf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 14:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600280724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ua/JPcaXcTwVTSXFhXBd8ky0UDiTDJR8Lf1n8scmRrk=;
 b=RLFVzf/OfyF76s0aqe03qVSYF3pCJoA8OEFVSTa/m8Rk8HWyaTlk36Vd7KVSQMsSKgiMer
 L/3Jlb+ma95QXOl/6OQDvOvx1NMigCvMTWCMJmysNfRkwHKqzIm9HkIfqa8qkBqIsFvgax
 Q2GxDb9+pSSkMooHW/5mWsq724eizGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-PxAovXaJM3yDaQx8Mx_0kA-1; Wed, 16 Sep 2020 14:25:22 -0400
X-MC-Unique: PxAovXaJM3yDaQx8Mx_0kA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D649802B6D
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 18:25:21 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA7ED100238C;
 Wed, 16 Sep 2020 18:25:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] qom: Convert more declarations to OBJECT_DECLARE*
Date: Wed, 16 Sep 2020 14:25:14 -0400
Message-Id: <20200916182519.415636-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This converts many QOM types to use OBJECT_DECLARE* instead of=0D
manually using DECLARE*_CHECKER*.=0D
=0D
Before doing that, I'm simplifying the OBJECT_DECLARE* API to=0D
make it easier to use and more difficult to misuse.  The=0D
module_obj_name and ParentClassType parameters were removed=0D
because they are not needed.=0D
=0D
Eduardo Habkost (5):=0D
  scripts/codeconverter: Update to latest version=0D
  qom: Remove ParentClassType argument from OBJECT_DECLARE_SIMPLE_TYPE=0D
  qom: Remove module_obj_name parameter from OBJECT_DECLARE* macros=0D
  [automated] Use OBJECT_DECLARE_TYPE when possible=0D
  [automated] Use OBJECT_DECLARE_SIMPLE_TYPE when possible=0D
=0D
 hw/9pfs/virtio-9p.h                           |   4 +-=0D
 hw/audio/intel-hda.h                          |   6 +-=0D
 hw/display/ati_int.h                          |   4 +-=0D
 hw/display/qxl.h                              |   4 +-=0D
 hw/display/virtio-vga.h                       |   2 +-=0D
 hw/i386/amd_iommu.h                           |   4 +-=0D
 hw/misc/tmp105.h                              |   4 +-=0D
 hw/net/fsl_etsec/etsec.h                      |   3 +-=0D
 hw/net/tulip.h                                |   4 +-=0D
 hw/ppc/e500-ccsr.h                            |   4 +-=0D
 hw/ppc/e500.h                                 |   5 +-=0D
 hw/ppc/mac.h                                  |   4 +-=0D
 hw/s390x/ccw-device.h                         |   4 +-=0D
 hw/s390x/ipl.h                                |   4 +-=0D
 hw/s390x/s390-pci-bus.h                       |  16 +-=0D
 hw/s390x/virtio-ccw.h                         |  57 +-=0D
 hw/usb/ccid.h                                 |   5 +-=0D
 hw/usb/hcd-dwc2.h                             |   3 +-=0D
 hw/usb/hcd-ehci.h                             |  13 +-=0D
 hw/usb/hcd-ohci.h                             |   4 +-=0D
 hw/usb/hcd-xhci.h                             |   4 +-=0D
 hw/vfio/pci.h                                 |   4 +-=0D
 hw/virtio/virtio-pci.h                        |   5 +-=0D
 hw/xen/xen_pt.h                               |   4 +-=0D
 include/authz/base.h                          |   2 +-=0D
 include/authz/list.h                          |   4 +-=0D
 include/authz/listfile.h                      |   4 +-=0D
 include/authz/pamacct.h                       |   4 +-=0D
 include/authz/simple.h                        |   4 +-=0D
 include/block/throttle-groups.h               |   4 +-=0D
 include/chardev/char.h                        |   4 +-=0D
 include/crypto/secret_common.h                |   2 +-=0D
 include/crypto/secret_keyring.h               |   4 +-=0D
 include/hw/acpi/generic_event_device.h        |   4 +-=0D
 include/hw/acpi/vmgenid.h                     |   4 +-=0D
 include/hw/adc/stm32f2xx_adc.h                |   4 +-=0D
 include/hw/arm/allwinner-a10.h                |   4 +-=0D
 include/hw/arm/allwinner-h3.h                 |   4 +-=0D
 include/hw/arm/armsse.h                       |   2 +-=0D
 include/hw/arm/armv7m.h                       |   8 +-=0D
 include/hw/arm/aspeed_soc.h                   |   5 +-=0D
 include/hw/arm/bcm2835_peripherals.h          |   4 +-=0D
 include/hw/arm/bcm2836.h                      |   5 +-=0D
 include/hw/arm/digic.h                        |   4 +-=0D
 include/hw/arm/exynos4210.h                   |   4 +-=0D
 include/hw/arm/fsl-imx25.h                    |   4 +-=0D
 include/hw/arm/fsl-imx31.h                    |   4 +-=0D
 include/hw/arm/fsl-imx6.h                     |   4 +-=0D
 include/hw/arm/fsl-imx6ul.h                   |   4 +-=0D
 include/hw/arm/fsl-imx7.h                     |   4 +-=0D
 include/hw/arm/msf2-soc.h                     |   4 +-=0D
 include/hw/arm/nrf51_soc.h                    |   4 +-=0D
 include/hw/arm/omap.h                         |   4 +-=0D
 include/hw/arm/pxa.h                          |  15 +-=0D
 include/hw/arm/smmu-common.h                  |   5 +-=0D
 include/hw/arm/smmuv3.h                       |   5 +-=0D
 include/hw/arm/stm32f205_soc.h                |   4 +-=0D
 include/hw/arm/stm32f405_soc.h                |   4 +-=0D
 include/hw/arm/virt.h                         |   5 +-=0D
 include/hw/arm/xlnx-versal.h                  |   4 +-=0D
 include/hw/arm/xlnx-zynqmp.h                  |   4 +-=0D
 include/hw/block/flash.h                      |   8 +-=0D
 include/hw/block/swim.h                       |  12 +-=0D
 include/hw/boards.h                           |   3 +-=0D
 include/hw/char/avr_usart.h                   |   4 +-=0D
 include/hw/char/bcm2835_aux.h                 |   4 +-=0D
 include/hw/char/cadence_uart.h                |   4 +-=0D
 include/hw/char/cmsdk-apb-uart.h              |   4 +-=0D
 include/hw/char/digic-uart.h                  |   4 +-=0D
 include/hw/char/escc.h                        |   4 +-=0D
 include/hw/char/ibex_uart.h                   |   4 +-=0D
 include/hw/char/imx_serial.h                  |   4 +-=0D
 include/hw/char/nrf51_uart.h                  |   4 +-=0D
 include/hw/char/pl011.h                       |   4 +-=0D
 include/hw/char/serial.h                      |  11 +-=0D
 include/hw/char/stm32f2xx_usart.h             |   4 +-=0D
 include/hw/clock.h                            |   4 +-=0D
 include/hw/core/generic-loader.h              |   4 +-=0D
 include/hw/core/split-irq.h                   |   4 +-=0D
 include/hw/cpu/a15mpcore.h                    |   4 +-=0D
 include/hw/cpu/a9mpcore.h                     |   4 +-=0D
 include/hw/cpu/arm11mpcore.h                  |   4 +-=0D
 include/hw/cpu/cluster.h                      |   4 +-=0D
 include/hw/cpu/core.h                         |   4 +-=0D
 include/hw/display/bcm2835_fb.h               |   4 +-=0D
 include/hw/display/dpcd.h                     |   4 +-=0D
 include/hw/display/i2c-ddc.h                  |   4 +-=0D
 include/hw/display/macfb.h                    |   9 +-=0D
 include/hw/display/xlnx_dp.h                  |   4 +-=0D
 include/hw/dma/bcm2835_dma.h                  |   4 +-=0D
 include/hw/dma/i8257.h                        |   4 +-=0D
 include/hw/dma/pl080.h                        |   4 +-=0D
 include/hw/dma/xlnx-zdma.h                    |   4 +-=0D
 include/hw/dma/xlnx-zynq-devcfg.h             |   4 +-=0D
 include/hw/dma/xlnx_dpdma.h                   |   4 +-=0D
 include/hw/gpio/aspeed_gpio.h                 |   5 +-=0D
 include/hw/gpio/bcm2835_gpio.h                |   4 +-=0D
 include/hw/gpio/imx_gpio.h                    |   4 +-=0D
 include/hw/gpio/nrf51_gpio.h                  |   4 +-=0D
 include/hw/hyperv/vmbus-bridge.h              |   4 +-=0D
 include/hw/hyperv/vmbus.h                     |   6 +-=0D
 include/hw/i2c/aspeed_i2c.h                   |   5 +-=0D
 include/hw/i2c/i2c.h                          |   5 +-=0D
 include/hw/i2c/imx_i2c.h                      |   4 +-=0D
 include/hw/i2c/microbit_i2c.h                 |   4 +-=0D
 include/hw/i2c/ppc4xx_i2c.h                   |   4 +-=0D
 include/hw/i2c/smbus_slave.h                  |   2 +-=0D
 include/hw/i386/ich9.h                        |   4 +-=0D
 include/hw/i386/intel_iommu.h                 |   4 +-=0D
 include/hw/i386/ioapic_internal.h             |   5 +-=0D
 include/hw/i386/microvm.h                     |   5 +-=0D
 include/hw/i386/pc.h                          |   4 +-=0D
 include/hw/i386/x86-iommu.h                   |   5 +-=0D
 include/hw/i386/x86.h                         |   5 +-=0D
 include/hw/ide/ahci.h                         |  12 +-=0D
 include/hw/ide/internal.h                     |   8 +-=0D
 include/hw/ide/pci.h                          |   4 +-=0D
 include/hw/input/adb.h                        |   8 +-=0D
 include/hw/input/i8042.h                      |   4 +-=0D
 include/hw/intc/allwinner-a10-pic.h           |   4 +-=0D
 include/hw/intc/aspeed_vic.h                  |   4 +-=0D
 include/hw/intc/bcm2835_ic.h                  |   4 +-=0D
 include/hw/intc/bcm2836_control.h             |   4 +-=0D
 include/hw/intc/heathrow_pic.h                |   4 +-=0D
 include/hw/intc/ibex_plic.h                   |   4 +-=0D
 include/hw/intc/imx_avic.h                    |   4 +-=0D
 include/hw/intc/imx_gpcv2.h                   |   4 +-=0D
 include/hw/intc/mips_gic.h                    |   4 +-=0D
 include/hw/intc/realview_gic.h                |   4 +-=0D
 include/hw/intc/rx_icu.h                      |   4 +-=0D
 include/hw/intc/xlnx-pmu-iomod-intc.h         |   4 +-=0D
 include/hw/intc/xlnx-zynqmp-ipi.h             |   4 +-=0D
 include/hw/ipack/ipack.h                      |   6 +-=0D
 include/hw/ipmi/ipmi.h                        |   6 +-=0D
 include/hw/isa/i8259_internal.h               |   5 +-=0D
 include/hw/isa/isa.h                          |   7 +-=0D
 include/hw/isa/pc87312.h                      |   4 +-=0D
 include/hw/m68k/mcf_fec.h                     |   4 +-=0D
 include/hw/mem/nvdimm.h                       |   5 +-=0D
 include/hw/mem/pc-dimm.h                      |   2 +-=0D
 include/hw/mips/cps.h                         |   4 +-=0D
 include/hw/misc/a9scu.h                       |   4 +-=0D
 include/hw/misc/allwinner-cpucfg.h            |   4 +-=0D
 include/hw/misc/allwinner-h3-ccu.h            |   4 +-=0D
 include/hw/misc/allwinner-h3-dramc.h          |   4 +-=0D
 include/hw/misc/allwinner-h3-sysctrl.h        |   4 +-=0D
 include/hw/misc/allwinner-sid.h               |   4 +-=0D
 include/hw/misc/arm11scu.h                    |   4 +-=0D
 include/hw/misc/armsse-cpuid.h                |   4 +-=0D
 include/hw/misc/armsse-mhu.h                  |   4 +-=0D
 include/hw/misc/aspeed_scu.h                  |   5 +-=0D
 include/hw/misc/aspeed_sdmc.h                 |   5 +-=0D
 include/hw/misc/aspeed_xdma.h                 |   4 +-=0D
 include/hw/misc/auxbus.h                      |  11 +-=0D
 include/hw/misc/avr_power.h                   |   4 +-=0D
 include/hw/misc/bcm2835_mbox.h                |   4 +-=0D
 include/hw/misc/bcm2835_mphi.h                |   3 +-=0D
 include/hw/misc/bcm2835_property.h            |   4 +-=0D
 include/hw/misc/bcm2835_rng.h                 |   4 +-=0D
 include/hw/misc/bcm2835_thermal.h             |   4 +-=0D
 include/hw/misc/grlib_ahb_apb_pnp.h           |   8 +-=0D
 include/hw/misc/imx25_ccm.h                   |   4 +-=0D
 include/hw/misc/imx31_ccm.h                   |   4 +-=0D
 include/hw/misc/imx6_ccm.h                    |   4 +-=0D
 include/hw/misc/imx6_src.h                    |   4 +-=0D
 include/hw/misc/imx6ul_ccm.h                  |   4 +-=0D
 include/hw/misc/imx7_ccm.h                    |   8 +-=0D
 include/hw/misc/imx7_gpr.h                    |   4 +-=0D
 include/hw/misc/imx7_snvs.h                   |   4 +-=0D
 include/hw/misc/imx_ccm.h                     |   5 +-=0D
 include/hw/misc/imx_rngc.h                    |   4 +-=0D
 include/hw/misc/iotkit-secctl.h               |   4 +-=0D
 include/hw/misc/iotkit-sysctl.h               |   4 +-=0D
 include/hw/misc/iotkit-sysinfo.h              |   4 +-=0D
 include/hw/misc/mac_via.h                     |  12 +-=0D
 include/hw/misc/macio/cuda.h                  |   8 +-=0D
 include/hw/misc/macio/gpio.h                  |   4 +-=0D
 include/hw/misc/macio/macio.h                 |  20 +-=0D
 include/hw/misc/macio/pmu.h                   |   8 +-=0D
 include/hw/misc/max111x.h                     |   4 +-=0D
 include/hw/misc/mips_cmgcr.h                  |   4 +-=0D
 include/hw/misc/mips_cpc.h                    |   4 +-=0D
 include/hw/misc/mips_itu.h                    |   4 +-=0D
 include/hw/misc/mos6522.h                     |   5 +-=0D
 include/hw/misc/mps2-fpgaio.h                 |   4 +-=0D
 include/hw/misc/mps2-scc.h                    |   4 +-=0D
 include/hw/misc/msf2-sysreg.h                 |   4 +-=0D
 include/hw/misc/nrf51_rng.h                   |   4 +-=0D
 include/hw/misc/stm32f2xx_syscfg.h            |   4 +-=0D
 include/hw/misc/stm32f4xx_exti.h              |   4 +-=0D
 include/hw/misc/stm32f4xx_syscfg.h            |   4 +-=0D
 include/hw/misc/tz-mpc.h                      |   4 +-=0D
 include/hw/misc/tz-msc.h                      |   4 +-=0D
 include/hw/misc/tz-ppc.h                      |   4 +-=0D
 include/hw/misc/unimp.h                       |   4 +-=0D
 include/hw/misc/zynq-xadc.h                   |   4 +-=0D
 include/hw/net/allwinner-sun8i-emac.h         |   4 +-=0D
 include/hw/net/allwinner_emac.h               |   4 +-=0D
 include/hw/net/cadence_gem.h                  |   4 +-=0D
 include/hw/net/ftgmac100.h                    |   8 +-=0D
 include/hw/net/imx_fec.h                      |   4 +-=0D
 include/hw/net/msf2-emac.h                    |   4 +-=0D
 include/hw/nubus/mac-nubus-bridge.h           |   4 +-=0D
 include/hw/nubus/nubus.h                      |   8 +-=0D
 include/hw/nvram/fw_cfg.h                     |   9 +-=0D
 include/hw/nvram/nrf51_nvm.h                  |   4 +-=0D
 include/hw/pci-bridge/simba.h                 |   4 +-=0D
 include/hw/pci-host/designware.h              |   8 +-=0D
 include/hw/pci-host/gpex.h                    |   8 +-=0D
 include/hw/pci-host/i440fx.h                  |   4 +-=0D
 include/hw/pci-host/pnv_phb3.h                |   7 +-=0D
 include/hw/pci-host/pnv_phb4.h                |  11 +-=0D
 include/hw/pci-host/q35.h                     |   8 +-=0D
 include/hw/pci-host/sabre.h                   |   8 +-=0D
 include/hw/pci-host/spapr.h                   |   4 +-=0D
 include/hw/pci-host/uninorth.h                |   4 +-=0D
 include/hw/pci-host/xilinx-pcie.h             |   8 +-=0D
 include/hw/pci/pci.h                          |   4 +-=0D
 include/hw/pci/pci_bridge.h                   |   3 +-=0D
 include/hw/pci/pci_host.h                     |   4 +-=0D
 include/hw/pci/pcie_host.h                    |   3 +-=0D
 include/hw/pci/pcie_port.h                    |   6 +-=0D
 include/hw/pcmcia.h                           |   5 +-=0D
 include/hw/platform-bus.h                     |   4 +-=0D
 include/hw/ppc/mac_dbdma.h                    |   3 +-=0D
 include/hw/ppc/openpic.h                      |   4 +-=0D
 include/hw/ppc/pnv.h                          |   2 +-=0D
 include/hw/ppc/pnv_core.h                     |   6 +-=0D
 include/hw/ppc/pnv_homer.h                    |   2 +-=0D
 include/hw/ppc/pnv_occ.h                      |   2 +-=0D
 include/hw/ppc/pnv_pnor.h                     |   4 +-=0D
 include/hw/ppc/pnv_psi.h                      |  10 +-=0D
 include/hw/ppc/pnv_xive.h                     |   2 +-=0D
 include/hw/ppc/spapr.h                        |  13 +-=0D
 include/hw/ppc/spapr_cpu_core.h               |   2 +-=0D
 include/hw/ppc/spapr_tpm_proxy.h              |   4 +-=0D
 include/hw/ppc/spapr_vio.h                    |   6 +-=0D
 include/hw/ppc/xics.h                         |   2 +-=0D
 include/hw/ppc/xive.h                         |  14 +-=0D
 include/hw/qdev-core.h                        |   4 +-=0D
 include/hw/riscv/opentitan.h                  |   4 +-=0D
 include/hw/riscv/riscv_hart.h                 |   4 +-=0D
 include/hw/rtc/allwinner-rtc.h                |   5 +-=0D
 include/hw/rtc/aspeed_rtc.h                   |   4 +-=0D
 include/hw/rtc/goldfish_rtc.h                 |   4 +-=0D
 include/hw/rtc/mc146818rtc.h                  |   4 +-=0D
 include/hw/rtc/pl031.h                        |   4 +-=0D
 include/hw/rtc/xlnx-zynqmp-rtc.h              |   4 +-=0D
 include/hw/s390x/3270-ccw.h                   |   5 +-=0D
 include/hw/s390x/css-bridge.h                 |   8 +-=0D
 include/hw/s390x/event-facility.h             |   2 +-=0D
 include/hw/s390x/s390-virtio-ccw.h            |   5 +-=0D
 include/hw/s390x/s390_flic.h                  |   6 +-=0D
 include/hw/s390x/sclp.h                       |   2 +-=0D
 include/hw/s390x/storage-attributes.h         |   5 +-=0D
 include/hw/s390x/storage-keys.h               |   5 +-=0D
 include/hw/s390x/tod.h                        |   5 +-=0D
 include/hw/s390x/vfio-ccw.h                   |   4 +-=0D
 include/hw/scsi/esp.h                         |   4 +-=0D
 include/hw/scsi/scsi.h                        |   7 +-=0D
 include/hw/sd/allwinner-sdhost.h              |   5 +-=0D
 include/hw/sd/aspeed_sdhci.h                  |   4 +-=0D
 include/hw/sd/bcm2835_sdhost.h                |   4 +-=0D
 include/hw/sd/sd.h                            |   7 +-=0D
 include/hw/sparc/sparc32_dma.h                |  16 +-=0D
 include/hw/ssi/aspeed_smc.h                   |   5 +-=0D
 include/hw/ssi/imx_spi.h                      |   4 +-=0D
 include/hw/ssi/mss-spi.h                      |   4 +-=0D
 include/hw/ssi/pl022.h                        |   4 +-=0D
 include/hw/ssi/ssi.h                          |   2 +-=0D
 include/hw/ssi/stm32f2xx_spi.h                |   4 +-=0D
 include/hw/ssi/xilinx_spips.h                 |  11 +-=0D
 include/hw/sysbus.h                           |   2 +-=0D
 include/hw/timer/a9gtimer.h                   |   4 +-=0D
 include/hw/timer/allwinner-a10-pit.h          |   4 +-=0D
 include/hw/timer/arm_mptimer.h                |   4 +-=0D
 include/hw/timer/armv7m_systick.h             |   4 +-=0D
 include/hw/timer/aspeed_timer.h               |   5 +-=0D
 include/hw/timer/avr_timer16.h                |   4 +-=0D
 include/hw/timer/bcm2835_systmr.h             |   4 +-=0D
 include/hw/timer/cmsdk-apb-dualtimer.h        |   4 +-=0D
 include/hw/timer/cmsdk-apb-timer.h            |   4 +-=0D
 include/hw/timer/digic-timer.h                |   4 +-=0D
 include/hw/timer/i8254.h                      |   5 +-=0D
 include/hw/timer/imx_epit.h                   |   4 +-=0D
 include/hw/timer/mss-timer.h                  |   4 +-=0D
 include/hw/timer/nrf51_timer.h                |   4 +-=0D
 include/hw/usb.h                              |   8 +-=0D
 include/hw/usb/chipidea.h                     |   4 +-=0D
 include/hw/usb/imx-usb-phy.h                  |   4 +-=0D
 include/hw/virtio/vhost-scsi-common.h         |   4 +-=0D
 include/hw/virtio/vhost-scsi.h                |   4 +-=0D
 include/hw/virtio/vhost-user-blk.h            |   4 +-=0D
 include/hw/virtio/vhost-user-fs.h             |   4 +-=0D
 include/hw/virtio/vhost-user-scsi.h           |   4 +-=0D
 include/hw/virtio/vhost-user-vsock.h          |   4 +-=0D
 include/hw/virtio/vhost-vsock-common.h        |   4 +-=0D
 include/hw/virtio/vhost-vsock.h               |   4 +-=0D
 include/hw/virtio/virtio-balloon.h            |   4 +-=0D
 include/hw/virtio/virtio-blk.h                |   4 +-=0D
 include/hw/virtio/virtio-crypto.h             |   4 +-=0D
 include/hw/virtio/virtio-gpu-pci.h            |   4 +-=0D
 include/hw/virtio/virtio-gpu.h                |  10 +-=0D
 include/hw/virtio/virtio-input.h              |  14 +-=0D
 include/hw/virtio/virtio-iommu.h              |   4 +-=0D
 include/hw/virtio/virtio-mem.h                |   2 +-=0D
 include/hw/virtio/virtio-mmio.h               |   4 +-=0D
 include/hw/virtio/virtio-net.h                |   4 +-=0D
 include/hw/virtio/virtio-pmem.h               |   2 +-=0D
 include/hw/virtio/virtio-rng.h                |   4 +-=0D
 include/hw/virtio/virtio-scsi.h               |   8 +-=0D
 include/hw/virtio/virtio-serial.h             |   9 +-=0D
 include/hw/virtio/virtio.h                    |   4 +-=0D
 include/hw/watchdog/cmsdk-apb-watchdog.h      |   4 +-=0D
 include/hw/watchdog/wdt_aspeed.h              |   5 +-=0D
 include/hw/watchdog/wdt_imx2.h                |   4 +-=0D
 include/hw/xen/xen-block.h                    |  12 +-=0D
 include/hw/xen/xen-bus.h                      |   6 +-=0D
 include/io/channel-buffer.h                   |   4 +-=0D
 include/io/channel-command.h                  |   4 +-=0D
 include/io/channel-file.h                     |   4 +-=0D
 include/io/channel-socket.h                   |   4 +-=0D
 include/io/channel-tls.h                      |   4 +-=0D
 include/io/channel-websock.h                  |   4 +-=0D
 include/io/channel.h                          |   2 +-=0D
 include/io/dns-resolver.h                     |   4 +-=0D
 include/io/net-listener.h                     |   4 +-=0D
 include/net/can_emu.h                         |   3 +-=0D
 include/net/can_host.h                        |   5 +-=0D
 include/net/filter.h                          |   4 +-=0D
 include/qom/object.h                          |  20 +-=0D
 include/scsi/pr-manager.h                     |   2 +-=0D
 include/sysemu/cryptodev.h                    |   2 +-=0D
 include/sysemu/hostmem.h                      |   2 +-=0D
 include/sysemu/rng-random.h                   |   4 +-=0D
 include/sysemu/rng.h                          |   2 +-=0D
 include/sysemu/tpm_backend.h                  |   2 +-=0D
 include/sysemu/vhost-user-backend.h           |   4 +-=0D
 include/ui/console.h                          |   4 +-=0D
 target/alpha/cpu-qom.h                        |   2 +-=0D
 target/arm/cpu-qom.h                          |   2 +-=0D
 target/avr/cpu-qom.h                          |   2 +-=0D
 target/cris/cpu-qom.h                         |   2 +-=0D
 target/hppa/cpu-qom.h                         |   2 +-=0D
 target/i386/cpu-qom.h                         |   2 +-=0D
 target/lm32/cpu-qom.h                         |   2 +-=0D
 target/m68k/cpu-qom.h                         |   2 +-=0D
 target/microblaze/cpu-qom.h                   |   2 +-=0D
 target/mips/cpu-qom.h                         |   2 +-=0D
 target/moxie/cpu.h                            |   2 +-=0D
 target/nios2/cpu.h                            |   2 +-=0D
 target/openrisc/cpu.h                         |   2 +-=0D
 target/ppc/cpu-qom.h                          |   2 +-=0D
 target/riscv/cpu.h                            |   2 +-=0D
 target/rx/cpu-qom.h                           |   2 +-=0D
 target/s390x/cpu-qom.h                        |   2 +-=0D
 target/sh4/cpu-qom.h                          |   2 +-=0D
 target/sparc/cpu-qom.h                        |   2 +-=0D
 target/tilegx/cpu.h                           |   2 +-=0D
 target/tricore/cpu-qom.h                      |   2 +-=0D
 target/unicore32/cpu-qom.h                    |   2 +-=0D
 target/xtensa/cpu-qom.h                       |   2 +-=0D
 authz/list.c                                  |   1 -=0D
 authz/listfile.c                              |   1 -=0D
 authz/pamacct.c                               |   1 -=0D
 authz/simple.c                                |   1 -=0D
 backends/cryptodev-builtin.c                  |   5 +-=0D
 backends/cryptodev-vhost-user.c               |   4 +-=0D
 backends/dbus-vmstate.c                       |   5 +-=0D
 backends/hostmem-file.c                       |   4 +-=0D
 backends/hostmem-memfd.c                      |   4 +-=0D
 backends/rng-builtin.c                        |   4 +-=0D
 backends/rng-egd.c                            |   4 +-=0D
 backends/tpm/tpm_emulator.c                   |   4 +-=0D
 backends/tpm/tpm_passthrough.c                |   4 +-=0D
 backends/vhost-user.c                         |   1 -=0D
 crypto/secret_keyring.c                       |   1 -=0D
 hw/acpi/piix4.c                               |   4 +-=0D
 hw/alpha/typhoon.c                            |   4 +-=0D
 hw/arm/collie.c                               |   4 +-=0D
 hw/arm/highbank.c                             |   4 +-=0D
 hw/arm/integratorcp.c                         |  12 +-=0D
 hw/arm/microbit.c                             |   4 +-=0D
 hw/arm/mps2-tz.c                              |   5 +-=0D
 hw/arm/mps2.c                                 |   5 +-=0D
 hw/arm/musca.c                                |   5 +-=0D
 hw/arm/musicpal.c                             |  32 +-=0D
 hw/arm/palm.c                                 |   4 +-=0D
 hw/arm/pxa2xx.c                               |  12 +-=0D
 hw/arm/pxa2xx_gpio.c                          |   4 +-=0D
 hw/arm/pxa2xx_pic.c                           |   4 +-=0D
 hw/arm/sbsa-ref.c                             |   4 +-=0D
 hw/arm/spitz.c                                |  25 +-=0D
 hw/arm/stellaris.c                            |   8 +-=0D
 hw/arm/strongarm.c                            |  24 +-=0D
 hw/arm/tosa.c                                 |   8 +-=0D
 hw/arm/versatilepb.c                          |   4 +-=0D
 hw/arm/vexpress.c                             |   5 +-=0D
 hw/arm/xilinx_zynq.c                          |   4 +-=0D
 hw/arm/xlnx-versal-virt.c                     |   4 +-=0D
 hw/arm/xlnx-zcu102.c                          |   4 +-=0D
 hw/arm/z2.c                                   |   8 +-=0D
 hw/audio/ac97.c                               |   4 +-=0D
 hw/audio/adlib.c                              |   4 +-=0D
 hw/audio/es1370.c                             |   3 +-=0D
 hw/audio/gus.c                                |   4 +-=0D
 hw/audio/hda-codec.c                          |   3 +-=0D
 hw/audio/marvell_88w8618.c                    |   4 +-=0D
 hw/audio/milkymist-ac97.c                     |   4 +-=0D
 hw/audio/pcspk.c                              |   4 +-=0D
 hw/audio/pl041.c                              |   4 +-=0D
 hw/audio/sb16.c                               |   4 +-=0D
 hw/audio/wm8750.c                             |   4 +-=0D
 hw/block/fdc.c                                |  16 +-=0D
 hw/block/m25p80.c                             |   5 +-=0D
 hw/block/nand.c                               |   3 +-=0D
 hw/block/onenand.c                            |   4 +-=0D
 hw/char/debugcon.c                            |   4 +-=0D
 hw/char/exynos4210_uart.c                     |   4 +-=0D
 hw/char/grlib_apbuart.c                       |   4 +-=0D
 hw/char/ipoctal232.c                          |   3 +-=0D
 hw/char/lm32_juart.c                          |   4 +-=0D
 hw/char/lm32_uart.c                           |   4 +-=0D
 hw/char/mcf_uart.c                            |   4 +-=0D
 hw/char/milkymist-uart.c                      |   4 +-=0D
 hw/char/parallel.c                            |   4 +-=0D
 hw/char/serial-isa.c                          |   4 +-=0D
 hw/char/serial-pci.c                          |   4 +-=0D
 hw/char/spapr_vty.c                           |   4 +-=0D
 hw/char/xilinx_uartlite.c                     |   4 +-=0D
 hw/cpu/realview_mpcore.c                      |   4 +-=0D
 hw/display/ads7846.c                          |   4 +-=0D
 hw/display/artist.c                           |   4 +-=0D
 hw/display/bochs-display.c                    |   4 +-=0D
 hw/display/cg3.c                              |   4 +-=0D
 hw/display/cirrus_vga.c                       |   4 +-=0D
 hw/display/cirrus_vga_isa.c                   |   4 +-=0D
 hw/display/exynos4210_fimd.c                  |   4 +-=0D
 hw/display/g364fb.c                           |   4 +-=0D
 hw/display/jazz_led.c                         |   4 +-=0D
 hw/display/milkymist-tmu2.c                   |   4 +-=0D
 hw/display/milkymist-vgafb.c                  |   4 +-=0D
 hw/display/next-fb.c                          |   4 +-=0D
 hw/display/pl110.c                            |   4 +-=0D
 hw/display/sii9022.c                          |   4 +-=0D
 hw/display/sm501.c                            |   8 +-=0D
 hw/display/ssd0303.c                          |   4 +-=0D
 hw/display/ssd0323.c                          |   4 +-=0D
 hw/display/tcx.c                              |   4 +-=0D
 hw/display/vga-isa.c                          |   4 +-=0D
 hw/display/vga-pci.c                          |   4 +-=0D
 hw/dma/i82374.c                               |   4 +-=0D
 hw/dma/pl330.c                                |   3 +-=0D
 hw/dma/puv3_dma.c                             |   4 +-=0D
 hw/dma/pxa2xx_dma.c                           |   4 +-=0D
 hw/dma/rc4030.c                               |   4 +-=0D
 hw/dma/xilinx_axidma.c                        |   4 +-=0D
 hw/gpio/gpio_key.c                            |   4 +-=0D
 hw/gpio/max7310.c                             |   4 +-=0D
 hw/gpio/mpc8xxx.c                             |   4 +-=0D
 hw/gpio/pl061.c                               |   4 +-=0D
 hw/gpio/puv3_gpio.c                           |   4 +-=0D
 hw/gpio/zaurus.c                              |   4 +-=0D
 hw/hppa/dino.c                                |   4 +-=0D
 hw/hppa/lasi.c                                |   4 +-=0D
 hw/hyperv/hyperv.c                            |   4 +-=0D
 hw/hyperv/hyperv_testdev.c                    |   4 +-=0D
 hw/i2c/bitbang_i2c.c                          |   4 +-=0D
 hw/i2c/exynos4210_i2c.c                       |   4 +-=0D
 hw/i2c/mpc_i2c.c                              |   4 +-=0D
 hw/i2c/smbus_eeprom.c                         |   4 +-=0D
 hw/i2c/smbus_ich9.c                           |   4 +-=0D
 hw/i386/kvm/clock.c                           |   4 +-=0D
 hw/i386/kvmvapic.c                            |   4 +-=0D
 hw/i386/port92.c                              |   4 +-=0D
 hw/i386/vmmouse.c                             |   4 +-=0D
 hw/i386/vmport.c                              |   4 +-=0D
 hw/i386/xen/xen_platform.c                    |   4 +-=0D
 hw/i386/xen/xen_pvdevice.c                    |   4 +-=0D
 hw/ide/isa.c                                  |   4 +-=0D
 hw/ide/microdrive.c                           |   4 +-=0D
 hw/ide/sii3112.c                              |   4 +-=0D
 hw/input/adb-kbd.c                            |   5 +-=0D
 hw/input/adb-mouse.c                          |   5 +-=0D
 hw/input/lm832x.c                             |   4 +-=0D
 hw/input/milkymist-softusb.c                  |   4 +-=0D
 hw/input/pl050.c                              |   4 +-=0D
 hw/intc/arm_gicv2m.c                          |   4 +-=0D
 hw/intc/exynos4210_combiner.c                 |   4 +-=0D
 hw/intc/exynos4210_gic.c                      |   8 +-=0D
 hw/intc/grlib_irqmp.c                         |   4 +-=0D
 hw/intc/lm32_pic.c                            |   4 +-=0D
 hw/intc/nios2_iic.c                           |   4 +-=0D
 hw/intc/ompic.c                               |   4 +-=0D
 hw/intc/openpic_kvm.c                         |   4 +-=0D
 hw/intc/pl190.c                               |   4 +-=0D
 hw/intc/puv3_intc.c                           |   4 +-=0D
 hw/intc/slavio_intctl.c                       |   4 +-=0D
 hw/ipack/tpci200.c                            |   4 +-=0D
 hw/ipmi/ipmi_bmc_extern.c                     |   4 +-=0D
 hw/ipmi/isa_ipmi_bt.c                         |   4 +-=0D
 hw/ipmi/isa_ipmi_kcs.c                        |   4 +-=0D
 hw/ipmi/pci_ipmi_bt.c                         |   4 +-=0D
 hw/ipmi/pci_ipmi_kcs.c                        |   4 +-=0D
 hw/ipmi/smbus_ipmi.c                          |   4 +-=0D
 hw/isa/i82378.c                               |   4 +-=0D
 hw/isa/piix4.c                                |   4 +-=0D
 hw/isa/vt82c686.c                             |  16 +-=0D
 hw/m68k/mcf_intc.c                            |   4 +-=0D
 hw/m68k/next-cube.c                           |   4 +-=0D
 hw/m68k/next-kbd.c                            |   4 +-=0D
 hw/microblaze/xlnx-zynqmp-pmu.c               |   4 +-=0D
 hw/mips/gt64xxx_pci.c                         |   4 +-=0D
 hw/mips/malta.c                               |   4 +-=0D
 hw/misc/applesmc.c                            |   4 +-=0D
 hw/misc/arm_integrator_debug.c                |   4 +-=0D
 hw/misc/arm_l2x0.c                            |   4 +-=0D
 hw/misc/arm_sysctl.c                          |   4 +-=0D
 hw/misc/debugexit.c                           |   4 +-=0D
 hw/misc/eccmemctl.c                           |   4 +-=0D
 hw/misc/empty_slot.c                          |   4 +-=0D
 hw/misc/exynos4210_clk.c                      |   4 +-=0D
 hw/misc/exynos4210_pmu.c                      |   4 +-=0D
 hw/misc/exynos4210_rng.c                      |   4 +-=0D
 hw/misc/milkymist-hpdmc.c                     |   4 +-=0D
 hw/misc/milkymist-pfpu.c                      |   4 +-=0D
 hw/misc/mst_fpga.c                            |   4 +-=0D
 hw/misc/pc-testdev.c                          |   4 +-=0D
 hw/misc/pci-testdev.c                         |   4 +-=0D
 hw/misc/puv3_pm.c                             |   4 +-=0D
 hw/misc/sga.c                                 |   4 +-=0D
 hw/misc/slavio_misc.c                         |   4 +-=0D
 hw/misc/tmp421.c                              |   5 +-=0D
 hw/misc/zynq_slcr.c                           |   4 +-=0D
 hw/net/dp8393x.c                              |   4 +-=0D
 hw/net/e1000e.c                               |   4 +-=0D
 hw/net/etraxfs_eth.c                          |   4 +-=0D
 hw/net/lan9118.c                              |   4 +-=0D
 hw/net/milkymist-minimac2.c                   |   4 +-=0D
 hw/net/mipsnet.c                              |   4 +-=0D
 hw/net/ne2000-isa.c                           |   4 +-=0D
 hw/net/opencores_eth.c                        |   4 +-=0D
 hw/net/pcnet-pci.c                            |   4 +-=0D
 hw/net/rtl8139.c                              |   4 +-=0D
 hw/net/smc91c111.c                            |   4 +-=0D
 hw/net/spapr_llan.c                           |   4 +-=0D
 hw/net/stellaris_enet.c                       |   4 +-=0D
 hw/net/sungem.c                               |   4 +-=0D
 hw/net/sunhme.c                               |   4 +-=0D
 hw/net/xgmac.c                                |   4 +-=0D
 hw/net/xilinx_axienet.c                       |   4 +-=0D
 hw/nvram/ds1225y.c                            |   4 +-=0D
 hw/nvram/spapr_nvram.c                        |   4 +-=0D
 hw/pci-bridge/dec.c                           |   4 +-=0D
 hw/pci-bridge/gen_pcie_root_port.c            |   4 +-=0D
 hw/pci-bridge/pci_bridge_dev.c                |   4 +-=0D
 hw/pci-bridge/pcie_pci_bridge.c               |   4 +-=0D
 hw/pci-host/bonito.c                          |   6 +-=0D
 hw/pci-host/grackle.c                         |   4 +-=0D
 hw/pci-host/i440fx.c                          |   4 +-=0D
 hw/pci-host/ppce500.c                         |   8 +-=0D
 hw/pci-host/prep.c                            |   4 +-=0D
 hw/ppc/mpc8544_guts.c                         |   4 +-=0D
 hw/ppc/ppc440_pcix.c                          |   4 +-=0D
 hw/ppc/ppc440_uc.c                            |   4 +-=0D
 hw/ppc/ppc4xx_pci.c                           |   4 +-=0D
 hw/ppc/ppce500_spin.c                         |   4 +-=0D
 hw/ppc/prep_systemio.c                        |   4 +-=0D
 hw/ppc/rs6000_mc.c                            |   4 +-=0D
 hw/ppc/spapr_rng.c                            |   4 +-=0D
 hw/rtc/ds1338.c                               |   4 +-=0D
 hw/rtc/exynos4210_rtc.c                       |   4 +-=0D
 hw/rtc/m41t80.c                               |   4 +-=0D
 hw/rtc/sun4v-rtc.c                            |   4 +-=0D
 hw/rtc/twl92230.c                             |   4 +-=0D
 hw/scsi/lsi53c895a.c                          |   4 +-=0D
 hw/scsi/scsi-disk.c                           |   5 +-=0D
 hw/scsi/spapr_vscsi.c                         |   4 +-=0D
 hw/scsi/vmw_pvscsi.c                          |   5 +-=0D
 hw/sd/milkymist-memcard.c                     |   4 +-=0D
 hw/sd/pl181.c                                 |   4 +-=0D
 hw/sd/ssi-sd.c                                |   4 +-=0D
 hw/sh4/sh_pci.c                               |   4 +-=0D
 hw/sparc/sun4m.c                              |   8 +-=0D
 hw/sparc64/sun4u.c                            |   8 +-=0D
 hw/ssi/ssi.c                                  |   3 +-=0D
 hw/ssi/xilinx_spi.c                           |   4 +-=0D
 hw/timer/altera_timer.c                       |   4 +-=0D
 hw/timer/arm_timer.c                          |   8 +-=0D
 hw/timer/cadence_ttc.c                        |   4 +-=0D
 hw/timer/exynos4210_mct.c                     |   4 +-=0D
 hw/timer/exynos4210_pwm.c                     |   4 +-=0D
 hw/timer/grlib_gptimer.c                      |   4 +-=0D
 hw/timer/hpet.c                               |   4 +-=0D
 hw/timer/lm32_timer.c                         |   4 +-=0D
 hw/timer/milkymist-sysctl.c                   |   4 +-=0D
 hw/timer/puv3_ost.c                           |   4 +-=0D
 hw/timer/pxa2xx_timer.c                       |   4 +-=0D
 hw/timer/slavio_timer.c                       |   4 +-=0D
 hw/tpm/tpm_tis_isa.c                          |   4 +-=0D
 hw/tpm/tpm_tis_sysbus.c                       |   4 +-=0D
 hw/usb/dev-audio.c                            |   4 +-=0D
 hw/usb/dev-hid.c                              |   4 +-=0D
 hw/usb/dev-hub.c                              |   4 +-=0D
 hw/usb/dev-mtp.c                              |   3 +-=0D
 hw/usb/dev-network.c                          |   4 +-=0D
 hw/usb/dev-serial.c                           |   4 +-=0D
 hw/usb/dev-smartcard-reader.c                 |   7 +-=0D
 hw/usb/dev-uas.c                              |   3 +-=0D
 hw/usb/dev-wacom.c                            |   4 +-=0D
 hw/usb/hcd-ohci-pci.c                         |   4 +-=0D
 hw/usb/host-libusb.c                          |   4 +-=0D
 hw/usb/tusb6010.c                             |   4 +-=0D
 hw/vfio/ap.c                                  |   4 +-=0D
 hw/virtio/virtio-input-pci.c                  |   8 +-=0D
 hw/watchdog/wdt_i6300esb.c                    |   4 +-=0D
 io/dns-resolver.c                             |   1 -=0D
 io/net-listener.c                             |   1 -=0D
 migration/rdma.c                              |   4 +-=0D
 net/can/can_socketcan.c                       |   4 +-=0D
 net/dump.c                                    |   4 +-=0D
 net/filter-buffer.c                           |   4 +-=0D
 net/filter-replay.c                           |   4 +-=0D
 net/filter-rewriter.c                         |   4 +-=0D
 scsi/pr-manager-helper.c                      |   4 +-=0D
 target/i386/sev.c                             |   4 +-=0D
 ui/input-barrier.c                            |   5 +-=0D
 ui/input-linux.c                              |   5 +-=0D
 .../codeconverter/codeconverter/patching.py   | 193 +++--=0D
 .../codeconverter/codeconverter/qom_macros.py | 327 ++++++--=0D
 .../codeconverter/qom_type_info.py            | 741 +++++++++++++++---=0D
 .../codeconverter/test_patching.py            |   3 +-=0D
 .../codeconverter/test_regexps.py             |  26 +-=0D
 scripts/codeconverter/converter.py            |  12 +-=0D
 634 files changed, 1828 insertions(+), 2401 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


