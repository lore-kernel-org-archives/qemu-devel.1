Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF0C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BDC23888
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkQ84PRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BDC23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtkd-00013M-U1
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLth4-0006VF-Po
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLth2-0007gH-87
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:47:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601063263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ItLr+I5WIO9suYXyrZ9G45t17NAf4UCHe+ZpnUwFwnQ=;
 b=NkQ84PRH8uuaqZTv9dKVl8RFaVTD/+TM4JqMXIAY3K0JX1tqlJ0Qs7FFMTWOoYOqCYG0sC
 fYmAJH2L5OiqIGo8CfgYoBbyPJr5TyZYUSMzvRIZcQS7AAFMutHNyt3LEtnLzEhL5NHgov
 PIvo7nZWWNAIhRRjt4pCywB14QQALGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-5DqfonI2O8K-SoG1ohUy3g-1; Fri, 25 Sep 2020 15:47:39 -0400
X-MC-Unique: 5DqfonI2O8K-SoG1ohUy3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EBB6107464A
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 19:47:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D4DF60C15
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 19:47:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v6 00/87] Misc patches for 2020-09-24
Date: Fri, 25 Sep 2020 15:47:34 -0400
Message-Id: <20200925194737.2148096-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8c1c07929feae876202ba26f07a540c5115c18cd:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-09-24 18:48:45 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f19fc40acf2a4481f56165228f788f322d947f60:

  hw/net/can: Correct Kconfig dependencies (2020-09-25 15:21:30 -0400)

----------------------------------------------------------------
* SCSI fix (Dmitry, Li Feng, Li Qiang)
* memory API fixes (Eduardo)
* removal of deprecated '-numa node', 'cpu-add', '-smp' (Igor)
* ACPI fix for VMBus (Jon)
* relocatable install (myself)
* always remove docker containers (myself)
* serial cleanups (Philippe)
* vmware cpuid leaf for tsc and apic frequency (Sunil)
* KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
* i386 XSAVE bugfix (Xiaoyao)
* QOM developer documentation in docs/devel (Eduardo)
* new checkpatch tests (Dov)
* x86_64 syscall fix (Douglas)
* interrupt-based APF fix (Vitaly)
* always create kvmclock (Vitaly)
* fix bios-tables-test (Eduardo)
* KVM PV features cleanup (myself)
* CAN FD (Pavel)

meson:
* fixes (Marc-André, Max, Stefan, Alexander, myself)
* moved libmpathpersist, cocoa, malloc tests (myself)
* support for 0.56 introspected test dependencies (myself)

----------------------------------------------------------------
Alexander Bulekov (1):
      oss-fuzz: move linker arg to fix coverage-build

Anthony PERARD (1):
      meson: fix installation of keymaps

Claudio Fontana (1):
      tests: add missing genh dependency

Daniel P. Berrangé (1):
      char: fix logging when chardev write fails

Dmitry Fomichev (1):
      scsi-generic: Fix HM-zoned device scan

Douglas Crosher (1):
      helper_syscall x86_64: clear exception_is_int

Dov Murik (1):
      checkpatch: Detect '%#' or '%0#' in printf-style format strings

Eduardo Habkost (10):
      memory: Convert IOMMUMemoryRegionClass doc comment to kernel-doc
      qom: Document all function parameters in doc comments
      qom: Use kernel-doc private/public tags in structs
      qom: Use ``code`` Sphinx syntax where appropriate
      qom: Add kernel-doc markup to introduction doc comment
      qom: Reformat section titles using Sphinx syntax
      qom: Indent existing code examples
      qom: Add code block markup to all code blocks
      docs: Create docs/devel/qom.rst
      bios-tables-test: Remove kernel-irqchip=off option

Igor Mammedov (5):
      numa: drop support for '-numa node' (without memory specified)
      doc: Cleanup "'-mem-path' fallback to RAM" deprecation text
      numa: remove fixup numa_state->num_nodes to MAX_NODES
      smp: drop support for deprecated (invalid topologies)
      cphp: remove deprecated cpu-add command(s)

Jan Charvat (5):
      net/can: Initial host SocketCan support for CAN FD.
      hw/net/can: sja1000 ignore CAN FD frames
      net/can: Add can_dlc2len and can_len2dlc for CAN FD.
      hw/net/can/ctucafd: Add CTU CAN FD core register definitions.
      hw/net/can: CTU CAN FD IP open hardware core emulation.

Jon Doron (1):
      acpi: i386: Move VMBus DSDT entry to SB

Li Feng (1):
      vhost-scsi: support inflight io track

Li Qiang (2):
      hw: megasas: return -1 when 'megasas_map_sgl' fails
      hw: megasas: consider 'iov_count=0' is an error in megasas_map_sgl

Marc-André Lureau (2):
      meson: fix MSI rule
      meson: error out if qemu_suffix starts with /

Paolo Bonzini (28):
      meson: clean up build_by_default
      ninjatool: rebuild multi-output targets if outputs are missing
      meson: move libudev test
      meson: move libmpathpersist test
      meson: extend libmpathpersist test for static linking
      configure: move malloc_trim/tcmalloc/jemalloc to meson
      configure: fix --meson=/path/to/meson
      configure: move cocoa option to Meson
      configure: do not limit Hypervisor.framework test to Darwin
      meson: qtest: set "depends" correctly
      mtest2make: add support for introspected test dependencies
      meson: report accelerator support
      oslib: do not call g_strdup from qemu_get_exec_dir
      fuzz: use qemu_get_exec_dir
      oslib-posix: default exec_dir to bindir
      cutils: introduce get_relocated_path
      oslib-posix: relocate path to /var
      module: relocate path to modules
      net: relocate paths to helpers and scripts
      vl: relocate paths to data directories
      vl: relocate path to configuration file
      qemu-bridge-helper: relocate path to default ACL
      qga: relocate path to default configuration and hook
      ui: relocate paths to icons and translations
      configure: use a platform-neutral prefix
      tests/tcg: reinstate or replace desired parts of rules.mak
      docs: Move object.h overview doc comment to qom.rst
      target/i386: kvm: do not use kvm_check_extension to find paravirtual capabilities

Pavel Pisa (2):
      hw/net/can: Documentation for CTU CAN FD IP open hardware core emulation.
      hw/net/can: Correct Kconfig dependencies

Philippe Mathieu-Daudé (16):
      configure: Do not intent to build WHPX on 32-bit host
      hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
      hw/char/serial: Remove TYPE_SERIAL_IO
      hw/char/serial: Assert serial_ioport_read/write offset fits 8 bytes
      hw/char/serial: Replace commented DPRINTF() by trace event
      hw/char/serial: Remove old DEBUG_SERIAL commented code
      hw/char/serial: Rename I/O read/write trace events
      hw/char/serial: Make 'wakeup' property boolean
      hw/char/serial-{isa, pci}: Alias QDEV properties from generic serial object
      hw/i386/q35: Remove unreachable Xen code on Q35 machine
      exec: Remove MemoryRegion::global_locking field
      hw/i386/xen: Rename X86/PC specific function as xen_hvm_init_pc()
      sysemu/xen: Add missing 'exec/cpu-common.h' header for ram_addr_t type
      stubs: Split accelerator / hardware related stubs
      hw/xen: Split x86-specific declaration from generic hardware ones
      typedefs: Restrict PCMachineState to 'hw/i386/pc.h'

Stefan Hajnoczi (2):
      MAINTAINERS: add Paolo Bonzini as RCU maintainer
      configure: rename QEMU_GA_MSI_ENABLED to CONFIG_QGA_MSI

Stefano Garzarella (1):
      checkpatch: avoid error on cover letter files

Sunil Muthuswamy (1):
      WHPX: vmware cpuid leaf for tsc and apic frequency

Vitaly Kuznetsov (3):
      target/i386: support KVM_FEATURE_ASYNC_PF_INT
      target/i386: Fix VM migration when interrupt based APF is enabled
      target/i386: always create kvmclock device

Xiaoyao Li (1):
      i386/cpu: Clear FEAT_XSAVE_COMP_{LO,HI} when XSAVE is not available

 MAINTAINERS                           |  18 +
 Makefile                              |   4 +-
 accel/stubs/xen-stub.c                |  41 +-
 accel/tcg/cputlb.c                    |   4 +-
 chardev/char.c                        |  13 +
 configure                             | 237 ++-------
 docs/can.txt                          | 113 +++-
 docs/devel/build-system.rst           |   5 +
 docs/devel/index.rst                  |   1 +
 docs/devel/qom.rst                    | 378 +++++++++++++
 docs/system/deprecated.rst            |  82 +--
 exec.c                                |   2 +-
 hmp-commands.hx                       |  15 -
 hw/char/serial-isa.c                  |   4 +-
 hw/char/serial-pci.c                  |   3 +-
 hw/char/serial.c                      |  65 +--
 hw/char/trace-events                  |   5 +-
 hw/core/machine-hmp-cmds.c            |  12 -
 hw/core/machine-qmp-cmds.c            |  12 -
 hw/core/machine.c                     |   1 -
 hw/core/numa.c                        |  59 ---
 hw/i386/acpi-build.c                  |  12 +-
 hw/i386/kvm/clock.c                   |   7 +-
 hw/i386/microvm.c                     |   2 +-
 hw/i386/pc.c                          |  28 +-
 hw/i386/pc_piix.c                     |  17 +-
 hw/i386/pc_q35.c                      |  19 +-
 hw/i386/xen/xen-hvm.c                 |   3 +-
 hw/mips/mipssim.c                     |   5 +-
 hw/net/Kconfig                        |  16 +-
 hw/net/can/can_sja1000.c              |  31 +-
 hw/net/can/ctu_can_fd_frame.h         | 189 +++++++
 hw/net/can/ctu_can_fd_regs.h          | 971 ++++++++++++++++++++++++++++++++++
 hw/net/can/ctucan_core.c              | 696 ++++++++++++++++++++++++
 hw/net/can/ctucan_core.h              | 127 +++++
 hw/net/can/ctucan_pci.c               | 281 ++++++++++
 hw/net/can/meson.build                |   2 +
 hw/ppc/spapr.c                        |   1 -
 hw/s390x/s390-virtio-ccw.c            |  12 -
 hw/scsi/megasas.c                     |   6 +-
 hw/scsi/scsi-generic.c                |  10 +-
 hw/scsi/vhost-scsi-common.c           |  27 +
 include/exec/memory.h                 |  64 ++-
 include/hw/boards.h                   |   3 -
 include/hw/char/serial.h              |  11 +-
 include/hw/i386/pc.h                  |   8 +-
 include/hw/kvm/clock.h                |   4 +-
 include/hw/virtio/vhost-scsi-common.h |   2 +
 include/hw/xen/xen-x86.h              |  15 +
 include/hw/xen/xen.h                  |   2 -
 include/monitor/hmp.h                 |   1 -
 include/net/can_emu.h                 |  12 +-
 include/net/net.h                     |   4 +-
 include/qemu-common.h                 |   1 -
 include/qemu/cutils.h                 |  12 +
 include/qemu/osdep.h                  |   8 +-
 include/qemu/typedefs.h               |   1 -
 include/qom/object.h                  | 547 ++++---------------
 include/scsi/constants.h              |   1 +
 include/sysemu/numa.h                 |   4 -
 include/sysemu/sysemu.h               |   2 +-
 include/sysemu/xen.h                  |   2 +
 meson.build                           | 202 +++++--
 meson_options.txt                     |   9 +
 net/can/can_core.c                    |  36 ++
 net/can/can_socketcan.c               |  47 +-
 net/tap.c                             |  26 +-
 os-posix.c                            |  24 -
 os-win32.c                            |  11 -
 pc-bios/keymaps/meson.build           |   2 +
 qapi/machine.json                     |  24 -
 qemu-bridge-helper.c                  |   9 +-
 qga/main.c                            |   8 +-
 qga/meson.build                       |   1 +
 scripts/checkpatch.pl                 |  12 +-
 scripts/mtest2make.py                 |  19 +-
 scripts/ninjatool.py                  |   3 +
 softmmu/memory.c                      |   6 -
 softmmu/vl.c                          |  43 +-
 stubs/meson.build                     |   1 +
 stubs/xen-hw-stub.c                   |  50 ++
 target/i386/cpu.c                     |   5 +-
 target/i386/cpu.h                     |   1 +
 target/i386/kvm.c                     |  45 +-
 target/i386/kvm_i386.h                |   1 +
 target/i386/machine.c                 |  19 +
 target/i386/seg_helper.c              |   1 +
 target/i386/whp-dispatch.h            |   3 +-
 target/i386/whpx-all.c                |  96 +++-
 tests/fp/meson.build                  |   2 -
 tests/meson.build                     |   9 +-
 tests/qemu-iotests/meson.build        |   3 +-
 tests/qtest/bios-tables-test.c        |   3 +-
 tests/qtest/cpu-plug-test.c           | 100 +---
 tests/qtest/fuzz/fuzz.c               |  12 +-
 tests/qtest/meson.build               |   8 +-
 tests/qtest/test-hmp.c                |   1 -
 tests/tcg/Makefile.qemu               |  13 +-
 tests/tcg/configure.sh                |   4 +-
 trace/meson.build                     |   1 -
 ui/gtk.c                              |  10 +-
 ui/meson.build                        |   2 +-
 ui/sdl2.c                             |   9 +-
 ui/shader/meson.build                 |   1 -
 util/cutils.c                         |  61 +++
 util/module.c                         |  10 +-
 util/oslib-posix.c                    |  35 +-
 util/oslib-win32.c                    |  14 +-
 108 files changed, 3863 insertions(+), 1379 deletions(-)
 create mode 100644 docs/devel/qom.rst
 create mode 100644 hw/net/can/ctu_can_fd_frame.h
 create mode 100644 hw/net/can/ctu_can_fd_regs.h
 create mode 100644 hw/net/can/ctucan_core.c
 create mode 100644 hw/net/can/ctucan_core.h
 create mode 100644 hw/net/can/ctucan_pci.c
 create mode 100644 include/hw/xen/xen-x86.h
 create mode 100644 stubs/xen-hw-stub.c
-- 
2.26.2


