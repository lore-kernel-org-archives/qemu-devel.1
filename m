Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDC2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D78920835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 16:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXnur4uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D78920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjmGm-0000a8-KZ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 12:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmE3-0005du-Fj
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:08:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjmE0-00014Q-US
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 12:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591978092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hTyOEAeg0oklOv7v9GVuZGcI4zdJXiiGaZybF+nBfg=;
 b=KXnur4uYDriygH6LMJKLBqZcKp/sHhAATxGP1D8dwlocuGZtICUcrReeO+89MxuJr/RXy8
 3UsXR7jP+C70xCkaUJkmOpcllMpii3EGBIGl1lZEAwP5WP34eglFcluPcxiSqrr/Tezwbt
 x/u06ZT2OpxjVs7PUlXM4vfqwP06vNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-zSRqB7PQNAyCZ-r5eWUBew-1; Fri, 12 Jun 2020 12:07:58 -0400
X-MC-Unique: zSRqB7PQNAyCZ-r5eWUBew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5783E18A0761
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 16:07:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFC618FF91
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 16:07:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 000/116] Huge miscellaneous pull request for 2020-06-11
Date: Fri, 12 Jun 2020 12:07:51 -0400
Message-Id: <20200612160755.9597-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3575b0aea983ad57804c9af739ed8ff7bc168393:

  target/i386: Remove obsolete TODO file (2020-06-12 11:20:15 -0400)

----------------------------------------------------------------
* Miscellaneous fixes and feature enablement (many)
* SEV refactoring (David)
* Hyper-V initial support (Jon)
* i386 TCG fixes (x87 and SSE, Joseph)
* vmport cleanup and improvements (Philippe, Liran)
* Use-after-free with vCPU hot-unplug (Nengyuan)
* run-coverity-scan improvements (myself)
* Record/replay fixes (Pavel)
* -machine kernel_irqchip=split improvements for INTx (Peter)
* Code cleanups (Philippe)
* Crash and security fixes (PJP)
* HVF cleanups (Roman)

----------------------------------------------------------------
Anthony PERARD (1):
      xen: fix build without pci passthrough

Babu Moger (1):
      target/i386: Fix the CPUID leaf CPUID_Fn80000008

Cathy Zhang (1):
      x86/cpu: Enable AVX512_VP2INTERSECT cpu feature

Cédric Le Goater (1):
      qom/object: Fix object_child_foreach_recursive() return value

David Carlier (1):
      util/oslib: Returns the real thread identifier on FreeBSD and NetBSD

David Gibson (9):
      target/i386: sev: Remove unused QSevGuestInfoClass
      target/i386: sev: Move local structure definitions into .c file
      target/i386: sev: Rename QSevGuestInfo
      target/i386: sev: Embed SEVState in SevGuestState
      target/i386: sev: Partial cleanup to sev_state global
      target/i386: sev: Remove redundant cbitpos and reduced_phys_bits fields
      target/i386: sev: Remove redundant policy field
      target/i386: sev: Remove redundant handle field
      target/i386: sev: Unify SEVState and SevGuestState

Edgar E. Iglesias (1):
      tests: machine-none-test: Enable MicroBlaze testing

Igor Mammedov (2):
      vl.c: run preconfig loop before creating default RAM backend
      numa: prevent usage of -M memory-backend and -numa memdev at the same time

Janne Grunau (1):
      target/i386: fix phadd* with identical destination and source register

Jon Doron (6):
      hyperv: expose API to determine if synic is enabled
      vmbus: add vmbus protocol definitions
      vmbus: vmbus implementation
      i386:pc: whitelist dynamic vmbus-bridge
      i386: Hyper-V VMBus ACPI DSDT entry
      vmbus: add infrastructure to save/load vmbus requests

Joseph Myers (12):
      target/i386: implement special cases for fxtract
      target/i386: fix fscale handling of signaling NaN
      target/i386: fix fscale handling of invalid exponent encodings
      target/i386: fix fscale handling of infinite exponents
      target/i386: fix fscale handling of rounding precision
      target/i386: fix floating-point load-constant rounding
      target/i386: fix fxam handling of invalid encodings
      target/i386: fix fbstp handling of negative zero
      target/i386: fix fbstp handling of out-of-range values
      target/i386: fix fisttpl, fisttpll handling of out-of-range values
      target/i386: fix IEEE x87 floating-point exception raising
      target/i386: correct fix for pcmpxstrx substring search

Julio Faracco (1):
      i386: Remove unused define's from hax and hvf

Leonid Bloch (1):
      configure: Do not ignore malloc value

Like Xu (1):
      target/i386: define a new MSR based feature word - FEAT_PERF_CAPABILITIES

Liran Alon (14):
      hw/i386/vmport: Add reference to VMware open-vm-tools
      hw/i386/vmport: Add device properties
      hw/i386/vmport: Propagate IOPort read to vCPU EAX register
      hw/i386/vmport: Set EAX to -1 on failed and unsupported commands
      hw/i386/vmport: Introduce vmware-vmx-version property
      hw/i386/vmport: Report vmware-vmx-type in CMD_GETVERSION
      hw/i386/vmport: Introduce vmport.h
      hw/i386/vmport: Define enum for all commands
      hw/i386/vmport: Add support for CMD_GETBIOSUUID
      hw/i386/vmport: Add support for CMD_GET_VCPU_INFO
      hw/i386/vmport: Allow x2apic without IR
      i386/cpu: Store LAPIC bus frequency in CPU structure
      hw/i386/vmport: Add support for CMD_GETHZ
      hw/i386/vmport: Assert vmport initialized before registering commands

Markus Armbruster (1):
      cpus: Fix botched configure_icount() error API violation fix

Masahiro Yamada (5):
      qom: remove index from object_resolve_abs_path()
      qom/object: factor out the initialization of hash table of properties
      qom/object: simplify type_initialize_interface()
      qom/object: pass (Object *) to object_initialize_with_type()
      qom/container: remove .instance_size initializer from container_info

Michael S. Tsirkin (1):
      checkpatch: reversed logic with acpi test checks

Pan Nengyuan (1):
      i386/kvm: fix a use-after-free when vcpu plug/unplug

Paolo Bonzini (9):
      docker.py/build: support -t and -f arguments
      docker.py/build: support binary files in --extra-files
      run-coverity-scan: get Coverity token and email from special git config section
      run-coverity-scan: use docker.py
      run-coverity-scan: add --no-update-tools option
      run-coverity-scan: use --no-update-tools in docker run
      run-coverity-scan: download tools outside the container
      run-coverity-scan: support --update-tools-only --docker
      stubs: move Xen stubs to accel/

Pavel Dovgaluk (3):
      icount: fix shift=auto for record/replay
      replay: implement fair mutex
      replay: fix replay shutdown for console mode

Peter Xu (3):
      vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for irqfds
      KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
      KVM: Kick resamplefd for split kernel irqchip

Philippe Mathieu-Daudé (19):
      target/i386: Fix OUTL debug output
      qom/object: Move Object typedef to 'qemu/typedefs.h'
      io/task: Move 'qom/object.h' header to source
      Makefile: Let the 'help' target list the helper targets
      accel: Move Xen accelerator code under accel/xen/
      exec: Let address_space_read/write_cached() propagate MemTxResult
      exec: Propagate cpu_memory_rw_debug() error
      disas: Let disas::read_memory() handler return EIO on error
      hw/elf_ops: Do not ignore write failures when loading ELF
      hw/i386/vmport: Allow QTest use without crashing
      memory: Make 'info mtree' not display disabled regions by default
      qemu/thread: Mark qemu_thread_exit() with 'noreturn' attribute
      sysemu/accel: Restrict machine methods to system-mode
      sysemu/tcg: Only declare tcg_allowed when TCG is available
      sysemu/hvf: Only declare hvf_allowed when HVF is available
      target/ppc: Restrict PPCVirtualHypervisorClass to system-mode
      exec/memory: Remove unused MemoryRegionMmio type
      hw/usb: Move device-specific declarations to new 'hcd-musb.h' header
      exec/cpu-common: Move MUSB specific typedefs to 'hw/usb/hcd-musb.h'

Prasad J Pandit (4):
      megasas: use unsigned type for reply_queue_head and check index
      megasas: avoid NULL pointer dereference
      megasas: use unsigned type for positive numeric fields
      exec: set map length to zero when returning NULL

Roman Bolshakov (13):
      i386: hvf: Move HVFState definition into hvf
      i386: hvf: Drop useless declarations in sysemu
      i386: hvf: Clean stray includes in sysemu
      i386: hvf: Drop unused variable
      i386: hvf: Use ins_len to advance IP
      i386: hvf: Use IP from CPUX86State
      i386: hvf: Drop fetch_rip from HVFX86EmulatorState
      i386: hvf: Drop rflags from HVFX86EmulatorState
      i386: hvf: Drop copy of RFLAGS defines
      i386: hvf: Drop regs in HVFX86EmulatorState
      i386: hvf: Move lazy_flags into CPUX86State
      i386: hvf: Move mmio_buf into CPUX86State
      i386: hvf: Drop HVFX86EmulatorState

Sai Pavan Boddu (1):
      chardev/char-socket: Properly make qio connections non blocking

Thomas Huth (1):
      target/i386: Remove obsolete TODO file

WangBowen (1):
      hax: Dynamic allocate vcpu state structure

Wei Huang (1):
      hw/i386/amd_iommu: Fix the reserved bits definition of IOMMU commands

 MAINTAINERS                                |    2 +
 Makefile                                   |    9 +-
 Makefile.objs                              |    1 +
 accel/Makefile.objs                        |    1 +
 accel/kvm/kvm-all.c                        |   95 +-
 accel/kvm/trace-events                     |    1 +
 accel/stubs/Makefile.objs                  |    1 +
 stubs/xen-hvm.c => accel/stubs/xen-stub.c  |   23 +-
 accel/xen/Makefile.objs                    |    1 +
 hw/xen/xen-common.c => accel/xen/xen-all.c |   12 +-
 chardev/char-socket.c                      |    4 +-
 configure                                  |   25 +-
 cpus.c                                     |   26 +-
 disas.c                                    |   13 +-
 exec.c                                     |   29 +-
 hmp-commands-info.hx                       |    7 +-
 hw/Makefile.objs                           |    2 +-
 hw/acpi/piix4.c                            |    2 +-
 hw/block/vhost-user-blk.c                  |    1 -
 hw/core/machine.c                          |    4 +
 hw/core/numa.c                             |    5 +
 hw/hyperv/Kconfig                          |    5 +
 hw/hyperv/Makefile.objs                    |    1 +
 hw/hyperv/hyperv.c                         |    8 +
 hw/hyperv/trace-events                     |   18 +
 hw/hyperv/vmbus.c                          | 2778 ++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                       |   43 +
 hw/i386/amd_iommu.c                        |   19 +-
 hw/i386/pc.c                               |    3 +-
 hw/i386/pc_piix.c                          |    5 +-
 hw/i386/pc_q35.c                           |    3 +
 hw/i386/vmmouse.c                          |   20 +-
 hw/i386/vmport.c                           |  183 +-
 hw/i386/vmport.h                           |   34 -
 hw/i386/xen/xen-hvm.c                      |    1 +
 hw/i386/xen/xen_platform.c                 |    1 +
 hw/intc/ioapic.c                           |   19 +
 hw/isa/piix3.c                             |    1 +
 hw/pci-host/pam.c                          |    1 -
 hw/pci/msix.c                              |    1 +
 hw/scsi/megasas.c                          |   44 +-
 hw/scsi/vhost-user-scsi.c                  |    1 -
 hw/usb/hcd-musb.c                          |    5 +-
 hw/usb/tusb6010.c                          |    1 +
 hw/vfio/pci.c                              |   37 +-
 hw/xen/Makefile.objs                       |    3 +-
 hw/xen/xen_pt.c                            |   12 +-
 hw/xen/xen_pt.h                            |    6 +-
 hw/xen/xen_pt_stub.c                       |   22 +
 include/exec/cpu-all.h                     |    1 +
 include/exec/cpu-common.h                  |    3 -
 include/exec/memory.h                      |   30 +-
 include/exec/ram_addr.h                    |    2 +-
 include/hw/display/edid.h                  |    3 -
 include/hw/elf_ops.h                       |   11 +-
 include/hw/hyperv/hyperv.h                 |    1 +
 include/hw/hyperv/vmbus-bridge.h           |   35 +
 include/hw/hyperv/vmbus-proto.h            |  222 +++
 include/hw/hyperv/vmbus.h                  |  230 +++
 include/hw/i386/vmport.h                   |   28 +
 include/hw/usb.h                           |   30 -
 include/hw/usb/hcd-musb.h                  |   47 +
 include/hw/xen/xen.h                       |   11 -
 include/io/task.h                          |    2 -
 include/qemu/thread.h                      |    2 +-
 include/qemu/typedefs.h                    |    2 +-
 include/qom/object.h                       |    2 -
 include/qom/qom-qobject.h                  |    2 -
 include/sysemu/accel.h                     |    2 +
 include/sysemu/hvf.h                       |   72 +-
 include/sysemu/kvm.h                       |    4 +
 include/sysemu/sysemu.h                    |    1 -
 include/sysemu/tcg.h                       |    2 +-
 include/sysemu/xen.h                       |   38 +
 io/task.c                                  |    1 +
 memory.c                                   |   75 +-
 migration/savevm.c                         |    2 +-
 monitor/misc.c                             |    3 +-
 qom/container.c                            |    1 -
 qom/object.c                               |   39 +-
 replay/replay-internal.c                   |   15 +-
 replay/replay.c                            |    5 +
 scripts/checkpatch.pl                      |    2 +-
 scripts/coverity-scan/coverity-scan.docker |    3 +-
 scripts/coverity-scan/run-coverity-scan    |  139 +-
 softmmu/vl.c                               |    7 +-
 stubs/Makefile.objs                        |    2 -
 stubs/qmp_memory_device.c                  |    1 -
 stubs/xen-common.c                         |   13 -
 target/i386/TODO                           |   31 -
 target/i386/cpu.c                          |   42 +-
 target/i386/cpu.h                          |   15 +-
 target/i386/fpu_helper.c                   |  258 ++-
 target/i386/hax-all.c                      |   25 +-
 target/i386/hax-i386.h                     |    7 +-
 target/i386/hvf/hvf-i386.h                 |   37 +-
 target/i386/hvf/hvf.c                      |   30 +-
 target/i386/hvf/x86.c                      |    2 +-
 target/i386/hvf/x86.h                      |   89 +-
 target/i386/hvf/x86_decode.c               |   25 +-
 target/i386/hvf/x86_emu.c                  |  122 +-
 target/i386/hvf/x86_flags.c                |   81 +-
 target/i386/hvf/x86_task.c                 |   10 +-
 target/i386/hvf/x86hvf.c                   |    6 +-
 target/i386/kvm.c                          |   34 +-
 target/i386/misc_helper.c                  |    2 +-
 target/i386/ops_sse.h                      |   57 +-
 target/i386/sev.c                          |  257 +--
 target/i386/sev_i386.h                     |   49 -
 target/ppc/cpu.h                           |    4 +-
 target/ppc/kvm_ppc.h                       |   22 +-
 target/ppc/translate_init.inc.c            |    4 +
 tests/docker/Makefile.include              |    2 +-
 tests/docker/docker.py                     |   14 +-
 tests/qtest/machine-none-test.c            |   10 +-
 tests/tcg/i386/Makefile.target             |    3 +
 tests/tcg/i386/test-i386-fbstp.c           |  140 ++
 tests/tcg/i386/test-i386-fisttp.c          |  100 +
 tests/tcg/i386/test-i386-fldcst.c          |  199 ++
 tests/tcg/i386/test-i386-fp-exceptions.c   |  831 +++++++++
 tests/tcg/i386/test-i386-fscale.c          |  108 ++
 tests/tcg/i386/test-i386-fxam.c            |  143 ++
 tests/tcg/i386/test-i386-fxtract.c         |  120 ++
 tests/tcg/i386/test-i386-pcmpistri.c       |   33 +
 tests/test-io-task.c                       |    1 +
 util/oslib-posix.c                         |    9 +
 126 files changed, 6572 insertions(+), 980 deletions(-)
 rename stubs/xen-hvm.c => accel/stubs/xen-stub.c (63%)
 create mode 100644 accel/xen/Makefile.objs
 rename hw/xen/xen-common.c => accel/xen/xen-all.c (96%)
 create mode 100644 hw/hyperv/trace-events
 create mode 100644 hw/hyperv/vmbus.c
 delete mode 100644 hw/i386/vmport.h
 create mode 100644 hw/xen/xen_pt_stub.c
 create mode 100644 include/hw/hyperv/vmbus-bridge.h
 create mode 100644 include/hw/hyperv/vmbus-proto.h
 create mode 100644 include/hw/hyperv/vmbus.h
 create mode 100644 include/hw/i386/vmport.h
 create mode 100644 include/hw/usb/hcd-musb.h
 create mode 100644 include/sysemu/xen.h
 delete mode 100644 stubs/xen-common.c
 delete mode 100644 target/i386/TODO
 create mode 100644 tests/tcg/i386/test-i386-fbstp.c
 create mode 100644 tests/tcg/i386/test-i386-fisttp.c
 create mode 100644 tests/tcg/i386/test-i386-fldcst.c
 create mode 100644 tests/tcg/i386/test-i386-fp-exceptions.c
 create mode 100644 tests/tcg/i386/test-i386-fscale.c
 create mode 100644 tests/tcg/i386/test-i386-fxam.c
 create mode 100644 tests/tcg/i386/test-i386-fxtract.c
 create mode 100644 tests/tcg/i386/test-i386-pcmpistri.c
-- 
2.26.2


