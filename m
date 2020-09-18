Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87676C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD09C2158C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDr2XdCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD09C2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOId-0004t0-RN
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNI2-0002bg-Mh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNHt-0006Es-22
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zp/k9FxxlqDCsTfVVoxGu73WkHXFFZEdIvINJVoJUYc=;
 b=HDr2XdCU4cEj6OsrqrmyzNsUtSPtG5Vw8H9sxVs8n/WFm4HqibY6Qs+QTIxyS7F8iwYn9s
 C7QrjH/I/xlKZM0PTiXbrhYcytizCGFtCy6SyX/fiqIiLznAIateSZEjWFNmoqbH9TSZX7
 cfRHp54bLp3qPIY+k4CaeVNcasJ2Jj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-HqlAiJA6NcaOi05lwfx-TQ-1; Fri, 18 Sep 2020 16:47:16 -0400
X-MC-Unique: HqlAiJA6NcaOi05lwfx-TQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9CFC10074BF;
 Fri, 18 Sep 2020 20:47:15 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3991A5DEBF;
 Fri, 18 Sep 2020 20:47:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 00/17] QOM queue, 2020-09-18
Date: Fri, 18 Sep 2020 16:46:57 -0400
Message-Id: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 053a4177817db307ec854356e95b5b350800a216:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' into staging (2020-09-18 16:34:26 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 8063396bf3459a810d24e3efd6110b8480f0de5b:

  Use OBJECT_DECLARE_SIMPLE_TYPE when possible (2020-09-18 14:12:32 -0400)

----------------------------------------------------------------
QOM queue, 2020-09-18

Fixes:
* Error value corrections (Markus Armbruster)
* Correct object_class_dynamic_cast_assert() documentation (Eduardo Habkost)
* Ensure objects using QEMU_ALIGNED are properly aligned (Richard Henderson)

QOM cleanups (Eduardo Habkost):
* Rename some constants
* Simplify parameters of OBJECT_DECLARE* macros
* Additional DECLARE_*CHECKER* usage
* Additional OBJECT_DECLARE_TYPE usage
* Additional OBJECT_DECLARE_SIMPLE_TYPE usage

----------------------------------------------------------------

Eduardo Habkost (10):
  sifive_e: Rename memmap enum constants
  sifive_u: Rename memmap enum constants
  sifive: Move QOM typedefs and add missing includes
  sifive: Use DECLARE_*CHECKER* macros
  qom: Correct object_class_dynamic_cast_assert() documentation
  scripts/codeconverter: Update to latest version
  qom: Remove ParentClassType argument from OBJECT_DECLARE_SIMPLE_TYPE
  qom: Remove module_obj_name parameter from OBJECT_DECLARE* macros
  Use OBJECT_DECLARE_TYPE when possible
  Use OBJECT_DECLARE_SIMPLE_TYPE when possible

Markus Armbruster (2):
  qom: Clean up object_property_get_enum()'s error value
  qom: Correct error values in two contracts

Richard Henderson (5):
  qom: Allow objects to be allocated with increased alignment
  target/arm: Set instance_align on CPUARM TypeInfo
  target/ppc: Set instance_align on PowerPCCPU TypeInfo
  target/riscv: Set instance_align on RISCVCPU TypeInfo
  target/s390x: Set instance_align on S390CPU TypeInfo

 hw/9pfs/virtio-9p.h                           |   4 +-
 hw/audio/intel-hda.h                          |   6 +-
 hw/display/ati_int.h                          |   4 +-
 hw/display/qxl.h                              |   4 +-
 hw/display/virtio-vga.h                       |   2 +-
 hw/i386/amd_iommu.h                           |   4 +-
 hw/intc/sifive_plic.h                         |  10 +-
 hw/misc/tmp105.h                              |   4 +-
 hw/net/fsl_etsec/etsec.h                      |   3 +-
 hw/net/tulip.h                                |   4 +-
 hw/ppc/e500-ccsr.h                            |   4 +-
 hw/ppc/e500.h                                 |   5 +-
 hw/ppc/mac.h                                  |   4 +-
 hw/s390x/ccw-device.h                         |   4 +-
 hw/s390x/ipl.h                                |   4 +-
 hw/s390x/s390-pci-bus.h                       |  16 +-
 hw/s390x/virtio-ccw.h                         |  57 +-
 hw/usb/ccid.h                                 |   5 +-
 hw/usb/hcd-dwc2.h                             |   3 +-
 hw/usb/hcd-ehci.h                             |  13 +-
 hw/usb/hcd-ohci.h                             |   4 +-
 hw/usb/hcd-xhci.h                             |   4 +-
 hw/vfio/pci.h                                 |   4 +-
 hw/virtio/virtio-pci.h                        |   5 +-
 hw/xen/xen_pt.h                               |   4 +-
 include/authz/base.h                          |   2 +-
 include/authz/list.h                          |   4 +-
 include/authz/listfile.h                      |   4 +-
 include/authz/pamacct.h                       |   4 +-
 include/authz/simple.h                        |   4 +-
 include/block/throttle-groups.h               |   4 +-
 include/chardev/char.h                        |   4 +-
 include/crypto/secret_common.h                |   2 +-
 include/crypto/secret_keyring.h               |   4 +-
 include/hw/acpi/generic_event_device.h        |   4 +-
 include/hw/acpi/vmgenid.h                     |   4 +-
 include/hw/adc/stm32f2xx_adc.h                |   4 +-
 include/hw/arm/allwinner-a10.h                |   4 +-
 include/hw/arm/allwinner-h3.h                 |   4 +-
 include/hw/arm/armsse.h                       |   2 +-
 include/hw/arm/armv7m.h                       |   8 +-
 include/hw/arm/aspeed_soc.h                   |   5 +-
 include/hw/arm/bcm2835_peripherals.h          |   4 +-
 include/hw/arm/bcm2836.h                      |   5 +-
 include/hw/arm/digic.h                        |   4 +-
 include/hw/arm/exynos4210.h                   |   4 +-
 include/hw/arm/fsl-imx25.h                    |   4 +-
 include/hw/arm/fsl-imx31.h                    |   4 +-
 include/hw/arm/fsl-imx6.h                     |   4 +-
 include/hw/arm/fsl-imx6ul.h                   |   4 +-
 include/hw/arm/fsl-imx7.h                     |   4 +-
 include/hw/arm/msf2-soc.h                     |   4 +-
 include/hw/arm/nrf51_soc.h                    |   4 +-
 include/hw/arm/omap.h                         |   4 +-
 include/hw/arm/pxa.h                          |  15 +-
 include/hw/arm/smmu-common.h                  |   5 +-
 include/hw/arm/smmuv3.h                       |   5 +-
 include/hw/arm/stm32f205_soc.h                |   4 +-
 include/hw/arm/stm32f405_soc.h                |   4 +-
 include/hw/arm/virt.h                         |   5 +-
 include/hw/arm/xlnx-versal.h                  |   4 +-
 include/hw/arm/xlnx-zynqmp.h                  |   4 +-
 include/hw/block/flash.h                      |   8 +-
 include/hw/block/swim.h                       |  12 +-
 include/hw/boards.h                           |   3 +-
 include/hw/char/avr_usart.h                   |   4 +-
 include/hw/char/bcm2835_aux.h                 |   4 +-
 include/hw/char/cadence_uart.h                |   4 +-
 include/hw/char/cmsdk-apb-uart.h              |   4 +-
 include/hw/char/digic-uart.h                  |   4 +-
 include/hw/char/escc.h                        |   4 +-
 include/hw/char/ibex_uart.h                   |   4 +-
 include/hw/char/imx_serial.h                  |   4 +-
 include/hw/char/nrf51_uart.h                  |   4 +-
 include/hw/char/pl011.h                       |   4 +-
 include/hw/char/serial.h                      |  11 +-
 include/hw/char/sifive_uart.h                 |  10 +-
 include/hw/char/stm32f2xx_usart.h             |   4 +-
 include/hw/clock.h                            |   4 +-
 include/hw/core/generic-loader.h              |   4 +-
 include/hw/core/split-irq.h                   |   4 +-
 include/hw/cpu/a15mpcore.h                    |   4 +-
 include/hw/cpu/a9mpcore.h                     |   4 +-
 include/hw/cpu/arm11mpcore.h                  |   4 +-
 include/hw/cpu/cluster.h                      |   4 +-
 include/hw/cpu/core.h                         |   4 +-
 include/hw/display/bcm2835_fb.h               |   4 +-
 include/hw/display/dpcd.h                     |   4 +-
 include/hw/display/i2c-ddc.h                  |   4 +-
 include/hw/display/macfb.h                    |   9 +-
 include/hw/display/xlnx_dp.h                  |   4 +-
 include/hw/dma/bcm2835_dma.h                  |   4 +-
 include/hw/dma/i8257.h                        |   4 +-
 include/hw/dma/pl080.h                        |   4 +-
 include/hw/dma/xlnx-zdma.h                    |   4 +-
 include/hw/dma/xlnx-zynq-devcfg.h             |   4 +-
 include/hw/dma/xlnx_dpdma.h                   |   4 +-
 include/hw/gpio/aspeed_gpio.h                 |   5 +-
 include/hw/gpio/bcm2835_gpio.h                |   4 +-
 include/hw/gpio/imx_gpio.h                    |   4 +-
 include/hw/gpio/nrf51_gpio.h                  |   4 +-
 include/hw/gpio/sifive_gpio.h                 |   9 +-
 include/hw/hyperv/vmbus-bridge.h              |   4 +-
 include/hw/hyperv/vmbus.h                     |   6 +-
 include/hw/i2c/aspeed_i2c.h                   |   5 +-
 include/hw/i2c/i2c.h                          |   5 +-
 include/hw/i2c/imx_i2c.h                      |   4 +-
 include/hw/i2c/microbit_i2c.h                 |   4 +-
 include/hw/i2c/ppc4xx_i2c.h                   |   4 +-
 include/hw/i2c/smbus_slave.h                  |   2 +-
 include/hw/i386/ich9.h                        |   4 +-
 include/hw/i386/intel_iommu.h                 |   4 +-
 include/hw/i386/ioapic_internal.h             |   5 +-
 include/hw/i386/microvm.h                     |   5 +-
 include/hw/i386/pc.h                          |   4 +-
 include/hw/i386/x86-iommu.h                   |   5 +-
 include/hw/i386/x86.h                         |   5 +-
 include/hw/ide/ahci.h                         |  12 +-
 include/hw/ide/internal.h                     |   8 +-
 include/hw/ide/pci.h                          |   4 +-
 include/hw/input/adb.h                        |   8 +-
 include/hw/input/i8042.h                      |   4 +-
 include/hw/intc/allwinner-a10-pic.h           |   4 +-
 include/hw/intc/aspeed_vic.h                  |   4 +-
 include/hw/intc/bcm2835_ic.h                  |   4 +-
 include/hw/intc/bcm2836_control.h             |   4 +-
 include/hw/intc/heathrow_pic.h                |   4 +-
 include/hw/intc/ibex_plic.h                   |   4 +-
 include/hw/intc/imx_avic.h                    |   4 +-
 include/hw/intc/imx_gpcv2.h                   |   4 +-
 include/hw/intc/mips_gic.h                    |   4 +-
 include/hw/intc/realview_gic.h                |   4 +-
 include/hw/intc/rx_icu.h                      |   4 +-
 include/hw/intc/xlnx-pmu-iomod-intc.h         |   4 +-
 include/hw/intc/xlnx-zynqmp-ipi.h             |   4 +-
 include/hw/ipack/ipack.h                      |   6 +-
 include/hw/ipmi/ipmi.h                        |   6 +-
 include/hw/isa/i8259_internal.h               |   5 +-
 include/hw/isa/isa.h                          |   7 +-
 include/hw/isa/pc87312.h                      |   4 +-
 include/hw/m68k/mcf_fec.h                     |   4 +-
 include/hw/mem/nvdimm.h                       |   5 +-
 include/hw/mem/pc-dimm.h                      |   2 +-
 include/hw/mips/cps.h                         |   4 +-
 include/hw/misc/a9scu.h                       |   4 +-
 include/hw/misc/allwinner-cpucfg.h            |   4 +-
 include/hw/misc/allwinner-h3-ccu.h            |   4 +-
 include/hw/misc/allwinner-h3-dramc.h          |   4 +-
 include/hw/misc/allwinner-h3-sysctrl.h        |   4 +-
 include/hw/misc/allwinner-sid.h               |   4 +-
 include/hw/misc/arm11scu.h                    |   4 +-
 include/hw/misc/armsse-cpuid.h                |   4 +-
 include/hw/misc/armsse-mhu.h                  |   4 +-
 include/hw/misc/aspeed_scu.h                  |   5 +-
 include/hw/misc/aspeed_sdmc.h                 |   5 +-
 include/hw/misc/aspeed_xdma.h                 |   4 +-
 include/hw/misc/auxbus.h                      |  11 +-
 include/hw/misc/avr_power.h                   |   4 +-
 include/hw/misc/bcm2835_mbox.h                |   4 +-
 include/hw/misc/bcm2835_mphi.h                |   3 +-
 include/hw/misc/bcm2835_property.h            |   4 +-
 include/hw/misc/bcm2835_rng.h                 |   4 +-
 include/hw/misc/bcm2835_thermal.h             |   4 +-
 include/hw/misc/grlib_ahb_apb_pnp.h           |   8 +-
 include/hw/misc/imx25_ccm.h                   |   4 +-
 include/hw/misc/imx31_ccm.h                   |   4 +-
 include/hw/misc/imx6_ccm.h                    |   4 +-
 include/hw/misc/imx6_src.h                    |   4 +-
 include/hw/misc/imx6ul_ccm.h                  |   4 +-
 include/hw/misc/imx7_ccm.h                    |   8 +-
 include/hw/misc/imx7_gpr.h                    |   4 +-
 include/hw/misc/imx7_snvs.h                   |   4 +-
 include/hw/misc/imx_ccm.h                     |   5 +-
 include/hw/misc/imx_rngc.h                    |   4 +-
 include/hw/misc/iotkit-secctl.h               |   4 +-
 include/hw/misc/iotkit-sysctl.h               |   4 +-
 include/hw/misc/iotkit-sysinfo.h              |   4 +-
 include/hw/misc/mac_via.h                     |  12 +-
 include/hw/misc/macio/cuda.h                  |   8 +-
 include/hw/misc/macio/gpio.h                  |   4 +-
 include/hw/misc/macio/macio.h                 |  20 +-
 include/hw/misc/macio/pmu.h                   |   8 +-
 include/hw/misc/max111x.h                     |   4 +-
 include/hw/misc/mips_cmgcr.h                  |   4 +-
 include/hw/misc/mips_cpc.h                    |   4 +-
 include/hw/misc/mips_itu.h                    |   4 +-
 include/hw/misc/mos6522.h                     |   5 +-
 include/hw/misc/mps2-fpgaio.h                 |   4 +-
 include/hw/misc/mps2-scc.h                    |   4 +-
 include/hw/misc/msf2-sysreg.h                 |   4 +-
 include/hw/misc/nrf51_rng.h                   |   4 +-
 include/hw/misc/sifive_e_prci.h               |  10 +-
 include/hw/misc/sifive_test.h                 |  10 +-
 include/hw/misc/sifive_u_otp.h                |  10 +-
 include/hw/misc/sifive_u_prci.h               |  10 +-
 include/hw/misc/stm32f2xx_syscfg.h            |   4 +-
 include/hw/misc/stm32f4xx_exti.h              |   4 +-
 include/hw/misc/stm32f4xx_syscfg.h            |   4 +-
 include/hw/misc/tz-mpc.h                      |   4 +-
 include/hw/misc/tz-msc.h                      |   4 +-
 include/hw/misc/tz-ppc.h                      |   4 +-
 include/hw/misc/unimp.h                       |   4 +-
 include/hw/misc/zynq-xadc.h                   |   4 +-
 include/hw/net/allwinner-sun8i-emac.h         |   4 +-
 include/hw/net/allwinner_emac.h               |   4 +-
 include/hw/net/cadence_gem.h                  |   4 +-
 include/hw/net/ftgmac100.h                    |   8 +-
 include/hw/net/imx_fec.h                      |   4 +-
 include/hw/net/msf2-emac.h                    |   4 +-
 include/hw/nubus/mac-nubus-bridge.h           |   4 +-
 include/hw/nubus/nubus.h                      |   8 +-
 include/hw/nvram/fw_cfg.h                     |   9 +-
 include/hw/nvram/nrf51_nvm.h                  |   4 +-
 include/hw/pci-bridge/simba.h                 |   4 +-
 include/hw/pci-host/designware.h              |   8 +-
 include/hw/pci-host/gpex.h                    |   8 +-
 include/hw/pci-host/i440fx.h                  |   4 +-
 include/hw/pci-host/pnv_phb3.h                |   7 +-
 include/hw/pci-host/pnv_phb4.h                |  11 +-
 include/hw/pci-host/q35.h                     |   8 +-
 include/hw/pci-host/sabre.h                   |   8 +-
 include/hw/pci-host/spapr.h                   |   4 +-
 include/hw/pci-host/uninorth.h                |   4 +-
 include/hw/pci-host/xilinx-pcie.h             |   8 +-
 include/hw/pci/pci.h                          |   4 +-
 include/hw/pci/pci_bridge.h                   |   3 +-
 include/hw/pci/pci_host.h                     |   4 +-
 include/hw/pci/pcie_host.h                    |   3 +-
 include/hw/pci/pcie_port.h                    |   6 +-
 include/hw/pcmcia.h                           |   5 +-
 include/hw/platform-bus.h                     |   4 +-
 include/hw/ppc/mac_dbdma.h                    |   3 +-
 include/hw/ppc/openpic.h                      |   4 +-
 include/hw/ppc/pnv.h                          |   2 +-
 include/hw/ppc/pnv_core.h                     |   6 +-
 include/hw/ppc/pnv_homer.h                    |   2 +-
 include/hw/ppc/pnv_occ.h                      |   2 +-
 include/hw/ppc/pnv_pnor.h                     |   4 +-
 include/hw/ppc/pnv_psi.h                      |  10 +-
 include/hw/ppc/pnv_xive.h                     |   2 +-
 include/hw/ppc/spapr.h                        |  13 +-
 include/hw/ppc/spapr_cpu_core.h               |   2 +-
 include/hw/ppc/spapr_tpm_proxy.h              |   4 +-
 include/hw/ppc/spapr_vio.h                    |   6 +-
 include/hw/ppc/xics.h                         |   2 +-
 include/hw/ppc/xive.h                         |  14 +-
 include/hw/qdev-core.h                        |   4 +-
 include/hw/riscv/opentitan.h                  |   4 +-
 include/hw/riscv/riscv_hart.h                 |   4 +-
 include/hw/riscv/sifive_e.h                   |  38 +-
 include/hw/riscv/sifive_u.h                   |  34 +-
 include/hw/rtc/allwinner-rtc.h                |   5 +-
 include/hw/rtc/aspeed_rtc.h                   |   4 +-
 include/hw/rtc/goldfish_rtc.h                 |   4 +-
 include/hw/rtc/mc146818rtc.h                  |   4 +-
 include/hw/rtc/pl031.h                        |   4 +-
 include/hw/rtc/xlnx-zynqmp-rtc.h              |   4 +-
 include/hw/s390x/3270-ccw.h                   |   5 +-
 include/hw/s390x/css-bridge.h                 |   8 +-
 include/hw/s390x/event-facility.h             |   2 +-
 include/hw/s390x/s390-virtio-ccw.h            |   5 +-
 include/hw/s390x/s390_flic.h                  |   6 +-
 include/hw/s390x/sclp.h                       |   2 +-
 include/hw/s390x/storage-attributes.h         |   5 +-
 include/hw/s390x/storage-keys.h               |   5 +-
 include/hw/s390x/tod.h                        |   5 +-
 include/hw/s390x/vfio-ccw.h                   |   4 +-
 include/hw/scsi/esp.h                         |   4 +-
 include/hw/scsi/scsi.h                        |   7 +-
 include/hw/sd/allwinner-sdhost.h              |   5 +-
 include/hw/sd/aspeed_sdhci.h                  |   4 +-
 include/hw/sd/bcm2835_sdhost.h                |   4 +-
 include/hw/sd/sd.h                            |   7 +-
 include/hw/sparc/sparc32_dma.h                |  16 +-
 include/hw/ssi/aspeed_smc.h                   |   5 +-
 include/hw/ssi/imx_spi.h                      |   4 +-
 include/hw/ssi/mss-spi.h                      |   4 +-
 include/hw/ssi/pl022.h                        |   4 +-
 include/hw/ssi/ssi.h                          |   2 +-
 include/hw/ssi/stm32f2xx_spi.h                |   4 +-
 include/hw/ssi/xilinx_spips.h                 |  11 +-
 include/hw/sysbus.h                           |   2 +-
 include/hw/timer/a9gtimer.h                   |   4 +-
 include/hw/timer/allwinner-a10-pit.h          |   4 +-
 include/hw/timer/arm_mptimer.h                |   4 +-
 include/hw/timer/armv7m_systick.h             |   4 +-
 include/hw/timer/aspeed_timer.h               |   5 +-
 include/hw/timer/avr_timer16.h                |   4 +-
 include/hw/timer/bcm2835_systmr.h             |   4 +-
 include/hw/timer/cmsdk-apb-dualtimer.h        |   4 +-
 include/hw/timer/cmsdk-apb-timer.h            |   4 +-
 include/hw/timer/digic-timer.h                |   4 +-
 include/hw/timer/i8254.h                      |   5 +-
 include/hw/timer/imx_epit.h                   |   4 +-
 include/hw/timer/mss-timer.h                  |   4 +-
 include/hw/timer/nrf51_timer.h                |   4 +-
 include/hw/usb.h                              |   8 +-
 include/hw/usb/chipidea.h                     |   4 +-
 include/hw/usb/imx-usb-phy.h                  |   4 +-
 include/hw/virtio/vhost-scsi-common.h         |   4 +-
 include/hw/virtio/vhost-scsi.h                |   4 +-
 include/hw/virtio/vhost-user-blk.h            |   4 +-
 include/hw/virtio/vhost-user-fs.h             |   4 +-
 include/hw/virtio/vhost-user-scsi.h           |   4 +-
 include/hw/virtio/vhost-user-vsock.h          |   4 +-
 include/hw/virtio/vhost-vsock-common.h        |   4 +-
 include/hw/virtio/vhost-vsock.h               |   4 +-
 include/hw/virtio/virtio-balloon.h            |   4 +-
 include/hw/virtio/virtio-blk.h                |   4 +-
 include/hw/virtio/virtio-crypto.h             |   4 +-
 include/hw/virtio/virtio-gpu-pci.h            |   4 +-
 include/hw/virtio/virtio-gpu.h                |  10 +-
 include/hw/virtio/virtio-input.h              |  14 +-
 include/hw/virtio/virtio-iommu.h              |   4 +-
 include/hw/virtio/virtio-mem.h                |   2 +-
 include/hw/virtio/virtio-mmio.h               |   4 +-
 include/hw/virtio/virtio-net.h                |   4 +-
 include/hw/virtio/virtio-pmem.h               |   2 +-
 include/hw/virtio/virtio-rng.h                |   4 +-
 include/hw/virtio/virtio-scsi.h               |   8 +-
 include/hw/virtio/virtio-serial.h             |   9 +-
 include/hw/virtio/virtio.h                    |   4 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h      |   4 +-
 include/hw/watchdog/wdt_aspeed.h              |   5 +-
 include/hw/watchdog/wdt_imx2.h                |   4 +-
 include/hw/xen/xen-block.h                    |  12 +-
 include/hw/xen/xen-bus.h                      |   6 +-
 include/io/channel-buffer.h                   |   4 +-
 include/io/channel-command.h                  |   4 +-
 include/io/channel-file.h                     |   4 +-
 include/io/channel-socket.h                   |   4 +-
 include/io/channel-tls.h                      |   4 +-
 include/io/channel-websock.h                  |   4 +-
 include/io/channel.h                          |   2 +-
 include/io/dns-resolver.h                     |   4 +-
 include/io/net-listener.h                     |   4 +-
 include/net/can_emu.h                         |   3 +-
 include/net/can_host.h                        |   5 +-
 include/net/filter.h                          |   4 +-
 include/qom/object.h                          |  37 +-
 include/scsi/pr-manager.h                     |   2 +-
 include/sysemu/cryptodev.h                    |   2 +-
 include/sysemu/hostmem.h                      |   2 +-
 include/sysemu/rng-random.h                   |   4 +-
 include/sysemu/rng.h                          |   2 +-
 include/sysemu/tpm_backend.h                  |   2 +-
 include/sysemu/vhost-user-backend.h           |   4 +-
 include/ui/console.h                          |   4 +-
 target/alpha/cpu-qom.h                        |   2 +-
 target/arm/cpu-qom.h                          |   2 +-
 target/avr/cpu-qom.h                          |   2 +-
 target/cris/cpu-qom.h                         |   2 +-
 target/hppa/cpu-qom.h                         |   2 +-
 target/i386/cpu-qom.h                         |   2 +-
 target/lm32/cpu-qom.h                         |   2 +-
 target/m68k/cpu-qom.h                         |   2 +-
 target/microblaze/cpu-qom.h                   |   2 +-
 target/mips/cpu-qom.h                         |   2 +-
 target/moxie/cpu.h                            |   2 +-
 target/nios2/cpu.h                            |   2 +-
 target/openrisc/cpu.h                         |   2 +-
 target/ppc/cpu-qom.h                          |   2 +-
 target/riscv/cpu.h                            |   2 +-
 target/rx/cpu-qom.h                           |   2 +-
 target/s390x/cpu-qom.h                        |   2 +-
 target/sh4/cpu-qom.h                          |   2 +-
 target/sparc/cpu-qom.h                        |   2 +-
 target/tilegx/cpu.h                           |   2 +-
 target/tricore/cpu-qom.h                      |   2 +-
 target/unicore32/cpu-qom.h                    |   2 +-
 target/xtensa/cpu-qom.h                       |   2 +-
 authz/list.c                                  |   1 -
 authz/listfile.c                              |   1 -
 authz/pamacct.c                               |   1 -
 authz/simple.c                                |   1 -
 backends/cryptodev-builtin.c                  |   5 +-
 backends/cryptodev-vhost-user.c               |   4 +-
 backends/dbus-vmstate.c                       |   5 +-
 backends/hostmem-file.c                       |   4 +-
 backends/hostmem-memfd.c                      |   4 +-
 backends/rng-builtin.c                        |   4 +-
 backends/rng-egd.c                            |   4 +-
 backends/tpm/tpm_emulator.c                   |   4 +-
 backends/tpm/tpm_passthrough.c                |   4 +-
 backends/vhost-user.c                         |   1 -
 crypto/secret_keyring.c                       |   1 -
 hw/acpi/piix4.c                               |   4 +-
 hw/alpha/typhoon.c                            |   4 +-
 hw/arm/collie.c                               |   4 +-
 hw/arm/highbank.c                             |   4 +-
 hw/arm/integratorcp.c                         |  12 +-
 hw/arm/microbit.c                             |   4 +-
 hw/arm/mps2-tz.c                              |   5 +-
 hw/arm/mps2.c                                 |   5 +-
 hw/arm/musca.c                                |   5 +-
 hw/arm/musicpal.c                             |  32 +-
 hw/arm/palm.c                                 |   4 +-
 hw/arm/pxa2xx.c                               |  12 +-
 hw/arm/pxa2xx_gpio.c                          |   4 +-
 hw/arm/pxa2xx_pic.c                           |   4 +-
 hw/arm/sbsa-ref.c                             |   4 +-
 hw/arm/spitz.c                                |  25 +-
 hw/arm/stellaris.c                            |   8 +-
 hw/arm/strongarm.c                            |  24 +-
 hw/arm/tosa.c                                 |   8 +-
 hw/arm/versatilepb.c                          |   4 +-
 hw/arm/vexpress.c                             |   5 +-
 hw/arm/xilinx_zynq.c                          |   4 +-
 hw/arm/xlnx-versal-virt.c                     |   4 +-
 hw/arm/xlnx-zcu102.c                          |   4 +-
 hw/arm/z2.c                                   |   8 +-
 hw/audio/ac97.c                               |   4 +-
 hw/audio/adlib.c                              |   4 +-
 hw/audio/es1370.c                             |   3 +-
 hw/audio/gus.c                                |   4 +-
 hw/audio/hda-codec.c                          |   3 +-
 hw/audio/marvell_88w8618.c                    |   4 +-
 hw/audio/milkymist-ac97.c                     |   4 +-
 hw/audio/pcspk.c                              |   4 +-
 hw/audio/pl041.c                              |   4 +-
 hw/audio/sb16.c                               |   4 +-
 hw/audio/wm8750.c                             |   4 +-
 hw/block/fdc.c                                |  16 +-
 hw/block/m25p80.c                             |   5 +-
 hw/block/nand.c                               |   3 +-
 hw/block/onenand.c                            |   4 +-
 hw/char/debugcon.c                            |   4 +-
 hw/char/exynos4210_uart.c                     |   4 +-
 hw/char/grlib_apbuart.c                       |   4 +-
 hw/char/ipoctal232.c                          |   3 +-
 hw/char/lm32_juart.c                          |   4 +-
 hw/char/lm32_uart.c                           |   4 +-
 hw/char/mcf_uart.c                            |   4 +-
 hw/char/milkymist-uart.c                      |   4 +-
 hw/char/parallel.c                            |   4 +-
 hw/char/serial-isa.c                          |   4 +-
 hw/char/serial-pci.c                          |   4 +-
 hw/char/spapr_vty.c                           |   4 +-
 hw/char/xilinx_uartlite.c                     |   4 +-
 hw/cpu/realview_mpcore.c                      |   4 +-
 hw/display/ads7846.c                          |   4 +-
 hw/display/artist.c                           |   4 +-
 hw/display/bochs-display.c                    |   4 +-
 hw/display/cg3.c                              |   4 +-
 hw/display/cirrus_vga.c                       |   4 +-
 hw/display/cirrus_vga_isa.c                   |   4 +-
 hw/display/exynos4210_fimd.c                  |   4 +-
 hw/display/g364fb.c                           |   4 +-
 hw/display/jazz_led.c                         |   4 +-
 hw/display/milkymist-tmu2.c                   |   4 +-
 hw/display/milkymist-vgafb.c                  |   4 +-
 hw/display/next-fb.c                          |   4 +-
 hw/display/pl110.c                            |   4 +-
 hw/display/sii9022.c                          |   4 +-
 hw/display/sm501.c                            |   8 +-
 hw/display/ssd0303.c                          |   4 +-
 hw/display/ssd0323.c                          |   4 +-
 hw/display/tcx.c                              |   4 +-
 hw/display/vga-isa.c                          |   4 +-
 hw/display/vga-pci.c                          |   4 +-
 hw/dma/i82374.c                               |   4 +-
 hw/dma/pl330.c                                |   3 +-
 hw/dma/puv3_dma.c                             |   4 +-
 hw/dma/pxa2xx_dma.c                           |   4 +-
 hw/dma/rc4030.c                               |   4 +-
 hw/dma/xilinx_axidma.c                        |   4 +-
 hw/gpio/gpio_key.c                            |   4 +-
 hw/gpio/max7310.c                             |   4 +-
 hw/gpio/mpc8xxx.c                             |   4 +-
 hw/gpio/pl061.c                               |   4 +-
 hw/gpio/puv3_gpio.c                           |   4 +-
 hw/gpio/zaurus.c                              |   4 +-
 hw/hppa/dino.c                                |   4 +-
 hw/hppa/lasi.c                                |   4 +-
 hw/hyperv/hyperv.c                            |   4 +-
 hw/hyperv/hyperv_testdev.c                    |   4 +-
 hw/i2c/bitbang_i2c.c                          |   4 +-
 hw/i2c/exynos4210_i2c.c                       |   4 +-
 hw/i2c/mpc_i2c.c                              |   4 +-
 hw/i2c/smbus_eeprom.c                         |   4 +-
 hw/i2c/smbus_ich9.c                           |   4 +-
 hw/i386/kvm/clock.c                           |   4 +-
 hw/i386/kvmvapic.c                            |   4 +-
 hw/i386/port92.c                              |   4 +-
 hw/i386/vmmouse.c                             |   4 +-
 hw/i386/vmport.c                              |   4 +-
 hw/i386/xen/xen_platform.c                    |   4 +-
 hw/i386/xen/xen_pvdevice.c                    |   4 +-
 hw/ide/isa.c                                  |   4 +-
 hw/ide/microdrive.c                           |   4 +-
 hw/ide/sii3112.c                              |   4 +-
 hw/input/adb-kbd.c                            |   5 +-
 hw/input/adb-mouse.c                          |   5 +-
 hw/input/lm832x.c                             |   4 +-
 hw/input/milkymist-softusb.c                  |   4 +-
 hw/input/pl050.c                              |   4 +-
 hw/intc/arm_gicv2m.c                          |   4 +-
 hw/intc/exynos4210_combiner.c                 |   4 +-
 hw/intc/exynos4210_gic.c                      |   8 +-
 hw/intc/grlib_irqmp.c                         |   4 +-
 hw/intc/lm32_pic.c                            |   4 +-
 hw/intc/nios2_iic.c                           |   4 +-
 hw/intc/ompic.c                               |   4 +-
 hw/intc/openpic_kvm.c                         |   4 +-
 hw/intc/pl190.c                               |   4 +-
 hw/intc/puv3_intc.c                           |   4 +-
 hw/intc/slavio_intctl.c                       |   4 +-
 hw/ipack/tpci200.c                            |   4 +-
 hw/ipmi/ipmi_bmc_extern.c                     |   4 +-
 hw/ipmi/isa_ipmi_bt.c                         |   4 +-
 hw/ipmi/isa_ipmi_kcs.c                        |   4 +-
 hw/ipmi/pci_ipmi_bt.c                         |   4 +-
 hw/ipmi/pci_ipmi_kcs.c                        |   4 +-
 hw/ipmi/smbus_ipmi.c                          |   4 +-
 hw/isa/i82378.c                               |   4 +-
 hw/isa/piix4.c                                |   4 +-
 hw/isa/vt82c686.c                             |  16 +-
 hw/m68k/mcf_intc.c                            |   4 +-
 hw/m68k/next-cube.c                           |   4 +-
 hw/m68k/next-kbd.c                            |   4 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |   4 +-
 hw/mips/gt64xxx_pci.c                         |   4 +-
 hw/mips/malta.c                               |   4 +-
 hw/misc/applesmc.c                            |   4 +-
 hw/misc/arm_integrator_debug.c                |   4 +-
 hw/misc/arm_l2x0.c                            |   4 +-
 hw/misc/arm_sysctl.c                          |   4 +-
 hw/misc/debugexit.c                           |   4 +-
 hw/misc/eccmemctl.c                           |   4 +-
 hw/misc/empty_slot.c                          |   4 +-
 hw/misc/exynos4210_clk.c                      |   4 +-
 hw/misc/exynos4210_pmu.c                      |   4 +-
 hw/misc/exynos4210_rng.c                      |   4 +-
 hw/misc/milkymist-hpdmc.c                     |   4 +-
 hw/misc/milkymist-pfpu.c                      |   4 +-
 hw/misc/mst_fpga.c                            |   4 +-
 hw/misc/pc-testdev.c                          |   4 +-
 hw/misc/pci-testdev.c                         |   4 +-
 hw/misc/puv3_pm.c                             |   4 +-
 hw/misc/sga.c                                 |   4 +-
 hw/misc/slavio_misc.c                         |   4 +-
 hw/misc/tmp421.c                              |   5 +-
 hw/misc/zynq_slcr.c                           |   4 +-
 hw/net/dp8393x.c                              |   4 +-
 hw/net/e1000e.c                               |   4 +-
 hw/net/etraxfs_eth.c                          |   4 +-
 hw/net/lan9118.c                              |   4 +-
 hw/net/milkymist-minimac2.c                   |   4 +-
 hw/net/mipsnet.c                              |   4 +-
 hw/net/ne2000-isa.c                           |   4 +-
 hw/net/opencores_eth.c                        |   4 +-
 hw/net/pcnet-pci.c                            |   4 +-
 hw/net/rtl8139.c                              |   4 +-
 hw/net/smc91c111.c                            |   4 +-
 hw/net/spapr_llan.c                           |   4 +-
 hw/net/stellaris_enet.c                       |   4 +-
 hw/net/sungem.c                               |   4 +-
 hw/net/sunhme.c                               |   4 +-
 hw/net/xgmac.c                                |   4 +-
 hw/net/xilinx_axienet.c                       |   4 +-
 hw/nvram/ds1225y.c                            |   4 +-
 hw/nvram/spapr_nvram.c                        |   4 +-
 hw/pci-bridge/dec.c                           |   4 +-
 hw/pci-bridge/gen_pcie_root_port.c            |   4 +-
 hw/pci-bridge/pci_bridge_dev.c                |   4 +-
 hw/pci-bridge/pcie_pci_bridge.c               |   4 +-
 hw/pci-host/bonito.c                          |   6 +-
 hw/pci-host/grackle.c                         |   4 +-
 hw/pci-host/i440fx.c                          |   4 +-
 hw/pci-host/ppce500.c                         |   8 +-
 hw/pci-host/prep.c                            |   4 +-
 hw/ppc/mpc8544_guts.c                         |   4 +-
 hw/ppc/ppc440_pcix.c                          |   4 +-
 hw/ppc/ppc440_uc.c                            |   4 +-
 hw/ppc/ppc4xx_pci.c                           |   4 +-
 hw/ppc/ppce500_spin.c                         |   4 +-
 hw/ppc/prep_systemio.c                        |   4 +-
 hw/ppc/rs6000_mc.c                            |   4 +-
 hw/ppc/spapr_rng.c                            |   4 +-
 hw/riscv/sifive_e.c                           |  82 +-
 hw/riscv/sifive_u.c                           | 156 ++--
 hw/rtc/ds1338.c                               |   4 +-
 hw/rtc/exynos4210_rtc.c                       |   4 +-
 hw/rtc/m41t80.c                               |   4 +-
 hw/rtc/sun4v-rtc.c                            |   4 +-
 hw/rtc/twl92230.c                             |   4 +-
 hw/scsi/lsi53c895a.c                          |   4 +-
 hw/scsi/scsi-disk.c                           |   5 +-
 hw/scsi/spapr_vscsi.c                         |   4 +-
 hw/scsi/vmw_pvscsi.c                          |   5 +-
 hw/sd/milkymist-memcard.c                     |   4 +-
 hw/sd/pl181.c                                 |   4 +-
 hw/sd/ssi-sd.c                                |   4 +-
 hw/sh4/sh_pci.c                               |   4 +-
 hw/sparc/sun4m.c                              |   8 +-
 hw/sparc64/sun4u.c                            |   8 +-
 hw/ssi/ssi.c                                  |   3 +-
 hw/ssi/xilinx_spi.c                           |   4 +-
 hw/timer/altera_timer.c                       |   4 +-
 hw/timer/arm_timer.c                          |   8 +-
 hw/timer/cadence_ttc.c                        |   4 +-
 hw/timer/exynos4210_mct.c                     |   4 +-
 hw/timer/exynos4210_pwm.c                     |   4 +-
 hw/timer/grlib_gptimer.c                      |   4 +-
 hw/timer/hpet.c                               |   4 +-
 hw/timer/lm32_timer.c                         |   4 +-
 hw/timer/milkymist-sysctl.c                   |   4 +-
 hw/timer/puv3_ost.c                           |   4 +-
 hw/timer/pxa2xx_timer.c                       |   4 +-
 hw/timer/slavio_timer.c                       |   4 +-
 hw/tpm/tpm_tis_isa.c                          |   4 +-
 hw/tpm/tpm_tis_sysbus.c                       |   4 +-
 hw/usb/dev-audio.c                            |   4 +-
 hw/usb/dev-hid.c                              |   4 +-
 hw/usb/dev-hub.c                              |   4 +-
 hw/usb/dev-mtp.c                              |   3 +-
 hw/usb/dev-network.c                          |   4 +-
 hw/usb/dev-serial.c                           |   4 +-
 hw/usb/dev-smartcard-reader.c                 |   7 +-
 hw/usb/dev-uas.c                              |   3 +-
 hw/usb/dev-wacom.c                            |   4 +-
 hw/usb/hcd-ohci-pci.c                         |   4 +-
 hw/usb/host-libusb.c                          |   4 +-
 hw/usb/tusb6010.c                             |   4 +-
 hw/vfio/ap.c                                  |   4 +-
 hw/virtio/virtio-input-pci.c                  |   8 +-
 hw/watchdog/wdt_i6300esb.c                    |   4 +-
 io/dns-resolver.c                             |   1 -
 io/net-listener.c                             |   1 -
 migration/rdma.c                              |   4 +-
 net/can/can_socketcan.c                       |   4 +-
 net/dump.c                                    |   4 +-
 net/filter-buffer.c                           |   4 +-
 net/filter-replay.c                           |   4 +-
 net/filter-rewriter.c                         |   4 +-
 qom/object.c                                  |  42 +-
 scsi/pr-manager-helper.c                      |   4 +-
 target/arm/cpu.c                              |   2 +
 target/i386/sev.c                             |   4 +-
 target/riscv/cpu.c                            |   1 +
 target/s390x/cpu.c                            |   1 +
 tests/check-qom-proplist.c                    |   2 +
 ui/input-barrier.c                            |   5 +-
 ui/input-linux.c                              |   5 +-
 .../codeconverter/codeconverter/patching.py   | 193 +++--
 .../codeconverter/codeconverter/qom_macros.py | 327 ++++++--
 .../codeconverter/qom_type_info.py            | 741 +++++++++++++++---
 .../codeconverter/test_patching.py            |   3 +-
 .../codeconverter/test_regexps.py             |  26 +-
 scripts/codeconverter/converter.py            |  12 +-
 target/ppc/translate_init.c.inc               |   1 +
 651 files changed, 2079 insertions(+), 2595 deletions(-)

-- 
2.26.2


