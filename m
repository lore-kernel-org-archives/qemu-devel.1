Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27987C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6617206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdXWKjbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6617206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUHY-00051F-1E
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC6-0003I4-PZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC4-00034h-0A
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n4l6ZbWVAfkOT9xXUnDqeOEBrRcSswBLEr6vm8VBeNw=;
 b=OdXWKjbOSPlfisPQrvy9FWsbwC0DMDGQ0aEeaDySgifkUaO9usPNnAxCONYaFC1pzlHiLR
 KGlW2f2p8ymue/ZTd9Xmqh9kd1IiVneC5iQu/nwI91224Su5wrtfWwjF25zxZkiipJN6LM
 2WJwabFmOh4jx4JgijwsSu7I2I3GzWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-Lqf6oSM8Pa29JuUpKh4IIA-1; Mon, 06 Jul 2020 12:41:57 -0400
X-MC-Unique: Lqf6oSM8Pa29JuUpKh4IIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7452B461
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 16:41:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A8721002380
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 16:41:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
Date: Mon,  6 Jul 2020 12:41:02 -0400
Message-Id: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:

  hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 80270507070ec73ea82741ce24cb7909a9258ea3:

  scripts: improve message when TAP based tests fail (2020-07-06 12:14:25 -0400)

----------------------------------------------------------------
* Make checkpatch say 'qemu' instead of 'kernel' (Aleksandar)
* Fix PSE guests with emulated NPT (Alexander B. #1)
* Fix leak (Alexander B. #2)
* HVF fixes (Roman, Cameron)
* New Sapphire Rapids CPUID bits (Cathy)
* cpus.c and softmmu/ cleanups (Claudio)
* TAP driver tweaks (Daniel, Havard)
* object-add bugfix and testcases (Eric A.)
* Fix Coverity MIN_CONST and MAX_CONST (Eric B.)
* SSE fixes (Joseph)
* "-msg guest-name" option (Mario)
* support for AMD nested live migration (myself)
* Small i386 TCG fixes (myself)
* improved error reporting for Xen (myself)
* fix "-cpu host -overcommit cpu-pm=on" (myself)
* Add accel/Kconfig (Philippe)
* KVM API cleanup (Philippe)
* iscsi sense handling fixes (Yongji)
* Misc bugfixes

----------------------------------------------------------------
Aleksandar Markovic (1):
      checkpatch: Change occurences of 'kernel' to 'qemu' in user messages

Alexander Boettcher (1):
      tcg/svm: use host cr4 during NPT page table walk

Alexander Bulekov (1):
      pc: fix leak in pc_system_flash_cleanup_unused

Cameron Esfahani (1):
      i386: hvf: Make long mode enter and exit clearer

Cathy Zhang (2):
      target/i386: Add SERIALIZE cpu feature
      target/i386: Enable TSX Suspend Load Address Tracking feature

Claudio Fontana (3):
      softmmu: move softmmu only files from root
      cpu-throttle: new module, extracted from cpus.c
      cpu-timers, icount: new modules

Daniel P. Berrangé (1):
      scripts: improve message when TAP based tests fail

Eric Auger (3):
      qom: Introduce object_property_try_add_child()
      tests/qmp-cmd-test: Add qmp/object-add-duplicate-id
      tests/qmp-cmd-test: Add qmp/object-add-failure-modes

Eric Blake (1):
      coverity: provide Coverity-friendly MIN_CONST and MAX_CONST

Havard Skinnemoen (1):
      tests: Inject test name also when the test fails

Joseph Myers (2):
      target/i386: set SSE FTZ in correct floating-point state
      target/i386: fix IEEE SSE floating-point exception raising

Luwei Kang (1):
      target/i386: Correct the warning message of Intel PT

Mario Smarduch (1):
      util/qemu-error: prepend guest name to error message to identify affected VM owner

Paolo Bonzini (7):
      KVM: add support for AMD nested live migration
      Makefile: simplify MINIKCONF rules
      target/i386: remove gen_io_end
      target/i386: implement undocumented "smsw r32" behavior
      KVM: x86: believe what KVM says about WAITPKG
      target/i386: sev: provide proper error reporting for query-sev-capabilities
      target/i386: sev: fail query-sev-capabilities if QEMU cannot use SEV

Philippe Mathieu-Daudé (16):
      hw/core/null-machine: Do not initialize unused chardev backends
      MAINTAINERS: Fix KVM path expansion glob
      MAINTAINERS: Add an 'overall' entry for accelerators
      MAINTAINERS: Cover the HAX accelerator stub
      Makefile: Remove dangerous EOL trailing backslash
      Makefile: Write MINIKCONF variables as one entry per line
      accel/Kconfig: Extract accel selectors into their own config
      accel/Kconfig: Add the TCG selector
      accel/tcg: Add stub for probe_access()
      cpus: Move CPU code from exec.c to cpus-common.c
      accel/kvm: Let kvm_check_extension use global KVM state
      accel/kvm: Simplify kvm_check_extension()
      accel/kvm: Simplify kvm_check_extension_list()
      target/i386/kvm: Simplify get_para_features()
      target/i386/kvm: Simplify kvm_get_mce_cap_supported()
      target/i386/kvm: Simplify kvm_get_supported_[feature]_msrs()

Roman Bolshakov (7):
      i386: hvf: Set env->eip in macvm_set_rip()
      i386: hvf: Move synchronize functions to sysemu
      i386: hvf: Add hvf_cpu_synchronize_pre_loadvm()
      i386: hvf: Move Guest LMA reset to macvm_set_cr0()
      i386: hvf: Don't duplicate register reset
      i386: hvf: Clean up synchronize functions
      MAINTAINERS: Add Cameron as HVF co-maintainer

Thomas Huth (1):
      softmmu/vl: Remove the check for colons in -accel parameters

Xie Yongji (2):
      iscsi: handle check condition status in retry loop
      iscsi: return -EIO when sense fields are meaningless

lichun (1):
      chardev/tcp: fix error message double free error

 Kconfig                                      |   4 +
 Kconfig.host                                 |   7 -
 MAINTAINERS                                  |  31 +-
 Makefile                                     |  12 +-
 Makefile.target                              |   7 +-
 accel/Kconfig                                |   9 +
 accel/kvm/kvm-all.c                          |  72 +--
 accel/qtest.c                                |   6 +-
 accel/stubs/tcg-stub.c                       |   7 +
 accel/tcg/cpu-exec.c                         |  43 +-
 accel/tcg/tcg-all.c                          |   7 +-
 accel/tcg/translate-all.c                    |   3 +-
 block/iscsi.c                                |  22 +-
 chardev/char-socket.c                        |   3 +-
 cpus-common.c                                |  18 +
 dma-helpers.c                                |   4 +-
 docs/replay.txt                              |   6 +-
 exec.c                                       |  26 -
 hw/core/null-machine.c                       |   5 +
 hw/core/ptimer.c                             |   8 +-
 hw/hyperv/hyperv.c                           |   2 +-
 hw/i386/kvm/clock.c                          |   2 +-
 hw/i386/kvm/i8254.c                          |   4 +-
 hw/i386/kvm/ioapic.c                         |   2 +-
 hw/i386/pc_sysfw.c                           |   5 +
 hw/i386/x86.c                                |   1 +
 hw/intc/arm_gic_kvm.c                        |   2 +-
 hw/intc/openpic_kvm.c                        |   2 +-
 hw/intc/xics_kvm.c                           |   2 +-
 hw/s390x/s390-stattrib-kvm.c                 |   2 +-
 include/exec/cpu-all.h                       |   4 +
 include/exec/exec-all.h                      |   4 +-
 include/hw/core/cpu.h                        |  37 --
 include/qemu/error-report.h                  |   2 +
 include/qemu/main-loop.h                     |   5 +
 include/qemu/osdep.h                         |  21 +-
 include/qemu/timer.h                         |  22 +-
 include/qom/object.h                         |  26 +-
 include/sysemu/cpu-throttle.h                |  68 +++
 include/sysemu/cpu-timers.h                  |  81 +++
 include/sysemu/cpus.h                        |  12 +-
 include/sysemu/hvf.h                         |   2 +-
 include/sysemu/hw_accel.h                    |  13 +
 include/sysemu/kvm.h                         |   2 +-
 include/sysemu/qtest.h                       |   2 +
 include/sysemu/replay.h                      |   4 +-
 migration/migration.c                        |   1 +
 migration/ram.c                              |   1 +
 qemu-options.hx                              |  12 +-
 qom/object.c                                 |  21 +-
 qom/object_interfaces.c                      |   7 +-
 replay/replay.c                              |   6 +-
 scripts/checkpatch.pl                        |   6 +-
 scripts/tap-driver.pl                        |   2 +-
 softmmu/Makefile.objs                        |  13 +
 arch_init.c => softmmu/arch_init.c           |   0
 balloon.c => softmmu/balloon.c               |   0
 softmmu/cpu-throttle.c                       | 122 ++++
 softmmu/cpu-timers.c                         | 284 +++++++++
 cpus.c => softmmu/cpus.c                     | 851 +--------------------------
 softmmu/icount.c                             | 499 ++++++++++++++++
 ioport.c => softmmu/ioport.c                 |   0
 memory.c => softmmu/memory.c                 |   0
 memory_mapping.c => softmmu/memory_mapping.c |   0
 qtest.c => softmmu/qtest.c                   |  34 +-
 softmmu/timers-state.h                       |  69 +++
 softmmu/vl.c                                 |  22 +-
 stubs/Makefile.objs                          |   3 +-
 stubs/clock-warp.c                           |   4 +-
 stubs/cpu-get-clock.c                        |   3 +-
 stubs/cpu-get-icount.c                       |  21 -
 stubs/icount.c                               |  22 +
 stubs/qemu-timer-notify-cb.c                 |   8 +
 stubs/qtest.c                                |   5 +
 target/alpha/translate.c                     |   3 +-
 target/arm/helper.c                          |   7 +-
 target/arm/kvm.c                             |  13 +-
 target/arm/kvm32.c                           |   2 +-
 target/arm/kvm64.c                           |  15 +-
 target/i386/cpu.c                            |  13 +-
 target/i386/cpu.h                            |  10 +
 target/i386/excp_helper.c                    |   4 +-
 target/i386/fpu_helper.c                     |  35 +-
 target/i386/gdbstub.c                        |   1 +
 target/i386/helper.c                         |   1 +
 target/i386/helper.h                         |   1 +
 target/i386/hvf/hvf.c                        | 137 +----
 target/i386/hvf/vmx.h                        |  17 +-
 target/i386/kvm.c                            | 143 +++--
 target/i386/kvm_i386.h                       |   1 +
 target/i386/machine.c                        |  31 +-
 target/i386/monitor.c                        |  10 +-
 target/i386/ops_sse.h                        |  28 +-
 target/i386/sev-stub.c                       |   3 +-
 target/i386/sev.c                            |  27 +-
 target/i386/sev_i386.h                       |   2 +-
 target/i386/svm.h                            |   1 +
 target/i386/svm_helper.c                     |   7 +-
 target/i386/translate.c                      |  36 +-
 target/mips/kvm.c                            |   4 +-
 target/ppc/kvm.c                             |  34 +-
 target/riscv/csr.c                           |   8 +-
 target/s390x/cpu_models.c                    |   3 +-
 target/s390x/kvm.c                           |  30 +-
 tests/Makefile.include                       |   2 +-
 tests/ptimer-test-stubs.c                    |   7 +-
 tests/qtest/qmp-cmd-test.c                   | 109 +++-
 tests/tcg/i386/Makefile.target               |   4 +
 tests/tcg/i386/test-i386-sse-exceptions.c    | 813 +++++++++++++++++++++++++
 tests/test-timed-average.c                   |   2 +-
 util/main-loop.c                             |   4 +-
 util/qemu-error.c                            |   7 +
 util/qemu-timer.c                            |  12 +-
 113 files changed, 2817 insertions(+), 1415 deletions(-)
 create mode 100644 Kconfig
 create mode 100644 accel/Kconfig
 create mode 100644 include/sysemu/cpu-throttle.h
 create mode 100644 include/sysemu/cpu-timers.h
 rename arch_init.c => softmmu/arch_init.c (100%)
 rename balloon.c => softmmu/balloon.c (100%)
 create mode 100644 softmmu/cpu-throttle.c
 create mode 100644 softmmu/cpu-timers.c
 rename cpus.c => softmmu/cpus.c (58%)
 create mode 100644 softmmu/icount.c
 rename ioport.c => softmmu/ioport.c (100%)
 rename memory.c => softmmu/memory.c (100%)
 rename memory_mapping.c => softmmu/memory_mapping.c (100%)
 rename qtest.c => softmmu/qtest.c (95%)
 create mode 100644 softmmu/timers-state.h
 delete mode 100644 stubs/cpu-get-icount.c
 create mode 100644 stubs/icount.c
 create mode 100644 stubs/qemu-timer-notify-cb.c
 create mode 100644 tests/tcg/i386/test-i386-sse-exceptions.c
-- 
2.26.2


