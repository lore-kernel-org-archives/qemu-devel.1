Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD5CC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A1E20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCyfJTjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A1E20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zy1-0007Zc-Dv
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6ZbN-0003JD-9u
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6ZbL-0006oF-7J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:46:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6ZbK-0006nj-VK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:46:15 -0500
Received: by mail-wm1-x335.google.com with SMTP id p9so2863294wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pPxevH10GnT3zkZXiLC8U7Qd1oR0WPPy5f2AcvdaE+I=;
 b=JCyfJTjGbI2oSBDrjd7k9zVhCH6hcAGGqb0azgPhirroQy4DnsKKsjSyuNlKq6tQ7G
 PWg1a64UTQpi3W6N1DNeAGHN+Eo2hTEuJ26LPaJzbj9k3DMZWervA73tKJyapy2cZ9ak
 wRkQvyv3LrX+5eLlQTLGNLx/5XlzTiONtoKTr44qrC9TewhAM9K6t72L5YQsEZXBJrTE
 77yaHV/OmEYrQQF9rDYflRANY2+dwip0n9ds6HngBnDrvMKZE705A5GHfZI2F07Kj8SV
 M4rZHwcQeKHZmmtSwjxJ7noN89b7PiS0kt1cuyWupLh6iccqZcoTmW3UZ7dnkxOuEa1T
 XqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=pPxevH10GnT3zkZXiLC8U7Qd1oR0WPPy5f2AcvdaE+I=;
 b=ALKiqt/rplzU5vLcZqSybX8Q353KsRzDGhndG1bzIgE35rXHHVCGN+bcrw4II3osm8
 3w7+kSa6ofUJYnuapj2LOsy0FYebdUt7nBQnTw2Mux11wAIwLkwE3f6xSV2VbDS/x8Y6
 ebGwI6ZZVawfdEd/Bs3e9kVmhQrZLsvsUJzIihDLrtdwIZ/4W+FERD/EfDKe7HdusZf/
 wMrYI46qdleU8o7z8BfAEUCeHvNL3MAnI9N3Vu1+BOKPha7PSoIPUrBTGukpPMSjvM6j
 cXGTcyqTLFHueKjF0UbOiA/3Lzlz2lDEWdm7KiuaPIp+QIeTtOuWHk0X9mOKsMJfOYzV
 HB3w==
X-Gm-Message-State: APjAAAV+2MrY/9TZjKLw0X+L1F/9SJTcunQCqHWIQ1KlxUI8lVaqvsGP
 +nmgMExMxuEhjHJN8ncbUFtCI9tZ
X-Google-Smtp-Source: APXvYqwQZKaHJQsMs8ogtUbUtp1ZsS9II1fm8Edt14zxPw9Azu9XpTdnZWtOBAGkiuLAwbKB9hOlgA==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr5087141wmc.111.1582634772808; 
 Tue, 25 Feb 2020 04:46:12 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g2sm23173959wrw.76.2020.02.25.04.46.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:46:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 000/104] Misc patches for 2020-02-25 (refactoring and
 Coccinelle edition)
Date: Tue, 25 Feb 2020 13:46:11 +0100
Message-Id: <1582634771-26661-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

The following changes since commit c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-02-24 11:38:54 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9e264985ff0bc86927b44b334bd504687f78659d:

  Merge branch 'exec_rw_const_v4' of https://github.com/philmd/qemu into HEAD (2020-02-25 13:41:48 +0100)

v1->v2: dropped patches 99-130

----------------------------------------------------------------

* device_del fix (Julia)
* FXAM fix (myself)
* memdev refactoring (Igor)
* memory region API cleanups (Peter, Philippe)
* ioeventfd optimization (Stefan)
* new WHPX maintainer (Sunil)
* Large guest startup optimizations (Chen)

----------------------------------------------------------------
Igor Mammedov (79):
      numa: remove deprecated -mem-path fallback to anonymous RAM
      machine: introduce memory-backend property
      machine: alias -mem-path and -mem-prealloc into memory-foo backend
      machine: introduce convenience MachineState::ram
      initialize MachineState::ram in NUMA case
      vl.c: move -m parsing after memory backends has been processed
      vl.c: ensure that ram_size matches size of machine.memory-backend
      alpha/dp264: use memdev for RAM
      arm/aspeed: actually check RAM size
      arm/aspeed: use memdev for RAM
      arm/collie: use memdev for RAM
      arm/cubieboard: use memdev for RAM
      arm/digic_boards: use memdev for RAM
      arm/highbank: use memdev for RAM
      arm/imx25_pdk: drop RAM size fixup
      arm/imx25_pdk: use memdev for RAM
      arm/integratorcp: use memdev for RAM
      arm/kzm: drop RAM size fixup
      arm/kzm: use memdev for RAM
      arm/mcimx6ul-evk: use memdev for RAM
      arm/mcimx7d-sabre: use memdev for RAM
      arm/mps2-tz: use memdev for RAM
      arm/mps2: use memdev for RAM
      arm/musicpal: use memdev for RAM
      arm/nseries: use memdev for RAM
      arm/omap_sx1: use memdev for RAM
      arm/palm: use memdev for RAM
      arm/sabrelite: use memdev for RAM
      arm/raspi: use memdev for RAM
      arm/sbsa-ref: use memdev for RAM
      arm/versatilepb: use memdev for RAM
      arm/vexpress: use memdev for RAM
      arm/virt: use memdev for RAM
      arm/xilinx_zynq: drop RAM size fixup
      arm/xilinx_zynq: use memdev for RAM
      arm/xlnx-versal-virt: use memdev for RAM
      arm/xlnx-zcu102: use memdev for RAM
      s390x/s390-virtio-ccw: use memdev for RAM
      null-machine: use memdev for RAM
      cris/axis_dev88: use memdev for RAM
      hppa: use memdev for RAM
      x86/microvm: use memdev for RAM
      x86/pc: use memdev for RAM
      lm32/lm32_boards: use memdev for RAM
      lm32/milkymist: use memdev for RAM
      m68k/an5206: use memdev for RAM
      m68k/q800: use memdev for RAM
      m68k/mcf5208: use memdev for RAM
      m68k/next-cube: use memdev for RAM
      mips/boston: use memdev for RAM
      mips/mips_fulong2e: drop RAM size fixup
      mips/mips_fulong2e: use memdev for RAM
      mips/mips_jazz: use memdev for RAM
      mips/mips_jazz: add max ram size check
      mips/mips_malta: use memdev for RAM
      mips/mips_mipssim: use memdev for RAM
      mips/mips_r4k: use memdev for RAM
      ppc/e500: drop RAM size fixup
      ppc/e500: use memdev for RAM
      ppc/mac_newworld: use memdev for RAM
      ppc/mac_oldworld: use memdev for RAM
      ppc/pnv: use memdev for RAM
      ppc/ppc405_boards: add RAM size checks
      ppc/ppc405_boards: use memdev for RAM
      ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup
      ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM
      ppc/spapr: use memdev for RAM
      ppc/virtex_ml507: use memdev for RAM
      sparc/leon3: use memdev for RAM
      sparc/sun4m: use memdev for RAM
      sparc/niagara: use memdev for RAM
      remove no longer used memory_region_allocate_system_memory()
      exec: cleanup qemu_minrampagesize()/qemu_maxrampagesize()
      exec: drop bogus mem_path from qemu_ram_alloc_from_fd()
      make mem_path local variable
      hostmem: introduce "prealloc-threads" property
      hostmem: fix strict bind policy
      tests/numa-test: make top level args dynamic and g_autofree(cli) cleanups
      tests:numa-test: use explicit memdev to specify node RAM

Julia Suvorova (1):
      qdev-monitor: Forbid repeated device_del

Paolo Bonzini (3):
      target/i386: check for empty register in FXAM
      Merge tag 'patchew/20200219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-project/qemu into HEAD
      Merge branch 'exec_rw_const_v4' of https://github.com/philmd/qemu into HEAD

Peter Maydell (1):
      Avoid address_space_rw() with a constant is_write argument

Philippe Mathieu-Daudé (19):
      scripts/git.orderfile: Display Cocci scripts before code modifications
      hw: Remove unnecessary cast when calling dma_memory_read()
      exec: Rename ram_ptr variable
      exec: Let flatview API take void pointer arguments
      exec: Let the address_space API use void pointer arguments
      hw/net: Avoid casting non-const pointer, use address_space_write()
      Remove unnecessary cast when using the address_space API
      exec: Let the cpu_[physical]_memory API use void pointer arguments
      Remove unnecessary cast when using the cpu_[physical]_memory API
      hw/ide/internal: Remove unused DMARestartFunc typedef
      hw/ide: Let the DMAIntFunc prototype use a boolean 'is_write' argument
      hw/virtio: Let virtqueue_map_iovec() use a boolean 'is_write' argument
      hw/virtio: Let vhost_memory_map() use a boolean 'is_write' argument
      exec: Let address_space_unmap() use a boolean 'is_write' argument
      Let address_space_rw() calls pass a boolean 'is_write' argument
      exec: Let cpu_[physical]_memory API use a boolean 'is_write' argument
      Let cpu_[physical]_memory() calls pass a boolean 'is_write' argument
      Avoid cpu_physical_memory_rw() with a constant is_write argument
      accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION) return value

Stefan Hajnoczi (1):
      memory: batch allocate ioeventfds[] in address_space_update_ioeventfds()

Sunil Muthuswamy (1):
      WHPX: Assigning maintainer for Windows Hypervisor Platform

bauerchen (1):
      mem-prealloc: optimize large guest startup

 MAINTAINERS                            |   8 ++
 accel/kvm/kvm-all.c                    |  18 ++++-
 backends/hostmem-file.c                |   8 --
 backends/hostmem-memfd.c               |   1 -
 backends/hostmem-ram.c                 |   2 -
 backends/hostmem.c                     |  53 +++++++++----
 dma-helpers.c                          |   4 +-
 exec.c                                 | 131 ++++++++++---------------------
 hw/alpha/alpha_sys.h                   |   2 +-
 hw/alpha/dp264.c                       |   3 +-
 hw/alpha/typhoon.c                     |   8 +-
 hw/arm/aspeed.c                        |  18 ++---
 hw/arm/boot.c                          |   6 +-
 hw/arm/collie.c                        |  16 +++-
 hw/arm/cubieboard.c                    |  25 ++----
 hw/arm/digic_boards.c                  |  40 +++++-----
 hw/arm/highbank.c                      |  10 +--
 hw/arm/imx25_pdk.c                     |  19 ++---
 hw/arm/integratorcp.c                  |   9 +--
 hw/arm/kzm.c                           |  18 ++---
 hw/arm/mcimx6ul-evk.c                  |  25 +++---
 hw/arm/mcimx7d-sabre.c                 |  25 +++---
 hw/arm/mps2-tz.c                       |  15 +++-
 hw/arm/mps2.c                          |  15 +++-
 hw/arm/musicpal.c                      |  18 +++--
 hw/arm/nseries.c                       |  32 ++++----
 hw/arm/omap_sx1.c                      |  20 +++--
 hw/arm/palm.c                          |  19 +++--
 hw/arm/raspi.c                         |  10 +--
 hw/arm/sabrelite.c                     |  23 ++----
 hw/arm/sbsa-ref.c                      |   7 +-
 hw/arm/smmu-common.c                   |   3 +-
 hw/arm/smmuv3.c                        |  10 +--
 hw/arm/versatilepb.c                   |   7 +-
 hw/arm/vexpress.c                      |  14 ++--
 hw/arm/virt.c                          |   7 +-
 hw/arm/xilinx_zynq.c                   |  20 +++--
 hw/arm/xlnx-versal-virt.c              |   7 +-
 hw/arm/xlnx-zcu102.c                   |   7 +-
 hw/core/machine.c                      |  48 ++++++++++++
 hw/core/null-machine.c                 |   8 +-
 hw/core/numa.c                         | 101 +++++++-----------------
 hw/cris/axis_dev88.c                   |   8 +-
 hw/display/exynos4210_fimd.c           |   3 +-
 hw/display/milkymist-tmu2.c            |   8 +-
 hw/display/omap_dss.c                  |   2 +-
 hw/display/omap_lcdc.c                 |  10 +--
 hw/display/ramfb.c                     |   2 +-
 hw/dma/etraxfs_dma.c                   |  25 +++---
 hw/dma/rc4030.c                        |  10 +--
 hw/dma/xlnx-zdma.c                     |  11 +--
 hw/hppa/machine.c                      |  10 +--
 hw/i386/microvm.c                      |  12 ++-
 hw/i386/pc.c                           |  19 +++--
 hw/ide/ahci.c                          |   2 +-
 hw/ide/core.c                          |   2 +-
 hw/ide/macio.c                         |   2 +-
 hw/ide/pci.c                           |   2 +-
 hw/lm32/lm32_boards.c                  |  39 ++++++----
 hw/lm32/milkymist.c                    |  21 +++--
 hw/m68k/an5206.c                       |   5 +-
 hw/m68k/mcf5208.c                      |   5 +-
 hw/m68k/next-cube.c                    |   5 +-
 hw/m68k/q800.c                         |   6 +-
 hw/mips/boston.c                       |  11 ++-
 hw/mips/mips_fulong2e.c                |  15 ++--
 hw/mips/mips_jazz.c                    |  12 ++-
 hw/mips/mips_malta.c                   |  10 +--
 hw/mips/mips_mipssim.c                 |   9 +--
 hw/mips/mips_r4k.c                     |  12 +--
 hw/misc/aspeed_sdmc.c                  |  83 +++++++++++++++-----
 hw/misc/pc-testdev.c                   |   2 +-
 hw/net/cadence_gem.c                   |  21 +++--
 hw/net/dp8393x.c                       |  70 +++++++++--------
 hw/net/i82596.c                        |  25 +++---
 hw/net/lasi_i82596.c                   |   5 +-
 hw/nvram/spapr_nvram.c                 |   4 +-
 hw/ppc/e500.c                          |  17 ++--
 hw/ppc/e500plat.c                      |   1 +
 hw/ppc/mac_newworld.c                  |   6 +-
 hw/ppc/mac_oldworld.c                  |   6 +-
 hw/ppc/mpc8544ds.c                     |   1 +
 hw/ppc/pnv.c                           |   8 +-
 hw/ppc/pnv_lpc.c                       |   8 +-
 hw/ppc/ppc405_boards.c                 |  48 +++++++-----
 hw/ppc/ppc440_bamboo.c                 |  12 ++-
 hw/ppc/ppc440_uc.c                     |   6 +-
 hw/ppc/ppc4xx_devs.c                   |  67 ++++++++--------
 hw/ppc/sam460ex.c                      |   6 +-
 hw/ppc/spapr.c                         |   8 +-
 hw/ppc/spapr_hcall.c                   |   4 +-
 hw/ppc/virtex_ml507.c                  |  12 ++-
 hw/s390x/css.c                         |  12 +--
 hw/s390x/ipl.c                         |   2 +-
 hw/s390x/s390-pci-bus.c                |   2 +-
 hw/s390x/s390-virtio-ccw.c             |   7 +-
 hw/s390x/virtio-ccw.c                  |   2 +-
 hw/scsi/vmw_pvscsi.c                   |   8 +-
 hw/sd/sdhci.c                          |  15 ++--
 hw/sparc/leon3.c                       |   6 +-
 hw/sparc/sun4m.c                       |  74 +++++++++---------
 hw/sparc64/niagara.c                   |   7 +-
 hw/virtio/vhost.c                      |   8 +-
 hw/virtio/virtio.c                     |   7 +-
 hw/xen/xen_pt_graphics.c               |   2 +-
 include/exec/cpu-all.h                 |   2 +-
 include/exec/cpu-common.h              |  12 +--
 include/exec/memory.h                  |  16 ++--
 include/hw/boards.h                    |  54 +++++--------
 include/hw/ide/internal.h              |   3 +-
 include/hw/misc/aspeed_sdmc.h          |   1 +
 include/hw/ppc/ppc4xx.h                |   9 +--
 include/sysemu/hostmem.h               |  20 ++++-
 include/sysemu/numa.h                  |   1 +
 include/sysemu/sysemu.h                |   2 -
 memory.c                               |  18 ++++-
 qdev-monitor.c                         |   6 ++
 qemu-deprecated.texi                   |   9 ---
 qtest.c                                |  52 ++++++-------
 scripts/coccinelle/exec_rw_const.cocci | 111 ++++++++++++++++++++++++++
 scripts/git.orderfile                  |   3 +
 softmmu/vl.c                           |  78 +++++++++++++++----
 target/i386/fpu_helper.c               |   6 +-
 target/i386/hax-all.c                  |   6 +-
 target/i386/hvf/vmx.h                  |   7 +-
 target/i386/hvf/x86_mmu.c              |  12 +--
 target/i386/whpx-all.c                 |   2 +-
 target/s390x/excp_helper.c             |   2 +-
 target/s390x/helper.c                  |   6 +-
 target/s390x/mmu_helper.c              |   2 +-
 tests/qtest/numa-test.c                | 138 +++++++++++++++++----------------
 util/oslib-posix.c                     |  32 ++++++--
 132 files changed, 1256 insertions(+), 1044 deletions(-)
 create mode 100644 scripts/coccinelle/exec_rw_const.cocci

