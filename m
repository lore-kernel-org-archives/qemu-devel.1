Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E7EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CA2206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx504QzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CA2206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihH7n-0002Ej-1n
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihH6H-0000zT-7c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihH6D-0006zb-CH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:35 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihH6D-0006ua-3z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:57:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id d16so12314734wre.10
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yky/nTR0SQlrT6THuvlR/Qqa2GZaOthOIWsdsv/boS4=;
 b=hx504QzLSsd6/5PlrzrVOD7dX+nP/9auWMsV+IEZAa6Z6Cv5+2m5lC1nY2s+uTQ8Wd
 +mlhHIZl4rKce8ypISijzrbwnacjcuL1dsjmfF5x82oCtFbcCQgKHEOpNLZZGkFq5H2+
 nxio3FUWQoALqHkbaQgL8sdRk41yDrq5fr6fWNKCaXPiB+rMCcwPUkjUUgMJnoMfR5PA
 uFSuVT4vcW1KSVQPCIpZDrtELCv4fonPyfCK5g9sBYztC6xnlMiI25YHfkHOnyExjCuz
 xmFCD2ab21N1prm3yIEJbmx4akHydAArLpd1qCohfMhTovG+yAWBZHxawULgQJXloDzd
 C2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Yky/nTR0SQlrT6THuvlR/Qqa2GZaOthOIWsdsv/boS4=;
 b=YsuGMuK+krcc64IcHf5zWkCG9DukeVvBwnCBsfOFE5WuAcRClwfKO3X5B9xEZiiPC+
 6YiLp7DuWysH4xNmA08h4ueq33W2ro88e3Gw5G0RYVWAYHbRY3EQQfNPMxOWDAZAjRxf
 wL6vUu9JEbjklPondLWmDLwrtDby6MjwBzTpihFCLs6+6qLdGYA7Ma63Sgp5jf5B4Ekg
 u+kDocFC9CzesC0/Y2PkPwDN1y9yK43QIQkXJi1H3U/A/0Ro/pAisRAE0BZ0oaWP12DE
 al5SKLAwg9kMH0Q1ZSc1IQ4nH300ytveiLBvkux0DVkAKoBF07Br1vuicN8NxlCrS85D
 lTxA==
X-Gm-Message-State: APjAAAVvTZ5MgwoPHEeiiuRwdAD7EeOGdI0J7eHB/l4TXPCkMsj2fH3q
 o6t6S5MTDAmfRXVV586HG+CuPjNa
X-Google-Smtp-Source: APXvYqwh4bk9gEbf1SPOKzw8XdECrFyKobdYmY59CKnjCfJfpXze17ccV41/wwZ05cAVfUKADUMwiw==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr39916298wrn.61.1576605447836; 
 Tue, 17 Dec 2019 09:57:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q8sm3649573wmq.3.2019.12.17.09.57.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 09:57:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/62] Misc patches for 2019-12-16
Date: Tue, 17 Dec 2019 18:57:23 +0100
Message-Id: <1576605445-28158-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b72f:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-12-13 18:14:07 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 74c14076700436f9d340652042c81f46eaf0cf9f:

  colo: fix return without releasing RCU (2019-12-17 14:03:44 +0100)

----------------------------------------------------------------
* More uses of RCU_READ_LOCK_GUARD (Dave, myself)
* QOM doc improvments (Greg)
* Cleanups from the Meson conversion (Marc-André)
* Support for multiple -accel options (myself)
* Many x86 machine cleanup (Philippe, myself)
* tests/migration-test cleanup (Juan)

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      kvm: Reallocate dirty_bmap when we change a slot
      hyperv: Use auto rcu_read macros
      qsp: Use WITH_RCU_READ_LOCK_GUARD

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

Paolo Bonzini (35):
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

Philippe Mathieu-Daudé (6):
      hw/i386/pc: Convert DPRINTF() to trace events
      hw/i386: De-duplicate gsi_handler() to remove kvm_pc_gsi_handler()
      hw/i386: Simplify ioapic_init_gsi()
      hw/i386/pc: Use TYPE_PORT92 instead of hardcoded string
      hw/i386/pc: Inline port92_init()
      hw/i386/pc: Extract the port92 device

 Kconfig.host                                       |   5 +
 Makefile                                           |  14 +-
 Makefile.objs                                      |   6 +-
 Makefile.target                                    |   2 -
 accel/Makefile.objs                                |   2 +-
 accel/accel.c                                      |  73 +-----
 accel/kvm/kvm-all.c                                | 161 ++++++++++--
 accel/tcg/tcg-all.c                                | 149 ++++++++++-
 configure                                          |  10 +-
 contrib/vhost-user-scsi/vhost-user-scsi.c          |   2 +-
 cpus.c                                             |  72 -----
 crypto/Makefile.objs                               |  13 +-
 disas/libvixl/Makefile.objs                        |  11 +-
 hw/acpi/Makefile.objs                              |   3 +-
 .../pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c |   0
 hw/alpha/alpha_sys.h                               |   3 +-
 hw/alpha/dp264.c                                   |   1 +
 hw/core/machine.c                                  | 141 ----------
 hw/hppa/hppa_sys.h                                 |   3 +-
 hw/hppa/machine.c                                  |   1 +
 hw/hyperv/hyperv.c                                 |  22 +-
 hw/i386/Kconfig                                    |   6 +
 hw/i386/Makefile.objs                              |  10 +-
 hw/i386/acpi-build.c                               |   1 +
 hw/i386/fw_cfg.c                                   |   8 +-
 hw/i386/fw_cfg.h                                   |   2 +
 hw/i386/kvm/Makefile.objs                          |   6 +-
 hw/i386/kvm/i8259.c                                |   1 +
 hw/i386/kvm/ioapic.c                               |  14 +-
 hw/i386/microvm.c                                  |   4 +-
 hw/i386/pc.c                                       | 291 +--------------------
 hw/i386/pc_piix.c                                  |   6 +-
 hw/i386/pc_q35.c                                   |   2 +-
 hw/i386/port92.c                                   | 126 +++++++++
 hw/i386/trace-events                               |   8 +
 hw/i386/x86-iommu-stub.c                           |  34 +++
 hw/i386/x86.c                                      | 154 ++++++++++-
 hw/input/pckbd.c                                   |   1 -
 hw/intc/Kconfig                                    |   2 +
 hw/intc/apic.c                                     |   2 +-
 hw/intc/i8259.c                                    |   2 +-
 hw/intc/i8259_common.c                             |   2 +-
 hw/intc/ioapic.c                                   |   3 +-
 hw/isa/i82378.c                                    |   2 +-
 hw/isa/isa-bus.c                                   |  11 +-
 hw/isa/lpc_ich9.c                                  |   1 -
 hw/isa/piix4.c                                     |   2 +-
 hw/mips/gt64xxx_pci.c                              |   2 +-
 hw/mips/mips_fulong2e.c                            |   2 +-
 hw/mips/mips_jazz.c                                |   2 +-
 hw/mips/mips_r4k.c                                 |   2 +-
 hw/pci-host/bonito.c                               |   1 -
 hw/pci-host/prep.c                                 |   2 +-
 hw/pci/pci-stub.c                                  |  27 ++
 hw/ppc/e500.c                                      |   5 +-
 hw/ppc/spapr_irq.c                                 |  16 +-
 hw/virtio/Kconfig                                  |   3 +
 hw/virtio/Makefile.objs                            |   4 +-
 hw/xen/xen-common.c                                |  18 ++
 hw/xen/xen_pt.c                                    |   2 +
 include/exec/memory.h                              |   3 +-
 include/hw/boards.h                                |   7 -
 include/hw/i386/pc.h                               |  32 +--
 include/hw/i386/x86.h                              |  23 ++
 include/hw/intc/i8259.h                            |  12 +
 include/hw/isa/i8259_internal.h                    |   2 +-
 include/hw/isa/isa.h                               |   8 +-
 include/qom/object.h                               |  23 +-
 include/sysemu/accel.h                             |   4 +-
 include/sysemu/cpus.h                              |   2 -
 include/sysemu/kvm.h                               |   8 +-
 memory.c                                           |   5 +-
 migration/ram.c                                    |  53 ++--
 monitor/misc.c                                     |   3 +-
 os-posix.c                                         |  41 +--
 qemu-deprecated.texi                               |   6 +
 qemu-options.hx                                    |  30 ++-
 qom/object.c                                       |  28 +-
 stubs/Makefile.objs                                |   1 -
 target/arm/kvm.c                                   |   8 +-
 target/i386/cpu.c                                  |   8 +-
 target/i386/kvm.c                                  |  11 +-
 target/i386/machine.c                              |   2 +-
 target/i386/monitor.c                              |   1 -
 target/mips/kvm.c                                  |   2 +-
 target/ppc/kvm.c                                   |   2 +-
 target/s390x/cpu_models.c                          |   4 +-
 target/s390x/kvm.c                                 |   2 +-
 tests/Makefile.include                             |   4 +-
 tests/arm-cpu-features.c                           |   4 +-
 tests/bios-tables-test.c                           |  16 +-
 tests/boot-serial-test.c                           |   4 +-
 tests/cdrom-test.c                                 |   2 +-
 tests/libqtest.c                                   |   4 +-
 tests/migration-test.c                             | 264 ++++++++++---------
 tests/pflash-cfi02-test.c                          |   4 +-
 tests/pnv-xscom-test.c                             |   4 +-
 tests/prom-env-test.c                              |   2 +-
 tests/pxe-test.c                                   |   2 +-
 tests/vmgenid-test.c                               |   2 +-
 util/Makefile.objs                                 |   3 +-
 util/qsp.c                                         |  22 +-
 vl.c                                               | 225 +++++++++++-----
 103 files changed, 1298 insertions(+), 1076 deletions(-)
 rename stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c (100%)
 create mode 100644 hw/i386/port92.c
 create mode 100644 hw/i386/x86-iommu-stub.c
 create mode 100644 include/hw/intc/i8259.h
-- 
1.8.3.1


