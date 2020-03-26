Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9188C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EB520714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u20mjN5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EB520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYJt-0005Xl-Oo
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJA-0004iB-3t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYJ8-0000ry-0x
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:36:51 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34]:36713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYJ7-0000rG-Se
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:36:49 -0400
Received: by mail-qv1-xf34.google.com with SMTP id z13so3704345qvw.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kqtFFQV8u75W3WgJbsOdDpyl4vAvzBeiJ1D7zCX75Lo=;
 b=u20mjN5bM6MqDqrDquAZhLqp+HOY2Nvfbms/AA5+LqUVoo+i9SOvLytKLpVWI/TNS2
 IPEyYxf0WCDdN+4Ec6uKfoZXDGAH7oIQfvwSdYY1YJXv1MDSM/13IhbtURCbchLB/tdz
 ucTmSkZSbRR8KVYTfJweD7ULsQiHXLLF8h3dbjPIsiJjdsuM9mpR6LUgP9rVqP9xml69
 w0qT2HiLRb/zFiBYlbBkm+sQeGeYSjcxvCbXUVF6peGftbxO2aiwt3rEgP1wufiLt/KT
 bHTsBrUF7v9NKmXJyzEomVP1uNtMm2CI5/8Ct3TwM+jX7mC7WSx2VJiUUnusQ9RUULZw
 zOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kqtFFQV8u75W3WgJbsOdDpyl4vAvzBeiJ1D7zCX75Lo=;
 b=U/VsDztY8pnT+3iW2ZletOF5M2fnyjUoklO9lCu1/btYqIBbS5l5JY5Y3mQvlGV5tL
 doRCMEGwe5eNu/HRZO40UDXsHKYPRX0BEFA2IlgMVNPyiCkh7ev2SQrFDy9d6dlWLMbt
 sI1ar9cRgGGLoHyGpqWkZulEyBvOeb3smgqJbF2EQvayac+Rr9fgcxWg2lq42+ASNhmR
 e+E8lZWe0pflKHAVWNnkSz9TtA1S0TnXUR5IJzmpHI91M7+uj1EbvcA2ckSAiCcbtzba
 A3ImlZqIY00ntCto4oMkXEjlLRaSNzr5M+ypuFOf8GLabaBmt+nPWZ227ysSu+PzAvz+
 bFFg==
X-Gm-Message-State: ANhLgQ0Asi5kQkQtMwJfY64yierVS7xEc2MJF1PiKxmhNTeySCoLgbQt
 i5drz78RfajtGYcn18u5zBnlqwOIBdBqHA==
X-Google-Smtp-Source: ADFU+vuevz101/BeCkMCO4sKagjwCO8ww3iB6vXBahZtYtPqxXntTmRWvcW2ROWJn4Fz3c/fZ2367Q==
X-Received: by 2002:a0c:fc03:: with SMTP id z3mr9567813qvo.210.1585251407887; 
 Thu, 26 Mar 2020 12:36:47 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:36:46 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/74] per-CPU locks
Date: Thu, 26 Mar 2020 15:30:42 -0400
Message-Id: <20200326193156.4322-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f34
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V7: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00786.html

This is a continuation of the series created by Emilio Cota.
We are picking up this patch set with the goal to apply 
any fixes or updates needed to get this accepted.

Quoting an earlier patch in the series:
"For context, the goal of this series is to substitute the BQL for the
per-CPU locks in many places, notably the execution loop in cpus.c.
This leads to better scalability for MTTCG, since CPUs don't have
to acquire a contended global lock (the BQL) every time they
stop executing code.
See the last commit for some performance numbers."

Listed below are the changes for this version of the patch, 
aside from the merge related changes.

Changes for V8:
- Fixed issue where in rr mode we could destroy the BQL twice.
  Added new function cpu_mutex_destroy().
- Removed g_assert(qemu_mutex_iothread_locked())
  from qemu_tcg_rr_all_cpu_threads_idle().  There is an existing
  case where we call qemu_tcg_rr_all_cpu_threads_idle() without
  the BQL held, so we cannot assert on the lock here.
- Found/fixed bug that had been hit in testing previously during 
  the last consideration of this patch.
  We reproduced the issue hit in the qtest: bios-tables-test.
  The issue was introduced by dropping the BQL, and found us
  (very rarely) missing the condition variable wakeup in
  qemu_tcg_rr_cpu_thread_fn().
- ppc: convert to cpu_halted
  - Converted new code for cpu_halted and cpu_halted_set.
- hw/semihosting: convert to cpu_halted_set
  -  Added this patch as this code was new and needed converting.
- ppc/translate_init.inc.c
  - Translated some new code here to use cpu_has_work_with_iothread_lock.
- ppc/sapr_hcall.c Translated new code to cpu_halted
- i386/hax-all.c - converted new code to cpu_interrupt_request and cpu_halted
- mips/kvm.c - converted new code to cpu_halted
- Some changes were related to files that moved, cpu.c and cpu.h
  moved to hw/core/, and some changes needed to be put
  there manually during the merge.

Emilio G. Cota (69):
  cpu: convert queued work to a QSIMPLEQ
  cpu: rename cpu->work_mutex to cpu->lock
  cpu: introduce cpu_mutex_lock/unlock
  cpu: make qemu_work_cond per-cpu
  cpu: move run_on_cpu to cpus-common
  cpu: introduce process_queued_cpu_work_locked
  cpu: make per-CPU locks an alias of the BQL in TCG rr mode
  tcg-runtime: define helper_cpu_halted_set
  ppc: convert to helper_cpu_halted_set
  cris: convert to helper_cpu_halted_set
  hppa: convert to helper_cpu_halted_set
  m68k: convert to helper_cpu_halted_set
  alpha: convert to helper_cpu_halted_set
  microblaze: convert to helper_cpu_halted_set
  cpu: define cpu_halted helpers
  tcg-runtime: convert to cpu_halted_set
  arm: convert to cpu_halted
  ppc: convert to cpu_halted
  sh4: convert to cpu_halted
  i386: convert to cpu_halted
  lm32: convert to cpu_halted
  m68k: convert to cpu_halted
  mips: convert to cpu_halted
  riscv: convert to cpu_halted
  s390x: convert to cpu_halted
  sparc: convert to cpu_halted
  xtensa: convert to cpu_halted
  gdbstub: convert to cpu_halted
  openrisc: convert to cpu_halted
  cpu-exec: convert to cpu_halted
  cpu: convert to cpu_halted
  cpu: define cpu_interrupt_request helpers
  exec: use cpu_reset_interrupt
  arm: convert to cpu_interrupt_request
  i386: convert to cpu_interrupt_request
  i386/kvm: convert to cpu_interrupt_request
  i386/hax-all: convert to cpu_interrupt_request
  i386/whpx-all: convert to cpu_interrupt_request
  i386/hvf: convert to cpu_request_interrupt
  ppc: convert to cpu_interrupt_request
  sh4: convert to cpu_interrupt_request
  cris: convert to cpu_interrupt_request
  hppa: convert to cpu_interrupt_request
  lm32: convert to cpu_interrupt_request
  m68k: convert to cpu_interrupt_request
  mips: convert to cpu_interrupt_request
  nios: convert to cpu_interrupt_request
  s390x: convert to cpu_interrupt_request
  alpha: convert to cpu_interrupt_request
  moxie: convert to cpu_interrupt_request
  sparc: convert to cpu_interrupt_request
  openrisc: convert to cpu_interrupt_request
  unicore32: convert to cpu_interrupt_request
  microblaze: convert to cpu_interrupt_request
  accel/tcg: convert to cpu_interrupt_request
  cpu: convert to interrupt_request
  cpu: call .cpu_has_work with the CPU lock held
  cpu: introduce cpu_has_work_with_iothread_lock
  ppc: convert to cpu_has_work_with_iothread_lock
  mips: convert to cpu_has_work_with_iothread_lock
  s390x: convert to cpu_has_work_with_iothread_lock
  riscv: convert to cpu_has_work_with_iothread_lock
  sparc: convert to cpu_has_work_with_iothread_lock
  xtensa: convert to cpu_has_work_with_iothread_lock
  cpu: rename all_cpu_threads_idle to qemu_tcg_rr_all_cpu_threads_idle
  cpu: protect CPU state with cpu->lock instead of the BQL
  cpus-common: release BQL earlier in run_on_cpu
  cpu: add async_run_on_cpu_no_bql
  cputlb: queue async flush jobs without the BQL

Paolo Bonzini (4):
  ppc: use cpu_reset_interrupt
  i386: use cpu_reset_interrupt
  s390x: use cpu_reset_interrupt
  openrisc: use cpu_reset_interrupt

Robert Foley (1):
  hw/semihosting: convert to cpu_halted_set

 accel/tcg/cpu-exec.c            |  40 ++-
 accel/tcg/cputlb.c              |  10 +-
 accel/tcg/tcg-all.c             |  12 +-
 accel/tcg/tcg-runtime.c         |   7 +
 accel/tcg/tcg-runtime.h         |   2 +
 accel/tcg/translate-all.c       |   2 +-
 cpus-common.c                   | 129 +++++++---
 cpus.c                          | 438 ++++++++++++++++++++++++++------
 exec.c                          |   2 +-
 gdbstub.c                       |   4 +-
 hw/arm/omap1.c                  |   4 +-
 hw/arm/pxa2xx_gpio.c            |   2 +-
 hw/arm/pxa2xx_pic.c             |   2 +-
 hw/core/cpu.c                   |  29 +--
 hw/core/machine-qmp-cmds.c      |   2 +-
 hw/intc/s390_flic.c             |   4 +-
 hw/mips/cps.c                   |   2 +-
 hw/misc/mips_itu.c              |   4 +-
 hw/openrisc/cputimer.c          |   2 +-
 hw/ppc/e500.c                   |   4 +-
 hw/ppc/ppc.c                    |  12 +-
 hw/ppc/ppce500_spin.c           |   6 +-
 hw/ppc/spapr_cpu_core.c         |   4 +-
 hw/ppc/spapr_hcall.c            |  14 +-
 hw/ppc/spapr_rtas.c             |   8 +-
 hw/semihosting/console.c        |   4 +-
 hw/sparc/leon3.c                |   2 +-
 hw/sparc/sun4m.c                |   8 +-
 hw/sparc64/sparc64.c            |   8 +-
 include/hw/core/cpu.h           | 197 ++++++++++++--
 stubs/Makefile.objs             |   1 +
 stubs/cpu-lock.c                |  35 +++
 target/alpha/cpu.c              |   8 +-
 target/alpha/translate.c        |   6 +-
 target/arm/arm-powerctl.c       |   6 +-
 target/arm/cpu.c                |   8 +-
 target/arm/helper.c             |  16 +-
 target/arm/machine.c            |   2 +-
 target/arm/op_helper.c          |   2 +-
 target/cris/cpu.c               |   2 +-
 target/cris/helper.c            |   4 +-
 target/cris/translate.c         |   5 +-
 target/hppa/cpu.c               |   2 +-
 target/hppa/translate.c         |   3 +-
 target/i386/cpu.c               |   4 +-
 target/i386/cpu.h               |   2 +-
 target/i386/hax-all.c           |  42 +--
 target/i386/helper.c            |   8 +-
 target/i386/hvf/hvf.c           |  12 +-
 target/i386/hvf/x86hvf.c        |  37 +--
 target/i386/kvm.c               |  82 +++---
 target/i386/misc_helper.c       |   2 +-
 target/i386/seg_helper.c        |  13 +-
 target/i386/svm_helper.c        |   6 +-
 target/i386/whpx-all.c          |  57 +++--
 target/lm32/cpu.c               |   2 +-
 target/lm32/op_helper.c         |   4 +-
 target/m68k/cpu.c               |   2 +-
 target/m68k/op_helper.c         |   2 +-
 target/m68k/translate.c         |   9 +-
 target/microblaze/cpu.c         |   2 +-
 target/microblaze/translate.c   |   4 +-
 target/mips/cp0_helper.c        |   6 +-
 target/mips/cpu.c               |  11 +-
 target/mips/kvm.c               |   4 +-
 target/mips/op_helper.c         |   2 +-
 target/mips/translate.c         |   4 +-
 target/moxie/cpu.c              |   2 +-
 target/nios2/cpu.c              |   2 +-
 target/openrisc/cpu.c           |   4 +-
 target/openrisc/sys_helper.c    |   4 +-
 target/ppc/excp_helper.c        |   6 +-
 target/ppc/helper_regs.h        |   2 +-
 target/ppc/kvm.c                |   6 +-
 target/ppc/translate.c          |   6 +-
 target/ppc/translate_init.inc.c |  41 +--
 target/riscv/cpu.c              |   5 +-
 target/riscv/op_helper.c        |   2 +-
 target/s390x/cpu.c              |  28 +-
 target/s390x/excp_helper.c      |   4 +-
 target/s390x/kvm.c              |   2 +-
 target/s390x/sigp.c             |   8 +-
 target/sh4/cpu.c                |   2 +-
 target/sh4/helper.c             |   2 +-
 target/sh4/op_helper.c          |   2 +-
 target/sparc/cpu.c              |   6 +-
 target/sparc/helper.c           |   2 +-
 target/unicore32/cpu.c          |   2 +-
 target/unicore32/softmmu.c      |   2 +-
 target/xtensa/cpu.c             |   6 +-
 target/xtensa/exc_helper.c      |   2 +-
 target/xtensa/helper.c          |   2 +-
 92 files changed, 1067 insertions(+), 464 deletions(-)
 create mode 100644 stubs/cpu-lock.c

-- 
2.17.1


