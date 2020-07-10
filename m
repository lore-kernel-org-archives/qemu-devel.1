Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D6620772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgxh+3UN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D6620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju2mT-0003aI-33
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 19:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju2lb-00026F-4Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:49:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju2lZ-0002uq-4L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594424955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q03CJRYWR7q18aKvTj6q0Pc1rDmElh53GwLoutSYxBs=;
 b=Kgxh+3UNKVmCH40e/cIGRIdEDmorT40B1HdRyuFUpZmbdKlcmteBOb0zXKJxvLH91tV9yV
 ZxyZEcZ7Ot3I+y1lng9NU23DZvT3ltw2Y6GIqTpHu5pdHE5/StlQGh1BD6qI1LMpBCyGqK
 AJSKL6uh2gcz5rORwLF+2RwW5u+dhE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-xNbocgvXN4qT_dJnPXWkeA-1; Fri, 10 Jul 2020 19:49:11 -0400
X-MC-Unique: xNbocgvXN4qT_dJnPXWkeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5094B8027E1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 23:49:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F3215C240
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 23:49:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/47] Misc patches for QEMU 5.1 soft freeze
Date: Fri, 10 Jul 2020 19:49:07 -0400
Message-Id: <20200710234909.21682-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 19:49:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 45db94cc90c286a9965a285ba19450f448760a09:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200707' into staging (2020-07-10 16:43:40 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 56908dc5041aa424fd1495b6c6beb78c539d93e1:

  linux-headers: update again to 5.8 (2020-07-10 19:26:55 -0400)

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
* "info lapic" improvement (Jan)
* SSE fixes (Joseph)
* "-msg guest-name" option (Mario)
* support for AMD nested live migration (myself)
* Small i386 TCG fixes (myself)
* improved error reporting for Xen (myself)
* fix "-cpu host -overcommit cpu-pm=on" (myself)
* Add accel/Kconfig (Philippe)
* iscsi sense handling fixes (Yongji)
* Misc bugfixes

----------------------------------------------------------------
v2->v3: dropped Philippe's KVM series as it seemed to make some tests flaky
	added Linux kernel headers update/fix
	fixed Cocoa includes
	
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

Claudio Fontana (2):
      softmmu: move softmmu only files from root
      cpu-throttle: new module, extracted from cpus.c

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

Jan Kiszka (1):
      apic: Report current_count via 'info lapic'

Joseph Myers (2):
      target/i386: set SSE FTZ in correct floating-point state
      target/i386: fix IEEE SSE floating-point exception raising

Luwei Kang (1):
      target/i386: Correct the warning message of Intel PT

Mario Smarduch (1):
      util/qemu-error: prepend guest name to error message to identify affected VM owner

Paolo Bonzini (8):
      KVM: add support for AMD nested live migration
      Makefile: simplify MINIKCONF rules
      target/i386: remove gen_io_end
      target/i386: implement undocumented "smsw r32" behavior
      KVM: x86: believe what KVM says about WAITPKG
      target/i386: sev: provide proper error reporting for query-sev-capabilities
      target/i386: sev: fail query-sev-capabilities if QEMU cannot use SEV
      linux-headers: update again to 5.8

Philippe Mathieu-Daudé (10):
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

 Kconfig                                      |   4 +
 Kconfig.host                                 |   7 -
 MAINTAINERS                                  |  29 +-
 Makefile                                     |  12 +-
 Makefile.target                              |   7 +-
 accel/Kconfig                                |   9 +
 accel/stubs/tcg-stub.c                       |   7 +
 block/iscsi.c                                |  22 +-
 cpus-common.c                                |  18 +
 exec.c                                       |  22 -
 hw/core/null-machine.c                       |   5 +
 hw/i386/pc_sysfw.c                           |   5 +
 hw/intc/apic.c                               |  18 -
 hw/intc/apic_common.c                        |  19 +
 include/hw/core/cpu.h                        |  37 --
 include/hw/i386/apic_internal.h              |   1 +
 include/qemu/error-report.h                  |   2 +
 include/qemu/main-loop.h                     |   5 +
 include/qemu/osdep.h                         |  21 +-
 include/qom/object.h                         |  26 +-
 include/sysemu/cpu-throttle.h                |  68 +++
 include/sysemu/hvf.h                         |   2 +-
 include/sysemu/hw_accel.h                    |  13 +
 linux-headers/asm-arm/unistd-common.h        |   1 +
 linux-headers/asm-x86/kvm.h                  |   5 +-
 migration/migration.c                        |   1 +
 migration/ram.c                              |   1 +
 qemu-options.hx                              |  12 +-
 qom/object.c                                 |  21 +-
 qom/object_interfaces.c                      |   7 +-
 scripts/checkpatch.pl                        |   6 +-
 scripts/tap-driver.pl                        |   2 +-
 softmmu/Makefile.objs                        |  11 +
 arch_init.c => softmmu/arch_init.c           |   0
 balloon.c => softmmu/balloon.c               |   0
 softmmu/cpu-throttle.c                       | 122 ++++
 cpus.c => softmmu/cpus.c                     | 107 +---
 ioport.c => softmmu/ioport.c                 |   0
 memory.c => softmmu/memory.c                 |   0
 memory_mapping.c => softmmu/memory_mapping.c |   0
 qtest.c => softmmu/qtest.c                   |   0
 softmmu/vl.c                                 |  14 +-
 target/i386/Makefile.objs                    |   1 +
 target/i386/cpu.c                            |  13 +-
 target/i386/cpu.h                            |  10 +
 target/i386/excp_helper.c                    |   4 +-
 target/i386/fpu_helper.c                     |  37 +-
 target/i386/gdbstub.c                        |   1 +
 target/i386/helper.c                         |   6 +-
 target/i386/helper.h                         |   1 +
 target/i386/hvf/hvf.c                        | 137 +----
 target/i386/hvf/vmx.h                        |  17 +-
 target/i386/kvm.c                            |  53 +-
 target/i386/kvm_i386.h                       |   1 +
 target/i386/machine.c                        |  31 +-
 target/i386/monitor.c                        |  10 +-
 target/i386/ops_sse.h                        |  28 +-
 target/i386/sev-stub.c                       |   3 +-
 target/i386/sev.c                            |  27 +-
 target/i386/sev_i386.h                       |   2 +-
 target/i386/svm.h                            |   1 +
 target/i386/svm_helper.c                     |   7 +-
 target/i386/tcg-stub.c                       |  25 +
 target/i386/translate.c                      |  36 +-
 tests/Makefile.include                       |   2 +-
 tests/qtest/qmp-cmd-test.c                   | 109 +++-
 tests/tcg/i386/Makefile.target               |   4 +
 tests/tcg/i386/test-i386-sse-exceptions.c    | 813 +++++++++++++++++++++++++++
 ui/cocoa.m                                   |   1 +
 util/qemu-error.c                            |   7 +
 70 files changed, 1615 insertions(+), 441 deletions(-)
 create mode 100644 Kconfig
 create mode 100644 accel/Kconfig
 create mode 100644 include/sysemu/cpu-throttle.h
 rename arch_init.c => softmmu/arch_init.c (100%)
 rename balloon.c => softmmu/balloon.c (100%)
 create mode 100644 softmmu/cpu-throttle.c
 rename cpus.c => softmmu/cpus.c (95%)
 rename ioport.c => softmmu/ioport.c (100%)
 rename memory.c => softmmu/memory.c (100%)
 rename memory_mapping.c => softmmu/memory_mapping.c (100%)
 rename qtest.c => softmmu/qtest.c (100%)
 create mode 100644 target/i386/tcg-stub.c
 create mode 100644 tests/tcg/i386/test-i386-sse-exceptions.c
-- 
2.26.2


