Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5C2C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659852072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 21:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHGAciNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659852072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j73wk-0003lD-J2
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 16:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j73tu-0007t6-5B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j73tp-0004zU-Qc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:07:26 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:40871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j73tp-0004xm-EP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 16:07:21 -0500
Received: by mail-oi1-x235.google.com with SMTP id a142so1003635oii.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=u7cahRt0K/zO6knywAVlpOJmsPLsuqwLqkRRaZSWNE8=;
 b=bHGAciNaOYtvDHPuNqxPAVZX2Sqekb/84nuq1oNkPTQZOBrtgZYx648mIYgVwIOh9/
 GVeuLbPXt9kCNaz6LdtitdvfVTmUlhK36e6uzxvRVnWYzopqFjRiloDuD9GHlg1QO58a
 f+S2hWH5r6ihIvwOG9gXXAPUDjMb7E+G1nUH2LIcwkZTPAmEyyXsu7qrdXjM92kzlspc
 udsl6ydkzBWHuTY99xLB1pGbfAlowEBbjbeDpYtBHYUsjo8Tn87v1RTfw1mIKJpeeeOu
 bUReFftWeKYF3MAnMgYpVDvr1yU+JdVHkfylQ1oEW1NTDR1pm3znrg3OQ9iMFt2tuZXW
 DKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=u7cahRt0K/zO6knywAVlpOJmsPLsuqwLqkRRaZSWNE8=;
 b=Kh2IAj6kWrAn1jSR7tO/nfx+U1OrAzASCzUVhzp2ZYlg0WDi1+0y0ppOVofZ4ePETf
 v0PrIFozEL0c7qmcssnvedj9poPSuwXAb9QXDP+8PPB11s6/VIqNnNpm8drk9t/OkHmi
 lYaQw3OiNzbdcbvlJH1cGrztcTBX7aNXJE2pmDb1HfpyKzzEDaxZbhOsdBYA1HUn9G0E
 LV9aLk6Sh5x2VzpGvlMcPs7Vmv0nWJsMw7mnOOcwfuyoBdsRugAm2vtUqQAGIvwVtSKt
 Hig/bMkESukRFqUGRZTih+RQW6bTeynfGeMR/lr4pTnK7kvQ0ZhEAEbg0K6RzU2g/Oop
 Ei+g==
X-Gm-Message-State: APjAAAWH4Lbuu+nwdPUrxZ8BFoIXtyR8cA1hxb9WwDLcMZIr2rqcR29N
 DiX4lsUryEPskVpuDehmd505UxpEuFFch287ji8=
X-Google-Smtp-Source: APXvYqzsqQeP6Ptto6+48Jzi70+iEybipLSjn9infI/sKiteJ8ylxp2TMznexpbUglBUFJhmJH7OGRjipLuFzFHcQBo=
X-Received: by 2002:aca:b80a:: with SMTP id i10mr751691oif.106.1582751239711; 
 Wed, 26 Feb 2020 13:07:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 13:07:19 -0800 (PST)
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 22:07:19 +0100
Message-ID: <CAL1e-=g6Kj3+vOuUArPyxdpZCn12GvQbo=O4PiYnCym5x6u-og@mail.gmail.com>
Subject: Re: [PULL 000/136] Misc patches for 2020-02-25 (refactoring and
 Coccinelle edition)
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000692f58059f80fd82"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000692f58059f80fd82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 25, 2020, Paolo Bonzini <pbonzini@redhat.com> wrote:

> The following changes since commit c1e667d2598b9b3ce62b8e89ed22dd
> 38dfe9f57f:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'
> into staging (2020-02-24 11:38:54 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 4db373bef1544b3b5e02ed376d0788c5b6a7548b:
>
>   Merge branch 'exec_rw_const_v4' of https://github.com/philmd/qemu into
> HEAD (2020-02-25 09:37:42 +0100)
>
> ----------------------------------------------------------------
>
>
Hmm, Paolo, what happened to this cover letter to contain diffs for a
couple of files at the end (that never happens for any cover letter)? How
was that possible? I am just curious.

Yours,
Aleksandar



> * device_del fix (Julia)
> * FXAM fix (myself)
> * memdev refactoring (Igor)
> * memory region API cleanups (Peter, Philippe)
> * ioeventfd optimization (Stefan)
> * new WHPX maintainer (Sunil)
> * Large guest startup optimizations (Chen)
>
> ----------------------------------------------------------------
> Igor Mammedov (79):
>       numa: remove deprecated -mem-path fallback to anonymous RAM
>       machine: introduce memory-backend property
>       machine: alias -mem-path and -mem-prealloc into memory-foo backend
>       machine: introduce convenience MachineState::ram
>       initialize MachineState::ram in NUMA case
>       vl.c: move -m parsing after memory backends has been processed
>       vl.c: ensure that ram_size matches size of machine.memory-backend
>       alpha/dp264: use memdev for RAM
>       arm/aspeed: actually check RAM size
>       arm/aspeed: use memdev for RAM
>       arm/collie: use memdev for RAM
>       arm/cubieboard: use memdev for RAM
>       arm/digic_boards: use memdev for RAM
>       arm/highbank: use memdev for RAM
>       arm/imx25_pdk: drop RAM size fixup
>       arm/imx25_pdk: use memdev for RAM
>       arm/integratorcp: use memdev for RAM
>       arm/kzm: drop RAM size fixup
>       arm/kzm: use memdev for RAM
>       arm/mcimx6ul-evk: use memdev for RAM
>       arm/mcimx7d-sabre: use memdev for RAM
>       arm/mps2-tz: use memdev for RAM
>       arm/mps2: use memdev for RAM
>       arm/musicpal: use memdev for RAM
>       arm/nseries: use memdev for RAM
>       arm/omap_sx1: use memdev for RAM
>       arm/palm: use memdev for RAM
>       arm/sabrelite: use memdev for RAM
>       arm/raspi: use memdev for RAM
>       arm/sbsa-ref: use memdev for RAM
>       arm/versatilepb: use memdev for RAM
>       arm/vexpress: use memdev for RAM
>       arm/virt: use memdev for RAM
>       arm/xilinx_zynq: drop RAM size fixup
>       arm/xilinx_zynq: use memdev for RAM
>       arm/xlnx-versal-virt: use memdev for RAM
>       arm/xlnx-zcu102: use memdev for RAM
>       s390x/s390-virtio-ccw: use memdev for RAM
>       null-machine: use memdev for RAM
>       cris/axis_dev88: use memdev for RAM
>       hppa: use memdev for RAM
>       x86/microvm: use memdev for RAM
>       x86/pc: use memdev for RAM
>       lm32/lm32_boards: use memdev for RAM
>       lm32/milkymist: use memdev for RAM
>       m68k/an5206: use memdev for RAM
>       m68k/q800: use memdev for RAM
>       m68k/mcf5208: use memdev for RAM
>       m68k/next-cube: use memdev for RAM
>       mips/boston: use memdev for RAM
>       mips/mips_fulong2e: drop RAM size fixup
>       mips/mips_fulong2e: use memdev for RAM
>       mips/mips_jazz: use memdev for RAM
>       mips/mips_jazz: add max ram size check
>       mips/mips_malta: use memdev for RAM
>       mips/mips_mipssim: use memdev for RAM
>       mips/mips_r4k: use memdev for RAM
>       ppc/e500: drop RAM size fixup
>       ppc/e500: use memdev for RAM
>       ppc/mac_newworld: use memdev for RAM
>       ppc/mac_oldworld: use memdev for RAM
>       ppc/pnv: use memdev for RAM
>       ppc/ppc405_boards: add RAM size checks
>       ppc/ppc405_boards: use memdev for RAM
>       ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup
>       ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM
>       ppc/spapr: use memdev for RAM
>       ppc/virtex_ml507: use memdev for RAM
>       sparc/leon3: use memdev for RAM
>       sparc/sun4m: use memdev for RAM
>       sparc/niagara: use memdev for RAM
>       remove no longer used memory_region_allocate_system_memory()
>       exec: cleanup qemu_minrampagesize()/qemu_maxrampagesize()
>       exec: drop bogus mem_path from qemu_ram_alloc_from_fd()
>       make mem_path local variable
>       hostmem: introduce "prealloc-threads" property
>       hostmem: fix strict bind policy
>       tests/numa-test: make top level args dynamic and g_autofree(cli)
> cleanups
>       tests:numa-test: use explicit memdev to specify node RAM
>
> Julia Suvorova (1):
>       qdev-monitor: Forbid repeated device_del
>
> Paolo Bonzini (4):
>       target/i386: check for empty register in FXAM
>       Merge tag 'patchew/20200219160953.13771-1-imammedo@redhat.com' of
> https://github.com/patchew-project/qemu into HEAD
>       Merge tag 'patchew/20200224205533.23798-1-philmd@redhat.com' of
> https://github.com/patchew-project/qemu into HEAD
>       Merge branch 'exec_rw_const_v4' of https://github.com/philmd/qemu
> into HEAD
>
> Peter Maydell (1):
>       Avoid address_space_rw() with a constant is_write argument
>
> Philippe Mathieu-Daud=C3=A9 (51):
>       scripts/git.orderfile: Display Cocci scripts before code
> modifications
>       hw: Remove unnecessary cast when calling dma_memory_read()
>       exec: Rename ram_ptr variable
>       exec: Let flatview API take void pointer arguments
>       exec: Let the address_space API use void pointer arguments
>       hw/net: Avoid casting non-const pointer, use address_space_write()
>       Remove unnecessary cast when using the address_space API
>       exec: Let the cpu_[physical]_memory API use void pointer arguments
>       Remove unnecessary cast when using the cpu_[physical]_memory API
>       hw/ide/internal: Remove unused DMARestartFunc typedef
>       hw/ide: Let the DMAIntFunc prototype use a boolean 'is_write'
> argument
>       hw/virtio: Let virtqueue_map_iovec() use a boolean 'is_write'
> argument
>       hw/virtio: Let vhost_memory_map() use a boolean 'is_write' argument
>       exec: Let address_space_unmap() use a boolean 'is_write' argument
>       Let address_space_rw() calls pass a boolean 'is_write' argument
>       exec: Let cpu_[physical]_memory API use a boolean 'is_write' argume=
nt
>       Let cpu_[physical]_memory() calls pass a boolean 'is_write' argumen=
t
>       Avoid cpu_physical_memory_rw() with a constant is_write argument
>       memory: Correctly return alias region type
>       memory: Simplify memory_region_init_rom_nomigrate() to ease review
>       scripts/cocci: Rename memory-region-{init-ram -> housekeeping}
>       scripts/cocci: Patch to replace memory_region_init_{ram, readonly -=
>
> rom}
>       hw/arm: Use memory_region_init_rom() with read-only regions
>       hw/display: Use memory_region_init_rom() with read-only regions
>       hw/mips: Use memory_region_init_rom() with read-only regions
>       hw/m68k: Use memory_region_init_rom() with read-only regions
>       hw/net: Use memory_region_init_rom() with read-only regions
>       hw/pci-host: Use memory_region_init_rom() with read-only regions
>       hw/ppc: Use memory_region_init_rom() with read-only regions
>       hw/riscv: Use memory_region_init_rom() with read-only regions
>       hw/sh4: Use memory_region_init_rom() with read-only regions
>       hw/sparc: Use memory_region_init_rom() with read-only regions
>       scripts/cocci: Patch to detect potential use of
> memory_region_init_rom
>       hw/arm/stm32: Use memory_region_init_rom() with read-only regions
>       hw/ppc/ppc405: Use memory_region_init_rom() with read-only regions
>       hw/i386/pc_sysfw: Simplify using memory_region_init_alias()
>       hw/i386/pc_sysfw: Remove unused 'ram_size' argument
>       scripts/cocci: Patch to remove unnecessary
> memory_region_set_readonly()
>       hw/arm: Remove unnecessary memory_region_set_readonly() on ROM alia=
s
>       scripts/cocci: Patch to let devices own their MemoryRegions
>       hw/arm: Let devices own the MemoryRegion they create
>       hw/char: Let devices own the MemoryRegion they create
>       hw/core: Let devices own the MemoryRegion they create
>       hw/display: Let devices own the MemoryRegion they create
>       hw/dma: Let devices own the MemoryRegion they create
>       hw/riscv: Let devices own the MemoryRegion they create
>       hw/input/milkymist-softusb: Remove unused 'pmem_ptr' field
>       hw/input/milkymist-softusb: Let devices own the MemoryRegion they
> create
>       hw/net/milkymist-minimac2: Let devices own the MemoryRegion they
> create
>       hw/block/onenand: Let devices own the MemoryRegion they create
>       accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION) return value
>
> Stefan Hajnoczi (1):
>       memory: batch allocate ioeventfds[] in address_space_update_
> ioeventfds()
>
> Sunil Muthuswamy (1):
>       WHPX: Assigning maintainer for Windows Hypervisor Platform
>
> bauerchen (1):
>       mem-prealloc: optimize large guest startup
>
>  MAINTAINERS                                        |   9 ++
>  accel/kvm/kvm-all.c                                |  18 ++-
>  backends/hostmem-file.c                            |   8 --
>  backends/hostmem-memfd.c                           |   1 -
>  backends/hostmem-ram.c                             |   2 -
>  backends/hostmem.c                                 |  53 +++++--
>  dma-helpers.c                                      |   4 +-
>  exec.c                                             | 131 ++++++---------=
--
>  hw/alpha/alpha_sys.h                               |   2 +-
>  hw/alpha/dp264.c                                   |   3 +-
>  hw/alpha/typhoon.c                                 |   8 +-
>  hw/arm/aspeed.c                                    |  18 +--
>  hw/arm/boot.c                                      |   6 +-
>  hw/arm/collie.c                                    |  16 ++-
>  hw/arm/cubieboard.c                                |  25 ++--
>  hw/arm/digic_boards.c                              |  40 +++---
>  hw/arm/exynos4210.c                                |  14 +-
>  hw/arm/fsl-imx25.c                                 |  10 +-
>  hw/arm/fsl-imx31.c                                 |   6 +-
>  hw/arm/fsl-imx6.c                                  |   6 +-
>  hw/arm/fsl-imx6ul.c                                |   9 +-
>  hw/arm/highbank.c                                  |  10 +-
>  hw/arm/imx25_pdk.c                                 |  19 +--
>  hw/arm/integratorcp.c                              |   9 +-
>  hw/arm/kzm.c                                       |  18 +--
>  hw/arm/mainstone.c                                 |   3 +-
>  hw/arm/mcimx6ul-evk.c                              |  25 ++--
>  hw/arm/mcimx7d-sabre.c                             |  25 ++--
>  hw/arm/mps2-tz.c                                   |  15 +-
>  hw/arm/mps2.c                                      |  15 +-
>  hw/arm/msf2-soc.c                                  |   6 +-
>  hw/arm/musicpal.c                                  |  18 ++-
>  hw/arm/nrf51_soc.c                                 |   2 +-
>  hw/arm/nseries.c                                   |  32 +++--
>  hw/arm/omap_sx1.c                                  |  26 ++--
>  hw/arm/palm.c                                      |  22 ++-
>  hw/arm/raspi.c                                     |  10 +-
>  hw/arm/sabrelite.c                                 |  23 ++-
>  hw/arm/sbsa-ref.c                                  |   7 +-
>  hw/arm/smmu-common.c                               |   3 +-
>  hw/arm/smmuv3.c                                    |  10 +-
>  hw/arm/spitz.c                                     |   3 +-
>  hw/arm/stellaris.c                                 |   3 +-
>  hw/arm/stm32f205_soc.c                             |  11 +-
>  hw/arm/stm32f405_soc.c                             |  12 +-
>  hw/arm/tosa.c                                      |   3 +-
>  hw/arm/versatilepb.c                               |   7 +-
>  hw/arm/vexpress.c                                  |  14 +-
>  hw/arm/virt.c                                      |   7 +-
>  hw/arm/xilinx_zynq.c                               |  20 ++-
>  hw/arm/xlnx-versal-virt.c                          |   7 +-
>  hw/arm/xlnx-zcu102.c                               |   7 +-
>  hw/arm/xlnx-zynqmp.c                               |  11 +-
>  hw/block/onenand.c                                 |   7 +-
>  hw/char/serial.c                                   |   7 +-
>  hw/core/machine.c                                  |  48 +++++++
>  hw/core/null-machine.c                             |   8 +-
>  hw/core/numa.c                                     | 101 ++++---------
>  hw/core/platform-bus.c                             |   3 +-
>  hw/cris/axis_dev88.c                               |   8 +-
>  hw/display/cg3.c                                   |   5 +-
>  hw/display/exynos4210_fimd.c                       |   3 +-
>  hw/display/g364fb.c                                |   3 +-
>  hw/display/macfb.c                                 |   4 +-
>  hw/display/milkymist-tmu2.c                        |   8 +-
>  hw/display/omap_dss.c                              |   2 +-
>  hw/display/omap_lcdc.c                             |  10 +-
>  hw/display/ramfb.c                                 |   2 +-
>  hw/display/tcx.c                                   |   5 +-
>  hw/dma/etraxfs_dma.c                               |  25 ++--
>  hw/dma/i8257.c                                     |   2 +-
>  hw/dma/rc4030.c                                    |  14 +-
>  hw/dma/xlnx-zdma.c                                 |  11 +-
>  hw/hppa/machine.c                                  |  10 +-
>  hw/i386/microvm.c                                  |  12 +-
>  hw/i386/pc.c                                       |  19 ++-
>  hw/i386/pc_sysfw.c                                 |  29 ++--
>  hw/ide/ahci.c                                      |   2 +-
>  hw/ide/core.c                                      |   2 +-
>  hw/ide/macio.c                                     |   2 +-
>  hw/ide/pci.c                                       |   2 +-
>  hw/input/milkymist-softusb.c                       |  12 +-
>  hw/lm32/lm32_boards.c                              |  39 +++--
>  hw/lm32/milkymist.c                                |  21 ++-
>  hw/m68k/an5206.c                                   |   5 +-
>  hw/m68k/mcf5208.c                                  |   5 +-
>  hw/m68k/next-cube.c                                |   5 +-
>  hw/m68k/q800.c                                     |   9 +-
>  hw/mips/boston.c                                   |  11 +-
>  hw/mips/mips_fulong2e.c                            |  18 +--
>  hw/mips/mips_jazz.c                                |  18 +--
>  hw/mips/mips_malta.c                               |  10 +-
>  hw/mips/mips_mipssim.c                             |  12 +-
>  hw/mips/mips_r4k.c                                 |  15 +-
>  hw/misc/aspeed_sdmc.c                              |  83 ++++++++---
>  hw/misc/pc-testdev.c                               |   2 +-
>  hw/net/cadence_gem.c                               |  21 ++-
>  hw/net/dp8393x.c                                   |  75 +++++-----
>  hw/net/i82596.c                                    |  25 ++--
>  hw/net/lasi_i82596.c                               |   5 +-
>  hw/net/milkymist-minimac2.c                        |   8 +-
>  hw/nvram/spapr_nvram.c                             |   4 +-
>  hw/pci-host/prep.c                                 |   5 +-
>  hw/ppc/e500.c                                      |  17 ++-
>  hw/ppc/e500plat.c                                  |   1 +
>  hw/ppc/mac_newworld.c                              |   9 +-
>  hw/ppc/mac_oldworld.c                              |   9 +-
>  hw/ppc/mpc8544ds.c                                 |   1 +
>  hw/ppc/pnv.c                                       |   8 +-
>  hw/ppc/pnv_lpc.c                                   |   8 +-
>  hw/ppc/ppc405_boards.c                             |  54 ++++---
>  hw/ppc/ppc440_bamboo.c                             |  12 +-
>  hw/ppc/ppc440_uc.c                                 |   6 +-
>  hw/ppc/ppc4xx_devs.c                               |  67 +++++----
>  hw/ppc/sam460ex.c                                  |   6 +-
>  hw/ppc/spapr.c                                     |   8 +-
>  hw/ppc/spapr_hcall.c                               |   4 +-
>  hw/ppc/virtex_ml507.c                              |  12 +-
>  hw/riscv/sifive_e.c                                |   9 +-
>  hw/riscv/sifive_u.c                                |   2 +-
>  hw/s390x/css.c                                     |  12 +-
>  hw/s390x/ipl.c                                     |   2 +-
>  hw/s390x/s390-pci-bus.c                            |   2 +-
>  hw/s390x/s390-virtio-ccw.c                         |   7 +-
>  hw/s390x/virtio-ccw.c                              |   2 +-
>  hw/scsi/vmw_pvscsi.c                               |   8 +-
>  hw/sd/sdhci.c                                      |  15 +-
>  hw/sh4/shix.c                                      |   3 +-
>  hw/sparc/leon3.c                                   |   9 +-
>  hw/sparc/sun4m.c                                   |  74 +++++-----
>  hw/sparc64/niagara.c                               |   7 +-
>  hw/virtio/vhost.c                                  |   8 +-
>  hw/virtio/virtio.c                                 |   7 +-
>  hw/xen/xen_pt_graphics.c                           |   2 +-
>  include/exec/cpu-all.h                             |   2 +-
>  include/exec/cpu-common.h                          |  12 +-
>  include/exec/memory.h                              |  16 +--
>  include/hw/boards.h                                |  54 +++----
>  include/hw/ide/internal.h                          |   3 +-
>  include/hw/misc/aspeed_sdmc.h                      |   1 +
>  include/hw/ppc/ppc4xx.h                            |   9 +-
>  include/sysemu/hostmem.h                           |  20 ++-
>  include/sysemu/numa.h                              |   1 +
>  include/sysemu/sysemu.h                            |   2 -
>  memory.c                                           |  34 +++--
>  qdev-monitor.c                                     |   6 +
>  qemu-deprecated.texi                               |   9 --
>  qtest.c                                            |  52 +++----
>  scripts/coccinelle/exec_rw_const.cocci             | 111 ++++++++++++++
>  .../coccinelle/memory-region-housekeeping.cocci    | 159
> +++++++++++++++++++++
>  scripts/coccinelle/memory-region-init-ram.cocci    |  38 -----
>  scripts/git.orderfile                              |   3 +
>  softmmu/vl.c                                       |  78 ++++++++--
>  target/i386/fpu_helper.c                           |   6 +-
>  target/i386/hax-all.c                              |   6 +-
>  target/i386/hvf/vmx.h                              |   7 +-
>  target/i386/hvf/x86_mmu.c                          |  12 +-
>  target/i386/whpx-all.c                             |   2 +-
>  target/s390x/excp_helper.c                         |   2 +-
>  target/s390x/helper.c                              |   6 +-
>  target/s390x/mmu_helper.c                          |   2 +-
>  tests/qtest/numa-test.c                            | 138
> +++++++++---------
>  util/oslib-posix.c                                 |  32 +++--
>  163 files changed, 1524 insertions(+), 1244 deletions(-)
>  create mode 100644 scripts/coccinelle/exec_rw_const.cocci
>  create mode 100644 scripts/coccinelle/memory-region-housekeeping.cocci
>  delete mode 100644 scripts/coccinelle/memory-region-init-ram.cocci
> ---
>  hw/core/numa.c       | 18 +-----------------
>  qemu-deprecated.texi |  9 ---------
>  2 files changed, 1 insertion(+), 26 deletions(-)
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 0d1b4be..840e685 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -784,24 +784,8 @@ static void allocate_system_memory_nonnuma(MemoryReg=
ion
> *mr, Object *owner,
>  {
>      if (mem_path) {
>  #ifdef __linux__
> -        Error *err =3D NULL;
>          memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0=
,
> -                                         mem_path, &err);
> -        if (err) {
> -            error_report_err(err);
> -            if (mem_prealloc) {
> -                exit(1);
> -            }
> -            warn_report("falling back to regular RAM allocation");
> -            error_printf("This is deprecated. Make sure that -mem-path "
> -                         " specified path has sufficient resources to
> allocate"
> -                         " -m specified RAM amount\n");
> -            /* Legacy behavior: if allocation failed, fall back to
> -             * regular RAM allocation.
> -             */
> -            mem_path =3D NULL;
> -            memory_region_init_ram_nomigrate(mr, owner, name, ram_size,
> &error_fatal);
> -        }
> +                                         mem_path, &error_fatal);
>  #else
>          fprintf(stderr, "-mem-path not supported on this host\n");
>          exit(1);
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 0671c26..66eca3a 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -113,15 +113,6 @@ QEMU using implicit generic or board specific
> splitting rule.
>  Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem=
}
> (if
>  it's supported by used machine type) to define mapping explictly instead=
.
>
> -@subsection -mem-path fallback to RAM (since 4.1)
> -Currently if guest RAM allocation from file pointed by @option{mem-path}
> -fails, QEMU falls back to allocating from RAM, which might result
> -in unpredictable behavior since the backing file specified by the user
> -is ignored. In the future, users will be responsible for making sure
> -the backing storage specified with @option{-mem-path} can actually provi=
de
> -the guest RAM configured with @option{-m} and QEMU will fail to start up
> if
> -RAM allocation is unsuccessful.
> -
>  @subsection RISC-V -bios (since 4.1)
>
>  QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for
> the
> --
> 1.8.3.1
>
>
>
>

--000000000000692f58059f80fd82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBUdWVzZGF5LCBGZWJydWFyeSAyNSwgMjAyMCwgUGFvbG8gQm9uemluaSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOnBib256aW5pQHJlZGhhdC5jb20iPnBib256aW5pQHJlZGhhdC5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0
OjFleCI+VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBjMWU2NjdkMjU5OGI5YjNj
ZTYyYjhlODllZDIyZGQ8d2JyPjM4ZGZlOWY1N2Y6PGJyPg0KPGJyPg0KwqAgTWVyZ2UgcmVtb3Rl
LXRyYWNraW5nIGJyYW5jaCAmIzM5O3JlbW90ZXMvc3RlZmFuaGEvdGFncy9ibG9jay08d2JyPnB1
bGwtcmVxdWVzdCYjMzk7IGludG8gc3RhZ2luZyAoMjAyMC0wMi0yNCAxMTozODo1NCArMDAwMCk8
YnI+DQo8YnI+DQphcmUgYXZhaWxhYmxlIGluIHRoZSBnaXQgcmVwb3NpdG9yeSBhdDo8YnI+DQo8
YnI+DQo8YnI+DQrCoCBnaXQ6Ly88YSBocmVmPSJodHRwOi8vZ2l0aHViLmNvbS9ib256aW5pL3Fl
bXUuZ2l0IiB0YXJnZXQ9Il9ibGFuayI+Z2l0aHViLmNvbS9ib256aW5pL3FlbXUuPHdicj5naXQ8
L2E+IHRhZ3MvZm9yLXVwc3RyZWFtPGJyPg0KPGJyPg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2Vz
IHVwIHRvIDRkYjM3M2JlZjE1NDRiM2I1ZTAyZWQzNzZkMDc4ODx3YnI+YzViNmE3NTQ4Yjo8YnI+
DQo8YnI+DQrCoCBNZXJnZSBicmFuY2ggJiMzOTtleGVjX3J3X2NvbnN0X3Y0JiMzOTsgb2YgPGEg
aHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3BoaWxtZC9xZW11IiB0YXJnZXQ9Il9ibGFuayI+aHR0
cHM6Ly9naXRodWIuY29tL3BoaWxtZC9xZW11PC9hPiBpbnRvIEhFQUQgKDIwMjAtMDItMjUgMDk6
Mzc6NDIgKzAxMDApPGJyPg0KPGJyPg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdi
cj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08d2JyPi0tLS08YnI+DQo8YnI+PC9ibG9j
a3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SG1tLCBQYW9sbywgd2hhdCBoYXBwZW5lZCB0byB0
aGlzIGNvdmVyIGxldHRlciB0byBjb250YWluIGRpZmZzIGZvciBhIGNvdXBsZSBvZiBmaWxlcyBh
dCB0aGUgZW5kICh0aGF0IG5ldmVyIGhhcHBlbnMgZm9yIGFueSBjb3ZlciBsZXR0ZXIpPyBIb3cg
d2FzIHRoYXQgcG9zc2libGU/IEkgYW0ganVzdCBjdXJpb3VzLjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+WW91cnMsPC9kaXY+PGRpdj5BbGVrc2FuZGFyPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0K
KiBkZXZpY2VfZGVsIGZpeCAoSnVsaWEpPGJyPg0KKiBGWEFNIGZpeCAobXlzZWxmKTxicj4NCiog
bWVtZGV2IHJlZmFjdG9yaW5nIChJZ29yKTxicj4NCiogbWVtb3J5IHJlZ2lvbiBBUEkgY2xlYW51
cHMgKFBldGVyLCBQaGlsaXBwZSk8YnI+DQoqIGlvZXZlbnRmZCBvcHRpbWl6YXRpb24gKFN0ZWZh
bik8YnI+DQoqIG5ldyBXSFBYIG1haW50YWluZXIgKFN1bmlsKTxicj4NCiogTGFyZ2UgZ3Vlc3Qg
c3RhcnR1cCBvcHRpbWl6YXRpb25zIChDaGVuKTxicj4NCjxicj4NCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLTx3YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPHdicj4tLS0t
PGJyPg0KSWdvciBNYW1tZWRvdiAoNzkpOjxicj4NCsKgIMKgIMKgIG51bWE6IHJlbW92ZSBkZXBy
ZWNhdGVkIC1tZW0tcGF0aCBmYWxsYmFjayB0byBhbm9ueW1vdXMgUkFNPGJyPg0KwqAgwqAgwqAg
bWFjaGluZTogaW50cm9kdWNlIG1lbW9yeS1iYWNrZW5kIHByb3BlcnR5PGJyPg0KwqAgwqAgwqAg
bWFjaGluZTogYWxpYXMgLW1lbS1wYXRoIGFuZCAtbWVtLXByZWFsbG9jIGludG8gbWVtb3J5LWZv
byBiYWNrZW5kPGJyPg0KwqAgwqAgwqAgbWFjaGluZTogaW50cm9kdWNlIGNvbnZlbmllbmNlIE1h
Y2hpbmVTdGF0ZTo6cmFtPGJyPg0KwqAgwqAgwqAgaW5pdGlhbGl6ZSBNYWNoaW5lU3RhdGU6OnJh
bSBpbiBOVU1BIGNhc2U8YnI+DQrCoCDCoCDCoCB2bC5jOiBtb3ZlIC1tIHBhcnNpbmcgYWZ0ZXIg
bWVtb3J5IGJhY2tlbmRzIGhhcyBiZWVuIHByb2Nlc3NlZDxicj4NCsKgIMKgIMKgIHZsLmM6IGVu
c3VyZSB0aGF0IHJhbV9zaXplIG1hdGNoZXMgc2l6ZSBvZiBtYWNoaW5lLm1lbW9yeS1iYWNrZW5k
PGJyPg0KwqAgwqAgwqAgYWxwaGEvZHAyNjQ6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKg
IMKgIGFybS9hc3BlZWQ6IGFjdHVhbGx5IGNoZWNrIFJBTSBzaXplPGJyPg0KwqAgwqAgwqAgYXJt
L2FzcGVlZDogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAgYXJtL2NvbGxpZTogdXNl
IG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAgYXJtL2N1YmllYm9hcmQ6IHVzZSBtZW1kZXYg
Zm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS9kaWdpY19ib2FyZHM6IHVzZSBtZW1kZXYgZm9yIFJB
TTxicj4NCsKgIMKgIMKgIGFybS9oaWdoYmFuazogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAg
wqAgwqAgYXJtL2lteDI1X3BkazogZHJvcCBSQU0gc2l6ZSBmaXh1cDxicj4NCsKgIMKgIMKgIGFy
bS9pbXgyNV9wZGs6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS9pbnRlZ3Jh
dG9yY3A6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS9rem06IGRyb3AgUkFN
IHNpemUgZml4dXA8YnI+DQrCoCDCoCDCoCBhcm0va3ptOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+
DQrCoCDCoCDCoCBhcm0vbWNpbXg2dWwtZXZrOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDC
oCDCoCBhcm0vbWNpbXg3ZC1zYWJyZTogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAg
YXJtL21wczItdHo6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS9tcHMyOiB1
c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBhcm0vbXVzaWNwYWw6IHVzZSBtZW1kZXYg
Zm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS9uc2VyaWVzOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+
DQrCoCDCoCDCoCBhcm0vb21hcF9zeDE6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKg
IGFybS9wYWxtOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBhcm0vc2FicmVsaXRl
OiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBhcm0vcmFzcGk6IHVzZSBtZW1kZXYg
Zm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS9zYnNhLXJlZjogdXNlIG1lbWRldiBmb3IgUkFNPGJy
Pg0KwqAgwqAgwqAgYXJtL3ZlcnNhdGlsZXBiOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDC
oCDCoCBhcm0vdmV4cHJlc3M6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS92
aXJ0OiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBhcm0veGlsaW54X3p5bnE6IGRy
b3AgUkFNIHNpemUgZml4dXA8YnI+DQrCoCDCoCDCoCBhcm0veGlsaW54X3p5bnE6IHVzZSBtZW1k
ZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIGFybS94bG54LXZlcnNhbC12aXJ0OiB1c2UgbWVtZGV2
IGZvciBSQU08YnI+DQrCoCDCoCDCoCBhcm0veGxueC16Y3UxMDI6IHVzZSBtZW1kZXYgZm9yIFJB
TTxicj4NCsKgIMKgIMKgIHMzOTB4L3MzOTAtdmlydGlvLWNjdzogdXNlIG1lbWRldiBmb3IgUkFN
PGJyPg0KwqAgwqAgwqAgbnVsbC1tYWNoaW5lOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDC
oCDCoCBjcmlzL2F4aXNfZGV2ODg6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIGhw
cGE6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIHg4Ni9taWNyb3ZtOiB1c2UgbWVt
ZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCB4ODYvcGM6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4N
CsKgIMKgIMKgIGxtMzIvbG0zMl9ib2FyZHM6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKg
IMKgIGxtMzIvbWlsa3ltaXN0OiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBtNjhr
L2FuNTIwNjogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAgbTY4ay9xODAwOiB1c2Ug
bWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBtNjhrL21jZjUyMDg6IHVzZSBtZW1kZXYgZm9y
IFJBTTxicj4NCsKgIMKgIMKgIG02OGsvbmV4dC1jdWJlOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+
DQrCoCDCoCDCoCBtaXBzL2Jvc3RvbjogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAg
bWlwcy9taXBzX2Z1bG9uZzJlOiBkcm9wIFJBTSBzaXplIGZpeHVwPGJyPg0KwqAgwqAgwqAgbWlw
cy9taXBzX2Z1bG9uZzJlOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBtaXBzL21p
cHNfamF6ejogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAgbWlwcy9taXBzX2pheno6
IGFkZCBtYXggcmFtIHNpemUgY2hlY2s8YnI+DQrCoCDCoCDCoCBtaXBzL21pcHNfbWFsdGE6IHVz
ZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKgIMKgIMKgIG1pcHMvbWlwc19taXBzc2ltOiB1c2UgbWVt
ZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBtaXBzL21pcHNfcjRrOiB1c2UgbWVtZGV2IGZvciBS
QU08YnI+DQrCoCDCoCDCoCBwcGMvZTUwMDogZHJvcCBSQU0gc2l6ZSBmaXh1cDxicj4NCsKgIMKg
IMKgIHBwYy9lNTAwOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBwcGMvbWFjX25l
d3dvcmxkOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBwcGMvbWFjX29sZHdvcmxk
OiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBwcGMvcG52OiB1c2UgbWVtZGV2IGZv
ciBSQU08YnI+DQrCoCDCoCDCoCBwcGMvcHBjNDA1X2JvYXJkczogYWRkIFJBTSBzaXplIGNoZWNr
czxicj4NCsKgIMKgIMKgIHBwYy9wcGM0MDVfYm9hcmRzOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+
DQrCoCDCoCDCoCBwcGMve3BwYzQ0MF9iYW1ib28sIHNhbTQ2MGV4fTogZHJvcCBSQU0gc2l6ZSBm
aXh1cDxicj4NCsKgIMKgIMKgIHBwYy97cHBjNDQwX2JhbWJvbywgc2FtNDYwZXh9OiB1c2UgbWVt
ZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBwcGMvc3BhcHI6IHVzZSBtZW1kZXYgZm9yIFJBTTxi
cj4NCsKgIMKgIMKgIHBwYy92aXJ0ZXhfbWw1MDc6IHVzZSBtZW1kZXYgZm9yIFJBTTxicj4NCsKg
IMKgIMKgIHNwYXJjL2xlb24zOiB1c2UgbWVtZGV2IGZvciBSQU08YnI+DQrCoCDCoCDCoCBzcGFy
Yy9zdW40bTogdXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAgc3BhcmMvbmlhZ2FyYTog
dXNlIG1lbWRldiBmb3IgUkFNPGJyPg0KwqAgwqAgwqAgcmVtb3ZlIG5vIGxvbmdlciB1c2VkIG1l
bW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtXzx3YnI+bWVtb3J5KCk8YnI+DQrCoCDCoCDCoCBl
eGVjOiBjbGVhbnVwIHFlbXVfbWlucmFtcGFnZXNpemUoKS9xZW11Xzx3YnI+bWF4cmFtcGFnZXNp
emUoKTxicj4NCsKgIMKgIMKgIGV4ZWM6IGRyb3AgYm9ndXMgbWVtX3BhdGggZnJvbSBxZW11X3Jh
bV9hbGxvY19mcm9tX2ZkKCk8YnI+DQrCoCDCoCDCoCBtYWtlIG1lbV9wYXRoIGxvY2FsIHZhcmlh
YmxlPGJyPg0KwqAgwqAgwqAgaG9zdG1lbTogaW50cm9kdWNlICZxdW90O3ByZWFsbG9jLXRocmVh
ZHMmcXVvdDsgcHJvcGVydHk8YnI+DQrCoCDCoCDCoCBob3N0bWVtOiBmaXggc3RyaWN0IGJpbmQg
cG9saWN5PGJyPg0KwqAgwqAgwqAgdGVzdHMvbnVtYS10ZXN0OiBtYWtlIHRvcCBsZXZlbCBhcmdz
IGR5bmFtaWMgYW5kIGdfYXV0b2ZyZWUoY2xpKSBjbGVhbnVwczxicj4NCsKgIMKgIMKgIHRlc3Rz
Om51bWEtdGVzdDogdXNlIGV4cGxpY2l0IG1lbWRldiB0byBzcGVjaWZ5IG5vZGUgUkFNPGJyPg0K
PGJyPg0KSnVsaWEgU3V2b3JvdmEgKDEpOjxicj4NCsKgIMKgIMKgIHFkZXYtbW9uaXRvcjogRm9y
YmlkIHJlcGVhdGVkIGRldmljZV9kZWw8YnI+DQo8YnI+DQpQYW9sbyBCb256aW5pICg0KTo8YnI+
DQrCoCDCoCDCoCB0YXJnZXQvaTM4NjogY2hlY2sgZm9yIGVtcHR5IHJlZ2lzdGVyIGluIEZYQU08
YnI+DQrCoCDCoCDCoCBNZXJnZSB0YWcgJiMzOTtwYXRjaGV3LzxhIGhyZWY9Im1haWx0bzoyMDIw
MDIxOTE2MDk1My4xMzc3MS0xLWltYW1tZWRvQHJlZGhhdC5jb20iPjIwMjAwMjE5MTYwOTUzLjEz
NzcxLTx3YnI+MS1pbWFtbWVkb0ByZWRoYXQuY29tPC9hPiYjMzk7IG9mIDxhIGhyZWY9Imh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdSIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LTx3YnI+cHJvamVjdC9xZW11PC9hPiBpbnRvIEhFQUQ8YnI+
DQrCoCDCoCDCoCBNZXJnZSB0YWcgJiMzOTtwYXRjaGV3LzxhIGhyZWY9Im1haWx0bzoyMDIwMDIy
NDIwNTUzMy4yMzc5OC0xLXBoaWxtZEByZWRoYXQuY29tIj4yMDIwMDIyNDIwNTUzMy4yMzc5OC08
d2JyPjEtcGhpbG1kQHJlZGhhdC5jb208L2E+JiMzOTsgb2YgPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRo
dWIuY29tL3BhdGNoZXctPHdicj5wcm9qZWN0L3FlbXU8L2E+IGludG8gSEVBRDxicj4NCsKgIMKg
IMKgIE1lcmdlIGJyYW5jaCAmIzM5O2V4ZWNfcndfY29uc3RfdjQmIzM5OyBvZiA8YSBocmVmPSJo
dHRwczovL2dpdGh1Yi5jb20vcGhpbG1kL3FlbXUiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dp
dGh1Yi5jb20vcGhpbG1kL3FlbXU8L2E+IGludG8gSEVBRDxicj4NCjxicj4NClBldGVyIE1heWRl
bGwgKDEpOjxicj4NCsKgIMKgIMKgIEF2b2lkIGFkZHJlc3Nfc3BhY2VfcncoKSB3aXRoIGEgY29u
c3RhbnQgaXNfd3JpdGUgYXJndW1lbnQ8YnI+DQo8YnI+DQpQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSAoNTEpOjxicj4NCsKgIMKgIMKgIHNjcmlwdHMvZ2l0Lm9yZGVyZmlsZTogRGlzcGxheSBDb2Nj
aSBzY3JpcHRzIGJlZm9yZSBjb2RlIG1vZGlmaWNhdGlvbnM8YnI+DQrCoCDCoCDCoCBodzogUmVt
b3ZlIHVubmVjZXNzYXJ5IGNhc3Qgd2hlbiBjYWxsaW5nIGRtYV9tZW1vcnlfcmVhZCgpPGJyPg0K
wqAgwqAgwqAgZXhlYzogUmVuYW1lIHJhbV9wdHIgdmFyaWFibGU8YnI+DQrCoCDCoCDCoCBleGVj
OiBMZXQgZmxhdHZpZXcgQVBJIHRha2Ugdm9pZCBwb2ludGVyIGFyZ3VtZW50czxicj4NCsKgIMKg
IMKgIGV4ZWM6IExldCB0aGUgYWRkcmVzc19zcGFjZSBBUEkgdXNlIHZvaWQgcG9pbnRlciBhcmd1
bWVudHM8YnI+DQrCoCDCoCDCoCBody9uZXQ6IEF2b2lkIGNhc3Rpbmcgbm9uLWNvbnN0IHBvaW50
ZXIsIHVzZSBhZGRyZXNzX3NwYWNlX3dyaXRlKCk8YnI+DQrCoCDCoCDCoCBSZW1vdmUgdW5uZWNl
c3NhcnkgY2FzdCB3aGVuIHVzaW5nIHRoZSBhZGRyZXNzX3NwYWNlIEFQSTxicj4NCsKgIMKgIMKg
IGV4ZWM6IExldCB0aGUgY3B1X1twaHlzaWNhbF1fbWVtb3J5IEFQSSB1c2Ugdm9pZCBwb2ludGVy
IGFyZ3VtZW50czxicj4NCsKgIMKgIMKgIFJlbW92ZSB1bm5lY2Vzc2FyeSBjYXN0IHdoZW4gdXNp
bmcgdGhlIGNwdV9bcGh5c2ljYWxdX21lbW9yeSBBUEk8YnI+DQrCoCDCoCDCoCBody9pZGUvaW50
ZXJuYWw6IFJlbW92ZSB1bnVzZWQgRE1BUmVzdGFydEZ1bmMgdHlwZWRlZjxicj4NCsKgIMKgIMKg
IGh3L2lkZTogTGV0IHRoZSBETUFJbnRGdW5jIHByb3RvdHlwZSB1c2UgYSBib29sZWFuICYjMzk7
aXNfd3JpdGUmIzM5OyBhcmd1bWVudDxicj4NCsKgIMKgIMKgIGh3L3ZpcnRpbzogTGV0IHZpcnRx
dWV1ZV9tYXBfaW92ZWMoKSB1c2UgYSBib29sZWFuICYjMzk7aXNfd3JpdGUmIzM5OyBhcmd1bWVu
dDxicj4NCsKgIMKgIMKgIGh3L3ZpcnRpbzogTGV0IHZob3N0X21lbW9yeV9tYXAoKSB1c2UgYSBi
b29sZWFuICYjMzk7aXNfd3JpdGUmIzM5OyBhcmd1bWVudDxicj4NCsKgIMKgIMKgIGV4ZWM6IExl
dCBhZGRyZXNzX3NwYWNlX3VubWFwKCkgdXNlIGEgYm9vbGVhbiAmIzM5O2lzX3dyaXRlJiMzOTsg
YXJndW1lbnQ8YnI+DQrCoCDCoCDCoCBMZXQgYWRkcmVzc19zcGFjZV9ydygpIGNhbGxzIHBhc3Mg
YSBib29sZWFuICYjMzk7aXNfd3JpdGUmIzM5OyBhcmd1bWVudDxicj4NCsKgIMKgIMKgIGV4ZWM6
IExldCBjcHVfW3BoeXNpY2FsXV9tZW1vcnkgQVBJIHVzZSBhIGJvb2xlYW4gJiMzOTtpc193cml0
ZSYjMzk7IGFyZ3VtZW50PGJyPg0KwqAgwqAgwqAgTGV0IGNwdV9bcGh5c2ljYWxdX21lbW9yeSgp
IGNhbGxzIHBhc3MgYSBib29sZWFuICYjMzk7aXNfd3JpdGUmIzM5OyBhcmd1bWVudDxicj4NCsKg
IMKgIMKgIEF2b2lkIGNwdV9waHlzaWNhbF9tZW1vcnlfcncoKSB3aXRoIGEgY29uc3RhbnQgaXNf
d3JpdGUgYXJndW1lbnQ8YnI+DQrCoCDCoCDCoCBtZW1vcnk6IENvcnJlY3RseSByZXR1cm4gYWxp
YXMgcmVnaW9uIHR5cGU8YnI+DQrCoCDCoCDCoCBtZW1vcnk6IFNpbXBsaWZ5IG1lbW9yeV9yZWdp
b25faW5pdF9yb21fPHdicj5ub21pZ3JhdGUoKSB0byBlYXNlIHJldmlldzxicj4NCsKgIMKgIMKg
IHNjcmlwdHMvY29jY2k6IFJlbmFtZSBtZW1vcnktcmVnaW9uLXtpbml0LXJhbSAtJmd0OyBob3Vz
ZWtlZXBpbmd9PGJyPg0KwqAgwqAgwqAgc2NyaXB0cy9jb2NjaTogUGF0Y2ggdG8gcmVwbGFjZSBt
ZW1vcnlfcmVnaW9uX2luaXRfe3JhbSwgcmVhZG9ubHkgLSZndDsgcm9tfTxicj4NCsKgIMKgIMKg
IGh3L2FybTogVXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20oKSB3aXRoIHJlYWQtb25seSByZWdp
b25zPGJyPg0KwqAgwqAgwqAgaHcvZGlzcGxheTogVXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20o
KSB3aXRoIHJlYWQtb25seSByZWdpb25zPGJyPg0KwqAgwqAgwqAgaHcvbWlwczogVXNlIG1lbW9y
eV9yZWdpb25faW5pdF9yb20oKSB3aXRoIHJlYWQtb25seSByZWdpb25zPGJyPg0KwqAgwqAgwqAg
aHcvbTY4azogVXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20oKSB3aXRoIHJlYWQtb25seSByZWdp
b25zPGJyPg0KwqAgwqAgwqAgaHcvbmV0OiBVc2UgbWVtb3J5X3JlZ2lvbl9pbml0X3JvbSgpIHdp
dGggcmVhZC1vbmx5IHJlZ2lvbnM8YnI+DQrCoCDCoCDCoCBody9wY2ktaG9zdDogVXNlIG1lbW9y
eV9yZWdpb25faW5pdF9yb20oKSB3aXRoIHJlYWQtb25seSByZWdpb25zPGJyPg0KwqAgwqAgwqAg
aHcvcHBjOiBVc2UgbWVtb3J5X3JlZ2lvbl9pbml0X3JvbSgpIHdpdGggcmVhZC1vbmx5IHJlZ2lv
bnM8YnI+DQrCoCDCoCDCoCBody9yaXNjdjogVXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20oKSB3
aXRoIHJlYWQtb25seSByZWdpb25zPGJyPg0KwqAgwqAgwqAgaHcvc2g0OiBVc2UgbWVtb3J5X3Jl
Z2lvbl9pbml0X3JvbSgpIHdpdGggcmVhZC1vbmx5IHJlZ2lvbnM8YnI+DQrCoCDCoCDCoCBody9z
cGFyYzogVXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20oKSB3aXRoIHJlYWQtb25seSByZWdpb25z
PGJyPg0KwqAgwqAgwqAgc2NyaXB0cy9jb2NjaTogUGF0Y2ggdG8gZGV0ZWN0IHBvdGVudGlhbCB1
c2Ugb2YgbWVtb3J5X3JlZ2lvbl9pbml0X3JvbTxicj4NCsKgIMKgIMKgIGh3L2FybS9zdG0zMjog
VXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20oKSB3aXRoIHJlYWQtb25seSByZWdpb25zPGJyPg0K
wqAgwqAgwqAgaHcvcHBjL3BwYzQwNTogVXNlIG1lbW9yeV9yZWdpb25faW5pdF9yb20oKSB3aXRo
IHJlYWQtb25seSByZWdpb25zPGJyPg0KwqAgwqAgwqAgaHcvaTM4Ni9wY19zeXNmdzogU2ltcGxp
ZnkgdXNpbmcgbWVtb3J5X3JlZ2lvbl9pbml0X2FsaWFzKCk8YnI+DQrCoCDCoCDCoCBody9pMzg2
L3BjX3N5c2Z3OiBSZW1vdmUgdW51c2VkICYjMzk7cmFtX3NpemUmIzM5OyBhcmd1bWVudDxicj4N
CsKgIMKgIMKgIHNjcmlwdHMvY29jY2k6IFBhdGNoIHRvIHJlbW92ZSB1bm5lY2Vzc2FyeSBtZW1v
cnlfcmVnaW9uX3NldF9yZWFkb25seSgpPGJyPg0KwqAgwqAgwqAgaHcvYXJtOiBSZW1vdmUgdW5u
ZWNlc3NhcnkgbWVtb3J5X3JlZ2lvbl9zZXRfcmVhZG9ubHkoKSBvbiBST00gYWxpYXM8YnI+DQrC
oCDCoCDCoCBzY3JpcHRzL2NvY2NpOiBQYXRjaCB0byBsZXQgZGV2aWNlcyBvd24gdGhlaXIgTWVt
b3J5UmVnaW9uczxicj4NCsKgIMKgIMKgIGh3L2FybTogTGV0IGRldmljZXMgb3duIHRoZSBNZW1v
cnlSZWdpb24gdGhleSBjcmVhdGU8YnI+DQrCoCDCoCDCoCBody9jaGFyOiBMZXQgZGV2aWNlcyBv
d24gdGhlIE1lbW9yeVJlZ2lvbiB0aGV5IGNyZWF0ZTxicj4NCsKgIMKgIMKgIGh3L2NvcmU6IExl
dCBkZXZpY2VzIG93biB0aGUgTWVtb3J5UmVnaW9uIHRoZXkgY3JlYXRlPGJyPg0KwqAgwqAgwqAg
aHcvZGlzcGxheTogTGV0IGRldmljZXMgb3duIHRoZSBNZW1vcnlSZWdpb24gdGhleSBjcmVhdGU8
YnI+DQrCoCDCoCDCoCBody9kbWE6IExldCBkZXZpY2VzIG93biB0aGUgTWVtb3J5UmVnaW9uIHRo
ZXkgY3JlYXRlPGJyPg0KwqAgwqAgwqAgaHcvcmlzY3Y6IExldCBkZXZpY2VzIG93biB0aGUgTWVt
b3J5UmVnaW9uIHRoZXkgY3JlYXRlPGJyPg0KwqAgwqAgwqAgaHcvaW5wdXQvbWlsa3ltaXN0LXNv
ZnR1c2I6IFJlbW92ZSB1bnVzZWQgJiMzOTtwbWVtX3B0ciYjMzk7IGZpZWxkPGJyPg0KwqAgwqAg
wqAgaHcvaW5wdXQvbWlsa3ltaXN0LXNvZnR1c2I6IExldCBkZXZpY2VzIG93biB0aGUgTWVtb3J5
UmVnaW9uIHRoZXkgY3JlYXRlPGJyPg0KwqAgwqAgwqAgaHcvbmV0L21pbGt5bWlzdC1taW5pbWFj
MjogTGV0IGRldmljZXMgb3duIHRoZSBNZW1vcnlSZWdpb24gdGhleSBjcmVhdGU8YnI+DQrCoCDC
oCDCoCBody9ibG9jay9vbmVuYW5kOiBMZXQgZGV2aWNlcyBvd24gdGhlIE1lbW9yeVJlZ2lvbiB0
aGV5IGNyZWF0ZTxicj4NCsKgIMKgIMKgIGFjY2VsL2t2bTogQ2hlY2sgaW9jdGwoS1ZNX1NFVF9V
U0VSX01FTU9SWV88d2JyPlJFR0lPTikgcmV0dXJuIHZhbHVlPGJyPg0KPGJyPg0KU3RlZmFuIEhh
am5vY3ppICgxKTo8YnI+DQrCoCDCoCDCoCBtZW1vcnk6IGJhdGNoIGFsbG9jYXRlIGlvZXZlbnRm
ZHNbXSBpbiBhZGRyZXNzX3NwYWNlX3VwZGF0ZV88d2JyPmlvZXZlbnRmZHMoKTxicj4NCjxicj4N
ClN1bmlsIE11dGh1c3dhbXkgKDEpOjxicj4NCsKgIMKgIMKgIFdIUFg6IEFzc2lnbmluZyBtYWlu
dGFpbmVyIGZvciBXaW5kb3dzIEh5cGVydmlzb3IgUGxhdGZvcm08YnI+DQo8YnI+DQpiYXVlcmNo
ZW4gKDEpOjxicj4NCsKgIMKgIMKgIG1lbS1wcmVhbGxvYzogb3B0aW1pemUgbGFyZ2UgZ3Vlc3Qg
c3RhcnR1cDxicj4NCjxicj4NCsKgTUFJTlRBSU5FUlPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA5ICsrPGJyPg0KwqBhY2Nl
bC9rdm0va3ZtLWFsbC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfMKgIDE4ICsrLTxicj4NCsKgYmFja2VuZHMvaG9zdG1lbS1maWxlLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA4IC0tPGJyPg0KwqBiYWNrZW5k
cy9ob3N0bWVtLW1lbWZkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCDCoDEgLTxicj4NCsKgYmFja2VuZHMvaG9zdG1lbS1yYW0uY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiAtPGJyPg0KwqBiYWNrZW5kcy9ob3N0
bWVtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzC
oCA1MyArKysrKy0tPGJyPg0KwqBkbWEtaGVscGVycy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgNCArLTxicj4NCsKgZXhlYy5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB8IDEzMSArKysrKystLS0tLS0tLS0tLTxicj4NCsKgaHcvYWxwaGEvYWxwaGFf
c3lzLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDC
oDIgKy08YnI+DQrCoGh3L2FscGhhL2RwMjY0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKy08YnI+DQrCoGh3L2FscGhhL3R5cGhv
b24uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgOCArLTxicj4NCsKgaHcvYXJtL2FzcGVlZC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDE4ICstLTxicj4NCsKgaHcvYXJtL2Jvb3Qu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCDCoDYgKy08YnI+DQrCoGh3L2FybS9jb2xsaWUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxNiArKy08YnI+DQrCoGh3L2FybS9j
dWJpZWJvYXJkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgMjUgKystLTxicj4NCsKgaHcvYXJtL2RpZ2ljX2JvYXJkcy5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQwICsrKy0tLTxicj4NCsKgaHcvYXJt
L2V4eW5vczQyMTAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHzCoCAxNCArLTxicj4NCsKgaHcvYXJtL2ZzbC1pbXgyNS5jwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTAgKy08YnI+DQrCoGh3L2FybS9m
c2wtaW14MzEuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfMKgIMKgNiArLTxicj4NCsKgaHcvYXJtL2ZzbC1pbXg2LmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA2ICstPGJyPg0KwqBody9hcm0v
ZnNsLWlteDZ1bC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgOSArLTxicj4NCsKgaHcvYXJtL2hpZ2hiYW5rLmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMTAgKy08YnI+DQrCoGh3L2FybS9p
bXgyNV9wZGsuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfMKgIDE5ICstLTxicj4NCsKgaHcvYXJtL2ludGVncmF0b3JjcC5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgOSArLTxicj4NCsKgaHcvYXJtL2t6
bS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgMTggKy0tPGJyPg0KwqBody9hcm0vbWFpbnN0b25lLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKy08YnI+DQrCoGh3L2Fy
bS9tY2lteDZ1bC1ldmsuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHzCoCAyNSArKy0tPGJyPg0KwqBody9hcm0vbWNpbXg3ZC1zYWJyZS5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMjUgKystLTxicj4NCsKgaHcvYXJt
L21wczItdHouY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIDE1ICstPGJyPg0KwqBody9hcm0vbXBzMi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDE1ICstPGJyPg0KwqBody9h
cm0vbXNmMi1zb2MuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHzCoCDCoDYgKy08YnI+DQrCoGh3L2FybS9tdXNpY3BhbC5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDE4ICsrLTxicj4NCsKgaHcv
YXJtL25yZjUxX3NvYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9hcm0vbnNlcmllcy5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMzIgKysrLS08YnI+DQrC
oGh3L2FybS9vbWFwX3N4MS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfMKgIDI2ICsrLS08YnI+DQrCoGh3L2FybS9wYWxtLmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMjIgKystPGJy
Pg0KwqBody9hcm0vcmFzcGkuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIDEwICstPGJyPg0KwqBody9hcm0vc2FicmVsaXRlLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyMyArKy08
YnI+DQrCoGh3L2FybS9zYnNhLXJlZi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgNyArLTxicj4NCsKgaHcvYXJtL3NtbXUtY29tbW9uLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKy08
YnI+DQrCoGh3L2FybS9zbW11djMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxMCArLTxicj4NCsKgaHcvYXJtL3NwaXR6LmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMg
Ky08YnI+DQrCoGh3L2FybS9zdGVsbGFyaXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMyArLTxicj4NCsKgaHcvYXJtL3N0bTMyZjIwNV9z
b2MuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDExICst
PGJyPg0KwqBody9hcm0vc3RtMzJmNDA1X3NvYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB8wqAgMTIgKy08YnI+DQrCoGh3L2FybS90b3NhLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAzICst
PGJyPg0KwqBody9hcm0vdmVyc2F0aWxlcGIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgNyArLTxicj4NCsKgaHcvYXJtL3ZleHByZXNzLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMTQgKy08
YnI+DQrCoGh3L2FybS92aXJ0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA3ICstPGJyPg0KwqBody9hcm0veGlsaW54X3p5bnEu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIwICsr
LTxicj4NCsKgaHcvYXJtL3hsbngtdmVyc2FsLXZpcnQuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoDcgKy08YnI+DQrCoGh3L2FybS94bG54LXpjdTEwMi5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqA3ICstPGJy
Pg0KwqBody9hcm0veGxueC16eW5xbXAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIDExICstPGJyPg0KwqBody9ibG9jay9vbmVuYW5kLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDcgKy08YnI+
DQrCoGh3L2NoYXIvc2VyaWFsLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCDCoDcgKy08YnI+DQrCoGh3L2NvcmUvbWFjaGluZS5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQ4ICsrKysr
Kys8YnI+DQrCoGh3L2NvcmUvbnVsbC1tYWNoaW5lLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDggKy08YnI+DQrCoGh3L2NvcmUvbnVtYS5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDEwMSAr
KysrLS0tLS0tLS0tPGJyPg0KwqBody9jb3JlL3BsYXRmb3JtLWJ1cy5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAzICstPGJyPg0KwqBody9jcmlzL2F4
aXNfZGV2ODguY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgOCArLTxicj4NCsKgaHcvZGlzcGxheS9jZzMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgNSArLTxicj4NCsKgaHcvZGlzcGxh
eS9leHlub3M0MjEwX2ZpbWQuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMyArLTxicj4NCsKgaHcvZGlzcGxheS9nMzY0ZmIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDMgKy08YnI+DQrCoGh3L2Rpc3BsYXkvbWFj
ZmIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgNCArLTxicj4NCsKgaHcvZGlzcGxheS9taWxreW1pc3QtdG11Mi5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgOCArLTxicj4NCsKgaHcvZGlzcGxheS9vbWFwX2Rz
cy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiAr
LTxicj4NCsKgaHcvZGlzcGxheS9vbWFwX2xjZGMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIDEwICstPGJyPg0KwqBody9kaXNwbGF5L3JhbWZiLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08
YnI+DQrCoGh3L2Rpc3BsYXkvdGN4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDUgKy08YnI+DQrCoGh3L2RtYS9ldHJheGZzX2RtYS5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMjUgKyst
LTxicj4NCsKgaHcvZG1hL2k4MjU3LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3L2RtYS9yYzQwMzAuY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAx
NCArLTxicj4NCsKgaHcvZG1hL3hsbngtemRtYS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTEgKy08YnI+DQrCoGh3L2hwcGEvbWFjaGluZS5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDEw
ICstPGJyPg0KwqBody9pMzg2L21pY3Jvdm0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxMiArLTxicj4NCsKgaHcvaTM4Ni9wYy5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
MTkgKystPGJyPg0KwqBody9pMzg2L3BjX3N5c2Z3LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyOSArKy0tPGJyPg0KwqBody9pZGUvYWhjaS5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMiArLTxicj4NCsKgaHcvaWRlL2NvcmUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L2lkZS9t
YWNpby5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9pZGUvcGNpLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGh3
L2lucHV0L21pbGt5bWlzdC1zb2Z0dXNiLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCAxMiArLTxicj4NCsKgaHcvbG0zMi9sbTMyX2JvYXJkcy5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDM5ICsrKy0tPGJyPg0KwqBody9sbTMy
L21pbGt5bWlzdC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIDIxICsrLTxicj4NCsKgaHcvbTY4ay9hbjUyMDYuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgNSArLTxicj4NCsKgaHcvbTY4
ay9tY2Y1MjA4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgwqA1ICstPGJyPg0KwqBody9tNjhrL25leHQtY3ViZS5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgNSArLTxicj4NCsKgaHcvbTY4
ay9xODAwLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHzCoCDCoDkgKy08YnI+DQrCoGh3L21pcHMvYm9zdG9uLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAxMSArLTxicj4NCsKgaHcv
bWlwcy9taXBzX2Z1bG9uZzJlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgMTggKy0tPGJyPg0KwqBody9taXBzL21pcHNfamF6ei5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDE4ICstLTxicj4NCsKgaHcvbWlw
cy9taXBzX21hbHRhLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCAxMCArLTxicj4NCsKgaHcvbWlwcy9taXBzX21pcHNzaW0uY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDEyICstPGJyPg0KwqBody9taXBzL21p
cHNfcjRrLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCAxNSArLTxicj4NCsKgaHcvbWlzYy9hc3BlZWRfc2RtYy5jwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDgzICsrKysrKysrLS0tPGJyPg0KwqBody9t
aXNjL3BjLXRlc3RkZXYuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaHcvbmV0L2NhZGVuY2VfZ2VtLmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyMSArKy08YnI+DQrCoGh3L25l
dC9kcDgzOTN4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHzCoCA3NSArKysrKy0tLS0tPGJyPg0KwqBody9uZXQvaTgyNTk2LmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMjUgKystLTxi
cj4NCsKgaHcvbmV0L2xhc2lfaTgyNTk2LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCDCoDUgKy08YnI+DQrCoGh3L25ldC9taWxreW1pc3QtbWluaW1h
YzIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDggKy08YnI+DQrC
oGh3L252cmFtL3NwYXByX252cmFtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDQgKy08YnI+DQrCoGh3L3BjaS1ob3N0L3ByZXAuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgNSArLTxicj4NCsKg
aHcvcHBjL2U1MDAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHzCoCAxNyArKy08YnI+DQrCoGh3L3BwYy9lNTAwcGxhdC5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0K
wqBody9wcGMvbWFjX25ld3dvcmxkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgwqA5ICstPGJyPg0KwqBody9wcGMvbWFjX29sZHdvcmxkLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA5ICstPGJyPg0KwqBo
dy9wcGMvbXBjODU0NGRzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCsKgaHcvcHBjL3Budi5jwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqA4ICstPGJyPg0K
wqBody9wcGMvcG52X2xwYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgwqA4ICstPGJyPg0KwqBody9wcGMvcHBjNDA1X2JvYXJkcy5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNTQgKysrKy0tLTxi
cj4NCsKgaHcvcHBjL3BwYzQ0MF9iYW1ib28uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIDEyICstPGJyPg0KwqBody9wcGMvcHBjNDQwX3VjLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDYgKy08YnI+
DQrCoGh3L3BwYy9wcGM0eHhfZGV2cy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgNjcgKysrKystLS0tPGJyPg0KwqBody9wcGMvc2FtNDYwZXguY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDYg
Ky08YnI+DQrCoGh3L3BwYy9zcGFwci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqA4ICstPGJyPg0KwqBody9wcGMvc3BhcHJfaGNh
bGwuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKg
NCArLTxicj4NCsKgaHcvcHBjL3ZpcnRleF9tbDUwNy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDEyICstPGJyPg0KwqBody9yaXNjdi9zaWZpdmVfZS5j
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgOSAr
LTxicj4NCsKgaHcvcmlzY3Yvc2lmaXZlX3UuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQrCoGh3L3MzOTB4L2Nzcy5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTIg
Ky08YnI+DQrCoGh3L3MzOTB4L2lwbC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBody9zMzkweC9zMzkwLXBj
aS1idXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIg
Ky08YnI+DQrCoGh3L3MzOTB4L3MzOTAtdmlydGlvLWNjdy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB8wqAgwqA3ICstPGJyPg0KwqBody9zMzkweC92aXJ0aW8tY2N3LmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJy
Pg0KwqBody9zY3NpL3Ztd19wdnNjc2kuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfMKgIMKgOCArLTxicj4NCsKgaHcvc2Qvc2RoY2kuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxNSArLTxi
cj4NCsKgaHcvc2g0L3NoaXguY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDMgKy08YnI+DQrCoGh3L3NwYXJjL2xlb24zLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDkg
Ky08YnI+DQrCoGh3L3NwYXJjL3N1bjRtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA3NCArKysrKy0tLS0tPGJyPg0KwqBody9zcGFyYzY0
L25pYWdhcmEuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgNyArLTxicj4NCsKgaHcvdmlydGlvL3Zob3N0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA4ICstPGJyPg0KwqBody92aXJ0aW8v
dmlydGlvLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCDCoDcgKy08YnI+DQrCoGh3L3hlbi94ZW5fcHRfZ3JhcGhpY3MuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgaW5jbHVkZS9leGVj
L2NwdS1hbGwuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMiArLTxicj4NCsKgaW5jbHVkZS9leGVjL2NwdS1jb21tb24uaMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxMiArLTxicj4NCsKgaW5jbHVkZS9leGVjL21lbW9y
eS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDE2ICst
LTxicj4NCsKgaW5jbHVkZS9ody9ib2FyZHMuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA1NCArKystLS0tPGJyPg0KwqBpbmNsdWRlL2h3L2lkZS9p
bnRlcm5hbC5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMyAr
LTxicj4NCsKgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zZG1jLmjCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8wqAgwqAxICs8YnI+DQrCoGluY2x1ZGUvaHcvcHBjL3BwYzR4eC5owqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgOSArLTxicj4NCsKg
aW5jbHVkZS9zeXNlbXUvaG9zdG1lbS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8wqAgMjAgKystPGJyPg0KwqBpbmNsdWRlL3N5c2VtdS9udW1hLmjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxICs8YnI+DQrCoGluY2x1
ZGUvc3lzZW11L3N5c2VtdS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgMiAtPGJyPg0KwqBtZW1vcnkuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDM0ICsrKy0tPGJyPg0KwqBx
ZGV2LW1vbml0b3IuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfMKgIMKgNiArPGJyPg0KwqBxZW11LWRlcHJlY2F0ZWQudGV4acKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgOSAtLTxicj4NCsKg
cXRlc3QuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCA1MiArKystLS0tPGJyPg0KwqBzY3JpcHRzL2NvY2NpbmVsbGUv
ZXhlY19yd188d2JyPmNvbnN0LmNvY2NpwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDExMSArKysrKysr
KysrKysrKzxicj4NCsKgLi4uL2NvY2NpbmVsbGUvbWVtb3J5LXJlZ2lvbi08d2JyPmhvdXNla2Vl
cGluZy5jb2NjacKgIMKgIHwgMTU5ICsrKysrKysrKysrKysrKysrKysrKzxicj4NCsKgc2NyaXB0
cy9jb2NjaW5lbGxlL21lbW9yeS08d2JyPnJlZ2lvbi1pbml0LXJhbS5jb2NjacKgIMKgIHzCoCAz
OCAtLS0tLTxicj4NCsKgc2NyaXB0cy9naXQub3JkZXJmaWxlwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMyArPGJyPg0KwqBzb2Z0bW11L3ZsLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzC
oCA3OCArKysrKysrKy0tPGJyPg0KwqB0YXJnZXQvaTM4Ni9mcHVfaGVscGVyLmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDYgKy08YnI+DQrCoHRhcmdldC9p
Mzg2L2hheC1hbGwuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCDCoDYgKy08YnI+DQrCoHRhcmdldC9pMzg2L2h2Zi92bXguaMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDcgKy08YnI+DQrCoHRhcmdldC9pMzg2
L2h2Zi94ODZfbW11LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
MTIgKy08YnI+DQrCoHRhcmdldC9pMzg2L3docHgtYWxsLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoHRhcmdldC9zMzkweC9leGNw
X2hlbHBlci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICst
PGJyPg0KwqB0YXJnZXQvczM5MHgvaGVscGVyLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8wqAgwqA2ICstPGJyPg0KwqB0YXJnZXQvczM5MHgvbW11X2hlbHBl
ci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMiArLTxicj4N
CsKgdGVzdHMvcXRlc3QvbnVtYS10ZXN0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8IDEzOCArKysrKysrKystLS0tLS0tLS08YnI+DQrCoHV0aWwvb3NsaWItcG9z
aXguY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IDMyICsrKy0tPGJyPg0KwqAxNjMgZmlsZXMgY2hhbmdlZCwgMTUyNCBpbnNlcnRpb25zKCspLCAx
MjQ0IGRlbGV0aW9ucygtKTxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IHNjcmlwdHMvY29jY2lu
ZWxsZS9leGVjX3J3Xzx3YnI+Y29uc3QuY29jY2k8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBz
Y3JpcHRzL2NvY2NpbmVsbGUvbWVtb3J5LTx3YnI+cmVnaW9uLWhvdXNla2VlcGluZy5jb2NjaTxi
cj4NCsKgZGVsZXRlIG1vZGUgMTAwNjQ0IHNjcmlwdHMvY29jY2luZWxsZS9tZW1vcnktPHdicj5y
ZWdpb24taW5pdC1yYW0uY29jY2k8YnI+DQotLS08YnI+DQrCoGh3L2NvcmUvbnVtYS5jwqAgwqAg
wqAgwqB8IDE4ICstLS0tLS0tLS0tLS0tLS0tLTxicj4NCsKgcWVtdS1kZXByZWNhdGVkLnRleGkg
fMKgIDkgLS0tLS0tLS0tPGJyPg0KwqAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAy
NiBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvaHcvY29yZS9udW1hLmMgYi9o
dy9jb3JlL251bWEuYzxicj4NCmluZGV4IDBkMWI0YmUuLjg0MGU2ODUgMTAwNjQ0PGJyPg0KLS0t
IGEvaHcvY29yZS9udW1hLmM8YnI+DQorKysgYi9ody9jb3JlL251bWEuYzxicj4NCkBAIC03ODQs
MjQgKzc4NCw4IEBAIHN0YXRpYyB2b2lkIGFsbG9jYXRlX3N5c3RlbV9tZW1vcnlfPHdicj5ub25u
dW1hKE1lbW9yeVJlZ2lvbiAqbXIsIE9iamVjdCAqb3duZXIsPGJyPg0KwqB7PGJyPg0KwqAgwqAg
wqBpZiAobWVtX3BhdGgpIHs8YnI+DQrCoCNpZmRlZiBfX2xpbnV4X188YnI+DQotwqAgwqAgwqAg
wqAgRXJyb3IgKmVyciA9IE5VTEw7PGJyPg0KwqAgwqAgwqAgwqAgwqBtZW1vcnlfcmVnaW9uX2lu
aXRfcmFtX2Zyb21fPHdicj5maWxlKG1yLCBvd25lciwgbmFtZSwgcmFtX3NpemUsIDAsIDAsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgbWVtX3BhdGgsICZhbXA7ZXJyKTs8YnI+DQotwqAgwqAgwqAgwqAgaWYgKGVycikg
ezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBlcnJvcl9yZXBvcnRfZXJyKGVycik7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIGlmIChtZW1fcHJlYWxsb2MpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZXhpdCgxKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCB3YXJuX3JlcG9ydCgmcXVvdDtmYWxsaW5nIGJhY2sgdG8gcmVndWxhciBSQU0g
YWxsb2NhdGlvbiZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGVycm9yX3ByaW50Zigm
cXVvdDtUaGlzIGlzIGRlcHJlY2F0ZWQuIE1ha2Ugc3VyZSB0aGF0IC1tZW0tcGF0aCAmcXVvdDs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDsgc3BlY2lm
aWVkIHBhdGggaGFzIHN1ZmZpY2llbnQgcmVzb3VyY2VzIHRvIGFsbG9jYXRlJnF1b3Q7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7IC1tIHNwZWNpZmll
ZCBSQU0gYW1vdW50XG4mcXVvdDspOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAvKiBMZWdhY3kg
YmVoYXZpb3I6IGlmIGFsbG9jYXRpb24gZmFpbGVkLCBmYWxsIGJhY2sgdG88YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAqIHJlZ3VsYXIgUkFNIGFsbG9jYXRpb24uPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgKi88YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgbWVtX3BhdGggPSBOVUxMOzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCBtZW1vcnlfcmVnaW9uX2luaXRfcmFtXzx3YnI+bm9taWdyYXRl
KG1yLCBvd25lciwgbmFtZSwgcmFtX3NpemUsICZhbXA7ZXJyb3JfZmF0YWwpOzxicj4NCi3CoCDC
oCDCoCDCoCB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtX3BhdGgsICZhbXA7ZXJyb3JfZmF0YWwpOzxicj4NCsKg
I2Vsc2U8YnI+DQrCoCDCoCDCoCDCoCDCoGZwcmludGYoc3RkZXJyLCAmcXVvdDstbWVtLXBhdGgg
bm90IHN1cHBvcnRlZCBvbiB0aGlzIGhvc3RcbiZxdW90Oyk7PGJyPg0KwqAgwqAgwqAgwqAgwqBl
eGl0KDEpOzxicj4NCmRpZmYgLS1naXQgYS9xZW11LWRlcHJlY2F0ZWQudGV4aSBiL3FlbXUtZGVw
cmVjYXRlZC50ZXhpPGJyPg0KaW5kZXggMDY3MWMyNi4uNjZlY2EzYSAxMDA2NDQ8YnI+DQotLS0g
YS9xZW11LWRlcHJlY2F0ZWQudGV4aTxicj4NCisrKyBiL3FlbXUtZGVwcmVjYXRlZC50ZXhpPGJy
Pg0KQEAgLTExMywxNSArMTEzLDYgQEAgUUVNVSB1c2luZyBpbXBsaWNpdCBnZW5lcmljIG9yIGJv
YXJkIHNwZWNpZmljIHNwbGl0dGluZyBydWxlLjxicj4NCsKgVXNlIEBvcHRpb257bWVtZGV2fSB3
aXRoIEB2YXJ7bWVtb3J5LWJhY2tlbmQtcmFtfSBiYWNrZW5kIG9yIEBvcHRpb257bWVtfSAoaWY8
YnI+DQrCoGl0JiMzOTtzIHN1cHBvcnRlZCBieSB1c2VkIG1hY2hpbmUgdHlwZSkgdG8gZGVmaW5l
IG1hcHBpbmcgZXhwbGljdGx5IGluc3RlYWQuPGJyPg0KPGJyPg0KLUBzdWJzZWN0aW9uIC1tZW0t
cGF0aCBmYWxsYmFjayB0byBSQU0gKHNpbmNlIDQuMSk8YnI+DQotQ3VycmVudGx5IGlmIGd1ZXN0
IFJBTSBhbGxvY2F0aW9uIGZyb20gZmlsZSBwb2ludGVkIGJ5IEBvcHRpb257bWVtLXBhdGh9PGJy
Pg0KLWZhaWxzLCBRRU1VIGZhbGxzIGJhY2sgdG8gYWxsb2NhdGluZyBmcm9tIFJBTSwgd2hpY2gg
bWlnaHQgcmVzdWx0PGJyPg0KLWluIHVucHJlZGljdGFibGUgYmVoYXZpb3Igc2luY2UgdGhlIGJh
Y2tpbmcgZmlsZSBzcGVjaWZpZWQgYnkgdGhlIHVzZXI8YnI+DQotaXMgaWdub3JlZC4gSW4gdGhl
IGZ1dHVyZSwgdXNlcnMgd2lsbCBiZSByZXNwb25zaWJsZSBmb3IgbWFraW5nIHN1cmU8YnI+DQot
dGhlIGJhY2tpbmcgc3RvcmFnZSBzcGVjaWZpZWQgd2l0aCBAb3B0aW9uey1tZW0tcGF0aH0gY2Fu
IGFjdHVhbGx5IHByb3ZpZGU8YnI+DQotdGhlIGd1ZXN0IFJBTSBjb25maWd1cmVkIHdpdGggQG9w
dGlvbnstbX0gYW5kIFFFTVUgd2lsbCBmYWlsIHRvIHN0YXJ0IHVwIGlmPGJyPg0KLVJBTSBhbGxv
Y2F0aW9uIGlzIHVuc3VjY2Vzc2Z1bC48YnI+DQotPGJyPg0KwqBAc3Vic2VjdGlvbiBSSVNDLVYg
LWJpb3MgKHNpbmNlIDQuMSk8YnI+DQo8YnI+DQrCoFFFTVUgNC4xIGludHJvZHVjZWQgc3VwcG9y
dCBmb3IgdGhlIC1iaW9zIG9wdGlvbiBpbiBRRU1VIGZvciBSSVNDLVYgZm9yIHRoZTxicj4NCi0t
IDxicj4NCjEuOC4zLjE8YnI+DQo8YnI+DQo8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+DQo=
--000000000000692f58059f80fd82--

