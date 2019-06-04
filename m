Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A3C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847C520848
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pk2FxKhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847C520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGCo-0004j4-OI
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:38:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG87-0000uh-6u
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG85-0003xe-FF
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:33:59 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG85-0003wi-73
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:33:57 -0400
Received: by mail-oi1-x244.google.com with SMTP id w7so5243436oic.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=/GGE9uzaJZM7BXK+ZvdxD9k00XdIm1UShmScAk8afLo=;
	b=pk2FxKhl7u9AOg0BD+9E+TNKfNMfqlDDl/k1ZL4Zx292Q8r63+NuNVdmvr1WstlT90
	NVvSN0GZ7cdop9vLjlmQtRWB7wRNce0YpyrnTGOXqR/GksJlYlSegl88tkw/kEzcwYM2
	HkNeWy6Su5xlJmH51Aj4yAqvbWNN3BqlgJxRGzaRzaS32DmUCnw4l3zm5n6+MCODtXx7
	Lxf+3szBr1inK3JsrO15/eijbnU81yUVQUkXW5jURbVkL1fX0cWZXeeg6b5ouWhCpgs6
	kVsJkrxAKcjRW/MofmgBo2+6i0BI6yR3KvXr0EYDcTCCjnZ9rdPNRHhUSQoTKoUBv9AB
	/Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=/GGE9uzaJZM7BXK+ZvdxD9k00XdIm1UShmScAk8afLo=;
	b=TpFNyx/MoGcVuP18qYMJ+F95FhZoeR27ZfBS5ilRxsoRtJXxEtIvtL37A7iQL8IWAj
	Pb9mvCBlMEBEDDGTt12BPoAdtSB9z3sqC3Vfcjv/F9ztF+RGg752U47EQN9HPPrbQ1cJ
	qfRq5EQtgR9yXf4HR68FyY5PNnQrg0K2ecw/qdgl5soasuFMyIcmxLcDAxLTJbkGZ8TC
	NU8qDKurHdb1s2CMeC2CJv6r2s1+PC+C9uRhWuf9b7O04u4U6mbncg7loYioMMJlo6x6
	/YmxUaXOaYbLkRQlKfwZwevPbS9ekB9lnZ68cy1Li4dCz4ehIkwKoL81xVSU3GmjBNjZ
	DPfw==
X-Gm-Message-State: APjAAAXBHP/cBxq1ssS47ncUpJKJ5opmwm1b0hl0Nee2Tt5TvY25PfIR
	ev7UTbVM84qMwBCtjBKrboN6QLMXr3Jx6A==
X-Google-Smtp-Source: APXvYqwdPGtEOiduPwJxsFbqDXCgtird7eK7YkSvARvyf7QWxIcc+PwEWbK+HYpAiVBOuAUmZbLORA==
X-Received: by 2002:aca:38d4:: with SMTP id f203mr5736880oia.88.1559680435099; 
	Tue, 04 Jun 2019 13:33:55 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.33.52
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:33:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:12 -0500
Message-Id: <20190604203351.27778-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH v4 00/39] tcg: Move the softmmu tlb to
 CPUNegativeOffsetState
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

Patches missing review/ack:
0038-tcg-arm-Use-LDRD-to-load-tlb-mask-table.patch

Changes from v3->v4:
  * Rebase to master, fixing a few conflicts.
  * Reword and replicate commit messages.

Changes from v2->v3:
  * Incorporate review from pm215:
    include guards and copyright/license for new headers;
    qemu_build_bug_on for tcg/{arm,aarch64}/ load-pair expectations;
    split out an independant tlb change in tcg/arm/;
    split out some re-indent patches for target/cris/.

Changes from v1->v2:
  * Add cpu_set_cpustate_pointers.
  * Add icount_decr_ptr to CPUState.

Blurb from v1:

This started merely as an attempt to reduce the size of each
softmmu lookup by using smaller offsets from env.  But in the
end it also represents a significant cleanup in the boilerplate
that each target must define.

With respect to the initial goal, here are the relevant code
snips generated for loading the mask & table fields for a
qemu_ld from an aarch64 guest on the indicated host.


r~


Richard Henderson (39):
  tcg: Fold CPUTLBWindow into CPUTLBDesc
  tcg: Split out target/arch/cpu-param.h
  tcg: Create struct CPUTLB
  cpu: Define CPUArchState with typedef
  cpu: Define ArchCPU
  cpu: Replace ENV_GET_CPU with env_cpu
  cpu: Introduce env_archcpu
  target/alpha: Use env_cpu, env_archcpu
  target/arm: Use env_cpu, env_archcpu
  target/cris: Reindent mmu.c
  target/cris: Reindent op_helper.c
  target/cris: Use env_cpu, env_archcpu
  target/hppa: Use env_cpu, env_archcpu
  target/i386: Use env_cpu, env_archcpu
  target/lm32: Use env_cpu, env_archcpu
  target/m68k: Use env_cpu, env_archcpu
  target/microblaze: Use env_cpu, env_archcpu
  target/mips: Use env_cpu, env_archcpu
  target/moxie: Use env_cpu, env_archcpu
  target/nios2: Use env_cpu, env_archcpu
  target/openrisc: Use env_cpu, env_archcpu
  target/ppc: Use env_cpu, env_archcpu
  target/riscv: Use env_cpu, env_archcpu
  target/s390x: Use env_cpu, env_archcpu
  target/sh4: Use env_cpu, env_archcpu
  target/sparc: Use env_cpu, env_archcpu
  target/tilegx: Use env_cpu
  target/tricore: Use env_cpu
  target/unicore32: Use env_cpu, env_archcpu
  target/xtensa: Use env_cpu, env_archcpu
  cpu: Move ENV_OFFSET to exec/gen-icount.h
  cpu: Introduce cpu_set_cpustate_pointers
  cpu: Introduce CPUNegativeOffsetState
  cpu: Move icount_decr to CPUNegativeOffsetState
  cpu: Move the softmmu tlb to CPUNegativeOffsetState
  cpu: Remove CPU_COMMON
  tcg/aarch64: Use LDP to load tlb mask+table
  tcg/arm: Use LDRD to load tlb mask+table
  tcg/arm: Remove mostly unreachable tlb special case

 accel/tcg/atomic_template.h               |   8 +-
 include/exec/cpu-all.h                    |  58 ++
 include/exec/cpu-defs.h                   | 113 ++-
 include/exec/cpu_ldst.h                   |   6 +-
 include/exec/cpu_ldst_template.h          |   6 +-
 include/exec/cpu_ldst_useronly_template.h |   6 +-
 include/exec/gen-icount.h                 |  14 +-
 include/exec/softmmu-semi.h               |  16 +-
 include/qom/cpu.h                         |  40 +-
 linux-user/cpu_loop-common.h              |   2 +-
 linux-user/m68k/target_cpu.h              |   2 +-
 target/alpha/cpu-param.h                  |  31 +
 target/alpha/cpu.h                        |  40 +-
 target/arm/cpu-param.h                    |  34 +
 target/arm/cpu.h                          |  52 +-
 target/cris/cpu-param.h                   |  17 +
 target/cris/cpu.h                         |  25 +-
 target/hppa/cpu-param.h                   |  34 +
 target/hppa/cpu.h                         |  38 +-
 target/i386/cpu-param.h                   |  28 +
 target/i386/cpu.h                         |  40 +-
 target/lm32/cpu-param.h                   |  17 +
 target/lm32/cpu.h                         |  25 +-
 target/m68k/cpu-param.h                   |  22 +
 target/m68k/cpu.h                         |  28 +-
 target/microblaze/cpu-param.h             |  18 +
 target/microblaze/cpu.h                   |  63 +-
 target/mips/cpu-param.h                   |  29 +
 target/mips/cpu.h                         |  21 +-
 target/mips/mips-defs.h                   |  15 -
 target/moxie/cpu-param.h                  |  17 +
 target/moxie/cpu.h                        |  29 +-
 target/nios2/cpu-param.h                  |  21 +
 target/nios2/cpu.h                        |  33 +-
 target/openrisc/cpu-param.h               |  17 +
 target/openrisc/cpu.h                     |  31 +-
 target/ppc/cpu-param.h                    |  37 +
 target/ppc/cpu.h                          |  61 +-
 target/ppc/helper_regs.h                  |   4 +-
 target/riscv/cpu-param.h                  |  23 +
 target/riscv/cpu.h                        |  34 +-
 target/s390x/cpu-param.h                  |  17 +
 target/s390x/cpu.h                        |  31 +-
 target/sh4/cpu-param.h                    |  21 +
 target/sh4/cpu.h                          |  30 +-
 target/sparc/cpu-param.h                  |  28 +
 target/sparc/cpu.h                        |  36 +-
 target/tilegx/cpu-param.h                 |  17 +
 target/tilegx/cpu.h                       |  23 +-
 target/tricore/cpu-param.h                |  17 +
 target/tricore/cpu.h                      |  22 +-
 target/tricore/tricore-defs.h             |   5 -
 target/unicore32/cpu-param.h              |  17 +
 target/unicore32/cpu.h                    |  24 +-
 target/xtensa/cpu-param.h                 |  21 +
 target/xtensa/cpu.h                       |  40 +-
 accel/tcg/cpu-exec.c                      |  23 +-
 accel/tcg/cputlb.c                        | 226 +++---
 accel/tcg/tcg-all.c                       |   6 +-
 accel/tcg/tcg-runtime.c                   |   4 +-
 accel/tcg/translate-all.c                 |  10 +-
 accel/tcg/user-exec.c                     |   2 +-
 bsd-user/main.c                           |   5 +-
 bsd-user/syscall.c                        |   6 +-
 cpus.c                                    |   9 +-
 hw/i386/kvmvapic.c                        |   4 +-
 hw/i386/pc.c                              |   2 +-
 hw/intc/mips_gic.c                        |   2 +-
 hw/mips/mips_int.c                        |   2 +-
 hw/nios2/cpu_pic.c                        |   5 +-
 hw/ppc/ppc.c                              |  18 +-
 hw/ppc/ppc405_uc.c                        |   2 +-
 hw/ppc/ppc_booke.c                        |   4 +-
 hw/semihosting/console.c                  |   2 +-
 hw/sparc/leon3.c                          |   4 +-
 hw/sparc/sun4m.c                          |   4 +-
 hw/sparc64/sparc64.c                      |   2 +-
 hw/unicore32/puv3.c                       |   2 +-
 hw/xtensa/pic_cpu.c                       |   2 +-
 linux-user/aarch64/cpu_loop.c             |   6 +-
 linux-user/aarch64/signal.c               |   4 +-
 linux-user/alpha/cpu_loop.c               |   2 +-
 linux-user/arm/cpu_loop.c                 |   4 +-
 linux-user/cris/cpu_loop.c                |   4 +-
 linux-user/elfload.c                      |   6 +-
 linux-user/hppa/cpu_loop.c                |   2 +-
 linux-user/i386/cpu_loop.c                |   2 +-
 linux-user/i386/signal.c                  |   2 +-
 linux-user/m68k-sim.c                     |   3 +-
 linux-user/m68k/cpu_loop.c                |   4 +-
 linux-user/main.c                         |   2 +-
 linux-user/microblaze/cpu_loop.c          |   2 +-
 linux-user/mips/cpu_loop.c                |   4 +-
 linux-user/nios2/cpu_loop.c               |   2 +-
 linux-user/openrisc/cpu_loop.c            |   2 +-
 linux-user/ppc/cpu_loop.c                 |   2 +-
 linux-user/riscv/cpu_loop.c               |   4 +-
 linux-user/s390x/cpu_loop.c               |   2 +-
 linux-user/sh4/cpu_loop.c                 |   2 +-
 linux-user/signal.c                       |   8 +-
 linux-user/sparc/cpu_loop.c               |   2 +-
 linux-user/syscall.c                      |  26 +-
 linux-user/tilegx/cpu_loop.c              |   2 +-
 linux-user/uname.c                        |   2 +-
 linux-user/vm86.c                         |  18 +-
 linux-user/xtensa/cpu_loop.c              |   2 +-
 qom/cpu.c                                 |   4 +-
 target/alpha/cpu.c                        |   3 +-
 target/alpha/helper.c                     |   8 +-
 target/alpha/sys_helper.c                 |   8 +-
 target/arm/arm-semi.c                     |   4 +-
 target/arm/cpu.c                          |   3 +-
 target/arm/cpu64.c                        |   2 +-
 target/arm/helper-a64.c                   |   4 +-
 target/arm/helper.c                       | 162 ++---
 target/arm/op_helper.c                    |  21 +-
 target/arm/translate-a64.c                |   4 +-
 target/arm/translate.c                    |   2 +-
 target/arm/vfp_helper.c                   |   2 +-
 target/cris/cpu.c                         |   3 +-
 target/cris/mmu.c                         | 482 +++++++------
 target/cris/op_helper.c                   | 827 +++++++++++-----------
 target/cris/translate.c                   |   2 +-
 target/hppa/cpu.c                         |   2 +-
 target/hppa/helper.c                      |   3 +-
 target/hppa/int_helper.c                  |   4 +-
 target/hppa/mem_helper.c                  |  10 +-
 target/hppa/op_helper.c                   |  10 +-
 target/i386/bpt_helper.c                  |   4 +-
 target/i386/cpu.c                         |   7 +-
 target/i386/excp_helper.c                 |   2 +-
 target/i386/fpu_helper.c                  |   2 +-
 target/i386/hax-all.c                     |   6 +-
 target/i386/helper.c                      |  16 +-
 target/i386/hvf/x86_decode.c              |  22 +-
 target/i386/hvf/x86_emu.c                 |  60 +-
 target/i386/mem_helper.c                  |   4 +-
 target/i386/misc_helper.c                 |  24 +-
 target/i386/seg_helper.c                  |  14 +-
 target/i386/smm_helper.c                  |   4 +-
 target/i386/svm_helper.c                  |  22 +-
 target/lm32/cpu.c                         |   3 +-
 target/lm32/helper.c                      |  19 +-
 target/lm32/op_helper.c                   |   6 +-
 target/lm32/translate.c                   |   2 +-
 target/m68k/cpu.c                         |   4 +-
 target/m68k/helper.c                      |  33 +-
 target/m68k/m68k-semi.c                   |   4 +-
 target/m68k/op_helper.c                   |  14 +-
 target/m68k/translate.c                   |   4 +-
 target/microblaze/cpu.c                   |   3 +-
 target/microblaze/mmu.c                   |   5 +-
 target/microblaze/op_helper.c             |   2 +-
 target/microblaze/translate.c             |   2 +-
 target/mips/cpu.c                         |   3 +-
 target/mips/helper.c                      |  15 +-
 target/mips/op_helper.c                   |  25 +-
 target/mips/translate.c                   |   3 +-
 target/mips/translate_init.inc.c          |   4 +-
 target/moxie/cpu.c                        |   3 +-
 target/moxie/helper.c                     |   4 +-
 target/moxie/translate.c                  |   2 +-
 target/nios2/cpu.c                        |   6 +-
 target/nios2/mmu.c                        |  14 +-
 target/nios2/op_helper.c                  |   2 +-
 target/openrisc/cpu.c                     |   3 +-
 target/openrisc/exception_helper.c        |   5 +-
 target/openrisc/sys_helper.c              |   8 +-
 target/ppc/excp_helper.c                  |  14 +-
 target/ppc/fpu_helper.c                   |  14 +-
 target/ppc/kvm.c                          |   5 +-
 target/ppc/misc_helper.c                  |  22 +-
 target/ppc/mmu-hash64.c                   |  14 +-
 target/ppc/mmu_helper.c                   | 117 ++-
 target/ppc/translate_init.inc.c           |  88 ++-
 target/riscv/cpu.c                        |   3 +-
 target/riscv/cpu_helper.c                 |  10 +-
 target/riscv/csr.c                        |  12 +-
 target/riscv/op_helper.c                  |   7 +-
 target/s390x/cc_helper.c                  |   5 +-
 target/s390x/cpu.c                        |   9 +-
 target/s390x/diag.c                       |   2 +-
 target/s390x/excp_helper.c                |   6 +-
 target/s390x/fpu_helper.c                 |   4 +-
 target/s390x/gdbstub.c                    |  24 +-
 target/s390x/helper.c                     |   7 +-
 target/s390x/int_helper.c                 |   3 +-
 target/s390x/interrupt.c                  |   6 +-
 target/s390x/mem_helper.c                 |  30 +-
 target/s390x/misc_helper.c                |  50 +-
 target/s390x/mmu_helper.c                 |   8 +-
 target/s390x/sigp.c                       |   4 +-
 target/sh4/cpu.c                          |   3 +-
 target/sh4/helper.c                       |  26 +-
 target/sh4/op_helper.c                    |  11 +-
 target/sparc/cpu.c                        |   3 +-
 target/sparc/fop_helper.c                 |   2 +-
 target/sparc/helper.c                     |   8 +-
 target/sparc/ldst_helper.c                |  33 +-
 target/sparc/mmu_helper.c                 |  10 +-
 target/tilegx/cpu.c                       |   4 +-
 target/tilegx/helper.c                    |   2 +-
 target/tricore/cpu.c                      |   4 +-
 target/tricore/op_helper.c                |   2 +-
 target/unicore32/cpu.c                    |   3 +-
 target/unicore32/helper.c                 |   4 +-
 target/unicore32/op_helper.c              |   2 +-
 target/unicore32/softmmu.c                |  11 +-
 target/unicore32/translate.c              |  26 +-
 target/unicore32/ucf64_helper.c           |   2 +-
 target/xtensa/cpu.c                       |   3 +-
 target/xtensa/dbg_helper.c                |   4 +-
 target/xtensa/exc_helper.c                |   9 +-
 target/xtensa/helper.c                    |   2 +-
 target/xtensa/mmu_helper.c                |  17 +-
 target/xtensa/xtensa-semi.c               |   2 +-
 tcg/aarch64/tcg-target.inc.c              |  40 +-
 tcg/arm/tcg-target.inc.c                  | 149 ++--
 tcg/i386/tcg-target.inc.c                 |   6 +-
 tcg/mips/tcg-target.inc.c                 |  45 +-
 tcg/ppc/tcg-target.inc.c                  |  32 +-
 tcg/riscv/tcg-target.inc.c                |  37 +-
 tcg/s390/tcg-target.inc.c                 |  13 +-
 tcg/sparc/tcg-target.inc.c                |  40 +-
 docs/devel/tracing.txt                    |   4 +-
 scripts/tracetool/format/tcg_helper_c.py  |   2 +-
 226 files changed, 2379 insertions(+), 2572 deletions(-)
 create mode 100644 target/alpha/cpu-param.h
 create mode 100644 target/arm/cpu-param.h
 create mode 100644 target/cris/cpu-param.h
 create mode 100644 target/hppa/cpu-param.h
 create mode 100644 target/i386/cpu-param.h
 create mode 100644 target/lm32/cpu-param.h
 create mode 100644 target/m68k/cpu-param.h
 create mode 100644 target/microblaze/cpu-param.h
 create mode 100644 target/mips/cpu-param.h
 create mode 100644 target/moxie/cpu-param.h
 create mode 100644 target/nios2/cpu-param.h
 create mode 100644 target/openrisc/cpu-param.h
 create mode 100644 target/ppc/cpu-param.h
 create mode 100644 target/riscv/cpu-param.h
 create mode 100644 target/s390x/cpu-param.h
 create mode 100644 target/sh4/cpu-param.h
 create mode 100644 target/sparc/cpu-param.h
 create mode 100644 target/tilegx/cpu-param.h
 create mode 100644 target/tricore/cpu-param.h
 create mode 100644 target/unicore32/cpu-param.h
 create mode 100644 target/xtensa/cpu-param.h

-- 
2.17.1


