Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D71C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2972205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS0+WqQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2972205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxtL-000391-Ry
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 18:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1jDxsM-0001Tk-2B
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 18:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1jDxsJ-0001mD-6o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 18:06:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jDxsI-0001Y9-SH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 18:06:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id v11so23241234wrm.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ac0BpTDPqryII/1mSbC6OFEqbPybLVEM8m8/BY/Qgg=;
 b=TS0+WqQApHnQ/SpSmR6cHe/P2mj65zzD+0FcsrpxUcqL+mlNLbEEyDBn1YtNHDQXx5
 ZaCQqGKzHUFiNFLBZcOyKikLHN3YCAeQoRjRHt7+k5w/T9M5P0nGkE9A5z4E0zVrhJEu
 cGuoGxhp/TwBNXURxH0Lycy8avOHBMv4qpBwVCxtVSpJbz1gP85XmfEmwyCh+2vKNECX
 ha+upL47ko8WQNPKB5GbE1ZTWNcJQvUcx7FVD0ayNn4R2U60bbruVAqBOVWSpu//KryA
 vyLg4XUW9pBUzLEUa8jT77qqlOhe5LRxl4NgtTpkQoryMULmbQxuMn8As9N8LPG8PZXB
 ky8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/Ac0BpTDPqryII/1mSbC6OFEqbPybLVEM8m8/BY/Qgg=;
 b=OGbhP2ftr4kyzcQMajdgCh01XMwzhryWXf9ohhP+bnlUt3/aa+qedtqJdWV7xjKPY+
 W45iuFsny2lkDE+MTEIIeV1S9e8BYzPM15Ej1AegKepoYtRFOTe6UmbrmT9ESx/WVy2P
 0XsvkfNw0NQ+3uLPUCJyaPXAzkyfk5IUIPmKkirAFOh+vc3fS27kdrFhAkaphljGI+MK
 cumnrZa7jb4IyFCPxIE4z7SsFscbVmeNYrVnsG9IVbfVztoWW2BKil/bkpgoDey+6eZA
 snq08fnFRtmVffyJwpR1E9WDb3OEUc2FomrZo46Qmd7gZrMLJd2iyBCJTibd5Jjq+iK4
 ruyw==
X-Gm-Message-State: ANhLgQ132kubirR/EqQw8d8z7/ry/lx9jleIEss/y60Dcz8ASRWsLjlK
 DKJR0iN5e63oHF0cKuCmjWFVAr9T
X-Google-Smtp-Source: ADFU+vv5hg/z3zkWB2FKMaKysWUponx75vo9p60jl9SEesliUWVIP2bnoCD1A5bBX0rSXb7d5AYRqg==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr1477473wrc.197.1584396377253; 
 Mon, 16 Mar 2020 15:06:17 -0700 (PDT)
Received: from 640k.lan ([93.56.174.5])
 by smtp.gmail.com with ESMTPSA id v10sm1369392wmh.17.2020.03.16.15.06.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Mar 2020 15:06:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/61] Misc patches for soft freeze
Date: Mon, 16 Mar 2020 23:06:14 +0100
Message-Id: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

The following changes since commit a98135f727595382e200d04c2996e868b7925a01:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9d04fea181318684a899fadd99cef7e04097456b:

  hw/arm: Let devices own the MemoryRegion they create (2020-03-16 23:02:30 +0100)

----------------------------------------------------------------
* Bugfixes all over the place
* get/set_uint cleanups (Felipe)
* Lock guard support (Stefan)
* MemoryRegion ownership cleanup (Philippe)
* AVX512 optimization for buffer_is_zero (Robert)

----------------------------------------------------------------
v1->v2: fix for clang build

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

Marc-André Lureau (1):
      build-sys: do not make qemu-ga link with pixman

Matt Borgerson (1):
      memory: Fix start offset for bitmap log_clear hook

Paolo Bonzini (1):
      oslib-posix: initialize mutex and condition variable

Peter Maydell (1):
      softmmu/vl.c: Handle '-cpu help' and '-device help' before 'no default machine'

Philippe Mathieu-Daudé (36):
      misc: Replace zero-length arrays with flexible array member (automatic)
      misc: Replace zero-length arrays with flexible array member (manual)
      configure: Fix building with SASL on Windows
      tests/docker: Install SASL library to extend code coverage on amd64
      Makefile: Align 'help' target output
      Makefile: Let the 'help' target list the tools targets
      hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB of .bss
      hw/audio/intel-hda: Use memory region alias to reduce .rodata by 4.34MB
      hw/usb/quirks: Use smaller types to reduce .rodata by 10KiB
      ui/curses: Make control_characters[] array const
      ui/curses: Move arrays to .heap to save 74KiB of .bss
      memory: Correctly return alias region type
      memory: Simplify memory_region_init_rom_nomigrate() to ease review
      scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
      scripts/cocci: Patch to replace memory_region_init_{ram,readonly -> rom}
      hw/arm: Use memory_region_init_rom() with read-only regions
      hw/display: Use memory_region_init_rom() with read-only regions
      hw/m68k: Use memory_region_init_rom() with read-only regions
      hw/net: Use memory_region_init_rom() with read-only regions
      hw/pci-host: Use memory_region_init_rom() with read-only regions
      hw/ppc: Use memory_region_init_rom() with read-only regions
      hw/riscv: Use memory_region_init_rom() with read-only regions
      hw/sh4: Use memory_region_init_rom() with read-only regions
      hw/sparc: Use memory_region_init_rom() with read-only regions
      scripts/cocci: Patch to detect potential use of memory_region_init_rom
      scripts/cocci: Patch to remove unnecessary memory_region_set_readonly()
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
 .../vhost-user-gpu/{main.c => vhost-user-gpu.c}    |   0
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
 include/qemu/lockable.h                            |  67 +++++++
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
 qom/object.c                                       | 212 ++++++++++++++++++---
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
 116 files changed, 1145 insertions(+), 764 deletions(-)
 rename contrib/vhost-user-gpu/{main.c => vhost-user-gpu.c} (100%)
 create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
 delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci
-- 
1.8.3.1


