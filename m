Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E859C3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3816F206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3816F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i063j-00034W-CC
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0631-0002dS-4t
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i062z-0007iG-JX
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i062z-0007hF-Al
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:27:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3A6D2F30D4
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 15:27:44 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C7310013A1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 15:27:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 17:27:40 +0200
Message-Id: <1566314861-32709-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 20 Aug 2019 15:27:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/34] Misc patches for 2019-08-20
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

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91ce=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to f496f8aca311b0b1fab979657694069871426395:

  x86: Intel AVX512_BF16 feature enabling (2019-08-20 17:26:30 +0200)

----------------------------------------------------------------
* New KVM PV features (Marcelo, Wanpeng)
* valgrind fixes (Andrey)
* Remove clock reset notifiers (David)
* KConfig and Makefile cleanups (Paolo)
* Replay and icount improvements (Pavel)
* x86 FP fixes (Peter M.)
* TCG locking assertions (Roman)
* x86 support for mmap-ed -kernel/-initrd (Stefano)
* Other cleanups (Wei Yang, Yan Zhao, Tony)
* LSI fix for infinite loop (Prasad)
* ARM migration fix (Catherine)
* AVX512_BF16 feature (Jing)

----------------------------------------------------------------
Andrey Shinkevich (3):
      test-throttle: Fix uninitialized use of burst_length
      tests: Fix uninitialized byte in test_visitor_in_fuzz
      i386/kvm: initialize struct at full before ioctl call

Catherine Ho (1):
      migration: do not rom_reset() during incoming migration

Dr. David Alan Gilbert (4):
      mc146818rtc: Remove reset notifiers
      timer: Remove reset notifiers
      replay: Remove host_clock_last
      timer: last, remove last bits of last

Eduardo Habkost (1):
      HACKING: Document 'struct' keyword usage

Jan Kiszka (1):
      kvm: vmxcap: Enhance with latest features

Jing Liu (1):
      x86: Intel AVX512_BF16 feature enabling

Li Qiang (1):
      target-i386: kvm: 'kvm_get_supported_msrs' cleanup

Marcelo Tosatti (1):
      kvm: i386: halt poll control MSR support

Paolo Bonzini (3):
      9p: simplify source file selection
      memory: fix race between TCG and accesses to dirty bitmap
      scsi: lsi: exit infinite loop while executing script (CVE-2019-1206=
8)

Pavel Dovgalyuk (8):
      replay: add missing fix for internal function
      replay: document development rules
      util/qemu-timer: refactor deadline calculation for external timers
      replay: fix replay shutdown
      replay: refine replay-time module
      replay: rename step-related variables and functions
      icount: clean up cpu_can_io at the entry to the block
      icount: remove unnecessary gen_io_end calls

Peter Maydell (1):
      target/i386: Return 'indefinite integer value' for invalid SSE fp->=
int conversions

Roman Kagan (2):
      cpus-common: nuke finish_safe_work
      cpus-common: assert BQL nesting within cpu-exclusive sections

Stefano Garzarella (3):
      loader: Handle memory-mapped ELFs
      elf-ops.h: Map into memory the ELF to load
      hw/i386/pc: Map into memory the initrd

Wanpeng Li (1):
      target-i386: adds PV_SCHED_YIELD CPUID feature bit

Wei Yang (1):
      test-bitmap: test set 1 bit case for bitmap_set

Yan Zhao (1):
      memory: assert on out of scope notification

tony.nguyen@bt.com (1):
      configure: Define target access alignment in configure

 HACKING                                     |  14 +-
 Kconfig.host                                |   1 +
 accel/tcg/cpu-exec.c                        |   1 -
 accel/tcg/translator.c                      |   1 -
 configure                                   |  12 +-
 cpus-common.c                               |  12 +-
 cpus.c                                      |  17 ++-
 docs/devel/replay.txt                       |  46 +++++++
 exec.c                                      |  31 +++++
 fsdev/Makefile.objs                         |   2 +-
 hw/9pfs/Kconfig                             |   5 +
 hw/core/loader.c                            |  48 +++++--
 hw/i386/pc.c                                |  17 ++-
 hw/scsi/lsi53c895a.c                        |  41 ++++--
 hw/timer/mc146818rtc.c                      |  19 ---
 include/exec/gen-icount.h                   |  44 +++---
 include/exec/memory.h                       |  12 ++
 include/exec/poison.h                       |   1 +
 include/hw/elf_ops.h                        |  71 ++++++----
 include/hw/i386/pc.h                        |   1 +
 include/hw/loader.h                         |   5 +-
 include/qemu/timer.h                        |  43 +-----
 include/qom/cpu.h                           |   2 +-
 include/standard-headers/asm-x86/kvm_para.h |   2 +
 include/sysemu/replay.h                     |   2 +-
 memory.c                                    |  16 ++-
 migration/ram.c                             |   1 +
 qtest.c                                     |   3 +-
 replay/replay-events.c                      |   2 +-
 replay/replay-internal.c                    |  10 +-
 replay/replay-internal.h                    |  10 +-
 replay/replay-snapshot.c                    |  13 +-
 replay/replay-time.c                        |  36 +++--
 replay/replay.c                             |  30 ++--
 scripts/kvm/vmxcap                          |   8 ++
 target/alpha/cpu.h                          |   2 -
 target/alpha/translate.c                    |   2 -
 target/arm/translate-a64.c                  |   4 -
 target/arm/translate.c                      |   7 -
 target/cris/translate.c                     |   2 -
 target/hppa/cpu.h                           |   1 -
 target/hppa/translate.c                     |   1 -
 target/i386/cpu.c                           |  43 +++++-
 target/i386/cpu.h                           |   8 ++
 target/i386/kvm.c                           | 205 +++++++++++++++-------=
------
 target/i386/machine.c                       |  20 +++
 target/i386/ops_sse.h                       |  88 ++++++++----
 target/i386/translate.c                     |  10 --
 target/lm32/translate.c                     |   9 --
 target/microblaze/translate.c               |   2 -
 target/mips/cpu.h                           |   2 -
 target/mips/translate.c                     |  11 --
 target/nios2/translate.c                    |   4 -
 target/ppc/translate.c                      |  13 --
 target/ppc/translate_init.inc.c             |   2 -
 target/riscv/insn_trans/trans_rvi.inc.c     |   1 -
 target/sh4/cpu.h                            |   2 -
 target/sparc/cpu.h                          |   2 -
 target/sparc/translate.c                    |  16 ---
 target/unicore32/translate.c                |   1 -
 target/xtensa/cpu.h                         |   2 -
 target/xtensa/translate.c                   |  15 --
 tcg/tcg.c                                   |   2 +-
 tcg/tcg.h                                   |   8 +-
 tests/ptimer-test-stubs.c                   |   4 +-
 tests/ptimer-test.c                         |   6 +-
 tests/test-bitmap.c                         |  12 ++
 tests/test-string-input-visitor.c           |   8 +-
 tests/test-throttle.c                       |   2 +
 util/qemu-timer.c                           |  71 ++++------
 70 files changed, 665 insertions(+), 502 deletions(-)
 create mode 100644 docs/devel/replay.txt
--=20
1.8.3.1


