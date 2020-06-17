Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B64C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2637221532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltDDEG1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2637221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfF6-00044F-CC
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDF-0002Vr-F4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:13 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35]:33121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDC-0008Nk-Li
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:13 -0400
Received: by mail-qv1-xf35.google.com with SMTP id d12so1774114qvn.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YFmOmhESBV4FDVhmsjSbq0ZQ32jAVP0YjYd7DxM6aIs=;
 b=ltDDEG1AdgPZo2DI5ZBScl6CWToccbVklGOPSOn2jmS6Jh3noqd/imRp6k0KjB2v2t
 s9B8Xv8JJGwvWYl81qyJ3tasn4oVd3QFHAq5I5Itt4egTJOPdOFZXRvRYaUzy9+shyW2
 PyG1pzpZrDswsE4y2Vq27N9zAc4ahjcs20gMnBF4HM63r/30LsDOgf8nqnBtoAF9A86H
 2puyjovRfc0oN1NTpIADTQAFssH+41r/O/SHwLyMf+vVJ1fezjmzGCLYsPvyO0BQPJug
 v+ip7XA6SzGF+e197SCqEDSSCFb3nKuFQ7Cf4osLh+Mr6YC1H5VroCF53iR78gHzdW6o
 H/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YFmOmhESBV4FDVhmsjSbq0ZQ32jAVP0YjYd7DxM6aIs=;
 b=elB8toY8WNieC+7VafJCnCA/qC55K3yEjk7DS+J2ebTdhy2pVMblqJlicrhvf3Fjy7
 igOBzdERF2lFjO9lpgr0GOdUHq97zP9YeEYZyKMBaE6THot1lgoJLz66d0TmDUybGBQT
 hUz8+ieXr6f9uMsgBIc54puAt02UWMyGM3Z+N9K5SyjxLUZclmgOPsXUtU6MPxZhf1w+
 eJc6DufzQ1nnekL7DLw5TK8mDe+m3oG8kDpj07fP0xqg83Zo6t6w/DwEaufxuJwIcGAv
 V7Qan/k33elVpXCD6qV40T96f5q7FPHskyR1Plfib0kDjzE/tkCL7xIrrbSU7t7uPdhu
 FWDw==
X-Gm-Message-State: AOAM533e2Ngd4QGE2n4fbth+k1SG/D4CdjhL3UlYW8cPeoMmv53VjuVa
 C8avNODv3WI1eHO1wVEs+VLbNqs1TIyHfg==
X-Google-Smtp-Source: ABdhPJyh987LTkiYhaW3GHeUZt+bHFMbeVPOsbKvnAc0+PLoHyBaV8trCjHFXUpcihFBGqzAGtdDcQ==
X-Received: by 2002:ad4:590d:: with SMTP id ez13mr553218qvb.177.1592427788695; 
 Wed, 17 Jun 2020 14:03:08 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:08 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 00/73] per-CPU locks
Date: Wed, 17 Jun 2020 17:01:18 -0400
Message-Id: <20200617210231.4393-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf35.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes for v10:
- Fixed one case in cpu_throttle_thread, where we were using 
  qemu_global_mutex instead of cpu->lock for the halt_cond.
- Changed qemu_cpu_kick() to ensure we are under the CPU
  lock so we do not miss a notification.
- Added a few more reviewed-bys.

v9: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06289.html

Quoting an earlier patch in the series:
"For context, the goal of this series is to substitute the BQL for the
per-CPU locks in many places, notably the execution loop in cpus.c.
This leads to better scalability for MTTCG, since CPUs don't have
to acquire a contended global lock (the BQL) every time they
stop executing code.
See the last commit for some performance numbers."

Emilio G. Cota (68):
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
 cpus-common.c                   | 108 ++++++--
 cpus.c                          | 456 ++++++++++++++++++++++++++------
 exec.c                          |   2 +-
 gdbstub.c                       |   4 +-
 hw/arm/omap1.c                  |   4 +-
 hw/arm/pxa2xx_gpio.c            |   2 +-
 hw/arm/pxa2xx_pic.c             |   2 +-
 hw/core/cpu.c                   |  28 +-
 hw/core/machine-qmp-cmds.c      |   2 +-
 hw/core/machine.c               |   1 +
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
 include/hw/core/cpu.h           | 196 ++++++++++++--
 stubs/Makefile.objs             |   1 +
 stubs/cpu-lock.c                |  27 ++
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
 target/i386/whpx-all.c          |  57 ++--
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
 93 files changed, 1063 insertions(+), 456 deletions(-)
 create mode 100644 stubs/cpu-lock.c

-- 
2.17.1


