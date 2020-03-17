Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF02AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C5A206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK5OBkgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5A206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEAb-0005dF-Hn
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEE0a-0006t3-5H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEE0Y-0006B5-3o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:19:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEE0X-00067R-T7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=28lZqcCxlwqh008YT0L91ByjTUAIlioPkjcFBN3wVcY=;
 b=aK5OBkgnghOzobSLqM4E7L2zdEKZ8sp13wd0DHA/nO+uz/cHbhoqCgitkq3lKO4csXEsSR
 B6OBhp0bcmmOZa0++s3eAlnfcS+LrLX6rozfV0L3LuagZ9lsBzfLuIJ8/Vx1pgz5Z5DeUi
 L7sRpsWHQy6KPHxw4LxjWCmlXs2vmqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-nt42XhiAMk-Dj6PhbxnDBw-1; Tue, 17 Mar 2020 11:19:50 -0400
X-MC-Unique: nt42XhiAMk-Dj6PhbxnDBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A127800D53
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:19:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56FA36E3EE
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:19:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/62] Misc patches for soft freeze
Date: Tue, 17 Mar 2020 16:19:31 +0100
Message-Id: <1584458374-29068-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a98135f727595382e200d04c2996e868b7925a01=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-reque=
st' into staging (2020-03-16 14:55:59 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 32b9523ad5b44dea87792d5d8f71a87e8cc5803b:

  hw/arm: Let devices own the MemoryRegion they create (2020-03-17 15:18:50=
 +0100)

----------------------------------------------------------------
* Bugfixes all over the place
* get/set_uint cleanups (Felipe)
* Lock guard support (Stefan)
* MemoryRegion ownership cleanup (Philippe)
* AVX512 optimization for buffer_is_zero (Robert)

----------------------------------------------------------------
Christian Ehrhardt (1):
      modules: load modules from versioned /var/run dir

Christophe de Dinechin (1):
      scsi/qemu-pr-helper: Fix out-of-bounds access to trnptid_list[]

Colin Xu (1):
      MAINTAINERS: Add entry for Guest X86 HAXM CPUs

Dr. David Alan Gilbert (1):
      exec/rom_reset: Free rom data during inmigrate skip

Eduardo Habkost (1):
      Use -isystem for linux-headers dir

Felipe Franciosi (4):
      qom/object: enable setter for uint types
      ich9: fix getter type for sci_int property
      ich9: Simplify ich9_lpc_initfn
      qom/object: Use common get/set uint helpers

Jan Kiszka (1):
      hw/i386/intel_iommu: Fix out-of-bounds access on guest IRT

Joe Richey (1):
      optionrom/pvh: scan entire RSDP Area

Julio Faracco (1):
      i386: Fix GCC warning with snprintf when HAX is enabled

Kashyap Chamarthy (1):
      qemu-cpu-models.rst: Document -noTSX, mds-no, taa-no, and tsx-ctrl

Longpeng (Mike) (1):
      cpus: avoid pause_all_vcpus getting stuck due to race

Marc-Andr=C3=A9 Lureau (1):
      build-sys: do not make qemu-ga link with pixman

Matt Borgerson (1):
      memory: Fix start offset for bitmap log_clear hook

Paolo Bonzini (2):
      oslib-posix: initialize mutex and condition variable
      lockable: add QEMU_MAKE_LOCKABLE_NONNULL

Peter Maydell (1):
      softmmu/vl.c: Handle '-cpu help' and '-device help' before 'no defaul=
t machine'

Philippe Mathieu-Daud=C3=A9 (36):
      misc: Replace zero-length arrays with flexible array member (automati=
c)
      misc: Replace zero-length arrays with flexible array member (manual)
      configure: Fix building with SASL on Windows
      tests/docker: Install SASL library to extend code coverage on amd64
      Makefile: Align 'help' target output
      Makefile: Let the 'help' target list the tools targets
      hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB of .bss
      hw/audio/intel-hda: Use memory region alias to reduce .rodata by 4.34=
MB
      hw/usb/quirks: Use smaller types to reduce .rodata by 10KiB
      ui/curses: Make control_characters[] array const
      ui/curses: Move arrays to .heap to save 74KiB of .bss
      memory: Correctly return alias region type
      memory: Simplify memory_region_init_rom_nomigrate() to ease review
      scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
      scripts/cocci: Patch to replace memory_region_init_{ram,readonly -> r=
om}
      hw/arm: Use memory_region_init_rom() with read-only regions
      hw/display: Use memory_region_init_rom() with read-only regions
      hw/m68k: Use memory_region_init_rom() with read-only regions
      hw/net: Use memory_region_init_rom() with read-only regions
      hw/pci-host: Use memory_region_init_rom() with read-only regions
      hw/ppc: Use memory_region_init_rom() with read-only regions
      hw/riscv: Use memory_region_init_rom() with read-only regions
      hw/sh4: Use memory_region_init_rom() with read-only regions
      hw/sparc: Use memory_region_init_rom() with read-only regions
      scripts/cocci: Patch to detect potential use of memory_region_init_ro=
m
      scripts/cocci: Patch to remove unnecessary memory_region_set_readonly=
()
      scripts/cocci: Patch to let devices own their MemoryRegions
      hw/core: Let devices own the MemoryRegion they create
      hw/display: Let devices own the MemoryRegion they create
      hw/dma: Let devices own the MemoryRegion they create
      hw/riscv: Let devices own the MemoryRegion they create
      hw/char: Let devices own the MemoryRegion they create
      hw/arm/stm32: Use memory_region_init_rom() with read-only regions
      hw/ppc/ppc405: Use memory_region_init_rom() with read-only regions
      hw/arm: Remove unnecessary memory_region_set_readonly() on ROM alias
      hw/arm: Let devices own the MemoryRegion they create

Robert Hoo (2):
      configure: add configure option avx512f_opt
      util: add util function buffer_zero_avx512()

Stefan Hajnoczi (2):
      lockable: add lock guards
      lockable: add QemuRecMutex support

Sunil Muthuswamy (3):
      WHPX: TSC get and set should be dependent on VM state
      WHPX: Use QEMU values for trapped CPUID
      WHPX: Use proper synchronization primitives while processing

 MAINTAINERS                                        |  12 ++
 Makefile                                           |  49 +++--
 Makefile.target                                    |   2 +-
 block/linux-aio.c                                  |   2 +-
 block/vmdk.c                                       |   2 +-
 bsd-user/qemu.h                                    |   2 +-
 configure                                          |  62 +++++-
 contrib/libvhost-user/libvhost-user.h              |   2 +-
 contrib/vhost-user-gpu/Makefile.objs               |   6 +-
 .../vhost-user-gpu/{main.c =3D> vhost-user-gpu.c}    |   0
 cpus.c                                             |   6 +-
 docs/interop/vhost-user.rst                        |   4 +-
 docs/system/cpu-models-x86.rst.inc                 |  57 +++++-
 exec.c                                             |   9 +-
 hw/acpi/ich9.c                                     |  99 +---------
 hw/acpi/nvdimm.c                                   |   6 +-
 hw/acpi/pcihp.c                                    |   7 +-
 hw/acpi/piix4.c                                    |  12 +-
 hw/arm/exynos4210.c                                |  14 +-
 hw/arm/fsl-imx25.c                                 |  10 +-
 hw/arm/fsl-imx31.c                                 |   6 +-
 hw/arm/fsl-imx6.c                                  |   6 +-
 hw/arm/fsl-imx6ul.c                                |   9 +-
 hw/arm/mainstone.c                                 |   3 +-
 hw/arm/msf2-soc.c                                  |   6 +-
 hw/arm/nrf51_soc.c                                 |   2 +-
 hw/arm/omap_sx1.c                                  |   6 +-
 hw/arm/palm.c                                      |   3 +-
 hw/arm/spitz.c                                     |   3 +-
 hw/arm/stellaris.c                                 |   3 +-
 hw/arm/stm32f205_soc.c                             |  11 +-
 hw/arm/stm32f405_soc.c                             |  12 +-
 hw/arm/tosa.c                                      |   3 +-
 hw/arm/xlnx-zynqmp.c                               |  11 +-
 hw/audio/fmopl.c                                   |   4 +-
 hw/audio/intel-hda.c                               |  24 +--
 hw/char/sclpconsole-lm.c                           |   2 +-
 hw/char/sclpconsole.c                              |   2 +-
 hw/char/serial.c                                   |   7 +-
 hw/core/loader.c                                   |  25 ++-
 hw/core/platform-bus.c                             |   3 +-
 hw/display/cg3.c                                   |   5 +-
 hw/display/g364fb.c                                |   3 +-
 hw/display/macfb.c                                 |   4 +-
 hw/display/tcx.c                                   |   5 +-
 hw/dma/i8257.c                                     |   2 +-
 hw/dma/rc4030.c                                    |   4 +-
 hw/dma/soc_dma.c                                   |   2 +-
 hw/i386/intel_iommu.c                              |   6 +
 hw/i386/x86.c                                      |   2 +-
 hw/isa/lpc_ich9.c                                  |  27 +--
 hw/m68k/bootinfo.h                                 |   2 +-
 hw/m68k/q800.c                                     |   3 +-
 hw/misc/edu.c                                      |  13 +-
 hw/misc/omap_l4.c                                  |   2 +-
 hw/net/dp8393x.c                                   |   5 +-
 hw/nvram/eeprom93xx.c                              |   2 +-
 hw/pci-host/prep.c                                 |   5 +-
 hw/pci-host/q35.c                                  |  14 +-
 hw/ppc/mac_newworld.c                              |   3 +-
 hw/ppc/mac_oldworld.c                              |   3 +-
 hw/ppc/ppc405_boards.c                             |   6 +-
 hw/ppc/spapr.c                                     |  36 +---
 hw/ppc/spapr_drc.c                                 |   3 +-
 hw/rdma/vmw/pvrdma_qp_ops.c                        |   4 +-
 hw/riscv/sifive_e.c                                |   9 +-
 hw/riscv/sifive_u.c                                |   2 +-
 hw/s390x/virtio-ccw.c                              |   2 +-
 hw/sh4/shix.c                                      |   3 +-
 hw/sparc/leon3.c                                   |   3 +-
 hw/usb/dev-network.c                               |   2 +-
 hw/usb/dev-smartcard-reader.c                      |   4 +-
 hw/usb/quirks.c                                    |   4 +-
 hw/usb/quirks.h                                    |  22 ++-
 hw/virtio/virtio.c                                 |   4 +-
 hw/xen/xen_pt.h                                    |   2 +-
 include/hw/acpi/acpi-defs.h                        |  16 +-
 include/hw/arm/smmu-common.h                       |   2 +-
 include/hw/boards.h                                |   2 +-
 include/hw/i386/intel_iommu.h                      |   3 +-
 include/hw/s390x/event-facility.h                  |   2 +-
 include/hw/s390x/sclp.h                            |   8 +-
 include/hw/virtio/virtio-iommu.h                   |   2 +-
 include/qemu/cpuid.h                               |   3 +
 include/qemu/lockable.h                            |  86 ++++++++-
 include/qom/object.h                               |  48 ++++-
 include/sysemu/cryptodev.h                         |   2 +-
 include/sysemu/whpx.h                              |   7 +
 include/tcg/tcg.h                                  |   2 +-
 memory.c                                           |  31 +--
 net/queue.c                                        |   2 +-
 pc-bios/optionrom/pvh_main.c                       |   2 +-
 pc-bios/s390-ccw/bootmap.h                         |   2 +-
 pc-bios/s390-ccw/sclp.h                            |   2 +-
 plugins/core.c                                     |   7 +-
 plugins/loader.c                                   |  16 +-
 qom/object.c                                       | 212 +++++++++++++++++=
+---
 .../coccinelle/memory-region-housekeeping.cocci    | 159 ++++++++++++++++
 scripts/coccinelle/memory-region-init-ram.cocci    |  38 ----
 scsi/qemu-pr-helper.c                              |  17 +-
 softmmu/vl.c                                       |  26 ++-
 target/arm/cpu.c                                   |  22 +--
 target/i386/hax-posix.c                            |  33 +---
 target/i386/hax-windows.c                          |  33 +---
 target/i386/sev.c                                  | 106 +----------
 target/i386/whp-dispatch.h                         |   9 +
 target/i386/whpx-all.c                             | 162 +++++++++++-----
 target/s390x/ioinst.c                              |   2 +-
 tests/docker/dockerfiles/debian-amd64.docker       |   1 +
 tests/qtest/libqos/ahci.h                          |   2 +-
 ui/console.c                                       |   4 +-
 ui/curses.c                                        |  10 +-
 util/bufferiszero.c                                |  71 ++++++-
 util/module.c                                      |  14 ++
 util/oslib-posix.c                                 |   7 +
 util/qemu-timer.c                                  |  23 ++-
 116 files changed, 1161 insertions(+), 767 deletions(-)
 rename contrib/vhost-user-gpu/{main.c =3D> vhost-user-gpu.c} (100%)
 create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
 delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci
--=20
1.8.3.1


