Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B04EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEA02075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J31KCDbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEA02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Yio-0004M2-HZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YI2-0007fy-HC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:18:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25618
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YHy-0002y7-3K
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QT0BnCxX6h6hzSrbIv1F4Nhno8qg2jd4GuEU2eoZEIw=;
 b=J31KCDbCnuMcM4QQoQ2F8LRJfDjv8bg6p0twk/0ju/4fin9hIXZ/0r1z6ue1lOJOpIuTLG
 7gMa5cWjjWJPjCev89nDyyJY4OhCTZPVFXkuIkrFkByT6kp8ap9jsC+jvC0kh8LeAiNCym
 x4hrd/J0JZI42PODR7TKPjfH0xfGY6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-N3HYcLeYPj6KiIn60djmhg-1; Wed, 19 Aug 2020 20:18:38 -0400
X-MC-Unique: N3HYcLeYPj6KiIn60djmhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FAAF1007466;
 Thu, 20 Aug 2020 00:18:37 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 707A15C1D0;
 Thu, 20 Aug 2020 00:18:36 +0000 (UTC)
Date: Wed, 19 Aug 2020 20:18:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/58] qom: Automated conversion of type checking
 boilerplate
Message-ID: <20200820001835.GB642093@habkost.net>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing everybody who replied to the v1 thread.  I've CCed people
on individual patches using get_maintainer.pl, but forgot to CC
people from the v1 thread (sorry!).

On Wed, Aug 19, 2020 at 08:11:38PM -0400, Eduardo Habkost wrote:
> This is an extension of the series previously submitted by
> Daniel[1], including a script that will convert existing type
> checker macros automatically.
> 
> Changes from series v1 to v2:
> * Don't skip TypeCheckMacro conversion if typedefs
>   are found in typedefs.h
> * Don't look for typedefs if type check macro uses "struct [...]"
> * "qom: Fix G_DEFINE_AUTOPTR_CLEANUP_FUNC" was squashed
>   in the original buggy patch
> * 18 new patches that fix inconsistencies in the code,
>   and make automated changes without --force possible
> * pl110:
>   * Fix typo on commit message
>   * Rename enum values to VERSION_*
> * "[automated]" patches (without --force):
>   * Re-ran script after after the changes mentioned above.
>     Now the patches change many more QOM type checker macros
> * "[semi-automated] Use DECLARE_*CHECKER* when possible (--force mode)":
>   * Now the patch touches very few macros, and all of them
>     have comments explaining why they are unusual
> * Maintainers are now CCed in the cleanup patches
>   (except for the automated ones, because they are too large)
> * TYPE_INFO macro: added commit message note suggested by Daniel
> * Added more details to commit message of "Rename enum constants" patches
> * Removed confusing paragraph mentioning _Generic from "Make type
>   checker functions accept const pointers" commit message
> 
> Link to series v1:
> https://lore.kernel.org/qemu-devel/20200813222625.243136-1-ehabkost@redhat.co=
> m/
> 
> The series is divided in the sections below:
> 
> Constant renaming
> -----------------
> 
> Patches 1-10 will just rename existing constants that will
> conflict with the type checker function names.
> 
> Fix and cleanups of existing code
> ---------------------------------
> 
> Patches 11-41 are changes to existing code
> that will either fix existing issues, delete unused and broken
> macros, or move typedefs around to make code conversion easier.
> 
> Original patches from Daniel
> ----------------------------
> 
> Patches 42-43 are the ones originally submitted by Daniel.
> 
> They introduce the macros:
> * OBJECT_DECLARE_TYPE
> * OBJECT_DECLARE_SIMPLE_TYPE
> * OBJECT_DEFINE_TYPE
> * OBJECT_DEFINE_TYPE_WITH_INTERFACES
> * OBJECT_DEFINE_ABSTRACT_TYPE
> 
> Changes to new macros
> ---------------------
> 
> Patches 44-48 extend the macros introduced by Daniel.  It
> includes small bug fixes, change the arguments to a few macros,
> and introduce a few new macros:
> 
> * DECLARE_INSTANCE_CHECKER
> * DECLARE_CLASS_CHECKERS
> * DECLARE_OBJ_CHECKERS
> * TYPE_INFO
> 
> Automated code conversion
> -------------------------
> 
> Patch 49 is the code conversion script that will look for common
> patterns and change them to use the new macros.
> 
> Patches 50-56 are all automatically generated by that script, to
> gradually transform existing code into DECLARE_*CHECKER or
> OBJECT_DECLARE*_TYPE macros.
> 
> Original crypto QOM patches from Daniel
> ---------------------------------------
> 
> Patches 57-58 are the patches originally sent by Daniel to
> convert the crypto QOM code to use the new macros, rebased and
> updated to pass additional arguments to OBJECT_DECLARE_*.
> 
> [1] https://lore.kernel.org/qemu-devel/20200723181410.3145233-1-berrange@redh=
> at.com/
> 
> Daniel P. Berrang=C3=A9 (4):
>   qom: make object_ref/unref use a void * instead of Object *.
>   qom: provide convenient macros for declaring and defining types
>   crypto: use QOM macros for declaration/definition of secret types
>   crypto: use QOM macros for declaration/definition of TLS creds types
> 
> Eduardo Habkost (54):
>   e1000: Rename QOM class cast macros
>   megasas: Rename QOM class cast macros
>   vmw_pvscsi: Rename QOM class cast macros
>   pl110: Rename pl110_version enum values
>   allwinner-h3: Rename memmap enum constants
>   aspeed_soc: Rename memmap/irqmap enum constants
>   opentitan: Rename memmap enum constants
>   sifive_e: Rename memmap enum constants
>   sifive_u: Rename memmap enum constants
>   aspeed_timer: Fix ASPEED_TIMER macro definition
>   versatile: Fix typo in PCI_VPB_HOST definition
>   virtio-ccw: Fix definition of VIRTIO_CCW_BUS_GET_CLASS
>   hvf: Add missing include
>   hcd-dwc2: Rename USB_*CLASS macros for consistency
>   tulip: Move TulipState typedef to header
>   throttle-groups: Move ThrottleGroup typedef to header
>   pci: Move PCIBusClass typedef to pci.h
>   i8254: Move PITCommonState/PITCommonClass typedefs to i8254.h
>   hvf: Move HVFState typedef to hvf.h
>   mcf_fec: Move mcf_fec_state typedef to header
>   s390_flic: Move KVMS390FLICState typedef to header
>   can_emu: Delete macros for non-existing typedef
>   nubus: Delete unused NUBUS_BRIDGE macro
>   platform-bus: Delete macros for non-existing typedef
>   armsse: Rename QOM macros to avoid conflicts
>   xen-legacy-backend: Add missing typedef XenLegacyDevice
>   spapr: Move typedef SpaprMachineState to spapr.h
>   s390x: Move typedef SCLPEventFacility to event-facility.h
>   vhost-user-gpu: Move QOM macro to header
>   ahci: Move QOM macros to header
>   i8257: Move QOM macro to header
>   ahci: Move QOM macro to header
>   pckbd: Move QOM macro to header
>   vmbus: Move QOM macros to vmbus.h
>   virtio-serial-bus: Move QOM macros to header
>   piix: Move QOM macros to header
>   auxbus: Move QOM macros to header
>   rocker: Move QOM macros to header
>   pxa2xx: Move QOM macros to header
>   mptsas: Move QOM macros to header
>   kvm: Move QOM macros to kvm.h
>   vfio/pci: Move QOM macros to header
>   qom: Allow class type name to be specified in OBJECT_DECLARE*
>   qom: DECLARE_*_CHECKERS macros
>   qom: Make type checker functions accept const pointers
>   qom: TYPE_INFO macro
>   codeconverter: script for automating QOM code cleanups
>   [automated] Delete duplicate QOM typedefs
>   [automated] Use TYPE_INFO macro
>   [automated] Move QOM typedefs and add missing includes
>   [automated] Use DECLARE_*CHECKER* macros
>   [semi-automated] Use DECLARE_*CHECKER* when possible (--force mode)
>   [automated] Use OBJECT_DECLARE_TYPE where possible
>   [automated] Use OBJECT_DECLARE_SIMPLE_TYPE when possible
> 
>  .../codeconverter/codeconverter/__init__.py   |   0
>  .../codeconverter/codeconverter/patching.py   | 381 +++++++++++
>  .../codeconverter/codeconverter/qom_macros.py | 628 ++++++++++++++++++
>  .../codeconverter/qom_type_info.py            | 314 +++++++++
>  .../codeconverter/codeconverter/regexps.py    |  89 +++
>  .../codeconverter/test_patching.py            |  98 +++
>  .../codeconverter/test_regexps.py             | 272 ++++++++
>  scripts/codeconverter/codeconverter/utils.py  |  65 ++
>  scripts/codeconverter/converter.py            | 113 ++++
>  chardev/chardev-internal.h                    |   8 +-
>  hw/9pfs/virtio-9p.h                           |  11 +-
>  hw/audio/intel-hda.h                          |  20 +-
>  hw/avr/atmega.h                               |   9 +-
>  hw/block/nvme.h                               |  10 +-
>  hw/display/ati_int.h                          |   9 +-
>  hw/display/qxl.h                              |   9 +-
>  hw/display/virtio-vga.h                       |  17 +-
>  hw/i386/amd_iommu.h                           |  10 +-
>  hw/ide/ahci_internal.h                        |   5 -
>  hw/misc/tmp105.h                              |   9 +-
>  hw/net/fsl_etsec/etsec.h                      |  10 +-
>  hw/net/rocker/rocker.h                        |   7 +-
>  hw/net/tulip.h                                |   5 +-
>  hw/net/vmxnet3_defs.h                         |   9 +-
>  hw/ppc/e500-ccsr.h                            |   9 +-
>  hw/ppc/e500.h                                 |  19 +-
>  hw/ppc/mac.h                                  |  19 +-
>  hw/rdma/vmw/pvrdma.h                          |   9 +-
>  hw/s390x/ccw-device.h                         |  17 +-
>  hw/s390x/ipl.h                                |   6 +-
>  hw/s390x/s390-pci-bus.h                       |  34 +-
>  hw/s390x/virtio-ccw.h                         | 141 ++--
>  hw/scsi/mptsas.h                              |   7 +-
>  hw/usb/ccid.h                                 |  14 +-
>  hw/usb/hcd-dwc2.h                             |   9 +-
>  hw/usb/hcd-ehci.h                             |  36 +-
>  hw/usb/hcd-ohci.h                             |   9 +-
>  hw/usb/hcd-xhci.h                             |   7 +-
>  hw/vfio/pci.h                                 |  10 +-
>  hw/virtio/virtio-mem-pci.h                    |   5 +-
>  hw/virtio/virtio-pci.h                        |  24 +-
>  hw/virtio/virtio-pmem-pci.h                   |   5 +-
>  hw/xen/xen_pt.h                               |   5 +-
>  include/authz/base.h                          |  15 +-
>  include/authz/list.h                          |  17 +-
>  include/authz/listfile.h                      |  17 +-
>  include/authz/pamacct.h                       |  17 +-
>  include/authz/simple.h                        |  17 +-
>  include/block/throttle-groups.h               |   5 +-
>  include/chardev/char-fd.h                     |   9 +-
>  include/chardev/char-win.h                    |   9 +-
>  include/chardev/char.h                        |  12 +-
>  include/chardev/spice.h                       |   9 +-
>  include/crypto/secret.h                       |  11 +-
>  include/crypto/secret_common.h                |  12 +-
>  include/crypto/secret_keyring.h               |  24 +-
>  include/crypto/tls-cipher-suites.h            |   9 +-
>  include/crypto/tlscreds.h                     |  13 +-
>  include/crypto/tlscredsanon.h                 |  15 +-
>  include/crypto/tlscredspsk.h                  |  14 +-
>  include/crypto/tlscredsx509.h                 |  14 +-
>  include/exec/memory.h                         |  19 +-
>  include/hw/acpi/acpi_dev_interface.h          |  13 +-
>  include/hw/acpi/generic_event_device.h        |  10 +-
>  include/hw/acpi/vmgenid.h                     |   9 +-
>  include/hw/adc/stm32f2xx_adc.h                |  10 +-
>  include/hw/arm/allwinner-a10.h                |   9 +-
>  include/hw/arm/allwinner-h3.h                 |  70 +-
>  include/hw/arm/armsse.h                       |  18 +-
>  include/hw/arm/armv7m.h                       |  17 +-
>  include/hw/arm/aspeed.h                       |  14 +-
>  include/hw/arm/aspeed_soc.h                   | 110 +--
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
>  include/hw/arm/pxa.h                          |  16 +
>  include/hw/arm/smmu-common.h                  |  18 +-
>  include/hw/arm/smmuv3.h                       |  18 +-
>  include/hw/arm/stm32f205_soc.h                |  10 +-
>  include/hw/arm/stm32f405_soc.h                |  10 +-
>  include/hw/arm/virt.h                         |  19 +-
>  include/hw/arm/xlnx-versal.h                  |   9 +-
>  include/hw/arm/xlnx-zynqmp.h                  |  10 +-
>  include/hw/block/flash.h                      |  13 +-
>  include/hw/block/swim.h                       |  12 +-
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
>  include/hw/display/macfb.h                    |  22 +-
>  include/hw/display/xlnx_dp.h                  |   9 +-
>  include/hw/dma/bcm2835_dma.h                  |  10 +-
>  include/hw/dma/i8257.h                        |   8 +-
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
>  include/hw/hyperv/vmbus-bridge.h              |  12 +-
>  include/hw/hyperv/vmbus.h                     |  19 +-
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
>  include/hw/i386/x86-iommu.h                   |   5 +-
>  include/hw/i386/x86.h                         |  19 +-
>  include/hw/ide/ahci.h                         |  17 +-
>  include/hw/ide/internal.h                     |  19 +-
>  include/hw/ide/pci.h                          |   9 +-
>  include/hw/input/adb.h                        |  16 +-
>  include/hw/input/i8042.h                      |   5 +-
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
>  include/hw/isa/pc87312.h                      |   9 +-
>  include/hw/isa/superio.h                      |  19 +-
>  include/hw/m68k/mcf_fec.h                     |   5 +-
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
>  include/hw/misc/auxbus.h                      |  12 +-
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
>  include/hw/misc/imx_ccm.h                     |  11 +-
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
>  include/hw/misc/mos6522.h                     |  11 +-
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
>  include/hw/nubus/nubus.h                      |  19 +-
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
>  include/hw/pci/pci.h                          |  20 +-
>  include/hw/pci/pci_bridge.h                   |   4 +-
>  include/hw/pci/pci_bus.h                      |   4 +-
>  include/hw/pci/pci_host.h                     |  14 +-
>  include/hw/pci/pcie_host.h                    |   5 +-
>  include/hw/pci/pcie_port.h                    |  18 +-
>  include/hw/pcmcia.h                           |  19 +-
>  include/hw/platform-bus.h                     |   9 +-
>  include/hw/ppc/mac_dbdma.h                    |   9 +-
>  include/hw/ppc/openpic.h                      |   9 +-
>  include/hw/ppc/pnv.h                          |  75 +--
>  include/hw/ppc/pnv_core.h                     |  26 +-
>  include/hw/ppc/pnv_homer.h                    |  22 +-
>  include/hw/ppc/pnv_lpc.h                      |  28 +-
>  include/hw/ppc/pnv_occ.h                      |  22 +-
>  include/hw/ppc/pnv_pnor.h                     |   9 +-
>  include/hw/ppc/pnv_psi.h                      |  35 +-
>  include/hw/ppc/pnv_xive.h                     |  16 +-
>  include/hw/ppc/pnv_xscom.h                    |  10 +-
>  include/hw/ppc/spapr.h                        |  24 +-
>  include/hw/ppc/spapr_cpu_core.h               |  17 +-
>  include/hw/ppc/spapr_drc.h                    |  80 +--
>  include/hw/ppc/spapr_irq.h                    |  48 +-
>  include/hw/ppc/spapr_tpm_proxy.h              |   9 +-
>  include/hw/ppc/spapr_vio.h                    |  19 +-
>  include/hw/ppc/spapr_xive.h                   |  19 +-
>  include/hw/ppc/xics.h                         |  31 +-
>  include/hw/ppc/xics_spapr.h                   |   5 +-
>  include/hw/ppc/xive.h                         |  77 ++-
>  include/hw/qdev-core.h                        |  15 +-
>  include/hw/rdma/rdma.h                        |   5 +-
>  include/hw/register.h                         |   4 +-
>  include/hw/resettable.h                       |  11 +-
>  include/hw/riscv/opentitan.h                  |  48 +-
>  include/hw/riscv/riscv_hart.h                 |  10 +-
>  include/hw/riscv/sifive_clint.h               |  10 +-
>  include/hw/riscv/sifive_e.h                   |  57 +-
>  include/hw/riscv/sifive_e_prci.h              |  10 +-
>  include/hw/riscv/sifive_gpio.h                |   9 +-
>  include/hw/riscv/sifive_plic.h                |  10 +-
>  include/hw/riscv/sifive_test.h                |  10 +-
>  include/hw/riscv/sifive_u.h                   |  49 +-
>  include/hw/riscv/sifive_u_otp.h               |  10 +-
>  include/hw/riscv/sifive_u_prci.h              |  10 +-
>  include/hw/riscv/sifive_uart.h                |  10 +-
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
>  include/hw/s390x/ap-device.h                  |  10 +-
>  include/hw/s390x/css-bridge.h                 |  18 +-
>  include/hw/s390x/event-facility.h             |  35 +-
>  include/hw/s390x/s390-ccw.h                   |  19 +-
>  include/hw/s390x/s390-virtio-ccw.h            |  11 +-
>  include/hw/s390x/s390_flic.h                  |  31 +-
>  include/hw/s390x/sclp.h                       |  18 +-
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
>  include/hw/timer/i8254.h                      |  11 +-
>  include/hw/timer/i8254_internal.h             |   8 +-
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
>  include/hw/virtio/virtio-gpu.h                |  33 +-
>  include/hw/virtio/virtio-input.h              |  29 +-
>  include/hw/virtio/virtio-iommu.h              |  10 +-
>  include/hw/virtio/virtio-mem.h                |  17 +-
>  include/hw/virtio/virtio-mmio.h               |  19 +-
>  include/hw/virtio/virtio-net.h                |   7 +-
>  include/hw/virtio/virtio-pmem.h               |  17 +-
>  include/hw/virtio/virtio-rng.h                |  10 +-
>  include/hw/virtio/virtio-scsi.h               |  19 +-
>  include/hw/virtio/virtio-serial.h             |  23 +-
>  include/hw/virtio/virtio.h                    |  14 +-
>  include/hw/vmstate-if.h                       |  11 +-
>  include/hw/watchdog/cmsdk-apb-watchdog.h      |  10 +-
>  include/hw/watchdog/wdt_aspeed.h              |  19 +-
>  include/hw/watchdog/wdt_diag288.h             |  19 +-
>  include/hw/watchdog/wdt_imx2.h                |   9 +-
>  include/hw/xen/xen-block.h                    |  39 +-
>  include/hw/xen/xen-bus.h                      |  37 +-
>  include/hw/xen/xen-legacy-backend.h           |   6 +-
>  include/io/channel-buffer.h                   |   7 +-
>  include/io/channel-command.h                  |   7 +-
>  include/io/channel-file.h                     |   7 +-
>  include/io/channel-socket.h                   |   7 +-
>  include/io/channel-tls.h                      |   7 +-
>  include/io/channel-websock.h                  |   7 +-
>  include/io/channel.h                          |  12 +-
>  include/io/dns-resolver.h                     |  13 +-
>  include/io/net-listener.h                     |  14 +-
>  include/net/can_emu.h                         |   8 +-
>  include/net/can_host.h                        |  21 +-
>  include/net/filter.h                          |  13 +-
>  include/qom/object.h                          | 332 ++++++++-
>  include/qom/object_interfaces.h               |  13 +-
>  include/scsi/pr-manager.h                     |  16 +-
>  include/sysemu/accel.h                        |  18 +-
>  include/sysemu/cryptodev.h                    |  16 +-
>  include/sysemu/hostmem.h                      |  10 +-
>  include/sysemu/hvf.h                          |   8 +-
>  include/sysemu/iothread.h                     |   9 +-
>  include/sysemu/kvm.h                          |   7 +
>  include/sysemu/kvm_int.h                      |   5 -
>  include/sysemu/rng-random.h                   |   5 +-
>  include/sysemu/rng.h                          |  10 +-
>  include/sysemu/tpm.h                          |  11 +-
>  include/sysemu/tpm_backend.h                  |  12 +-
>  include/sysemu/vhost-user-backend.h           |  17 +-
>  include/ui/console.h                          |  10 +-
>  migration/migration.h                         |   6 +-
>  target/alpha/cpu-qom.h                        |  14 +-
>  target/arm/cpu-qom.h                          |  19 +-
>  target/arm/idau.h                             |  11 +-
>  target/avr/cpu-qom.h                          |  14 +-
>  target/cris/cpu-qom.h                         |  14 +-
>  target/hppa/cpu-qom.h                         |  14 +-
>  target/i386/cpu-qom.h                         |  14 +-
>  target/i386/hvf/hvf-i386.h                    |   4 +-
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
>  target/rx/cpu-qom.h                           |   6 +-
>  target/s390x/cpu-qom.h                        |  14 +-
>  target/sh4/cpu-qom.h                          |  14 +-
>  target/sparc/cpu-qom.h                        |  14 +-
>  target/tilegx/cpu.h                           |  17 +-
>  target/tricore/cpu-qom.h                      |  14 +-
>  target/unicore32/cpu-qom.h                    |  14 +-
>  target/xtensa/cpu-qom.h                       |  14 +-
>  accel/accel.c                                 |   6 +-
>  accel/kvm/kvm-all.c                           |   6 +-
>  accel/qtest.c                                 |   6 +-
>  accel/tcg/tcg-all.c                           |  15 +-
>  accel/xen/xen-all.c                           |   6 +-
>  authz/base.c                                  |   6 +-
>  authz/list.c                                  |   7 +-
>  authz/listfile.c                              |   7 +-
>  authz/pamacct.c                               |   7 +-
>  authz/simple.c                                |   7 +-
>  backends/cryptodev-builtin.c                  |  15 +-
>  backends/cryptodev-vhost-user.c               |  18 +-
>  backends/cryptodev.c                          |   7 +-
>  backends/dbus-vmstate.c                       |  23 +-
>  backends/hostmem-file.c                       |  13 +-
>  backends/hostmem-memfd.c                      |   9 +-
>  backends/hostmem-ram.c                        |   6 +-
>  backends/hostmem.c                            |   6 +-
>  backends/rng-builtin.c                        |  15 +-
>  backends/rng-egd.c                            |  16 +-
>  backends/rng-random.c                         |   6 +-
>  backends/rng.c                                |   6 +-
>  backends/tpm/tpm_backend.c                    |   8 +-
>  backends/tpm/tpm_emulator.c                   |  16 +-
>  backends/tpm/tpm_passthrough.c                |  13 +-
>  backends/vhost-user.c                         |   6 +-
>  block/throttle-groups.c                       |  10 +-
>  chardev/baum.c                                |  15 +-
>  chardev/char-console.c                        |   6 +-
>  chardev/char-fd.c                             |   6 +-
>  chardev/char-mux.c                            |   6 +-
>  chardev/char-null.c                           |   6 +-
>  chardev/char-parallel.c                       |  23 +-
>  chardev/char-pty.c                            |  15 +-
>  chardev/char-ringbuf.c                        |  18 +-
>  chardev/char-socket.c                         |  16 +-
>  chardev/char-udp.c                            |  15 +-
>  chardev/char-win-stdio.c                      |  16 +-
>  chardev/char-win.c                            |   6 +-
>  chardev/char.c                                |   6 +-
>  chardev/msmouse.c                             |  16 +-
>  chardev/spice.c                               |  10 +-
>  chardev/testdev.c                             |  16 +-
>  chardev/wctablet.c                            |  16 +-
>  crypto/secret.c                               |  24 +-
>  crypto/secret_common.c                        |  32 +-
>  crypto/secret_keyring.c                       |  28 +-
>  crypto/tls-cipher-suites.c                    |   6 +-
>  crypto/tlscreds.c                             |  25 +-
>  crypto/tlscredsanon.c                         |  23 +-
>  crypto/tlscredspsk.c                          |  25 +-
>  crypto/tlscredsx509.c                         |  29 +-
>  gdbstub.c                                     |   6 +-
>  hw/9pfs/virtio-9p-device.c                    |   6 +-
>  hw/acpi/generic_event_device.c                |   6 +-
>  hw/acpi/piix4.c                               |  16 +-
>  hw/acpi/vmgenid.c                             |   6 +-
>  hw/adc/stm32f2xx_adc.c                        |   6 +-
>  hw/alpha/typhoon.c                            |  18 +-
>  hw/arm/allwinner-a10.c                        |   6 +-
>  hw/arm/allwinner-h3.c                         | 130 ++--
>  hw/arm/armsse.c                               |  26 +-
>  hw/arm/armv7m.c                               |   8 +-
>  hw/arm/aspeed.c                               |   4 +-
>  hw/arm/aspeed_ast2600.c                       | 208 +++---
>  hw/arm/aspeed_soc.c                           | 228 +++----
>  hw/arm/bcm2835_peripherals.c                  |   6 +-
>  hw/arm/bcm2836.c                              |   2 +-
>  hw/arm/boot.c                                 |   6 +-
>  hw/arm/collie.c                               |  16 +-
>  hw/arm/digic.c                                |   6 +-
>  hw/arm/exynos4210.c                           |   6 +-
>  hw/arm/exynos4_boards.c                       |   8 +-
>  hw/arm/fsl-imx25.c                            |   6 +-
>  hw/arm/fsl-imx31.c                            |   6 +-
>  hw/arm/fsl-imx6.c                             |   6 +-
>  hw/arm/fsl-imx6ul.c                           |   6 +-
>  hw/arm/fsl-imx7.c                             |   6 +-
>  hw/arm/gumstix.c                              |   8 +-
>  hw/arm/highbank.c                             |  24 +-
>  hw/arm/integratorcp.c                         |  38 +-
>  hw/arm/microbit.c                             |  16 +-
>  hw/arm/mps2-tz.c                              |  29 +-
>  hw/arm/mps2.c                                 |  29 +-
>  hw/arm/msf2-soc.c                             |   6 +-
>  hw/arm/musca.c                                |  29 +-
>  hw/arm/musicpal.c                             |  95 +--
>  hw/arm/nrf51_soc.c                            |   6 +-
>  hw/arm/nseries.c                              |   8 +-
>  hw/arm/omap_sx1.c                             |   8 +-
>  hw/arm/orangepi.c                             |   6 +-
>  hw/arm/palm.c                                 |  16 +-
>  hw/arm/pxa2xx.c                               |  49 +-
>  hw/arm/pxa2xx_gpio.c                          |  13 +-
>  hw/arm/pxa2xx_pic.c                           |  16 +-
>  hw/arm/raspi.c                                |  19 +-
>  hw/arm/realview.c                             |  12 +-
>  hw/arm/sbsa-ref.c                             |  16 +-
>  hw/arm/smmu-common.c                          |   6 +-
>  hw/arm/spitz.c                                |  89 ++-
>  hw/arm/stellaris.c                            |  46 +-
>  hw/arm/stm32f205_soc.c                        |   6 +-
>  hw/arm/stm32f405_soc.c                        |   6 +-
>  hw/arm/strongarm.c                            |  65 +-
>  hw/arm/tosa.c                                 |  28 +-
>  hw/arm/versatilepb.c                          |  24 +-
>  hw/arm/vexpress.c                             |  29 +-
>  hw/arm/virt.c                                 |   6 +-
>  hw/arm/xilinx_zynq.c                          |  16 +-
>  hw/arm/xlnx-versal-virt.c                     |  16 +-
>  hw/arm/xlnx-versal.c                          |   6 +-
>  hw/arm/xlnx-zcu102.c                          |  16 +-
>  hw/arm/xlnx-zynqmp.c                          |   6 +-
>  hw/arm/z2.c                                   |  17 +-
>  hw/audio/ac97.c                               |  10 +-
>  hw/audio/adlib.c                              |   9 +-
>  hw/audio/cs4231.c                             |  16 +-
>  hw/audio/cs4231a.c                            |   9 +-
>  hw/audio/es1370.c                             |  10 +-
>  hw/audio/gus.c                                |   9 +-
>  hw/audio/hda-codec.c                          |  16 +-
>  hw/audio/intel-hda.c                          |  15 +-
>  hw/audio/marvell_88w8618.c                    |  16 +-
>  hw/audio/milkymist-ac97.c                     |  13 +-
>  hw/audio/pcspk.c                              |  11 +-
>  hw/audio/pl041.c                              |  15 +-
>  hw/audio/sb16.c                               |   9 +-
>  hw/audio/wm8750.c                             |  15 +-
>  hw/avr/arduino.c                              |  19 +-
>  hw/avr/atmega.c                               |  12 +-
>  hw/block/fdc.c                                |  50 +-
>  hw/block/m25p80.c                             |  21 +-
>  hw/block/nand.c                               |  11 +-
>  hw/block/nvme.c                               |   6 +-
>  hw/block/onenand.c                            |  15 +-
>  hw/block/pflash_cfi01.c                       |   6 +-
>  hw/block/pflash_cfi02.c                       |   6 +-
>  hw/block/swim.c                               |  10 +-
>  hw/block/vhost-user-blk.c                     |   6 +-
>  hw/block/virtio-blk.c                         |   6 +-
>  hw/block/xen-block.c                          |  10 +-
>  hw/char/avr_usart.c                           |   6 +-
>  hw/char/bcm2835_aux.c                         |   6 +-
>  hw/char/cadence_uart.c                        |   6 +-
>  hw/char/cmsdk-apb-uart.c                      |   6 +-
>  hw/char/debugcon.c                            |  16 +-
>  hw/char/digic-uart.c                          |   6 +-
>  hw/char/escc.c                                |   6 +-
>  hw/char/etraxfs_ser.c                         |  16 +-
>  hw/char/exynos4210_uart.c                     |  16 +-
>  hw/char/grlib_apbuart.c                       |  16 +-
>  hw/char/ibex_uart.c                           |   6 +-
>  hw/char/imx_serial.c                          |   6 +-
>  hw/char/ipoctal232.c                          |  11 +-
>  hw/char/lm32_juart.c                          |  12 +-
>  hw/char/lm32_uart.c                           |  12 +-
>  hw/char/mcf_uart.c                            |  15 +-
>  hw/char/milkymist-uart.c                      |  13 +-
>  hw/char/nrf51_uart.c                          |   6 +-
>  hw/char/parallel.c                            |  16 +-
>  hw/char/pl011.c                               |   8 +-
>  hw/char/renesas_sci.c                         |   6 +-
>  hw/char/sclpconsole-lm.c                      |  16 +-
>  hw/char/sclpconsole.c                         |  16 +-
>  hw/char/serial-isa.c                          |  15 +-
>  hw/char/serial-pci-multi.c                    |   8 +-
>  hw/char/serial-pci.c                          |  15 +-
>  hw/char/serial.c                              |  10 +-
>  hw/char/spapr_vty.c                           |  12 +-
>  hw/char/stm32f2xx_usart.c                     |   6 +-
>  hw/char/terminal3270.c                        |  16 +-
>  hw/char/virtio-console.c                      |  18 +-
>  hw/char/virtio-serial-bus.c                   |  14 +-
>  hw/char/xilinx_uartlite.c                     |  16 +-
>  hw/core/bus.c                                 |   6 +-
>  hw/core/clock.c                               |   6 +-
>  hw/core/cpu.c                                 |   6 +-
>  hw/core/fw-path-provider.c                    |   6 +-
>  hw/core/generic-loader.c                      |   6 +-
>  hw/core/hotplug.c                             |   6 +-
>  hw/core/irq.c                                 |   9 +-
>  hw/core/machine.c                             |   6 +-
>  hw/core/nmi.c                                 |   6 +-
>  hw/core/or-irq.c                              |   6 +-
>  hw/core/platform-bus.c                        |   6 +-
>  hw/core/qdev.c                                |   6 +-
>  hw/core/register.c                            |   6 +-
>  hw/core/resettable.c                          |   6 +-
>  hw/core/split-irq.c                           |   6 +-
>  hw/core/stream.c                              |   6 +-
>  hw/core/sysbus.c                              |   8 +-
>  hw/core/vmstate-if.c                          |   6 +-
>  hw/cpu/a15mpcore.c                            |   6 +-
>  hw/cpu/a9mpcore.c                             |   6 +-
>  hw/cpu/arm11mpcore.c                          |   6 +-
>  hw/cpu/cluster.c                              |   6 +-
>  hw/cpu/core.c                                 |   6 +-
>  hw/cpu/realview_mpcore.c                      |  16 +-
>  hw/display/ads7846.c                          |  15 +-
>  hw/display/artist.c                           |  15 +-
>  hw/display/ati.c                              |   6 +-
>  hw/display/bcm2835_fb.c                       |   6 +-
>  hw/display/bochs-display.c                    |  16 +-
>  hw/display/cg3.c                              |  15 +-
>  hw/display/cirrus_vga.c                       |  16 +-
>  hw/display/cirrus_vga_isa.c                   |  16 +-
>  hw/display/dpcd.c                             |   6 +-
>  hw/display/exynos4210_fimd.c                  |  16 +-
>  hw/display/g364fb.c                           |  15 +-
>  hw/display/i2c-ddc.c                          |   6 +-
>  hw/display/jazz_led.c                         |  15 +-
>  hw/display/macfb.c                            |   8 +-
>  hw/display/milkymist-tmu2.c                   |  13 +-
>  hw/display/milkymist-vgafb.c                  |  13 +-
>  hw/display/next-fb.c                          |  12 +-
>  hw/display/pl110.c                            |  41 +-
>  hw/display/qxl.c                              |  10 +-
>  hw/display/ramfb-standalone.c                 |  15 +-
>  hw/display/sii9022.c                          |  15 +-
>  hw/display/sm501.c                            |  26 +-
>  hw/display/ssd0303.c                          |  15 +-
>  hw/display/ssd0323.c                          |  15 +-
>  hw/display/tcx.c                              |  15 +-
>  hw/display/vga-isa.c                          |  15 +-
>  hw/display/vga-pci.c                          |  19 +-
>  hw/display/vhost-user-gpu-pci.c               |  10 +-
>  hw/display/vhost-user-gpu.c                   |   9 +-
>  hw/display/vhost-user-vga.c                   |  10 +-
>  hw/display/virtio-gpu-base.c                  |   7 +-
>  hw/display/virtio-gpu-pci.c                   |  12 +-
>  hw/display/virtio-gpu.c                       |   6 +-
>  hw/display/virtio-vga.c                       |  12 +-
>  hw/display/vmware_vga.c                       |  11 +-
>  hw/display/xlnx_dp.c                          |   6 +-
>  hw/dma/bcm2835_dma.c                          |   6 +-
>  hw/dma/i82374.c                               |  15 +-
>  hw/dma/i8257.c                                |   8 +-
>  hw/dma/pl080.c                                |   8 +-
>  hw/dma/pl330.c                                |  10 +-
>  hw/dma/puv3_dma.c                             |  15 +-
>  hw/dma/pxa2xx_dma.c                           |  15 +-
>  hw/dma/rc4030.c                               |  18 +-
>  hw/dma/sparc32_dma.c                          |  12 +-
>  hw/dma/xilinx_axidma.c                        |  29 +-
>  hw/dma/xlnx-zdma.c                            |   6 +-
>  hw/dma/xlnx-zynq-devcfg.c                     |   6 +-
>  hw/dma/xlnx_dpdma.c                           |   6 +-
>  hw/gpio/aspeed_gpio.c                         |  14 +-
>  hw/gpio/bcm2835_gpio.c                        |   6 +-
>  hw/gpio/gpio_key.c                            |  15 +-
>  hw/gpio/imx_gpio.c                            |   6 +-
>  hw/gpio/max7310.c                             |  15 +-
>  hw/gpio/mpc8xxx.c                             |  15 +-
>  hw/gpio/nrf51_gpio.c                          |   6 +-
>  hw/gpio/omap_gpio.c                           |   8 +-
>  hw/gpio/pl061.c                               |  17 +-
>  hw/gpio/puv3_gpio.c                           |  15 +-
>  hw/gpio/zaurus.c                              |  12 +-
>  hw/hppa/dino.c                                |  16 +-
>  hw/hppa/lasi.c                                |  16 +-
>  hw/hyperv/hyperv.c                            |  15 +-
>  hw/hyperv/hyperv_testdev.c                    |  11 +-
>  hw/hyperv/vmbus.c                             |  13 +-
>  hw/i2c/aspeed_i2c.c                           |  12 +-
>  hw/i2c/bitbang_i2c.c                          |  15 +-
>  hw/i2c/core.c                                 |   8 +-
>  hw/i2c/exynos4210_i2c.c                       |  16 +-
>  hw/i2c/imx_i2c.c                              |   6 +-
>  hw/i2c/microbit_i2c.c                         |   6 +-
>  hw/i2c/mpc_i2c.c                              |  16 +-
>  hw/i2c/omap_i2c.c                             |   6 +-
>  hw/i2c/ppc4xx_i2c.c                           |   6 +-
>  hw/i2c/smbus_eeprom.c                         |  16 +-
>  hw/i2c/smbus_ich9.c                           |  16 +-
>  hw/i2c/smbus_slave.c                          |   6 +-
>  hw/i2c/versatile_i2c.c                        |  13 +-
>  hw/i386/amd_iommu.c                           |  10 +-
>  hw/i386/intel_iommu.c                         |   8 +-
>  hw/i386/kvm/apic.c                            |   6 +-
>  hw/i386/kvm/clock.c                           |  15 +-
>  hw/i386/kvm/i8254.c                           |  24 +-
>  hw/i386/kvm/i8259.c                           |  18 +-
>  hw/i386/kvm/ioapic.c                          |   6 +-
>  hw/i386/kvmvapic.c                            |  15 +-
>  hw/i386/microvm.c                             |   6 +-
>  hw/i386/pc.c                                  |   6 +-
>  hw/i386/pc_piix.c                             |   6 +-
>  hw/i386/port92.c                              |  15 +-
>  hw/i386/vmmouse.c                             |  16 +-
>  hw/i386/vmport.c                              |  15 +-
>  hw/i386/x86-iommu.c                           |   6 +-
>  hw/i386/x86.c                                 |   6 +-
>  hw/i386/xen/xen_apic.c                        |   6 +-
>  hw/i386/xen/xen_platform.c                    |  16 +-
>  hw/i386/xen/xen_pvdevice.c                    |  16 +-
>  hw/ide/ahci-allwinner.c                       |   9 +-
>  hw/ide/ahci.c                                 |   6 +-
>  hw/ide/cmd646.c                               |   6 +-
>  hw/ide/ich.c                                  |   6 +-
>  hw/ide/isa.c                                  |  15 +-
>  hw/ide/macio.c                                |   6 +-
>  hw/ide/microdrive.c                           |  17 +-
>  hw/ide/mmio.c                                 |  15 +-
>  hw/ide/pci.c                                  |   6 +-
>  hw/ide/piix.c                                 |  10 +-
>  hw/ide/qdev.c                                 |  14 +-
>  hw/ide/sii3112.c                              |  14 +-
>  hw/ide/via.c                                  |   6 +-
>  hw/input/adb-kbd.c                            |  24 +-
>  hw/input/adb-mouse.c                          |  24 +-
>  hw/input/adb.c                                |   8 +-
>  hw/input/lm832x.c                             |  15 +-
>  hw/input/milkymist-softusb.c                  |  13 +-
>  hw/input/pckbd.c                              |   8 +-
>  hw/input/pl050.c                              |  19 +-
>  hw/input/vhost-user-input.c                   |   6 +-
>  hw/input/virtio-input-hid.c                   |  12 +-
>  hw/input/virtio-input-host.c                  |   6 +-
>  hw/input/virtio-input.c                       |   6 +-
>  hw/intc/allwinner-a10-pic.c                   |   6 +-
>  hw/intc/apic.c                                |  12 +-
>  hw/intc/apic_common.c                         |   6 +-
>  hw/intc/arm_gic.c                             |   6 +-
>  hw/intc/arm_gic_common.c                      |   6 +-
>  hw/intc/arm_gic_kvm.c                         |  23 +-
>  hw/intc/arm_gicv2m.c                          |  15 +-
>  hw/intc/arm_gicv3.c                           |   6 +-
>  hw/intc/arm_gicv3_common.c                    |   6 +-
>  hw/intc/arm_gicv3_its_common.c                |   6 +-
>  hw/intc/arm_gicv3_its_kvm.c                   |  20 +-
>  hw/intc/arm_gicv3_kvm.c                       |  21 +-
>  hw/intc/armv7m_nvic.c                         |   6 +-
>  hw/intc/aspeed_vic.c                          |   6 +-
>  hw/intc/bcm2835_ic.c                          |   6 +-
>  hw/intc/bcm2836_control.c                     |   6 +-
>  hw/intc/etraxfs_pic.c                         |  11 +-
>  hw/intc/exynos4210_combiner.c                 |  16 +-
>  hw/intc/exynos4210_gic.c                      |  31 +-
>  hw/intc/grlib_irqmp.c                         |  15 +-
>  hw/intc/heathrow_pic.c                        |   6 +-
>  hw/intc/i8259.c                               |  16 +-
>  hw/intc/i8259_common.c                        |   6 +-
>  hw/intc/ibex_plic.c                           |   6 +-
>  hw/intc/imx_avic.c                            |   6 +-
>  hw/intc/imx_gpcv2.c                           |   6 +-
>  hw/intc/intc.c                                |   6 +-
>  hw/intc/ioapic.c                              |   6 +-
>  hw/intc/ioapic_common.c                       |   6 +-
>  hw/intc/lm32_pic.c                            |  12 +-
>  hw/intc/loongson_liointc.c                    |  11 +-
>  hw/intc/mips_gic.c                            |   6 +-
>  hw/intc/nios2_iic.c                           |  16 +-
>  hw/intc/omap_intc.c                           |  10 +-
>  hw/intc/ompic.c                               |  12 +-
>  hw/intc/openpic.c                             |   6 +-
>  hw/intc/openpic_kvm.c                         |  16 +-
>  hw/intc/pl190.c                               |  15 +-
>  hw/intc/pnv_xive.c                            |   6 +-
>  hw/intc/puv3_intc.c                           |  15 +-
>  hw/intc/realview_gic.c                        |   6 +-
>  hw/intc/rx_icu.c                              |   6 +-
>  hw/intc/s390_flic.c                           |   8 +-
>  hw/intc/s390_flic_kvm.c                       |  22 +-
>  hw/intc/slavio_intctl.c                       |  16 +-
>  hw/intc/spapr_xive.c                          |   6 +-
>  hw/intc/xics.c                                |  10 +-
>  hw/intc/xics_pnv.c                            |   6 +-
>  hw/intc/xics_spapr.c                          |   6 +-
>  hw/intc/xilinx_intc.c                         |  10 +-
>  hw/intc/xive.c                                |  18 +-
>  hw/intc/xlnx-pmu-iomod-intc.c                 |   6 +-
>  hw/intc/xlnx-zynqmp-ipi.c                     |   6 +-
>  hw/ipack/ipack.c                              |   8 +-
>  hw/ipack/tpci200.c                            |  16 +-
>  hw/ipmi/ipmi.c                                |   8 +-
>  hw/ipmi/ipmi_bmc_extern.c                     |  10 +-
>  hw/ipmi/ipmi_bmc_sim.c                        |   6 +-
>  hw/ipmi/isa_ipmi_bt.c                         |  16 +-
>  hw/ipmi/isa_ipmi_kcs.c                        |  16 +-
>  hw/ipmi/pci_ipmi_bt.c                         |  16 +-
>  hw/ipmi/pci_ipmi_kcs.c                        |  16 +-
>  hw/ipmi/smbus_ipmi.c                          |  15 +-
>  hw/isa/i82378.c                               |  16 +-
>  hw/isa/isa-bus.c                              |  12 +-
>  hw/isa/isa-superio.c                          |   8 +-
>  hw/isa/lpc_ich9.c                             |   6 +-
>  hw/isa/pc87312.c                              |   6 +-
>  hw/isa/piix3.c                                |  14 +-
>  hw/isa/piix4.c                                |  16 +-
>  hw/isa/smc37c669-superio.c                    |   6 +-
>  hw/isa/vt82c686.c                             |  51 +-
>  hw/lm32/lm32_boards.c                         |   8 +-
>  hw/m68k/mcf_intc.c                            |  15 +-
>  hw/m68k/next-cube.c                           |  15 +-
>  hw/m68k/next-kbd.c                            |  15 +-
>  hw/m68k/q800.c                                |   6 +-
>  hw/mem/memory-device.c                        |   6 +-
>  hw/mem/nvdimm.c                               |   6 +-
>  hw/mem/pc-dimm.c                              |   6 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c               |  16 +-
>  hw/mips/boston.c                              |  15 +-
>  hw/mips/cps.c                                 |   6 +-
>  hw/mips/gt64xxx_pci.c                         |  18 +-
>  hw/mips/jazz.c                                |   8 +-
>  hw/mips/malta.c                               |  15 +-
>  hw/misc/a9scu.c                               |   6 +-
>  hw/misc/allwinner-cpucfg.c                    |   6 +-
>  hw/misc/allwinner-h3-ccu.c                    |   6 +-
>  hw/misc/allwinner-h3-dramc.c                  |   6 +-
>  hw/misc/allwinner-h3-sysctrl.c                |   6 +-
>  hw/misc/allwinner-sid.c                       |   6 +-
>  hw/misc/applesmc.c                            |  12 +-
>  hw/misc/arm11scu.c                            |   6 +-
>  hw/misc/arm_integrator_debug.c                |  16 +-
>  hw/misc/arm_l2x0.c                            |  15 +-
>  hw/misc/arm_sysctl.c                          |  16 +-
>  hw/misc/armsse-cpuid.c                        |   6 +-
>  hw/misc/armsse-mhu.c                          |   6 +-
>  hw/misc/aspeed_scu.c                          |  12 +-
>  hw/misc/aspeed_sdmc.c                         |  12 +-
>  hw/misc/aspeed_xdma.c                         |   6 +-
>  hw/misc/auxbus.c                              |  12 +-
>  hw/misc/avr_power.c                           |   6 +-
>  hw/misc/bcm2835_mbox.c                        |   6 +-
>  hw/misc/bcm2835_mphi.c                        |   6 +-
>  hw/misc/bcm2835_property.c                    |   6 +-
>  hw/misc/bcm2835_rng.c                         |   6 +-
>  hw/misc/bcm2835_thermal.c                     |   6 +-
>  hw/misc/debugexit.c                           |  16 +-
>  hw/misc/eccmemctl.c                           |  15 +-
>  hw/misc/edu.c                                 |   9 +-
>  hw/misc/empty_slot.c                          |  15 +-
>  hw/misc/exynos4210_clk.c                      |  12 +-
>  hw/misc/exynos4210_pmu.c                      |  16 +-
>  hw/misc/exynos4210_rng.c                      |  16 +-
>  hw/misc/grlib_ahb_apb_pnp.c                   |   8 +-
>  hw/misc/imx25_ccm.c                           |   6 +-
>  hw/misc/imx31_ccm.c                           |   6 +-
>  hw/misc/imx6_ccm.c                            |   6 +-
>  hw/misc/imx6_src.c                            |   6 +-
>  hw/misc/imx6ul_ccm.c                          |   6 +-
>  hw/misc/imx7_ccm.c                            |   8 +-
>  hw/misc/imx7_gpr.c                            |   6 +-
>  hw/misc/imx7_snvs.c                           |   6 +-
>  hw/misc/imx_ccm.c                             |   6 +-
>  hw/misc/imx_rngc.c                            |   6 +-
>  hw/misc/iotkit-secctl.c                       |   6 +-
>  hw/misc/iotkit-sysctl.c                       |   6 +-
>  hw/misc/iotkit-sysinfo.c                      |   6 +-
>  hw/misc/ivshmem.c                             |  32 +-
>  hw/misc/mac_via.c                             |  10 +-
>  hw/misc/macio/cuda.c                          |   8 +-
>  hw/misc/macio/gpio.c                          |   6 +-
>  hw/misc/macio/mac_dbdma.c                     |   6 +-
>  hw/misc/macio/macio.c                         |  12 +-
>  hw/misc/macio/pmu.c                           |   8 +-
>  hw/misc/max111x.c                             |  10 +-
>  hw/misc/milkymist-hpdmc.c                     |  13 +-
>  hw/misc/milkymist-pfpu.c                      |  13 +-
>  hw/misc/mips_cmgcr.c                          |   6 +-
>  hw/misc/mips_cpc.c                            |   6 +-
>  hw/misc/mips_itu.c                            |   6 +-
>  hw/misc/mos6522.c                             |   6 +-
>  hw/misc/mps2-fpgaio.c                         |   6 +-
>  hw/misc/mps2-scc.c                            |   6 +-
>  hw/misc/msf2-sysreg.c                         |   6 +-
>  hw/misc/mst_fpga.c                            |  16 +-
>  hw/misc/nrf51_rng.c                           |   6 +-
>  hw/misc/pc-testdev.c                          |  16 +-
>  hw/misc/pca9552.c                             |  20 +-
>  hw/misc/pci-testdev.c                         |  16 +-
>  hw/misc/puv3_pm.c                             |  15 +-
>  hw/misc/pvpanic.c                             |  16 +-
>  hw/misc/sga.c                                 |  15 +-
>  hw/misc/slavio_misc.c                         |  25 +-
>  hw/misc/stm32f2xx_syscfg.c                    |   6 +-
>  hw/misc/stm32f4xx_exti.c                      |   6 +-
>  hw/misc/stm32f4xx_syscfg.c                    |   6 +-
>  hw/misc/tmp105.c                              |   6 +-
>  hw/misc/tmp421.c                              |  20 +-
>  hw/misc/tz-mpc.c                              |   8 +-
>  hw/misc/tz-msc.c                              |   6 +-
>  hw/misc/tz-ppc.c                              |   6 +-
>  hw/misc/unimp.c                               |   6 +-
>  hw/misc/vmcoreinfo.c                          |   6 +-
>  hw/misc/zynq-xadc.c                           |   6 +-
>  hw/misc/zynq_slcr.c                           |  15 +-
>  hw/net/allwinner-sun8i-emac.c                 |   6 +-
>  hw/net/allwinner_emac.c                       |   6 +-
>  hw/net/cadence_gem.c                          |   6 +-
>  hw/net/can/can_kvaser_pci.c                   |  16 +-
>  hw/net/can/can_mioe3680_pci.c                 |  16 +-
>  hw/net/can/can_pcm3680_pci.c                  |  16 +-
>  hw/net/dp8393x.c                              |  15 +-
>  hw/net/e1000.c                                |  25 +-
>  hw/net/e1000e.c                               |  15 +-
>  hw/net/etraxfs_eth.c                          |  17 +-
>  hw/net/fsl_etsec/etsec.c                      |   6 +-
>  hw/net/ftgmac100.c                            |   8 +-
>  hw/net/imx_fec.c                              |   8 +-
>  hw/net/lan9118.c                              |  15 +-
>  hw/net/lance.c                                |   6 +-
>  hw/net/lasi_i82596.c                          |   6 +-
>  hw/net/mcf_fec.c                              |  10 +-
>  hw/net/milkymist-minimac2.c                   |  13 +-
>  hw/net/mipsnet.c                              |  15 +-
>  hw/net/msf2-emac.c                            |   6 +-
>  hw/net/ne2000-isa.c                           |  15 +-
>  hw/net/ne2000-pci.c                           |   6 +-
>  hw/net/opencores_eth.c                        |  15 +-
>  hw/net/pcnet-pci.c                            |  16 +-
>  hw/net/rocker/rocker.c                        |  11 +-
>  hw/net/rtl8139.c                              |  16 +-
>  hw/net/smc91c111.c                            |  15 +-
>  hw/net/spapr_llan.c                           |  12 +-
>  hw/net/stellaris_enet.c                       |  16 +-
>  hw/net/sungem.c                               |  15 +-
>  hw/net/sunhme.c                               |  15 +-
>  hw/net/tulip.c                                |  10 +-
>  hw/net/virtio-net.c                           |   6 +-
>  hw/net/vmxnet3.c                              |  14 +-
>  hw/net/xgmac.c                                |  15 +-
>  hw/net/xilinx_axienet.c                       |  29 +-
>  hw/net/xilinx_ethlite.c                       |  11 +-
>  hw/nubus/mac-nubus-bridge.c                   |   6 +-
>  hw/nubus/nubus-bridge.c                       |   6 +-
>  hw/nubus/nubus-bus.c                          |   6 +-
>  hw/nubus/nubus-device.c                       |   6 +-
>  hw/nvram/ds1225y.c                            |  15 +-
>  hw/nvram/eeprom_at24c.c                       |  15 +-
>  hw/nvram/fw_cfg.c                             |  12 +-
>  hw/nvram/mac_nvram.c                          |   6 +-
>  hw/nvram/nrf51_nvm.c                          |   6 +-
>  hw/nvram/spapr_nvram.c                        |  16 +-
>  hw/pci-bridge/dec.c                           |  19 +-
>  hw/pci-bridge/gen_pcie_root_port.c            |  10 +-
>  hw/pci-bridge/i82801b11.c                     |   6 +-
>  hw/pci-bridge/ioh3420.c                       |   6 +-
>  hw/pci-bridge/pci_bridge_dev.c                |  15 +-
>  hw/pci-bridge/pci_expander_bridge.c           |  37 +-
>  hw/pci-bridge/pcie_pci_bridge.c               |  16 +-
>  hw/pci-bridge/pcie_root_port.c                |   6 +-
>  hw/pci-bridge/simba.c                         |   6 +-
>  hw/pci-bridge/xio3130_downstream.c            |   6 +-
>  hw/pci-bridge/xio3130_upstream.c              |   6 +-
>  hw/pci-host/bonito.c                          |  22 +-
>  hw/pci-host/designware.c                      |   8 +-
>  hw/pci-host/gpex.c                            |   8 +-
>  hw/pci-host/grackle.c                         |  18 +-
>  hw/pci-host/i440fx.c                          |  18 +-
>  hw/pci-host/pnv_phb3.c                        |  17 +-
>  hw/pci-host/pnv_phb3_msi.c                    |   6 +-
>  hw/pci-host/pnv_phb3_pbcq.c                   |   6 +-
>  hw/pci-host/pnv_phb4.c                        |  17 +-
>  hw/pci-host/pnv_phb4_pec.c                    |   8 +-
>  hw/pci-host/ppce500.c                         |  21 +-
>  hw/pci-host/prep.c                            |  27 +-
>  hw/pci-host/q35.c                             |   8 +-
>  hw/pci-host/sabre.c                           |   8 +-
>  hw/pci-host/uninorth.c                        |  18 +-
>  hw/pci-host/versatile.c                       |  24 +-
>  hw/pci-host/xen_igd_pt.c                      |   6 +-
>  hw/pci-host/xilinx-pcie.c                     |   8 +-
>  hw/pci/pci.c                                  |  14 +-
>  hw/pci/pci_bridge.c                           |   6 +-
>  hw/pci/pci_host.c                             |   6 +-
>  hw/pci/pcie_host.c                            |   6 +-
>  hw/pci/pcie_port.c                            |   8 +-
>  hw/pcmcia/pcmcia.c                            |   6 +-
>  hw/pcmcia/pxa2xx.c                            |  10 +-
>  hw/ppc/e500.c                                 |   8 +-
>  hw/ppc/e500plat.c                             |   6 +-
>  hw/ppc/mac_newworld.c                         |   6 +-
>  hw/ppc/mac_oldworld.c                         |   6 +-
>  hw/ppc/mpc8544_guts.c                         |  12 +-
>  hw/ppc/mpc8544ds.c                            |   6 +-
>  hw/ppc/pnv_core.c                             |   6 +-
>  hw/ppc/pnv_homer.c                            |  10 +-
>  hw/ppc/pnv_lpc.c                              |  12 +-
>  hw/ppc/pnv_occ.c                              |  10 +-
>  hw/ppc/pnv_pnor.c                             |   6 +-
>  hw/ppc/pnv_psi.c                              |  12 +-
>  hw/ppc/pnv_xscom.c                            |   6 +-
>  hw/ppc/ppc405_boards.c                        |   8 +-
>  hw/ppc/ppc440_pcix.c                          |  16 +-
>  hw/ppc/ppc440_uc.c                            |  16 +-
>  hw/ppc/ppc4xx_pci.c                           |  15 +-
>  hw/ppc/ppce500_spin.c                         |  15 +-
>  hw/ppc/prep_systemio.c                        |  16 +-
>  hw/ppc/rs6000_mc.c                            |  16 +-
>  hw/ppc/spapr.c                                |   6 +-
>  hw/ppc/spapr_drc.c                            |  16 +-
>  hw/ppc/spapr_iommu.c                          |   8 +-
>  hw/ppc/spapr_irq.c                            |   6 +-
>  hw/ppc/spapr_pci.c                            |   6 +-
>  hw/ppc/spapr_rng.c                            |  13 +-
>  hw/ppc/spapr_rtc.c                            |   6 +-
>  hw/ppc/spapr_tpm_proxy.c                      |   2 +-
>  hw/ppc/spapr_vio.c                            |  10 +-
>  hw/rdma/rdma.c                                |   6 +-
>  hw/rdma/vmw/pvrdma_main.c                     |   6 +-
>  hw/riscv/opentitan.c                          |  90 ++-
>  hw/riscv/riscv_hart.c                         |   6 +-
>  hw/riscv/sifive_clint.c                       |   6 +-
>  hw/riscv/sifive_e.c                           |  94 ++-
>  hw/riscv/sifive_e_prci.c                      |   6 +-
>  hw/riscv/sifive_gpio.c                        |   6 +-
>  hw/riscv/sifive_plic.c                        |   6 +-
>  hw/riscv/sifive_test.c                        |   6 +-
>  hw/riscv/sifive_u.c                           | 148 ++---
>  hw/riscv/sifive_u_otp.c                       |   6 +-
>  hw/riscv/sifive_u_prci.c                      |   6 +-
>  hw/riscv/virt.c                               |   6 +-
>  hw/rtc/allwinner-rtc.c                        |  12 +-
>  hw/rtc/aspeed_rtc.c                           |   6 +-
>  hw/rtc/ds1338.c                               |  15 +-
>  hw/rtc/exynos4210_rtc.c                       |  16 +-
>  hw/rtc/goldfish_rtc.c                         |   6 +-
>  hw/rtc/m41t80.c                               |  15 +-
>  hw/rtc/m48t59-isa.c                           |  23 +-
>  hw/rtc/m48t59.c                               |  23 +-
>  hw/rtc/mc146818rtc.c                          |   6 +-
>  hw/rtc/pl031.c                                |   6 +-
>  hw/rtc/sun4v-rtc.c                            |  15 +-
>  hw/rtc/twl92230.c                             |  15 +-
>  hw/rtc/xlnx-zynqmp-rtc.c                      |   6 +-
>  hw/rx/rx-gdbsim.c                             |  19 +-
>  hw/rx/rx62n.c                                 |  12 +-
>  hw/s390x/3270-ccw.c                           |   6 +-
>  hw/s390x/ap-bridge.c                          |   8 +-
>  hw/s390x/ap-device.c                          |   6 +-
>  hw/s390x/ccw-device.c                         |   6 +-
>  hw/s390x/css-bridge.c                         |   8 +-
>  hw/s390x/event-facility.c                     |  10 +-
>  hw/s390x/ipl.c                                |   6 +-
>  hw/s390x/s390-ccw.c                           |   6 +-
>  hw/s390x/s390-pci-bus.c                       |  14 +-
>  hw/s390x/s390-skeys-kvm.c                     |   6 +-
>  hw/s390x/s390-skeys.c                         |   8 +-
>  hw/s390x/s390-stattrib-kvm.c                  |   6 +-
>  hw/s390x/s390-stattrib.c                      |   8 +-
>  hw/s390x/s390-virtio-ccw.c                    |   6 +-
>  hw/s390x/sclp.c                               |   6 +-
>  hw/s390x/sclpcpu.c                            |   6 +-
>  hw/s390x/sclpquiesce.c                        |   6 +-
>  hw/s390x/tod-kvm.c                            |   6 +-
>  hw/s390x/tod-qemu.c                           |   6 +-
>  hw/s390x/tod.c                                |   6 +-
>  hw/s390x/vhost-vsock-ccw.c                    |   6 +-
>  hw/s390x/virtio-ccw-9p.c                      |   6 +-
>  hw/s390x/virtio-ccw-balloon.c                 |   6 +-
>  hw/s390x/virtio-ccw-blk.c                     |   6 +-
>  hw/s390x/virtio-ccw-crypto.c                  |   6 +-
>  hw/s390x/virtio-ccw-gpu.c                     |   6 +-
>  hw/s390x/virtio-ccw-input.c                   |  14 +-
>  hw/s390x/virtio-ccw-net.c                     |   6 +-
>  hw/s390x/virtio-ccw-rng.c                     |   6 +-
>  hw/s390x/virtio-ccw-scsi.c                    |   4 +-
>  hw/s390x/virtio-ccw-serial.c                  |   6 +-
>  hw/s390x/virtio-ccw.c                         |   8 +-
>  hw/scsi/esp-pci.c                             |  27 +-
>  hw/scsi/esp.c                                 |   6 +-
>  hw/scsi/lsi53c895a.c                          |  18 +-
>  hw/scsi/megasas.c                             |  29 +-
>  hw/scsi/mptsas.c                              |   5 -
>  hw/scsi/scsi-bus.c                            |   8 +-
>  hw/scsi/scsi-disk.c                           |  30 +-
>  hw/scsi/scsi-generic.c                        |   6 +-
>  hw/scsi/spapr_vscsi.c                         |  16 +-
>  hw/scsi/vhost-scsi-common.c                   |   6 +-
>  hw/scsi/vhost-scsi.c                          |   6 +-
>  hw/scsi/vhost-user-scsi.c                     |   6 +-
>  hw/scsi/virtio-scsi.c                         |   8 +-
>  hw/scsi/vmw_pvscsi.c                          |  29 +-
>  hw/sd/allwinner-sdhost.c                      |  18 +-
>  hw/sd/aspeed_sdhci.c                          |   6 +-
>  hw/sd/bcm2835_sdhost.c                        |  14 +-
>  hw/sd/core.c                                  |   6 +-
>  hw/sd/milkymist-memcard.c                     |  13 +-
>  hw/sd/pl181.c                                 |  15 +-
>  hw/sd/pxa2xx_mmci.c                           |  16 +-
>  hw/sd/sd.c                                    |   6 +-
>  hw/sd/sdhci-pci.c                             |   6 +-
>  hw/sd/sdhci.c                                 |  17 +-
>  hw/sd/ssi-sd.c                                |  15 +-
>  hw/sh4/sh_pci.c                               |  18 +-
>  hw/sparc/sun4m.c                              |  62 +-
>  hw/sparc/sun4m_iommu.c                        |   8 +-
>  hw/sparc64/niagara.c                          |   6 +-
>  hw/sparc64/sun4u.c                            |  45 +-
>  hw/sparc64/sun4u_iommu.c                      |   8 +-
>  hw/ssi/aspeed_smc.c                           |   2 +-
>  hw/ssi/imx_spi.c                              |   6 +-
>  hw/ssi/mss-spi.c                              |   6 +-
>  hw/ssi/pl022.c                                |   6 +-
>  hw/ssi/ssi.c                                  |  12 +-
>  hw/ssi/stm32f2xx_spi.c                        |   6 +-
>  hw/ssi/xilinx_spi.c                           |  15 +-
>  hw/ssi/xilinx_spips.c                         |  10 +-
>  hw/timer/a9gtimer.c                           |   6 +-
>  hw/timer/allwinner-a10-pit.c                  |   6 +-
>  hw/timer/altera_timer.c                       |  16 +-
>  hw/timer/arm_mptimer.c                        |   6 +-
>  hw/timer/arm_timer.c                          |  26 +-
>  hw/timer/armv7m_systick.c                     |   6 +-
>  hw/timer/aspeed_timer.c                       |  12 +-
>  hw/timer/avr_timer16.c                        |   6 +-
>  hw/timer/bcm2835_systmr.c                     |   6 +-
>  hw/timer/cadence_ttc.c                        |  16 +-
>  hw/timer/cmsdk-apb-dualtimer.c                |   6 +-
>  hw/timer/cmsdk-apb-timer.c                    |   6 +-
>  hw/timer/digic-timer.c                        |   6 +-
>  hw/timer/etraxfs_timer.c                      |  16 +-
>  hw/timer/exynos4210_mct.c                     |  16 +-
>  hw/timer/exynos4210_pwm.c                     |  16 +-
>  hw/timer/grlib_gptimer.c                      |  13 +-
>  hw/timer/hpet.c                               |  15 +-
>  hw/timer/i8254.c                              |  16 +-
>  hw/timer/i8254_common.c                       |   6 +-
>  hw/timer/imx_epit.c                           |   6 +-
>  hw/timer/imx_gpt.c                            |  12 +-
>  hw/timer/lm32_timer.c                         |  12 +-
>  hw/timer/milkymist-sysctl.c                   |  13 +-
>  hw/timer/mss-timer.c                          |   6 +-
>  hw/timer/nrf51_timer.c                        |   6 +-
>  hw/timer/puv3_ost.c                           |  15 +-
>  hw/timer/pxa2xx_timer.c                       |  17 +-
>  hw/timer/renesas_cmt.c                        |   6 +-
>  hw/timer/renesas_tmr.c                        |   6 +-
>  hw/timer/slavio_timer.c                       |  16 +-
>  hw/timer/stm32f2xx_timer.c                    |   6 +-
>  hw/timer/xilinx_timer.c                       |  11 +-
>  hw/tpm/tpm_crb.c                              |  15 +-
>  hw/tpm/tpm_spapr.c                            |  16 +-
>  hw/tpm/tpm_tis_isa.c                          |  15 +-
>  hw/tpm/tpm_tis_sysbus.c                       |  15 +-
>  hw/usb/bus.c                                  |   8 +-
>  hw/usb/ccid-card-emulated.c                   |  13 +-
>  hw/usb/ccid-card-passthru.c                   |  11 +-
>  hw/usb/chipidea.c                             |   6 +-
>  hw/usb/dev-audio.c                            |  11 +-
>  hw/usb/dev-hid.c                              |  17 +-
>  hw/usb/dev-hub.c                              |  15 +-
>  hw/usb/dev-mtp.c                              |  10 +-
>  hw/usb/dev-network.c                          |  15 +-
>  hw/usb/dev-serial.c                           |  15 +-
>  hw/usb/dev-smartcard-reader.c                 |  23 +-
>  hw/usb/dev-storage.c                          |  19 +-
>  hw/usb/dev-uas.c                              |  10 +-
>  hw/usb/dev-wacom.c                            |  11 +-
>  hw/usb/hcd-dwc2.c                             |  14 +-
>  hw/usb/hcd-ehci-pci.c                         |   2 +-
>  hw/usb/hcd-ehci-sysbus.c                      |  18 +-
>  hw/usb/hcd-ohci-pci.c                         |  15 +-
>  hw/usb/hcd-ohci.c                             |   6 +-
>  hw/usb/hcd-uhci.c                             |   6 +-
>  hw/usb/hcd-xhci-nec.c                         |   6 +-
>  hw/usb/hcd-xhci.c                             |   8 +-
>  hw/usb/host-libusb.c                          |  13 +-
>  hw/usb/imx-usb-phy.c                          |   6 +-
>  hw/usb/redirect.c                             |  10 +-
>  hw/usb/tusb6010.c                             |  15 +-
>  hw/vfio/amd-xgbe.c                            |   6 +-
>  hw/vfio/ap.c                                  |  16 +-
>  hw/vfio/calxeda-xgmac.c                       |   6 +-
>  hw/vfio/ccw.c                                 |   6 +-
>  hw/vfio/igd.c                                 |   6 +-
>  hw/vfio/pci.c                                 |  11 +-
>  hw/vfio/platform.c                            |   6 +-
>  hw/virtio/vhost-scsi-pci.c                    |   5 +-
>  hw/virtio/vhost-user-blk-pci.c                |   5 +-
>  hw/virtio/vhost-user-fs-pci.c                 |   5 +-
>  hw/virtio/vhost-user-fs.c                     |   6 +-
>  hw/virtio/vhost-user-input-pci.c              |   5 +-
>  hw/virtio/vhost-user-scsi-pci.c               |   5 +-
>  hw/virtio/vhost-user-vsock-pci.c              |   5 +-
>  hw/virtio/vhost-user-vsock.c                  |   6 +-
>  hw/virtio/vhost-vsock-common.c                |   6 +-
>  hw/virtio/vhost-vsock-pci.c                   |   5 +-
>  hw/virtio/vhost-vsock.c                       |   6 +-
>  hw/virtio/virtio-9p-pci.c                     |  10 +-
>  hw/virtio/virtio-balloon-pci.c                |   5 +-
>  hw/virtio/virtio-balloon.c                    |   6 +-
>  hw/virtio/virtio-blk-pci.c                    |   5 +-
>  hw/virtio/virtio-bus.c                        |   6 +-
>  hw/virtio/virtio-crypto-pci.c                 |   5 +-
>  hw/virtio/virtio-crypto.c                     |   6 +-
>  hw/virtio/virtio-input-host-pci.c             |   5 +-
>  hw/virtio/virtio-input-pci.c                  |  13 +-
>  hw/virtio/virtio-iommu-pci.c                  |   5 +-
>  hw/virtio/virtio-iommu.c                      |   8 +-
>  hw/virtio/virtio-mem.c                        |   6 +-
>  hw/virtio/virtio-mmio.c                       |   8 +-
>  hw/virtio/virtio-net-pci.c                    |   5 +-
>  hw/virtio/virtio-pci.c                        |   4 +-
>  hw/virtio/virtio-pmem.c                       |   6 +-
>  hw/virtio/virtio-rng-pci.c                    |   5 +-
>  hw/virtio/virtio-rng.c                        |   6 +-
>  hw/virtio/virtio-scsi-pci.c                   |   5 +-
>  hw/virtio/virtio-serial-pci.c                 |   5 +-
>  hw/virtio/virtio.c                            |   6 +-
>  hw/watchdog/cmsdk-apb-watchdog.c              |   8 +-
>  hw/watchdog/wdt_aspeed.c                      |   8 +-
>  hw/watchdog/wdt_diag288.c                     |   2 +-
>  hw/watchdog/wdt_i6300esb.c                    |   7 +-
>  hw/watchdog/wdt_ib700.c                       |  11 +-
>  hw/watchdog/wdt_imx2.c                        |   2 +-
>  hw/xen/xen-bus.c                              |  10 +-
>  hw/xen/xen-legacy-backend.c                   |  10 +-
>  hw/xen/xen_pt.c                               |   6 +-
>  hw/xtensa/xtfpga.c                            |  20 +-
>  io/channel-buffer.c                           |   6 +-
>  io/channel-command.c                          |   6 +-
>  io/channel-file.c                             |   6 +-
>  io/channel-socket.c                           |   6 +-
>  io/channel-tls.c                              |   6 +-
>  io/channel-websock.c                          |   6 +-
>  io/channel.c                                  |   6 +-
>  io/dns-resolver.c                             |   6 +-
>  io/net-listener.c                             |   6 +-
>  iothread.c                                    |  12 +-
>  migration/migration.c                         |   6 +-
>  migration/rdma.c                              |  13 +-
>  net/can/can_core.c                            |   6 +-
>  net/can/can_host.c                            |   6 +-
>  net/can/can_socketcan.c                       |  16 +-
>  net/colo-compare.c                            |  15 +-
>  net/dump.c                                    |  13 +-
>  net/filter-buffer.c                           |  15 +-
>  net/filter-mirror.c                           |  25 +-
>  net/filter-replay.c                           |  13 +-
>  net/filter-rewriter.c                         |  17 +-
>  net/filter.c                                  |   6 +-
>  qom/container.c                               |   6 +-
>  qom/object.c                                  |   6 +-
>  scsi/pr-manager-helper.c                      |  17 +-
>  scsi/pr-manager.c                             |   7 +-
>  softmmu/memory.c                              |   8 +-
>  target/arm/cpu.c                              |   4 +-
>  target/arm/cpu64.c                            |   2 +-
>  target/hppa/cpu.c                             |   6 +-
>  target/i386/cpu.c                             |   8 +-
>  target/i386/hax-all.c                         |   6 +-
>  target/i386/hvf/hvf.c                         |   6 +-
>  target/i386/sev.c                             |  14 +-
>  target/i386/whpx-all.c                        |   6 +-
>  target/microblaze/cpu.c                       |   6 +-
>  target/mips/cpu.c                             |   2 +-
>  target/nios2/cpu.c                            |   6 +-
>  target/ppc/translate_init.inc.c               |   4 +-
>  target/rx/cpu.c                               |   8 +-
>  target/s390x/cpu.c                            |   6 +-
>  target/s390x/cpu_models.c                     |   6 +-
>  target/sparc/cpu.c                            |   2 +-
>  target/tilegx/cpu.c                           |   6 +-
>  target/xtensa/cpu.c                           |   6 +-
>  tests/check-qom-interface.c                   |  11 +-
>  tests/check-qom-proplist.c                    |  16 +-
>  tests/test-qdev-global-props.c                |  13 +-
>  ui/console.c                                  |  15 +-
>  ui/gtk.c                                      |   8 +-
>  ui/input-barrier.c                            |  20 +-
>  ui/input-linux.c                              |  20 +-
>  ui/spice-app.c                                |   9 +-
>  1332 files changed, 9573 insertions(+), 9591 deletions(-)
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
> --=20
> 2.26.2
> 

-- 
Eduardo


