Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27943C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D741F2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX3OSDUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D741F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY50-0008Td-JF
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2e-0005uZ-Js
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2c-0007hv-Df
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2b-0007fL-LH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:02:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d139so4489680wmd.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q52eOI9nooOQwqBRIKRNqiRymkNx/u2oyVxHaCf9pTE=;
 b=FX3OSDUXL3yLuvTM2BejipJy5hTd9M6zp/YvDaLvENiRmZq87d+BtcxdLoqS3YKL8o
 oqAN8rRPmPtRS/z8jfTGciDDcEs6mWfObVdZGWyuk/6wo0UzNqNnnIowO0ZWAJM0fDma
 Nfd3+1r/ew8VJkvmL3wEykcvtlrMj39TUQD9dvl+tHtrQ8UtWLoMbOWLJN4dR70lbIil
 WY8OjqlB7Atp4GsOxUtQV4/5sMDWXZEbbh8+cbYMk2BF5VbIssqmY8/g9fODKcpQUbwA
 sOIAcXgh4woFgI3bsbkp9CVyCOQ6YdPimcbdtvV5CQtes6jUPqmjtPGGE+GyFjIhq0e0
 1b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Q52eOI9nooOQwqBRIKRNqiRymkNx/u2oyVxHaCf9pTE=;
 b=emXp4XmMoTOIfTAswT97b6iiH+Tc9ExWZyDt2T4kT750wQn0QfowI0IaerszUoK5rz
 3ZED9Fb+KA/a/W+mIHJJr1ads2dOQsEVav2n6Ua2kxdnF1nvSuibMpIb5+Cdb4UX5Frn
 bAMsQXlJxJRVN7YJoEZWoreGXSzFsiV70x5Ps3uQthVDCF25MYcdtNjbWmIfoxMroJgN
 gj2X80sb1sWAh8xB1GS4q35Ds/AJ5w3YQ5XwMlvfhFaW0eRZZnlr9DkoKS8yXot5yTHF
 c0HQzAV4rbUwPJph7z3raw2hEE3Gue5gWYLA/H8ODGNMbmykcs9LUtk040B4TTv0zMEv
 Aqwg==
X-Gm-Message-State: APjAAAU7/yFYlhuW+qJCn8tTwtSVn+4MnCo4fLHZyRqbfG4ZO1CxaIDR
 ip2AHrmxDyP3Q7bXpV2rBPYijZVE
X-Google-Smtp-Source: APXvYqywSYYoIDtHAzV/bUjxsgL0rG/iJGNhvnNv4lWGUbe3wZIqt1Eoi10RM8xnZ/657ZVx4IKkLg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr3031161wmi.15.1576670574887; 
 Wed, 18 Dec 2019 04:02:54 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.02.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:02:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/87] Misc patches for 2019-12-18
Date: Wed, 18 Dec 2019 13:01:26 +0100
Message-Id: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e2328a11bda7a4d087200c524333adafb8beb7d7:

  vga: cleanup mapping of VRAM for non-PCI VGA (2019-12-18 02:34:13 +0100)

----------------------------------------------------------------
* More uses of RCU_READ_LOCK_GUARD (Dave, myself)
* QOM doc improvments (Greg)
* Cleanups from the Meson conversion (Marc-André)
* Support for multiple -accel options (myself)
* Many x86 machine cleanup (Philippe, myself)
* tests/migration-test cleanup (Juan)
* PC machine removal and next round of deprecation (Thomas)
* kernel-doc integration (Peter, myself)

----------------------------------------------------------------
Cameron Esfahani (1):
      Fix some comment spelling errors.

Dr. David Alan Gilbert (3):
      kvm: Reallocate dirty_bmap when we change a slot
      hyperv: Use auto rcu_read macros
      qsp: Use WITH_RCU_READ_LOCK_GUARD

Eiichi Tsukata (1):
      target/i386: remove unused pci-assign codes

Greg Kurz (1):
      object: Improve documentation of interfaces

Juan Quintela (10):
      migration-test: Create cmd_soure and cmd_target
      migration-test: Move hide_stderr to common commandline
      migration-test: Move -machine to common commandline
      migration-test: Move memory size to common commandline
      migration-test: Move shmem handling to common commandline
      migration-test: Move -name handling to common commandline
      migration-test: Move -serial handling to common commandline
      migration-test: Move -incomming handling to common commandline
      migration-test: Rename cmd_src/dst to arch_source/arch_target
      migration-test: Use a struct for test_migrate_start parameters

Marc-André Lureau (7):
      build-sys: build vhost-user-gpu only if CONFIG_TOOLS
      migration: fix maybe-uninitialized warning
      monitor: fix maybe-uninitialized
      vhost-user-scsi: fix printf format warning
      os-posix: simplify os_find_datadir
      tests: skip block layer tests if !CONFIG_TOOLS
      configure: simplify vhost condition with Kconfig

Paolo Bonzini (42):
      memory: do not look at current_machine->accel
      vl: move icount configuration earlier
      tcg: move qemu_tcg_configure to accel/tcg/tcg-all.c
      vl: extract accelerator option processing to a separate function
      vl: merge -accel processing into configure_accelerators
      accel: compile accel/accel.c just once
      vl: introduce object_parse_property_opt
      vl: configure accelerators from -accel options
      vl: warn for unavailable accelerators, clarify messages
      qom: introduce object_register_sugar_prop
      qom: add object_new_with_class
      accel: pass object to accel_init_machine
      tcg: convert "-accel threads" to a QOM property
      tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
      xen: convert "-machine igd-passthru" to an accelerator property
      kvm: convert "-machine kvm_shadow_mem" to an accelerator property
      kvm: introduce kvm_kernel_irqchip_* functions
      kvm: convert "-machine kernel_irqchip" to an accelerator property
      Makefile: remove unused variables
      build-sys: do not include Windows SLIRP dependencies in $LIBS
      libvixl: remove per-target compiler flags
      crypto: move common bits for all emulators to libqemuutil
      stubs: replace stubs with lnot if applicable
      configure: set $PYTHON to a full path
      i386: conditionally compile more files
      fw_cfg: allow building without other devices
      hw: replace hw/i386/pc.h with a header just for the i8259
      pci-stub: add more MSI functions
      x86: move SMM property to X86MachineState
      x86: move more x86-generic functions out of PC files
      acpi: move PC stubs out of stubs/
      pc: stubify x86 iommu
      hw/isa/isa-bus: cleanup irq functions
      memory: use RCU_READ_LOCK_GUARD
      colo: fix return without releasing RCU
      build: rename CONFIG_LIBCAP to CONFIG_LIBCAP_NG
      docs: import Linux kernel-doc script and extension
      docs: tweak kernel-doc for QEMU coding standards
      memory.h: Silence kernel-doc complaints
      docs: add memory API reference
      memory: include MemoryListener documentation and some missing function parameters
      vga: cleanup mapping of VRAM for non-PCI VGA

Peter Maydell (4):
      docs/conf.py: Enable use of kerneldoc sphinx extension
      Makefile: disable Sphinx nitpicking
      bitops.h: Silence kernel-doc complaints
      docs: Create bitops.rst as example of kernel-docs

Philippe Mathieu-Daudé (12):
      hw/i386/pc: Convert DPRINTF() to trace events
      hw/i386: De-duplicate gsi_handler() to remove kvm_pc_gsi_handler()
      hw/i386: Simplify ioapic_init_gsi()
      hw/i386/pc: Use TYPE_PORT92 instead of hardcoded string
      hw/i386/pc: Inline port92_init()
      hw/i386/pc: Extract the port92 device
      hw/pci-host/i440fx: Correct the header description
      hw/pci-host/i440fx: Extract PCII440FXState to "hw/pci-host/i440fx.h"
      hw/pci-host/i440fx: Use size_t to iterate over ARRAY_SIZE()
      hw/pci-host/i440fx: Use definitions instead of magic values
      hw/pci-host/i440fx: Extract the IGD passthrough host bridge device
      hw/pci-host: Add Kconfig entry to select the IGD Passthrough Host Bridge

Sunil Muthuswamy (1):
      WHPX: refactor load library

Thomas Huth (4):
      hw/i386: Remove the deprecated machines 0.12 up to 0.15
      hw/audio: Remove the "use_broken_id" hack from the AC97 device
      hw/pci: Remove the "command_serr_enable" property
      hw/display: Remove "rombar" hack from vga-pci and vmware_vga

Wei Yang (1):
      migration: check length directly to make sure the range is aligned

 Kconfig.host                                       |    5 +
 MAINTAINERS                                        |    1 +
 Makefile                                           |   16 +-
 Makefile.objs                                      |    6 +-
 Makefile.target                                    |    2 -
 accel/Makefile.objs                                |    2 +-
 accel/accel.c                                      |   73 +-
 accel/kvm/kvm-all.c                                |  161 +-
 accel/tcg/tcg-all.c                                |  149 +-
 configure                                          |   12 +-
 contrib/vhost-user-scsi/vhost-user-scsi.c          |    2 +-
 cpus.c                                             |   72 -
 crypto/Makefile.objs                               |   13 +-
 disas/libvixl/Makefile.objs                        |   11 +-
 docs/conf.py                                       |    7 +-
 docs/devel/bitops.rst                              |    8 +
 docs/devel/index.rst                               |    1 +
 docs/devel/memory.rst                              |    5 +
 docs/sphinx/kerneldoc.py                           |  172 ++
 docs/sphinx/kernellog.py                           |   28 +
 exec.c                                             |    7 +-
 hw/acpi/Makefile.objs                              |    3 +-
 .../pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c |    0
 hw/alpha/alpha_sys.h                               |    3 +-
 hw/alpha/dp264.c                                   |    1 +
 hw/audio/ac97.c                                    |    9 -
 hw/core/machine.c                                  |  141 --
 hw/display/vga-isa-mm.c                            |    5 +-
 hw/display/vga-isa.c                               |    4 +-
 hw/display/vga-pci.c                               |    5 -
 hw/display/vga.c                                   |   14 -
 hw/display/vga_int.h                               |    3 -
 hw/display/vmware_vga.c                            |    5 -
 hw/hppa/hppa_sys.h                                 |    3 +-
 hw/hppa/machine.c                                  |    1 +
 hw/hyperv/hyperv.c                                 |   22 +-
 hw/i386/Kconfig                                    |    6 +
 hw/i386/Makefile.objs                              |   10 +-
 hw/i386/acpi-build.c                               |    1 +
 hw/i386/fw_cfg.c                                   |    8 +-
 hw/i386/fw_cfg.h                                   |    2 +
 hw/i386/kvm/Makefile.objs                          |    6 +-
 hw/i386/kvm/i8259.c                                |    1 +
 hw/i386/kvm/ioapic.c                               |   14 +-
 hw/i386/microvm.c                                  |    4 +-
 hw/i386/pc.c                                       |  291 +--
 hw/i386/pc_piix.c                                  |   91 +-
 hw/i386/pc_q35.c                                   |    2 +-
 hw/i386/port92.c                                   |  126 ++
 hw/i386/trace-events                               |    8 +
 hw/i386/x86-iommu-stub.c                           |   34 +
 hw/i386/x86.c                                      |  154 +-
 hw/input/pckbd.c                                   |    1 -
 hw/intc/Kconfig                                    |    2 +
 hw/intc/apic.c                                     |    2 +-
 hw/intc/i8259.c                                    |    2 +-
 hw/intc/i8259_common.c                             |    2 +-
 hw/intc/ioapic.c                                   |    3 +-
 hw/isa/i82378.c                                    |    2 +-
 hw/isa/isa-bus.c                                   |   11 +-
 hw/isa/lpc_ich9.c                                  |    1 -
 hw/isa/piix4.c                                     |    2 +-
 hw/mips/gt64xxx_pci.c                              |    2 +-
 hw/mips/mips_fulong2e.c                            |    2 +-
 hw/mips/mips_jazz.c                                |    2 +-
 hw/mips/mips_r4k.c                                 |    2 +-
 hw/pci-host/Kconfig                                |    5 +
 hw/pci-host/Makefile.objs                          |    1 +
 hw/pci-host/bonito.c                               |    1 -
 hw/pci-host/i440fx.c                               |  105 +-
 hw/pci-host/prep.c                                 |    2 +-
 hw/pci-host/xen_igd_pt.c                           |  120 ++
 hw/pci/pci-stub.c                                  |   27 +
 hw/pci/pci.c                                       |    6 +-
 hw/ppc/e500.c                                      |    5 +-
 hw/ppc/spapr_irq.c                                 |   16 +-
 hw/virtio/Kconfig                                  |    3 +
 hw/virtio/Makefile.objs                            |    4 +-
 hw/xen/xen-common.c                                |   18 +
 hw/xen/xen_pt.c                                    |    2 +
 include/exec/memory.h                              |  237 ++-
 include/hw/boards.h                                |    7 -
 include/hw/i386/pc.h                               |   32 +-
 include/hw/i386/x86.h                              |   23 +
 include/hw/intc/i8259.h                            |   12 +
 include/hw/isa/i8259_internal.h                    |    2 +-
 include/hw/isa/isa.h                               |    8 +-
 include/hw/pci-host/i440fx.h                       |   19 +-
 include/hw/pci/pci.h                               |    2 +-
 include/qemu/bitops.h                              |   52 +-
 include/qom/object.h                               |   23 +-
 include/sysemu/accel.h                             |    4 +-
 include/sysemu/cpus.h                              |    2 -
 include/sysemu/kvm.h                               |    8 +-
 memory.c                                           |    5 +-
 migration/ram.c                                    |   53 +-
 monitor/misc.c                                     |    3 +-
 os-posix.c                                         |   41 +-
 qemu-bridge-helper.c                               |    6 +-
 qemu-deprecated.texi                               |    8 +-
 qemu-options.hx                                    |   30 +-
 qom/object.c                                       |   28 +-
 scripts/kernel-doc                                 | 2236 ++++++++++++++++++++
 scsi/qemu-pr-helper.c                              |   12 +-
 stubs/Makefile.objs                                |    1 -
 target/arm/kvm.c                                   |    8 +-
 target/i386/cpu.c                                  |    8 +-
 target/i386/kvm.c                                  |  151 +-
 target/i386/kvm_i386.h                             |   20 -
 target/i386/machine.c                              |   10 +-
 target/i386/monitor.c                              |    1 -
 target/i386/whp-dispatch.h                         |    4 +
 target/i386/whpx-all.c                             |   85 +-
 target/mips/kvm.c                                  |    2 +-
 target/ppc/kvm.c                                   |    2 +-
 target/s390x/cpu_models.c                          |    4 +-
 target/s390x/kvm.c                                 |    2 +-
 tests/Makefile.include                             |    4 +-
 tests/arm-cpu-features.c                           |    4 +-
 tests/bios-tables-test.c                           |   16 +-
 tests/boot-serial-test.c                           |    4 +-
 tests/cdrom-test.c                                 |    2 +-
 tests/cpu-plug-test.c                              |    6 +-
 tests/libqtest.c                                   |    4 +-
 tests/migration-test.c                             |  264 +--
 tests/pflash-cfi02-test.c                          |    4 +-
 tests/pnv-xscom-test.c                             |    4 +-
 tests/prom-env-test.c                              |    2 +-
 tests/pxe-test.c                                   |    2 +-
 tests/vmgenid-test.c                               |    2 +-
 util/Makefile.objs                                 |    3 +-
 util/qsp.c                                         |   22 +-
 vl.c                                               |  225 +-
 133 files changed, 4248 insertions(+), 1552 deletions(-)
 create mode 100644 docs/devel/bitops.rst
 create mode 100644 docs/sphinx/kerneldoc.py
 create mode 100644 docs/sphinx/kernellog.py
 rename stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c (100%)
 create mode 100644 hw/i386/port92.c
 create mode 100644 hw/i386/x86-iommu-stub.c
 create mode 100644 hw/pci-host/xen_igd_pt.c
 create mode 100644 include/hw/intc/i8259.h
 create mode 100755 scripts/kernel-doc
-- 
1.8.3.1


