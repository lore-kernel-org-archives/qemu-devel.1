Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A37C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3508C206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrPwSqPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3508C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3mN-0004jN-0K
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kG3lM-0003n1-AY
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:20:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kG3lH-0007bo-AK
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599671998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5rGDKwHlapWezbJOilm+KXFLa2cP3Ah9xEVfRcY2/4=;
 b=OrPwSqPsuXVSUKO4MoArjsV+uaZOKQSbhDG6qcqRapmWpuQT0MdV7ulKhXSxR5ZN8vxCqf
 zZ6NS6h0k6aOQigJPp8QopHIvYi3p4Z0dXtG61oGKlhrXFq4jSvyj6o6YxXJjHASIj3GIL
 8mdCnqvs+MbkiwnyDWY95g2chf4i+js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-fVUwelNRPY2wdM_cRyNJrQ-1; Wed, 09 Sep 2020 13:19:56 -0400
X-MC-Unique: fVUwelNRPY2wdM_cRyNJrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17A841882FA6;
 Wed,  9 Sep 2020 17:19:55 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F3F460BEC;
 Wed,  9 Sep 2020 17:19:54 +0000 (UTC)
Date: Wed, 9 Sep 2020 13:19:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/34] QOM boilerplate cleanup (v3)
Message-ID: <20200909171953.GL1618070@habkost.net>
References: <20200908215239.3519638-1-ehabkost@redhat.com>
 <CAFEAcA9E04CfeD=75idggFOCX2Tv0SfK0SyQrUvK3VeO4N9VBQ@mail.gmail.com>
 <20200909133812.GI1618070@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200909133812.GI1618070@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 09:38:13AM -0400, Eduardo Habkost wrote:
> Ouch.  It looks like the code movements crossed #ifdef boundaries there.
> 
> I have just dropped the char-parallel.c changes, and new pull
> request is below.  Sorry for the noise, and thanks for the
> patience.

Please ignore the pull request below.  The chardev-parallel.c
changes conflict with other patches in the queue, and I'll submit
a new pull request later.

> 
> The following changes since commit 6779038537360e957dbded830f76b08ef5070161:
> 
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-09-08' into staging (2020-09-08 17:23:31 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> 
> for you to fetch changes up to 32907eb39ca3f8b7a5394afc57e6589ce7151e29:
> 
>   virtio-vga: Use typedef name for instance_size (2020-09-09 09:27:18 -0400)
> 
> ----------------------------------------------------------------
> QOM boilerplate cleanup
> 
> Documentation build fix:
> * memory: Remove kernel-doc comment marker (Eduardo Habkost)
> 
> QOM cleanups:
> * Rename QOM macros for consistency between
>   TYPE_* and type checking constants (Eduardo Habkost)
> 
> QOM new macros:
> * OBJECT_DECLARE_* and OBJECT_DEFINE_* macros (Daniel P. Berrangé)
> * DECLARE_*_CHECKER macros (Eduardo Habkost)
> 
> Automated QOM boilerplate changes:
> * Automated changes to use DECLARE_*_CHECKER (Eduardo Habkost
> * Automated changes to use OBJECT_DECLARE* (Eduardo Habkost)
> 
> ----------------------------------------------------------------
> 
> Daniel P. Berrangé (2):
>   qom: make object_ref/unref use a void * instead of Object *.
>   qom: provide convenient macros for declaring and defining types
> 
> Eduardo Habkost (32):
>   memory: Remove kernel-doc comment marker
>   qom: Allow class type name to be specified in OBJECT_DECLARE*
>   qom: DECLARE_*_CHECKERS macros
>   qom: Make type checker functions accept const pointers
>   codeconverter: script for automating QOM code cleanups
>   Delete duplicate QOM typedefs
>   Move QOM typedefs and add missing includes
>   Use DECLARE_*CHECKER* macros
>   Use DECLARE_*CHECKER* when possible (--force mode)
>   Use OBJECT_DECLARE_TYPE where possible
>   Use OBJECT_DECLARE_SIMPLE_TYPE when possible
>   gpex: Fix type checking function name
>   chardev: Rename TYPE_CHARDEV_* to TYPE_*_CHARDEV
>   ap-device: Rename AP_DEVICE_TYPE to TYPE_AP_DEVICE
>   dev-smartcard-reader: Rename CCID_DEV_NAME to TYPE_USB_CCID_DEV
>   vfio: Rename VFIO_AP_DEVICE_TYPE to TYPE_VFIO_AP_DEVICE
>   vmgenid: Rename VMGENID_DEVICE to TYPE_VMGENID
>   ahci: Rename ICH_AHCI to ICH9_AHCI
>   esp: Rename ESP_STATE to ESP
>   filter-rewriter: Rename FILTER_COLO_REWRITER to FILTER_REWRITER
>   rs6000_mc: Rename RS6000MC_DEVICE to RS6000MC
>   sabre: Rename SABRE_DEVICE to SABRE
>   usb: Rename USB_SERIAL_DEV to USB_SERIAL
>   vfio: Rename PCI_VFIO to VFIO_PCI
>   pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312
>   tusb6010: Rename TUSB to TUSB6010
>   xilinx_axidma: Use typedef name for instance_size
>   omap_intc: Use typedef name for instance_size
>   lpc_ich9: Use typedef name for instance_size
>   xilinx_axienet: Use typedef name for instance_size
>   vhost-user-vga: Use typedef name for instance_size
>   virtio-vga: Use typedef name for instance_size
> 
>  .../codeconverter/codeconverter/__init__.py   |   0
>  .../codeconverter/codeconverter/patching.py   | 397 +++++++++++
>  .../codeconverter/codeconverter/qom_macros.py | 652 ++++++++++++++++++
>  .../codeconverter/qom_type_info.py            | 434 ++++++++++++
>  .../codeconverter/codeconverter/regexps.py    | 118 ++++
>  .../codeconverter/test_patching.py            | 105 +++
>  .../codeconverter/test_regexps.py             | 282 ++++++++
>  scripts/codeconverter/codeconverter/utils.py  |  72 ++
>  scripts/codeconverter/converter.py            | 123 ++++
>  chardev/chardev-internal.h                    |  10 +-
>  hw/9pfs/virtio-9p.h                           |  11 +-
>  hw/audio/intel-hda.h                          |  20 +-
>  hw/avr/atmega.h                               |   9 +-
>  hw/display/ati_int.h                          |   9 +-
>  hw/display/qxl.h                              |   9 +-
>  hw/display/virtio-vga.h                       |  17 +-
>  hw/i386/amd_iommu.h                           |  10 +-
>  hw/misc/tmp105.h                              |   9 +-
>  hw/net/fsl_etsec/etsec.h                      |  10 +-
>  hw/net/rocker/rocker.h                        |   5 +-
>  hw/net/tulip.h                                |   4 +-
>  hw/net/vmxnet3_defs.h                         |   9 +-
>  hw/ppc/e500-ccsr.h                            |   9 +-
>  hw/ppc/e500.h                                 |  19 +-
>  hw/ppc/mac.h                                  |  19 +-
>  hw/rdma/vmw/pvrdma.h                          |   9 +-
>  hw/s390x/ccw-device.h                         |  17 +-
>  hw/s390x/ipl.h                                |   6 +-
>  hw/s390x/s390-pci-bus.h                       |  34 +-
>  hw/s390x/virtio-ccw.h                         | 141 ++--
>  hw/scsi/mptsas.h                              |   5 +-
>  hw/usb/ccid.h                                 |  14 +-
>  hw/usb/hcd-dwc2.h                             |   9 +-
>  hw/usb/hcd-ehci.h                             |  36 +-
>  hw/usb/hcd-ohci.h                             |   9 +-
>  hw/usb/hcd-xhci.h                             |   7 +-
>  hw/vfio/pci.h                                 |   9 +-
>  hw/virtio/virtio-mem-pci.h                    |   5 +-
>  hw/virtio/virtio-pci.h                        |  24 +-
>  hw/virtio/virtio-pmem-pci.h                   |   5 +-
>  hw/xen/xen_pt.h                               |   5 +-
>  include/authz/base.h                          |  15 +-
>  include/authz/list.h                          |  17 +-
>  include/authz/listfile.h                      |  17 +-
>  include/authz/pamacct.h                       |  17 +-
>  include/authz/simple.h                        |  17 +-
>  include/block/throttle-groups.h               |   4 +-
>  include/chardev/char-fd.h                     |  11 +-
>  include/chardev/char-win-stdio.h              |   2 +-
>  include/chardev/char-win.h                    |  11 +-
>  include/chardev/char.h                        |  44 +-
>  include/chardev/spice.h                       |  15 +-
>  include/crypto/secret.h                       |   6 +-
>  include/crypto/secret_common.h                |  12 +-
>  include/crypto/secret_keyring.h               |  24 +-
>  include/crypto/tls-cipher-suites.h            |   9 +-
>  include/crypto/tlscreds.h                     |   6 +-
>  include/crypto/tlscredsanon.h                 |   7 +-
>  include/crypto/tlscredspsk.h                  |   7 +-
>  include/crypto/tlscredsx509.h                 |   7 +-
>  include/exec/memory.h                         |  21 +-
>  include/hw/acpi/acpi_dev_interface.h          |  13 +-
>  include/hw/acpi/generic_event_device.h        |  10 +-
>  include/hw/acpi/vmgenid.h                     |  13 +-
>  include/hw/adc/stm32f2xx_adc.h                |  10 +-
>  include/hw/arm/allwinner-a10.h                |   9 +-
>  include/hw/arm/allwinner-h3.h                 |   8 +-
>  include/hw/arm/armsse.h                       |  16 +-
>  include/hw/arm/armv7m.h                       |  17 +-
>  include/hw/arm/aspeed.h                       |  14 +-
>  include/hw/arm/aspeed_soc.h                   |  18 +-
>  include/hw/arm/bcm2835_peripherals.h          |  10 +-
>  include/hw/arm/bcm2836.h                      |  18 +-
>  include/hw/arm/digic.h                        |   9 +-
>  include/hw/arm/exynos4210.h                   |  10 +-
>  include/hw/arm/fsl-imx25.h                    |   9 +-
>  include/hw/arm/fsl-imx31.h                    |   9 +-
>  include/hw/arm/fsl-imx6.h                     |   9 +-
>  include/hw/arm/fsl-imx6ul.h                   |   9 +-
>  include/hw/arm/fsl-imx7.h                     |   9 +-
>  include/hw/arm/linux-boot-if.h                |  11 +-
>  include/hw/arm/msf2-soc.h                     |   9 +-
>  include/hw/arm/nrf51_soc.h                    |  10 +-
>  include/hw/arm/omap.h                         |  20 +-
>  include/hw/arm/pxa.h                          |  15 +-
>  include/hw/arm/smmu-common.h                  |  18 +-
>  include/hw/arm/smmuv3.h                       |  18 +-
>  include/hw/arm/stm32f205_soc.h                |  10 +-
>  include/hw/arm/stm32f405_soc.h                |  10 +-
>  include/hw/arm/virt.h                         |  19 +-
>  include/hw/arm/xlnx-versal.h                  |   9 +-
>  include/hw/arm/xlnx-zynqmp.h                  |  10 +-
>  include/hw/block/flash.h                      |  13 +-
>  include/hw/block/swim.h                       |  15 +-
>  include/hw/boards.h                           |   8 +-
>  include/hw/char/avr_usart.h                   |  10 +-
>  include/hw/char/bcm2835_aux.h                 |   9 +-
>  include/hw/char/cadence_uart.h                |  10 +-
>  include/hw/char/cmsdk-apb-uart.h              |  10 +-
>  include/hw/char/digic-uart.h                  |  10 +-
>  include/hw/char/escc.h                        |   9 +-
>  include/hw/char/ibex_uart.h                   |  10 +-
>  include/hw/char/imx_serial.h                  |   9 +-
>  include/hw/char/nrf51_uart.h                  |   9 +-
>  include/hw/char/pl011.h                       |   9 +-
>  include/hw/char/renesas_sci.h                 |   9 +-
>  include/hw/char/serial.h                      |  25 +-
>  include/hw/char/stm32f2xx_usart.h             |  10 +-
>  include/hw/clock.h                            |   5 +-
>  include/hw/core/cpu.h                         |  10 +-
>  include/hw/core/generic-loader.h              |  10 +-
>  include/hw/core/split-irq.h                   |   3 +-
>  include/hw/cpu/a15mpcore.h                    |  10 +-
>  include/hw/cpu/a9mpcore.h                     |  10 +-
>  include/hw/cpu/arm11mpcore.h                  |  10 +-
>  include/hw/cpu/cluster.h                      |  10 +-
>  include/hw/cpu/core.h                         |  10 +-
>  include/hw/display/bcm2835_fb.h               |   9 +-
>  include/hw/display/dpcd.h                     |   4 +-
>  include/hw/display/i2c-ddc.h                  |   4 +-
>  include/hw/display/macfb.h                    |  30 +-
>  include/hw/display/xlnx_dp.h                  |   9 +-
>  include/hw/dma/bcm2835_dma.h                  |  10 +-
>  include/hw/dma/i8257.h                        |  10 +-
>  include/hw/dma/pl080.h                        |   9 +-
>  include/hw/dma/xlnx-zdma.h                    |  10 +-
>  include/hw/dma/xlnx-zynq-devcfg.h             |  10 +-
>  include/hw/dma/xlnx_dpdma.h                   |   4 +-
>  include/hw/fw-path-provider.h                 |  11 +-
>  include/hw/gpio/aspeed_gpio.h                 |  18 +-
>  include/hw/gpio/bcm2835_gpio.h                |  10 +-
>  include/hw/gpio/imx_gpio.h                    |   9 +-
>  include/hw/gpio/nrf51_gpio.h                  |   9 +-
>  include/hw/hotplug.h                          |  11 +-
>  include/hw/hyperv/vmbus-bridge.h              |   9 +-
>  include/hw/hyperv/vmbus.h                     |  17 +-
>  include/hw/i2c/arm_sbcon_i2c.h                |  10 +-
>  include/hw/i2c/aspeed_i2c.h                   |  19 +-
>  include/hw/i2c/i2c.h                          |  19 +-
>  include/hw/i2c/imx_i2c.h                      |   9 +-
>  include/hw/i2c/microbit_i2c.h                 |  10 +-
>  include/hw/i2c/ppc4xx_i2c.h                   |   9 +-
>  include/hw/i2c/smbus_slave.h                  |  15 +-
>  include/hw/i386/apic_internal.h               |  17 +-
>  include/hw/i386/ich9.h                        |  10 +-
>  include/hw/i386/intel_iommu.h                 |   7 +-
>  include/hw/i386/ioapic_internal.h             |  16 +-
>  include/hw/i386/microvm.h                     |  19 +-
>  include/hw/i386/pc.h                          |  14 +-
>  include/hw/i386/x86-iommu.h                   |  13 +-
>  include/hw/i386/x86.h                         |  19 +-
>  include/hw/ide/ahci.h                         |  22 +-
>  include/hw/ide/internal.h                     |  19 +-
>  include/hw/ide/pci.h                          |   9 +-
>  include/hw/input/adb.h                        |  16 +-
>  include/hw/input/i8042.h                      |   6 +-
>  include/hw/intc/allwinner-a10-pic.h           |   9 +-
>  include/hw/intc/arm_gic.h                     |  15 +-
>  include/hw/intc/arm_gic_common.h              |  21 +-
>  include/hw/intc/arm_gicv3.h                   |  14 +-
>  include/hw/intc/arm_gicv3_common.h            |  16 +-
>  include/hw/intc/arm_gicv3_its_common.h        |  11 +-
>  include/hw/intc/armv7m_nvic.h                 |  10 +-
>  include/hw/intc/aspeed_vic.h                  |   9 +-
>  include/hw/intc/bcm2835_ic.h                  |   9 +-
>  include/hw/intc/bcm2836_control.h             |  10 +-
>  include/hw/intc/heathrow_pic.h                |   9 +-
>  include/hw/intc/ibex_plic.h                   |  10 +-
>  include/hw/intc/imx_avic.h                    |   9 +-
>  include/hw/intc/imx_gpcv2.h                   |   9 +-
>  include/hw/intc/intc.h                        |  11 +-
>  include/hw/intc/mips_gic.h                    |   6 +-
>  include/hw/intc/realview_gic.h                |  10 +-
>  include/hw/intc/rx_icu.h                      |   4 +-
>  include/hw/intc/xlnx-pmu-iomod-intc.h         |  10 +-
>  include/hw/intc/xlnx-zynqmp-ipi.h             |  10 +-
>  include/hw/ipack/ipack.h                      |  14 +-
>  include/hw/ipmi/ipmi.h                        |  36 +-
>  include/hw/isa/i8259_internal.h               |  15 +-
>  include/hw/isa/isa.h                          |  28 +-
>  include/hw/isa/pc87312.h                      |  11 +-
>  include/hw/isa/superio.h                      |  19 +-
>  include/hw/m68k/mcf_fec.h                     |   4 +-
>  include/hw/mem/memory-device.h                |  11 +-
>  include/hw/mem/nvdimm.h                       |  11 +-
>  include/hw/mem/pc-dimm.h                      |  17 +-
>  include/hw/mips/cps.h                         |   9 +-
>  include/hw/misc/a9scu.h                       |   9 +-
>  include/hw/misc/allwinner-cpucfg.h            |   9 +-
>  include/hw/misc/allwinner-h3-ccu.h            |   9 +-
>  include/hw/misc/allwinner-h3-dramc.h          |   9 +-
>  include/hw/misc/allwinner-h3-sysctrl.h        |   9 +-
>  include/hw/misc/allwinner-sid.h               |   9 +-
>  include/hw/misc/arm11scu.h                    |   9 +-
>  include/hw/misc/armsse-cpuid.h                |   9 +-
>  include/hw/misc/armsse-mhu.h                  |   9 +-
>  include/hw/misc/aspeed_scu.h                  |  18 +-
>  include/hw/misc/aspeed_sdmc.h                 |  18 +-
>  include/hw/misc/aspeed_xdma.h                 |   9 +-
>  include/hw/misc/auxbus.h                      |  11 +-
>  include/hw/misc/avr_power.h                   |   9 +-
>  include/hw/misc/bcm2835_mbox.h                |  10 +-
>  include/hw/misc/bcm2835_mphi.h                |   5 +-
>  include/hw/misc/bcm2835_property.h            |  10 +-
>  include/hw/misc/bcm2835_rng.h                 |  10 +-
>  include/hw/misc/bcm2835_thermal.h             |  10 +-
>  include/hw/misc/grlib_ahb_apb_pnp.h           |   9 +-
>  include/hw/misc/imx25_ccm.h                   |   9 +-
>  include/hw/misc/imx31_ccm.h                   |   9 +-
>  include/hw/misc/imx6_ccm.h                    |   9 +-
>  include/hw/misc/imx6_src.h                    |   9 +-
>  include/hw/misc/imx6ul_ccm.h                  |   9 +-
>  include/hw/misc/imx7_ccm.h                    |  17 +-
>  include/hw/misc/imx7_gpr.h                    |   9 +-
>  include/hw/misc/imx7_snvs.h                   |   9 +-
>  include/hw/misc/imx_ccm.h                     |  19 +-
>  include/hw/misc/imx_rngc.h                    |   9 +-
>  include/hw/misc/iotkit-secctl.h               |   6 +-
>  include/hw/misc/iotkit-sysctl.h               |  10 +-
>  include/hw/misc/iotkit-sysinfo.h              |  10 +-
>  include/hw/misc/mac_via.h                     |  27 +-
>  include/hw/misc/macio/cuda.h                  |  18 +-
>  include/hw/misc/macio/gpio.h                  |   9 +-
>  include/hw/misc/macio/macio.h                 |  43 +-
>  include/hw/misc/macio/pmu.h                   |  18 +-
>  include/hw/misc/max111x.h                     |  10 +-
>  include/hw/misc/mips_cmgcr.h                  |   6 +-
>  include/hw/misc/mips_cpc.h                    |   9 +-
>  include/hw/misc/mips_itu.h                    |   9 +-
>  include/hw/misc/mos6522.h                     |  18 +-
>  include/hw/misc/mps2-fpgaio.h                 |   9 +-
>  include/hw/misc/mps2-scc.h                    |   9 +-
>  include/hw/misc/msf2-sysreg.h                 |   9 +-
>  include/hw/misc/nrf51_rng.h                   |   9 +-
>  include/hw/misc/pca9552.h                     |   9 +-
>  include/hw/misc/stm32f2xx_syscfg.h            |  10 +-
>  include/hw/misc/stm32f4xx_exti.h              |  10 +-
>  include/hw/misc/stm32f4xx_syscfg.h            |  10 +-
>  include/hw/misc/tz-mpc.h                      |   6 +-
>  include/hw/misc/tz-msc.h                      |   9 +-
>  include/hw/misc/tz-ppc.h                      |   6 +-
>  include/hw/misc/unimp.h                       |  10 +-
>  include/hw/misc/vmcoreinfo.h                  |   9 +-
>  include/hw/misc/zynq-xadc.h                   |  10 +-
>  include/hw/net/allwinner-sun8i-emac.h         |   9 +-
>  include/hw/net/allwinner_emac.h               |   9 +-
>  include/hw/net/cadence_gem.h                  |   9 +-
>  include/hw/net/ftgmac100.h                    |  17 +-
>  include/hw/net/imx_fec.h                      |   9 +-
>  include/hw/net/lance.h                        |  10 +-
>  include/hw/net/lasi_82596.h                   |  10 +-
>  include/hw/net/msf2-emac.h                    |  10 +-
>  include/hw/nmi.h                              |  11 +-
>  include/hw/nubus/mac-nubus-bridge.h           |  10 +-
>  include/hw/nubus/nubus.h                      |  18 +-
>  include/hw/nvram/fw_cfg.h                     |  21 +-
>  include/hw/nvram/nrf51_nvm.h                  |   9 +-
>  include/hw/or-irq.h                           |   3 +-
>  include/hw/pci-bridge/simba.h                 |  10 +-
>  include/hw/pci-host/designware.h              |  16 +-
>  include/hw/pci-host/gpex.h                    |  19 +-
>  include/hw/pci-host/i440fx.h                  |  10 +-
>  include/hw/pci-host/pnv_phb3.h                |  20 +-
>  include/hw/pci-host/pnv_phb4.h                |  21 +-
>  include/hw/pci-host/q35.h                     |  19 +-
>  include/hw/pci-host/sabre.h                   |  19 +-
>  include/hw/pci-host/spapr.h                   |   7 +-
>  include/hw/pci-host/uninorth.h                |  31 +-
>  include/hw/pci-host/xilinx-pcie.h             |  19 +-
>  include/hw/pci/pci.h                          |  19 +-
>  include/hw/pci/pci_bridge.h                   |   4 +-
>  include/hw/pci/pci_host.h                     |  14 +-
>  include/hw/pci/pcie_host.h                    |   5 +-
>  include/hw/pci/pcie_port.h                    |  18 +-
>  include/hw/pcmcia.h                           |  19 +-
>  include/hw/platform-bus.h                     |   5 +-
>  include/hw/ppc/mac_dbdma.h                    |   9 +-
>  include/hw/ppc/openpic.h                      |   9 +-
>  include/hw/ppc/pnv.h                          |  75 +-
>  include/hw/ppc/pnv_core.h                     |  26 +-
>  include/hw/ppc/pnv_homer.h                    |  22 +-
>  include/hw/ppc/pnv_lpc.h                      |  28 +-
>  include/hw/ppc/pnv_occ.h                      |  22 +-
>  include/hw/ppc/pnv_pnor.h                     |   9 +-
>  include/hw/ppc/pnv_psi.h                      |  35 +-
>  include/hw/ppc/pnv_xive.h                     |  16 +-
>  include/hw/ppc/pnv_xscom.h                    |  10 +-
>  include/hw/ppc/spapr.h                        |  23 +-
>  include/hw/ppc/spapr_cpu_core.h               |  17 +-
>  include/hw/ppc/spapr_irq.h                    |  12 +-
>  include/hw/ppc/spapr_tpm_proxy.h              |   9 +-
>  include/hw/ppc/spapr_vio.h                    |  19 +-
>  include/hw/ppc/xics.h                         |  31 +-
>  include/hw/ppc/xics_spapr.h                   |   5 +-
>  include/hw/ppc/xive.h                         |  77 +--
>  include/hw/qdev-core.h                        |  15 +-
>  include/hw/rdma/rdma.h                        |  11 +-
>  include/hw/register.h                         |   4 +-
>  include/hw/resettable.h                       |  11 +-
>  include/hw/riscv/opentitan.h                  |  10 +-
>  include/hw/riscv/riscv_hart.h                 |  10 +-
>  include/hw/riscv/spike.h                      |  10 +-
>  include/hw/riscv/virt.h                       |  10 +-
>  include/hw/rtc/allwinner-rtc.h                |  18 +-
>  include/hw/rtc/aspeed_rtc.h                   |   9 +-
>  include/hw/rtc/goldfish_rtc.h                 |  10 +-
>  include/hw/rtc/m48t59.h                       |  11 +-
>  include/hw/rtc/mc146818rtc.h                  |   9 +-
>  include/hw/rtc/pl031.h                        |   9 +-
>  include/hw/rtc/xlnx-zynqmp-rtc.h              |  10 +-
>  include/hw/rx/rx62n.h                         |   9 +-
>  include/hw/s390x/3270-ccw.h                   |  19 +-
>  include/hw/s390x/ap-device.h                  |  12 +-
>  include/hw/s390x/css-bridge.h                 |  18 +-
>  include/hw/s390x/event-facility.h             |  34 +-
>  include/hw/s390x/s390-ccw.h                   |  19 +-
>  include/hw/s390x/s390-virtio-ccw.h            |  17 +-
>  include/hw/s390x/s390_flic.h                  |  30 +-
>  include/hw/s390x/sclp.h                       |  14 +-
>  include/hw/s390x/storage-attributes.h         |  37 +-
>  include/hw/s390x/storage-keys.h               |  28 +-
>  include/hw/s390x/tod.h                        |  18 +-
>  include/hw/s390x/vfio-ccw.h                   |   7 +-
>  include/hw/scsi/esp.h                         |   9 +-
>  include/hw/scsi/scsi.h                        |  19 +-
>  include/hw/sd/allwinner-sdhost.h              |  18 +-
>  include/hw/sd/aspeed_sdhci.h                  |  10 +-
>  include/hw/sd/bcm2835_sdhost.h                |  10 +-
>  include/hw/sd/sd.h                            |  23 +-
>  include/hw/sd/sdhci.h                         |  13 +-
>  include/hw/southbridge/piix.h                 |  10 +-
>  include/hw/sparc/sparc32_dma.h                |  34 +-
>  include/hw/sparc/sun4m_iommu.h                |   9 +-
>  include/hw/sparc/sun4u_iommu.h                |   9 +-
>  include/hw/ssi/aspeed_smc.h                   |  18 +-
>  include/hw/ssi/imx_spi.h                      |   9 +-
>  include/hw/ssi/mss-spi.h                      |   9 +-
>  include/hw/ssi/pl022.h                        |   9 +-
>  include/hw/ssi/ssi.h                          |  11 +-
>  include/hw/ssi/stm32f2xx_spi.h                |  10 +-
>  include/hw/ssi/xilinx_spips.h                 |  32 +-
>  include/hw/stream.h                           |  11 +-
>  include/hw/sysbus.h                           |  17 +-
>  include/hw/timer/a9gtimer.h                   |   6 +-
>  include/hw/timer/allwinner-a10-pit.h          |   6 +-
>  include/hw/timer/arm_mptimer.h                |  10 +-
>  include/hw/timer/armv7m_systick.h             |   9 +-
>  include/hw/timer/aspeed_timer.h               |  19 +-
>  include/hw/timer/avr_timer16.h                |  10 +-
>  include/hw/timer/bcm2835_systmr.h             |  10 +-
>  include/hw/timer/cmsdk-apb-dualtimer.h        |   7 +-
>  include/hw/timer/cmsdk-apb-timer.h            |  10 +-
>  include/hw/timer/digic-timer.h                |   9 +-
>  include/hw/timer/i8254.h                      |   9 +-
>  include/hw/timer/imx_epit.h                   |   9 +-
>  include/hw/timer/imx_gpt.h                    |   9 +-
>  include/hw/timer/mss-timer.h                  |  10 +-
>  include/hw/timer/nrf51_timer.h                |   9 +-
>  include/hw/timer/renesas_cmt.h                |   9 +-
>  include/hw/timer/renesas_tmr.h                |   9 +-
>  include/hw/timer/stm32f2xx_timer.h            |  10 +-
>  include/hw/usb.h                              |  17 +-
>  include/hw/usb/chipidea.h                     |   9 +-
>  include/hw/usb/imx-usb-phy.h                  |   9 +-
>  include/hw/vfio/vfio-amd-xgbe.h               |  11 +-
>  include/hw/vfio/vfio-calxeda-xgmac.h          |  21 +-
>  include/hw/vfio/vfio-platform.h               |  19 +-
>  include/hw/virtio/vhost-scsi-common.h         |  10 +-
>  include/hw/virtio/vhost-scsi.h                |  10 +-
>  include/hw/virtio/vhost-user-blk.h            |  10 +-
>  include/hw/virtio/vhost-user-fs.h             |  10 +-
>  include/hw/virtio/vhost-user-scsi.h           |  10 +-
>  include/hw/virtio/vhost-user-vsock.h          |  10 +-
>  include/hw/virtio/vhost-vsock-common.h        |  10 +-
>  include/hw/virtio/vhost-vsock.h               |  10 +-
>  include/hw/virtio/virtio-balloon.h            |  10 +-
>  include/hw/virtio/virtio-blk.h                |  10 +-
>  include/hw/virtio/virtio-bus.h                |  15 +-
>  include/hw/virtio/virtio-crypto.h             |  10 +-
>  include/hw/virtio/virtio-gpu-pci.h            |   5 +-
>  include/hw/virtio/virtio-gpu.h                |  35 +-
>  include/hw/virtio/virtio-input.h              |  29 +-
>  include/hw/virtio/virtio-iommu.h              |  10 +-
>  include/hw/virtio/virtio-mem.h                |  17 +-
>  include/hw/virtio/virtio-mmio.h               |  19 +-
>  include/hw/virtio/virtio-net.h                |   7 +-
>  include/hw/virtio/virtio-pmem.h               |  17 +-
>  include/hw/virtio/virtio-rng.h                |  10 +-
>  include/hw/virtio/virtio-scsi.h               |  19 +-
>  include/hw/virtio/virtio-serial.h             |  22 +-
>  include/hw/virtio/virtio.h                    |  14 +-
>  include/hw/vmstate-if.h                       |  11 +-
>  include/hw/watchdog/cmsdk-apb-watchdog.h      |  10 +-
>  include/hw/watchdog/wdt_aspeed.h              |  19 +-
>  include/hw/watchdog/wdt_diag288.h             |  19 +-
>  include/hw/watchdog/wdt_imx2.h                |   9 +-
>  include/hw/xen/xen-block.h                    |  39 +-
>  include/hw/xen/xen-bus.h                      |  37 +-
>  include/hw/xen/xen-legacy-backend.h           |   5 +-
>  include/io/channel-buffer.h                   |   7 +-
>  include/io/channel-command.h                  |   7 +-
>  include/io/channel-file.h                     |   7 +-
>  include/io/channel-socket.h                   |   7 +-
>  include/io/channel-tls.h                      |   7 +-
>  include/io/channel-websock.h                  |   7 +-
>  include/io/channel.h                          |  12 +-
>  include/io/dns-resolver.h                     |  13 +-
>  include/io/net-listener.h                     |  14 +-
>  include/net/can_emu.h                         |   4 +-
>  include/net/can_host.h                        |  21 +-
>  include/net/filter.h                          |  13 +-
>  include/qom/object.h                          | 327 ++++++++-
>  include/qom/object_interfaces.h               |  13 +-
>  include/scsi/pr-manager.h                     |  16 +-
>  include/sysemu/cryptodev.h                    |  16 +-
>  include/sysemu/hostmem.h                      |  10 +-
>  include/sysemu/hvf.h                          |   5 +-
>  include/sysemu/iothread.h                     |   9 +-
>  include/sysemu/kvm.h                          |   5 +-
>  include/sysemu/rng-random.h                   |   5 +-
>  include/sysemu/rng.h                          |  10 +-
>  include/sysemu/tpm.h                          |  11 +-
>  include/sysemu/tpm_backend.h                  |  12 +-
>  include/sysemu/vhost-user-backend.h           |  17 +-
>  include/ui/console.h                          |  10 +-
>  migration/migration.h                         |  14 +-
>  target/alpha/cpu-qom.h                        |  14 +-
>  target/arm/cpu-qom.h                          |  25 +-
>  target/arm/idau.h                             |  11 +-
>  target/avr/cpu-qom.h                          |  14 +-
>  target/cris/cpu-qom.h                         |  14 +-
>  target/hppa/cpu-qom.h                         |  14 +-
>  target/i386/cpu-qom.h                         |  14 +-
>  target/lm32/cpu-qom.h                         |  14 +-
>  target/m68k/cpu-qom.h                         |  14 +-
>  target/microblaze/cpu-qom.h                   |  14 +-
>  target/mips/cpu-qom.h                         |  14 +-
>  target/moxie/cpu.h                            |  17 +-
>  target/nios2/cpu.h                            |  17 +-
>  target/openrisc/cpu.h                         |  17 +-
>  target/ppc/cpu-qom.h                          |  14 +-
>  target/ppc/cpu.h                              |  11 +-
>  target/riscv/cpu.h                            |  17 +-
>  target/rx/cpu-qom.h                           |  14 +-
>  target/s390x/cpu-qom.h                        |  14 +-
>  target/sh4/cpu-qom.h                          |  14 +-
>  target/sparc/cpu-qom.h                        |  14 +-
>  target/tilegx/cpu.h                           |  17 +-
>  target/tricore/cpu-qom.h                      |  14 +-
>  target/unicore32/cpu-qom.h                    |  14 +-
>  target/xtensa/cpu-qom.h                       |  14 +-
>  accel/tcg/tcg-all.c                           |   9 +-
>  backends/cryptodev-builtin.c                  |   8 +-
>  backends/cryptodev-vhost-user.c               |  11 +-
>  backends/dbus-vmstate.c                       |  16 +-
>  backends/hostmem-file.c                       |   7 +-
>  backends/hostmem-memfd.c                      |   7 +-
>  backends/rng-builtin.c                        |   9 +-
>  backends/rng-egd.c                            |  10 +-
>  backends/tpm/tpm_emulator.c                   |  10 +-
>  backends/tpm/tpm_passthrough.c                |   7 +-
>  chardev/baum.c                                |  13 +-
>  chardev/char-console.c                        |   4 +-
>  chardev/char-fd.c                             |   2 +-
>  chardev/char-file.c                           |   6 +-
>  chardev/char-mux.c                            |   2 +-
>  chardev/char-null.c                           |   2 +-
>  chardev/char-pipe.c                           |   6 +-
>  chardev/char-pty.c                            |  11 +-
>  chardev/char-ringbuf.c                        |  16 +-
>  chardev/char-serial.c                         |   6 +-
>  chardev/char-socket.c                         |  12 +-
>  chardev/char-stdio.c                          |   6 +-
>  chardev/char-udp.c                            |  11 +-
>  chardev/char-win-stdio.c                      |  12 +-
>  chardev/char-win.c                            |   2 +-
>  chardev/char.c                                |   2 +-
>  chardev/msmouse.c                             |  14 +-
>  chardev/spice.c                               |  10 +-
>  chardev/testdev.c                             |  14 +-
>  chardev/wctablet.c                            |  14 +-
>  gdbstub.c                                     |   6 +-
>  hw/acpi/piix4.c                               |  10 +-
>  hw/acpi/vmgenid.c                             |   6 +-
>  hw/alpha/typhoon.c                            |  10 +-
>  hw/arm/collie.c                               |  10 +-
>  hw/arm/highbank.c                             |  10 +-
>  hw/arm/integratorcp.c                         |  28 +-
>  hw/arm/microbit.c                             |  10 +-
>  hw/arm/mps2-tz.c                              |  19 +-
>  hw/arm/mps2.c                                 |  19 +-
>  hw/arm/musca.c                                |  19 +-
>  hw/arm/musicpal.c                             |  73 +-
>  hw/arm/palm.c                                 |  10 +-
>  hw/arm/pxa2xx.c                               |  28 +-
>  hw/arm/pxa2xx_gpio.c                          |   7 +-
>  hw/arm/pxa2xx_pic.c                           |  10 +-
>  hw/arm/raspi.c                                |  19 +-
>  hw/arm/sbsa-ref.c                             |  10 +-
>  hw/arm/spitz.c                                |  61 +-
>  hw/arm/stellaris.c                            |  28 +-
>  hw/arm/strongarm.c                            |  49 +-
>  hw/arm/tosa.c                                 |  18 +-
>  hw/arm/versatilepb.c                          |  10 +-
>  hw/arm/vexpress.c                             |  19 +-
>  hw/arm/xilinx_zynq.c                          |  10 +-
>  hw/arm/xlnx-versal-virt.c                     |  10 +-
>  hw/arm/xlnx-zcu102.c                          |  10 +-
>  hw/arm/z2.c                                   |  17 +-
>  hw/audio/ac97.c                               |  10 +-
>  hw/audio/adlib.c                              |   9 +-
>  hw/audio/cs4231.c                             |  10 +-
>  hw/audio/cs4231a.c                            |   9 +-
>  hw/audio/es1370.c                             |  10 +-
>  hw/audio/gus.c                                |   9 +-
>  hw/audio/hda-codec.c                          |   4 +-
>  hw/audio/intel-hda.c                          |   5 +-
>  hw/audio/marvell_88w8618.c                    |  10 +-
>  hw/audio/milkymist-ac97.c                     |   7 +-
>  hw/audio/pcspk.c                              |   9 +-
>  hw/audio/pl041.c                              |   9 +-
>  hw/audio/sb16.c                               |   9 +-
>  hw/audio/wm8750.c                             |   9 +-
>  hw/avr/arduino.c                              |  19 +-
>  hw/avr/atmega.c                               |  12 +-
>  hw/block/fdc.c                                |  34 +-
>  hw/block/m25p80.c                             |  19 +-
>  hw/block/nand.c                               |   5 +-
>  hw/block/onenand.c                            |   9 +-
>  hw/char/debugcon.c                            |  10 +-
>  hw/char/etraxfs_ser.c                         |  10 +-
>  hw/char/exynos4210_uart.c                     |  10 +-
>  hw/char/grlib_apbuart.c                       |  10 +-
>  hw/char/ipoctal232.c                          |   5 +-
>  hw/char/lm32_juart.c                          |   6 +-
>  hw/char/lm32_uart.c                           |   6 +-
>  hw/char/mcf_uart.c                            |   9 +-
>  hw/char/milkymist-uart.c                      |   7 +-
>  hw/char/parallel.c                            |  10 +-
>  hw/char/sclpconsole-lm.c                      |  10 +-
>  hw/char/sclpconsole.c                         |  10 +-
>  hw/char/serial-isa.c                          |   9 +-
>  hw/char/serial-pci.c                          |   9 +-
>  hw/char/spapr_vty.c                           |  10 +-
>  hw/char/terminal3270.c                        |  10 +-
>  hw/char/virtio-console.c                      |  10 +-
>  hw/char/xilinx_uartlite.c                     |  10 +-
>  hw/core/irq.c                                 |   3 +-
>  hw/cpu/realview_mpcore.c                      |  10 +-
>  hw/display/ads7846.c                          |   9 +-
>  hw/display/artist.c                           |   9 +-
>  hw/display/bochs-display.c                    |  10 +-
>  hw/display/cg3.c                              |   9 +-
>  hw/display/cirrus_vga.c                       |  10 +-
>  hw/display/cirrus_vga_isa.c                   |  10 +-
>  hw/display/exynos4210_fimd.c                  |  10 +-
>  hw/display/g364fb.c                           |   9 +-
>  hw/display/jazz_led.c                         |   9 +-
>  hw/display/milkymist-tmu2.c                   |   7 +-
>  hw/display/milkymist-vgafb.c                  |   7 +-
>  hw/display/next-fb.c                          |   6 +-
>  hw/display/pl110.c                            |   9 +-
>  hw/display/ramfb-standalone.c                 |   9 +-
>  hw/display/sii9022.c                          |   9 +-
>  hw/display/sm501.c                            |  18 +-
>  hw/display/ssd0303.c                          |   9 +-
>  hw/display/ssd0323.c                          |   9 +-
>  hw/display/tcx.c                              |   9 +-
>  hw/display/vga-isa.c                          |   9 +-
>  hw/display/vga-pci.c                          |   9 +-
>  hw/display/vhost-user-gpu-pci.c               |  10 +-
>  hw/display/vhost-user-gpu.c                   |   2 +-
>  hw/display/vhost-user-vga.c                   |  12 +-
>  hw/display/virtio-gpu-pci.c                   |  10 +-
>  hw/display/virtio-vga.c                       |  16 +-
>  hw/display/vmware_vga.c                       |   5 +-
>  hw/dma/i82374.c                               |   9 +-
>  hw/dma/pl330.c                                |   4 +-
>  hw/dma/puv3_dma.c                             |   9 +-
>  hw/dma/pxa2xx_dma.c                           |   9 +-
>  hw/dma/rc4030.c                               |  10 +-
>  hw/dma/sparc32_dma.c                          |   2 +-
>  hw/dma/xilinx_axidma.c                        |  23 +-
>  hw/gpio/gpio_key.c                            |   9 +-
>  hw/gpio/max7310.c                             |   9 +-
>  hw/gpio/mpc8xxx.c                             |   9 +-
>  hw/gpio/pl061.c                               |   9 +-
>  hw/gpio/puv3_gpio.c                           |   9 +-
>  hw/gpio/zaurus.c                              |   6 +-
>  hw/hppa/dino.c                                |  10 +-
>  hw/hppa/lasi.c                                |  10 +-
>  hw/hyperv/hyperv.c                            |   9 +-
>  hw/hyperv/hyperv_testdev.c                    |   5 +-
>  hw/i2c/bitbang_i2c.c                          |   9 +-
>  hw/i2c/exynos4210_i2c.c                       |  10 +-
>  hw/i2c/mpc_i2c.c                              |  10 +-
>  hw/i2c/smbus_eeprom.c                         |  10 +-
>  hw/i2c/smbus_ich9.c                           |  10 +-
>  hw/i2c/versatile_i2c.c                        |   7 +-
>  hw/i386/kvm/clock.c                           |   9 +-
>  hw/i386/kvm/i8254.c                           |  18 +-
>  hw/i386/kvm/i8259.c                           |  12 +-
>  hw/i386/kvmvapic.c                            |   9 +-
>  hw/i386/port92.c                              |   9 +-
>  hw/i386/vmmouse.c                             |  10 +-
>  hw/i386/vmport.c                              |   9 +-
>  hw/i386/xen/xen_platform.c                    |  10 +-
>  hw/i386/xen/xen_pvdevice.c                    |  10 +-
>  hw/ide/ahci.c                                 |   4 +-
>  hw/ide/ich.c                                  |   8 +-
>  hw/ide/isa.c                                  |   9 +-
>  hw/ide/microdrive.c                           |   9 +-
>  hw/ide/mmio.c                                 |   9 +-
>  hw/ide/sii3112.c                              |   8 +-
>  hw/input/adb-kbd.c                            |  18 +-
>  hw/input/adb-mouse.c                          |  18 +-
>  hw/input/lm832x.c                             |   9 +-
>  hw/input/milkymist-softusb.c                  |   7 +-
>  hw/input/pl050.c                              |   9 +-
>  hw/intc/apic.c                                |   6 +-
>  hw/intc/arm_gic_kvm.c                         |  17 +-
>  hw/intc/arm_gicv2m.c                          |   9 +-
>  hw/intc/arm_gicv3_its_kvm.c                   |  14 +-
>  hw/intc/arm_gicv3_kvm.c                       |  15 +-
>  hw/intc/etraxfs_pic.c                         |   5 +-
>  hw/intc/exynos4210_combiner.c                 |  10 +-
>  hw/intc/exynos4210_gic.c                      |  19 +-
>  hw/intc/grlib_irqmp.c                         |   9 +-
>  hw/intc/i8259.c                               |  10 +-
>  hw/intc/lm32_pic.c                            |   6 +-
>  hw/intc/loongson_liointc.c                    |   5 +-
>  hw/intc/nios2_iic.c                           |  10 +-
>  hw/intc/omap_intc.c                           |   2 +-
>  hw/intc/ompic.c                               |   6 +-
>  hw/intc/openpic_kvm.c                         |  10 +-
>  hw/intc/pl190.c                               |   9 +-
>  hw/intc/puv3_intc.c                           |   9 +-
>  hw/intc/s390_flic_kvm.c                       |  12 +-
>  hw/intc/slavio_intctl.c                       |  10 +-
>  hw/intc/xilinx_intc.c                         |   4 +-
>  hw/ipack/tpci200.c                            |  10 +-
>  hw/ipmi/ipmi_bmc_extern.c                     |  10 +-
>  hw/ipmi/isa_ipmi_bt.c                         |  10 +-
>  hw/ipmi/isa_ipmi_kcs.c                        |  10 +-
>  hw/ipmi/pci_ipmi_bt.c                         |  10 +-
>  hw/ipmi/pci_ipmi_kcs.c                        |  10 +-
>  hw/ipmi/smbus_ipmi.c                          |   9 +-
>  hw/isa/i82378.c                               |  10 +-
>  hw/isa/lpc_ich9.c                             |   2 +-
>  hw/isa/pc87312.c                              |   2 +-
>  hw/isa/piix4.c                                |  10 +-
>  hw/isa/vt82c686.c                             |  37 +-
>  hw/m68k/mcf_intc.c                            |   9 +-
>  hw/m68k/next-cube.c                           |   9 +-
>  hw/m68k/next-kbd.c                            |   9 +-
>  hw/m68k/q800.c                                |   2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c               |  10 +-
>  hw/mips/boston.c                              |   9 +-
>  hw/mips/gt64xxx_pci.c                         |  10 +-
>  hw/mips/jazz.c                                |   2 +-
>  hw/mips/malta.c                               |   9 +-
>  hw/misc/applesmc.c                            |   6 +-
>  hw/misc/arm_integrator_debug.c                |  10 +-
>  hw/misc/arm_l2x0.c                            |   9 +-
>  hw/misc/arm_sysctl.c                          |  10 +-
>  hw/misc/debugexit.c                           |  10 +-
>  hw/misc/eccmemctl.c                           |   9 +-
>  hw/misc/edu.c                                 |   9 +-
>  hw/misc/empty_slot.c                          |   9 +-
>  hw/misc/exynos4210_clk.c                      |  10 +-
>  hw/misc/exynos4210_pmu.c                      |  10 +-
>  hw/misc/exynos4210_rng.c                      |  10 +-
>  hw/misc/ivshmem.c                             |  22 +-
>  hw/misc/milkymist-hpdmc.c                     |   7 +-
>  hw/misc/milkymist-pfpu.c                      |   7 +-
>  hw/misc/mst_fpga.c                            |  10 +-
>  hw/misc/pc-testdev.c                          |  10 +-
>  hw/misc/pca9552.c                             |  12 +-
>  hw/misc/pci-testdev.c                         |  10 +-
>  hw/misc/puv3_pm.c                             |   9 +-
>  hw/misc/pvpanic.c                             |  10 +-
>  hw/misc/sga.c                                 |   9 +-
>  hw/misc/slavio_misc.c                         |  17 +-
>  hw/misc/tmp421.c                              |  18 +-
>  hw/misc/zynq_slcr.c                           |   9 +-
>  hw/net/can/can_kvaser_pci.c                   |  10 +-
>  hw/net/can/can_mioe3680_pci.c                 |  10 +-
>  hw/net/can/can_pcm3680_pci.c                  |  10 +-
>  hw/net/dp8393x.c                              |   9 +-
>  hw/net/e1000.c                                |  19 +-
>  hw/net/e1000e.c                               |   9 +-
>  hw/net/etraxfs_eth.c                          |  11 +-
>  hw/net/lan9118.c                              |   9 +-
>  hw/net/milkymist-minimac2.c                   |   7 +-
>  hw/net/mipsnet.c                              |   9 +-
>  hw/net/ne2000-isa.c                           |   9 +-
>  hw/net/opencores_eth.c                        |   9 +-
>  hw/net/pcnet-pci.c                            |  10 +-
>  hw/net/rtl8139.c                              |  10 +-
>  hw/net/smc91c111.c                            |   9 +-
>  hw/net/spapr_llan.c                           |  10 +-
>  hw/net/stellaris_enet.c                       |  10 +-
>  hw/net/sungem.c                               |   9 +-
>  hw/net/sunhme.c                               |   9 +-
>  hw/net/vmxnet3.c                              |  12 +-
>  hw/net/xgmac.c                                |   9 +-
>  hw/net/xilinx_axienet.c                       |  23 +-
>  hw/net/xilinx_ethlite.c                       |   5 +-
>  hw/nvram/ds1225y.c                            |   9 +-
>  hw/nvram/eeprom_at24c.c                       |   9 +-
>  hw/nvram/spapr_nvram.c                        |  10 +-
>  hw/pci-bridge/dec.c                           |   9 +-
>  hw/pci-bridge/gen_pcie_root_port.c            |  10 +-
>  hw/pci-bridge/pci_bridge_dev.c                |   7 +-
>  hw/pci-bridge/pci_expander_bridge.c           |  23 +-
>  hw/pci-bridge/pcie_pci_bridge.c               |  10 +-
>  hw/pci-host/bonito.c                          |  14 +-
>  hw/pci-host/grackle.c                         |  10 +-
>  hw/pci-host/i440fx.c                          |  10 +-
>  hw/pci-host/pnv_phb3.c                        |   5 +-
>  hw/pci-host/pnv_phb4.c                        |   5 +-
>  hw/pci-host/ppce500.c                         |  13 +-
>  hw/pci-host/prep.c                            |  19 +-
>  hw/pci-host/sabre.c                           |   8 +-
>  hw/pci-host/versatile.c                       |  14 +-
>  hw/ppc/mpc8544_guts.c                         |   6 +-
>  hw/ppc/ppc440_pcix.c                          |  10 +-
>  hw/ppc/ppc440_uc.c                            |  10 +-
>  hw/ppc/ppc4xx_pci.c                           |   7 +-
>  hw/ppc/ppce500_spin.c                         |   9 +-
>  hw/ppc/prep_systemio.c                        |  10 +-
>  hw/ppc/rs6000_mc.c                            |  12 +-
>  hw/ppc/spapr_rng.c                            |   7 +-
>  hw/rtc/ds1338.c                               |   9 +-
>  hw/rtc/exynos4210_rtc.c                       |  10 +-
>  hw/rtc/m41t80.c                               |   9 +-
>  hw/rtc/m48t59-isa.c                           |  21 +-
>  hw/rtc/m48t59.c                               |  19 +-
>  hw/rtc/sun4v-rtc.c                            |   9 +-
>  hw/rtc/twl92230.c                             |   9 +-
>  hw/rx/rx-gdbsim.c                             |  19 +-
>  hw/rx/rx62n.c                                 |  12 +-
>  hw/s390x/ap-device.c                          |   2 +-
>  hw/scsi/esp-pci.c                             |  19 +-
>  hw/scsi/esp.c                                 |   6 +-
>  hw/scsi/lsi53c895a.c                          |  10 +-
>  hw/scsi/megasas.c                             |  19 +-
>  hw/scsi/scsi-disk.c                           |  20 +-
>  hw/scsi/spapr_vscsi.c                         |  10 +-
>  hw/scsi/vmw_pvscsi.c                          |  18 +-
>  hw/sd/allwinner-sdhost.c                      |   6 +-
>  hw/sd/bcm2835_sdhost.c                        |   6 +-
>  hw/sd/milkymist-memcard.c                     |   7 +-
>  hw/sd/pl181.c                                 |   9 +-
>  hw/sd/pxa2xx_mmci.c                           |   5 +-
>  hw/sd/sdhci.c                                 |   5 +-
>  hw/sd/ssi-sd.c                                |   9 +-
>  hw/sh4/sh_pci.c                               |  10 +-
>  hw/sparc/sun4m.c                              |  36 +-
>  hw/sparc64/sun4u.c                            |  35 +-
>  hw/ssi/ssi.c                                  |   4 +-
>  hw/ssi/xilinx_spi.c                           |   9 +-
>  hw/timer/altera_timer.c                       |  10 +-
>  hw/timer/arm_timer.c                          |  18 +-
>  hw/timer/cadence_ttc.c                        |  10 +-
>  hw/timer/etraxfs_timer.c                      |  10 +-
>  hw/timer/exynos4210_mct.c                     |  10 +-
>  hw/timer/exynos4210_pwm.c                     |  10 +-
>  hw/timer/grlib_gptimer.c                      |   7 +-
>  hw/timer/hpet.c                               |   9 +-
>  hw/timer/i8254.c                              |  10 +-
>  hw/timer/lm32_timer.c                         |   6 +-
>  hw/timer/milkymist-sysctl.c                   |   7 +-
>  hw/timer/puv3_ost.c                           |   9 +-
>  hw/timer/pxa2xx_timer.c                       |   7 +-
>  hw/timer/slavio_timer.c                       |  10 +-
>  hw/timer/xilinx_timer.c                       |   5 +-
>  hw/tpm/tpm_crb.c                              |   9 +-
>  hw/tpm/tpm_spapr.c                            |  10 +-
>  hw/tpm/tpm_tis_isa.c                          |   9 +-
>  hw/tpm/tpm_tis_sysbus.c                       |   9 +-
>  hw/usb/ccid-card-emulated.c                   |   7 +-
>  hw/usb/ccid-card-passthru.c                   |   5 +-
>  hw/usb/dev-audio.c                            |   9 +-
>  hw/usb/dev-hid.c                              |   9 +-
>  hw/usb/dev-hub.c                              |   9 +-
>  hw/usb/dev-mtp.c                              |   4 +-
>  hw/usb/dev-network.c                          |   9 +-
>  hw/usb/dev-serial.c                           |  11 +-
>  hw/usb/dev-smartcard-reader.c                 |  23 +-
>  hw/usb/dev-storage.c                          |   9 +-
>  hw/usb/dev-uas.c                              |   4 +-
>  hw/usb/dev-wacom.c                            |   9 +-
>  hw/usb/hcd-ohci-pci.c                         |   9 +-
>  hw/usb/hcd-uhci.c                             |   4 +-
>  hw/usb/host-libusb.c                          |   7 +-
>  hw/usb/redirect.c                             |   4 +-
>  hw/usb/tusb6010.c                             |  13 +-
>  hw/vfio/ap.c                                  |  18 +-
>  hw/vfio/pci.c                                 |  22 +-
>  hw/virtio/vhost-scsi-pci.c                    |   5 +-
>  hw/virtio/vhost-user-blk-pci.c                |   5 +-
>  hw/virtio/vhost-user-fs-pci.c                 |   5 +-
>  hw/virtio/vhost-user-input-pci.c              |   5 +-
>  hw/virtio/vhost-user-scsi-pci.c               |   5 +-
>  hw/virtio/vhost-user-vsock-pci.c              |   5 +-
>  hw/virtio/vhost-vsock-pci.c                   |   5 +-
>  hw/virtio/virtio-9p-pci.c                     |  10 +-
>  hw/virtio/virtio-balloon-pci.c                |   5 +-
>  hw/virtio/virtio-blk-pci.c                    |   5 +-
>  hw/virtio/virtio-crypto-pci.c                 |   5 +-
>  hw/virtio/virtio-input-host-pci.c             |   5 +-
>  hw/virtio/virtio-input-pci.c                  |   9 +-
>  hw/virtio/virtio-iommu-pci.c                  |   5 +-
>  hw/virtio/virtio-net-pci.c                    |   5 +-
>  hw/virtio/virtio-rng-pci.c                    |   5 +-
>  hw/virtio/virtio-scsi-pci.c                   |   5 +-
>  hw/virtio/virtio-serial-pci.c                 |   5 +-
>  hw/watchdog/wdt_i6300esb.c                    |   5 +-
>  hw/watchdog/wdt_ib700.c                       |   9 +-
>  iothread.c                                    |   6 +-
>  migration/rdma.c                              |   7 +-
>  net/can/can_socketcan.c                       |  10 +-
>  net/colo-compare.c                            |   9 +-
>  net/dump.c                                    |   7 +-
>  net/filter-buffer.c                           |   9 +-
>  net/filter-mirror.c                           |  17 +-
>  net/filter-replay.c                           |   7 +-
>  net/filter-rewriter.c                         |  27 +-
>  qom/object.c                                  |   6 +-
>  scsi/pr-manager-helper.c                      |  11 +-
>  target/i386/sev.c                             |   7 +-
>  tests/check-qom-interface.c                   |  11 +-
>  tests/check-qom-proplist.c                    |  16 +-
>  tests/test-char.c                             |   4 +-
>  tests/test-qdev-global-props.c                |  13 +-
>  ui/console.c                                  |  15 +-
>  ui/gtk.c                                      |  12 +-
>  ui/input-barrier.c                            |  14 +-
>  ui/input-linux.c                              |  14 +-
>  ui/spice-app.c                                |  17 +-
>  MAINTAINERS                                   |   5 +
>  842 files changed, 7950 insertions(+), 4505 deletions(-)
>  create mode 100644 scripts/codeconverter/codeconverter/__init__.py
>  create mode 100644 scripts/codeconverter/codeconverter/patching.py
>  create mode 100644 scripts/codeconverter/codeconverter/qom_macros.py
>  create mode 100644 scripts/codeconverter/codeconverter/qom_type_info.py
>  create mode 100644 scripts/codeconverter/codeconverter/regexps.py
>  create mode 100644 scripts/codeconverter/codeconverter/test_patching.py
>  create mode 100644 scripts/codeconverter/codeconverter/test_regexps.py
>  create mode 100644 scripts/codeconverter/codeconverter/utils.py
>  create mode 100755 scripts/codeconverter/converter.py
> 
> -- 
> 2.26.2
> 
> -- 
> Eduardo

-- 
Eduardo


