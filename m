Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DD3C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA72214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA72214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHE2Z-0006PO-Ec
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:53:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0T-00056B-3m
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0R-0005AC-4f
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0Q-00059K-Qc
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC1673008CC7
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 85DDC5D9CC
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EBA011138648; Thu, 18 Apr 2019 22:51:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:50:59 +0200
Message-Id: <20190418205135.6686-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 00/36] Error reporting & monitor patches
 for 2019-04-18
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418205059.mm3WN7fo7sOCLAYz4pCMmREivg2Xa2MqWSvlvqEVzT8@z>

Early pull request because I'll be on vacation when 4.1 opens.  Hope
that's okay.

The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb599=
83:

  Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-monitor-2019-04-18

for you to fetch changes up to ede9a8a656c992deecce45f8175985dd81cc6be9:

  include: Move fprintf_function to disas/ (2019-04-18 22:18:59 +0200)

----------------------------------------------------------------
Error reporting & monitor patches for 2019-04-18

----------------------------------------------------------------
Christophe Fergeau (2):
      qemu-io: Use error_[gs]et_progname()
      log: Make glib logging go through QEMU

Markus Armbruster (33):
      error: Fix error_report_err(), warn_report_err() hint printing
      qemu-img: Use error_vreport() in error_exit()
      block/ssh: Do not report read/write/flush errors to the user
      loader-fit: Wean off error_printf()
      mips/boston: Report errors with error_report(), not error_printf()
      pci: Report fatal errors with error_report(), not error_printf()
      hpet: Report warnings with warn_report(), not error_printf()
      vfio: Report warnings with warn_report(), not error_printf()
      s390x/kvm: Report warnings with warn_report(), not error_printf()
      vl: Make -machine $TYPE,help and -accel help print to stdout
      monitor error: Make printf()-like functions return a value
      qemu-print: New qemu_printf(), qemu_vprintf() etc.
      blockdev: Make -drive format=3Dhelp print to stdout
      char: Make -chardev help print to stdout
      char-pty: Print "char device redirected" message to stdout
      monitor: Simplify how -device/device_add print help
      include: Include fprintf-fn.h only where needed
      trace: Simplify how st_print_trace_file_status() prints
      tcg: Simplify how dump_opcount_info() prints
      tcg: Simplify how dump_exec_info() prints
      tcg: Simplify how dump_drift_info() prints
      qsp: Simplify how qsp_report() prints
      block/qapi: Clean up how we print to monitor or stdout
      memory: Clean up how mtree_info() prints
      target: Simplify how the TARGET_cpu_list() print
      target: Clean up how the dump_mmu() print
      target/i386: Simplify how x86_cpu_dump_local_apic_state() prints
      qom/cpu: Simplify how CPUClass::dump_statistics() prints
      qemu-print: New qemu_fprintf(), qemu_vfprintf()
      qom/cpu: Simplify how CPUClass:cpu_dump_state() prints
      monitor: Clean up how monitor_disas() funnels output to monitor
      disas: Rename include/disas/bfd.h back to include/disas/dis-asm.h
      include: Move fprintf_function to disas/

Vladimir Sementsov-Ogievskiy (1):
      util/error: do not free error on error_abort

 MAINTAINERS                        |   2 +
 accel/kvm/kvm-all.c                |   4 +-
 accel/tcg/translate-all.c          |  49 ++---
 block/qapi.c                       | 120 ++++++-------
 block/ssh.c                        |  38 ++--
 block/trace-events                 |   3 +
 blockdev.c                         |   9 +-
 bsd-user/main.c                    |   6 +-
 chardev/char-pty.c                 |   5 +-
 chardev/char.c                     |   3 +-
 cpus.c                             |  21 ++-
 disas.c                            |   5 +-
 disas/alpha.c                      |   2 +-
 disas/arm-a64.cc                   |   2 +-
 disas/arm.c                        |   2 +-
 disas/cris.c                       |   2 +-
 disas/hppa.c                       |   2 +-
 disas/i386.c                       |   2 +-
 disas/lm32.c                       |   2 +-
 disas/m68k.c                       |   2 +-
 disas/microblaze.c                 |   2 +-
 disas/mips.c                       |   2 +-
 disas/moxie.c                      |   2 +-
 disas/nanomips.cpp                 |   2 +-
 disas/nios2.c                      |   2 +-
 disas/ppc.c                        |   2 +-
 disas/riscv.c                      |   2 +-
 disas/s390.c                       |   2 +-
 disas/sh4.c                        |   2 +-
 disas/sparc.c                      |   2 +-
 disas/tci.c                        |   2 +-
 disas/xtensa.c                     |   2 +-
 exec.c                             |  42 ++---
 hmp.c                              |  12 +-
 hw/core/loader-fit.c               |  62 ++++---
 hw/mips/boston.c                   |   6 +-
 hw/pci/pci.c                       |   2 +-
 hw/timer/hpet.c                    |   2 +-
 hw/vfio/pci.c                      |  19 +-
 include/block/qapi.h               |   9 +-
 include/disas/{bfd.h =3D> dis-asm.h} |   5 +-
 include/exec/cpu-all.h             |   4 +-
 include/exec/cpu-common.h          |  13 --
 include/exec/log.h                 |   2 +-
 include/exec/memory-internal.h     |   3 +-
 include/exec/memory.h              |   3 +-
 include/monitor/monitor.h          |   8 +-
 include/qemu-common.h              |   2 -
 include/qemu/cutils.h              |   2 -
 include/qemu/error-report.h        |  11 +-
 include/qemu/fprintf-fn.h          |  14 --
 include/qemu/qemu-print.h          |  23 +++
 include/qemu/qsp.h                 |   6 +-
 include/qom/cpu.h                  |  24 +--
 include/sysemu/cpus.h              |   4 +-
 linux-user/alpha/cpu_loop.c        |   2 +-
 linux-user/cpu_loop-common.h       |   2 +-
 linux-user/cris/cpu_loop.c         |   2 +-
 linux-user/main.c                  |   4 +-
 linux-user/microblaze/cpu_loop.c   |   4 +-
 linux-user/s390x/cpu_loop.c        |   4 +-
 linux-user/sh4/cpu_loop.c          |   2 +-
 linux-user/sparc/cpu_loop.c        |   2 +-
 memory.c                           | 156 ++++++++--------
 monitor.c                          |  89 ++++------
 qdev-monitor.c                     |  36 ++--
 qemu-img.c                         |  14 +-
 qemu-io-cmds.c                     |   2 +-
 qemu-io.c                          |  14 +-
 qemu-nbd.c                         |   2 +-
 qom/cpu.c                          |  11 +-
 scsi/qemu-pr-helper.c              |   1 +
 stubs/error-printf.c               |  13 +-
 stubs/monitor.c                    |   5 +
 target/alpha/cpu.c                 |  15 +-
 target/alpha/cpu.h                 |   5 +-
 target/alpha/helper.c              |  24 +--
 target/arm/arm-semi.c              |   2 +-
 target/arm/cpu.c                   |   1 -
 target/arm/cpu.h                   |   5 +-
 target/arm/helper.c                |  15 +-
 target/arm/translate-a64.c         |  82 ++++-----
 target/arm/translate.c             |  58 +++---
 target/arm/translate.h             |   7 +-
 target/cris/cpu.c                  |  14 +-
 target/cris/cpu.h                  |   5 +-
 target/cris/helper.c               |   2 +-
 target/cris/translate.c            |  36 ++--
 target/hppa/cpu.c                  |  14 +-
 target/hppa/cpu.h                  |   4 +-
 target/hppa/helper.c               |  24 +--
 target/i386/cpu.c                  |  29 ++-
 target/i386/cpu.h                  |   8 +-
 target/i386/hax-all.c              |   4 +-
 target/i386/helper.c               | 356 ++++++++++++++++++-------------=
------
 target/i386/monitor.c              |   3 +-
 target/lm32/cpu.c                  |  14 +-
 target/lm32/cpu.h                  |   5 +-
 target/lm32/translate.c            |  36 ++--
 target/m68k/cpu.h                  |   8 +-
 target/m68k/helper.c               | 129 +++++++-------
 target/m68k/monitor.c              |   2 +-
 target/m68k/translate.c            |  86 ++++-----
 target/microblaze/cpu.h            |   3 +-
 target/microblaze/helper.c         |   2 +-
 target/microblaze/translate.c      |  39 ++--
 target/mips/cpu.h                  |   2 +-
 target/mips/internal.h             |   3 +-
 target/mips/translate.c            |  77 ++++----
 target/mips/translate_init.inc.c   |   5 +-
 target/moxie/cpu.h                 |   3 +-
 target/moxie/helper.c              |   2 +-
 target/moxie/translate.c           |  22 +--
 target/nios2/cpu.h                 |   5 +-
 target/nios2/helper.c              |   2 +-
 target/nios2/mmu.c                 |   7 +-
 target/nios2/monitor.c             |   2 +-
 target/nios2/translate.c           |  24 +--
 target/openrisc/cpu.c              |  15 +-
 target/openrisc/cpu.h              |   5 +-
 target/openrisc/disas.c            |   2 +-
 target/openrisc/translate.c        |  11 +-
 target/ppc/cpu.h                   |  10 +-
 target/ppc/mmu-hash64.c            |   7 +-
 target/ppc/mmu-hash64.h            |   2 +-
 target/ppc/mmu_helper.c            |  70 ++++----
 target/ppc/monitor.c               |   2 +-
 target/ppc/translate.c             | 170 +++++++++---------
 target/ppc/translate_init.inc.c    |  28 ++-
 target/riscv/cpu.c                 |  54 +++---
 target/riscv/cpu.h                 |   2 +-
 target/s390x/cpu.h                 |   2 +-
 target/s390x/cpu_models.c          |  21 +--
 target/s390x/helper.c              |  42 ++---
 target/s390x/internal.h            |   3 +-
 target/s390x/kvm.c                 |   2 +-
 target/sh4/cpu.c                   |  17 +-
 target/sh4/cpu.h                   |   5 +-
 target/sh4/translate.c             |  27 +--
 target/sparc/cpu.c                 | 133 +++++++-------
 target/sparc/cpu.h                 |   7 +-
 target/sparc/ldst_helper.c         |  18 +-
 target/sparc/mmu_helper.c          |  97 +++++-----
 target/sparc/monitor.c             |   2 +-
 target/tilegx/cpu.c                |  14 +-
 target/tricore/cpu.h               |   5 +-
 target/tricore/helper.c            |  15 +-
 target/tricore/translate.c         |  26 +--
 target/unicore32/cpu.h             |   3 +-
 target/unicore32/translate.c       |  39 ++--
 target/xtensa/cpu.h                |   7 +-
 target/xtensa/helper.c             |   7 +-
 target/xtensa/mmu_helper.c         |  24 ++-
 target/xtensa/monitor.c            |   2 +-
 target/xtensa/translate.c          |  40 +++--
 tcg/tcg.c                          |  50 +++---
 tcg/tcg.h                          |   4 +-
 tests/test-util-sockets.c          |   1 +
 trace/simple.c                     |   7 +-
 trace/simple.h                     |   2 +-
 util/Makefile.objs                 |   1 +
 util/error.c                       |   9 +-
 util/qemu-error.c                  |  67 ++++++-
 util/qemu-print.c                  |  69 +++++++
 util/qsp.c                         |  21 +--
 vl.c                               |  14 +-
 166 files changed, 1651 insertions(+), 1669 deletions(-)
 rename include/disas/{bfd.h =3D> dis-asm.h} (99%)
 delete mode 100644 include/qemu/fprintf-fn.h
 create mode 100644 include/qemu/qemu-print.h
 create mode 100644 util/qemu-print.c

--=20
2.17.2


